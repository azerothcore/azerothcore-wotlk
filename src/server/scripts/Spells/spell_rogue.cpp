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

#include "CellImpl.h"
#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
/*
 * Scripts for spells with SPELLFAMILY_ROGUE and SPELLFAMILY_GENERIC spells used by rogue players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_rog_".
 */

//npcbot
#include "Creature.h"
//end npcbot

enum RogueSpells
{
    SPELL_ROGUE_BLADE_FLURRY_EXTRA_ATTACK       = 22482,
    SPELL_ROGUE_CHEAT_DEATH_COOLDOWN            = 31231,
    SPELL_ROGUE_CHEATING_DEATH                  = 45182,
    SPELL_ROGUE_GLYPH_OF_PREPARATION            = 56819,
    SPELL_ROGUE_KILLING_SPREE                   = 51690,
    SPELL_ROGUE_KILLING_SPREE_TELEPORT          = 57840,
    SPELL_ROGUE_KILLING_SPREE_WEAPON_DMG        = 57841,
    SPELL_ROGUE_KILLING_SPREE_DMG_BUFF          = 61851,
    SPELL_ROGUE_PREY_ON_THE_WEAK                = 58670,
    SPELL_ROGUE_SHIV_TRIGGERED                  = 5940,
    SPELL_ROGUE_TRICKS_OF_THE_TRADE_DMG_BOOST   = 57933,
    SPELL_ROGUE_TRICKS_OF_THE_TRADE_PROC        = 59628,
};

class spell_rog_savage_combat : public AuraScript
{
    PrepareAuraScript(spell_rog_savage_combat);

    void CalcPeriodic(AuraEffect const* /*effect*/, bool& isPeriodic, int32& amplitude)
    {
        isPeriodic = true;
        amplitude = 1000;
    }

    void Update(AuraEffect*  /*auraEffect*/)
    {
        Unit::AuraApplicationMap const& auras = GetUnitOwner()->GetAppliedAuras();
        for (Unit::AuraApplicationMap::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
            if (itr->second->GetBase()->GetCasterGUID() == this->GetCasterGUID() && itr->second->GetBase()->GetSpellInfo()->Dispel == DISPEL_POISON)
                return;

        SetDuration(0);
    }

    void Register() override
    {
        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_rog_savage_combat::CalcPeriodic, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN);
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_rog_savage_combat::Update, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN);
    }
};

class spell_rog_combat_potency : public AuraScript
{
    PrepareAuraScript(spell_rog_combat_potency);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetTypeMask() & PROC_FLAG_DONE_MELEE_AUTO_ATTACK;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_rog_combat_potency::CheckProc);
    }
};

// 13877, 33735, (check 51211, 65956) - Blade Flurry
class spell_rog_blade_flurry : public AuraScript
{
    PrepareAuraScript(spell_rog_blade_flurry);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ROGUE_BLADE_FLURRY_EXTRA_ATTACK });
    }

    bool Load() override
    {
        _procTargetGUID.Clear();
        return true;
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (!eventInfo.GetActor())
            return false;

        Unit* _procTarget = eventInfo.GetActor()->SelectNearbyNoTotemTarget(eventInfo.GetProcTarget());
        if (_procTarget)
            _procTargetGUID = _procTarget->GetGUID();
        return _procTarget;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        // Xinef: no _procTarget but checkproc passed??
        // Unit::CalculateAOEDamageReduction (this=0x0, damage=4118, schoolMask=1, caster=0x7ffdad089000)
        Unit* procTarget = ObjectAccessor::GetUnit(*GetTarget(), _procTargetGUID);
        DamageInfo* damageInfo = eventInfo.GetDamageInfo();
        if (procTarget && damageInfo)
        {
            int32 damage = damageInfo->GetUnmitigatedDamage();

            CustomSpellValues values;
            values.AddSpellMod(SPELLVALUE_BASE_POINT0, damage);
            values.AddSpellMod(SPELLVALUE_FORCED_CRIT_RESULT, int32(eventInfo.GetHitMask() & PROC_EX_CRITICAL_HIT));
            GetTarget()->CastCustomSpell(SPELL_ROGUE_BLADE_FLURRY_EXTRA_ATTACK, values, procTarget, TRIGGERED_FULL_MASK, nullptr, aurEff);
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_rog_blade_flurry::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_rog_blade_flurry::HandleProc, EFFECT_0, SPELL_AURA_MOD_MELEE_HASTE);
    }

