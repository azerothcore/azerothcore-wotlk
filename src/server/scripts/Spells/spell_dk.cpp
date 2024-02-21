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

#include "CreatureScript.h"
#include "PetDefines.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Totem.h"
#include "UnitAI.h"
/*
 * Scripts for spells with SPELLFAMILY_DEATHKNIGHT and SPELLFAMILY_GENERIC spells used by deathknight players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_dk_".
 */

enum DeathKnightSpells
{
    SPELL_DK_DEATH_AND_DECAY_TRIGGER            = 52212,
    SPELL_DK_GLYPH_OF_SCOURGE_STRIKE            = 58642,
    SPELL_DK_WANDERING_PLAGUE_TRIGGER           = 50526,
    SPELL_DK_GLYPH_OF_THE_GHOUL                 = 58686,
    SPELL_SHADOWMOURNE_CHAOS_BANE_DAMAGE        = 71904,
    SPELL_SHADOWMOURNE_SOUL_FRAGMENT            = 71905,
    SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF          = 73422,
    SPELL_DK_ANTI_MAGIC_SHELL_TALENT            = 51052,
    SPELL_DK_BLACK_ICE_R1                       = 49140,
    SPELL_DK_BLOOD_BOIL_TRIGGERED               = 65658,
    SPELL_DK_BLOOD_GORGED_HEAL                  = 50454,
    SPELL_DK_BLOOD_PRESENCE                     = 48266,
    SPELL_DK_CORPSE_EXPLOSION_TRIGGERED         = 43999,
    SPELL_DK_CORPSE_EXPLOSION_VISUAL            = 51270,
    SPELL_DK_DEATH_COIL_DAMAGE                  = 47632,
    SPELL_DK_DEATH_COIL_HEAL                    = 47633,
    SPELL_DK_DEATH_STRIKE_HEAL                  = 45470,
    SPELL_DK_FROST_FEVER                        = 55095,
    SPELL_DK_FROST_PRESENCE                     = 48263,
    SPELL_DK_FROST_PRESENCE_TRIGGERED           = 61261,
    SPELL_DK_GHOUL_EXPLODE                      = 47496,
    SPELL_DK_GLYPH_OF_DISEASE                   = 63334,
    SPELL_DK_GLYPH_OF_ICEBOUND_FORTITUDE        = 58625,
    SPELL_DK_IMPROVED_BLOOD_PRESENCE_R1         = 50365,
    SPELL_DK_IMPROVED_FROST_PRESENCE_R1         = 50384,
    SPELL_DK_IMPROVED_UNHOLY_PRESENCE_R1        = 50391,
    SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED  = 63611,
    SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED = 63622,
    SPELL_DK_ITEM_SIGIL_VENGEFUL_HEART          = 64962,
    SPELL_DK_ITEM_T8_MELEE_4P_BONUS             = 64736,
    SPELL_DK_MASTER_OF_GHOULS                   = 52143,
    SPELL_DK_BLOOD_PLAGUE                       = 55078,
    SPELL_DK_RAISE_DEAD_USE_REAGENT             = 48289,
    SPELL_DK_RUNIC_POWER_ENERGIZE               = 49088,
    SPELL_DK_SCENT_OF_BLOOD                     = 50422,
    SPELL_DK_SCOURGE_STRIKE_TRIGGERED           = 70890,
    SPELL_DK_UNHOLY_PRESENCE                    = 48265,
    SPELL_DK_UNHOLY_PRESENCE_TRIGGERED          = 49772,
    SPELL_DK_WILL_OF_THE_NECROPOLIS_TALENT_R1   = 49189,
    SPELL_DK_WILL_OF_THE_NECROPOLIS_AURA_R1     = 52284,
    // Risen Ally
    SPELL_DK_RAISE_ALLY                         = 46619,
    SPELL_DK_THRASH                             = 47480,
    SPELL_GHOUL_FRENZY                          = 62218,
};

enum DeathKnightSpellIcons
{
    DK_ICON_ID_IMPROVED_DEATH_STRIKE            = 2751
};

enum Misc
{
    NPC_DK_GHOUL                                = 26125,
    NPC_RISEN_ALLY                              = 30230
};

// 50526 - Wandering Plague
class spell_dk_wandering_plague : public SpellScript
{
    PrepareSpellScript(spell_dk_wandering_plague);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        static const AuraType ccAuras[] =
        {
            SPELL_AURA_MOD_CONFUSE,
            SPELL_AURA_MOD_FEAR,
            SPELL_AURA_MOD_STUN,
            SPELL_AURA_MOD_ROOT,
            SPELL_AURA_TRANSFORM,
            SPELL_AURA_NONE
        };

        for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end();)
        {
            Unit* target = (*itr)->ToUnit();
            if (!target)
            {
                targets.erase(itr++);
                continue;
            }

            bool skip = false;
            for (uint8 index = 0; !skip && ccAuras[index] != SPELL_AURA_NONE; ++index)
            {
                Unit::AuraEffectList const& auras = target->GetAuraEffectsByType(ccAuras[index]);
                for (Unit::AuraEffectList::const_iterator i = auras.begin(); i != auras.end(); ++i)
                    if ((*i)->GetAmount())
                    {
                        skip = true;
                        break;
                    }
            }

            if (skip)
                targets.erase(itr++);
            else
                ++itr;
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dk_wandering_plague::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
    }
};

// 61999 - Raise Ally
class spell_dk_raise_ally : public SpellScript
{
    PrepareSpellScript(spell_dk_raise_ally);

    SpellCastResult CheckCast()
    {
        Player* unitTarget = GetHitPlayer();
        if (!unitTarget)
            return SPELL_FAILED_BAD_TARGETS;

        if (unitTarget->IsAlive()) // not discovered attributeEx5?
            return SPELL_FAILED_TARGET_NOT_DEAD;

        return SPELL_CAST_OK;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Player* unitTarget = GetHitPlayer())
        {
            unitTarget->CastSpell(unitTarget, GetEffectValue(), true);
            if (Unit* ghoul = unitTarget->GetCharm())
            {
                //health, mana, armor and resistance
                PetLevelInfo const* pInfo = sObjectMgr->GetPetLevelInfo(ghoul->GetEntry(), ghoul->GetLevel());
                if (pInfo)                                      // exist in DB
                {
                    ghoul->SetCreateHealth(pInfo->health);
                    ghoul->SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, pInfo->health);
                    ghoul->SetModifierValue(UNIT_MOD_ARMOR, BASE_VALUE, float(pInfo->armor));
                    for (uint8 stat = 0; stat < MAX_STATS; ++stat)
                        ghoul->SetCreateStat(Stats(stat), float(pInfo->stats[stat]));
                }

                ghoul->SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, float(ghoul->GetLevel() - (ghoul->GetLevel() / 4)));
                ghoul->SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, float(ghoul->GetLevel() + (ghoul->GetLevel() / 4)));

                // Avoidance, Night of the Dead
                if (Aura* aur = ghoul->AddAura(62137, ghoul))
                    if (AuraEffect* aurEff = GetCaster()->GetAuraEffect(SPELL_AURA_ADD_FLAT_MODIFIER, SPELLFAMILY_DEATHKNIGHT, 2718, 0))
                        if (aur->GetEffect(0))
                            aur->GetEffect(0)->SetAmount(-aurEff->GetSpellInfo()->Effects[EFFECT_2].CalcValue());

                // Hit / Expertise scalling, warlock / hunter pets have this by default
                ghoul->AddAura(SPELL_HUNTER_PET_SCALING_04, ghoul);

                // DK Ghoul haste refresh
                float val = (GetCaster()->m_modAttackSpeedPct[BASE_ATTACK] - 1.0f) * 100.0f;
                ghoul->m_modAttackSpeedPct[BASE_ATTACK] = GetCaster()->m_modAttackSpeedPct[BASE_ATTACK];
                ghoul->SetFloatValue(UNIT_FIELD_BASEATTACKTIME, 2000.0f);
                ghoul->ApplyPercentModFloatValue(UNIT_FIELD_BASEATTACKTIME, val, true); // we want to reduce attack time

                // Strength + Stamina
                for (uint8 i = STAT_STRENGTH; i <= STAT_STAMINA; ++i)
                {
                    Stats stat = Stats(i);
                    if (stat != STAT_STRENGTH && stat != STAT_STAMINA)
                        continue;

                    float value = 0.0f;
                    float mod = (stat == STAT_STAMINA ? 0.3f : 0.7f);

                    // Check just if owner has Ravenous Dead since it's effect is not an aura
                    AuraEffect const* aurEff = GetCaster()->GetAuraEffect(SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, SPELLFAMILY_DEATHKNIGHT, 3010, 0);
                    if (aurEff)
                    {
                        SpellInfo const* spellInfo = aurEff->GetSpellInfo();                                                 // Then get the SpellProto and add the dummy effect value
                        AddPct(mod, spellInfo->Effects[EFFECT_1].CalcValue());                                              // Ravenous Dead edits the original scale
                    }
                    // Glyph of the Ghoul
                    aurEff = GetCaster()->GetAuraEffect(SPELL_DK_GLYPH_OF_THE_GHOUL, EFFECT_0);
                    if (aurEff)
                        mod += CalculatePct(1.0f, aurEff->GetAmount());                                                    // Glyph of the Ghoul adds a flat value to the scale mod

                    value = float(GetCaster()->GetStat(stat)) * mod;
                    value = ghoul->GetTotalStatValue(stat, value);
                    ghoul->SetStat(stat, int32(value));
                    ghoul->ApplyStatBuffMod(stat, value, true);
                }

                // Attack Power
                ghoul->SetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE, 589 + ghoul->GetStat(STAT_STRENGTH) + ghoul->GetStat(STAT_AGILITY));
                ghoul->SetInt32Value(UNIT_FIELD_ATTACK_POWER, (int32)ghoul->GetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE) * ghoul->GetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_PCT));
                ghoul->SetInt32Value(UNIT_FIELD_ATTACK_POWER_MODS, (int32)ghoul->GetModifierValue(UNIT_MOD_ATTACK_POWER, TOTAL_VALUE));
                ghoul->SetFloatValue(UNIT_FIELD_ATTACK_POWER_MULTIPLIER, ghoul->GetModifierValue(UNIT_MOD_ATTACK_POWER, TOTAL_PCT) - 1.0f);

                // Health
                ghoul->SetModifierValue(UNIT_MOD_HEALTH, TOTAL_VALUE, (ghoul->GetStat(STAT_STAMINA) - ghoul->GetCreateStat(STAT_STAMINA)) * 10.0f);

                // Power Energy
                ghoul->SetModifierValue(UnitMods(UNIT_MOD_POWER_START + static_cast<uint8>(POWER_ENERGY)), BASE_VALUE, ghoul->GetCreatePowers(POWER_ENERGY));
                ghoul->UpdateAllStats();
                ghoul->SetFullHealth();

                // Aura Immunities
                ghoul->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_MELEE_RANGED_HASTE, true, SPELL_BLOCK_TYPE_POSITIVE);
                ghoul->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MELEE_SLOW, true, SPELL_BLOCK_TYPE_POSITIVE);
                ghoul->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_STAT, true, SPELL_BLOCK_TYPE_POSITIVE);
                ghoul->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, true, SPELL_BLOCK_TYPE_POSITIVE);
                ghoul->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER, true, SPELL_BLOCK_TYPE_POSITIVE);
                ghoul->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER_PCT, true, SPELL_BLOCK_TYPE_POSITIVE);
            }
        }
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_dk_raise_ally::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_dk_raise_ally::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 46619 - Raise Ally
class spell_dk_raise_ally_trigger : public AuraScript
{
    PrepareAuraScript(spell_dk_raise_ally_trigger);

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* charm = GetUnitOwner()->GetCharm())
            if (GetSpellInfo()->Effects[EFFECT_0].MiscValue >= 0 && charm->GetEntry() == uint32(GetSpellInfo()->Effects[EFFECT_0].MiscValue))
                charm->ToCreature()->DespawnOrUnsummon();
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_dk_raise_ally_trigger::HandleEffectRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 43263 - Ghoul Taunt
class spell_dk_aotd_taunt : public SpellScript
{
    PrepareSpellScript(spell_dk_aotd_taunt);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end();)
        {
            // ignore bosses
            if (Creature* cr = (*itr)->ToCreature())
                if (cr->isWorldBoss())
                {
                    targets.erase(itr++);
                    continue;
                }

            ++itr;
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dk_aotd_taunt::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

// -43265, 52212 - Death and Decay
class spell_dk_death_and_decay : public SpellScript
{
    PrepareSpellScript(spell_dk_death_and_decay);

    void RecalculateDamage()
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        int32 damage = GetHitDamage();

        // T10P2 bonus
        if (AuraEffect* aurEff = caster->GetAuraEffectDummy(70650))
            AddPct(damage, aurEff->GetAmount());
        // Glyph of Death and Decay
        if (AuraEffect* aurEff = caster->GetAuraEffect(58629, EFFECT_0))
            AddPct(damage, aurEff->GetAmount());

        // Xinef: include AOE damage reducing auras
        if (target)
            damage = target->CalculateAOEDamageReduction(damage, GetSpellInfo()->SchoolMask, caster);

        SetHitDamage(damage);
    }

    void Register() override
    {
        if (m_scriptSpellId == SPELL_DK_DEATH_AND_DECAY_TRIGGER)
            OnHit += SpellHitFn(spell_dk_death_and_decay::RecalculateDamage);
    }
};

