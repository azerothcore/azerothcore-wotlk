/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "SpellScript.h"
#include "CreatureAI.h"
#include "uldaman.h"

enum Spells
{
    SPELL_ARCHAEDAS_AWAKEN      = 10347,
    SPELL_AWAKEN_VAULT_WALKER   = 10258,
};

enum Events
{
    EVENT_SUB_BOSS_AGGRO        = 2228
};

class instance_uldaman : public InstanceMapScript
{
    public:
        instance_uldaman() : InstanceMapScript("instance_uldaman", 70) { }

        struct instance_uldaman_InstanceMapScript : public InstanceScript
        {
            instance_uldaman_InstanceMapScript(Map* map) : InstanceScript(map) { }

            void Initialize()
            {
                memset(&_encounters, 0, sizeof(_encounters));
                archaedasTempleDoorGUID = 0;
                ancientVaultDoorGUID = 0;
            }

            void OnGameObjectCreate(GameObject* gameobject)
            {
                switch (gameobject->GetEntry())
                {
                    case GO_IRONAYA_SEAL_DOOR:
                    case GO_KEYSTONE:
                        if (_encounters[DATA_IRONAYA_DOORS] == DONE)
                        {
                            HandleGameObject(0, true, gameobject);
                            gameobject->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        }
                        break;
                    case GO_TEMPLE_DOOR:
                        if (_encounters[DATA_STONE_KEEPERS] == DONE)
                           HandleGameObject(0, true, gameobject);
                        break;
                    case GO_ANCIENT_VAULT_DOOR:
                        ancientVaultDoorGUID = gameobject->GetGUID();
                        if (_encounters[DATA_ARCHAEDAS] == DONE)
                           HandleGameObject(0, true, gameobject);
                        break;
                    case GO_ARCHAEDAS_TEMPLE_DOOR:
                        archaedasTempleDoorGUID = gameobject->GetGUID();
                        break;
                }
            }

            void SetData(uint32 type, uint32 data)
            {
                switch (type)
                {
                    case DATA_IRONAYA_DOORS:
                    case DATA_STONE_KEEPERS:
                        _encounters[type] = data;
                        break;
                    case DATA_ARCHAEDAS:
                        _encounters[type] = data;
                        HandleGameObject(ancientVaultDoorGUID, data == DONE, NULL);
                        HandleGameObject(archaedasTempleDoorGUID, data != IN_PROGRESS, NULL);
                        break;
                }

                if (data == DONE)
                    SaveToDB();
            }

            std::string GetSaveData()
            {
                std::ostringstream saveStream;
                saveStream << "U D " << _encounters[DATA_IRONAYA_DOORS] << ' ' << _encounters[DATA_STONE_KEEPERS] << ' ' << _encounters[DATA_ARCHAEDAS];
                return saveStream.str();
            }

            void Load(const char* in)
            {
                if (!in)
                    return;

                char dataHead1, dataHead2;
                std::istringstream loadStream(in);
                loadStream >> dataHead1 >> dataHead2;

                if (dataHead1 == 'U' && dataHead2 == 'D')
                {
                    for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                    {
                        loadStream >> _encounters[i];
                        if (_encounters[i] == IN_PROGRESS)
                            _encounters[i] = NOT_STARTED;
                    }
                }
            }

            void OnCreatureCreate(Creature* creature)
            {
                switch (creature->GetEntry())
                {
                    case NPC_STONE_KEEPER:
                        if (_encounters[DATA_STONE_KEEPERS] != DONE && !creature->IsAlive())
                            creature->Respawn();
                        break;
                }
            }

        private:
            uint32 _encounters[MAX_ENCOUNTERS];
            uint64 archaedasTempleDoorGUID;
            uint64 ancientVaultDoorGUID;
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_uldaman_InstanceMapScript(map);
        }
};

class spell_uldaman_sub_boss_agro_keepers : public SpellScriptLoader
{
    public:
        spell_uldaman_sub_boss_agro_keepers() : SpellScriptLoader("spell_uldaman_sub_boss_agro_keepers") { }

        class spell_uldaman_sub_boss_agro_keepers_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_uldaman_sub_boss_agro_keepers_SpellScript);

            void HandleSendEvent(SpellEffIndex  /*effIndex*/)
            {
                if (Creature* keeper = GetCaster()->FindNearestCreature(NPC_STONE_KEEPER, 100.0f, true))
                    keeper->AI()->SetData(1, 1);
            }

            void Register()
            {
                OnEffectLaunch += SpellEffectFn(spell_uldaman_sub_boss_agro_keepers_SpellScript::HandleSendEvent, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_uldaman_sub_boss_agro_keepers_SpellScript();
        }
};

class spell_uldaman_stoned : public SpellScriptLoader
{
    public:
        spell_uldaman_stoned() : SpellScriptLoader("spell_uldaman_stoned") { }

        class spell_uldaman_stoned_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_uldaman_stoned_AuraScript);

            bool Load()
            {
                return GetUnitOwner()->GetTypeId() == TYPEID_UNIT;
            }

            void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Creature* target = GetUnitOwner()->ToCreature();
                target->SetReactState(REACT_PASSIVE);
                target->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
            }

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Creature* target = GetUnitOwner()->ToCreature();
                target->SetReactState(REACT_AGGRESSIVE);
                target->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_uldaman_stoned_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_uldaman_stoned_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_uldaman_stoned_AuraScript();
        }
};

class spell_uldaman_boss_agro_archaedas : public SpellScriptLoader
{
    public:
        spell_uldaman_boss_agro_archaedas() : SpellScriptLoader("spell_uldaman_boss_agro_archaedas") { }

        class spell_uldaman_boss_agro_archaedas_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_uldaman_boss_agro_archaedas_SpellScript);

            void HandleSendEvent(SpellEffIndex  /*effIndex*/)
            {
                InstanceScript* instance = GetCaster()->GetInstanceScript();
                if (!instance || instance->GetData(DATA_ARCHAEDAS) == IN_PROGRESS)
                    return;

                instance->SetData(DATA_ARCHAEDAS, IN_PROGRESS);
                if (Creature* archaedas = GetCaster()->FindNearestCreature(NPC_ARCHAEDAS, 100.0f, true))
                    archaedas->AI()->SetData(1, 1);
            }

            void Register()
            {
                OnEffectLaunch += SpellEffectFn(spell_uldaman_boss_agro_archaedas_SpellScript::HandleSendEvent, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_uldaman_boss_agro_archaedas_SpellScript();
        }
};

void AddSC_instance_uldaman()
{
    new instance_uldaman();
    new spell_uldaman_sub_boss_agro_keepers();
    new spell_uldaman_stoned();
    new spell_uldaman_boss_agro_archaedas();
}