private:
    ObjectGuid _procTargetGUID;
};

// -31228 - Cheat Death
class spell_rog_cheat_death : public AuraScript
{
    PrepareAuraScript(spell_rog_cheat_death);

    uint32 absorbChance;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ROGUE_CHEAT_DEATH_COOLDOWN, SPELL_ROGUE_CHEATING_DEATH });
    }

    bool Load() override
    {
        absorbChance = GetSpellInfo()->Effects[EFFECT_0].CalcValue();
        //npcbot
        if (GetUnitOwner()->IsNPCBot())
            return true;
        //end npcbot
        return GetUnitOwner()->ToPlayer();
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        // Set absorbtion amount to unlimited
        amount = -1;
    }

    void Absorb(AuraEffect* /*aurEff*/, DamageInfo& dmgInfo, uint32& absorbAmount)
    {
        //npcbot
        if (Creature* bot = GetTarget()->ToCreature())
        {
            if (dmgInfo.GetDamage() < bot->GetHealth() || bot->HasSpellCooldown(SPELL_ROGUE_CHEAT_DEATH_COOLDOWN) ||
                bot->HasSpellCooldown(SPELL_ROGUE_CHEAT_DEATH_COOLDOWN) || !roll_chance_i(absorbChance))
                return;

            bot->CastSpell(bot, SPELL_ROGUE_CHEAT_DEATH_COOLDOWN, true);
            bot->AddBotSpellCooldown(SPELL_ROGUE_CHEAT_DEATH_COOLDOWN, MINUTE * IN_MILLISECONDS);

            uint32 health10 = bot->CountPctFromMaxHealth(10);

            if (bot->GetHealth() > health10)
                absorbAmount = dmgInfo.GetDamage() - bot->GetHealth() + health10;
            else
                absorbAmount = dmgInfo.GetDamage();

            return;
        }
        //end npcbot

        Player* target = GetTarget()->ToPlayer();
        if (dmgInfo.GetDamage() < target->GetHealth() || target->HasSpellCooldown(SPELL_ROGUE_CHEAT_DEATH_COOLDOWN) || !roll_chance_i(absorbChance))
            return;

        target->CastSpell(target, SPELL_ROGUE_CHEAT_DEATH_COOLDOWN, true);
        target->CastSpell(target, SPELL_ROGUE_CHEATING_DEATH, true);
        target->AddSpellCooldown(SPELL_ROGUE_CHEAT_DEATH_COOLDOWN, 0, MINUTE * IN_MILLISECONDS);

        uint32 health10 = target->CountPctFromMaxHealth(10);

        // hp > 10% - absorb hp till 10%
        if (target->GetHealth() > health10)
            absorbAmount = dmgInfo.GetDamage() - target->GetHealth() + health10;
        // hp lower than 10% - absorb everything
        else
            absorbAmount = dmgInfo.GetDamage();
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_rog_cheat_death::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_rog_cheat_death::Absorb, EFFECT_0);
    }
};

// -2818 - Deadly Poison
class spell_rog_deadly_poison : public SpellScript
{
    PrepareSpellScript(spell_rog_deadly_poison);

    bool Load() override
    {
        _stackAmount = 0;
        // at this point CastItem must already be initialized
        return GetCaster()->GetTypeId() == TYPEID_PLAYER && GetCastItem();
    }