class spell_dk_death_and_decay_aura : public AuraScript
{
    PrepareAuraScript(spell_dk_death_and_decay_aura);

    void HandlePeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (GetCaster() && GetTarget())
        {
            int32 basePoints0 = aurEff->GetAmount();
            GetCaster()->CastCustomSpell(GetTarget(), SPELL_DK_DEATH_AND_DECAY_TRIGGER, &basePoints0, nullptr, nullptr, true, 0, aurEff);
        }
    }

    void Register() override
    {
        if (m_scriptSpellId != SPELL_DK_DEATH_AND_DECAY_TRIGGER)
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_dk_death_and_decay_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 52143 - Master of Ghouls
class spell_dk_master_of_ghouls : public AuraScript
{
    PrepareAuraScript(spell_dk_master_of_ghouls);

    void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (target->GetTypeId() == TYPEID_PLAYER)
            target->ToPlayer()->SetShowDKPet(true);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (target->GetTypeId() == TYPEID_PLAYER)
            target->ToPlayer()->SetShowDKPet(false);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_dk_master_of_ghouls::HandleEffectApply, EFFECT_0, SPELL_AURA_ADD_FLAT_MODIFIER, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_dk_master_of_ghouls::HandleEffectRemove, EFFECT_0, SPELL_AURA_ADD_FLAT_MODIFIER, AURA_EFFECT_HANDLE_REAL);
    }
};

// 45524 - Chains of Ice
class spell_dk_chains_of_ice : public SpellScript
{
    PrepareSpellScript(spell_dk_chains_of_ice);

    void HandleAfterCast()
    {
        if (Unit* target = GetExplTargetUnit())
        {
            std::list<TargetInfo> const* targetsInfo = GetSpell()->GetUniqueTargetInfo();
            for (std::list<TargetInfo>::const_iterator ihit = targetsInfo->begin(); ihit != targetsInfo->end(); ++ihit)
                if (ihit->missCondition == SPELL_MISS_NONE && ihit->targetGUID == target->GetGUID())
                    GetCaster()->CastSpell(target, 55095 /*SPELL_FROST_FEVER*/, true);
        }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_dk_chains_of_ice::HandleAfterCast);
    }
};

class spell_dk_chains_of_ice_aura : public AuraScript
{
    PrepareAuraScript(spell_dk_chains_of_ice_aura);

    void HandlePeriodic(AuraEffect* aurEff)
    {
        // Get 0 effect aura
        if (AuraEffect* slow = GetAura()->GetEffect(0))
        {
            int32 newAmount = slow->GetAmount() + aurEff->GetAmount();
            if (newAmount > 0)
                newAmount = 0;
            slow->ChangeAmount(newAmount);
        }
    }

    void Register() override
    {
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_dk_chains_of_ice_aura::HandlePeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 50452 - Bloodworm
class spell_dk_bloodworms : public SpellScript
{
    PrepareSpellScript(spell_dk_bloodworms);

    void HandleSummon(SpellEffIndex /*effIndex*/)
    {
        SetEffectValue(irand(2, 4));
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_dk_bloodworms::HandleSummon, EFFECT_0, SPELL_EFFECT_SUMMON);
    }
};

// 49206 - Summon Gargoyle
class spell_dk_summon_gargoyle : public SpellScript
{
    PrepareSpellScript(spell_dk_summon_gargoyle);

    void SetDest(SpellDestination& dest)
    {
        // Adjust effect summon position
        if (GetCaster()->IsWithinLOS(dest._position.GetPositionX(), dest._position.GetPositionY(), dest._position.GetPositionZ() + 15.0f))
            dest._position.m_positionZ += 15.0f;
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_dk_summon_gargoyle::SetDest, EFFECT_0, TARGET_DEST_CASTER_FRONT_LEFT);
    }
};

// 63611 - Improved Blood Presence
class spell_dk_improved_blood_presence_proc : public AuraScript
{
    PrepareAuraScript(spell_dk_improved_blood_presence_proc);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetDamageInfo() && eventInfo.GetDamageInfo()->GetDamage();
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_dk_improved_blood_presence_proc::CheckProc);
    }
};

// 49217 - Wandering Plague
class spell_dk_wandering_plague_aura : public AuraScript
{
    PrepareAuraScript(spell_dk_wandering_plague_aura);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo || !eventInfo.GetActionTarget() || !eventInfo.GetDamageInfo() || !eventInfo.GetActor())
            return false;

        if (!roll_chance_f(eventInfo.GetActor()->GetUnitCriticalChance(BASE_ATTACK, eventInfo.GetActionTarget())))
            return false;

        return !eventInfo.GetActor()->HasSpellCooldown(SPELL_DK_WANDERING_PLAGUE_TRIGGER);
    }

    // xinef: prevent default proc with castItem passed, which applies 30 sec cooldown to procing of the aura
    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        eventInfo.GetActor()->AddSpellCooldown(SPELL_DK_WANDERING_PLAGUE_TRIGGER, 0, 1000);
        eventInfo.GetActor()->CastCustomSpell(SPELL_DK_WANDERING_PLAGUE_TRIGGER, SPELLVALUE_BASE_POINT0, CalculatePct<int32, int32>(eventInfo.GetDamageInfo()->GetDamage(), aurEff->GetAmount()), eventInfo.GetActionTarget(), TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_dk_wandering_plague_aura::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_dk_wandering_plague_aura::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 53365 - Unholy Strength
class spell_dk_rune_of_the_fallen_crusader : public SpellScript
{
    PrepareSpellScript(spell_dk_rune_of_the_fallen_crusader);

    void RecalculateDamage()
    {
        std::list<TargetInfo>* targetsInfo = GetSpell()->GetUniqueTargetInfo();
        for (std::list<TargetInfo>::iterator ihit = targetsInfo->begin(); ihit != targetsInfo->end(); ++ihit)
        {
            if (ihit->targetGUID == GetCaster()->GetGUID())
            {
                //npcbot: get bot's crit
                if (GetCaster()->IsNPCBot())
                    ihit->crit = roll_chance_f(GetCaster()->ToCreature()->GetCreatureCritChance());
                else
                //end npcbot
                ihit->crit = roll_chance_f(GetCaster()->GetFloatValue(PLAYER_CRIT_PERCENTAGE));
            }
        }
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_dk_rune_of_the_fallen_crusader::RecalculateDamage);
    }
};

// 49222 - Bone Shield
class spell_dk_bone_shield : public AuraScript
{
    PrepareAuraScript(spell_dk_bone_shield);

