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

#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "Cell.h"
#include "CellImpl.h"
#include "Chat.h"
#include "CreatureScript.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "Pet.h"
#include "ReputationMgr.h"
#include "SkillDiscovery.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Unit.h"
#include "Vehicle.h"
#include <array>
/*
 * Scripts for spells with SPELLFAMILY_GENERIC which cannot be included in AI script file
 * of creature using it or can't be bound to any player class.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_gen_"
 */

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

// 46642 - 5,000 Gold
class spell_gen_5000_gold : public SpellScript
{
    PrepareSpellScript(spell_gen_5000_gold);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Player* target = GetHitPlayer())
        {
            target->ModifyMoney(5000 * GOLD);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_5000_gold::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 24401 - Test Pet Passive
class spell_gen_model_visible : public AuraScript
{
public:
    PrepareAuraScript(spell_gen_model_visible)

    bool Load() override
    {
        _modelId = 0;
        _hasFlag = false;
        return true;
    }

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        _modelId = GetUnitOwner()->GetDisplayId();
        _hasFlag = GetUnitOwner()->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        for (uint8 i = 0; i < 3; ++i)
            _itemId.at(i) = GetUnitOwner()->GetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + i);

        GetUnitOwner()->SetDisplayId(11686);
        GetUnitOwner()->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        for (uint8 i = 0; i < 3; ++i)
            GetUnitOwner()->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + i, 0);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->SetDisplayId(_modelId);
        if (!_hasFlag)
            GetUnitOwner()->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        for (uint8 i = 0; i < 3; ++i)
            GetUnitOwner()->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + i, _itemId.at(i));
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_gen_model_visible::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_gen_model_visible::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }

private:
    std::array<uint32, 3> _itemId = { {0, 0, 0} };
    uint32 _modelId;
    bool _hasFlag;
};

enum FlagOfOwnership
{
    TEXT_FLAG_OF_OWNERSHIP  = 28008,
    SPELL_TAUNT_FLAG        = 52605
};

// 51640 - Taunt Flag Targeting
class spell_the_flag_of_ownership : public SpellScript
{
    PrepareSpellScript(spell_the_flag_of_ownership);

    bool haveTarget;
    bool Load() override
    {
        haveTarget = false;
        return true;
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (!caster || caster->GetTypeId() != TYPEID_PLAYER)
            return;
        Player* target = GetHitPlayer();
        if (!target)
            return;
        caster->CastSpell(target, SPELL_TAUNT_FLAG, true);

        LocaleConstant loc_idx = caster->ToPlayer()->GetSession()->GetSessionDbLocaleIndex();
        BroadcastText const* bct = sObjectMgr->GetBroadcastText(TEXT_FLAG_OF_OWNERSHIP);
        std::string bctMsg = Acore::StringFormat(bct->GetText(loc_idx, caster->getGender()), caster->GetName().c_str(), target->GetName().c_str());
        caster->Talk(bctMsg, CHAT_MSG_MONSTER_EMOTE, LANG_UNIVERSAL, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_TEXTEMOTE), target);

        haveTarget = true;
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        for( std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); )
        {
            if ((*itr)->GetTypeId() != TYPEID_PLAYER || (*itr)->ToPlayer()->IsAlive())
            {
                targets.erase(itr);
                itr = targets.begin();
                continue;
            }
            ++itr;
        }
    }

    void HandleFinish()
    {
        Unit* caster = GetCaster();
        if (!caster || !caster->ToPlayer())
            return;

        if (!haveTarget)
        {
            caster->ToPlayer()->RemoveSpellCooldown(GetSpellInfo()->Id, true);
            Spell::SendCastResult(caster->ToPlayer(), GetSpellInfo(), 0, SPELL_FAILED_BAD_TARGETS);
        }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_the_flag_of_ownership::HandleFinish);
        OnEffectHitTarget += SpellEffectFn(spell_the_flag_of_ownership::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_flag_of_ownership::FilterTargets, EFFECT_0, TARGET_CORPSE_SRC_AREA_ENEMY);
    }
};

/* 51060 - Have Withered Batwing
   51068 - Have Muddy Mire Maggot
   51088 - Have Amberseed
   51094 - Have Chilled Serpent Mucus */
class spell_gen_have_item_auras : public AuraScript
{
    PrepareAuraScript(spell_gen_have_item_auras)

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (target && target->ToPlayer())
        {
            uint32 entry = 0;
            switch (GetSpellInfo()->Id)
            {
                case 51060: // Have Withered Batwing
                    entry = 28294;
                    break;
                case 51068: // Have Muddy Mire Maggot
                    entry = 28293;
                    break;
                case 51094: // Have Chilled Serpent Mucus
                    entry = 28296;
                    break;
                case 51088: // Have Amberseed
                    entry = 28295;
                    break;
            }

            if (entry)
                target->ToPlayer()->KilledMonsterCredit(entry);
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_gen_have_item_auras::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

enum MineSweeper
{
    SPELL_LAND_MINE_KNOCKBACK = 54402,
    SPELL_LANDMINE_KNOCKBACK_ACHIEVEMENT = 57064,
};

/* 54355 - Detonation
   57099 - Landmine Knockback Achievement Aura */
class spell_gen_mine_sweeper : public SpellScript
{
    PrepareSpellScript(spell_gen_mine_sweeper);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_LAND_MINE_KNOCKBACK, SPELL_LANDMINE_KNOCKBACK_ACHIEVEMENT});
    }

    void HandleSchoolDMG(SpellEffIndex  /*effIndex*/)
    {
        Unit* caster = GetCaster();
        Player* target = GetHitPlayer();
        if (!target)
            return;

        target->RemoveAurasByType(SPELL_AURA_MOUNTED);
        caster->CastSpell(target, SPELL_LAND_MINE_KNOCKBACK, true);
    }

    void HandleScriptEffect(SpellEffIndex  /*effIndex*/)
    {
        if (Unit* target = GetHitPlayer())
            if (Aura* aur = target->GetAura(GetSpellInfo()->Id))
                if (aur->GetStackAmount() >= 10)
                    target->CastSpell(target, SPELL_LANDMINE_KNOCKBACK_ACHIEVEMENT, true);
    }

    void Register() override
    {
        if (m_scriptSpellId == 54355)
            OnEffectHitTarget += SpellEffectFn(spell_gen_mine_sweeper::HandleSchoolDMG, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
        else
            OnEffectHitTarget += SpellEffectFn(spell_gen_mine_sweeper::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/* 20004 - Life Steal
   20005 - Chilled
   20007 - Holy Strength */
class spell_gen_reduced_above_60 : public SpellScript
{
    PrepareSpellScript(spell_gen_reduced_above_60);

    void RecalculateDamage()
    {
        if (Unit* target = GetHitUnit())
            if (target->GetLevel() > 60)
            {
                int32 damage = GetHitDamage();
                AddPct(damage, -4 * int8(std::min(target->GetLevel(), uint8(85)) - 60)); // prevents reduce by more than 100%
                SetHitDamage(damage);
            }
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_gen_reduced_above_60::RecalculateDamage);
    }
};

class spell_gen_reduced_above_60_aura : public AuraScript
{
    PrepareAuraScript(spell_gen_reduced_above_60_aura);

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool&   /*canBeRecalculated*/)
    {
        if (Unit* owner = GetUnitOwner())
            if (owner->GetLevel() > 60)
                AddPct(amount, -4 * int8(std::min(owner->GetLevel(), uint8(85)) - 60)); // prevents reduce by more than 100%
    }

    void Register() override
    {
        if (m_scriptSpellId != 20004) // Lifestealing enchange - no aura effect
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_gen_reduced_above_60_aura::CalculateAmount, EFFECT_ALL, SPELL_AURA_ANY);
    }
};

/* 69664 - Aquanos Laundry                      (spell_q20438_q24556_aquantos_laundry)
   38724 - Magic Sucker Device (Success Visual) (spell_q10838_demoniac_scryer_visual) */
class spell_gen_relocaste_dest : public SpellScript
{
    PrepareSpellScript(spell_gen_relocaste_dest);
public:
    spell_gen_relocaste_dest(float x, float y, float z, float o) : _x(x), _y(y), _z(z), _o(o) { }

    void RelocateDest()
    {
        Position const offset = {_x, _y, _z, _o};
        const_cast<WorldLocation*>(GetExplTargetDest())->RelocateOffset(offset);
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_gen_relocaste_dest::RelocateDest);
    }

private:
    float _x, _y, _z, _o;
};

/* 55640 - Lightweave Embroidery
   67698 - Item - Coliseum 25 Normal Healer Trinket
   67752 - Item - Coliseum 25 Heroic Healer Trinket
   69762 - Unchained Magic */
class spell_gen_allow_proc_from_spells_with_cost : public AuraScript
{
    PrepareAuraScript(spell_gen_allow_proc_from_spells_with_cost);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo)
            return false;

        // xinef: Spells with no damage class and physical school only are not treated as spells
        if ((eventInfo.GetTypeMask() & (PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_NEG | PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_POS)) && spellInfo->SchoolMask == SPELL_SCHOOL_MASK_NORMAL)
            return false;

        // xinef: holy nova exception
        if (spellInfo->SpellFamilyName == SPELLFAMILY_PRIEST && spellInfo->SpellIconID == 1874)
            return spellInfo->HasEffect(SPELL_EFFECT_HEAL);

        // xinef: Holy Shock exception...
        return spellInfo->ManaCost > 0 || spellInfo->ManaCostPercentage > 0 || (spellInfo->SpellFamilyName == SPELLFAMILY_PALADIN && spellInfo->SpellIconID == 156);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_gen_allow_proc_from_spells_with_cost::CheckProc);
    }
};

/* 32727 - Arena Preparation
   44521 - Preparation */
class spell_gen_bg_preparation : public AuraScript
{
    PrepareAuraScript(spell_gen_bg_preparation)

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->ApplySpellImmune(GetId(), IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_ALL, true);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->ApplySpellImmune(GetId(), IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_ALL, false);
    }

    void CalcPeriodic(AuraEffect const* /*effect*/, bool& isPeriodic, int32& amplitude)
    {
        isPeriodic = true;
        amplitude = 3 * IN_MILLISECONDS;
    }

    void Update(AuraEffect*  /*effect*/)
    {
        if (Player* player = GetUnitOwner()->GetCharmerOrOwnerPlayerOrPlayerItself())
            if (MapEntry const* mapEntry = sMapStore.LookupEntry(player->GetMapId()))
                if ((GetId() == 32727 && mapEntry->IsBattleArena()) || (GetId() == 44521 && mapEntry->IsBattleground()))
                    if (Battleground* bg = player->GetBattleground())
                        if (bg->GetStatus() == STATUS_WAIT_JOIN)
                            return;
        SetMaxDuration(1);
        SetDuration(1);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_gen_bg_preparation::HandleEffectApply, EFFECT_0, SPELL_AURA_MOD_POWER_COST_SCHOOL_PCT, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_gen_bg_preparation::HandleEffectRemove, EFFECT_0, SPELL_AURA_MOD_POWER_COST_SCHOOL_PCT, AURA_EFFECT_HANDLE_REAL);

        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_gen_bg_preparation::CalcPeriodic, EFFECT_0, SPELL_AURA_MOD_POWER_COST_SCHOOL_PCT);
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_gen_bg_preparation::Update, EFFECT_0, SPELL_AURA_MOD_POWER_COST_SCHOOL_PCT);
    }
};

/* 27867 - Freeze            (spell_gen_disabled_above_70)
   59917 - Minor Mount Speed (spell_gen_disabled_above_70)
   46629 - Deathfrost        (spell_gen_disabled_above_73) */
class spell_gen_disabled_above_level : public SpellScript
{
    PrepareSpellScript(spell_gen_disabled_above_level)

public:
    spell_gen_disabled_above_level(uint8 level) : SpellScript(), _level(level) { }

    SpellCastResult CheckRequirement()
    {
        if (Unit* target = GetExplTargetUnit())
            if (target->GetLevel() >= _level)
                return SPELL_FAILED_DONT_REPORT;

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_gen_disabled_above_level::CheckRequirement);
    }

private:
    uint8 _level;
};

/* 61013 - Warlock Pet Scaling 05
   61017 - Hunter Pet Scaling 04 */
class spell_pet_hit_expertise_scalling : public AuraScript
{
    PrepareAuraScript(spell_pet_hit_expertise_scalling)

    int32 CalculatePercent(float hitChance, float cap, float maxChance)
    {
        return (hitChance / cap) * maxChance;
    }

    void CalculateHitAmount(AuraEffect const*  /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (Player* modOwner = GetUnitOwner()->GetSpellModOwner())
        {
            if (modOwner->IsClass(CLASS_HUNTER, CLASS_CONTEXT_STATS))
                amount = CalculatePercent(modOwner->m_modRangedHitChance, 8.0f, 8.0f);
            else if (modOwner->getPowerType() == POWER_MANA)
                amount = CalculatePercent(modOwner->m_modSpellHitChance, 17.0f, 8.0f);
            else
                amount = CalculatePercent(modOwner->m_modMeleeHitChance, 8.0f, 8.0f);
        }
    }

    void CalculateSpellHitAmount(AuraEffect const*  /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (Player* modOwner = GetUnitOwner()->GetSpellModOwner())
        {
            if (modOwner->IsClass(CLASS_HUNTER, CLASS_CONTEXT_STATS))
                amount = CalculatePercent(modOwner->m_modRangedHitChance, 8.0f, 17.0f);
            else if (modOwner->getPowerType() == POWER_MANA)
                amount = CalculatePercent(modOwner->m_modSpellHitChance, 17.0f, 17.0f);
            else
                amount = CalculatePercent(modOwner->m_modMeleeHitChance, 8.0f, 17.0f);
        }
    }

    void CalculateExpertiseAmount(AuraEffect const*  /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (Player* modOwner = GetUnitOwner()->GetSpellModOwner())
        {
            if (modOwner->IsClass(CLASS_HUNTER, CLASS_CONTEXT_STATS))
                amount = CalculatePercent(modOwner->m_modRangedHitChance, 8.0f, 26.0f);
            else if (modOwner->getPowerType() == POWER_MANA)
                amount = CalculatePercent(modOwner->m_modSpellHitChance, 17.0f, 26.0f);
            else
                amount = CalculatePercent(modOwner->m_modMeleeHitChance, 8.0f, 26.0f);
        }
    }

    void HandleEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->ApplySpellImmune(GetId(), IMMUNITY_STATE, aurEff->GetAuraType(), true, SPELL_BLOCK_TYPE_POSITIVE);
    }

    void CalcPeriodic(AuraEffect const* /*aurEff*/, bool& isPeriodic, int32& amplitude)
    {
        if (!GetUnitOwner()->IsPet())
            return;

        isPeriodic = true;
        amplitude = 3 * IN_MILLISECONDS;
    }

    void HandlePeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        GetEffect(aurEff->GetEffIndex())->RecalculateAmount();
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pet_hit_expertise_scalling::CalculateHitAmount, EFFECT_0, SPELL_AURA_MOD_HIT_CHANCE);
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pet_hit_expertise_scalling::CalculateSpellHitAmount, EFFECT_1, SPELL_AURA_MOD_SPELL_HIT_CHANCE);
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pet_hit_expertise_scalling::CalculateExpertiseAmount, EFFECT_2, SPELL_AURA_MOD_EXPERTISE);

        OnEffectApply += AuraEffectApplyFn(spell_pet_hit_expertise_scalling::HandleEffectApply, EFFECT_ALL, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_pet_hit_expertise_scalling::CalcPeriodic, EFFECT_ALL, SPELL_AURA_ANY);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_pet_hit_expertise_scalling::HandlePeriodic, EFFECT_ALL, SPELL_AURA_ANY);
    }
};

// 55475 - Grow Flower Patch
class spell_gen_grow_flower_patch : public SpellScript
{
    PrepareSpellScript(spell_gen_grow_flower_patch)

    SpellCastResult CheckCast()
    {
        if (GetCaster()->HasAuraType(SPELL_AURA_MOD_STEALTH) || GetCaster()->HasAuraType(SPELL_AURA_MOD_INVISIBILITY))
            return SPELL_FAILED_DONT_REPORT;

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_gen_grow_flower_patch::CheckCast);
    }
};

// 22888 - Rallying Cry of the Dragonslayer
class spell_gen_rallying_cry_of_the_dragonslayer : public SpellScript
{
    PrepareSpellScript(spell_gen_rallying_cry_of_the_dragonslayer);

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        targets.clear();

        uint32 zoneId = 1519;
        if (GetCaster()->GetMapId() == 1) // Kalimdor
            zoneId = 1637;

        Map::PlayerList const& pList = GetCaster()->GetMap()->GetPlayers();
        for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
            if (itr->GetSource()->GetZoneId() == zoneId)
                targets.push_back(itr->GetSource());
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_gen_rallying_cry_of_the_dragonslayer::SelectTarget, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ALLY);
    }
};

// 39953 - A'dal's Song of Battle
class spell_gen_adals_song_of_battle : public SpellScript
{
    PrepareSpellScript(spell_gen_adals_song_of_battle);

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        targets.clear();
        Map::PlayerList const& pList = GetCaster()->GetMap()->GetPlayers();
        for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
            if (itr->GetSource()->GetZoneId() == 3703 /*Shattrath*/)
                targets.push_back(itr->GetSource());
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_gen_adals_song_of_battle::SelectTarget, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ALLY);
    }
};

/* 15366 - Songflower Serenade
   22888 - Rallying Cry of the Dragonslayer */
class spell_gen_disabled_above_63 : public AuraScript
{
    PrepareAuraScript(spell_gen_disabled_above_63);

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool&   /*canBeRecalculated*/)
    {
        Unit* target = GetUnitOwner();
        if (target->GetLevel() <= 63)
            amount = amount * target->GetLevel() / 60;
        else
            SetDuration(1);
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_gen_disabled_above_63::CalculateAmount, EFFECT_ALL, SPELL_AURA_ANY);
    }
};

// 59630 - Black Magic
class spell_gen_black_magic_enchant : public AuraScript
{
    PrepareAuraScript(spell_gen_black_magic_enchant);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo)
            return false;

        // Xinef: Old 'code'
        if (eventInfo.GetTypeMask() & PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
            return true;

        // Implement Black Magic enchant Bug
        if (spellInfo->SpellFamilyName == SPELLFAMILY_DRUID)
            if (spellInfo->SpellIconID == 2857 /*SPELL_INFECTED_WOUNDS*/ || spellInfo->SpellIconID == 147 /*SPELL_SHRED*/ || spellInfo->SpellFamilyFlags[1] & 0x400 /*SPELL_MANGLE_(CAT)*/)
                return true;

        return false;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_gen_black_magic_enchant::CheckProc);
    }
};

// 53642 - The Might of Mograine
// 64174 - Protective Gaze
class spell_gen_area_aura_select_players : public AuraScript
{
    PrepareAuraScript(spell_gen_area_aura_select_players);

    bool CheckAreaTarget(Unit* target)
    {
        return target->IsPlayer();
    }
    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_gen_area_aura_select_players::CheckAreaTarget);
    }
};

// 62650 - Fortitude of Frost
// 62670 - Resilience of Nature
// 62671 - Speed of Invention
// 62702 - Fury of the Storm
class spell_gen_area_aura_select_players_and_caster : public AuraScript
{
    PrepareAuraScript(spell_gen_area_aura_select_players_and_caster);

    bool CheckAreaTarget(Unit* target)
    {
        return target->IsPlayer() || target == GetCaster();
    }
    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_gen_area_aura_select_players_and_caster::CheckAreaTarget);
    }
};

/* 29883 - Blink             (spell_gen_select_target_count_15_1)
   38573 - Spore Drop Effect (spell_gen_select_target_count_15_1)
   38633 - Arcane Volley     (spell_gen_select_target_count_15_1)
   38650 - Rancid Mushroom   (spell_gen_select_target_count_15_1)
   39672 - Curse of Agony    (spell_gen_select_target_count_15_1)
   41081 - Find Target       (spell_gen_select_target_count_15_1)
   41357 - L1 Arcane Charge  (spell_gen_select_target_count_15_1)
   53457 - Impale            (spell_gen_select_target_count_15_1)
   54847 - Mojo Volley       (spell_gen_select_target_count_15_2)
   59452 - Mojo Volley       (spell_gen_select_target_count_15_2)
   46008 - Negative Energy   (spell_gen_select_target_count_15_5)
   40851 - Disgruntled                (spell_gen_select_target_count_7_1)
   45680 - Shadow Bolt                (spell_gen_select_target_count_7_1)
   45976 - Open Portal                (spell_gen_select_target_count_7_1)
   48425 - Shoot                      (spell_gen_select_target_count_7_1)
   52438 - Summon Skittering Swarmer  (spell_gen_select_target_count_7_1)
   52449 - Summon Skittering Infector (spell_gen_select_target_count_7_1)
   41172 - Rapid Shot  (spell_gen_select_target_count_24_1)
   74960 - Infrigidate (spell_gen_select_target_count_30_1) */
class spell_gen_select_target_count : public SpellScript
{
    PrepareSpellScript(spell_gen_select_target_count);

public:
    spell_gen_select_target_count(Targets effTarget, uint8 count) : _effTarget(effTarget), _count(count) { }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove(GetCaster());
        Acore::Containers::RandomResize(targets, _count);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_gen_select_target_count::FilterTargets, EFFECT_ALL, _effTarget);
    }

private:
    Targets _effTarget;
    uint8 _count;
};

// 20631 - Furbolg Medicine Pouch
class spell_gen_use_spell_base_level_check : public SpellScript
{
    PrepareSpellScript(spell_gen_use_spell_base_level_check)

    SpellCastResult CheckRequirement()
    {
        if (GetCaster()->GetLevel() < GetSpellInfo()->BaseLevel)
            return SPELL_FAILED_LEVEL_REQUIREMENT;
        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_gen_use_spell_base_level_check::CheckRequirement);
    }
};

