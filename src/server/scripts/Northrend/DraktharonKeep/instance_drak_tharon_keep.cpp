/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "drak_tharon_keep.h"

DoorData const doorData[] =
{
    { GO_NOVOS_CRYSTAL_1,   DATA_NOVOS_CRYSTALS,    DOOR_TYPE_ROOM,     BOUNDARY_NONE },
    { GO_NOVOS_CRYSTAL_2,   DATA_NOVOS_CRYSTALS,    DOOR_TYPE_ROOM,     BOUNDARY_NONE },
    { GO_NOVOS_CRYSTAL_3,   DATA_NOVOS_CRYSTALS,    DOOR_TYPE_ROOM,     BOUNDARY_NONE },
    { GO_NOVOS_CRYSTAL_4,   DATA_NOVOS_CRYSTALS,    DOOR_TYPE_ROOM,     BOUNDARY_NONE },
    { 0,                    0,                      DOOR_TYPE_ROOM,     BOUNDARY_NONE }
};

class instance_drak_tharon_keep : public InstanceMapScript
{
    public:
        instance_drak_tharon_keep() : InstanceMapScript("instance_drak_tharon_keep", 600) { }

        struct instance_drak_tharon_keep_InstanceScript : public InstanceScript
        {
            instance_drak_tharon_keep_InstanceScript(Map* map) : InstanceScript(map)
            {
                SetBossNumber(MAX_ENCOUNTERS);
                LoadDoorData(doorData);
            }
            
            void OnGameObjectCreate(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_NOVOS_CRYSTAL_1:
                    case GO_NOVOS_CRYSTAL_2:
                    case GO_NOVOS_CRYSTAL_3:
                    case GO_NOVOS_CRYSTAL_4:
                        AddDoor(go, true);
                        break;
                }
            }
            
            void OnGameObjectRemove(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_NOVOS_CRYSTAL_1:
                    case GO_NOVOS_CRYSTAL_2:
                    case GO_NOVOS_CRYSTAL_3:
                    case GO_NOVOS_CRYSTAL_4:
                        AddDoor(go, false);
                        break;
                }
            }

            std::string GetSaveData()
            {
                std::ostringstream saveStream;
                saveStream << "D K " << GetBossSaveData();
                return saveStream.str();
            }

            void Load(const char* in)
            {
                if( !in )
                    return;

                char dataHead1, dataHead2;
                std::istringstream loadStream(in);
                loadStream >> dataHead1 >> dataHead2;
                if (dataHead1 == 'D' && dataHead2 == 'K')
                {
                    for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                    {
                        uint32 tmpState;
                        loadStream >> tmpState;
                        if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                            tmpState = NOT_STARTED;
                        SetBossState(i, EncounterState(tmpState));
                    }
                }
            }
        };

        InstanceScript* GetInstanceScript(InstanceMap *map) const
        {
            return new instance_drak_tharon_keep_InstanceScript(map);
        }
};

class spell_dtk_raise_dead : public SpellScriptLoader
{
    public:
        spell_dtk_raise_dead() : SpellScriptLoader("spell_dtk_raise_dead") { }

        class spell_dtk_raise_dead_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dtk_raise_dead_AuraScript)

            bool Load()
            {
                return GetUnitOwner()->GetTypeId() == TYPEID_UNIT;
            }

            void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetUnitOwner()->ToCreature()->DespawnOrUnsummon(1);
                GetUnitOwner()->SummonCreature(NPC_RISEN_DRAKKARI_WARRIOR, *GetUnitOwner());
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_dtk_raise_dead_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dtk_raise_dead_AuraScript();
        }
};

class spell_dtk_summon_random_drakkari : public SpellScriptLoader
{
    public:
        spell_dtk_summon_random_drakkari() : SpellScriptLoader("spell_dtk_summon_random_drakkari") { }

        class spell_dtk_summon_random_drakkari_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dtk_summon_random_drakkari_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                GetCaster()->CastSpell(GetCaster(), RAND(SPELL_SUMMON_DRAKKARI_SHAMAN, SPELL_SUMMON_DRAKKARI_GUARDIAN), true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dtk_summon_random_drakkari_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dtk_summon_random_drakkari_SpellScript();
        }
};

void AddSC_instance_drak_tharon_keep()
{
    new instance_drak_tharon_keep();
    new spell_dtk_raise_dead();
    new spell_dtk_summon_random_drakkari();
}