    void HandleProc(ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        if (!eventInfo.GetSpellInfo() || !eventInfo.GetSpellInfo()->IsTargetingArea())
            DropCharge();
    }

    void Register() override
    {
        OnProc += AuraProcFn(spell_dk_bone_shield::HandleProc);
    }
};

// 51209 - Hungering Cold
class spell_dk_hungering_cold : public AuraScript
{
    PrepareAuraScript(spell_dk_hungering_cold);

    void HandleProc(ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        if (eventInfo.GetDamageInfo() && eventInfo.GetDamageInfo()->GetDamage() > 0 && (!eventInfo.GetSpellInfo() || eventInfo.GetSpellInfo()->Dispel != DISPEL_DISEASE))
            SetDuration(0);
    }

    void Register() override
    {
        OnProc += AuraProcFn(spell_dk_hungering_cold::HandleProc);
    }
};

// -49219 - Blood-Caked Blade
class spell_dk_blood_caked_blade : public AuraScript
{
    PrepareAuraScript(spell_dk_blood_caked_blade);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetActionTarget() && eventInfo.GetActionTarget()->IsAlive() && eventInfo.GetActor();
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        eventInfo.GetActor()->CastSpell(eventInfo.GetActionTarget(), aurEff->GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, true, nullptr, aurEff);

        // Xinef: Shadowmourne hack (blood-caked blade trigger proc disabled...)
        if (roll_chance_i(75) && eventInfo.GetActor()->FindMap() && !eventInfo.GetActor()->FindMap()->IsBattlegroundOrArena() && eventInfo.GetActor()->HasAura(71903) && !eventInfo.GetActor()->HasAura(SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF))
        {
            eventInfo.GetActor()->CastSpell(eventInfo.GetActor(), SPELL_SHADOWMOURNE_SOUL_FRAGMENT, true);

            // this can't be handled in AuraScript of SoulFragments because we need to know victim
            if (Aura* soulFragments = eventInfo.GetActor()->GetAura(SPELL_SHADOWMOURNE_SOUL_FRAGMENT))
            {
                if (soulFragments->GetStackAmount() >= 10)
                {
                    eventInfo.GetActor()->CastSpell(eventInfo.GetActor(), SPELL_SHADOWMOURNE_CHAOS_BANE_DAMAGE, true, nullptr);
                    soulFragments->Remove();
                }
            }
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_dk_blood_caked_blade::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_dk_blood_caked_blade::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 49028 - Dancing Rune Weapon
class spell_dk_dancing_rune_weapon : public AuraScript
{
    PrepareAuraScript(spell_dk_dancing_rune_weapon);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (!eventInfo.GetActor() || !eventInfo.GetActionTarget() || !eventInfo.GetActionTarget()->IsAlive() || eventInfo.GetActor()->GetTypeId() != TYPEID_PLAYER)
            return false;

        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo)
            return true;

        // Death Coil exception, Check if spell is from spellbook
        if (spellInfo->Id != SPELL_DK_DEATH_COIL_DAMAGE && !eventInfo.GetActor()->ToPlayer()->HasActiveSpell(spellInfo->Id))
            return false;

        // Can't cast raise dead/ally, death grip, dark command, death pact, death and decay, anti-magic shell
        if (spellInfo->SpellFamilyFlags.HasFlag(0x20A1220, 0x10000000, 0x0))
            return false;

        // AoE can be cast only once
        if (spellInfo->IsTargetingArea() && eventInfo.GetActor() != eventInfo.GetActionTarget())
            return false;

        // No spells with summoning
        if (spellInfo->HasEffect(SPELL_EFFECT_SUMMON))
            return false;

        // No Positive Spells
        if (spellInfo->IsPositive())
            return false;

        return true;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        Unit* player = eventInfo.GetActor();
        Unit* target = eventInfo.GetActionTarget();
        Unit* dancingRuneWeapon = nullptr;
        for (Unit::ControlSet::const_iterator itr = player->m_Controlled.begin(); itr != player->m_Controlled.end(); ++itr)
            if (int32((*itr)->GetEntry()) == GetSpellInfo()->Effects[EFFECT_0].MiscValue)
            {
                dancingRuneWeapon = *itr;
                break;
            }

        if (!dancingRuneWeapon)
            return;

        dancingRuneWeapon->SetOrientation(dancingRuneWeapon->GetAngle(target));
        if (SpellInfo const* procSpell = eventInfo.GetSpellInfo())
        {
            // xinef: ugly hack
            if (!procSpell->IsAffectingArea())
                GetUnitOwner()->SetFloatValue(UNIT_FIELD_COMBATREACH, 10.0f);
            dancingRuneWeapon->CastSpell(target, procSpell->Id, true, nullptr, aurEff, dancingRuneWeapon->GetGUID());
            GetUnitOwner()->SetFloatValue(UNIT_FIELD_COMBATREACH, 0.01f);
        }
        else if (eventInfo.GetDamageInfo())
        {
            target = player->GetMeleeHitRedirectTarget(target);
            CalcDamageInfo damageInfo;
            player->CalculateMeleeDamage(target, &damageInfo, eventInfo.GetDamageInfo()->GetAttackType());
            for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
            {
                Unit::DealDamageMods(target, damageInfo.damages[i].damage, &damageInfo.damages[i].absorb);
                damageInfo.damages[i].damage /= 2.0f;
            }
            damageInfo.attacker = dancingRuneWeapon;
            dancingRuneWeapon->SendAttackStateUpdate(&damageInfo);
            dancingRuneWeapon->DealMeleeDamage(&damageInfo, true);
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_dk_dancing_rune_weapon::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_dk_dancing_rune_weapon::HandleProc, EFFECT_1, SPELL_AURA_DUMMY);
    }
};

// 53160 - Dancing Rune Weapon Visual
class spell_dk_dancing_rune_weapon_visual : public AuraScript
{
    PrepareAuraScript(spell_dk_dancing_rune_weapon_visual);

    void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        PreventDefaultAction();
        if (Unit* owner = GetUnitOwner()->ToTempSummon()->GetSummonerUnit())
        {
            GetUnitOwner()->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, owner->GetUInt32Value(PLAYER_VISIBLE_ITEM_16_ENTRYID));
            GetUnitOwner()->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1, owner->GetUInt32Value(PLAYER_VISIBLE_ITEM_17_ENTRYID));
            GetUnitOwner()->SetFloatValue(UNIT_FIELD_COMBATREACH, 0.01f);
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_dk_dancing_rune_weapon_visual::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// -49004 - Scent of Blood
class spell_dk_scent_of_blood_trigger : public AuraScript
{
    PrepareAuraScript(spell_dk_scent_of_blood_trigger);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return (eventInfo.GetHitMask() & (PROC_EX_DODGE | PROC_EX_PARRY)) || (eventInfo.GetDamageInfo() && eventInfo.GetDamageInfo()->GetDamage());
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_dk_scent_of_blood_trigger::CheckProc);
    }
};

/* 51996 - Death Knight Pet Scaling 02
   54566 - Death Knight Pet Scaling 01
   61697 - Death Knight Pet Scaling 03 */
class spell_dk_pet_scaling : public AuraScript
{
    PrepareAuraScript(spell_dk_pet_scaling);

    void CalculateStatAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
    {
        Stats stat = Stats(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue);

        // xinef: dk ghoul inherits 70% of strength and 30% of stamina
        if (GetUnitOwner()->GetEntry() != NPC_RISEN_GHOUL)
        {
            // xinef: ebon garogyle - inherit 30% of stamina
            if (GetUnitOwner()->GetEntry() == NPC_EBON_GARGOYLE && stat == STAT_STAMINA)
                if (Unit* owner = GetUnitOwner()->GetOwner())
                    amount = CalculatePct(std::max<int32>(0, owner->GetStat(stat)), 30);
            return;
        }

        if (Unit* owner = GetUnitOwner()->GetOwner())
        {
            int32 modifier = stat == STAT_STRENGTH ? 70 : 30;

            // Check just if owner has Ravenous Dead since it's effect is not an aura
            if (AuraEffect const* rdEff = owner->GetAuraEffect(SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, SPELLFAMILY_DEATHKNIGHT, 3010, 0))
            {
                SpellInfo const* spellInfo = rdEff->GetSpellInfo();                                                 // Then get the SpellProto and add the dummy effect value
                AddPct(modifier, spellInfo->Effects[EFFECT_1].CalcValue());                                          // Ravenous Dead edits the original scale
            }

            // xinef: Glyph of the Ghoul
            if (AuraEffect const* glyphEff = owner->GetAuraEffect(SPELL_DK_GLYPH_OF_THE_GHOUL, EFFECT_0))
                modifier += glyphEff->GetAmount();

            amount = CalculatePct(std::max<int32>(0, owner->GetStat(stat)), modifier);
        }
    }

    void CalculateSPAmount(AuraEffect const*  /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        // xinef: dk gargoyle inherits 33% of SP
        if (GetUnitOwner()->GetEntry() != NPC_EBON_GARGOYLE)
            return;

        if (Unit* owner = GetUnitOwner()->GetOwner())
        {
            int32 modifier = 33;

            // xinef: impurity
            if (owner->GetDummyAuraEffect(SPELLFAMILY_DEATHKNIGHT, 1986, 0))
                modifier = 40;

            amount = CalculatePct(std::max<int32>(0, owner->GetTotalAttackPowerValue(BASE_ATTACK)), modifier);

            // xinef: Update appropriate player field
            if (owner->GetTypeId() == TYPEID_PLAYER)
                owner->SetUInt32Value(PLAYER_PET_SPELL_POWER, (uint32)amount);
        }
    }

    void CalculateHasteAmount(AuraEffect const*  /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        // xinef: scale haste with owners melee haste
        if (Unit* owner = GetUnitOwner()->GetOwner())
            if (owner->m_modAttackSpeedPct[BASE_ATTACK] < 1.0f) // inherit haste only
                amount = std::min<int32>(100, int32(((1.0f / owner->m_modAttackSpeedPct[BASE_ATTACK]) - 1.0f) * 100.0f));
    }