/* -49004 - Scent of Blood
   -12317 - Enrage */
class spell_gen_proc_from_direct_damage : public AuraScript
{
    PrepareAuraScript(spell_gen_proc_from_direct_damage);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return !eventInfo.GetSpellInfo() || !eventInfo.GetSpellInfo()->IsTargetingArea();
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_gen_proc_from_direct_damage::CheckProc);
    }
};

/* -51123 - Killing Machine
   -49188 - Rime */
class spell_gen_no_offhand_proc : public AuraScript
{
    PrepareAuraScript(spell_gen_no_offhand_proc);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return !(eventInfo.GetTypeMask() & PROC_FLAG_DONE_OFFHAND_ATTACK);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_gen_no_offhand_proc::CheckProc);
    }
};

// 70805 - Item - Rogue T10 2P Bonus
class spell_gen_proc_on_self : public AuraScript
{
    PrepareAuraScript(spell_gen_proc_on_self);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetActor() == eventInfo.GetActionTarget();
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_gen_proc_on_self::CheckProc);
    }
};

// 70803 - Item - Rogue T10 4P Bonus
class spell_gen_proc_not_self : public AuraScript
{
    PrepareAuraScript(spell_gen_proc_not_self);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetActor() != eventInfo.GetActionTarget();
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        if (Unit* caster = GetCaster())
            if (Unit* target = eventInfo.GetActionTarget())
            {
                ObjectGuid targetGUID = target->GetGUID();
                uint32 spellID = aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell;
                caster->m_Events.AddEventAtOffset([caster, targetGUID, spellID]()
                {
                    if (Unit *target = ObjectAccessor::GetUnit(*caster, targetGUID))
                        caster->CastSpell(target, spellID, true);
                }, 100ms);
            }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_gen_proc_not_self::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_gen_proc_not_self::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// 24983 - Baby Murloc Passive
class spell_gen_baby_murloc_passive : public AuraScript
{
    PrepareAuraScript(spell_gen_baby_murloc_passive);

    void HandleApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        GetAura()->GetEffect(aurEff->GetEffIndex())->SetPeriodicTimer(urand(60000, 120000));
    }

    void HandlePeriodicTimer(AuraEffect* aurEff)
    {
        aurEff->SetPeriodicTimer(urand(120000, 240000));
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_gen_baby_murloc_passive::HandleApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_gen_baby_murloc_passive::HandlePeriodicTimer, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

// 24984 - Baby Murloc
class spell_gen_baby_murloc : public AuraScript
{
    PrepareAuraScript(spell_gen_baby_murloc)

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_DANCE);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_gen_baby_murloc::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_gen_baby_murloc::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 40414, 40892, 49026 - Fixate
class spell_gen_fixate : public SpellScript
{
    PrepareSpellScript(spell_gen_fixate);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            target->CastSpell(GetCaster(), GetEffectValue(), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_fixate::HandleScriptEffect, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_gen_fixate_aura : public AuraScript
{
    PrepareAuraScript(spell_gen_fixate_aura)

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            caster->RemoveAurasDueToSpell(GetSpellInfo()->Effects[EFFECT_2].CalcValue(), GetTarget()->GetGUID());
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_gen_fixate_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

/* 64440 - Blade Warding
   64568 - Blood Reserve */
class spell_gen_proc_above_75 : public SpellScript
{
    PrepareSpellScript(spell_gen_proc_above_75);

    SpellCastResult CheckLevel()
    {
        Unit* caster = GetCaster();
        if (caster->GetLevel() < 75)
        {
            return SPELL_FAILED_LOWLEVEL;
        }

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_gen_proc_above_75::CheckLevel);
    }
};

// 21737 - Periodic Knock Away
class spell_gen_periodic_knock_away : public AuraScript
{
    PrepareAuraScript(spell_gen_periodic_knock_away);

    void OnPeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (Unit* victim = GetUnitOwner()->GetVictim())
            GetUnitOwner()->CastSpell(victim, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_gen_periodic_knock_away::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

// 10101, 18670, 18813, 18945, 19633, 20686, 25778, 31389, 32959 - Knock Away
class spell_gen_knock_away : public SpellScript
{
    PrepareSpellScript(spell_gen_knock_away);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            if (Creature* caster = GetCaster()->ToCreature())
                caster->GetThreatMgr().ModifyThreatByPercent(target, -25); // Xinef: amount confirmed by onyxia and void reaver notes
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_knock_away::HandleScriptEffect, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/* 74630, 75882, 75883, 75884 - Combustion
   74802, 75874, 75875, 75876 - Consumption */
class spell_gen_mod_radius_by_caster_scale : public SpellScript
{
    PrepareSpellScript(spell_gen_mod_radius_by_caster_scale)

    bool Load() override
    {
        GetSpell()->SetSpellValue(SPELLVALUE_RADIUS_MOD, 10000.0f * GetCaster()->GetFloatValue(OBJECT_FIELD_SCALE_X));
        return true;
    }

    void Register() override
    {
    }
};

// 15600 - Hand of Justice

class spell_gen_proc_reduced_above_60 : public AuraScript
{
    PrepareAuraScript(spell_gen_proc_reduced_above_60);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        // Xinef: mostly its 33.(3)% reduce by 70 and 66.(6)% by 80
        if (eventInfo.GetActor() && eventInfo.GetActor()->GetLevel() > 60)
            if (roll_chance_f((eventInfo.GetActor()->GetLevel() - 60) * 3.33f))
                return false;

        return true;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_gen_proc_reduced_above_60::CheckProc);
    }
};

/* 21708 - Summon Noxxion's Spawns
   30205 - Shadow Cage
   52249 - Quetz'lun's Hex of Air
   52278 - Quetz'lun's Hex of Fire
   54894 - Icy Imprisonment */
class spell_gen_visual_dummy_stun : public AuraScript
{
    PrepareAuraScript(spell_gen_visual_dummy_stun);

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->SetControlled(true, UNIT_STATE_STUNNED);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->SetControlled(false, UNIT_STATE_STUNNED);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_gen_visual_dummy_stun::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_gen_visual_dummy_stun::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 21809 - Summon Theradrim Shardling
class spell_gen_random_target32 : public SpellScript
{
    PrepareSpellScript(spell_gen_random_target32);

    void ModDest(SpellDestination& dest)
    {
        float dist = GetSpellInfo()->Effects[EFFECT_0].CalcRadius(GetCaster());
        float angle = frand(0.0f, 2 * M_PI);

        Position pos = GetCaster()->GetNearPosition(dist, angle);
        dest.Relocate(pos);
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_gen_random_target32::ModDest, EFFECT_0, TARGET_DEST_CASTER_SUMMON);
    }
};

// 9204 - Serverside - Hate to Zero
class spell_gen_hate_to_zero : public SpellScript
{
    PrepareSpellScript(spell_gen_hate_to_zero);

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            if (Creature* caster = GetCaster()->ToCreature())
                caster->GetThreatMgr().ModifyThreatByPercent(target, -100);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_hate_to_zero::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 36448, 36475 - Focused Bursts
class spell_gen_focused_bursts : public SpellScript
{
    PrepareSpellScript(spell_gen_focused_bursts);

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (effIndex != EFFECT_0)
            return;

        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, uint32(GetSpellInfo()->Effects[EFFECT_0].BasePoints) + urand(1, 3), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_focused_bursts::HandleDummy, EFFECT_ALL, SPELL_EFFECT_DUMMY);
    }
};

enum eFlurryOfClaws
{
    NPC_FRENZYHEART_RAVAGER             = 28078,
    NPC_FRENZYHEART_HUNTER              = 28079,
    SPELL_FLURRY_OF_CLAWS_DAMAGE        = 53033
};

// 53032 - Flurry of Claws
class spell_gen_flurry_of_claws : public AuraScript
{
    PrepareAuraScript(spell_gen_flurry_of_claws);

    void OnPeriodic(AuraEffect const*  /*aurEff*/)
    {
        PreventDefaultAction();
        if (Unit* target = GetUnitOwner()->SelectNearbyTarget(nullptr, 7.0f))
            if (target->GetEntry() == NPC_FRENZYHEART_RAVAGER || target->GetEntry() == NPC_FRENZYHEART_HUNTER)
            {
                int32 basePoints = irand(1400, 2200);
                GetUnitOwner()->CastCustomSpell(SPELL_FLURRY_OF_CLAWS_DAMAGE, SPELLVALUE_BASE_POINT0, basePoints, target, TRIGGERED_FULL_MASK);
            }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_gen_flurry_of_claws::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 36500 - Glaive
class spell_gen_throw_back : public SpellScript
{
    PrepareSpellScript(spell_gen_throw_back);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            target->CastSpell(GetCaster(), uint32(GetEffectValue()), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_throw_back::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum eHaunted
{
    NPC_SCOURGE_HAUNT = 29238
};

// 53768 - Haunted
class spell_gen_haunted : public SpellScript
{
    PrepareSpellScript(spell_gen_haunted);

    void HandleOnEffectHit(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (Unit* caster = GetCaster())
        {
            Position pos = caster->GetRandomNearPosition(5.0f);
            if (Creature* haunt = caster->SummonCreature(NPC_SCOURGE_HAUNT, pos, TEMPSUMMON_TIMED_DESPAWN, urand(10, 20) * IN_MILLISECONDS))
            {
                haunt->SetSpeed(MOVE_RUN, 0.5, true);
                haunt->GetMotionMaster()->MoveFollow(caster, 1, M_PI);
            }
        }
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_gen_haunted::HandleOnEffectHit, EFFECT_0, SPELL_EFFECT_SUMMON);
    }
};

class spell_gen_haunted_aura : public AuraScript
{
    PrepareAuraScript(spell_gen_haunted_aura);

    void HandleEffectCalcPeriodic(AuraEffect const* /*aurEff*/, bool& isPeriodic, int32& amplitude)
    {
        isPeriodic = true;
        amplitude  = urand(120, 300) * IN_MILLISECONDS;
    }

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        if (Unit* caster = GetCaster())
        {
            Position pos = caster->GetRandomNearPosition(5.0f);
            if (Creature* haunt = caster->SummonCreature(NPC_SCOURGE_HAUNT, pos, TEMPSUMMON_TIMED_DESPAWN, urand(10, 20) * IN_MILLISECONDS))
            {
                haunt->SetSpeed(MOVE_RUN, 0.5, true);
                haunt->GetMotionMaster()->MoveFollow(caster, 1, M_PI);
            }
        }
    }

    void HandleOnEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            if (Creature* haunt = caster->FindNearestCreature(NPC_SCOURGE_HAUNT, 5.0f, true))
                haunt->DespawnOrUnsummon();
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_gen_haunted_aura::HandleEffectPeriodic, EFFECT_1, SPELL_AURA_DUMMY);
        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_gen_haunted_aura::HandleEffectCalcPeriodic, EFFECT_1, SPELL_AURA_DUMMY);
        OnEffectRemove += AuraEffectRemoveFn(spell_gen_haunted_aura::HandleOnEffectRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

/* 39228 - Argussian Compass
   60218 - Essence of Gossamer */
class spell_gen_absorb0_hitlimit1 : public AuraScript
{
    PrepareAuraScript(spell_gen_absorb0_hitlimit1);

    uint32 limit;

    bool Load() override
    {
        // Max absorb stored in 1 dummy effect
        limit = GetSpellInfo()->Effects[EFFECT_1].CalcValue();
        return true;
    }

    void Absorb(AuraEffect* /*aurEff*/, DamageInfo& /*dmgInfo*/, uint32& absorbAmount)
    {
        absorbAmount = std::min(limit, absorbAmount);
    }

    void Register() override
    {
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_gen_absorb0_hitlimit1::Absorb, EFFECT_0);
    }
};

enum AdaptiveWarding
{
    SPELL_GEN_ADAPTIVE_WARDING_FIRE     = 28765,
    SPELL_GEN_ADAPTIVE_WARDING_NATURE   = 28768,
    SPELL_GEN_ADAPTIVE_WARDING_FROST    = 28766,
    SPELL_GEN_ADAPTIVE_WARDING_SHADOW   = 28769,
    SPELL_GEN_ADAPTIVE_WARDING_ARCANE   = 28770
};

// 28764 - Adaptive Warding (Frostfire Regalia Set)
class spell_gen_adaptive_warding : public AuraScript
{
    PrepareAuraScript(spell_gen_adaptive_warding);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_GEN_ADAPTIVE_WARDING_FIRE,
                SPELL_GEN_ADAPTIVE_WARDING_NATURE,
                SPELL_GEN_ADAPTIVE_WARDING_FROST,
                SPELL_GEN_ADAPTIVE_WARDING_SHADOW,
                SPELL_GEN_ADAPTIVE_WARDING_ARCANE
            });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (!eventInfo.GetSpellInfo())
            return false;

        // find Mage Armor
        if (!GetTarget()->GetAuraEffect(SPELL_AURA_MOD_MANA_REGEN_INTERRUPT, SPELLFAMILY_MAGE, 0x10000000, 0x0, 0x0))
            return false;

        switch (GetFirstSchoolInMask(eventInfo.GetSchoolMask()))
        {
            case SPELL_SCHOOL_NORMAL:
            case SPELL_SCHOOL_HOLY:
                return false;
            default:
                break;
        }
        return true;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        uint32 spellId = 0;
        switch (GetFirstSchoolInMask(eventInfo.GetSchoolMask()))
        {
            case SPELL_SCHOOL_FIRE:
                spellId = SPELL_GEN_ADAPTIVE_WARDING_FIRE;
                break;
            case SPELL_SCHOOL_NATURE:
                spellId = SPELL_GEN_ADAPTIVE_WARDING_NATURE;
                break;
            case SPELL_SCHOOL_FROST:
                spellId = SPELL_GEN_ADAPTIVE_WARDING_FROST;
                break;
            case SPELL_SCHOOL_SHADOW:
                spellId = SPELL_GEN_ADAPTIVE_WARDING_SHADOW;
                break;
            case SPELL_SCHOOL_ARCANE:
                spellId = SPELL_GEN_ADAPTIVE_WARDING_ARCANE;
                break;
            default:
                return;
        }
        GetTarget()->CastSpell(GetTarget(), spellId, true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_gen_adaptive_warding::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_gen_adaptive_warding::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

/* 45822 - Iceblood Warmaster
   45823 - Tower Point Warmaster
   45824 - West Frostwolf Warmaster
   45826 - East Frostwolf Warmaster
   45828 - Dun Baldar North Marshal
   45829 - Dun Baldar South Marshal
   45830 - Stonehearth Marshal
   45831 - Icewing Marshal */
class spell_gen_av_drekthar_presence : public AuraScript
{
    PrepareAuraScript(spell_gen_av_drekthar_presence);

    bool CheckAreaTarget(Unit* target)
    {
        switch (target->GetEntry())
        {
            // alliance
            case 14762: // Dun Baldar North Marshal
            case 14763: // Dun Baldar South Marshal
            case 14764: // Icewing Marshal
            case 14765: // Stonehearth Marshal
            case 11948: // Vandar Stormspike
            // horde
            case 14772: // East Frostwolf Warmaster
            case 14776: // Tower Point Warmaster
            case 14773: // Iceblood Warmaster
            case 14777: // West Frostwolf Warmaster
            case 11946: // Drek'thar
                return true;
            default:
                return false;
        }
    }

    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_gen_av_drekthar_presence::CheckAreaTarget);
    }
};

// 46394 - Brutallus Burn
class spell_gen_burn_brutallus : public AuraScript
{
    PrepareAuraScript(spell_gen_burn_brutallus);

    void HandleEffectPeriodicUpdate(AuraEffect* aurEff)
    {
        if (aurEff->GetTickNumber() % 11 == 0)
            aurEff->SetAmount(aurEff->GetAmount() * 2);
    }

    void Register() override
    {
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_gen_burn_brutallus::HandleEffectPeriodicUpdate, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

enum CannibalizeSpells
{
    SPELL_CANNIBALIZE_TRIGGERED = 20578
};

// 20577 - Cannibalize
class spell_gen_cannibalize : public SpellScript
{
    PrepareSpellScript(spell_gen_cannibalize);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CANNIBALIZE_TRIGGERED });
    }

    SpellCastResult CheckIfCorpseNear()
    {
        Unit* caster = GetCaster();
        float max_range = GetSpellInfo()->GetMaxRange(false);
        WorldObject* result = nullptr;
        // search for nearby enemy corpse in range
        Acore::AnyDeadUnitSpellTargetInRangeCheck check(caster, max_range, GetSpellInfo(), TARGET_CHECK_CORPSE);
        Acore::WorldObjectSearcher<Acore::AnyDeadUnitSpellTargetInRangeCheck> searcher(caster, result, check);
        Cell::VisitWorldObjects(caster, searcher, max_range);
        if (!result)
        {
            Cell::VisitGridObjects(caster, searcher, max_range);
        }
        if (!result)
        {
            return SPELL_FAILED_NO_EDIBLE_CORPSES;
        }
        return SPELL_CAST_OK;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetCaster(), SPELL_CANNIBALIZE_TRIGGERED, false);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_gen_cannibalize::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        OnCheckCast += SpellCheckCastFn(spell_gen_cannibalize::CheckIfCorpseNear);
    }
};

// 34098 - ClearAllDebuffs
class spell_gen_clear_debuffs : public SpellScript
{
    PrepareSpellScript(spell_gen_clear_debuffs);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            target->RemoveOwnedAuras([](Aura const* aura)
            {
                SpellInfo const* spellInfo = aura->GetSpellInfo();
                return !spellInfo->IsPositive() && !spellInfo->IsPassive();
            });
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_clear_debuffs::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum CreateLanceSpells
{
    SPELL_CREATE_LANCE_ALLIANCE = 63914,
    SPELL_CREATE_LANCE_HORDE    = 63919
};

// 63845 - Create Lance
class spell_gen_create_lance : public SpellScript
{
    PrepareSpellScript(spell_gen_create_lance);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CREATE_LANCE_ALLIANCE, SPELL_CREATE_LANCE_HORDE });
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (Player* target = GetHitPlayer())
        {
            if (target->GetTeamId() == TEAM_ALLIANCE)
                GetCaster()->CastSpell(target, SPELL_CREATE_LANCE_ALLIANCE, true);
            else
                GetCaster()->CastSpell(target, SPELL_CREATE_LANCE_HORDE, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_create_lance::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum MossCoveredFeet
{
    SPELL_FALL_DOWN = 6869
};

/* 6870 - Moss Covered Feet
   31399 - Moss Covered Feet */
class spell_gen_moss_covered_feet : public AuraScript
{
    PrepareAuraScript(spell_gen_moss_covered_feet);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FALL_DOWN });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        if (eventInfo.GetActionTarget())
        {
            eventInfo.GetActionTarget()->CastSpell((Unit*)nullptr, SPELL_FALL_DOWN, true, nullptr, aurEff);
        }
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_gen_moss_covered_feet::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

enum Netherbloom
{
    SPELL_NETHERBLOOM_POLLEN_1      = 28703
};

// 28702 - Netherbloom
class spell_gen_netherbloom : public SpellScript
{
    PrepareSpellScript(spell_gen_netherbloom);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        for (uint8 i = 0; i < 5; ++i)
            if (!sSpellMgr->GetSpellInfo(SPELL_NETHERBLOOM_POLLEN_1 + i))
                return false;
        return true;
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (Unit* target = GetHitUnit())
        {
            // 25% chance of casting a random buff
            if (roll_chance_i(75))
                return;

            // triggered spells are 28703 to 28707
            // Note: some sources say, that there was the possibility of
            //       receiving a debuff. However, this seems to be removed by a patch.

            // don't overwrite an existing aura
            for (uint8 i = 0; i < 5; ++i)
                if (target->HasAura(SPELL_NETHERBLOOM_POLLEN_1 + i))
                    return;

            target->CastSpell(target, SPELL_NETHERBLOOM_POLLEN_1 + urand(0, 4), true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_netherbloom::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum NightmareVine
{
    SPELL_NIGHTMARE_POLLEN      = 28721
};

// 28720 - Nightmare Vine
class spell_gen_nightmare_vine : public SpellScript
{
    PrepareSpellScript(spell_gen_nightmare_vine);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_NIGHTMARE_POLLEN });
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (Unit* target = GetHitUnit())
        {
            // 25% chance of casting Nightmare Pollen
            if (roll_chance_i(25))
                target->CastSpell(target, SPELL_NIGHTMARE_POLLEN, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_nightmare_vine::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum ObsidianArmor
{
    SPELL_GEN_OBSIDIAN_ARMOR_HOLY       = 27536,
    SPELL_GEN_OBSIDIAN_ARMOR_FIRE       = 27533,
    SPELL_GEN_OBSIDIAN_ARMOR_NATURE     = 27538,
    SPELL_GEN_OBSIDIAN_ARMOR_FROST      = 27534,
    SPELL_GEN_OBSIDIAN_ARMOR_SHADOW     = 27535,
    SPELL_GEN_OBSIDIAN_ARMOR_ARCANE     = 27540
};

// 27539 - Obsidian Armor
class spell_gen_obsidian_armor : public AuraScript
{
    PrepareAuraScript(spell_gen_obsidian_armor);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_GEN_OBSIDIAN_ARMOR_HOLY,
                SPELL_GEN_OBSIDIAN_ARMOR_FIRE,
                SPELL_GEN_OBSIDIAN_ARMOR_NATURE,
                SPELL_GEN_OBSIDIAN_ARMOR_FROST,
                SPELL_GEN_OBSIDIAN_ARMOR_SHADOW,
                SPELL_GEN_OBSIDIAN_ARMOR_ARCANE
            });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (eventInfo.GetSpellInfo())
        {
            return false;
        }

        if (GetFirstSchoolInMask(eventInfo.GetSchoolMask()) == SPELL_SCHOOL_NORMAL)
            return false;

        return true;
    }

    void OnProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        uint32 spellId = 0;
        switch (GetFirstSchoolInMask(eventInfo.GetSchoolMask()))
        {
            case SPELL_SCHOOL_HOLY:
                spellId = SPELL_GEN_OBSIDIAN_ARMOR_HOLY;
                break;
            case SPELL_SCHOOL_FIRE:
                spellId = SPELL_GEN_OBSIDIAN_ARMOR_FIRE;
                break;
            case SPELL_SCHOOL_NATURE:
                spellId = SPELL_GEN_OBSIDIAN_ARMOR_NATURE;
                break;
            case SPELL_SCHOOL_FROST:
                spellId = SPELL_GEN_OBSIDIAN_ARMOR_FROST;
                break;
            case SPELL_SCHOOL_SHADOW:
                spellId = SPELL_GEN_OBSIDIAN_ARMOR_SHADOW;
                break;
            case SPELL_SCHOOL_ARCANE:
                spellId = SPELL_GEN_OBSIDIAN_ARMOR_ARCANE;
                break;
            default:
                return;
        }
        GetTarget()->CastSpell(GetTarget(), spellId, true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_gen_obsidian_armor::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_gen_obsidian_armor::OnProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

enum ParachuteSpells
{
    SPELL_PARACHUTE         = 45472,
    SPELL_PARACHUTE_BUFF    = 44795,
};

// 45472 - Parachute
class spell_gen_parachute : public AuraScript
{
    PrepareAuraScript(spell_gen_parachute);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PARACHUTE, SPELL_PARACHUTE_BUFF });
    }

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        if (Player* target = GetTarget()->ToPlayer())
            if (target->IsFalling())
            {
                target->RemoveAurasDueToSpell(SPELL_PARACHUTE);
                target->CastSpell(target, SPELL_PARACHUTE_BUFF, true);
            }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_gen_parachute::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 6962 - Pet Summoned
class spell_gen_pet_summoned : public SpellScript
{
    PrepareSpellScript(spell_gen_pet_summoned);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Player* player = GetCaster()->ToPlayer();
        if (player->GetLastPetNumber() && player->CanResummonPet(player->GetLastPetSpell()))
        {
            PetType newPetType = (player->IsClass(CLASS_HUNTER, CLASS_CONTEXT_PET)) ? HUNTER_PET : SUMMON_PET;
            Pet* newPet = new Pet(player, newPetType);
            if (newPet->LoadPetFromDB(player, 0, player->GetLastPetNumber(), true, 100, true))
            {
                switch (newPet->GetEntry())
                {
                    case NPC_DOOMGUARD:
                    case NPC_INFERNAL:
                        newPet->SetEntry(NPC_IMP);
                        break;
                    default:
                        break;
                }
            }
            else
                delete newPet;
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_pet_summoned::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 58601 - Remove Flight Auras
class spell_gen_remove_flight_auras : public SpellScript
{
    PrepareSpellScript(spell_gen_remove_flight_auras);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            target->RemoveAurasByType(SPELL_AURA_FLY);
            target->RemoveAurasByType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_remove_flight_auras::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum EluneCandle
{
    // Creatures
    NPC_OMEN                       = 15467,

    // Spells
    SPELL_ELUNE_CANDLE_OMEN_HEAD   = 26622,
    SPELL_ELUNE_CANDLE_OMEN_CHEST  = 26624,
    SPELL_ELUNE_CANDLE_OMEN_HAND_R = 26625,
    SPELL_ELUNE_CANDLE_OMEN_HAND_L = 26649,
    SPELL_ELUNE_CANDLE_NORMAL      = 26636
};

// 26374 - Elune's Candle
class spell_gen_elune_candle : public SpellScript
{
    PrepareSpellScript(spell_gen_elune_candle);
    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_ELUNE_CANDLE_OMEN_HEAD,
                SPELL_ELUNE_CANDLE_OMEN_CHEST,
                SPELL_ELUNE_CANDLE_OMEN_HAND_R,
                SPELL_ELUNE_CANDLE_OMEN_HAND_L,
                SPELL_ELUNE_CANDLE_NORMAL
            });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        uint32 spellId = 0;

        if (GetHitUnit()->GetEntry() == NPC_OMEN)
        {
            switch (urand(0, 3))
            {
                case 0:
                    spellId = SPELL_ELUNE_CANDLE_OMEN_HEAD;
                    break;
                case 1:
                    spellId = SPELL_ELUNE_CANDLE_OMEN_CHEST;
                    break;
                case 2:
                    spellId = SPELL_ELUNE_CANDLE_OMEN_HAND_R;
                    break;
                case 3:
                    spellId = SPELL_ELUNE_CANDLE_OMEN_HAND_L;
                    break;
            }
        }
        else
            spellId = SPELL_ELUNE_CANDLE_NORMAL;

        GetCaster()->CastSpell(GetHitUnit(), spellId, true, nullptr);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_elune_candle::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

/*
There are only 3 possible flags Feign Death auras can apply: UNIT_DYNFLAG_DEAD, UNIT_FLAG2_FEIGN_DEATH
and UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT. Some auras can apply only 2 flags

spell_gen_feign_death_all_flags applies all 3 flags
spell_gen_feign_death_no_dyn_flag applies no UNIT_DYNFLAG_DEAD (does not make the creature appear dead)
spell_gen_feign_death_no_prevent_emotes applies no UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT

REACT_PASSIVE should be handled directly in scripts since not all creatures should be passive. Otherwise
creature will be not able to aggro or execute MoveInLineOfSight events. Removing may cause more issues
than already exists
*/

class spell_gen_feign_death_all_flags : public AuraScript
{
    PrepareAuraScript(spell_gen_feign_death_all_flags);

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->SetDynamicFlag(UNIT_DYNFLAG_DEAD);
        target->SetUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
        target->SetUnitFlag(UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);

        if (target->GetTypeId() == TYPEID_UNIT)
            target->ToCreature()->SetReactState(REACT_PASSIVE);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->RemoveDynamicFlag(UNIT_DYNFLAG_DEAD);
        target->RemoveUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
        target->RemoveUnitFlag(UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);

        if (target->GetTypeId() == TYPEID_UNIT)
            target->ToCreature()->InitializeReactState();
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_gen_feign_death_all_flags::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectApplyFn(spell_gen_feign_death_all_flags::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 35357 - Spawn Feign Death
// 51329 - Feign Death

class spell_gen_feign_death_no_dyn_flag : public AuraScript
{
    PrepareAuraScript(spell_gen_feign_death_no_dyn_flag);

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->SetUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
        target->SetUnitFlag(UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);

        if (target->GetTypeId() == TYPEID_UNIT)
            target->ToCreature()->SetReactState(REACT_PASSIVE);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->RemoveUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
        target->RemoveUnitFlag(UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);

        if (target->GetTypeId() == TYPEID_UNIT)
            target->ToCreature()->InitializeReactState();
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_gen_feign_death_no_dyn_flag::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectApplyFn(spell_gen_feign_death_no_dyn_flag::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 58951 - Permanent Feign Death

class spell_gen_feign_death_no_prevent_emotes : public AuraScript
{
    PrepareAuraScript(spell_gen_feign_death_no_prevent_emotes);

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->SetUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
        target->SetUnitFlag(UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);

        if (target->GetTypeId() == TYPEID_UNIT)
            target->ToCreature()->SetReactState(REACT_PASSIVE);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->RemoveUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
        target->RemoveUnitFlag(UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);

        if (target->GetTypeId() == TYPEID_UNIT)
            target->ToCreature()->InitializeReactState();
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_gen_feign_death_no_prevent_emotes::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectApplyFn(spell_gen_feign_death_no_prevent_emotes::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

enum Teleporting
{
    AREA_VIOLET_CITADEL_SPIRE   = 4637,

    SPELL_TELEPORT_SPIRE_DOWN   = 59316,
    SPELL_TELEPORT_SPIRE_UP     = 59314
};

class spell_gen_teleporting : public SpellScript
{
    PrepareSpellScript(spell_gen_teleporting);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_TELEPORT_SPIRE_UP, SPELL_TELEPORT_SPIRE_DOWN });
    }

    void HandleScript(SpellEffIndex /* effIndex */)
    {
        Unit* target = GetHitUnit();
        if (target->GetTypeId() != TYPEID_PLAYER)
            return;

        // return from top
        if (target->ToPlayer()->GetAreaId() == AREA_VIOLET_CITADEL_SPIRE)
            target->CastSpell(target, SPELL_TELEPORT_SPIRE_DOWN, true);
            // teleport atop
        else
            target->CastSpell(target, SPELL_TELEPORT_SPIRE_UP, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_teleporting::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum PvPTrinketTriggeredSpells
{
    SPELL_WILL_OF_THE_FORSAKEN_COOLDOWN_TRIGGER         = 72752,
    SPELL_WILL_OF_THE_FORSAKEN_COOLDOWN_TRIGGER_WOTF    = 72757,
    SPELL_PVP_TRINKET                                   = 42292,
};

/* 72752 - Will of the Forsaken Cooldown Trigger
   72757 - Will of the Forsaken Cooldown Trigger (WOTF) */
class spell_pvp_trinket_wotf_shared_cd : public SpellScript
{
    PrepareSpellScript(spell_pvp_trinket_wotf_shared_cd);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({
            SPELL_WILL_OF_THE_FORSAKEN_COOLDOWN_TRIGGER,
            SPELL_WILL_OF_THE_FORSAKEN_COOLDOWN_TRIGGER_WOTF,
            SPELL_PVP_TRINKET });
    }

    void HandleScript()
    {
        Player* player = GetCaster()->ToPlayer();
        // This is only needed because spells cast from spell_linked_spell are triggered by default
        // Spell::SendSpellCooldown() skips all spells with TRIGGERED_IGNORE_SPELL_AND_CATEGORY_CD
        player->AddSpellAndCategoryCooldowns(GetSpellInfo(), GetCastItem() ? GetCastItem()->GetEntry() : 0, GetSpell());

        if (player->GetTeamId(true) == TEAM_HORDE)
        {
            if (GetSpellInfo()->Id == SPELL_WILL_OF_THE_FORSAKEN_COOLDOWN_TRIGGER)
            {
                WorldPacket data;
                player->BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_INCLUDE_GCD, 7744, GetSpellInfo()->CategoryRecoveryTime); // Will of the forsaken
                player->GetSession()->SendPacket(&data);
            }
            else
            {
                WorldPacket data(SMSG_INITIAL_SPELLS, (1 + 2 + 2 + 4 + 2 + 2 + 4 + 4));
                data << uint8(0);
                data << uint16(0);
                data << uint16(1);
                data << uint32(42292); // PvP Trinket spell
                data << uint16(0);                 // cast item id
                data << uint16(GetSpellInfo()->GetCategory());                   // spell category
                data << uint32(0);
                data << uint32(GetSpellInfo()->CategoryRecoveryTime);
                player->GetSession()->SendPacket(&data);

                WorldPacket data2;
                player->BuildCooldownPacket(data2, SPELL_COOLDOWN_FLAG_INCLUDE_GCD, SPELL_PVP_TRINKET, GetSpellInfo()->CategoryRecoveryTime); // PvP Trinket spell
                player->GetSession()->SendPacket(&data2);
            }
        }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_pvp_trinket_wotf_shared_cd::HandleScript);
    }
};

enum AnimalBloodPoolSpell
{
    SPELL_ANIMAL_BLOOD      = 46221,
    SPELL_SPAWN_BLOOD_POOL  = 63471,
    FACTION_DETHA_ATTACK    = 942
};

// 46221 - Animal Blood
class spell_gen_animal_blood : public AuraScript
{
    PrepareAuraScript(spell_gen_animal_blood);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SPAWN_BLOOD_POOL });
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        // Remove all auras with spell id 46221, except the one currently being applied
        while (Aura* aur = GetUnitOwner()->GetOwnedAura(SPELL_ANIMAL_BLOOD, ObjectGuid::Empty, ObjectGuid::Empty, 0, GetAura()))
            GetUnitOwner()->RemoveOwnedAura(aur);
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* owner = GetUnitOwner())
        {
            owner->CastSpell(owner, SPELL_SPAWN_BLOOD_POOL, true);
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_gen_animal_blood::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_gen_animal_blood::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

// 63471 - Spawn Blood Pool
class spell_spawn_blood_pool : public SpellScript
{
    PrepareSpellScript(spell_spawn_blood_pool);

    void SetDest(SpellDestination &dest)
    {
        Unit* caster = GetCaster();
        LiquidData liquidStatus = caster->GetMap()->GetLiquidData(caster->GetPhaseMask(), caster->GetPositionX(), caster->GetPositionY(), caster->GetPositionZ(), caster->GetCollisionHeight(), MAP_ALL_LIQUIDS);

        float level = liquidStatus.Level > INVALID_HEIGHT ? liquidStatus.Level : caster->GetPositionZ();
        Position pos = Position(caster->GetPositionX(), caster->GetPositionY(), level, caster->GetOrientation());
        dest.Relocate(pos);
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_spawn_blood_pool::SetDest, EFFECT_0, TARGET_DEST_CASTER);
    }
};

enum DivineStormSpell
{
    SPELL_DIVINE_STORM      = 53385,
};

// 70769 - Divine Storm!
class spell_gen_divine_storm_cd_reset : public SpellScript
{
    PrepareSpellScript(spell_gen_divine_storm_cd_reset);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DIVINE_STORM });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Player* caster = GetCaster()->ToPlayer();
        if (caster->HasSpellCooldown(SPELL_DIVINE_STORM))
            caster->RemoveSpellCooldown(SPELL_DIVINE_STORM, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_divine_storm_cd_reset::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

/* 60893 - Northrend Alchemy Research
   61177 - Northrend Inscription Research
   61288 - Minor Inscription Research
   61756 - Northrend Inscription Research (FAST QA VERSION) */
class spell_gen_profession_research : public SpellScript
{
    PrepareSpellScript(spell_gen_profession_research);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    SpellCastResult CheckRequirement()
    {
        if (HasDiscoveredAllSpells(GetSpellInfo()->Id, GetCaster()->ToPlayer()))
        {
            SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_NOTHING_TO_DISCOVER);
            return SPELL_FAILED_CUSTOM_ERROR;
        }

        return SPELL_CAST_OK;
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Player* caster = GetCaster()->ToPlayer();
        uint32 spellId = GetSpellInfo()->Id;

        // learn random explicit discovery recipe (if any)
        if (uint32 discoveredSpellId = GetExplicitDiscoverySpell(spellId, caster))
            caster->learnSpell(discoveredSpellId);

        caster->UpdateCraftSkill(spellId);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_gen_profession_research::CheckRequirement);
        OnEffectHitTarget += SpellEffectFn(spell_gen_profession_research::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/* 45204 - Clone Me!
   45785 - Sinister Reflection Clone
   49889 - Mystery of the Infinite: Future You's Mirror Image Aura
   50218 - The Cleansing: Your Inner Turmoil's Mirror Image Aura
   51719 - Altar of Quetz'lun: Material You's Mirror Image Aura
   57528 - Nightmare Figment Mirror Image */
class spell_gen_clone : public SpellScript
{
    PrepareSpellScript(spell_gen_clone);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (GetHitUnit())
        {
            GetHitUnit()->CastSpell(GetCaster(), uint32(GetEffectValue()), true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_clone::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
        OnEffectHitTarget += SpellEffectFn(spell_gen_clone::HandleScriptEffect, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum CloneWeaponSpells
{
    SPELL_COPY_WEAPON_AURA       = 41054,
    SPELL_COPY_WEAPON_2_AURA     = 63418,
    SPELL_COPY_WEAPON_3_AURA     = 69893,

    SPELL_COPY_OFFHAND_AURA      = 45205,
    SPELL_COPY_OFFHAND_2_AURA    = 69896,

    SPELL_COPY_RANGED_AURA       = 57594
};

/* 41055, 63416 - Copy Weapon
   45206 - Copy Off-hand Weapon
   57593 - Copy Ranged Weapon
   69891 - Copy Weapon (No Threat)
   69892 - Copy Off-hand Weapon (No Threat) */
class spell_gen_clone_weapon : public SpellScript
{
    PrepareSpellScript(spell_gen_clone_weapon);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (GetHitUnit())
        {
            GetHitUnit()->CastSpell(GetCaster(), uint32(GetEffectValue()), true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_clone_weapon::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/* 41054, 63418 - Copy Weapon
   45205 - Copy Offhand Weapon
   57594 - Copy Ranged Weapon
   69893 - Copy Weapon (No Threat)
   69896 - Copy Offhand Weapon (No Threat) */
class spell_gen_clone_weapon_aura : public AuraScript
{
    PrepareAuraScript(spell_gen_clone_weapon_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_COPY_WEAPON_AURA,
                SPELL_COPY_WEAPON_2_AURA,
                SPELL_COPY_WEAPON_3_AURA,
                SPELL_COPY_OFFHAND_AURA,
                SPELL_COPY_OFFHAND_2_AURA,
                SPELL_COPY_RANGED_AURA
            });
    }

    bool Load() override
    {
        prevItem = 0;
        return true;
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetTarget();
        if (!caster)
            return;

        switch (GetSpellInfo()->Id)
        {
            case SPELL_COPY_WEAPON_AURA:
            case SPELL_COPY_WEAPON_2_AURA:
            case SPELL_COPY_WEAPON_3_AURA:
                {
                    prevItem = target->GetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID);

                    if (Player* player = caster->ToPlayer())
                    {
                        if (Item* mainItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND))
                            target->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, mainItem->GetEntry());
                    }
                    else
                        target->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, caster->GetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID));
                    break;
                }
            case SPELL_COPY_OFFHAND_AURA:
            case SPELL_COPY_OFFHAND_2_AURA:
                {
                    prevItem = target->GetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1);

                    if (Player* player = caster->ToPlayer())
                    {
                        if (Item* offItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND))
                            target->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1, offItem->GetEntry());
                    }
                    else
                        target->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1, caster->GetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1));
                    break;
                }
            case SPELL_COPY_RANGED_AURA:
                {
                    prevItem = target->GetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 2);

                    if (Player* player = caster->ToPlayer())
                    {
                        if (Item* rangedItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED))
                            target->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 2, rangedItem->GetEntry());
                    }
                    else
                        target->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 2, caster->GetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 2));
                    break;
                }
            default:
                break;
        }
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();

        switch (GetSpellInfo()->Id)
        {
            case SPELL_COPY_WEAPON_AURA:
            case SPELL_COPY_WEAPON_2_AURA:
            case SPELL_COPY_WEAPON_3_AURA:
                target->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, prevItem);
                break;
            case SPELL_COPY_OFFHAND_AURA:
            case SPELL_COPY_OFFHAND_2_AURA:
                target->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1, prevItem);
                break;
            case SPELL_COPY_RANGED_AURA:
                target->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 2, prevItem);
                break;
            default:
                break;
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_gen_clone_weapon_aura::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        OnEffectRemove += AuraEffectRemoveFn(spell_gen_clone_weapon_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }

