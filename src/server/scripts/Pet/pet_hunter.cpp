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

/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_hun_".
 */

#include "CombatManager.h"
#include "Containers.h"
#include "CreatureScript.h"
#include "PetDefines.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TemporarySummon.h"

enum HunterSpells
{
    SPELL_HUNTER_CRIPPLING_POISON       = 30981, // Viper
    SPELL_HUNTER_DEADLY_POISON_PASSIVE  = 34657, // Venomous Snake
    SPELL_HUNTER_MIND_NUMBING_POISON    = 25810, // Viper
    SPELL_HUNTER_GLYPH_OF_SNAKE_TRAP    = 56849,
    SPELL_HUNTER_PET_SCALING            = 62915
};

enum PetSpellsMisc
{
    SPELL_PET_GUARD_DOG_HAPPINESS   = 54445,
    SPELL_PET_SILVERBACK_RANK_1     = 62800,
    SPELL_PET_SILVERBACK_RANK_2     = 62801,

    PET_ICON_ID_GROWL               = 201,
    PET_ICON_ID_CLAW                = 262,
    PET_ICON_ID_BITE                = 1680,
    PET_ICON_ID_SMACK               = 473
};

struct npc_pet_hunter_snake_trap : public ScriptedAI
{
    npc_pet_hunter_snake_trap(Creature* creature) : ScriptedAI(creature), _isViper(false), _spellTimer(0) { }

    void JustEngagedWith(Unit* /*who*/) override { }

    void InitializeAI() override
    {
        _isViper = me->GetEntry() == NPC_VIPER;

        me->SetMaxHealth(uint32(107 * (me->GetLevel() - 40) * 0.025f));
        // Add delta to make them not all hit the same time
        me->SetAttackTime(BASE_ATTACK, me->GetAttackTime(BASE_ATTACK) + urandms(0, 6));

        if (!_isViper && !me->HasAura(SPELL_HUNTER_DEADLY_POISON_PASSIVE))
            DoCast(me, SPELL_HUNTER_DEADLY_POISON_PASSIVE, true);

        // Glyph of Snake Trap — apply AoE damage reduction scaling
        if (Unit* owner = me->GetOwner())
            if (owner->GetAuraEffectDummy(SPELL_HUNTER_GLYPH_OF_SNAKE_TRAP))
                me->CastSpell(me, SPELL_HUNTER_PET_SCALING, true);
    }

    // Redefined for random target selection:
    void MoveInLineOfSight(Unit* /*who*/) override { }

    void UpdateAI(uint32 diff) override
    {
        if (me->GetVictim() && me->GetVictim()->HasBreakableByDamageCrowdControlAura(me))
        {
            me->GetThreatMgr().ClearFixate();
            me->InterruptNonMeleeSpells(false);
            me->AttackStop();
            return;
        }

        if (me->IsSummon() && !me->GetThreatMgr().GetFixateTarget())
        {
            Unit* summoner = me->ToTempSummon()->GetSummonerUnit();
            if (summoner)
            {
                std::vector<Unit*> targets;

                auto addTargetIfValid = [this, &targets, summoner](CombatReference* ref) mutable
                {
                    Unit* enemy = ref->GetOther(summoner);
                    if (!enemy->HasBreakableByDamageCrowdControlAura(me) && me->CanCreatureAttack(enemy) && me->IsWithinDistInMap(enemy, me->GetAttackDistance(enemy)))
                        targets.push_back(enemy);
                };

                for (auto const& [guid, ref] : summoner->GetCombatManager().GetPvPCombatRefs())
                    addTargetIfValid(ref);

                if (targets.empty())
                    for (auto const& [guid, ref] : summoner->GetCombatManager().GetPvECombatRefs())
                        addTargetIfValid(ref);

                for (Unit* target : targets)
                    me->EngageWithTarget(target);

                if (!targets.empty())
                {
                    Unit* target = Acore::Containers::SelectRandomContainerElement(targets);
                    me->GetThreatMgr().FixateTarget(target);
                }
            }
        }

        if (!UpdateVictim())
            return;

        // Viper
        if (_isViper)
        {
            if (_spellTimer <= diff)
            {
                if (!urand(0, 2)) // 33% chance to cast
                    DoCastVictim(RAND(SPELL_HUNTER_MIND_NUMBING_POISON, SPELL_HUNTER_CRIPPLING_POISON));

                _spellTimer = 3000;
            }
            else
                _spellTimer -= diff;
        }

        DoMeleeAttackIfReady();
    }

private:
    bool _isViper;
    uint32 _spellTimer;
};

// -53178 - Guard Dog
class spell_pet_guard_dog : public AuraScript
{
    PrepareAuraScript(spell_pet_guard_dog);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PET_GUARD_DOG_HAPPINESS });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        // Growl shares family flags with other spells
        // filter by spellIcon instead
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo || spellInfo->SpellIconID != PET_ICON_ID_GROWL)
            return false;

        return true;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        Unit* caster = eventInfo.GetActor();
        caster->CastSpell(nullptr, SPELL_PET_GUARD_DOG_HAPPINESS, true, nullptr, aurEff);

        Unit* target = eventInfo.GetActionTarget();
        if (!target->CanHaveThreatList())
            return;

        SpellInfo const* procSpellInfo = eventInfo.GetSpellInfo();
        if (!procSpellInfo)
            return;

        float addThreat = CalculatePct(static_cast<float>(procSpellInfo->Effects[EFFECT_0].CalcValue(caster)), aurEff->GetAmount());
        target->GetThreatMgr().AddThreat(caster, addThreat, GetSpellInfo());
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pet_guard_dog::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pet_guard_dog::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// -62764 - Silverback
class spell_pet_silverback : public AuraScript
{
    PrepareAuraScript(spell_pet_silverback);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PET_SILVERBACK_RANK_1, SPELL_PET_SILVERBACK_RANK_2 });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        // Growl shares family flags with other spells
        // filter by spellIcon instead
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo || spellInfo->SpellIconID != PET_ICON_ID_GROWL)
            return false;

        return true;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        static uint32 const triggerSpell[2] = { SPELL_PET_SILVERBACK_RANK_1, SPELL_PET_SILVERBACK_RANK_2 };

        PreventDefaultAction();

        uint8 rank = GetSpellInfo()->GetRank();
        if (rank > 0 && rank <= 2)
        {
            uint32 spellId = triggerSpell[rank - 1];
            eventInfo.GetActor()->CastSpell(nullptr, spellId, true, nullptr, aurEff);
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pet_silverback::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pet_silverback::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// -61680 - Culling the Herd
class spell_pet_culling_the_herd : public AuraScript
{
    PrepareAuraScript(spell_pet_culling_the_herd);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        // Claw, Bite and Smack share FamilyFlags with other spells
        // filter by spellIcon instead
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo)
            return false;

        switch (spellInfo->SpellIconID)
        {
            case PET_ICON_ID_CLAW:
            case PET_ICON_ID_BITE:
            case PET_ICON_ID_SMACK:
                break;
            default:
                return false;
        }

        return true;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pet_culling_the_herd::CheckProc);
    }
};

void AddSC_hunter_pet_scripts()
{
    RegisterCreatureAI(npc_pet_hunter_snake_trap);
    RegisterSpellScript(spell_pet_guard_dog);
    RegisterSpellScript(spell_pet_silverback);
    RegisterSpellScript(spell_pet_culling_the_herd);
}