    void HandleEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        if (aurEff->GetAuraType() != SPELL_AURA_MELEE_SLOW)
            return;

        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_CASTING_SPEED_NOT_STACK, true, SPELL_BLOCK_TYPE_POSITIVE);
        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_MELEE_RANGED_HASTE, true, SPELL_BLOCK_TYPE_POSITIVE);
        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MELEE_SLOW, true, SPELL_BLOCK_TYPE_POSITIVE);

        if (GetUnitOwner()->IsPet())
            return;

        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_STAT, true, SPELL_BLOCK_TYPE_POSITIVE);
        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, true, SPELL_BLOCK_TYPE_POSITIVE);
        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER, true, SPELL_BLOCK_TYPE_POSITIVE);
        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER_PCT, true, SPELL_BLOCK_TYPE_POSITIVE);
    }

    void CalcPeriodic(AuraEffect const* /*aurEff*/, bool& isPeriodic, int32& amplitude)
    {
        if (!GetUnitOwner()->IsPet())
            return;

        isPeriodic = true;
        amplitude = 2 * IN_MILLISECONDS;
    }

    void HandlePeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (aurEff->GetAuraType() == SPELL_AURA_MOD_STAT && (aurEff->GetMiscValue() == STAT_STAMINA || aurEff->GetMiscValue() == STAT_INTELLECT))
        {
            int32 currentAmount = aurEff->GetAmount();
            int32 newAmount = GetEffect(aurEff->GetEffIndex())->CalculateAmount(GetCaster());
            if (newAmount != currentAmount)
            {
                if (aurEff->GetMiscValue() == STAT_STAMINA)
                {
                    uint32 actStat = GetUnitOwner()->GetHealth();
                    GetEffect(aurEff->GetEffIndex())->ChangeAmount(newAmount, false);
                    GetUnitOwner()->SetHealth(std::min<uint32>(GetUnitOwner()->GetMaxHealth(), actStat));
                }
                else
                {
                    uint32 actStat = GetUnitOwner()->GetPower(POWER_MANA);
                    GetEffect(aurEff->GetEffIndex())->ChangeAmount(newAmount, false);
                    GetUnitOwner()->SetPower(POWER_MANA, std::min<uint32>(GetUnitOwner()->GetMaxPower(POWER_MANA), actStat));
                }
            }
        }
        else
            GetEffect(aurEff->GetEffIndex())->RecalculateAmount();
    }

    void Register() override
    {
        if (m_scriptSpellId == 54566)
        {
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_pet_scaling::CalculateStatAmount, EFFECT_ALL, SPELL_AURA_MOD_STAT);
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_pet_scaling::CalculateSPAmount, EFFECT_ALL, SPELL_AURA_MOD_DAMAGE_DONE);
        }

        if (m_scriptSpellId == 51996)
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_pet_scaling::CalculateHasteAmount, EFFECT_ALL, SPELL_AURA_MELEE_SLOW);

        OnEffectApply += AuraEffectApplyFn(spell_dk_pet_scaling::HandleEffectApply, EFFECT_ALL, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_dk_pet_scaling::CalcPeriodic, EFFECT_ALL, SPELL_AURA_ANY);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_dk_pet_scaling::HandlePeriodic, EFFECT_ALL, SPELL_AURA_ANY);
    }
};

// 50462 - Anti-Magic Zone (on raid member)
class spell_dk_anti_magic_shell_raid : public AuraScript
{
    PrepareAuraScript(spell_dk_anti_magic_shell_raid);

    uint32 absorbPct;

    bool Load() override
    {
        absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
        return true;
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        /// @todo: this should absorb limited amount of damage, but no info on calculation formula
        amount = -1;

        SpellInfo const* talentSpell = sSpellMgr->AssertSpellInfo(SPELL_DK_ANTI_MAGIC_SHELL_TALENT);
        Unit* owner = GetCaster()->GetOwner();
        if (!owner)
            return;

        //npcbot: take bot attack power into account
        if (Creature const* bot = owner->ToCreature())
        {
            if (bot->IsNPCBot())
            {
                amount = talentSpell->GetEffect(EFFECT_0).CalcValue(owner);
                amount += int32(2 * bot->GetTotalAttackPowerValue(BASE_ATTACK));
            }
        }
        //end npcbot
    }

    void Absorb(AuraEffect* /*aurEff*/, DamageInfo& dmgInfo, uint32& absorbAmount)
    {
        absorbAmount = CalculatePct(dmgInfo.GetDamage(), absorbPct);
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_anti_magic_shell_raid::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_dk_anti_magic_shell_raid::Absorb, EFFECT_0);
    }
};

// 48707 - Anti-Magic Shell (on self)
class spell_dk_anti_magic_shell_self : public AuraScript
{
    PrepareAuraScript(spell_dk_anti_magic_shell_self);

    uint32 absorbPct, hpPct;
    bool Load() override
    {
        absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
        hpPct = GetSpellInfo()->Effects[EFFECT_1].CalcValue(GetCaster());
        return true;
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DK_RUNIC_POWER_ENERGIZE });
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        amount = GetCaster()->CountPctFromMaxHealth(hpPct);
    }

    void Absorb(AuraEffect* /*aurEff*/, DamageInfo& dmgInfo, uint32& absorbAmount)
    {
        absorbAmount = std::min(CalculatePct(dmgInfo.GetDamage(), absorbPct), GetTarget()->CountPctFromMaxHealth(hpPct));
    }

    void Trigger(AuraEffect* aurEff, DamageInfo& /*dmgInfo*/, uint32& absorbAmount)
    {
        // damage absorbed by Anti-Magic Shell energizes the DK with additional runic power.
        // This, if I'm not mistaken, shows that we get back ~20% of the absorbed damage as runic power.
        int32 bp = CalculatePct(absorbAmount, 20);
        GetTarget()->CastCustomSpell(SPELL_DK_RUNIC_POWER_ENERGIZE, SPELLVALUE_BASE_POINT0, bp, GetTarget(), true, nullptr, aurEff);
    }

    void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->ApplySpellImmune(GetId(), IMMUNITY_ID, 33786, true); // cyclone
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->ApplySpellImmune(GetId(), IMMUNITY_ID, 33786, false); // cyclone
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_anti_magic_shell_self::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_dk_anti_magic_shell_self::Absorb, EFFECT_0);
        AfterEffectAbsorb += AuraEffectAbsorbFn(spell_dk_anti_magic_shell_self::Trigger, EFFECT_0);

        OnEffectApply += AuraEffectApplyFn(spell_dk_anti_magic_shell_self::HandleEffectApply, EFFECT_1, SPELL_AURA_MOD_IMMUNE_AURA_APPLY_SCHOOL, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_dk_anti_magic_shell_self::HandleEffectRemove, EFFECT_1, SPELL_AURA_MOD_IMMUNE_AURA_APPLY_SCHOOL, AURA_EFFECT_HANDLE_REAL);
    }
};

// 50461 - Anti-Magic Zone
class spell_dk_anti_magic_zone : public AuraScript
{
    PrepareAuraScript(spell_dk_anti_magic_zone);

    uint32 absorbPct;

    bool Load() override
    {
        absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
        return true;
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DK_ANTI_MAGIC_SHELL_TALENT });
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        SpellInfo const* talentSpell = sSpellMgr->AssertSpellInfo(SPELL_DK_ANTI_MAGIC_SHELL_TALENT);

        Unit* owner = GetCaster()->GetOwner();
        if (!owner)
        {
            return;
        }

        amount = talentSpell->Effects[EFFECT_0].CalcValue(owner);
        if (Player* player = owner->ToPlayer())
        {
            amount += int32(2 * player->GetTotalAttackPowerValue(BASE_ATTACK));
        }
    }

    void Absorb(AuraEffect* /*aurEff*/, DamageInfo& dmgInfo, uint32& absorbAmount)
    {
        absorbAmount = CalculatePct(dmgInfo.GetDamage(), absorbPct);
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_anti_magic_zone::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_dk_anti_magic_zone::Absorb, EFFECT_0);
    }
};

// -48721 - Blood Boil
class spell_dk_blood_boil : public SpellScript
{
    PrepareSpellScript(spell_dk_blood_boil);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DK_BLOOD_BOIL_TRIGGERED });
    }

    bool Load() override
    {
        _executed = false;
        return GetCaster()->GetTypeId() == TYPEID_PLAYER && GetCaster()->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY);
    }

    void HandleAfterHit()
    {
        if (_executed || !GetHitUnit())
            return;

        _executed = true;
        GetCaster()->CastSpell(GetCaster(), SPELL_DK_BLOOD_BOIL_TRIGGERED, true);
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_dk_blood_boil::HandleAfterHit);
    }

    bool _executed;
};

// 50453 - Bloodworms Health Leech
class spell_dk_blood_gorged : public AuraScript
{
    PrepareAuraScript(spell_dk_blood_gorged);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DK_BLOOD_GORGED_HEAL });
    }

    bool Load() override
    {
        _procTarget = nullptr;
        return true;
    }

    bool CheckProc(ProcEventInfo& /*eventInfo*/)
    {
        _procTarget = GetTarget()->GetOwner();
        return _procTarget;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        DamageInfo* damageInfo = eventInfo.GetDamageInfo();

        if (!damageInfo || !damageInfo->GetDamage())
        {
            return;
        }

        int32 bp = static_cast<int32>(damageInfo->GetDamage() * 1.5f);
        GetTarget()->CastCustomSpell(SPELL_DK_BLOOD_GORGED_HEAL, SPELLVALUE_BASE_POINT0, bp, _procTarget, true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_dk_blood_gorged::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_dk_blood_gorged::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }

private:
    Unit* _procTarget;
};

class CorpseExplosionCheck
{
public:
    explicit CorpseExplosionCheck(ObjectGuid casterGUID, bool allowGhoul) : _casterGUID(casterGUID), _allowGhoul(allowGhoul) { }