    void HandleBeforeHit(SpellMissInfo missInfo)
    {
        if (missInfo != SPELL_MISS_NONE)
        {
            return;
        }

        if (Unit* target = GetHitUnit())
            // Deadly Poison
            if (AuraEffect const* aurEff = target->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_ROGUE, 0x10000, 0x80000, 0, GetCaster()->GetGUID()))
                _stackAmount = aurEff->GetBase()->GetStackAmount();
    }

    void HandleAfterHit()
    {
        if (_stackAmount < 5)
            return;

        Player* player = GetCaster()->ToPlayer();

        if (Unit* target = GetHitUnit())
        {
            Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);

            if (item == GetCastItem())
                item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);

            if (!item)
                return;

            // item combat enchantments
            for (uint8 slot = 0; slot < MAX_ENCHANTMENT_SLOT; ++slot)
            {
                SpellItemEnchantmentEntry const* enchant = sSpellItemEnchantmentStore.LookupEntry(item->GetEnchantmentId(EnchantmentSlot(slot)));
                if (!enchant)
                    continue;

                for (uint8 s = 0; s < 3; ++s)
                {
                    if (enchant->type[s] != ITEM_ENCHANTMENT_TYPE_COMBAT_SPELL)
                        continue;

                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(enchant->spellid[s]);
                    if (!spellInfo)
                    {
                        LOG_ERROR("misc", "Player::CastItemCombatSpell Enchant {}, player (Name: {}, {}) cast unknown spell {}",
                            enchant->ID, player->GetName(), player->GetGUID().ToString(), enchant->spellid[s]);
                        continue;
                    }

                    // Proc only rogue poisons
                    if (spellInfo->SpellFamilyName != SPELLFAMILY_ROGUE || spellInfo->Dispel != DISPEL_POISON)
                        continue;

                    // Do not reproc deadly
                    if (spellInfo->SpellFamilyFlags.IsEqual(0x10000, 0x80000, 0))
                        continue;

                    if (spellInfo->IsPositive())
                        player->CastSpell(player, enchant->spellid[s], true, item);
                    else
                        player->CastSpell(target, enchant->spellid[s], true, item);
                }
            }
        }
    }

    void Register() override
    {
        BeforeHit += BeforeSpellHitFn(spell_rog_deadly_poison::HandleBeforeHit);
        AfterHit += SpellHitFn(spell_rog_deadly_poison::HandleAfterHit);
    }

    uint8 _stackAmount;
};

// 51690 - Killing Spree
class spell_rog_killing_spree_aura : public AuraScript
{
    PrepareAuraScript(spell_rog_killing_spree_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_ROGUE_KILLING_SPREE_TELEPORT,
                SPELL_ROGUE_KILLING_SPREE_WEAPON_DMG,
                SPELL_ROGUE_KILLING_SPREE_DMG_BUFF
            });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->CastSpell(GetTarget(), SPELL_ROGUE_KILLING_SPREE_DMG_BUFF, true);
    }

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        while (!_targets.empty())
        {
            ObjectGuid guid = Acore::Containers::SelectRandomContainerElement(_targets);
            if (Unit* target = ObjectAccessor::GetUnit(*GetTarget(), guid))
            {
                // xinef: target may be no longer valid
                if (!GetTarget()->IsValidAttackTarget(target) || target->HasStealthAura() || target->HasInvisibilityAura())
                {
                    _targets.remove(guid);
                    continue;
                }

                GetTarget()->CastSpell(target, SPELL_ROGUE_KILLING_SPREE_TELEPORT, true);

                    //npcbot: prevent crash from trying to access player fields
                    if (GetTarget()->GetTypeId() == TYPEID_PLAYER)
                    {
                    //end npcbot
                // xinef: ensure fast coordinates switch, dont wait for client to send opcode
                WorldLocation const& dest = GetTarget()->ToPlayer()->GetTeleportDest();
                GetTarget()->ToPlayer()->UpdatePosition(dest, true);
                    //npcbot
                    }
                    //end npcbot

                GetTarget()->CastSpell(target, SPELL_ROGUE_KILLING_SPREE_WEAPON_DMG, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_DONT_REPORT_CAST_ERROR));
                break;
            }
            else
                _targets.remove(guid);
        }
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(SPELL_ROGUE_KILLING_SPREE_DMG_BUFF);
    }

public:
    void AddTarget(Unit* target)
    {
        _targets.push_back(target->GetGUID());
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_rog_killing_spree_aura::HandleApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_rog_killing_spree_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        AfterEffectRemove += AuraEffectRemoveFn(spell_rog_killing_spree_aura::HandleRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }

private:
    GuidList _targets;
};

#define KillingSpreeScriptName "spell_rog_killing_spree"
typedef spell_rog_killing_spree_aura spell_rog_killing_spree_aura_script;
class spell_rog_killing_spree : public SpellScript
{
    PrepareSpellScript(spell_rog_killing_spree);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ROGUE_KILLING_SPREE });
    }

    SpellCastResult CheckCast()
    {
        // Kologarn area, Killing Spree should not work
        if (GetCaster()->GetMapId() == 603 /*Ulduar*/ && GetCaster()->GetDistance2d(1766.936f, -24.748f) < 50.0f)
            return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;
        return SPELL_CAST_OK;
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (targets.empty() || GetCaster()->GetVehicleBase() || GetCaster()->HasUnitState(UNIT_STATE_ROOT))
            FinishCast(SPELL_FAILED_OUT_OF_RANGE);
        else
        {
            // Added attribute not breaking stealth, removes auras here
            GetCaster()->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_CAST);
            GetCaster()->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_SPELL_ATTACK);
        }
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Aura* aura = GetCaster()->GetAura(SPELL_ROGUE_KILLING_SPREE))
        {
            if (spell_rog_killing_spree_aura* script = dynamic_cast<spell_rog_killing_spree_aura_script*>(aura->GetScriptByName(KillingSpreeScriptName)))
                script->AddTarget(GetHitUnit());
        }
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_rog_killing_spree::CheckCast);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_rog_killing_spree::FilterTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_rog_killing_spree::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
    }
};

