/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "InstanceScript.h"
#include "ScriptMgr.h"
#include "TemporarySummon.h"
#include "shadowfang_keep.h"

enum Spells
{
    SPELL_SUMMON_VALENTINE_ADD = 68610
};

class instance_shadowfang_keep : public InstanceMapScript
{
public:
    instance_shadowfang_keep() : InstanceMapScript("instance_shadowfang_keep", 33) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_shadowfang_keep_InstanceMapScript(map);
    }

    struct instance_shadowfang_keep_InstanceMapScript : public InstanceScript
    {
        instance_shadowfang_keep_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize() override
        {
            memset(&_encounters, 0, sizeof(_encounters));
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_DND_CRAZED_APOTHECARY_GENERATOR:
                    _crazedApothecaryGeneratorGUIDs.push_back(creature->GetGUID());
                    break;
                case NPC_APOTHECARY_HUMMEL:
                    _apothecaryHummel = creature->GetGUID();
                    break;
                case NPC_CRAZED_APOTHECARY:
                    if (Creature* hummel = instance->GetCreature(_apothecaryHummel))
                    {
                        hummel->AI()->JustSummoned(creature);
                    }
                    break;
                default:
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* gameobject) override
        {
            switch (gameobject->GetEntry())
            {
                case GO_COURTYARD_DOOR:
                    if (_encounters[TYPE_COURTYARD] == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, gameobject);
                    break;
                case GO_SORCERER_DOOR:
                    if (_encounters[TYPE_FENRUS_THE_DEVOURER] == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, gameobject);
                    break;
                case GO_ARUGAL_DOOR:
                    if (_encounters[TYPE_WOLF_MASTER_NANDOS] == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, gameobject);
                    break;
                default:
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case TYPE_COURTYARD:
                case TYPE_FENRUS_THE_DEVOURER:
                case TYPE_WOLF_MASTER_NANDOS:
                    _encounters[type] = data;
                    break;
                case DATA_SPAWN_VALENTINE_ADDS:
                    for (ObjectGuid guid : _crazedApothecaryGeneratorGUIDs)
                    {
                        if (Creature* generator = instance->GetCreature(guid))
                        {
                            generator->CastSpell(nullptr, SPELL_SUMMON_VALENTINE_ADD);
                        }
                    }
                    break;
                default:
                    break;
            }

            if (data == DONE)
                SaveToDB();
        }

        std::string GetSaveData() override
        {
            std::ostringstream saveStream;
            saveStream << "S K " << _encounters[0] << ' ' << _encounters[1] << ' ' << _encounters[2];
            return saveStream.str();
        }

        void Load(const char* in) override
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
        GuidVector _crazedApothecaryGeneratorGUIDs;
        ObjectGuid _apothecaryHummel;
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
            amplitude = irand(30 * IN_MILLISECONDS, 90 * IN_MILLISECONDS);
        }

        void HandleDummyTick(AuraEffect const* aurEff)
        {
            GetTarget()->CastSpell((Unit*)nullptr, aurEff->GetAmount(), true);
        }

        void HandleUpdatePeriodic(AuraEffect* aurEff)
        {
            aurEff->CalculatePeriodic(GetCaster());
        }

        void Register() override
        {
            DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_shadowfang_keep_haunting_spirits_AuraScript::CalcPeriodic, EFFECT_0, SPELL_AURA_DUMMY);
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_shadowfang_keep_haunting_spirits_AuraScript::HandleDummyTick, EFFECT_0, SPELL_AURA_DUMMY);
            OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_shadowfang_keep_haunting_spirits_AuraScript::HandleUpdatePeriodic, EFFECT_0, SPELL_AURA_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const override
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

        bool Load() override
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

        void Register() override
        {
            OnEffectApply += AuraEffectApplyFn(spell_shadowfang_keep_forsaken_skills_AuraScript::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_shadowfang_keep_forsaken_skills_AuraScript::HandleDummyTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }

    private:
        uint32 _forsakenSpell;
    };

    AuraScript* GetAuraScript() const override
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