    bool operator()(WorldObject* obj) const
    {
        if (Unit* target = obj->ToUnit())
        {
            if ((target->isDead() || (_allowGhoul && target->GetEntry() == NPC_DK_GHOUL && target->GetOwnerGUID() == _casterGUID))
                    && !(target->GetCreatureTypeMask() & CREATURE_TYPEMASK_MECHANICAL_OR_ELEMENTAL)
                    && target->GetDisplayId() == target->GetNativeDisplayId())
                return false;
        }

        return true;
    }

private:
    ObjectGuid _casterGUID;
    bool _allowGhoul;
};

// -49158 - Corpse Explosion
class spell_dk_corpse_explosion : public SpellScript
{
    PrepareSpellScript(spell_dk_corpse_explosion);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_DK_CORPSE_EXPLOSION_TRIGGERED,
                SPELL_DK_GHOUL_EXPLODE,
                SPELL_DK_CORPSE_EXPLOSION_VISUAL,
            });
    }

    bool Load() override
    {
        _target = nullptr;
        return true;
    }

    void CheckTarget(WorldObject*& target)
    {
        if (CorpseExplosionCheck(GetCaster()->GetGUID(), true)(target))
            target = nullptr;

        _target = target;
    }

    void CheckTargets(std::list<WorldObject*>& targets)
    {
        WorldObject* target = _target;
        if (!target)
        {
            targets.remove_if(CorpseExplosionCheck(GetCaster()->GetGUID(), false));
            if (targets.empty())
            {
                FinishCast(SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW);
                return;
            }
            target = Acore::Containers::SelectRandomContainerElement(targets);
            targets.clear();
            targets.push_back(target);
        }
        else
            targets.clear();
    }

    void HandleDamage(SpellEffIndex effIndex, Unit* target)
    {
        if (effIndex == EFFECT_0)
            GetCaster()->CastCustomSpell(GetSpellInfo()->Effects[EFFECT_1].CalcValue(), SPELLVALUE_BASE_POINT0, GetEffectValue(), target, true);
        else if (effIndex == EFFECT_1)
            GetCaster()->CastCustomSpell(GetEffectValue(), SPELLVALUE_BASE_POINT0, GetSpell()->CalculateSpellDamage(EFFECT_0, nullptr), target, true);
    }

    void HandleCorpseExplosion(SpellEffIndex effIndex)
    {
        if (Unit* unitTarget = GetHitUnit())
        {
            if (unitTarget->IsAlive())  // Living ghoul as a target
            {
                unitTarget->ToCreature()->m_CreatureSpellCooldowns.clear();
                if (CharmInfo* charmInfo = unitTarget->GetCharmInfo())
                    charmInfo->GetGlobalCooldownMgr().CancelGlobalCooldown(sSpellMgr->GetSpellInfo(SPELL_DK_GHOUL_EXPLODE));

                unitTarget->StopMoving();
                unitTarget->CastSpell(unitTarget, SPELL_DK_GHOUL_EXPLODE, false);
                // Corpse Explosion (Suicide) and Set corpse look handled in SpellScript of SPELL_DK_GHOUL_EXPLODE
            }
            else                        // Some corpse
            {
                HandleDamage(effIndex, unitTarget);
                // Corpse Explosion (Suicide)
                unitTarget->CastSpell(unitTarget, SPELL_DK_CORPSE_EXPLOSION_TRIGGERED, true);
                // Set corpse look
                GetCaster()->CastSpell(unitTarget, SPELL_DK_CORPSE_EXPLOSION_VISUAL, true);
            }
        }
    }

    void Register() override
    {
        OnObjectTargetSelect += SpellObjectTargetSelectFn(spell_dk_corpse_explosion::CheckTarget, EFFECT_0, TARGET_UNIT_TARGET_ANY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dk_corpse_explosion::CheckTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_dk_corpse_explosion::HandleCorpseExplosion, EFFECT_0, SPELL_EFFECT_DUMMY);
        OnEffectHitTarget += SpellEffectFn(spell_dk_corpse_explosion::HandleCorpseExplosion, EFFECT_1, SPELL_EFFECT_DUMMY);
    }

private:
    WorldObject* _target;
};