// -31130 - Nerves of Steel
class spell_rog_nerves_of_steel : public AuraScript
{
    PrepareAuraScript(spell_rog_nerves_of_steel);

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
        // reduces all damage taken while stun or fear
        if (GetTarget()->GetUnitFlags() & (UNIT_FLAG_FLEEING) || (GetTarget()->GetUnitFlags() & (UNIT_FLAG_STUNNED) && GetTarget()->HasAuraWithMechanic(1 << MECHANIC_STUN)))
            absorbAmount = CalculatePct(dmgInfo.GetDamage(), absorbPct);
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_rog_nerves_of_steel::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_rog_nerves_of_steel::Absorb, EFFECT_0);
    }
};

// 14185 - Preparation
class spell_rog_preparation : public SpellScript
{
    PrepareSpellScript(spell_rog_preparation);

    bool Load() override
    {
        return GetCaster()->GetTypeId() == TYPEID_PLAYER;
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ROGUE_GLYPH_OF_PREPARATION });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Player* caster = GetCaster()->ToPlayer();
        //immediately finishes the cooldown on certain Rogue abilities

        bool hasGlyph = caster->HasAura(SPELL_ROGUE_GLYPH_OF_PREPARATION);
        PlayerSpellMap const& spellMap = caster->GetSpellMap();
        for (PlayerSpellMap::const_iterator itr = spellMap.begin(); itr != spellMap.end(); ++itr)
        {
            SpellInfo const* spellInfo = sSpellMgr->AssertSpellInfo(itr->first);
            if (spellInfo->SpellFamilyName == SPELLFAMILY_ROGUE)
            {
                if (spellInfo->SpellFamilyFlags[1] & SPELLFAMILYFLAG1_ROGUE_COLDB_SHADOWSTEP ||      // Cold Blood, Shadowstep
                        spellInfo->SpellFamilyFlags[0] & SPELLFAMILYFLAG_ROGUE_VAN_EVAS_SPRINT)           // Vanish, Evasion, Sprint
                {
                    SpellCooldowns::iterator citr = caster->GetSpellCooldownMap().find(spellInfo->Id);
                    if (citr != caster->GetSpellCooldownMap().end() && citr->second.needSendToClient)
                        caster->RemoveSpellCooldown(spellInfo->Id, true);
                    else
                        caster->RemoveSpellCooldown(spellInfo->Id, false);
                }
                else if (hasGlyph)
                {
                    if (spellInfo->SpellFamilyFlags[1] & SPELLFAMILYFLAG1_ROGUE_DISMANTLE ||         // Dismantle
                            spellInfo->SpellFamilyFlags[0] & SPELLFAMILYFLAG_ROGUE_KICK ||               // Kick
                            (spellInfo->SpellFamilyFlags[0] & SPELLFAMILYFLAG_ROGUE_BLADE_FLURRY &&     // Blade Flurry
                                spellInfo->SpellFamilyFlags[1] & SPELLFAMILYFLAG1_ROGUE_BLADE_FLURRY))
                    {
                        SpellCooldowns::iterator citr = caster->GetSpellCooldownMap().find(spellInfo->Id);
                        if (citr != caster->GetSpellCooldownMap().end() && citr->second.needSendToClient)
                            caster->RemoveSpellCooldown(spellInfo->Id, true);
                        else
                            caster->RemoveSpellCooldown(spellInfo->Id, false);
                    }
                }
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_rog_preparation::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// -51685 - Prey on the Weak
class spell_rog_prey_on_the_weak : public AuraScript
{
    PrepareAuraScript(spell_rog_prey_on_the_weak);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ROGUE_PREY_ON_THE_WEAK });
    }

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        Unit* target = GetTarget();
        Unit* victim = target->GetVictim();
        if (!victim && target->GetTypeId() == TYPEID_PLAYER)
            victim = target->ToPlayer()->GetSelectedUnit();

        if (victim && (target->GetHealthPct() > victim->GetHealthPct()))
        {
            if (!target->HasAura(SPELL_ROGUE_PREY_ON_THE_WEAK))
            {
                int32 bp = GetSpellInfo()->Effects[EFFECT_0].CalcValue();
                target->CastCustomSpell(target, SPELL_ROGUE_PREY_ON_THE_WEAK, &bp, 0, 0, true);
            }
        }
        else
            target->RemoveAurasDueToSpell(SPELL_ROGUE_PREY_ON_THE_WEAK);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_rog_prey_on_the_weak::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// -1943 - Rupture