private:
    uint32 prevItem;
};

enum SeaforiumSpells
{
    SPELL_PLANT_CHARGES_CREDIT_ACHIEVEMENT  = 60937
};

// 52408 - Seaforium Blast
class spell_gen_seaforium_blast : public SpellScript
{
    PrepareSpellScript(spell_gen_seaforium_blast);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PLANT_CHARGES_CREDIT_ACHIEVEMENT });
    }

    bool Load() override
    {
        // OriginalCaster is always available in Spell::prepare
        return GetOriginalCaster()->IsPlayer();
    }

    void AchievementCredit(SpellEffIndex /*effIndex*/)
    {
        // but in effect handling OriginalCaster can become nullptr
        if (Unit* originalCaster = GetOriginalCaster())
            if (GameObject* go = GetHitGObj())
                if (go->GetGOValue()->Building.Health > 0 && go->GetGOInfo()->type == GAMEOBJECT_TYPE_DESTRUCTIBLE_BUILDING)
                    originalCaster->CastSpell(originalCaster, SPELL_PLANT_CHARGES_CREDIT_ACHIEVEMENT, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_seaforium_blast::AchievementCredit, EFFECT_1, SPELL_EFFECT_GAMEOBJECT_DAMAGE);
    }
};

enum FriendOrFowl
{
    SPELL_TURKEY_VENGEANCE      = 25285
};

// 25281 - Turkey Marker
class spell_gen_turkey_marker : public AuraScript
{
    PrepareAuraScript(spell_gen_turkey_marker);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_TURKEY_VENGEANCE });
    }

    bool Load() override
    {
        _applyTimes.clear();
        stackAmount = 0;
        return true;
    }

    void OnPeriodic(AuraEffect const* aurEff)
    {
        if (GetStackAmount() > stackAmount)
        {
            _applyTimes.push_back(GameTime::GetGameTimeMS().count());
            stackAmount++;
        }

        // pop stack if it expired for us
        if (_applyTimes.front() + GetMaxDuration() < GameTime::GetGameTimeMS().count())
        {
            stackAmount--;
            ModStackAmount(-1, AURA_REMOVE_BY_EXPIRE);
        }

        // dont cast this spell on every tick
        if (stackAmount >= 15 && stackAmount < 40)
        {
            stackAmount = 40;
            GetTarget()->CastSpell(GetTarget(), SPELL_TURKEY_VENGEANCE, true, nullptr, aurEff, GetCasterGUID());
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_gen_turkey_marker::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }

    std::list<uint32> _applyTimes;
    int16 stackAmount;
};

// -55428 - Lifeblood
class spell_gen_lifeblood : public AuraScript
{
    PrepareAuraScript(spell_gen_lifeblood);

    void CalculateAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (Unit* owner = GetUnitOwner())
            amount += int32(CalculatePct(owner->GetMaxHealth(), 1.5f / aurEff->GetTotalTicks()));
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_gen_lifeblood::CalculateAmount, EFFECT_0, SPELL_AURA_PERIODIC_HEAL);
    }
};