// -62900, -47541, 52375, 59134 - Death Coil
class spell_dk_death_coil : public SpellScript
{
    PrepareSpellScript(spell_dk_death_coil);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_DK_DEATH_COIL_DAMAGE, SPELL_DK_DEATH_COIL_HEAL });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        int32 damage = GetEffectValue();
        Unit* caster = GetCaster();
        if (Unit* target = GetHitUnit())
        {
            if (caster->IsFriendlyTo(target))
            {
                int32 bp = int32(damage * 1.5f);
                caster->CastCustomSpell(target, SPELL_DK_DEATH_COIL_HEAL, &bp, nullptr, nullptr, true);
            }
            else
            {
                if (AuraEffect const* auraEffect = caster->GetAuraEffect(SPELL_DK_ITEM_SIGIL_VENGEFUL_HEART, EFFECT_1))
                    damage += auraEffect->GetBaseAmount();
                caster->CastCustomSpell(target, SPELL_DK_DEATH_COIL_DAMAGE, &damage, nullptr, nullptr, true);
            }
        }
    }

    SpellCastResult CheckCast()
    {
        Unit* caster = GetCaster();
        if (Unit* target = GetExplTargetUnit())
        {
            if (!caster->IsFriendlyTo(target) && !caster->isInFront(target))
                return SPELL_FAILED_UNIT_NOT_INFRONT;

            if (target->IsFriendlyTo(caster) && target->GetCreatureType() != CREATURE_TYPE_UNDEAD)
                return SPELL_FAILED_BAD_TARGETS;
        }
        else
            return SPELL_FAILED_BAD_TARGETS;

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_dk_death_coil::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_dk_death_coil::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 52751 - Death Gate
class spell_dk_death_gate : public SpellScript
{
    PrepareSpellScript(spell_dk_death_gate);

    SpellCastResult CheckClass()
    {
        if (!GetCaster()->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
        {
            SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_MUST_BE_DEATH_KNIGHT);
            return SPELL_FAILED_CUSTOM_ERROR;
        }

        return SPELL_CAST_OK;
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            target->CastSpell(target, GetEffectValue(), false);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_dk_death_gate::CheckClass);
        OnEffectHitTarget += SpellEffectFn(spell_dk_death_gate::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 49560, 49576 - Death Grip
class spell_dk_death_grip : public SpellScript
{
    PrepareSpellScript(spell_dk_death_grip);

    SpellCastResult CheckCast()
    {
        Unit* caster = GetCaster();
        Unit* target = GetExplTargetUnit();

        if (target->GetTypeId() == TYPEID_PLAYER && caster->GetExactDist(target) < 8.0f) // xinef: should be 8.0f, but we have to add target size (1.5f)
            return SPELL_FAILED_TOO_CLOSE;

        if (caster->HasUnitState(UNIT_STATE_JUMPING) || caster->HasUnitMovementFlag(MOVEMENTFLAG_FALLING))
            return SPELL_FAILED_MOVING;

        return SPELL_CAST_OK;
    }

    uint32 EntryCheck(uint32 entry)
    {
        Creature* targetCreature = GetHitCreature();

        switch (targetCreature->GetEntry())
        {
            //Alliance Faction Champions
            case 34461:
            case 34460:
            case 34469:
            case 34467:
            case 34468:
            case 34465:
            case 34471:
            case 34466:
            case 34473:
            case 34472:
            case 34470:
            case 34463:
            case 34474:
            case 34475:

            //Horde Faction Champions
            case 34458:
            case 34451:
            case 34459:
            case 34448:
            case 34449:
            case 34445:
            case 34456:
            case 34447:
            case 34441:
            case 34454:
            case 34444:
            case 34455:
            case 34450:
            case 34453:
                return entry;
                break;
        }
        return 0;
    }

    void HandleBaseDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        Unit* baseTarget = GetExplTargetUnit();
        Creature* targetCreature = GetHitCreature();

        if (caster != target)
        {
            if (targetCreature && (targetCreature->isWorldBoss() || targetCreature->IsDungeonBoss()) && targetCreature->GetEntry() != EntryCheck(targetCreature->GetEntry()))
            {
                return;
            }
            else
            {
                caster->CastSpell(target, 49560, true);
                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(1766); // Rogue kick
                if (!target->IsImmunedToSpellEffect(spellInfo, EFFECT_0))
                    target->InterruptNonMeleeSpells(true);
            }
        }
        else
            baseTarget->CastSpell(caster, 49560, true);
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        float casterZ = GetCaster()->GetPositionZ(); // for Ring of Valor
        WorldLocation gripPos = *GetExplTargetDest();
        if (Unit* target = GetHitUnit())
            if (!target->HasAuraType(SPELL_AURA_DEFLECT_SPELLS) || target->HasUnitState(UNIT_STATE_STUNNED)) // Deterrence
            {
                if (target != GetCaster())
                {
                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(1766); // Rogue kick
                    if (!target->IsImmunedToSpellEffect(spellInfo, EFFECT_0))
                        target->InterruptNonMeleeSpells(false, 0, false);
                }

                if (target->GetMapId() == 618) // for Ring of Valor
                    gripPos.m_positionZ = std::max(casterZ + 0.2f, 28.5f);

                target->CastSpell(gripPos.GetPositionX(), gripPos.GetPositionY(), gripPos.GetPositionZ(), 57604, true);
            }
    }

    void Register() override
    {
        if (m_scriptSpellId == 49576) // xinef: base death grip, add pvp range restriction
        {
            OnCheckCast += SpellCheckCastFn(spell_dk_death_grip::CheckCast);
            OnEffectHitTarget += SpellEffectFn(spell_dk_death_grip::HandleBaseDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
        else
            OnEffectHitTarget += SpellEffectFn(spell_dk_death_grip::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 48743 - Death Pact
class spell_dk_death_pact : public SpellScript
{
    PrepareSpellScript(spell_dk_death_pact);

    SpellCastResult CheckCast()
    {
        // Check if we have valid targets, otherwise skip spell casting here
        if (Player* player = GetCaster()->ToPlayer())
            for (Unit::ControlSet::const_iterator itr = player->m_Controlled.begin(); itr != player->m_Controlled.end(); ++itr)
                if (Creature* undeadPet = (*itr)->ToCreature())
                    if (undeadPet->IsAlive() &&
                            undeadPet->GetOwnerGUID() == player->GetGUID() &&
                            undeadPet->GetCreatureType() == CREATURE_TYPE_UNDEAD &&
                            undeadPet->IsWithinDist(player, 100.0f, false))
                        return SPELL_CAST_OK;

        return SPELL_FAILED_NO_PET;
    }

    void FilterTargets(std::list<WorldObject*>& targetList)
    {
        Unit* target = nullptr;
        for (std::list<WorldObject*>::iterator itr = targetList.begin(); itr != targetList.end(); ++itr)
        {
            if (Unit* unit = (*itr)->ToUnit())
                if (unit->GetOwnerGUID() == GetCaster()->GetGUID() && unit->GetCreatureType() == CREATURE_TYPE_UNDEAD)
                {
                    target = unit;
                    break;
                }
        }

        targetList.clear();
        if (target)
        {
            // xinef: remove all auras preventing effect execution
            target->RemoveAllAurasOnDeath();
            targetList.push_back(target);
        }
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_dk_death_pact::CheckCast);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dk_death_pact::FilterTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ALLY);
    }
};

// -49998 - Death Strike
class spell_dk_death_strike : public SpellScript
{
    PrepareSpellScript(spell_dk_death_strike);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DK_DEATH_STRIKE_HEAL });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (Unit* target = GetHitUnit())
        {
            uint32 count = target->GetDiseasesByCaster(caster->GetGUID());
            int32 bp = int32(count * caster->CountPctFromMaxHealth(int32(GetSpellInfo()->Effects[EFFECT_0].DamageMultiplier)));
            // Improved Death Strike
            if (AuraEffect const* aurEff = caster->GetAuraEffect(SPELL_AURA_ADD_PCT_MODIFIER, SPELLFAMILY_DEATHKNIGHT, DK_ICON_ID_IMPROVED_DEATH_STRIKE, 0))
                AddPct(bp, caster->CalculateSpellDamage(caster, aurEff->GetSpellInfo(), 2));
            caster->CastCustomSpell(caster, SPELL_DK_DEATH_STRIKE_HEAL, &bp, nullptr, nullptr, false);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_dk_death_strike::HandleDummy, EFFECT_2, SPELL_EFFECT_DUMMY);
    }
};

// 47496 - Explode
class spell_dk_ghoul_explode : public SpellScript
{
    PrepareSpellScript(spell_dk_ghoul_explode);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DK_CORPSE_EXPLOSION_TRIGGERED });
    }

    void HandleDamage(SpellEffIndex /*effIndex*/)
    {
        int32 value = int32(GetCaster()->CountPctFromMaxHealth(GetSpellInfo()->Effects[EFFECT_2].CalcValue(GetCaster())));
        SetEffectValue(value);
    }

    void Suicide(SpellEffIndex /*effIndex*/)
    {
        if (Unit* unitTarget = GetHitUnit())
        {
            // Corpse Explosion (Suicide)
            unitTarget->CastSpell(unitTarget, SPELL_DK_CORPSE_EXPLOSION_TRIGGERED, true);
            // Set corpse look
            GetCaster()->CastSpell(unitTarget, SPELL_DK_CORPSE_EXPLOSION_VISUAL, true);
        }
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_dk_ghoul_explode::HandleDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
        OnEffectHitTarget += SpellEffectFn(spell_dk_ghoul_explode::Suicide, EFFECT_1, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

// 47480 - Thrash
class spell_dk_ghoul_thrash : public SpellScript
{
    PrepareSpellScript(spell_dk_ghoul_thrash);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_GHOUL_FRENZY });
    }

    void CalcDamage(SpellEffIndex /*effIndex*/)
    {
        /*
        Causes more damage per frenzy point:
            1 point   : (Attack power * 40 * 0.01 + Attack power * 0.05)-(Attack power * 40 * 0.01 + Attack power * 0.10) damage
            2 points  : (Attack power * 40 * 0.01 + Attack power * 0.10)-(Attack power * 40 * 0.01 + Attack power * 0.20) damage
            3 points  : (Attack power * 40 * 0.01 + Attack power * 0.15)-(Attack power * 40 * 0.01 + Attack power * 0.30) damage
            4 points  : (Attack power * 40 * 0.01 + Attack power * 0.20)-(Attack power * 40 * 0.01 + Attack power * 0.40) damage
            5 points  : (Attack power * 40 * 0.01 + Attack power * 0.25)-(Attack power * 40 * 0.01 + Attack power * 0.50) damage
        */

        if (Aura* frenzy = GetCaster()->GetAura(SPELL_GHOUL_FRENZY))
        {
            float APBonus = GetCaster()->GetTotalAttackPowerValue(BASE_ATTACK);
            float fixedDamageBonus = APBonus * GetEffectValue() * 0.01f;
            APBonus *= 0.05f * frenzy->GetStackAmount();

            SetEffectValue(fixedDamageBonus + urand(int32(APBonus), int32(APBonus * 2.f)));

            if (Unit* caster = GetCaster())
            {
                caster->RemoveAurasDueToSpell(SPELL_GHOUL_FRENZY);

                if (Unit* charmer = caster->GetCharmer())
                {
                    charmer->RemoveAurasDueToSpell(SPELL_GHOUL_FRENZY);
                }
            }
        }
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_dk_ghoul_thrash::CalcDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

// 48792 - Icebound Fortitude
class spell_dk_icebound_fortitude : public AuraScript
{
    PrepareAuraScript(spell_dk_icebound_fortitude);

    bool Load() override
    {
        Unit* caster = GetCaster();
        return caster && caster->GetTypeId() == TYPEID_PLAYER;
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (Unit* caster = GetCaster())
        {
            int32 value = amount;
            uint32 defValue = uint32(caster->ToPlayer()->GetSkillValue(SKILL_DEFENSE) + caster->ToPlayer()->GetRatingBonusValue(CR_DEFENSE_SKILL));

            if (defValue > 400)
                value -= int32((defValue - 400) * 0.15);

            // Glyph of Icebound Fortitude
            if (AuraEffect const* aurEff = caster->GetAuraEffect(SPELL_DK_GLYPH_OF_ICEBOUND_FORTITUDE, EFFECT_0))
            {
                int32 valMax = -aurEff->GetAmount();
                if (value > valMax)
                    value = valMax;
            }
            amount = value;
        }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_icebound_fortitude::CalculateAmount, EFFECT_2, SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN);
    }
};

// -50365 - Improved Blood Presence
class spell_dk_improved_blood_presence : public AuraScript
{
    PrepareAuraScript(spell_dk_improved_blood_presence);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_DK_BLOOD_PRESENCE,
                SPELL_DK_FROST_PRESENCE,
                SPELL_DK_UNHOLY_PRESENCE,
                SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED
            });
    }

    void HandleEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if ((target->HasAura(SPELL_DK_FROST_PRESENCE) || target->HasAura(SPELL_DK_UNHOLY_PRESENCE)) && !target->HasAura(SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED))
            target->CastCustomSpell(SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED, SPELLVALUE_BASE_POINT1, aurEff->GetAmount(), target, true, nullptr, aurEff);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (!target->HasAura(SPELL_DK_BLOOD_PRESENCE))
            target->RemoveAura(SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_dk_improved_blood_presence::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_dk_improved_blood_presence::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// -50384 - Improved Frost Presence
class spell_dk_improved_frost_presence : public AuraScript
{
    PrepareAuraScript(spell_dk_improved_frost_presence);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_DK_BLOOD_PRESENCE,
                SPELL_DK_FROST_PRESENCE,
                SPELL_DK_UNHOLY_PRESENCE,
                SPELL_DK_FROST_PRESENCE_TRIGGERED
            });
    }

    void HandleEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if ((target->HasAura(SPELL_DK_BLOOD_PRESENCE) || target->HasAura(SPELL_DK_UNHOLY_PRESENCE)) && !target->HasAura(SPELL_DK_FROST_PRESENCE_TRIGGERED))
            target->CastCustomSpell(SPELL_DK_FROST_PRESENCE_TRIGGERED, SPELLVALUE_BASE_POINT0, aurEff->GetAmount(), target, true, nullptr, aurEff);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (!target->HasAura(SPELL_DK_FROST_PRESENCE))
            target->RemoveAura(SPELL_DK_FROST_PRESENCE_TRIGGERED);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_dk_improved_frost_presence::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_dk_improved_frost_presence::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// -50391 - Improved Unholy Presence
class spell_dk_improved_unholy_presence : public AuraScript
{
    PrepareAuraScript(spell_dk_improved_unholy_presence);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_DK_BLOOD_PRESENCE,
                SPELL_DK_FROST_PRESENCE,
                SPELL_DK_UNHOLY_PRESENCE,
                SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED,
                SPELL_DK_UNHOLY_PRESENCE_TRIGGERED
            });
    }

    void HandleEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (target->HasAura(SPELL_DK_UNHOLY_PRESENCE) && !target->HasAura(SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED))
        {
            // Not listed as any effect, only base points set in dbc
            int32 basePoints = GetSpellInfo()->Effects[EFFECT_1].CalcValue();
            target->CastCustomSpell(target, SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED, &basePoints, &basePoints, &basePoints, true, nullptr, aurEff);
        }

        if ((target->HasAura(SPELL_DK_BLOOD_PRESENCE) || target->HasAura(SPELL_DK_FROST_PRESENCE)) && !target->HasAura(SPELL_DK_UNHOLY_PRESENCE_TRIGGERED))
            target->CastCustomSpell(SPELL_DK_UNHOLY_PRESENCE_TRIGGERED, SPELLVALUE_BASE_POINT0, aurEff->GetAmount(), target, true, nullptr, aurEff);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();

        target->RemoveAura(SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED);

        if (!target->HasAura(SPELL_DK_UNHOLY_PRESENCE))
            target->RemoveAura(SPELL_DK_UNHOLY_PRESENCE_TRIGGERED);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_dk_improved_unholy_presence::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_dk_improved_unholy_presence::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 50842 - Pestilence
