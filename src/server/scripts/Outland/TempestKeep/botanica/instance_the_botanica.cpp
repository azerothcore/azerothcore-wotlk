/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "GameTime.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "the_botanica.h"

class instance_the_botanica : public InstanceMapScript
{
public:
    instance_the_botanica() : InstanceMapScript("instance_the_botanica", MAP_TEMPEST_KEEP_THE_BOTANICA) { }

    struct instance_the_botanica_InstanceMapScript : public InstanceScript
    {
        instance_the_botanica_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTER);
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_the_botanica_InstanceMapScript(map);
    }
};

class spell_botanica_call_of_the_falcon_aura : public AuraScript
{
    PrepareAuraScript(spell_botanica_call_of_the_falcon_aura);

    bool Load() override
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
        for (ObjectGuid const& guid : _falconSet)
            if (Creature* falcon = ObjectAccessor::GetCreature(*GetUnitOwner(), guid))
            {
                falcon->TauntFadeOut(GetUnitOwner());
                falcon->AddThreat(GetUnitOwner(), -10000000.0f);
            }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_botanica_call_of_the_falcon_aura::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_botanica_call_of_the_falcon_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }

private:
    GuidSet _falconSet;
};

class spell_botanica_shift_form_aura : public AuraScript
{
    PrepareAuraScript(spell_botanica_shift_form_aura);

    bool Load() override
    {
        _lastSchool = 0;
        _lastForm = 0;
        _swapTime = 0;
        return true;
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (SpellInfo const* spellInfo = eventInfo.GetSpellInfo())
        {
            if ((spellInfo->GetSchoolMask() & _lastSchool) && _swapTime > GameTime::GetGameTime().count())
                return false;

            uint32 form = 0;
            switch (GetFirstSchoolInMask(spellInfo->GetSchoolMask()))
            {
                case SPELL_SCHOOL_FIRE:
                    form = SPELL_FIRE_FORM;
                    break;
                case SPELL_SCHOOL_FROST:
                    form = SPELL_FROST_FORM;
                    break;
                case SPELL_SCHOOL_ARCANE:
                    form = SPELL_ARCANE_FORM;
                    break;
                case SPELL_SCHOOL_SHADOW:
                    form = SPELL_SHADOW_FORM;
                    break;
                default:
                    break;
            }

            if (form)
            {
                _swapTime = GameTime::GetGameTime().count() + 6;
                _lastSchool = spellInfo->GetSchoolMask();
                GetUnitOwner()->RemoveAurasDueToSpell(_lastForm);
                _lastForm = form;
                GetUnitOwner()->CastSpell(GetUnitOwner(), _lastForm, true);
            }
        }

        return false;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_botanica_shift_form_aura::CheckProc);
    }

private:
    uint32 _lastSchool;
    uint32 _lastForm;
    uint32 _swapTime;
};

void AddSC_instance_the_botanica()
{
    new instance_the_botanica();
    RegisterSpellScript(spell_botanica_call_of_the_falcon_aura);
    RegisterSpellScript(spell_botanica_shift_form_aura);
}