/* 4073 - Mechanical Dragonling
   12749 - Mithril Mechanical Dragonling
   13166 - Battle Chicken
   13258 - Summon Goblin Bomb
   19804 - Arcanite Dragonling */
class spell_gen_allow_cast_from_item_only : public SpellScript
{
    PrepareSpellScript(spell_gen_allow_cast_from_item_only);

    SpellCastResult CheckRequirement()
    {
        if (!GetCastItem())
            return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;
        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_gen_allow_cast_from_item_only::CheckRequirement);
    }
};

enum VehicleScaling
{
    SPELL_GEAR_SCALING      = 66668
};

// 65266, 65635, 65636, 66666, 66667, 66668 - Gear Scaling
class spell_gen_vehicle_scaling : public SpellScript
{
    PrepareSpellScript(spell_gen_vehicle_scaling);

    SpellCastResult CheckSeat()
    {
        if (Vehicle* veh = GetCaster()->GetVehicle())
            if (const VehicleSeatEntry* seatEntry = veh->GetSeatForPassenger(GetCaster()))
                if (seatEntry->m_flags & VEHICLE_SEAT_FLAG_CAN_CONTROL)
                    return SPELL_CAST_OK;

        return SPELL_FAILED_DONT_REPORT;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_gen_vehicle_scaling::CheckSeat);
    }
};

class spell_gen_vehicle_scaling_aura: public AuraScript
{
    PrepareAuraScript(spell_gen_vehicle_scaling_aura);

    bool Load() override
    {
        return GetCaster() && GetCaster()->IsPlayer() && GetOwner()->GetTypeId() == TYPEID_UNIT;
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        Unit* caster = GetCaster();
        float factor;
        uint16 baseItemLevel;

        /// @todo Reserach coeffs for different vehicles
        switch (GetId())
        {
            case SPELL_GEAR_SCALING:
                factor = 1.0f;
                baseItemLevel = 205;
                break;
            default:
                factor = 1.0f;
                baseItemLevel = 170;
                break;
        }

        float avgILvl = caster->ToPlayer()->GetAverageItemLevel();
        if (avgILvl < baseItemLevel)
            return;                     /// @todo Research possibility of scaling down

        amount = uint16((avgILvl - baseItemLevel) * factor);
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_gen_vehicle_scaling_aura::CalculateAmount, EFFECT_0, SPELL_AURA_MOD_HEALING_PCT);
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_gen_vehicle_scaling_aura::CalculateAmount, EFFECT_1, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_gen_vehicle_scaling_aura::CalculateAmount, EFFECT_2, SPELL_AURA_MOD_INCREASE_HEALTH_PERCENT);
    }
};

/* 53475 - Set Oracle Faction Friendly
   53487 - Set Wolvar Faction Honored
   54015 - Set Oracle Faction Honored */
class spell_gen_oracle_wolvar_reputation : public SpellScript
{
    PrepareSpellScript(spell_gen_oracle_wolvar_reputation);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        Player* player = GetCaster()->ToPlayer();
        uint32 factionId = GetSpellInfo()->Effects[effIndex].CalcValue();
        int32  repChange = GetSpellInfo()->Effects[EFFECT_1].CalcValue();

        FactionEntry const* factionEntry = sFactionStore.LookupEntry(factionId);

        if (!factionEntry)
            return;

        // Set rep to baserep + basepoints (expecting spillover for oposite faction -> become hated)
        // Not when player already has equal or higher rep with this faction
        if (player->GetReputationMgr().GetReputation(factionEntry) <= repChange)
            player->GetReputationMgr().SetReputation(factionEntry, static_cast<float>(repChange));

        // EFFECT_INDEX_2 most likely update at war state, we already handle this in SetReputation
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_gen_oracle_wolvar_reputation::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum DamageReductionAura
{
    SPELL_BLESSING_OF_SANCTUARY         = 20911,
    SPELL_GREATER_BLESSING_OF_SANCTUARY = 25899,
    SPELL_RENEWED_HOPE                  = 63944,
    SPELL_VIGILANCE                     = 50720,
    SPELL_DAMAGE_REDUCTION_AURA         = 68066
};

/* 20911 - Blessing of Sanctuary
   25899 - Greater Blessing of Sanctuary
   63944 - Renewed Hope */
class spell_gen_damage_reduction_aura : public AuraScript
{
    PrepareAuraScript(spell_gen_damage_reduction_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_DAMAGE_REDUCTION_AURA,
                SPELL_BLESSING_OF_SANCTUARY,
                SPELL_GREATER_BLESSING_OF_SANCTUARY,
                SPELL_RENEWED_HOPE,
                SPELL_VIGILANCE
            });
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->CastSpell(target, SPELL_DAMAGE_REDUCTION_AURA, true);
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (target->HasAura(SPELL_DAMAGE_REDUCTION_AURA) && !(target->HasAura(SPELL_BLESSING_OF_SANCTUARY) ||
                target->HasAura(SPELL_GREATER_BLESSING_OF_SANCTUARY) ||
                target->HasAura(SPELL_RENEWED_HOPE) ||
                target->HasAura(SPELL_VIGILANCE)))
        {
            target->RemoveAurasDueToSpell(SPELL_DAMAGE_REDUCTION_AURA);
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_gen_damage_reduction_aura::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        OnEffectRemove += AuraEffectRemoveFn(spell_gen_damage_reduction_aura::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};

enum DummyTrigger
{
    SPELL_PERSISTANT_SHIELD_TRIGGERED       = 26470,
    SPELL_PERSISTANT_SHIELD                 = 26467
};

// 13567 - Dummy Trigger
class spell_gen_dummy_trigger : public SpellScript
{
    PrepareSpellScript(spell_gen_dummy_trigger);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PERSISTANT_SHIELD_TRIGGERED, SPELL_PERSISTANT_SHIELD });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        int32 damage = GetEffectValue();
        Unit* caster = GetCaster();
        if (Unit* target = GetHitUnit())
            if (SpellInfo const* triggeredByAuraSpell = GetTriggeringSpell())
                if (triggeredByAuraSpell->Id == SPELL_PERSISTANT_SHIELD_TRIGGERED)
                    caster->CastCustomSpell(target, SPELL_PERSISTANT_SHIELD_TRIGGERED, &damage, nullptr, nullptr, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_dummy_trigger::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 17251 - Spirit Healer Res
class spell_gen_spirit_healer_res : public SpellScript
{
    PrepareSpellScript(spell_gen_spirit_healer_res);

    bool Load() override
    {
        return GetOriginalCaster() && GetOriginalCaster()->IsPlayer();
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Player* originalCaster = GetOriginalCaster()->ToPlayer();
        if (Unit* target = GetHitUnit())
        {
            WorldPacket data(SMSG_SPIRIT_HEALER_CONFIRM, 8);
            data << target->GetGUID();
            originalCaster->GetSession()->SendPacket(&data);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_spirit_healer_res::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum TransporterBackfires
{
    SPELL_TRANSPORTER_MALFUNCTION_POLYMORPH     = 23444,
    SPELL_TRANSPORTER_EVIL_TWIN                 = 23445,
    SPELL_TRANSPORTER_MALFUNCTION_MISS          = 36902
};

// 23448 - Transporter Arrival
class spell_gen_gadgetzan_transporter_backfire : public SpellScript
{
    PrepareSpellScript(spell_gen_gadgetzan_transporter_backfire)

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_TRANSPORTER_MALFUNCTION_POLYMORPH,
                SPELL_TRANSPORTER_EVIL_TWIN,
                SPELL_TRANSPORTER_MALFUNCTION_MISS
            });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Unit* caster = GetCaster();
        int32 r = irand(0, 119);
        if (r < 20)                           // Transporter Malfunction - 1/6 polymorph
            caster->CastSpell(caster, SPELL_TRANSPORTER_MALFUNCTION_POLYMORPH, true);
        else if (r < 100)                     // Evil Twin               - 4/6 evil twin
            caster->CastSpell(caster, SPELL_TRANSPORTER_EVIL_TWIN, true);
        else                                    // Transporter Malfunction - 1/6 miss the target
            caster->CastSpell(caster, SPELL_TRANSPORTER_MALFUNCTION_MISS, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_gadgetzan_transporter_backfire::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum GnomishTransporter
{
    SPELL_TRANSPORTER_SUCCESS                   = 23441,
    SPELL_TRANSPORTER_FAILURE                   = 23446
};

// 23453 - Gnomish Transporter
class spell_gen_gnomish_transporter : public SpellScript
{
    PrepareSpellScript(spell_gen_gnomish_transporter)

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_TRANSPORTER_SUCCESS, SPELL_TRANSPORTER_FAILURE });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        GetCaster()->CastSpell(GetCaster(), roll_chance_i(50) ? SPELL_TRANSPORTER_SUCCESS : SPELL_TRANSPORTER_FAILURE, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_gnomish_transporter::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 69641 - Gryphon/Wyvern Pet - Mounting Check Aura
class spell_gen_gryphon_wyvern_mount_check : public AuraScript
{
    PrepareAuraScript(spell_gen_gryphon_wyvern_mount_check);

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        Unit* target = GetTarget();
        Unit* owner = target->GetOwner();

        if (!owner)
        {
            return;
        }

        target->SetDisableGravity(owner->IsMounted());
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_gen_gryphon_wyvern_mount_check::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

enum DalaranDisguiseSpells
{
    SPELL_SUNREAVER_DISGUISE_TRIGGER       = 69672,
    SPELL_SUNREAVER_DISGUISE_FEMALE        = 70973,
    SPELL_SUNREAVER_DISGUISE_MALE          = 70974,

    SPELL_SILVER_COVENANT_DISGUISE_TRIGGER = 69673,
    SPELL_SILVER_COVENANT_DISGUISE_FEMALE  = 70971,
    SPELL_SILVER_COVENANT_DISGUISE_MALE    = 70972
};

/* 69673 - Silver Covenant Disguise (spell_gen_silver_covenant_disguise)
   69672 - Sunreaver Disguise       (spell_gen_sunreaver_disguise) */
class spell_gen_dalaran_disguise : public SpellScript
{
    PrepareSpellScript(spell_gen_dalaran_disguise);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_SUNREAVER_DISGUISE_TRIGGER,
                SPELL_SUNREAVER_DISGUISE_FEMALE,
                SPELL_SUNREAVER_DISGUISE_MALE,
                SPELL_SILVER_COVENANT_DISGUISE_TRIGGER,
                SPELL_SILVER_COVENANT_DISGUISE_FEMALE,
                SPELL_SILVER_COVENANT_DISGUISE_MALE
            });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Player* player = GetHitPlayer())
        {
            uint8 gender = player->getGender();

            uint32 spellId = GetSpellInfo()->Id;

            switch (spellId)
            {
                case SPELL_SUNREAVER_DISGUISE_TRIGGER:
                    spellId = gender ? SPELL_SUNREAVER_DISGUISE_FEMALE : SPELL_SUNREAVER_DISGUISE_MALE;
                    break;
                case SPELL_SILVER_COVENANT_DISGUISE_TRIGGER:
                    spellId = gender ? SPELL_SILVER_COVENANT_DISGUISE_FEMALE : SPELL_SILVER_COVENANT_DISGUISE_MALE;
                    break;
                default:
                    break;
            }

            GetCaster()->CastSpell(player, spellId, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_dalaran_disguise::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/* DOCUMENTATION: Break-Shield spells
    Break-Shield spells can be classified in three groups:

        - Spells on vehicle bar used by players:
            + EFFECT_0: SCRIPT_EFFECT
            + EFFECT_1: NONE
            + EFFECT_2: NONE
        - Spells cast by players triggered by script:
            + EFFECT_0: SCHOOL_DAMAGE
            + EFFECT_1: SCRIPT_EFFECT
            + EFFECT_2: FORCE_CAST
        - Spells cast by NPCs on players:
            + EFFECT_0: SCHOOL_DAMAGE
            + EFFECT_1: SCRIPT_EFFECT
            + EFFECT_2: NONE

    In the following script we handle the SCRIPT_EFFECT for effIndex EFFECT_0 and EFFECT_1.
        - When handling EFFECT_0 we're in the "Spells on vehicle bar used by players" case
          and we'll trigger "Spells cast by players triggered by script"
        - When handling EFFECT_1 we're in the "Spells cast by players triggered by script"
          or "Spells cast by NPCs on players" so we'll search for the first defend layer and drop it.
*/

enum BreakShieldSpells
{
    SPELL_BREAK_SHIELD_DAMAGE_2K                 = 62626,
    SPELL_BREAK_SHIELD_DAMAGE_10K                = 64590,

    SPELL_BREAK_SHIELD_TRIGGER_FACTION_MOUNTS    = 62575, // Also on ToC5 mounts
    SPELL_BREAK_SHIELD_TRIGGER_CAMPAING_WARHORSE = 64595,
    SPELL_BREAK_SHIELD_TRIGGER_UNK               = 66480,
    SPELL_BREAK_SHIELD_TRIGGER_SUNDERING_THURST  = 63825
};

/* 62575, 62626, 64342, 64590, 64595, 64686, 65147, 66480, 68504 - Shield-Breaker
   63233 - Necrocution
   63825 - Sundering Thrust
   64507 - Shield-Breaker Counter */
class spell_gen_break_shield : public SpellScript
{
    PrepareSpellScript(spell_gen_break_shield)

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_BREAK_SHIELD_DAMAGE_2K,
                SPELL_BREAK_SHIELD_DAMAGE_10K,
                SPELL_BREAK_SHIELD_TRIGGER_FACTION_MOUNTS,
                SPELL_BREAK_SHIELD_TRIGGER_CAMPAING_WARHORSE,
                SPELL_BREAK_SHIELD_TRIGGER_UNK,
                SPELL_BREAK_SHIELD_TRIGGER_SUNDERING_THURST
            });
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        Unit* target = GetHitUnit();

        switch (effIndex)
        {
            case EFFECT_0: // On spells wich trigger the damaging spell (and also the visual)
                {
                    uint32 spellId;

                    switch (GetSpellInfo()->Id)
                    {
                        case SPELL_BREAK_SHIELD_TRIGGER_UNK:
                        case SPELL_BREAK_SHIELD_TRIGGER_CAMPAING_WARHORSE:
                            spellId = SPELL_BREAK_SHIELD_DAMAGE_10K;
                            break;
                        case SPELL_BREAK_SHIELD_TRIGGER_FACTION_MOUNTS:
                        case SPELL_BREAK_SHIELD_TRIGGER_SUNDERING_THURST:
                            spellId = SPELL_BREAK_SHIELD_DAMAGE_2K;
                            break;
                        default:
                            return;
                    }

                    if (Unit* rider = GetCaster()->GetCharmer())
                        rider->CastSpell(target, spellId, false);
                    else
                        GetCaster()->CastSpell(target, spellId, false);
                    break;
                }
            case EFFECT_1: // On damaging spells, for removing a defend layer
                {
                    Unit::AuraApplicationMap const& auras = target->GetAppliedAuras();
                    for (Unit::AuraApplicationMap::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
                    {
                        if (Aura* aura = itr->second->GetBase())
                        {
                            SpellInfo const* auraInfo = aura->GetSpellInfo();
                            if (auraInfo && auraInfo->SpellIconID == 2007 && aura->HasEffectType(SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN))
                            {
                                aura->ModStackAmount(-1, AURA_REMOVE_BY_ENEMY_SPELL);
                                // Remove dummys from rider (Necessary for updating visual shields)
                                if (Unit* rider = target->GetCharmer())
                                    if (Aura* defend = rider->GetAura(aura->GetId()))
                                        defend->ModStackAmount(-1, AURA_REMOVE_BY_ENEMY_SPELL);
                                break;
                            }
                        }
                    }
                    break;
                }
            default:
                break;
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_break_shield::HandleScriptEffect, EFFECT_FIRST_FOUND, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/* DOCUMENTATION: Charge spells
    Charge spells can be classified in four groups:

        - Spells on vehicle bar used by players:
            + EFFECT_0: SCRIPT_EFFECT
            + EFFECT_1: TRIGGER_SPELL
            + EFFECT_2: NONE
        - Spells cast by player's mounts triggered by script:
            + EFFECT_0: CHARGE
            + EFFECT_1: TRIGGER_SPELL
            + EFFECT_2: APPLY_AURA
        - Spells cast by players on the target triggered by script:
            + EFFECT_0: SCHOOL_DAMAGE
            + EFFECT_1: SCRIPT_EFFECT
            + EFFECT_2: NONE
        - Spells cast by NPCs on players:
            + EFFECT_0: SCHOOL_DAMAGE
            + EFFECT_1: CHARGE
            + EFFECT_2: SCRIPT_EFFECT

    In the following script we handle the SCRIPT_EFFECT and CHARGE
        - When handling SCRIPT_EFFECT:
            + EFFECT_0: Corresponds to "Spells on vehicle bar used by players" and we make player's mount cast
              the charge effect on the current target , "Spells cast by player's mounts triggered by script").
            + EFFECT_1 and EFFECT_2: Triggered when "Spells cast by player's mounts triggered by script" hits target,
              corresponding to "Spells cast by players on the target triggered by script" and "Spells cast by
              NPCs on players" and we check Defend layers and drop a charge of the first found.
        - When handling CHARGE:
            + Only launched for "Spells cast by player's mounts triggered by script", makes the player cast the
              damaging spell on target with a small chance of failing it.
*/

enum ChargeSpells
{
    SPELL_CHARGE_DAMAGE_8K5             = 62874,
    SPELL_CHARGE_DAMAGE_20K             = 68498,
    SPELL_CHARGE_DAMAGE_45K             = 64591,

    SPELL_CHARGE_CHARGING_EFFECT_8K5    = 63661,
    SPELL_CHARGE_CHARGING_EFFECT_20K_1  = 68284,
    SPELL_CHARGE_CHARGING_EFFECT_20K_2  = 68501,
    SPELL_CHARGE_CHARGING_EFFECT_45K_1  = 62563,
    SPELL_CHARGE_CHARGING_EFFECT_45K_2  = 66481,

    SPELL_CHARGE_TRIGGER_FACTION_MOUNTS = 62960,
    SPELL_CHARGE_TRIGGER_TRIAL_CHAMPION = 68282,

    SPELL_CHARGE_MISS_EFFECT            = 62977,
};

// 62563, 62874, 62960, 63003, 63010, 63661, 64591, 66481, 68282, 68284, 68321, 68498, 68501 - Charge
class spell_gen_mounted_charge : public SpellScript
{
    PrepareSpellScript(spell_gen_mounted_charge)

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_CHARGE_DAMAGE_8K5,
                SPELL_CHARGE_DAMAGE_20K,
                SPELL_CHARGE_DAMAGE_45K,
                SPELL_CHARGE_CHARGING_EFFECT_8K5,
                SPELL_CHARGE_CHARGING_EFFECT_20K_1,
                SPELL_CHARGE_CHARGING_EFFECT_20K_2,
                SPELL_CHARGE_CHARGING_EFFECT_45K_1,
                SPELL_CHARGE_CHARGING_EFFECT_45K_2,
                SPELL_CHARGE_TRIGGER_FACTION_MOUNTS,
                SPELL_CHARGE_TRIGGER_TRIAL_CHAMPION,
                SPELL_CHARGE_MISS_EFFECT
            });
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        Unit* target = GetHitUnit();

        switch (effIndex)
        {
            case EFFECT_0: // On spells wich trigger the damaging spell (and also the visual)
                {
                    uint32 spellId;

                    switch (GetSpellInfo()->Id)
                    {
                        case SPELL_CHARGE_TRIGGER_TRIAL_CHAMPION:
                            spellId = SPELL_CHARGE_CHARGING_EFFECT_20K_1;
                            break;
                        case SPELL_CHARGE_TRIGGER_FACTION_MOUNTS:
                            spellId = SPELL_CHARGE_CHARGING_EFFECT_8K5;
                            break;
                        default:
                            return;
                    }

                    // If target isn't a training dummy there's a chance of failing the charge
                    if (!target->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE) && roll_chance_f(12.5f))
                        spellId = SPELL_CHARGE_MISS_EFFECT;

                    if (Unit* vehicle = GetCaster()->GetVehicleBase())
                        vehicle->CastSpell(target, spellId, false);
                    else
                        GetCaster()->CastSpell(target, spellId, false);
                    break;
                }
            case EFFECT_1: // On damaging spells, for removing a defend layer
            case EFFECT_2:
                {
                    Unit::AuraApplicationMap const& auras = target->GetAppliedAuras();
                    for (Unit::AuraApplicationMap::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
                    {
                        if (Aura* aura = itr->second->GetBase())
                        {
                            SpellInfo const* auraInfo = aura->GetSpellInfo();
                            if (auraInfo && auraInfo->SpellIconID == 2007 && aura->HasEffectType(SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN))
                            {
                                aura->ModStackAmount(-1, AURA_REMOVE_BY_ENEMY_SPELL);
                                // Remove dummys from rider (Necessary for updating visual shields)
                                if (Unit* rider = target->GetCharmer())
                                    if (Aura* defend = rider->GetAura(aura->GetId()))
                                        defend->ModStackAmount(-1, AURA_REMOVE_BY_ENEMY_SPELL);
                                break;
                            }
                        }
                    }
                    break;
                }
        }
    }

    void HandleChargeEffect(SpellEffIndex /*effIndex*/)
    {
        uint32 spellId;

        switch (GetSpellInfo()->Id)
        {
            case SPELL_CHARGE_CHARGING_EFFECT_8K5:
                spellId = SPELL_CHARGE_DAMAGE_8K5;
                break;
            case SPELL_CHARGE_CHARGING_EFFECT_20K_1:
            case SPELL_CHARGE_CHARGING_EFFECT_20K_2:
                spellId = SPELL_CHARGE_DAMAGE_20K;
                break;
            case SPELL_CHARGE_CHARGING_EFFECT_45K_1:
            case SPELL_CHARGE_CHARGING_EFFECT_45K_2:
                spellId = SPELL_CHARGE_DAMAGE_45K;
                break;
            default:
                return;
        }

        if (Unit* rider = GetCaster()->GetCharmer())
            rider->CastSpell(GetHitUnit(), spellId, false);
        else
            GetCaster()->CastSpell(GetHitUnit(), spellId, false);
    }

    void Register() override
    {
        SpellInfo const* spell = sSpellMgr->AssertSpellInfo(m_scriptSpellId);

        if (spell->HasEffect(SPELL_EFFECT_SCRIPT_EFFECT))
            OnEffectHitTarget += SpellEffectFn(spell_gen_mounted_charge::HandleScriptEffect, EFFECT_FIRST_FOUND, SPELL_EFFECT_SCRIPT_EFFECT);

        if (spell->Effects[EFFECT_0].Effect == SPELL_EFFECT_CHARGE)
            OnEffectHitTarget += SpellEffectFn(spell_gen_mounted_charge::HandleChargeEffect, EFFECT_0, SPELL_EFFECT_CHARGE);
    }
};

enum DefendVisuals
{
    SPELL_VISUAL_SHIELD_1 = 63130,
    SPELL_VISUAL_SHIELD_2 = 63131,
    SPELL_VISUAL_SHIELD_3 = 63132
};

// 62552, 62719, 66482 - Defend
class spell_gen_defend : public AuraScript
{
    PrepareAuraScript(spell_gen_defend);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_VISUAL_SHIELD_1,
                SPELL_VISUAL_SHIELD_2,
                SPELL_VISUAL_SHIELD_3
            });
    }

    void RefreshVisualShields(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        if (GetCaster())
        {
            Unit* target = GetTarget();

            for (uint8 i = 0; i < GetSpellInfo()->StackAmount; ++i)
                target->RemoveAurasDueToSpell(SPELL_VISUAL_SHIELD_1 + i);

            target->CastSpell(target, SPELL_VISUAL_SHIELD_1 + GetAura()->GetStackAmount() - 1, true, nullptr, aurEff);
        }
        else
            GetTarget()->RemoveAurasDueToSpell(GetId());
    }

    void RemoveVisualShields(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        for (uint8 i = 0; i < GetSpellInfo()->StackAmount; ++i)
            GetTarget()->RemoveAurasDueToSpell(SPELL_VISUAL_SHIELD_1 + i);
    }

    void RemoveDummyFromDriver(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            if (TempSummon* vehicle = caster->ToTempSummon())
                if (Unit* rider = vehicle->GetSummonerUnit())
                    rider->RemoveAurasDueToSpell(GetId());
    }

    void Register() override
    {
        SpellInfo const* spell = sSpellMgr->AssertSpellInfo(m_scriptSpellId);

        // Defend spells cast by NPCs (add visuals)
        if (spell->Effects[EFFECT_0].ApplyAuraName == SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN)
        {
            AfterEffectApply += AuraEffectApplyFn(spell_gen_defend::RefreshVisualShields, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            OnEffectRemove += AuraEffectRemoveFn(spell_gen_defend::RemoveVisualShields, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
        }

        // Remove Defend spell from player when he dismounts
        if (spell->Effects[EFFECT_2].ApplyAuraName == SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN)
            OnEffectRemove += AuraEffectRemoveFn(spell_gen_defend::RemoveDummyFromDriver, EFFECT_2, SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, AURA_EFFECT_HANDLE_REAL);

        // Defend spells cast by players (add/remove visuals)
        if (spell->Effects[EFFECT_1].ApplyAuraName == SPELL_AURA_DUMMY)
        {
            AfterEffectApply += AuraEffectApplyFn(spell_gen_defend::RefreshVisualShields, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            OnEffectRemove += AuraEffectRemoveFn(spell_gen_defend::RemoveVisualShields, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
        }
    }
};

// 41213, 43416, 69222, 73076 - Throw Shield
class spell_gen_throw_shield : public SpellScript
{
    PrepareSpellScript(spell_gen_throw_shield);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetCaster()->CastSpell(GetHitUnit(), uint32(GetEffectValue()), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_throw_shield::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum MountedDuelSpells
{
    SPELL_ON_TOURNAMENT_MOUNT = 63034,
    SPELL_MOUNTED_DUEL        = 62875
};

// 62863 - Duel
class spell_gen_tournament_duel : public SpellScript
{
    PrepareSpellScript(spell_gen_tournament_duel);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ON_TOURNAMENT_MOUNT, SPELL_MOUNTED_DUEL });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* rider = GetCaster()->GetCharmer())
        {
            if (Player* playerTarget = GetHitPlayer())
            {
                if (playerTarget->HasAura(SPELL_ON_TOURNAMENT_MOUNT) && playerTarget->GetVehicleBase())
                    rider->CastSpell(playerTarget, SPELL_MOUNTED_DUEL, true);
            }
            else if (Unit* unitTarget = GetHitUnit())
            {
                if (unitTarget->GetCharmer() && unitTarget->GetCharmer()->IsPlayer() && unitTarget->GetCharmer()->HasAura(SPELL_ON_TOURNAMENT_MOUNT))
                    rider->CastSpell(unitTarget->GetCharmer(), SPELL_MOUNTED_DUEL, true);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_tournament_duel::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum TournamentMountsSpells
{
    SPELL_LANCE_EQUIPPED     = 62853
};

/* 62774 - Summon Tournament Charger
   62779 - Summon Tournament Ram
   62780 - Summon Tournament Mechanostrider
   62781 - Summon Tournament Elekk
   62782 - Summon Tournament Nightsaber
   62783 - Summon Tournament Wolf
   62784 - Summon Tournament Raptor
   62785 - Summon Tournament Kodo
   62786 - Summon Tournament Hawkstrider
   62787 - Summon Tournament Warhorse
   63663 - Summon Tournament Argent Charger
   63791 - Summon Tournament Hawkstrider (Aspirant)
   63792 - Summon Tournament Steed (Aspirant) */
class spell_gen_summon_tournament_mount : public SpellScript
{
    PrepareSpellScript(spell_gen_summon_tournament_mount);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_LANCE_EQUIPPED });
    }

    SpellCastResult CheckIfLanceEquiped()
    {
        if (GetCaster()->IsInDisallowedMountForm())
            GetCaster()->RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);

        if (!GetCaster()->HasAura(SPELL_LANCE_EQUIPPED))
        {
            SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_MUST_HAVE_LANCE_EQUIPPED);
            return SPELL_FAILED_CUSTOM_ERROR;
        }

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_gen_summon_tournament_mount::CheckIfLanceEquiped);
    }
};

enum TournamentPennantSpells
{
    SPELL_PENNANT_STORMWIND_ASPIRANT        = 62595,
    SPELL_PENNANT_STORMWIND_VALIANT         = 62596,
    SPELL_PENNANT_STORMWIND_CHAMPION        = 62594,
    SPELL_PENNANT_GNOMEREGAN_ASPIRANT       = 63394,
    SPELL_PENNANT_GNOMEREGAN_VALIANT        = 63395,
    SPELL_PENNANT_GNOMEREGAN_CHAMPION       = 63396,
    SPELL_PENNANT_SEN_JIN_ASPIRANT          = 63397,
    SPELL_PENNANT_SEN_JIN_VALIANT           = 63398,
    SPELL_PENNANT_SEN_JIN_CHAMPION          = 63399,
    SPELL_PENNANT_SILVERMOON_ASPIRANT       = 63401,
    SPELL_PENNANT_SILVERMOON_VALIANT        = 63402,
    SPELL_PENNANT_SILVERMOON_CHAMPION       = 63403,
    SPELL_PENNANT_DARNASSUS_ASPIRANT        = 63404,
    SPELL_PENNANT_DARNASSUS_VALIANT         = 63405,
    SPELL_PENNANT_DARNASSUS_CHAMPION        = 63406,
    SPELL_PENNANT_EXODAR_ASPIRANT           = 63421,
    SPELL_PENNANT_EXODAR_VALIANT            = 63422,
    SPELL_PENNANT_EXODAR_CHAMPION           = 63423,
    SPELL_PENNANT_IRONFORGE_ASPIRANT        = 63425,
    SPELL_PENNANT_IRONFORGE_VALIANT         = 63426,
    SPELL_PENNANT_IRONFORGE_CHAMPION        = 63427,
    SPELL_PENNANT_UNDERCITY_ASPIRANT        = 63428,
    SPELL_PENNANT_UNDERCITY_VALIANT         = 63429,
    SPELL_PENNANT_UNDERCITY_CHAMPION        = 63430,
    SPELL_PENNANT_ORGRIMMAR_ASPIRANT        = 63431,
    SPELL_PENNANT_ORGRIMMAR_VALIANT         = 63432,
    SPELL_PENNANT_ORGRIMMAR_CHAMPION        = 63433,
    SPELL_PENNANT_THUNDER_BLUFF_ASPIRANT    = 63434,
    SPELL_PENNANT_THUNDER_BLUFF_VALIANT     = 63435,
    SPELL_PENNANT_THUNDER_BLUFF_CHAMPION    = 63436,
    SPELL_PENNANT_ARGENT_CRUSADE_ASPIRANT   = 63606,
    SPELL_PENNANT_ARGENT_CRUSADE_VALIANT    = 63500,
    SPELL_PENNANT_ARGENT_CRUSADE_CHAMPION   = 63501,
    SPELL_PENNANT_EBON_BLADE_ASPIRANT       = 63607,
    SPELL_PENNANT_EBON_BLADE_VALIANT        = 63608,
    SPELL_PENNANT_EBON_BLADE_CHAMPION       = 63609
};

enum TournamentMounts
{
    NPC_STORMWIND_STEED                     = 33217,
    NPC_IRONFORGE_RAM                       = 33316,
    NPC_GNOMEREGAN_MECHANOSTRIDER           = 33317,
    NPC_EXODAR_ELEKK                        = 33318,
    NPC_DARNASSIAN_NIGHTSABER               = 33319,
    NPC_ORGRIMMAR_WOLF                      = 33320,
    NPC_DARK_SPEAR_RAPTOR                   = 33321,
    NPC_THUNDER_BLUFF_KODO                  = 33322,
    NPC_SILVERMOON_HAWKSTRIDER              = 33323,
    NPC_FORSAKEN_WARHORSE                   = 33324,
    NPC_ARGENT_WARHORSE                     = 33782,
    NPC_ARGENT_STEED_ASPIRANT               = 33845,
    NPC_ARGENT_HAWKSTRIDER_ASPIRANT         = 33844
};

enum TournamentQuestsAchievements
{
    ACHIEVEMENT_CHAMPION_STORMWIND          = 2781,
    ACHIEVEMENT_CHAMPION_DARNASSUS          = 2777,
    ACHIEVEMENT_CHAMPION_IRONFORGE          = 2780,
    ACHIEVEMENT_CHAMPION_GNOMEREGAN         = 2779,
    ACHIEVEMENT_CHAMPION_THE_EXODAR         = 2778,
    ACHIEVEMENT_CHAMPION_ORGRIMMAR          = 2783,
    ACHIEVEMENT_CHAMPION_SEN_JIN            = 2784,
    ACHIEVEMENT_CHAMPION_THUNDER_BLUFF      = 2786,
    ACHIEVEMENT_CHAMPION_UNDERCITY          = 2787,
    ACHIEVEMENT_CHAMPION_SILVERMOON         = 2785,
    ACHIEVEMENT_ARGENT_VALOR                = 2758,
    ACHIEVEMENT_CHAMPION_ALLIANCE           = 2782,
    ACHIEVEMENT_CHAMPION_HORDE              = 2788,