class spell_dk_pestilence : public SpellScript
{
    PrepareSpellScript(spell_dk_pestilence);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        Unit* hitUnit = GetHitUnit();
        Unit* target = GetExplTargetUnit();
        if (!target)
            return;

        if (target != hitUnit || caster->GetAura(SPELL_DK_GLYPH_OF_DISEASE))
        {
            // xinef: checked in target selection
            //if (!m_targets.GetUnitTarget()->IsWithinLOSInMap(unitTarget))
            //  return;

            // And spread them on target
            // Blood Plague
            if (target->GetAura(SPELL_DK_BLOOD_PLAGUE, caster->GetGUID()))
                caster->CastSpell(hitUnit, SPELL_DK_BLOOD_PLAGUE, true);
            // Frost Fever
            if (target->GetAura(SPELL_DK_FROST_FEVER, caster->GetGUID()))
                caster->CastSpell(hitUnit, SPELL_DK_FROST_FEVER, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_dk_pestilence::HandleScriptEffect, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/* 48266 - Blood Presence
   48263 - Frost Presence
   48265 - Unholy Presence */
class spell_dk_presence : public AuraScript
{
    PrepareAuraScript(spell_dk_presence);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_DK_BLOOD_PRESENCE,
                SPELL_DK_FROST_PRESENCE,
                SPELL_DK_UNHOLY_PRESENCE,
                SPELL_DK_IMPROVED_BLOOD_PRESENCE_R1,
                SPELL_DK_IMPROVED_FROST_PRESENCE_R1,
                SPELL_DK_IMPROVED_UNHOLY_PRESENCE_R1,
                SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED,
                SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED,
                SPELL_DK_FROST_PRESENCE_TRIGGERED,
                SPELL_DK_UNHOLY_PRESENCE_TRIGGERED
            });
    }

    void HandleImprovedBloodPresence(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();

        if (GetId() == SPELL_DK_BLOOD_PRESENCE)
            target->CastSpell(target, SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED, true);
        else if (AuraEffect const* impAurEff = target->GetAuraEffectOfRankedSpell(SPELL_DK_IMPROVED_BLOOD_PRESENCE_R1, EFFECT_0))
            if (!target->HasAura(SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED))
                target->CastCustomSpell(SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED, SPELLVALUE_BASE_POINT1, impAurEff->GetAmount(), target, true, nullptr, aurEff);
    }

    void HandleImprovedFrostPresence(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();

        if (GetId() == SPELL_DK_FROST_PRESENCE)
            target->CastSpell(target, SPELL_DK_FROST_PRESENCE_TRIGGERED, true);
        else if (AuraEffect const* impAurEff = target->GetAuraEffectOfRankedSpell(SPELL_DK_IMPROVED_FROST_PRESENCE_R1, EFFECT_0))
            if (!target->HasAura(SPELL_DK_FROST_PRESENCE_TRIGGERED))
                target->CastCustomSpell(SPELL_DK_FROST_PRESENCE_TRIGGERED, SPELLVALUE_BASE_POINT0, impAurEff->GetAmount(), target, true, nullptr, aurEff);
    }

    void HandleImprovedUnholyPresence(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();

        if (GetId() == SPELL_DK_UNHOLY_PRESENCE)
            target->CastSpell(target, SPELL_DK_UNHOLY_PRESENCE_TRIGGERED, true);

        if (AuraEffect const* impAurEff = target->GetAuraEffectOfRankedSpell(SPELL_DK_IMPROVED_UNHOLY_PRESENCE_R1, EFFECT_0))
        {
            if (GetId() == SPELL_DK_UNHOLY_PRESENCE)
            {
                // Not listed as any effect, only base points set
                int32 bp = impAurEff->GetSpellInfo()->Effects[EFFECT_1].CalcValue();
                target->CastCustomSpell(target, SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED, &bp, &bp, &bp, true, nullptr, aurEff);
            }
            else if (!target->HasAura(SPELL_DK_UNHOLY_PRESENCE_TRIGGERED))
                target->CastCustomSpell(SPELL_DK_UNHOLY_PRESENCE_TRIGGERED, SPELLVALUE_BASE_POINT0, impAurEff->GetAmount(), target, true, nullptr, aurEff);
        }
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->RemoveAura(SPELL_DK_IMPROVED_BLOOD_PRESENCE_TRIGGERED);
        target->RemoveAura(SPELL_DK_IMPROVED_UNHOLY_PRESENCE_TRIGGERED);
        target->RemoveAura(SPELL_DK_FROST_PRESENCE_TRIGGERED);
        target->RemoveAura(SPELL_DK_UNHOLY_PRESENCE_TRIGGERED);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_dk_presence::HandleImprovedBloodPresence, EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectApply += AuraEffectApplyFn(spell_dk_presence::HandleImprovedFrostPresence, EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectApply += AuraEffectApplyFn(spell_dk_presence::HandleImprovedUnholyPresence, EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_dk_presence::HandleEffectRemove, EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
    }
};

class RaiseDeadCheck
{
public:
    explicit RaiseDeadCheck(Player const* caster) : _caster(caster) { }

    bool operator()(WorldObject* obj) const
    {
        if (Unit* target = obj->ToUnit())
        {
            if (!target->IsAlive()
                    && _caster->isHonorOrXPTarget(target)
                    && target->GetCreatureType() == CREATURE_TYPE_HUMANOID
                    && target->GetDisplayId() == target->GetNativeDisplayId())
                return false;
        }

        return true;
    }

private:
    Player const* _caster;
};

// 46584 - Raise Dead
class spell_dk_raise_dead : public SpellScript
{
    PrepareSpellScript(spell_dk_raise_dead);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_DK_RAISE_DEAD_USE_REAGENT,
                SPELL_DK_MASTER_OF_GHOULS
            });
    }

    bool Load() override
    {
        _result = SPELL_CAST_OK;
        _corpse = false;
        return GetCaster()->GetTypeId() == TYPEID_PLAYER;
    }

    SpellCastResult CheckCast()
    {
        /// process spell target selection before cast starts
        /// targets of effect_1 are used to check cast
        GetSpell()->SelectSpellTargets();
        /// cleanup spell target map, and fill it again on normal way
        GetSpell()->CleanupTargetList();
        /// _result is set in spell target selection
        return _result;
    }

    SpellCastResult CheckReagents()
    {
        /// @workaround: there is no access to castresult of other spells, check it manually
        SpellInfo const* reagentSpell = sSpellMgr->GetSpellInfo(SPELL_DK_RAISE_DEAD_USE_REAGENT);
        Player* player = GetCaster()->ToPlayer();
        if (!player->CanNoReagentCast(reagentSpell))
        {
            for (uint32 i = 0; i < MAX_SPELL_REAGENTS; i++)
            {
                if (reagentSpell->Reagent[i] <= 0)
                    continue;

                if (!player->HasItemCount(reagentSpell->Reagent[i], reagentSpell->ReagentCount[i]))
                {
                    Spell::SendCastResult(player, reagentSpell, 0, SPELL_FAILED_REAGENTS);
                    return SPELL_FAILED_DONT_REPORT;
                }
            }
        }
        return SPELL_CAST_OK;
    }

    void CheckTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(RaiseDeadCheck(GetCaster()->ToPlayer()));

        if (targets.empty())
        {
            if (GetSpell()->getState() == SPELL_STATE_PREPARING)
                _result = CheckReagents();

            return;
        }

        WorldObject* target = Acore::Containers::SelectRandomContainerElement(targets);
        targets.clear();
        targets.push_back(target);
        _corpse = true;
    }

    void CheckTarget(WorldObject*& target)
    {
        // Don't add caster to target map, if we found a corpse to raise dead
        if (_corpse)
            target = nullptr;
    }

    void ConsumeReagents()
    {
        // No corpse found, take reagents
        if (!_corpse)
            GetCaster()->CastSpell(GetCaster(), SPELL_DK_RAISE_DEAD_USE_REAGENT, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_POWER_AND_REAGENT_COST));
    }

    uint32 GetGhoulSpellId()
    {
        // Do we have talent Master of Ghouls?
        if (GetCaster()->HasAura(SPELL_DK_MASTER_OF_GHOULS))
            // summon as pet
            return GetSpellInfo()->Effects[EFFECT_2].CalcValue();

        // or guardian
        return GetSpellInfo()->Effects[EFFECT_1].CalcValue();
    }

    void HandleRaiseDead(SpellEffIndex /*effIndex*/)
    {
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(GetGhoulSpellId());
        SpellCastTargets targets;
        targets.SetDst(*GetHitUnit());

        GetCaster()->CastSpell(targets, spellInfo, nullptr, TRIGGERED_FULL_MASK, nullptr, nullptr, GetCaster()->GetGUID());
        GetCaster()->ToPlayer()->RemoveSpellCooldown(GetSpellInfo()->Id, true);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_dk_raise_dead::CheckCast);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dk_raise_dead::CheckTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ENTRY);
        OnObjectTargetSelect += SpellObjectTargetSelectFn(spell_dk_raise_dead::CheckTarget, EFFECT_2, TARGET_UNIT_CASTER);
        OnCast += SpellCastFn(spell_dk_raise_dead::ConsumeReagents);
        OnEffectHitTarget += SpellEffectFn(spell_dk_raise_dead::HandleRaiseDead, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
        OnEffectHitTarget += SpellEffectFn(spell_dk_raise_dead::HandleRaiseDead, EFFECT_2, SPELL_EFFECT_DUMMY);
    }

private:
    SpellCastResult _result;
    bool _corpse;
};

// 59754 - Rune Tap
class spell_dk_rune_tap_party : public SpellScript
{
    PrepareSpellScript(spell_dk_rune_tap_party);

    void CheckTargets(std::list<WorldObject*>& targets)
    {
        targets.remove(GetCaster());
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dk_rune_tap_party::CheckTargets, EFFECT_0, TARGET_UNIT_CASTER_AREA_PARTY);
    }
};