class spell_rog_rupture : public AuraScript
{
    PrepareAuraScript(spell_rog_rupture);

    bool Load() override
    {
        Unit* caster = GetCaster();
        //npcbot
        if (caster && caster->IsNPCBot())
            return true;
        //end npcbot
        return caster && caster->GetTypeId() == TYPEID_PLAYER;
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& canBeRecalculated)
    {
        if (Unit* caster = GetCaster())
        {
            canBeRecalculated = false;

            float const attackpowerPerCombo[6] =
            {
                0.0f,
                0.015f,         // 1 point:  ${($m1 + $b1*1 + 0.015 * $AP) * 4} damage over 8 secs
                0.024f,         // 2 points: ${($m1 + $b1*2 + 0.024 * $AP) * 5} damage over 10 secs
                0.03f,          // 3 points: ${($m1 + $b1*3 + 0.03 * $AP) * 6} damage over 12 secs
                0.03428571f,    // 4 points: ${($m1 + $b1*4 + 0.03428571 * $AP) * 7} damage over 14 secs
                0.0375f         // 5 points: ${($m1 + $b1*5 + 0.0375 * $AP) * 8} damage over 16 secs
            };

            //npcbot
            if (caster->GetTypeId() == TYPEID_UNIT)
            {
                uint8 cp = caster->ToCreature()->GetCreatureComboPoints();
                if (cp > 5)
                    cp = 5;

                amount += int32(caster->GetTotalAttackPowerValue(BASE_ATTACK) * attackpowerPerCombo[cp]);
                return;
            }
            //end npcbot

            uint8 cp = caster->ToPlayer()->GetComboPoints();
            if (cp > 5)
                cp = 5;

            amount += int32(caster->GetTotalAttackPowerValue(BASE_ATTACK) * attackpowerPerCombo[cp]);
        }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_rog_rupture::CalculateAmount, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

// 5938 - Shiv
class spell_rog_shiv : public SpellScript
{
    PrepareSpellScript(spell_rog_shiv);

    bool Load() override
    {
        return GetCaster()->GetTypeId() == TYPEID_PLAYER;
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ROGUE_SHIV_TRIGGERED });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (Unit* unitTarget = GetHitUnit())
            caster->CastSpell(unitTarget, SPELL_ROGUE_SHIV_TRIGGERED, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_rog_shiv::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 57934 - Tricks of the Trade
class spell_rog_tricks_of_the_trade : public AuraScript
{
    PrepareAuraScript(spell_rog_tricks_of_the_trade);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ROGUE_TRICKS_OF_THE_TRADE_DMG_BOOST, SPELL_ROGUE_TRICKS_OF_THE_TRADE_PROC });
    }

    bool Load() override
    {
        _redirectTarget = nullptr;
        return true;
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_DEFAULT)
            GetTarget()->ResetRedirectThreat();
    }

    bool CheckProc(ProcEventInfo& /*eventInfo*/)
    {
        _redirectTarget = GetTarget()->GetRedirectThreatTarget();
        return _redirectTarget;
    }

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();

        Unit* target = GetTarget();
        target->CastSpell(_redirectTarget, SPELL_ROGUE_TRICKS_OF_THE_TRADE_DMG_BOOST, true);
        target->CastSpell(target, SPELL_ROGUE_TRICKS_OF_THE_TRADE_PROC, true);
        Remove(AURA_REMOVE_BY_DEFAULT); // maybe handle by proc charges
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_rog_tricks_of_the_trade::OnRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        DoCheckProc += AuraCheckProcFn(spell_rog_tricks_of_the_trade::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_rog_tricks_of_the_trade::HandleProc, EFFECT_1, SPELL_AURA_DUMMY);
    }

private:
    Unit* _redirectTarget;
};