    QUEST_VALIANT_OF_STORMWIND              = 13593,
    QUEST_A_VALIANT_OF_STORMWIND            = 13684,
    QUEST_VALIANT_OF_DARNASSUS              = 13706,
    QUEST_A_VALIANT_OF_DARNASSUS            = 13689,
    QUEST_VALIANT_OF_IRONFORGE              = 13703,
    QUEST_A_VALIANT_OF_IRONFORGE            = 13685,
    QUEST_VALIANT_OF_GNOMEREGAN             = 13704,
    QUEST_A_VALIANT_OF_GNOMEREGAN           = 13688,
    QUEST_VALIANT_OF_THE_EXODAR             = 13705,
    QUEST_A_VALIANT_OF_THE_EXODAR           = 13690,
    QUEST_VALIANT_OF_ORGRIMMAR              = 13707,
    QUEST_A_VALIANT_OF_ORGRIMMAR            = 13691,
    QUEST_VALIANT_OF_SEN_JIN                = 13708,
    QUEST_A_VALIANT_OF_SEN_JIN              = 13693,
    QUEST_VALIANT_OF_THUNDER_BLUFF          = 13709,
    QUEST_A_VALIANT_OF_THUNDER_BLUFF        = 13694,
    QUEST_VALIANT_OF_UNDERCITY              = 13710,
    QUEST_A_VALIANT_OF_UNDERCITY            = 13695,
    QUEST_VALIANT_OF_SILVERMOON             = 13711,
    QUEST_A_VALIANT_OF_SILVERMOON           = 13696
};

// 63034 - Player On Tournament Mount
class spell_gen_on_tournament_mount : public AuraScript
{
    PrepareAuraScript(spell_gen_on_tournament_mount);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_PENNANT_STORMWIND_ASPIRANT,
                SPELL_PENNANT_STORMWIND_VALIANT,
                SPELL_PENNANT_STORMWIND_CHAMPION,
                SPELL_PENNANT_GNOMEREGAN_ASPIRANT,
                SPELL_PENNANT_GNOMEREGAN_VALIANT,
                SPELL_PENNANT_GNOMEREGAN_CHAMPION,
                SPELL_PENNANT_SEN_JIN_ASPIRANT,
                SPELL_PENNANT_SEN_JIN_VALIANT,
                SPELL_PENNANT_SEN_JIN_CHAMPION,
                SPELL_PENNANT_SILVERMOON_ASPIRANT,
                SPELL_PENNANT_SILVERMOON_VALIANT,
                SPELL_PENNANT_SILVERMOON_CHAMPION,
                SPELL_PENNANT_DARNASSUS_ASPIRANT,
                SPELL_PENNANT_DARNASSUS_VALIANT,
                SPELL_PENNANT_DARNASSUS_CHAMPION,
                SPELL_PENNANT_EXODAR_ASPIRANT,
                SPELL_PENNANT_EXODAR_VALIANT,
                SPELL_PENNANT_EXODAR_CHAMPION,
                SPELL_PENNANT_IRONFORGE_ASPIRANT,
                SPELL_PENNANT_IRONFORGE_VALIANT,
                SPELL_PENNANT_IRONFORGE_CHAMPION,
                SPELL_PENNANT_UNDERCITY_ASPIRANT,
                SPELL_PENNANT_UNDERCITY_VALIANT,
                SPELL_PENNANT_UNDERCITY_CHAMPION,
                SPELL_PENNANT_ORGRIMMAR_ASPIRANT,
                SPELL_PENNANT_ORGRIMMAR_VALIANT,
                SPELL_PENNANT_ORGRIMMAR_CHAMPION,
                SPELL_PENNANT_THUNDER_BLUFF_ASPIRANT,
                SPELL_PENNANT_THUNDER_BLUFF_VALIANT,
                SPELL_PENNANT_THUNDER_BLUFF_CHAMPION,
                SPELL_PENNANT_ARGENT_CRUSADE_ASPIRANT,
                SPELL_PENNANT_ARGENT_CRUSADE_VALIANT,
                SPELL_PENNANT_ARGENT_CRUSADE_CHAMPION,
                SPELL_PENNANT_EBON_BLADE_ASPIRANT,
                SPELL_PENNANT_EBON_BLADE_VALIANT,
                SPELL_PENNANT_EBON_BLADE_CHAMPION
            });
    }

    uint32 _pennantSpellId;

    bool Load() override
    {
        _pennantSpellId = 0;
        return GetCaster() && GetCaster()->IsPlayer();
    }

    void HandleApplyEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (Unit* vehicle = caster->GetVehicleBase())
            {
                _pennantSpellId = GetPennatSpellId(caster->ToPlayer(), vehicle);
                caster->CastSpell(caster, _pennantSpellId, true);
            }
        }
    }

    void HandleRemoveEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            caster->RemoveAurasDueToSpell(_pennantSpellId);
    }

    uint32 GetPennatSpellId(Player* player, Unit* mount)
    {
        switch (mount->GetEntry())
        {
            case NPC_ARGENT_STEED_ASPIRANT:
            case NPC_STORMWIND_STEED:
                {
                    if (player->HasAchieved(ACHIEVEMENT_CHAMPION_STORMWIND))
                        return SPELL_PENNANT_STORMWIND_CHAMPION;
                    else if (player->GetQuestRewardStatus(QUEST_VALIANT_OF_STORMWIND) || player->GetQuestRewardStatus(QUEST_A_VALIANT_OF_STORMWIND))
                        return SPELL_PENNANT_STORMWIND_VALIANT;
                    else
                        return SPELL_PENNANT_STORMWIND_ASPIRANT;
                }
            case NPC_GNOMEREGAN_MECHANOSTRIDER:
                {
                    if (player->HasAchieved(ACHIEVEMENT_CHAMPION_GNOMEREGAN))
                        return SPELL_PENNANT_GNOMEREGAN_CHAMPION;
                    else if (player->GetQuestRewardStatus(QUEST_VALIANT_OF_GNOMEREGAN) || player->GetQuestRewardStatus(QUEST_A_VALIANT_OF_GNOMEREGAN))
                        return SPELL_PENNANT_GNOMEREGAN_VALIANT;
                    else
                        return SPELL_PENNANT_GNOMEREGAN_ASPIRANT;
                }
            case NPC_DARK_SPEAR_RAPTOR:
                {
                    if (player->HasAchieved(ACHIEVEMENT_CHAMPION_SEN_JIN))
                        return SPELL_PENNANT_SEN_JIN_CHAMPION;
                    else if (player->GetQuestRewardStatus(QUEST_VALIANT_OF_SEN_JIN) || player->GetQuestRewardStatus(QUEST_A_VALIANT_OF_SEN_JIN))
                        return SPELL_PENNANT_SEN_JIN_VALIANT;
                    else
                        return SPELL_PENNANT_SEN_JIN_ASPIRANT;
                }
            case NPC_ARGENT_HAWKSTRIDER_ASPIRANT:
            case NPC_SILVERMOON_HAWKSTRIDER:
                {
                    if (player->HasAchieved(ACHIEVEMENT_CHAMPION_SILVERMOON))
                        return SPELL_PENNANT_SILVERMOON_CHAMPION;
                    else if (player->GetQuestRewardStatus(QUEST_VALIANT_OF_SILVERMOON) || player->GetQuestRewardStatus(QUEST_A_VALIANT_OF_SILVERMOON))
                        return SPELL_PENNANT_SILVERMOON_VALIANT;
                    else
                        return SPELL_PENNANT_SILVERMOON_ASPIRANT;
                }
            case NPC_DARNASSIAN_NIGHTSABER:
                {
                    if (player->HasAchieved(ACHIEVEMENT_CHAMPION_DARNASSUS))
                        return SPELL_PENNANT_DARNASSUS_CHAMPION;
                    else if (player->GetQuestRewardStatus(QUEST_VALIANT_OF_DARNASSUS) || player->GetQuestRewardStatus(QUEST_A_VALIANT_OF_DARNASSUS))
                        return SPELL_PENNANT_DARNASSUS_VALIANT;
                    else
                        return SPELL_PENNANT_DARNASSUS_ASPIRANT;
                }
            case NPC_EXODAR_ELEKK:
                {
                    if (player->HasAchieved(ACHIEVEMENT_CHAMPION_THE_EXODAR))
                        return SPELL_PENNANT_EXODAR_CHAMPION;
                    else if (player->GetQuestRewardStatus(QUEST_VALIANT_OF_THE_EXODAR) || player->GetQuestRewardStatus(QUEST_A_VALIANT_OF_THE_EXODAR))
                        return SPELL_PENNANT_EXODAR_VALIANT;
                    else
                        return SPELL_PENNANT_EXODAR_ASPIRANT;
                }
            case NPC_IRONFORGE_RAM:
                {
                    if (player->HasAchieved(ACHIEVEMENT_CHAMPION_IRONFORGE))
                        return SPELL_PENNANT_IRONFORGE_CHAMPION;
                    else if (player->GetQuestRewardStatus(QUEST_VALIANT_OF_IRONFORGE) || player->GetQuestRewardStatus(QUEST_A_VALIANT_OF_IRONFORGE))
                        return SPELL_PENNANT_IRONFORGE_VALIANT;
                    else
                        return SPELL_PENNANT_IRONFORGE_ASPIRANT;
                }
            case NPC_FORSAKEN_WARHORSE:
                {
                    if (player->HasAchieved(ACHIEVEMENT_CHAMPION_UNDERCITY))
                        return SPELL_PENNANT_UNDERCITY_CHAMPION;
                    else if (player->GetQuestRewardStatus(QUEST_VALIANT_OF_UNDERCITY) || player->GetQuestRewardStatus(QUEST_A_VALIANT_OF_UNDERCITY))
                        return SPELL_PENNANT_UNDERCITY_VALIANT;
                    else
                        return SPELL_PENNANT_UNDERCITY_ASPIRANT;
                }
            case NPC_ORGRIMMAR_WOLF:
                {
                    if (player->HasAchieved(ACHIEVEMENT_CHAMPION_ORGRIMMAR))
                        return SPELL_PENNANT_ORGRIMMAR_CHAMPION;
                    else if (player->GetQuestRewardStatus(QUEST_VALIANT_OF_ORGRIMMAR) || player->GetQuestRewardStatus(QUEST_A_VALIANT_OF_ORGRIMMAR))
                        return SPELL_PENNANT_ORGRIMMAR_VALIANT;
                    else
                        return SPELL_PENNANT_ORGRIMMAR_ASPIRANT;
                }
            case NPC_THUNDER_BLUFF_KODO:
                {
                    if (player->HasAchieved(ACHIEVEMENT_CHAMPION_THUNDER_BLUFF))
                        return SPELL_PENNANT_THUNDER_BLUFF_CHAMPION;
                    else if (player->GetQuestRewardStatus(QUEST_VALIANT_OF_THUNDER_BLUFF) || player->GetQuestRewardStatus(QUEST_A_VALIANT_OF_THUNDER_BLUFF))
                        return SPELL_PENNANT_THUNDER_BLUFF_VALIANT;
                    else
                        return SPELL_PENNANT_THUNDER_BLUFF_ASPIRANT;
                }
            case NPC_ARGENT_WARHORSE:
                {
                    if (player->HasAchieved(ACHIEVEMENT_CHAMPION_ALLIANCE) || player->HasAchieved(ACHIEVEMENT_CHAMPION_HORDE))
                        return player->IsClass(CLASS_DEATH_KNIGHT) ? SPELL_PENNANT_EBON_BLADE_CHAMPION : SPELL_PENNANT_ARGENT_CRUSADE_CHAMPION;
                    else if (player->HasAchieved(ACHIEVEMENT_ARGENT_VALOR))
                        return player->IsClass(CLASS_DEATH_KNIGHT) ? SPELL_PENNANT_EBON_BLADE_VALIANT : SPELL_PENNANT_ARGENT_CRUSADE_VALIANT;
                    else
                        return player->IsClass(CLASS_DEATH_KNIGHT) ? SPELL_PENNANT_EBON_BLADE_ASPIRANT : SPELL_PENNANT_ARGENT_CRUSADE_ASPIRANT;
                }
            default:
                return 0;
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_gen_on_tournament_mount::HandleApplyEffect, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        OnEffectRemove += AuraEffectRemoveFn(spell_gen_on_tournament_mount::HandleRemoveEffect, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};

/* 62594 - Stormwind Champion's Pennant
   62595 - Stormwind Aspirant's Pennant
   62596 - Stormwind Valiant's Pennant
   63394 - Gnomeregan Aspirant's Pennant
   63395 - Gnomeregan Valiant's Pennant
   63396 - Gnomeregan Champion's Pennant
   63397 - Sen'jin Aspirant's Pennant
   63398 - Sen'jin Valiant's Pennant
   63399 - Sen'jin Champion's Pennant
   63401 - Silvermoon Aspirant's Pennant
   63402 - Silvermoon Valiant's Pennant
   63403 - Silvermoon Champion's Pennant
   63404 - Darnassus Aspirant's Pennant
   63405 - Darnassus Valiant's Pennant
   63406 - Darnassus Champion's Pennant
   63421 - Exodar Aspirant's Pennant
   63422 - Exodar Valiant's Pennant
   63423 - Exodar Champion's Pennant
   63425 - Ironforge Aspirant's Pennant
   63426 - Ironforge Valiant's Pennant
   63427 - Ironforge Champion's Pennant
   63428 - Undercity Aspirant's Pennant
   63429 - Undercity Valiant's Pennant
   63430 - Undercity Champion's Pennant
   63431 - Orgrimmar Aspirant's Pennant
   63432 - Orgrimmar Valiant's Pennant
   63433 - Orgrimmar Champion's Pennant
   63434 - Thunder Bluff Aspirant's Pennant
   63435 - Thunder Bluff Valiant's Pennant
   63436 - Thunder Bluff Champion's Pennant
   63500 - Argent Crusade Valiant's Pennant
   63501 - Argent Crusade Champion's Pennant
   63606 - Argent Crusade Aspirant's Pennant
   63607 - Ebon Blade Aspirant's Pennant
   63608 - Ebon Blade Valiant's Pennant
   63609 - Ebon Blade Champion's Pennant */
class spell_gen_tournament_pennant : public AuraScript
{
    PrepareAuraScript(spell_gen_tournament_pennant);

    bool Load() override
    {
        return GetCaster() && GetCaster()->IsPlayer();
    }

    void HandleApplyEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            if (!caster->GetVehicleBase())
                caster->RemoveAurasDueToSpell(GetId());
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_gen_tournament_pennant::HandleApplyEffect, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};

// 61698 - Serverside - Flush - Knockback effect
class spell_gen_ds_flush_knockback : public SpellScript
{
    PrepareSpellScript(spell_gen_ds_flush_knockback);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        // Here the target is the water spout and determines the position where the player is knocked from
        if (Unit* target = GetHitUnit())
        {
            if (Player* player = GetCaster()->ToPlayer())
            {
                float horizontalSpeed = 20.0f + (40.0f - GetCaster()->GetDistance(target));
                float verticalSpeed = 8.0f;
                // This method relies on the Dalaran Sewer map disposition and Water Spout position
                // What we do is knock the player from a position exactly behind him and at the end of the pipe
                player->KnockbackFrom(target->GetPositionX(), player->GetPositionY(), horizontalSpeed, verticalSpeed);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_ds_flush_knockback::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

/* 20625 - Ritual of Doom Sacrifice (spell_gen_default_count_pct_from_max_hp)
   29142 - Eyesore Blaster          (spell_gen_default_count_pct_from_max_hp)
   35139 - Throw Boom's Doom        (spell_gen_default_count_pct_from_max_hp)
   42393 - Brewfest - Attack Keg    (spell_gen_default_count_pct_from_max_hp)
   49882 - Leviroth Self-Impale     (spell_gen_default_count_pct_from_max_hp)
   55269 - Deathly Stare            (spell_gen_default_count_pct_from_max_hp)
   56578 - Rapid-Fire Harpoon       (spell_gen_default_count_pct_from_max_hp)
   56698 - Shadow Blast             (spell_gen_default_count_pct_from_max_hp)
   59102 - Shadow Blast             (spell_gen_default_count_pct_from_max_hp)
   60532 - Heart Explosion Effects  (spell_gen_default_count_pct_from_max_hp)
   60864 - Jaws of Death            (spell_gen_default_count_pct_from_max_hp)
   38441 - Cataclysmic Bolt                         (spell_gen_50pct_count_pct_from_max_hp)
   66316, 67100, 67101, 67102 - Spinning Pain Spike (spell_gen_50pct_count_pct_from_max_hp)
   33711/38794 - Murmur's Touch
   */
class spell_gen_count_pct_from_max_hp : public SpellScript
{
    PrepareSpellScript(spell_gen_count_pct_from_max_hp)

public:
    spell_gen_count_pct_from_max_hp(int32 damagePct = 0) : SpellScript(), _damagePct(damagePct) { }

    void RecalculateDamage()
    {
        if (!_damagePct)
            _damagePct = GetHitDamage();

        SetHitDamage(GetHitUnit()->CountPctFromMaxHealth(_damagePct));
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_gen_count_pct_from_max_hp::RecalculateDamage);
    }

private:
    int32 _damagePct;
};

/* 15998 - Capture Worg Pup
   25952 - Reindeer Dust Effect
   29435 - Capture Female Kaliri Hatchling
   42268 - Quest - Mindless Abomination Explosion FX Master
   51592 - Pickup Primordial Hatchling
   51910 - Kickin' Nass: Quest Completion
   52267 - Despawn Horse
   54420 - Deliver Gryphon */
class spell_gen_despawn_self : public SpellScript
{
    PrepareSpellScript(spell_gen_despawn_self);

    bool Load() override
    {
        return GetCaster()->GetTypeId() == TYPEID_UNIT;
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        if (GetSpellInfo()->Effects[effIndex].Effect == SPELL_EFFECT_DUMMY || GetSpellInfo()->Effects[effIndex].Effect == SPELL_EFFECT_SCRIPT_EFFECT)
            GetCaster()->ToCreature()->DespawnOrUnsummon(1);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_despawn_self::HandleDummy, EFFECT_ALL, SPELL_EFFECT_ANY);
    }
};

enum GenericBandage
{
    SPELL_RECENTLY_BANDAGED     = 11196
};

// 23567, 23568, 23569, 23696, 24412, 24413, 24414 - First Aid
class spell_gen_bandage : public SpellScript
{
    PrepareSpellScript(spell_gen_bandage);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_RECENTLY_BANDAGED });
    }

    SpellCastResult CheckCast()
    {
        if (Unit* target = GetExplTargetUnit())
        {
            if (target->HasAura(SPELL_RECENTLY_BANDAGED))
                return SPELL_FAILED_TARGET_AURASTATE;
        }
        return SPELL_CAST_OK;
    }

    void HandleScript()
    {
        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, SPELL_RECENTLY_BANDAGED, true);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_gen_bandage::CheckCast);
        AfterHit += SpellHitFn(spell_gen_bandage::HandleScript);
    }
};