// 50421 - Scent of Blood
class spell_dk_scent_of_blood : public AuraScript
{
    PrepareAuraScript(spell_dk_scent_of_blood);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DK_SCENT_OF_BLOOD });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(GetTarget(), SPELL_DK_SCENT_OF_BLOOD, true, nullptr, aurEff);
        GetTarget()->RemoveAuraFromStack(GetSpellInfo()->Id);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_dk_scent_of_blood::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// -55090 - Scourge Strike
class spell_dk_scourge_strike : public SpellScript
{
    PrepareSpellScript(spell_dk_scourge_strike);
    float multiplier;
    ObjectGuid guid;

    bool Load() override
    {
        multiplier = 1.0f;
        guid.Clear();
        return true;
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DK_SCOURGE_STRIKE_TRIGGERED });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (Unit* unitTarget = GetHitUnit())
        {
            uint8 mode = caster->GetAuraEffectDummy(SPELL_DK_GLYPH_OF_SCOURGE_STRIKE) ? 2 : 0;
            float disease_amt = GetEffectValue();

            // Death Knight T8 Melee 4P Bonus
            if (AuraEffect const* aurEff = caster->GetAuraEffect(SPELL_DK_ITEM_T8_MELEE_4P_BONUS, EFFECT_0))
                AddPct(disease_amt, aurEff->GetAmount());

            multiplier = disease_amt * unitTarget->GetDiseasesByCaster(caster->GetGUID(), mode) / 100.0f;
            guid = unitTarget->GetGUID();
        }
    }

    void HandleAfterHit()
    {
        Unit* caster = GetCaster();
        if (Unit* unitTarget = ObjectAccessor::GetUnit(*caster, guid))
        {
            int32 bp = GetHitDamage() * multiplier;
            caster->CastCustomSpell(unitTarget, SPELL_DK_SCOURGE_STRIKE_TRIGGERED, &bp, nullptr, nullptr, true);

            // Xinef: Shadowmourne hack (scourge strike trigger proc disabled...)
            if (roll_chance_i(75) && caster->FindMap() && !caster->FindMap()->IsBattlegroundOrArena() && caster->HasAura(71903) && !caster->HasAura(SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF))
            {
                caster->CastSpell(caster, SPELL_SHADOWMOURNE_SOUL_FRAGMENT, true);

                // this can't be handled in AuraScript of SoulFragments because we need to know victim
                if (Aura* soulFragments = caster->GetAura(SPELL_SHADOWMOURNE_SOUL_FRAGMENT))
                {
                    if (soulFragments->GetStackAmount() >= 10)
                    {
                        caster->CastSpell(caster, SPELL_SHADOWMOURNE_CHAOS_BANE_DAMAGE, true, nullptr);
                        soulFragments->Remove();
                    }
                }
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_dk_scourge_strike::HandleDummy, EFFECT_2, SPELL_EFFECT_DUMMY);
        AfterHit += SpellHitFn(spell_dk_scourge_strike::HandleAfterHit);
    }
};

// -49145 - Spell Deflection
class spell_dk_spell_deflection : public AuraScript
{
    PrepareAuraScript(spell_dk_spell_deflection);

    uint32 absorbPct;

    bool Load() override
    {
        absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
        return true;
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        // Set absorbtion amount to unlimited
        amount = -1;
    }

    void Absorb(AuraEffect* /*aurEff*/, DamageInfo& dmgInfo, uint32& absorbAmount)
    {
        // You have a chance equal to your Parry chance
        float chance = GetTarget()->GetUnitParryChance();
        if (GetTarget()->IsNonMeleeSpellCast(false, false, true) || GetTarget()->HasUnitState(UNIT_STATE_CONTROLLED))
            chance = 0.0f;

        //npcbot handle creature case (and prevent crashes)
        Unit* target = GetTarget();
        if (target->GetTypeId() == TYPEID_UNIT)
        {
            if (dmgInfo.GetDamageType() == SPELL_DIRECT_DAMAGE &&
                roll_chance_f(target->ToCreature()->GetCreatureParryChance()))
                absorbAmount = CalculatePct(dmgInfo.GetDamage(), absorbPct);
        }
        else
        //end npcbot
        if ((dmgInfo.GetDamageType() == SPELL_DIRECT_DAMAGE) && roll_chance_f(chance))
            absorbAmount = CalculatePct(dmgInfo.GetDamage(), absorbPct);
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_spell_deflection::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_dk_spell_deflection::Absorb, EFFECT_0);
    }
};

// 55233 - Vampiric Blood
class spell_dk_vampiric_blood : public AuraScript
{
    PrepareAuraScript(spell_dk_vampiric_blood);

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        amount = GetUnitOwner()->CountPctFromMaxHealth(amount);
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_vampiric_blood::CalculateAmount, EFFECT_1, SPELL_AURA_MOD_INCREASE_HEALTH);
    }
};

// 52284 - Will of the Necropolis
class spell_dk_will_of_the_necropolis : public AuraScript
{
    PrepareAuraScript(spell_dk_will_of_the_necropolis);

    bool Validate(SpellInfo const* spellInfo) override
    {
        SpellInfo const* firstRankSpellInfo = sSpellMgr->GetSpellInfo(SPELL_DK_WILL_OF_THE_NECROPOLIS_AURA_R1);
        if (!firstRankSpellInfo)
            return false;

        // can't use other spell than will of the necropolis due to spell_ranks dependency
        if (!spellInfo->IsRankOf(firstRankSpellInfo))
            return false;

        uint8 rank = spellInfo->GetRank();
        if (!sSpellMgr->GetSpellWithRank(SPELL_DK_WILL_OF_THE_NECROPOLIS_TALENT_R1, rank, true))
            return false;

        return true;
    }

    uint32 absorbPct;

    bool Load() override
    {
        absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
        return true;
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        // Set absorbtion amount to unlimited
        amount = -1;
    }

    void Absorb(AuraEffect* /*aurEff*/, DamageInfo& dmgInfo, uint32& absorbAmount)
    {
        // min pct of hp is stored in effect 0 of talent spell
        uint8 rank = GetSpellInfo()->GetRank();
        SpellInfo const* talentProto = sSpellMgr->AssertSpellInfo(sSpellMgr->GetSpellWithRank(SPELL_DK_WILL_OF_THE_NECROPOLIS_TALENT_R1, rank));

        int32 remainingHp = int32(GetTarget()->GetHealth() - dmgInfo.GetDamage());
        int32 minHp = int32(GetTarget()->CountPctFromMaxHealth(talentProto->Effects[EFFECT_0].CalcValue(GetCaster())));

        // Damage that would take you below [effect0] health or taken while you are at [effect0]
        if (remainingHp < minHp)
            absorbAmount = CalculatePct(dmgInfo.GetDamage(), absorbPct);
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_will_of_the_necropolis::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_dk_will_of_the_necropolis::Absorb, EFFECT_0);
    }
};

void AddSC_deathknight_spell_scripts()
{
    RegisterSpellScript(spell_dk_wandering_plague);
    RegisterSpellScript(spell_dk_raise_ally);
    RegisterSpellScript(spell_dk_raise_ally_trigger);
    RegisterSpellScript(spell_dk_aotd_taunt);
    RegisterSpellAndAuraScriptPair(spell_dk_death_and_decay, spell_dk_death_and_decay_aura);
    RegisterSpellScript(spell_dk_master_of_ghouls);
    RegisterSpellAndAuraScriptPair(spell_dk_chains_of_ice, spell_dk_chains_of_ice_aura);
    RegisterSpellScript(spell_dk_bloodworms);
    RegisterSpellScript(spell_dk_summon_gargoyle);
    RegisterSpellScript(spell_dk_improved_blood_presence_proc);
    RegisterSpellScript(spell_dk_wandering_plague_aura);
    RegisterSpellScript(spell_dk_rune_of_the_fallen_crusader);
    RegisterSpellScript(spell_dk_bone_shield);
    RegisterSpellScript(spell_dk_hungering_cold);
    RegisterSpellScript(spell_dk_blood_caked_blade);
    RegisterSpellScript(spell_dk_dancing_rune_weapon);
    RegisterSpellScript(spell_dk_dancing_rune_weapon_visual);
    RegisterSpellScript(spell_dk_scent_of_blood_trigger);
    RegisterSpellScript(spell_dk_pet_scaling);
    RegisterSpellScript(spell_dk_anti_magic_shell_raid);
    RegisterSpellScript(spell_dk_anti_magic_shell_self);
    RegisterSpellScript(spell_dk_anti_magic_zone);
    RegisterSpellScript(spell_dk_blood_boil);
    RegisterSpellScript(spell_dk_blood_gorged);
    RegisterSpellScript(spell_dk_corpse_explosion);
    RegisterSpellScript(spell_dk_death_coil);
    RegisterSpellScript(spell_dk_death_gate);
    RegisterSpellScript(spell_dk_death_grip);
    RegisterSpellScript(spell_dk_death_pact);
    RegisterSpellScript(spell_dk_death_strike);
    RegisterSpellScript(spell_dk_ghoul_explode);
    RegisterSpellScript(spell_dk_icebound_fortitude);
    RegisterSpellScript(spell_dk_improved_blood_presence);
    RegisterSpellScript(spell_dk_improved_frost_presence);
    RegisterSpellScript(spell_dk_improved_unholy_presence);
    RegisterSpellScript(spell_dk_pestilence);
    RegisterSpellScript(spell_dk_presence);
    RegisterSpellScript(spell_dk_raise_dead);
    RegisterSpellScript(spell_dk_rune_tap_party);
    RegisterSpellScript(spell_dk_scent_of_blood);
    RegisterSpellScript(spell_dk_scourge_strike);
    RegisterSpellScript(spell_dk_spell_deflection);
    RegisterSpellScript(spell_dk_vampiric_blood);
    RegisterSpellScript(spell_dk_will_of_the_necropolis);
    RegisterSpellScript(spell_dk_ghoul_thrash);
}

