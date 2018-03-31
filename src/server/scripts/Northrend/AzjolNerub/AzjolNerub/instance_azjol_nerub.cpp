/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "azjol_nerub.h"

DoorData const doorData[] =
{
    { GO_KRIKTHIR_DOORS,    DATA_KRIKTHIR_THE_GATEWATCHER_EVENT,    DOOR_TYPE_PASSAGE,      BOUNDARY_NONE },
    { GO_ANUBARAK_DOORS1,   DATA_ANUBARAK_EVENT,    DOOR_TYPE_ROOM,     BOUNDARY_NONE },
    { GO_ANUBARAK_DOORS2,   DATA_ANUBARAK_EVENT,    DOOR_TYPE_ROOM,     BOUNDARY_NONE },
    { GO_ANUBARAK_DOORS3,   DATA_ANUBARAK_EVENT,    DOOR_TYPE_ROOM,     BOUNDARY_NONE },
    { 0,                    0,                      DOOR_TYPE_ROOM,     BOUNDARY_NONE }
};

class instance_azjol_nerub : public InstanceMapScript
{
    public:
        instance_azjol_nerub() : InstanceMapScript("instance_azjol_nerub", 601) { }

        struct instance_azjol_nerub_InstanceScript : public InstanceScript
        {
            instance_azjol_nerub_InstanceScript(Map* map) : InstanceScript(map)
            {
                SetBossNumber(MAX_ENCOUNTERS);
                LoadDoorData(doorData);
                _krikthirGUID = 0;
                _hadronoxGUID = 0;
            };

            void OnCreatureCreate(Creature* creature)
            {
                switch (creature->GetEntry())
                {
                    case NPC_KRIKTHIR_THE_GATEWATCHER:
                        _krikthirGUID = creature->GetGUID();
                        break;
                    case NPC_HADRONOX:
                        _hadronoxGUID = creature->GetGUID();
                        break;
                    case NPC_SKITTERING_SWARMER:
                    case NPC_SKITTERING_INFECTIOR:
                        if (Creature* krikthir = instance->GetCreature(_krikthirGUID))
                            krikthir->AI()->JustSummoned(creature);
                        break;
                    case NPC_ANUB_AR_CHAMPION:
                    case NPC_ANUB_AR_NECROMANCER:
                    case NPC_ANUB_AR_CRYPTFIEND:
                        if (Creature* hadronox = instance->GetCreature(_hadronoxGUID))
                            hadronox->AI()->JustSummoned(creature);
                        break;

                }
            }                   

            void OnGameObjectCreate(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_KRIKTHIR_DOORS:
                    case GO_ANUBARAK_DOORS1:
                    case GO_ANUBARAK_DOORS2:
                    case GO_ANUBARAK_DOORS3:
                        AddDoor(go, true);
                        break;
                }
            }
            
            void OnGameObjectRemove(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_KRIKTHIR_DOORS:
                    case GO_ANUBARAK_DOORS1:
                    case GO_ANUBARAK_DOORS2:
                    case GO_ANUBARAK_DOORS3:
                        AddDoor(go, false);
                        break;
                }
            }

            bool SetBossState(uint32 id, EncounterState state)
            {
                return InstanceScript::SetBossState(id, state);
            }

            std::string GetSaveData()
            {
                std::ostringstream saveStream;
                saveStream << "A N " << GetBossSaveData();
                return saveStream.str();
            }

            void Load(const char* in)
            {
                if( !in )
                    return;

                char dataHead1, dataHead2;
                std::istringstream loadStream(in);
                loadStream >> dataHead1 >> dataHead2;
                if (dataHead1 == 'A' && dataHead2 == 'N')
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

        private:
            uint64 _krikthirGUID;
            uint64 _hadronoxGUID;
        };

        InstanceScript* GetInstanceScript(InstanceMap *map) const
        {
            return new instance_azjol_nerub_InstanceScript(map);
        }
};

class spell_azjol_nerub_fixate : public SpellScriptLoader
{
    public:
        spell_azjol_nerub_fixate() : SpellScriptLoader("spell_azjol_nerub_fixate") { }

        class spell_azjol_nerub_fixate_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_azjol_nerub_fixate_SpellScript);

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                    target->CastSpell(GetCaster(), GetEffectValue(), true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_azjol_nerub_fixate_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_azjol_nerub_fixate_SpellScript();
        }
};

class spell_azjol_nerub_web_wrap : public SpellScriptLoader
{
    public:
        spell_azjol_nerub_web_wrap() : SpellScriptLoader("spell_azjol_nerub_web_wrap") { }

        class spell_azjol_nerub_web_wrap_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_azjol_nerub_web_wrap_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                if (!target->HasAura(SPELL_WEB_WRAP_TRIGGER))
                    target->CastSpell(target, SPELL_WEB_WRAP_TRIGGER, true);
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_azjol_nerub_web_wrap_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_MOD_ROOT, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_azjol_nerub_web_wrap_AuraScript();
        }
};

void AddSC_instance_azjol_nerub()
{
   new instance_azjol_nerub();
   new spell_azjol_nerub_fixate();
   new spell_azjol_nerub_web_wrap();
}