enum ParalyticPoison
{
    SPELL_PARALYSIS = 35202
};

// 35201 - Paralytic Poison
class spell_gen_paralytic_poison : public AuraScript
{
    PrepareAuraScript(spell_gen_paralytic_poison);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return (sSpellMgr->GetSpellInfo(SPELL_PARALYSIS));
    }

    void HandleStun(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE)
        {
            return;
        }

        GetTarget()->CastSpell((Unit*)nullptr, SPELL_PARALYSIS, true, nullptr, aurEff);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_gen_paralytic_poison::HandleStun, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_gen_prevent_emotes : public AuraScript
{
    PrepareAuraScript(spell_gen_prevent_emotes);

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_gen_prevent_emotes::HandleEffectApply, EFFECT_FIRST_FOUND, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_gen_prevent_emotes::OnRemove, EFFECT_FIRST_FOUND, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
    }
};

enum BladeWarding
{
    SPELL_GEN_BLADE_WARDING_TRIGGERED = 64442
};

// Blade Warding - 64440
class spell_gen_blade_warding : public AuraScript
{
    PrepareAuraScript(spell_gen_blade_warding);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_GEN_BLADE_WARDING_TRIGGERED });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        Unit* caster = eventInfo.GetActionTarget();
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_GEN_BLADE_WARDING_TRIGGERED);
        if (!caster)
        {
            return;
        }

        uint8 stacks = GetStackAmount();
        int32 bp = 0;

        for (uint8 i = 0; i < stacks; ++i)
            bp += spellInfo->Effects[EFFECT_0].CalcValue(caster);

        caster->CastCustomSpell(SPELL_GEN_BLADE_WARDING_TRIGGERED, SPELLVALUE_BASE_POINT0, bp, eventInfo.GetActor(), TRIGGERED_FULL_MASK, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_gen_blade_warding::HandleProc, EFFECT_1, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

enum GenericLifebloom
{
    SPELL_HEXLORD_MALACRASS_LIFEBLOOM_FINAL_HEAL        = 43422,
    SPELL_TUR_RAGEPAW_LIFEBLOOM_FINAL_HEAL              = 52552,
    SPELL_CENARION_SCOUT_LIFEBLOOM_FINAL_HEAL           = 53692,
    SPELL_TWISTED_VISAGE_LIFEBLOOM_FINAL_HEAL           = 57763,
    SPELL_FACTION_CHAMPIONS_DRU_LIFEBLOOM_FINAL_HEAL    = 66094
};

/* 43421 - Lifebloom (spell_hexlord_lifebloom)
   52551 - Lifebloom (spell_tur_ragepaw_lifebloom)
   53608 - Lifebloom (spell_cenarion_scout_lifebloom)
   57762, 59990 - Lifebloom (spell_twisted_visage_lifebloom)
   66093, 67957, 67958, 67959 - Lifebloom (spell_faction_champion_dru_lifebloom) */
class spell_gen_lifebloom : public AuraScript
{
    PrepareAuraScript(spell_gen_lifebloom);

public:
    spell_gen_lifebloom(uint32 spellId) : AuraScript(), _spellId(spellId) { }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ _spellId });
    }

    void AfterRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        // Final heal only on duration end
        if (GetTargetApplication() && GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE && GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_ENEMY_SPELL)
        {
            return;
        }

        // final heal
        GetTarget()->CastSpell(GetTarget(), _spellId, true, nullptr, aurEff, GetCasterGUID());
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_gen_lifebloom::AfterRemove, EFFECT_0, SPELL_AURA_PERIODIC_HEAL, AURA_EFFECT_HANDLE_REAL);
    }

private:
    uint32 _spellId;
};

enum SummonElemental
{
    SPELL_SUMMON_FIRE_ELEMENTAL  = 8985,
    SPELL_SUMMON_EARTH_ELEMENTAL = 19704
};

/* 40133 - Summon Fire Elemental (spell_gen_summon_fire_elemental)
   40132 - Summon Earth Elemental (spell_gen_summon_earth_elemental) */
class spell_gen_summon_elemental : public AuraScript
{
    PrepareAuraScript(spell_gen_summon_elemental);

public:
    spell_gen_summon_elemental(uint32 spellId) : AuraScript(), _spellId(spellId) { }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ _spellId });
    }

    void AfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetCaster())
            if (Unit* owner = GetCaster()->GetOwner())
                owner->CastSpell(owner, _spellId, true);
    }

    void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetCaster())
            if (Unit* owner = GetCaster()->GetOwner())
                if (owner->IsPlayer()) /// @todo this check is maybe wrong
                    owner->ToPlayer()->RemovePet(nullptr, PET_SAVE_NOT_IN_SLOT, true);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_gen_summon_elemental::AfterApply, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_gen_summon_elemental::AfterRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }

private:
    uint32 _spellId;
};

enum Mounts
{
    SPELL_COLD_WEATHER_FLYING           = 54197,

    // Magic Broom
    SPELL_MAGIC_BROOM_60                = 42680,
    SPELL_MAGIC_BROOM_100               = 42683,
    SPELL_MAGIC_BROOM_150               = 42667,
    SPELL_MAGIC_BROOM_280               = 42668,

    // Headless Horseman's Mount
    SPELL_HEADLESS_HORSEMAN_MOUNT_60    = 51621,
    SPELL_HEADLESS_HORSEMAN_MOUNT_100   = 48024,
    SPELL_HEADLESS_HORSEMAN_MOUNT_150   = 51617,
    SPELL_HEADLESS_HORSEMAN_MOUNT_280   = 48023,

    // Winged Steed of the Ebon Blade
    SPELL_WINGED_STEED_150              = 54726,
    SPELL_WINGED_STEED_280              = 54727,

    // Big Love Rocket
    SPELL_BIG_LOVE_ROCKET_0             = 71343,
    SPELL_BIG_LOVE_ROCKET_60            = 71344,
    SPELL_BIG_LOVE_ROCKET_100           = 71345,
    SPELL_BIG_LOVE_ROCKET_150           = 71346,
    SPELL_BIG_LOVE_ROCKET_310           = 71347,

    // Invincible
    SPELL_INVINCIBLE_60                 = 72281,
    SPELL_INVINCIBLE_100                = 72282,
    SPELL_INVINCIBLE_150                = 72283,
    SPELL_INVINCIBLE_310                = 72284,

    // Blazing Hippogryph
    SPELL_BLAZING_HIPPOGRYPH_150        = 74854,
    SPELL_BLAZING_HIPPOGRYPH_280        = 74855,

    // Celestial Steed
    SPELL_CELESTIAL_STEED_60            = 75619,
    SPELL_CELESTIAL_STEED_100           = 75620,
    SPELL_CELESTIAL_STEED_150           = 75617,
    SPELL_CELESTIAL_STEED_280           = 75618,
    SPELL_CELESTIAL_STEED_310           = 76153,

    // X-53 Touring Rocket
    SPELL_X53_TOURING_ROCKET_150        = 75957,
    SPELL_X53_TOURING_ROCKET_280        = 75972,
    SPELL_X53_TOURING_ROCKET_310        = 76154,

    // Big Blizzard Bear
    SPELL_BIG_BLIZZARD_BEAR_60          = 58997,
    SPELL_BIG_BLIZZARD_BEAR_100         = 58999,
    SPELL_BIG_BLIZZARD_BEAR_150         = 58999,
    SPELL_BIG_BLIZZARD_BEAR_280         = 58999,
    SPELL_BIG_BLIZZARD_BEAR_310         = 58999
};

/* 58983 - Big Blizzard Bear (spell_big_blizzard_bear)
   47977 - Magic Broom (spell_magic_broom)
   48025 - Headless Horseman's Mount (spell_headless_horseman_mount)
   54729 - Winged Steed of the Ebon Blade (spell_winged_steed_of_the_ebon_blade)
   71342 - Big Love Rocket (spell_big_love_rocket)
   72286 - Invincible (spell_invincible)
   74856 - Blazing Hippogryph (spell_blazing_hippogryph)
   75614 - Celestial Steed (spell_celestial_steed)
   75973 - X-53 Touring Rocket (spell_x53_touring_rocket) */
class spell_gen_mount : public SpellScript
{
    PrepareSpellScript(spell_gen_mount);

public:
    spell_gen_mount(uint32 mount0, uint32 mount60, uint32 mount100, uint32 mount150, uint32 mount280, uint32 mount310) : SpellScript(),
        _mount0(mount0), _mount60(mount60), _mount100(mount100), _mount150(mount150), _mount280(mount280), _mount310(mount310) { }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        if (_mount0 && !sSpellMgr->GetSpellInfo(_mount0))
            return false;
        if (_mount60 && !sSpellMgr->GetSpellInfo(_mount60))
            return false;
        if (_mount100 && !sSpellMgr->GetSpellInfo(_mount100))
            return false;
        if (_mount150 && !sSpellMgr->GetSpellInfo(_mount150))
            return false;
        if (_mount280 && !sSpellMgr->GetSpellInfo(_mount280))
            return false;
        if (_mount310 && !sSpellMgr->GetSpellInfo(_mount310))
            return false;
        return true;
    }

    void HandleMount(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (Player* target = GetHitPlayer())
        {
            uint32 petNumber = target->GetTemporaryUnsummonedPetNumber();
            target->SetTemporaryUnsummonedPetNumber(0);

            // Prevent stacking of mounts and client crashes upon dismounting
            target->RemoveAurasByType(SPELL_AURA_MOUNTED, ObjectGuid::Empty, GetHitAura());

            // Triggered spell id dependent on riding skill and zone
            bool canFly = false;
            uint32 map = GetVirtualMapForMapAndZone(target->GetMapId(), target->GetZoneId());
            if (map == 530 || (map == 571 && target->HasSpell(SPELL_COLD_WEATHER_FLYING)))
                canFly = true;

            AreaTableEntry const* area = sAreaTableStore.LookupEntry(target->GetAreaId());
            // Xinef: add battlefield check
            Battlefield* Bf = sBattlefieldMgr->GetBattlefieldToZoneId(target->GetZoneId());
            if ((area && canFly && (area->flags & AREA_FLAG_NO_FLY_ZONE)) || (Bf && !Bf->CanFlyIn()))
                canFly = false;

            uint32 mount = 0;
            switch (target->GetBaseSkillValue(SKILL_RIDING))
            {
                case 0:
                    mount = _mount0;
                    break;
                case 75:
                    mount = _mount60;
                    break;
                case 150:
                    mount = _mount100;
                    break;
                case 225:
                    if (canFly)
                        mount = _mount150;
                    else
                        mount = _mount100;
                    break;
                case 300:
                    if (canFly)
                    {
                        if (_mount310 && target->Has310Flyer(false))
                            mount = _mount310;
                        else
                            mount = _mount280;
                    }
                    else
                        mount = _mount100;
                    break;
                default:
                    break;
            }

            if (mount)
            {
                PreventHitAura();
                target->CastSpell(target, mount, true);
            }

            if (petNumber)
                target->SetTemporaryUnsummonedPetNumber(petNumber);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_mount::HandleMount, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
    }

private:
    uint32 _mount0;
    uint32 _mount60;
    uint32 _mount100;
    uint32 _mount150;
    uint32 _mount280;
    uint32 _mount310;
};

enum FoamSword
{
    ITEM_FOAM_SWORD_GREEN   = 45061,
    ITEM_FOAM_SWORD_PINK    = 45176,
    ITEM_FOAM_SWORD_BLUE    = 45177,
    ITEM_FOAM_SWORD_RED     = 45178,
    ITEM_FOAM_SWORD_YELLOW  = 45179
};

// 64142 - Upper Deck - Create Foam Sword
class spell_gen_upper_deck_create_foam_sword : public SpellScript
{
    PrepareSpellScript(spell_gen_upper_deck_create_foam_sword);

