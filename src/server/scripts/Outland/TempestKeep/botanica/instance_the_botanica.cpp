/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "the_botanica.h"

class instance_the_botanica : public InstanceMapScript
{
    public:
        instance_the_botanica() : InstanceMapScript("instance_the_botanica", 553) { }

        struct instance_the_botanica_InstanceMapScript : public InstanceScript
        {
            instance_the_botanica_InstanceMapScript(Map* map) : InstanceScript(map)
            {
                SetBossNumber(MAX_ENCOUNTER);
            }

            bool SetBossState(uint32 type, EncounterState state)
            {
                if (!InstanceScript::SetBossState(type, state))
                    return false;

                return true;
            }

            std::string GetSaveData()
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << "B O " << GetBossSaveData();

                OUT_SAVE_INST_DATA_COMPLETE;
                return saveStream.str();
            }

            void Load(char const* str)
            {
                if (!str)
                {
                    OUT_LOAD_INST_DATA_FAIL;
                    return;
                }

                OUT_LOAD_INST_DATA(str);

                char dataHead1, dataHead2;

                std::istringstream loadStream(str);
                loadStream >> dataHead1 >> dataHead2;

                if (dataHead1 == 'B' && dataHead2 == 'O')
                {
                    for (uint32 i = 0; i < MAX_ENCOUNTER; ++i)
                    {
                        uint32 tmpState;
                        loadStream >> tmpState;
                        if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                            tmpState = NOT_STARTED;
                        SetBossState(i, EncounterState(tmpState));
                    }
                }
                else
                    OUT_LOAD_INST_DATA_FAIL;

                OUT_LOAD_INST_DATA_COMPLETE;
            }
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_the_botanica_InstanceMapScript(map);
        }
};

class spell_botanica_call_of_the_falcon : public SpellScriptLoader
{
public:
    spell_botanica_call_of_the_falcon() : SpellScriptLoader("spell_botanica_call_of_the_falcon") { }

    class spell_botanica_call_of_the_falcon_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_botanica_call_of_the_falcon_AuraScript)

        bool Load()
        {
            _falconSet.clear();
            return true;
        }
        
        void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            std::list<Creature*> creatureList;
            GetUnitOwner()->GetCreaturesWithEntryInRange(creatureList, 80.0f, NPC_BLOODFALCON);
            for (std::list<Creature*>::const_iterator itr = creatureList.begin(); itr != creatureList.end(); ++itr)
            {
                (*itr)->TauntApply(GetUnitOwner());
                (*itr)->AddThreat(GetUnitOwner(), 10000000.0f);
                _falconSet.insert((*itr)->GetGUID());
            }
        }

        void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            for (std::set<uint64>::const_iterator itr = _falconSet.begin(); itr != _falconSet.end(); ++itr)
                if (Creature* falcon = ObjectAccessor::GetCreature(*GetUnitOwner(), *itr))
                {
                    falcon->TauntFadeOut(GetUnitOwner());
                    falcon->AddThreat(GetUnitOwner(), -10000000.0f);
                }
        }

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_botanica_call_of_the_falcon_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            OnEffectRemove += AuraEffectRemoveFn(spell_botanica_call_of_the_falcon_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }

        private:
            std::set<uint64> _falconSet;
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_botanica_call_of_the_falcon_AuraScript();
    }
};

class spell_botanica_shift_form : public SpellScriptLoader
{
    public:
        spell_botanica_shift_form() : SpellScriptLoader("spell_botanica_shift_form") { }

        class spell_botanica_shift_form_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_botanica_shift_form_AuraScript);

            bool Load()
            {
                _lastSchool = 0;
                _lastForm = 0;
                _swapTime = 0;
                return true;
            }

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                if (SpellInfo const* spellInfo = eventInfo.GetDamageInfo()->GetSpellInfo())
                {
                    if ((spellInfo->GetSchoolMask() & _lastSchool) && _swapTime > time(nullptr))
                        return false;

                    uint32 form = 0;
                    switch (GetFirstSchoolInMask(spellInfo->GetSchoolMask()))
                    {
                        case SPELL_SCHOOL_FIRE:     form = SPELL_FIRE_FORM;     break;
                        case SPELL_SCHOOL_FROST:    form = SPELL_FROST_FORM;    break;
                        case SPELL_SCHOOL_ARCANE:   form = SPELL_ARCANE_FORM;   break;
                        case SPELL_SCHOOL_SHADOW:   form = SPELL_SHADOW_FORM;   break;
                        default:
                            break;
                    }

                    if (form)
                    {
                        _swapTime = time(nullptr) + 6;
                        _lastSchool = spellInfo->GetSchoolMask();
                        GetUnitOwner()->RemoveAurasDueToSpell(_lastForm);
                        _lastForm = form;
                        GetUnitOwner()->CastSpell(GetUnitOwner(), _lastForm, true);
                    }
                }

                return false;
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_botanica_shift_form_AuraScript::CheckProc);
            }

            private:
                uint32 _lastSchool;
                uint32 _lastForm;
                uint32 _swapTime;
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_botanica_shift_form_AuraScript();
        }
};

void AddSC_instance_the_botanica()
{
    new instance_the_botanica();
    new spell_botanica_call_of_the_falcon();
    new spell_botanica_shift_form();
}
