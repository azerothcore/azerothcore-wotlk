/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "shadowfang_keep.h"
#include "TemporarySummon.h"


enum Creatures
{
    NPC_ASH                 = 3850,
    NPC_ADA                 = 3849,
    NPC_ARCHMAGE_ARUGAL     = 4275,
    NPC_ARUGAL_VOIDWALKER   = 4627
};


class instance_shadowfang_keep : public InstanceMapScript
{
    public:
        instance_shadowfang_keep() : InstanceMapScript("instance_shadowfang_keep", 33) { }

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_shadowfang_keep_InstanceMapScript(map);
        }

        struct instance_shadowfang_keep_InstanceMapScript : public InstanceScript
        {
            instance_shadowfang_keep_InstanceMapScript(Map* map) : InstanceScript(map) { }

            void Initialize()
            {
                memset(&_encounters, 0, sizeof(_encounters));
            }

            void OnGameObjectCreate(GameObject* gameobject)
            {
                switch (gameobject->GetEntry())
                {
                    case GO_COURTYARD_DOOR:
                        if (_encounters[TYPE_COURTYARD] == DONE)
                            HandleGameObject(0, true, gameobject);
                        break;
                    case GO_SORCERER_DOOR:
                        if (_encounters[TYPE_FENRUS_THE_DEVOURER] == DONE)
                            HandleGameObject(0, true, gameobject);
                        break;
                    case GO_ARUGAL_DOOR:
                        if (_encounters[TYPE_WOLF_MASTER_NANDOS] == DONE)
                            HandleGameObject(0, true, gameobject);
                        break;
                }
            }

            void SetData(uint32 type, uint32 data)
            {
                switch (type)
                {
                    case TYPE_COURTYARD:
                    case TYPE_FENRUS_THE_DEVOURER:
                    case TYPE_WOLF_MASTER_NANDOS:
                        _encounters[type] = data;
                        break;
                }

                if (data == DONE)
                    SaveToDB();
            }

            std::string GetSaveData()
            {
                std::ostringstream saveStream;
                saveStream << "S K " << _encounters[0] << ' ' << _encounters[1] << ' ' << _encounters[2];
                return saveStream.str();
            }

            void Load(const char* in)
            {
                if (!in)
                    return;

                char dataHead1, dataHead2;
                std::istringstream loadStream(in);
                loadStream >> dataHead1 >> dataHead2;
                if (dataHead1 == 'S' && dataHead2 == 'K')
                {
                    for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                    {
                        loadStream >> _encounters[i];
                        if (_encounters[i] == IN_PROGRESS)
                            _encounters[i] = NOT_STARTED;
                    }
                }
            }

        private:
            uint32 _encounters[MAX_ENCOUNTERS];
        };

};

class spell_shadowfang_keep_haunting_spirits : public SpellScriptLoader
{
    public:
        spell_shadowfang_keep_haunting_spirits() : SpellScriptLoader("spell_shadowfang_keep_haunting_spirits") { }

        class spell_shadowfang_keep_haunting_spirits_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_shadowfang_keep_haunting_spirits_AuraScript);

            void CalcPeriodic(AuraEffect const* /*aurEff*/, bool& isPeriodic, int32& amplitude)
            {
                isPeriodic = true;
                amplitude = irand(30*IN_MILLISECONDS, 90*IN_MILLISECONDS);
            }

            void HandleDummyTick(AuraEffect const* aurEff)
            {
                GetTarget()->CastSpell((Unit*)NULL, aurEff->GetAmount(), true);
            }

            void HandleUpdatePeriodic(AuraEffect* aurEff)
            {
                aurEff->CalculatePeriodic(GetCaster());
            }

            void Register()
            {
                DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_shadowfang_keep_haunting_spirits_AuraScript::CalcPeriodic, EFFECT_0, SPELL_AURA_DUMMY);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_shadowfang_keep_haunting_spirits_AuraScript::HandleDummyTick, EFFECT_0, SPELL_AURA_DUMMY);
                OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_shadowfang_keep_haunting_spirits_AuraScript::HandleUpdatePeriodic, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_shadowfang_keep_haunting_spirits_AuraScript();
        }
};

enum ForsakenSpells
{
    SPELL_FORSAKEN_SKILL_SWORD          = 7038,
    SPELL_FORSAKEN_SKILL_SHADOW         = 7053
};

class spell_shadowfang_keep_forsaken_skills : public SpellScriptLoader
{
    public:
        spell_shadowfang_keep_forsaken_skills() : SpellScriptLoader("spell_shadowfang_keep_forsaken_skills") { }

        class spell_shadowfang_keep_forsaken_skills_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_shadowfang_keep_forsaken_skills_AuraScript);

            bool Load()
            {
                _forsakenSpell = 0;
                return true;
            }

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                _forsakenSpell = urand(SPELL_FORSAKEN_SKILL_SWORD, SPELL_FORSAKEN_SKILL_SHADOW);
                if (_forsakenSpell == SPELL_FORSAKEN_SKILL_SHADOW - 1)
                    ++_forsakenSpell;
                GetUnitOwner()->CastSpell(GetUnitOwner(), _forsakenSpell, true);
            }

            void HandleDummyTick(AuraEffect const*  /*aurEff*/)
            {
                PreventDefaultAction();
                GetUnitOwner()->RemoveAurasDueToSpell(_forsakenSpell);
                _forsakenSpell = urand(SPELL_FORSAKEN_SKILL_SWORD, SPELL_FORSAKEN_SKILL_SHADOW);
                if (_forsakenSpell == SPELL_FORSAKEN_SKILL_SHADOW - 1)
                    ++_forsakenSpell;
                GetUnitOwner()->CastSpell(GetUnitOwner(), _forsakenSpell, true);
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_shadowfang_keep_forsaken_skills_AuraScript::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_shadowfang_keep_forsaken_skills_AuraScript::HandleDummyTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }

        private:
            uint32 _forsakenSpell;
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_shadowfang_keep_forsaken_skills_AuraScript();
        }
};

void AddSC_instance_shadowfang_keep()
{
    new instance_shadowfang_keep();
    new spell_shadowfang_keep_haunting_spirits();
    new spell_shadowfang_keep_forsaken_skills();
}