    void HandleScript(SpellEffIndex effIndex)
    {
        if (Player* player = GetHitPlayer())
        {
            static uint32 const itemId[5] = { ITEM_FOAM_SWORD_GREEN, ITEM_FOAM_SWORD_PINK, ITEM_FOAM_SWORD_BLUE, ITEM_FOAM_SWORD_RED, ITEM_FOAM_SWORD_YELLOW };
            // player can only have one of these items
            for (uint8 i = 0; i < 5; ++i)
            {
                if (player->HasItemCount(itemId[i], 1, true))
                    return;
            }

            CreateItem(effIndex, itemId[urand(0, 4)]);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_upper_deck_create_foam_sword::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum Bonked
{
    SPELL_BONKED            = 62991,
    SPELL_FOAM_SWORD_DEFEAT = 62994,
    SPELL_ON_GUARD          = 62972
};

// 62991 - Bonked!
class spell_gen_bonked : public SpellScript
{
    PrepareSpellScript(spell_gen_bonked);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BONKED, SPELL_FOAM_SWORD_DEFEAT, SPELL_ON_GUARD });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Player* target = GetHitPlayer())
        {
            Aura const* aura = GetHitAura();
            if (!(aura && aura->GetStackAmount() == 3))
            {
                return;
            }

            target->CastSpell(target, SPELL_FOAM_SWORD_DEFEAT, true);
            target->RemoveAurasDueToSpell(SPELL_BONKED);

            if (Aura const* onGuardAura = target->GetAura(SPELL_ON_GUARD))
            {
                if (Item* item = target->GetItemByGuid(onGuardAura->GetCastItemGUID()))
                {
                    target->DestroyItemCount(item->GetEntry(), 1, true);
                }
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_bonked::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 28880, 59542, 59543, 59544, 59545, 59547, 59548 - Gift of the Naaru
class spell_gen_gift_of_naaru : public AuraScript
{
    PrepareAuraScript(spell_gen_gift_of_naaru);

    void CalculateAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (!GetCaster())
            return;

        float heal = 0.0f;
        switch (GetSpellInfo()->SpellFamilyName)
        {
            case SPELLFAMILY_MAGE:
            case SPELLFAMILY_WARLOCK:
            case SPELLFAMILY_PRIEST:
                heal = 1.885f * float(GetCaster()->SpellBaseDamageBonusDone(GetSpellInfo()->GetSchoolMask()));
                break;
            case SPELLFAMILY_PALADIN:
            case SPELLFAMILY_SHAMAN:
                heal = std::max(1.885f * float(GetCaster()->SpellBaseDamageBonusDone(GetSpellInfo()->GetSchoolMask())), 1.1f * float(GetCaster()->GetTotalAttackPowerValue(BASE_ATTACK)));
                break;
            case SPELLFAMILY_WARRIOR:
            case SPELLFAMILY_HUNTER:
            case SPELLFAMILY_DEATHKNIGHT:
                heal = 1.1f * float(std::max(GetCaster()->GetTotalAttackPowerValue(BASE_ATTACK), GetCaster()->GetTotalAttackPowerValue(RANGED_ATTACK)));
                break;
            case SPELLFAMILY_GENERIC:
            default:
                break;
        }

        int32 healTick = floor(heal / aurEff->GetTotalTicks());
        amount += int32(std::max(healTick, 0));
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_gen_gift_of_naaru::CalculateAmount, EFFECT_0, SPELL_AURA_PERIODIC_HEAL);
    }
};

enum Replenishment
{
    SPELL_REPLENISHMENT             = 57669,
    SPELL_INFINITE_REPLENISHMENT    = 61782
};

/* 57669 - Replenishment
   61782 - Infinite Replenishment + Wisdom */
class spell_gen_replenishment : public SpellScript
{
    PrepareSpellScript(spell_gen_replenishment);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_REPLENISHMENT, SPELL_INFINITE_REPLENISHMENT });
    }

    void RemoveInvalidTargets(std::list<WorldObject*>& targets)
    {
        // In arenas Replenishment may only affect the caster
        if (Player* caster = GetCaster()->ToPlayer())
        {
            if (caster->InArena())
            {
                targets.clear();
                targets.push_back(caster);
                return;
            }
        }

        targets.remove_if(Acore::PowerCheck(POWER_MANA, false));

        uint8 const maxTargets = 10;

        if (targets.size() > maxTargets)
        {
            targets.sort(Acore::PowerPctOrderPred(POWER_MANA));
            targets.resize(maxTargets);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_gen_replenishment::RemoveInvalidTargets, EFFECT_ALL, TARGET_UNIT_CASTER_AREA_RAID);
    }
};

class spell_gen_replenishment_aura : public AuraScript
{
    PrepareAuraScript(spell_gen_replenishment_aura);

    bool Load() override
    {
        return GetUnitOwner()->GetPower(POWER_MANA);
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        switch (GetSpellInfo()->Id)
        {
            case SPELL_REPLENISHMENT:
                amount = GetUnitOwner()->GetMaxPower(POWER_MANA) * 0.002f;
                break;
            case SPELL_INFINITE_REPLENISHMENT:
                amount = GetUnitOwner()->GetMaxPower(POWER_MANA) * 0.0025f;
                break;
            default:
                break;
        }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_gen_replenishment_aura::CalculateAmount, EFFECT_0, SPELL_AURA_PERIODIC_ENERGIZE);
    }
};

enum SpectatorCheerTrigger
{
    EMOTE_ONE_SHOT_CHEER        = 4,
    EMOTE_ONE_SHOT_EXCLAMATION  = 5,
    EMOTE_ONE_SHOT_APPLAUD      = 21
};

uint8 const EmoteArray[3] = { EMOTE_ONE_SHOT_CHEER, EMOTE_ONE_SHOT_EXCLAMATION, EMOTE_ONE_SHOT_APPLAUD };

// 55945 - Spectator - Cheer Trigger
class spell_gen_spectator_cheer_trigger : public SpellScript
{
    PrepareSpellScript(spell_gen_spectator_cheer_trigger)

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->HandleEmoteCommand(EmoteArray[urand(0, 2)]);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_spectator_cheer_trigger::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum VendorBarkTrigger
{
    NPC_AMPHITHEATER_VENDOR     = 30098,
    SAY_AMPHITHEATER_VENDOR     = 0
};

// 56096 - Vendor - Bark Trigger
class spell_gen_vendor_bark_trigger : public SpellScript
{
    PrepareSpellScript(spell_gen_vendor_bark_trigger)

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        if (Creature* vendor = GetCaster()->ToCreature())
        {
            if (vendor->GetEntry() == NPC_AMPHITHEATER_VENDOR && vendor->AI())
            {
                vendor->AI()->Talk(SAY_AMPHITHEATER_VENDOR);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_vendor_bark_trigger::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum WhisperGulchYoggSaronWhisper
{
    SPELL_YOGG_SARON_WHISPER_DUMMY  = 29072
};

// 27769 - Whisper Gulch: Yogg-Saron Whisper
class spell_gen_whisper_gulch_yogg_saron_whisper : public AuraScript
{
    PrepareAuraScript(spell_gen_whisper_gulch_yogg_saron_whisper);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_YOGG_SARON_WHISPER_DUMMY });
    }

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell((Unit*)nullptr, SPELL_YOGG_SARON_WHISPER_DUMMY, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_gen_whisper_gulch_yogg_saron_whisper::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 50630, 68576 - Eject All Passengers
class spell_gen_eject_all_passengers : public SpellScript
{
    PrepareSpellScript(spell_gen_eject_all_passengers);

    void RemoveVehicleAuras()
    {
        if (!GetHitUnit())
        {
            return;
        }

        Unit* u = nullptr;
        if (Vehicle* vehicle = GetHitUnit()->GetVehicleKit())
        {
            u = vehicle->GetPassenger(0);
            vehicle->RemoveAllPassengers();
        }
        if (u)
            u->RemoveAurasDueToSpell(VEHICLE_SPELL_PARACHUTE);
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_gen_eject_all_passengers::RemoveVehicleAuras);
    }
};

/* 62539 - Eject Passenger 2
   64614 - Eject Passenger 4
   64629 - Eject Passenger 1
   64630 - Eject Passenger 2
   64631 - Eject Passenger 3
   64632 - Eject Passenger 4
   64633 - Eject Passenger 5
   64634 - Eject Passenger 6
   64635 - Eject Passenger 7
   64636 - Eject Passenger 8
   67393 - Eject Passenger */
class spell_gen_eject_passenger : public SpellScript
{
    PrepareSpellScript(spell_gen_eject_passenger);

    bool Validate(SpellInfo const* spellInfo) override
    {
        if (spellInfo->Effects[EFFECT_0].CalcValue() < 1)
            return false;
        return true;
    }

    void EjectPassenger(SpellEffIndex /*effIndex*/)
    {
        if (Vehicle* vehicle = GetHitUnit()->GetVehicleKit())
        {
            if (Unit* passenger = vehicle->GetPassenger(GetEffectValue() - 1))
                passenger->ExitVehicle();
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_eject_passenger::EjectPassenger, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/* 37727 - Touch of Darkness
   37851 - Tag Greater Felfire Diemetradon
   37917 - Arcano-Cloak
   37918 - Arcano-pince
   37919 - Arcano-dismantle
   47911 - EMP
   48620 - Wing Buffet
   51748 - Signal Hemet to Attack
   51752 - Stampy's Stompy-Stomp
   51756 - Charge
   54996 - Ice Slick
   54997 - Cast Net
   56513 - Jormungar Strike
   56524 - Acid Breath */
// Used for some spells cast by vehicles or charmed creatures that do not send a cooldown event on their own.
class spell_gen_charmed_unit_spell_cooldown : public SpellScript
{
    PrepareSpellScript(spell_gen_charmed_unit_spell_cooldown);

    void HandleCast()
    {
        Unit* caster = GetCaster();
        if (Player* owner = caster->GetCharmerOrOwnerPlayerOrPlayerItself())
        {
            WorldPacket data;
            caster->BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_NONE, GetSpellInfo()->Id, GetSpellInfo()->RecoveryTime);
            owner->SendDirectMessage(&data);
        }
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_gen_charmed_unit_spell_cooldown::HandleCast);
    }
};

// 7102 Contagion of Rot
class spell_contagion_of_rot : public AuraScript
{
    PrepareAuraScript(spell_contagion_of_rot);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        // 7103 => triggered spell that spreads to others
        while (Aura* aur = GetUnitOwner()->GetOwnedAura(7103, ObjectGuid::Empty, ObjectGuid::Empty, 0, GetAura()))
        {
            GetUnitOwner()->RemoveOwnedAura(aur);
        }
        // 7102 => contagion of rot casted by mobs
        while (Aura* aur = GetUnitOwner()->GetOwnedAura(7102, ObjectGuid::Empty, ObjectGuid::Empty, 0, GetAura()))
        {
            GetUnitOwner()->RemoveOwnedAura(aur);
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_contagion_of_rot::OnApply, EFFECT_2, SPELL_AURA_PROC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

// 29519 - Silithyst
class spell_silithyst : public AuraScript
{
    PrepareAuraScript(spell_silithyst);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetCaster()->SetPvP(true);
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetCaster()->IsMounted())
        {
            GetCaster()->SummonGameObject(181597, GetCaster()->GetPositionX(), GetCaster()->GetPositionY(), GetCaster()->GetPositionZ(), 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 10 * IN_MILLISECONDS * MINUTE);
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_silithyst::OnApply, EFFECT_0, SPELL_AURA_MOD_DECREASE_SPEED, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_silithyst::OnRemove, EFFECT_0, SPELL_AURA_MOD_DECREASE_SPEED, AURA_EFFECT_HANDLE_REAL);
    }
};

enum HolidayFoodBuffEnum
{
    SPELL_WELL_FED = 24870,
};

// -24869 - Food
class spell_gen_holiday_buff_food : public AuraScript
{
    PrepareAuraScript(spell_gen_holiday_buff_food);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WELL_FED });
    }

    void TriggerFoodBuff(AuraEffect* aurEff)
    {
        if (aurEff->GetTickNumber() == 10 && GetUnitOwner())
        {
            GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_WELL_FED, TriggerCastFlags(TRIGGERED_IGNORE_AURA_INTERRUPT_FLAGS));
        }
    }

    void Register() override
    {
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_gen_holiday_buff_food::TriggerFoodBuff, EFFECT_0, SPELL_AURA_OBS_MOD_HEALTH);
    }
};

class spell_gen_arcane_charge : public SpellScript
{
    PrepareSpellScript(spell_gen_arcane_charge);

    SpellCastResult CheckRequirement()
    {
        if (Unit* target = GetExplTargetUnit())
        {
            if (target->GetCreatureType() != CREATURE_TYPE_DEMON && target->GetCreatureType() != CREATURE_TYPE_UNDEAD)
            {
                return SPELL_FAILED_DONT_REPORT;
            }
        }

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_gen_arcane_charge::CheckRequirement);
    }
};

// 20589 - Escape artist
// 30918 - Improved Sprint
class spell_gen_remove_impairing_auras : public SpellScript
{
    PrepareSpellScript(spell_gen_remove_impairing_auras);

    void HandleScriptEffect(SpellEffIndex /* effIndex */)
    {
        GetHitUnit()->RemoveMovementImpairingAuras(true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_remove_impairing_auras::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum AQSpells
{
    SPELL_CONSUME_LEECH_AQ20      = 25373,
    SPELL_CONSUME_LEECH_HEAL_AQ20 = 25378,
    SPELL_CONSUME_SPIT_OUT        = 25383,

    SPELL_HIVEZARA_CATALYST       = 25187,
    SPELL_VEKNISS_CATALYST        = 26078
};

class spell_gen_consume : public AuraScript
{
    PrepareAuraScript(spell_gen_consume);

public:
    spell_gen_consume(uint32 spellId1, uint32 spellId2) : AuraScript(), _spellId1(spellId1), _spellId2(spellId2) { }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ _spellId1, _spellId2 });
    }

    void HandleProc(AuraEffect* /*aurEff*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (!caster->IsAlive())
            {
                GetUnitOwner()->RemoveAurasDueToSpell(GetSpellInfo()->Id);
                return;
            }

            caster->CastSpell(GetUnitOwner(), _spellId1, true);
        }
    }

    void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication())
        {
            if (Unit* caster = GetCaster())
            {
                if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_DEATH)
                {
                    caster->CastSpell(caster, _spellId2, true);
                }
                else if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
                {
                    caster->CastSpell(GetTarget(), SPELL_CONSUME_SPIT_OUT, true);
                }
            }
        }
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_gen_consume::AfterRemove, EFFECT_1, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_gen_consume::HandleProc, EFFECT_2, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }

private:
    uint32 _spellId1;
    uint32 _spellId2;
};

class spell_gen_apply_aura_after_expiration : public AuraScript
{
    PrepareAuraScript(spell_gen_apply_aura_after_expiration);

public:
    spell_gen_apply_aura_after_expiration(uint32 spellId, uint32 effect, uint32 aura) : AuraScript(), _spellId(spellId), _effect(effect), _aura(aura) { }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ _spellId });
    }

    void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication() && GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
        {
            if (Unit* caster = GetCaster())
            {
                caster->CastSpell(GetTarget(), _spellId, true);
            }
        }
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_gen_apply_aura_after_expiration::AfterRemove, _effect, _aura, AURA_EFFECT_HANDLE_REAL);
    }

private:
    uint32 _spellId;
    uint32 _effect;
    uint32 _aura;
};

inline int32 SkillGainChance(uint32 SkillValue, uint32 GrayLevel, uint32 GreenLevel, uint32 YellowLevel)
{
    if (SkillValue >= GrayLevel)
    {
        return sWorld->getIntConfig(CONFIG_SKILL_CHANCE_GREY) * 10;
    }

    if (SkillValue >= GreenLevel)
    {
        return sWorld->getIntConfig(CONFIG_SKILL_CHANCE_GREEN) * 10;
    }

    if (SkillValue >= YellowLevel)
    {
        return sWorld->getIntConfig(CONFIG_SKILL_CHANCE_YELLOW) * 10;
    }

    return sWorld->getIntConfig(CONFIG_SKILL_CHANCE_ORANGE) * 10;
}

// 818 Basic Campfire
class spell_gen_basic_campfire : public SpellScript
{
    PrepareSpellScript(spell_gen_basic_campfire);

    void ModDest(SpellDestination& dest)
    {
        if (Unit* caster = GetCaster())
        {
            if (caster->GetMap()->GetGameObjectFloor(caster->GetPhaseMask(), caster->GetPositionX(), caster->GetPositionY(), caster->GetPositionZ()) == -G3D::finf())
            {
                float ground = caster->GetMap()->GetHeight(dest._position.GetPositionX(), dest._position.GetPositionY(), dest._position.GetPositionZ() + caster->GetCollisionHeight() * 0.5f);
                dest._position.m_positionZ = ground;
            }
        }
    }

    void ModifyCookingSkill(SpellEffIndex /*effIndex*/)
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            uint32 SkillValue = player->GetPureSkillValue(SKILL_COOKING);
            int32 chance = SkillGainChance(SkillValue, 75, 50, 25);
            player->UpdateSkillPro(SKILL_COOKING, chance, 1);
        }
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_gen_basic_campfire::ModDest, EFFECT_0, TARGET_DEST_CASTER_SUMMON);
        OnEffectHit += SpellEffectFn(spell_gen_basic_campfire::ModifyCookingSkill, EFFECT_0, SPELL_EFFECT_TRANS_DOOR);
    }
};

// 34779 - Freezing Circle
enum FreezingCircleSpells
{
    SPELL_FREEZING_CIRCLE_PIT_OF_SARON_NORMAL = 69574,
    SPELL_FREEZING_CIRCLE_PIT_OF_SARON_HEROIC = 70276,
    SPELL_FREEZING_CIRCLE                     = 34787,
};

class spell_freezing_circle : public SpellScript
{
    PrepareSpellScript(spell_freezing_circle);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_FREEZING_CIRCLE_PIT_OF_SARON_NORMAL,
                SPELL_FREEZING_CIRCLE_PIT_OF_SARON_HEROIC,
                SPELL_FREEZING_CIRCLE
            });
    }

    void HandleDamage(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        uint32 spellId = 0;
        Map* map = caster->GetMap();

        if (map->IsDungeon())
            spellId = map->IsHeroic() ? SPELL_FREEZING_CIRCLE_PIT_OF_SARON_HEROIC : SPELL_FREEZING_CIRCLE_PIT_OF_SARON_NORMAL;
        else
            spellId = SPELL_FREEZING_CIRCLE;

        if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId))
            SetHitDamage(spellInfo->Effects[EFFECT_0].CalcValue());
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_freezing_circle::HandleDamage, EFFECT_1, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

// 35385 - Threshalisk Charge
enum Threshalisk
{
    SPELL_THRESHALISK_CHARGE = 35385,
    SPELL_RUSHING_CHARGE     = 35382,
};

class spell_gen_threshalisk_charge : public SpellScript
{
    PrepareSpellScript(spell_gen_threshalisk_charge);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_THRESHALISK_CHARGE });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Creature* caster = GetCaster()->ToCreature())
        {
            if (Unit* victim = caster->GetVictim())
            {
                if (caster->GetReactState() != REACT_PASSIVE)
                {
                    caster->CastSpell(victim, GetSpellInfo()->Effects[EFFECT_1].TriggerSpell, true);
                }
            }
        }
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_gen_threshalisk_charge::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 37589 - Shriveling Gaze
enum ShrivelingGaze
{
    SPELL_SHRIVELING_GAZE         = 37589,
    SPELL_SHRIVELING_GAZE_REMOVAL = 30023, // Serverside - Gushing Wound Removal
};

class spell_gen_shriveling_gaze : public AuraScript
{
    PrepareAuraScript(spell_gen_shriveling_gaze);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SHRIVELING_GAZE });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        ModStackAmount(20);
    }

    void OnPeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        ModStackAmount(-1);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_gen_shriveling_gaze::HandleApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_gen_shriveling_gaze::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

// 38048 - Curse of Pain
enum CurseOfPain
{
    SPELL_CURSE_OF_PAIN           = 38048,
};

class spell_gen_curse_of_pain : public AuraScript
{
    PrepareAuraScript(spell_gen_curse_of_pain);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CURSE_OF_PAIN });
    }

    void OnPeriodic(AuraEffect const* /*aurEff*/)
    {
        Unit* target = GetTarget();
        if (target && target->ToPlayer())
        {
            if (target->GetHealthPct() < 50.f)
            {
                target->RemoveAurasDueToSpell(SPELL_CURSE_OF_PAIN);
            }
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_gen_curse_of_pain::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

enum SpiritofCompetition
{
    // Spells
    SPELL_SPIRIT_OF_COMPETITION_PARTICIPANT_EFFECT = 48056,
    SPELL_SPIRIT_OF_COMPETITION_WINNER_EFFECT      = 48057,
    // Mail
    MAIL_THE_COMPETITIORS_TABARD                   = 195,
    MAIL_A_GOLD_MEDALLION                          = 196,
    // NPC
    NPC_SPIRIT_OF_COMPETITION                      = 27217,
    // Items
    ITEM_COMPETITORS_TABARD                        = 36941,
    ITEM_GOLD_MEDALLION                            = 37297,
};

class spell_gen_spirit_of_competition_participant : public SpellScript
{
    PrepareSpellScript(spell_gen_spirit_of_competition_participant);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SPIRIT_OF_COMPETITION_PARTICIPANT_EFFECT });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Player* player = GetHitPlayer())
        {
            player->CastSpell(player, SPELL_SPIRIT_OF_COMPETITION_PARTICIPANT_EFFECT, true);

            Item* item = Item::CreateItem(ITEM_COMPETITORS_TABARD, 1);
            if (!item)
                return;

            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
            MailDraft(MAIL_THE_COMPETITIORS_TABARD)
                .AddItem(item)
                .SendMailTo(trans, player, MailSender(NPC_SPIRIT_OF_COMPETITION), MAIL_CHECK_MASK_HAS_BODY);
            CharacterDatabase.CommitTransaction(trans);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_spirit_of_competition_participant::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_gen_spirit_of_competition_winner : public SpellScript
{
    PrepareSpellScript(spell_gen_spirit_of_competition_winner);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SPIRIT_OF_COMPETITION_WINNER_EFFECT });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Player* player = GetHitPlayer())
        {
            player->CastSpell(player, SPELL_SPIRIT_OF_COMPETITION_WINNER_EFFECT, true);

            Item* item = Item::CreateItem(ITEM_GOLD_MEDALLION, 1);
            if (!item)
                return;

            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
            MailDraft(MAIL_A_GOLD_MEDALLION)
                .AddItem(item)
                .SendMailTo(trans, player, MailSender(NPC_SPIRIT_OF_COMPETITION), MAIL_CHECK_MASK_HAS_BODY);
            CharacterDatabase.CommitTransaction(trans);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_spirit_of_competition_winner::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 27360 - Lord Valthalak's Amulet
enum Valthalak
{
    SPELL_INSTILL_LORD_VALTHALAK_SPIRIT = 27360,
    NPC_LORD_VALTHALAK                  = 16042
};

class spell_gen_valthalak_amulet : public SpellScript
{
    PrepareSpellScript(spell_gen_valthalak_amulet)

    SpellCastResult CheckCast()
    {
        if (Unit* target = GetExplTargetUnit())
            if (target->GetEntry() == NPC_LORD_VALTHALAK && target->isDead())
                return SPELL_CAST_OK;

        return SPELL_FAILED_BAD_TARGETS;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_gen_valthalak_amulet::CheckCast);
    }
};