// 59628 - Tricks of the Trade (Proc)
class spell_rog_tricks_of_the_trade_proc : public AuraScript
{
    PrepareAuraScript(spell_rog_tricks_of_the_trade_proc);

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->ResetRedirectThreat();
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_rog_tricks_of_the_trade_proc::HandleRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_rog_pickpocket : public SpellScript
{
    PrepareSpellScript(spell_rog_pickpocket);

    SpellCastResult CheckCast()
    {
        if (!GetExplTargetUnit() || !GetCaster()->IsValidAttackTarget(GetExplTargetUnit(), GetSpellInfo()))
            return SPELL_FAILED_BAD_TARGETS;

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_rog_pickpocket::CheckCast);
    }
};

enum vanish
{
    SPELL_STEALTH           = 1784,
    SPELL_PARALYZE          = 38132,
    SPELL_CLEAN_ESCAPE_AURA = 23582,
    SPELL_CLEAN_ESCAPE_HEAL = 23583
};

// 18461 - Vanish Purge (Server Side)
class spell_rog_vanish_purge : public SpellScript
{
    PrepareSpellScript(spell_rog_vanish_purge);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PARALYZE });
    }

    void HandleRootRemove(SpellEffIndex /*effIndex*/)
    {
        if (GetCaster() && !GetCaster()->HasAura(SPELL_PARALYZE)) // Root from Tainted Core SSC, should not be removed by vanish.
            GetCaster()->RemoveAurasWithMechanic(1 << MECHANIC_ROOT);
    }

    void HandleSnareRemove(SpellEffIndex /*effIndex*/)
    {
        if (GetCaster())
            GetCaster()->RemoveAurasWithMechanic(1 << MECHANIC_SNARE);
    }

    void Register() override
    {
        // Blizzard handles EFFECT_0 as the unroot and EFFECT_1 as unsnare. Hence why they are not done in the same place.
        OnEffectHitTarget += SpellEffectFn(spell_rog_vanish_purge::HandleRootRemove, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
        OnEffectHitTarget += SpellEffectFn(spell_rog_vanish_purge::HandleSnareRemove, EFFECT_1, SPELL_EFFECT_APPLY_AURA);
    }
};

// -1856 - Vanish
class spell_rog_vanish : public SpellScript
{
    PrepareSpellScript(spell_rog_vanish);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CLEAN_ESCAPE_AURA, SPELL_CLEAN_ESCAPE_HEAL });
    }

    void HandleEffect(SpellEffIndex /*effIndex*/)
    {
        if (GetCaster())
        {
            GetCaster()->RemoveAurasByType(SPELL_AURA_MOD_STALKED);

            if (!GetCaster()->HasAura(SPELL_STEALTH))
            {
                // Remove stealth cooldown if needed.
                if (GetCaster()->IsPlayer() && GetCaster()->HasSpellCooldown(SPELL_STEALTH))
                    GetCaster()->ToPlayer()->RemoveSpellCooldown(SPELL_STEALTH);

                GetCaster()->CastSpell(GetCaster(), SPELL_STEALTH, true);
            }

            if (GetCaster()->HasAura(SPELL_CLEAN_ESCAPE_AURA))
                GetCaster()->CastSpell(GetCaster(), SPELL_CLEAN_ESCAPE_HEAL, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_rog_vanish::HandleEffect, EFFECT_2, SPELL_EFFECT_SANCTUARY);
    }
};

void AddSC_rogue_spell_scripts()
{
    RegisterSpellScript(spell_rog_savage_combat);
    RegisterSpellScript(spell_rog_combat_potency);
    RegisterSpellScript(spell_rog_blade_flurry);
    RegisterSpellScript(spell_rog_cheat_death);
    RegisterSpellScript(spell_rog_deadly_poison);
    RegisterSpellAndAuraScriptPair(spell_rog_killing_spree, spell_rog_killing_spree_aura);
    RegisterSpellScript(spell_rog_nerves_of_steel);
    RegisterSpellScript(spell_rog_preparation);
    RegisterSpellScript(spell_rog_prey_on_the_weak);
    RegisterSpellScript(spell_rog_rupture);
    RegisterSpellScript(spell_rog_shiv);
    RegisterSpellScript(spell_rog_tricks_of_the_trade);
    RegisterSpellScript(spell_rog_tricks_of_the_trade_proc);
    RegisterSpellScript(spell_rog_pickpocket);
    RegisterSpellScript(spell_rog_vanish_purge);
    RegisterSpellScript(spell_rog_vanish);
}