enum ScourgeBanner
{
    GO_COMMAND_TENT = 176210,
};

class spell_gen_planting_scourge_banner : public SpellScript
{
    PrepareSpellScript(spell_gen_planting_scourge_banner)

    SpellCastResult CheckCast()
    {
        if (GameObject* tent = GetCaster()->FindNearestGameObject(GO_COMMAND_TENT, 20.0f))
            if (tent->GetGoState() != GO_STATE_READY) // If tent is burned down
                return SPELL_CAST_OK;

        return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_gen_planting_scourge_banner::CheckCast);
    }
};

enum Jubling
{
    SPELL_JUBLING_COOLDOWN_1_WEEK = 23852
};

// 23853 - Jubling Cooldown
class spell_gen_jubling_cooldown : public SpellScript
{
    PrepareSpellScript(spell_gen_jubling_cooldown);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_JUBLING_COOLDOWN_1_WEEK });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Player* target = GetHitPlayer())
        {
            target->CastSpell(target, SPELL_JUBLING_COOLDOWN_1_WEEK); // 1 week
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_jubling_cooldown::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 12699 - Yeh'kinya's Bramble
enum YehkinyaBramble
{
    NPC_VALE_SCREECHER       = 5307,
    NPC_ROGUE_VALE_SCREECHER = 5308
};

class spell_gen_yehkinya_bramble : public SpellScript
{
    PrepareSpellScript(spell_gen_yehkinya_bramble)

    SpellCastResult CheckCast()
    {
        if (Unit* target = GetExplTargetUnit())
            if ((target->GetEntry() == NPC_VALE_SCREECHER || target->GetEntry() == NPC_ROGUE_VALE_SCREECHER) && target->isDead())
                return SPELL_CAST_OK;

        return SPELL_FAILED_BAD_TARGETS;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_gen_yehkinya_bramble::CheckCast);
    }
};

// 35244 - Choking Vines
enum ChokingVines
{
    SPELL_CHOKING_VINES = 35244,
    SPELL_CHOKING_WOUND = 35247
};

class spell_gen_choking_vines : public AuraScript
{
    PrepareAuraScript(spell_gen_choking_vines);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CHOKING_VINES, SPELL_CHOKING_WOUND });
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetTarget())
        {
            if (GetStackAmount() == GetSpellInfo()->StackAmount) // 5 stacks
            {
                target->RemoveAurasDueToSpell(SPELL_CHOKING_VINES);
                target->CastSpell(target, SPELL_CHOKING_WOUND, true); // Unknown if it's a self cast or casted by the source on 5th
            }
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_gen_choking_vines::OnApply, EFFECT_0, SPELL_AURA_MOD_DECREASE_SPEED, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};

 // 28865 - Consumption
class spell_gen_consumption : public SpellScript
{
    PrepareSpellScript(spell_gen_consumption);

    void CalculateDamage(SpellEffIndex /*effIndex*/)
    {
        Map* map = GetCaster()->GetMap();
        if (!map)
        {
            return;
        }
        int32 value = 0;
        if (map->GetDifficulty() == RAID_DIFFICULTY_25MAN_NORMAL) // NAXX25 N
        {
            value = urand(4500, 4700);
        }
        else if (map->GetId() == 533) // NAXX10 N
        {
            value = urand(3000, 3200);
        }
        else if (map->GetId() == 532) // Karazhan
        {
            value = urand(1110, 1310);
        }
        if (value)
        {
            SetEffectValue(value);
        }
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_gen_consumption::CalculateDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

// 37591 - Drunken Haze | 29690 - Drunken Skull Crack
enum DrunkenHaze
{
    SPELL_DRUNKEN_HAZE        = 37591,
    SPELL_DRUNKEN_SKULL_CRACK = 29690
};

class spell_gen_sober_up : public AuraScript
{
    PrepareAuraScript(spell_gen_sober_up);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DRUNKEN_HAZE, SPELL_DRUNKEN_SKULL_CRACK });
    }

    void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (!target && !target->ToPlayer())
            return;

        SpellEffIndex InebriateEffIndex = EFFECT_0;
        if (Player* player = target->ToPlayer())
        {
            switch (GetSpellInfo()->Id)
            {
                case SPELL_DRUNKEN_HAZE:
                    InebriateEffIndex = EFFECT_1;
                    break;
                case SPELL_DRUNKEN_SKULL_CRACK:
                    InebriateEffIndex = EFFECT_2;
                    break;
            }

            uint16 level = aurEff->GetSpellInfo()->Effects[InebriateEffIndex].CalcValue();
            player->SetDrunkValue(player->GetDrunkValue() - (level > 100 ? 100 : level)); // Some (maybe it's only 29690) spells can have over 100 inebriate points
        }
    }

    void Register() override
    {
        if (m_scriptSpellId == SPELL_DRUNKEN_HAZE)
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_gen_sober_up::OnRemove, EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
        }
        else
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_gen_sober_up::OnRemove, EFFECT_1, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
        }
    }
};

enum StealWeapon
{
    SPELL_STEAL_WEAPON = 36207, // in 36208 as script_effect
    NPC_GLUMDOR        = 20730,
    SAY_GLUMDOR_STEAL  = 0      // Stupid, squishy $r. That weapon mine now! Give!
};

 // 36208 - Steal Weapon
class spell_gen_steal_weapon : public AuraScript
{
    PrepareAuraScript(spell_gen_steal_weapon);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_STEAL_WEAPON });
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetTarget();
        if (!caster || !target)
            return;

        if (Creature* stealer = caster->ToCreature())
        {
            if (Player* player = target->ToPlayer())
            {
                if (Item* mainItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND))
                {
                    stealer->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, mainItem->GetEntry());
                    stealer->CastSpell(stealer, SPELL_STEAL_WEAPON, true);

                    if (stealer->GetEntry() == NPC_GLUMDOR)
                    {
                        stealer->AI()->Talk(SAY_GLUMDOR_STEAL, player);
                    }
                }
            }
            // He can steal creature weapons too
            if (Creature* creature = target->ToCreature())
            {
                int8 mainhand = 1;
                if (EquipmentInfo const* eInfo = sObjectMgr->GetEquipmentInfo(creature->GetEntry(), mainhand))
                {
                    stealer->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, eInfo->ItemEntry[0]);
                    stealer->CastSpell(stealer, SPELL_STEAL_WEAPON, true);
                }
            }
        }
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();
        if (!caster)
            return;

        if (Creature* stealer = caster->ToCreature())
        {
            stealer->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, 0);
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_gen_steal_weapon::OnApply, EFFECT_1, SPELL_AURA_MOD_DISARM, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_gen_steal_weapon::OnRemove, EFFECT_1, SPELL_AURA_MOD_DISARM, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_generic_spell_scripts()
{
    RegisterSpellScript(spell_silithyst);
    RegisterSpellScript(spell_gen_5000_gold);
    RegisterSpellScript(spell_gen_model_visible);
    RegisterSpellScript(spell_the_flag_of_ownership);
    RegisterSpellScript(spell_gen_have_item_auras);
    RegisterSpellScript(spell_gen_mine_sweeper);
    RegisterSpellAndAuraScriptPair(spell_gen_reduced_above_60, spell_gen_reduced_above_60_aura);
    RegisterSpellScriptWithArgs(spell_gen_relocaste_dest, "spell_q10838_demoniac_scryer_visual", 0, 0, 20.0, 0);
    RegisterSpellScriptWithArgs(spell_gen_relocaste_dest, "spell_q20438_q24556_aquantos_laundry", 0, 0, 7.0f, 0);
    RegisterSpellScript(spell_gen_allow_proc_from_spells_with_cost);
    RegisterSpellScript(spell_gen_bg_preparation);
    RegisterSpellScriptWithArgs(spell_gen_disabled_above_level, "spell_gen_disabled_above_73", 73);
    RegisterSpellScriptWithArgs(spell_gen_disabled_above_level, "spell_gen_disabled_above_70", 70);
    RegisterSpellScript(spell_pet_hit_expertise_scalling);
    RegisterSpellScript(spell_gen_grow_flower_patch);
    RegisterSpellScript(spell_gen_rallying_cry_of_the_dragonslayer);
    RegisterSpellScript(spell_gen_adals_song_of_battle);
    RegisterSpellScript(spell_gen_disabled_above_63);
    RegisterSpellScript(spell_gen_black_magic_enchant);
    RegisterSpellScript(spell_gen_area_aura_select_players);
    RegisterSpellScript(spell_gen_area_aura_select_players_and_caster);
    RegisterSpellScriptWithArgs(spell_gen_select_target_count, "spell_gen_select_target_count_15_1", TARGET_UNIT_SRC_AREA_ENEMY, 1);
    RegisterSpellScriptWithArgs(spell_gen_select_target_count, "spell_gen_select_target_count_15_2", TARGET_UNIT_SRC_AREA_ENEMY, 2);
    RegisterSpellScriptWithArgs(spell_gen_select_target_count, "spell_gen_select_target_count_15_5", TARGET_UNIT_SRC_AREA_ENEMY, 5);
    RegisterSpellScriptWithArgs(spell_gen_select_target_count, "spell_gen_select_target_count_7_1", TARGET_UNIT_SRC_AREA_ENTRY, 1);
    RegisterSpellScriptWithArgs(spell_gen_select_target_count, "spell_gen_select_target_count_24_1", TARGET_UNIT_CONE_ENEMY_24, 1);
    RegisterSpellScriptWithArgs(spell_gen_select_target_count, "spell_gen_select_target_count_30_1", TARGET_UNIT_SRC_AREA_ALLY, 1);
    RegisterSpellScript(spell_gen_use_spell_base_level_check);
    RegisterSpellScript(spell_gen_proc_from_direct_damage);
    RegisterSpellScript(spell_gen_no_offhand_proc);
    RegisterSpellScript(spell_gen_proc_on_self);
    RegisterSpellScript(spell_gen_proc_not_self);
    RegisterSpellScript(spell_gen_baby_murloc_passive);
    RegisterSpellScript(spell_gen_baby_murloc);
    RegisterSpellAndAuraScriptPair(spell_gen_fixate, spell_gen_fixate_aura);
    RegisterSpellScript(spell_gen_proc_above_75);
    RegisterSpellScript(spell_gen_periodic_knock_away);
    RegisterSpellScript(spell_gen_knock_away);
    RegisterSpellScript(spell_gen_mod_radius_by_caster_scale);
    RegisterSpellScript(spell_gen_proc_reduced_above_60);
    RegisterSpellScript(spell_gen_visual_dummy_stun);
    RegisterSpellScript(spell_gen_random_target32);
    RegisterSpellScript(spell_gen_hate_to_zero);
    RegisterSpellScript(spell_gen_focused_bursts);
    RegisterSpellScript(spell_gen_flurry_of_claws);
    RegisterSpellScript(spell_gen_throw_back);
    RegisterSpellAndAuraScriptPair(spell_gen_haunted, spell_gen_haunted_aura);
    RegisterSpellScript(spell_gen_absorb0_hitlimit1);
    RegisterSpellScript(spell_gen_adaptive_warding);
    RegisterSpellScript(spell_gen_av_drekthar_presence);
    RegisterSpellScript(spell_gen_burn_brutallus);
    RegisterSpellScript(spell_gen_cannibalize);
    RegisterSpellScript(spell_gen_clear_debuffs);
    RegisterSpellScript(spell_gen_create_lance);
    RegisterSpellScript(spell_gen_netherbloom);
    RegisterSpellScript(spell_gen_nightmare_vine);
    RegisterSpellScript(spell_gen_obsidian_armor);
    RegisterSpellScript(spell_gen_parachute);
    RegisterSpellScript(spell_gen_pet_summoned);
    RegisterSpellScript(spell_gen_remove_flight_auras);
    RegisterSpellScript(spell_gen_feign_death_all_flags);
    RegisterSpellScript(spell_gen_feign_death_no_dyn_flag);
    RegisterSpellScript(spell_gen_feign_death_no_prevent_emotes);
    RegisterSpellScript(spell_pvp_trinket_wotf_shared_cd);
    RegisterSpellScript(spell_gen_animal_blood);
    RegisterSpellScript(spell_spawn_blood_pool);
    RegisterSpellScript(spell_gen_divine_storm_cd_reset);
    RegisterSpellScript(spell_gen_profession_research);
    RegisterSpellScript(spell_gen_clone);
    RegisterSpellScript(spell_gen_clone_weapon);
    RegisterSpellScript(spell_gen_clone_weapon_aura);
    RegisterSpellScript(spell_gen_seaforium_blast);
    RegisterSpellScript(spell_gen_turkey_marker);
    RegisterSpellScript(spell_gen_lifeblood);
    RegisterSpellScript(spell_gen_allow_cast_from_item_only);
    RegisterSpellAndAuraScriptPair(spell_gen_vehicle_scaling, spell_gen_vehicle_scaling_aura);
    RegisterSpellScript(spell_gen_oracle_wolvar_reputation);
    RegisterSpellScript(spell_gen_damage_reduction_aura);
    RegisterSpellScript(spell_gen_dummy_trigger);
    RegisterSpellScript(spell_gen_spirit_healer_res);
    RegisterSpellScript(spell_gen_gadgetzan_transporter_backfire);
    RegisterSpellScript(spell_gen_gnomish_transporter);
    RegisterSpellScript(spell_gen_gryphon_wyvern_mount_check);
    RegisterSpellScriptWithArgs(spell_gen_dalaran_disguise, "spell_gen_sunreaver_disguise");
    RegisterSpellScriptWithArgs(spell_gen_dalaran_disguise, "spell_gen_silver_covenant_disguise");
    RegisterSpellScript(spell_gen_elune_candle);
    RegisterSpellScriptWithArgs(spell_gen_break_shield, "spell_gen_break_shield");
    RegisterSpellScriptWithArgs(spell_gen_break_shield, "spell_gen_tournament_counterattack");
    RegisterSpellScript(spell_gen_mounted_charge);
    RegisterSpellScript(spell_gen_moss_covered_feet);
    RegisterSpellScript(spell_gen_defend);
    RegisterSpellScript(spell_gen_tournament_duel);
    RegisterSpellScript(spell_gen_summon_tournament_mount);
    RegisterSpellScript(spell_gen_throw_shield);
    RegisterSpellScript(spell_gen_on_tournament_mount);
    RegisterSpellScript(spell_gen_tournament_pennant);
    RegisterSpellScript(spell_gen_teleporting);
    RegisterSpellScript(spell_gen_ds_flush_knockback);
    RegisterSpellScriptWithArgs(spell_gen_count_pct_from_max_hp, "spell_gen_default_count_pct_from_max_hp");
    RegisterSpellScriptWithArgs(spell_gen_count_pct_from_max_hp, "spell_gen_10pct_count_pct_from_max_hp", 10);
    RegisterSpellScriptWithArgs(spell_gen_count_pct_from_max_hp, "spell_gen_50pct_count_pct_from_max_hp", 50);
    RegisterSpellScript(spell_gen_despawn_self);
    RegisterSpellScript(spell_gen_bandage);
    RegisterSpellScript(spell_gen_paralytic_poison);
    RegisterSpellScript(spell_gen_prevent_emotes);
    RegisterSpellScript(spell_gen_blade_warding);
    RegisterSpellScriptWithArgs(spell_gen_lifebloom, "spell_hexlord_lifebloom", SPELL_HEXLORD_MALACRASS_LIFEBLOOM_FINAL_HEAL);
    RegisterSpellScriptWithArgs(spell_gen_lifebloom, "spell_tur_ragepaw_lifebloom", SPELL_TUR_RAGEPAW_LIFEBLOOM_FINAL_HEAL);
    RegisterSpellScriptWithArgs(spell_gen_lifebloom, "spell_cenarion_scout_lifebloom", SPELL_CENARION_SCOUT_LIFEBLOOM_FINAL_HEAL);
    RegisterSpellScriptWithArgs(spell_gen_lifebloom, "spell_twisted_visage_lifebloom", SPELL_TWISTED_VISAGE_LIFEBLOOM_FINAL_HEAL);
    RegisterSpellScriptWithArgs(spell_gen_lifebloom, "spell_faction_champion_dru_lifebloom", SPELL_FACTION_CHAMPIONS_DRU_LIFEBLOOM_FINAL_HEAL);
    RegisterSpellScriptWithArgs(spell_gen_summon_elemental, "spell_gen_summon_fire_elemental", SPELL_SUMMON_FIRE_ELEMENTAL);
    RegisterSpellScriptWithArgs(spell_gen_summon_elemental, "spell_gen_summon_earth_elemental", SPELL_SUMMON_EARTH_ELEMENTAL);
    RegisterSpellScriptWithArgs(spell_gen_mount, "spell_big_blizzard_bear", 0, SPELL_BIG_BLIZZARD_BEAR_60, SPELL_BIG_BLIZZARD_BEAR_100, SPELL_BIG_BLIZZARD_BEAR_150, SPELL_BIG_BLIZZARD_BEAR_280, SPELL_BIG_BLIZZARD_BEAR_310);
    RegisterSpellScriptWithArgs(spell_gen_mount, "spell_magic_broom", 0, SPELL_MAGIC_BROOM_60, SPELL_MAGIC_BROOM_100, SPELL_MAGIC_BROOM_150, SPELL_MAGIC_BROOM_280, 0);
    RegisterSpellScriptWithArgs(spell_gen_mount, "spell_headless_horseman_mount", 0, SPELL_HEADLESS_HORSEMAN_MOUNT_60, SPELL_HEADLESS_HORSEMAN_MOUNT_100, SPELL_HEADLESS_HORSEMAN_MOUNT_150, SPELL_HEADLESS_HORSEMAN_MOUNT_280, 0);
    RegisterSpellScriptWithArgs(spell_gen_mount, "spell_winged_steed_of_the_ebon_blade", 0, 0, 0, SPELL_WINGED_STEED_150, SPELL_WINGED_STEED_280, 0);
    RegisterSpellScriptWithArgs(spell_gen_mount, "spell_big_love_rocket", SPELL_BIG_LOVE_ROCKET_0, SPELL_BIG_LOVE_ROCKET_60, SPELL_BIG_LOVE_ROCKET_100, SPELL_BIG_LOVE_ROCKET_150, SPELL_BIG_LOVE_ROCKET_310, 0);
    RegisterSpellScriptWithArgs(spell_gen_mount, "spell_invincible", 0, SPELL_INVINCIBLE_60, SPELL_INVINCIBLE_100, SPELL_INVINCIBLE_150, SPELL_INVINCIBLE_310, 0);
    RegisterSpellScriptWithArgs(spell_gen_mount, "spell_blazing_hippogryph", 0, 0, 0, SPELL_BLAZING_HIPPOGRYPH_150, SPELL_BLAZING_HIPPOGRYPH_280, 0);
    RegisterSpellScriptWithArgs(spell_gen_mount, "spell_celestial_steed", 0, SPELL_CELESTIAL_STEED_60, SPELL_CELESTIAL_STEED_100, SPELL_CELESTIAL_STEED_150, SPELL_CELESTIAL_STEED_280, SPELL_CELESTIAL_STEED_310);
    RegisterSpellScriptWithArgs(spell_gen_mount, "spell_x53_touring_rocket", 0, 0, 0, SPELL_X53_TOURING_ROCKET_150, SPELL_X53_TOURING_ROCKET_280, SPELL_X53_TOURING_ROCKET_310);
    RegisterSpellScript(spell_gen_upper_deck_create_foam_sword);
    RegisterSpellScript(spell_gen_bonked);
    RegisterSpellScript(spell_gen_gift_of_naaru);
    RegisterSpellAndAuraScriptPair(spell_gen_replenishment, spell_gen_replenishment_aura);
    RegisterSpellScript(spell_gen_spectator_cheer_trigger);
    RegisterSpellScript(spell_gen_vendor_bark_trigger);
    RegisterSpellScript(spell_gen_whisper_gulch_yogg_saron_whisper);
    RegisterSpellScript(spell_gen_eject_all_passengers);
    RegisterSpellScript(spell_gen_eject_passenger);
    RegisterSpellScript(spell_gen_charmed_unit_spell_cooldown);
    RegisterSpellScript(spell_contagion_of_rot);
    RegisterSpellScript(spell_gen_holiday_buff_food);
    RegisterSpellScript(spell_gen_arcane_charge);
    RegisterSpellScript(spell_gen_remove_impairing_auras);
    RegisterSpellScriptWithArgs(spell_gen_consume, "spell_consume_aq20", SPELL_CONSUME_LEECH_AQ20, SPELL_CONSUME_LEECH_HEAL_AQ20);
    RegisterSpellScriptWithArgs(spell_gen_apply_aura_after_expiration, "spell_itch_aq20", SPELL_HIVEZARA_CATALYST, EFFECT_0, SPELL_AURA_DUMMY);
    RegisterSpellScriptWithArgs(spell_gen_apply_aura_after_expiration, "spell_itch_aq40", SPELL_VEKNISS_CATALYST, EFFECT_0, SPELL_AURA_DUMMY);
    RegisterSpellScript(spell_gen_basic_campfire);
    RegisterSpellScript(spell_freezing_circle);
    RegisterSpellScript(spell_gen_threshalisk_charge);
    RegisterSpellScript(spell_gen_shriveling_gaze);
    RegisterSpellScript(spell_gen_curse_of_pain);
    RegisterSpellScript(spell_gen_spirit_of_competition_participant);
    RegisterSpellScript(spell_gen_spirit_of_competition_winner);
    RegisterSpellScript(spell_gen_valthalak_amulet);
    RegisterSpellScript(spell_gen_planting_scourge_banner);
    RegisterSpellScript(spell_gen_jubling_cooldown);
    RegisterSpellScript(spell_gen_yehkinya_bramble);
    RegisterSpellScript(spell_gen_choking_vines);
    RegisterSpellScript(spell_gen_consumption);
    RegisterSpellScript(spell_gen_sober_up);
    RegisterSpellScript(spell_gen_steal_weapon);
}
