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

#include "Battleground.h"
#include "CreatureScript.h"
#include "ObjectMgr.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SkillDiscovery.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "WorldSession.h"
/*
 * Scripts for spells with SPELLFAMILY_GENERIC spells used by items.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_item_".
 */

enum MassiveSeaforiumCharge
{
    ITEM_MASSIVE_SEAFORIUM_CHARGE = 39213,
};

class spell_item_massive_seaforium_charge : public SpellScript
{
    PrepareSpellScript(spell_item_massive_seaforium_charge);

    void HandleItemRemove(SpellEffIndex  /*effIndex*/)
    {
        if (!GetHitUnit() || !GetHitUnit()->ToPlayer())
            return;

        Player* target = GetHitUnit()->ToPlayer();
        target->DestroyItemCount(ITEM_MASSIVE_SEAFORIUM_CHARGE, 1, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_massive_seaforium_charge::HandleItemRemove, EFFECT_0, SPELL_EFFECT_SUMMON_OBJECT_WILD);
    }
};

enum TitaniumSealOfDalaran
{
    TITANIUM_SEAL_OF_DALARAN_BROADCAST_TEXT_ID_FLIP      = 32638,
    TITANIUM_SEAL_OF_DALARAN_BROADCAST_TEXT_ID_HEADS_UP  = 32663,
    TITANIUM_SEAL_OF_DALARAN_BROADCAST_TEXT_ID_FACE_DOWN = 32664
};

class spell_item_titanium_seal_of_dalaran : public SpellScript
{
    PrepareSpellScript(spell_item_titanium_seal_of_dalaran)

    void OnScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        Unit* caster = GetCaster();
        if (Player* player = caster->ToPlayer())
        {
            LocaleConstant loc_idx = player->GetSession()->GetSessionDbLocaleIndex();
            if (BroadcastText const* bct = sObjectMgr->GetBroadcastText(TITANIUM_SEAL_OF_DALARAN_BROADCAST_TEXT_ID_FLIP))
                player->TextEmote(bct->GetText(loc_idx, player->getGender()));
            if (urand(0, 1))
            {
                if (BroadcastText const* bct = sObjectMgr->GetBroadcastText(TITANIUM_SEAL_OF_DALARAN_BROADCAST_TEXT_ID_FACE_DOWN))
                    player->TextEmote(bct->GetText(loc_idx, player->getGender()));
            }
            else
            {
                if (BroadcastText const* bct = sObjectMgr->GetBroadcastText(TITANIUM_SEAL_OF_DALARAN_BROADCAST_TEXT_ID_HEADS_UP))
                    player->TextEmote(bct->GetText(loc_idx, player->getGender()));
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_titanium_seal_of_dalaran::OnScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum AmplifyDish
{
    SPELL_AMPLIFY_30S               = 13180,
    SPELL_AMPLIFY_10S               = 67799,
    SPELL_MENTAL_BATTLE             = 67810,
    SPELL_AMPLIFY_CHARM_30S         = 13181,
    SPELL_AMPLIFY_CHARM_10S         = 26740,
};

class spell_item_mind_amplify_dish : public SpellScript
{
    PrepareSpellScript(spell_item_mind_amplify_dish)

    void OnDummyEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        Unit* caster = GetCaster();
        if (Player* player = caster->ToPlayer())
        {
            if (Unit* target = GetHitUnit())
            {
                // little protection
                if (target->ToCreature())
                    if (target->ToCreature()->GetCreatureTemplate()->rank > CREATURE_ELITE_NORMAL)
                        return;

                if (GetSpellInfo()->Id != SPELL_AMPLIFY_10S)
                    if (target->GetLevel() > 60)
                        return;

                uint8 pct = std::max(0, 20 + player->GetLevel() - target->GetLevel());
                if (roll_chance_i(pct))
                    player->CastSpell(target, SPELL_MENTAL_BATTLE, true);
                else if (roll_chance_i(pct))
                    player->CastSpell(target, GetSpellInfo()->Id == SPELL_AMPLIFY_10S ? SPELL_AMPLIFY_CHARM_10S : SPELL_AMPLIFY_CHARM_30S, true);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_mind_amplify_dish::OnDummyEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum RunescrollOfFortitude
{
    SPELL_FORTITUDE = 72590,
};

class spell_item_runescroll_of_fortitude : public SpellScript
{
    PrepareSpellScript(spell_item_runescroll_of_fortitude)

    void OnScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (Unit* target = GetHitUnit())
        {
            if (target->GetLevel() < 70)
                return;

            target->CastSpell(target, SPELL_FORTITUDE, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_runescroll_of_fortitude::OnScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum BrannsCommunicator
{
    NPC_BRANN_BRONZEBEARD = 29579,
    SPELL_CONTACT_BRANN   = 55038,
};

class spell_item_branns_communicator : public SpellScript
{
    PrepareSpellScript(spell_item_branns_communicator)

    void OnScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (Player* target = GetHitPlayer())
        {
            target->KilledMonsterCredit(NPC_BRANN_BRONZEBEARD); // Brann's entry
            target->CastSpell(target, SPELL_CONTACT_BRANN, true); // Brann summoning spell
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_branns_communicator::OnScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_item_goblin_gumbo_kettle : public AuraScript
{
    PrepareAuraScript(spell_item_goblin_gumbo_kettle);

    void CalcPeriodic(AuraEffect const* /*effect*/, bool& isPeriodic, int32& amplitude)
    {
        isPeriodic = true;
        amplitude = urand(10 * IN_MILLISECONDS, 40 * IN_MILLISECONDS);
    }

    void Update(AuraEffect* effect)
    {
        PreventDefaultAction();
        effect->SetPeriodicTimer(urand(10 * IN_MILLISECONDS, 40 * IN_MILLISECONDS));
        if (Unit* owner = GetUnitOwner())
            owner->CastSpell(owner, 42755 /*Goblin Gumbo Trigger*/, true);
    }

    void Register() override
    {
        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_item_goblin_gumbo_kettle::CalcPeriodic, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_item_goblin_gumbo_kettle::Update, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

enum MountModSpells
{
    SPELL_CARROT_ON_A_STICK_EFFECT = 48402,
    SPELL_RIDING_CROP_EFFECT = 48383,
    SPELL_MITHRIL_SPURS_EFFECT = 59916,
    SPELL_MITHRIL_SPURS = 7215,
    SPELL_MOUNT_SPEED_CARROT = 48777,
    SPELL_MOUNT_SPEED_RIDING = 48776
};

class spell_item_with_mount_speed : public AuraScript
{
    PrepareAuraScript(spell_item_with_mount_speed);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        if (!sSpellMgr->GetSpellInfo(SPELL_MOUNT_SPEED_CARROT)
            || !sSpellMgr->GetSpellInfo(SPELL_MITHRIL_SPURS)
            || !sSpellMgr->GetSpellInfo(SPELL_MOUNT_SPEED_RIDING))
        {
            return false;
        }
        return true;
    }

    uint32 getMountSpellId()
    {
        switch (m_scriptSpellId)
        {
            case SPELL_MOUNT_SPEED_CARROT:
                return SPELL_CARROT_ON_A_STICK_EFFECT;
            case SPELL_MITHRIL_SPURS:
                return SPELL_MITHRIL_SPURS_EFFECT;
            case SPELL_MOUNT_SPEED_RIDING:
                return SPELL_RIDING_CROP_EFFECT;
            default:
                return 0;
        }
    }

    void OnApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (target->GetLevel() <= 70)
        {
            if (auto spellId = getMountSpellId())
            {
                target->CastSpell(target, spellId, aurEff);
            }
        }
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (auto spellId = getMountSpellId())
        {
            target->RemoveAurasDueToSpell(spellId);
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_item_with_mount_speed::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_item_with_mount_speed::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_item_magic_dust : public SpellScript
{
    PrepareSpellScript(spell_item_magic_dust);

    void HandlePreventAura(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            if (target->GetLevel() >= 30)
            {
                uint8 chance = 100 - std::min<uint8>(100, target->GetLevel() - 30 * urand(3, 10));
                if (!roll_chance_i(chance))
                {
                    PreventHitAura();
                }
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_magic_dust::HandlePreventAura, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
    }
};

class spell_item_toy_train_set : public SpellScript
{
    PrepareSpellScript(spell_item_toy_train_set)

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            target->HandleEmoteCommand(EMOTE_ONESHOT_TRAIN);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_toy_train_set::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum eChicken
{
    SPELL_ROCKET_CHICKEN_EMOTE          = 45255,
};

class spell_item_rocket_chicken : public AuraScript
{
    PrepareAuraScript(spell_item_rocket_chicken);

    void HandleDummyTick(AuraEffect const* /*aurEff*/)
    {
        if (roll_chance_i(5))
        {
            GetTarget()->ToCreature()->DespawnOrUnsummon(8000);
            GetTarget()->Kill(GetTarget(), GetTarget());
        }
        else if (roll_chance_i(50))
            GetTarget()->CastSpell(GetTarget(), SPELL_ROCKET_CHICKEN_EMOTE, false);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_rocket_chicken::HandleDummyTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_item_sleepy_willy : public SpellScript
{
    PrepareSpellScript(spell_item_sleepy_willy);

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        Creature* target = nullptr;
        for (std::list<WorldObject*>::const_iterator itr = targets.begin(); itr != targets.end(); ++itr)
            if (Creature* creature = (*itr)->ToCreature())
                if (creature->IsCritter())
                {
                    target = creature;
                    break;
                }

        targets.clear();
        if (target)
            targets.push_back(target);
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Creature* target = GetHitCreature();
        if (!target)
            return;

        GetCaster()->CastSpell(target, GetEffectValue(), false);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_item_sleepy_willy::SelectTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_item_sleepy_willy::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_item_lil_phylactery : public AuraScript
{
    PrepareAuraScript(spell_item_lil_phylactery);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetActionTarget() && (!eventInfo.GetActionTarget()->IsCreature() || eventInfo.GetActionTarget()->ToCreature()->isWorldBoss());
    }

    void HandleProc(AuraEffect const*  /*aurEff*/, ProcEventInfo&  /*eventInfo*/)
    {
        PreventDefaultAction();

        if (Unit* critter = ObjectAccessor::GetUnit(*GetUnitOwner(), GetUnitOwner()->GetCritterGUID()))
            GetUnitOwner()->CastSpell(critter, 69731 /*SPELL_LICH_PET_AURA_ON_KILL*/, true);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_item_lil_phylactery::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_item_lil_phylactery::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

class spell_item_shifting_naaru_silver : public AuraScript
{
    PrepareAuraScript(spell_item_shifting_naaru_silver);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTarget() == GetCaster())
            if (Aura* aur = GetTarget()->AddAura(45044 /*Limitless Power*/, GetTarget()))
                aur->SetDuration(GetDuration());
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Aura* aur = GetTarget()->GetAura(45044 /*Limitless Power*/, GetTarget()->GetGUID()))
            aur->SetDuration(0);
    }

    void OnBaseRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->RemoveDynObject(45043);
    }

    void Register() override
    {
        if (m_scriptSpellId == 45043)
        {
            OnEffectApply += AuraEffectApplyFn(spell_item_shifting_naaru_silver::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_item_shifting_naaru_silver::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
        else
            AfterEffectRemove += AuraEffectRemoveFn(spell_item_shifting_naaru_silver::OnBaseRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_item_toxic_wasteling : public SpellScript
{
    PrepareSpellScript(spell_item_toxic_wasteling);

    void HandleJump(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Creature* target = GetHitCreature())
        {
            GetCaster()->GetMotionMaster()->Clear(false);
            GetCaster()->GetMotionMaster()->MoveIdle();
            GetCaster()->ToCreature()->SetHomePosition(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0.0f);
            GetCaster()->GetMotionMaster()->MoveJump(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 12.0f, 3.0f, 1);
            target->DespawnOrUnsummon(1500);
        }
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_item_toxic_wasteling::HandleJump, EFFECT_0, SPELL_EFFECT_JUMP);
        OnEffectHitTarget += SpellEffectFn(spell_item_toxic_wasteling::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_item_lil_xt : public SpellScript
{
    PrepareSpellScript(spell_item_lil_xt);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Creature* target = GetHitCreature();
        if (!target)
            return;
        GetCaster()->CastSpell(target, GetEffectValue(), false);
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Creature* target = GetHitCreature();
        if (!target)
            return;
        if (GetCaster()->IsCreature() && GetCaster()->ToCreature()->AI())
            GetCaster()->ToCreature()->AI()->Talk(2);
        target->DespawnOrUnsummon(500);
    }

    void Register() override
    {
        if (m_scriptSpellId == 76098)
            OnEffectHitTarget += SpellEffectFn(spell_item_lil_xt::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        else
            OnEffectHitTarget += SpellEffectFn(spell_item_lil_xt::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_item_essence_of_life : public AuraScript
{
    PrepareAuraScript(spell_item_essence_of_life);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo || !spellInfo->HasEffect(SPELL_EFFECT_HEAL))
        {
            return false;
        }

        return spellInfo->ManaCost > 0 || spellInfo->ManaCostPercentage > 0 || (spellInfo->SpellFamilyName == SPELLFAMILY_PALADIN && spellInfo->SpellIconID == 156);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_item_essence_of_life::CheckProc);
    }
};

const uint32 crazyAlchemistTable[5] =
{
    53909, // Wild Magic
    53908, // Potion of Speed
    53762, // Indestructible Potion
    43185, // Runic Healing Potion
    43186  // Runic Mana Potion
};

class spell_item_crazy_alchemists_potion : public SpellScript
{
    PrepareSpellScript(spell_item_crazy_alchemists_potion);

    void HandleHeal(SpellEffIndex /*effIndex*/)
    {
        // Xinef: 20% to get additional effect, guessed
        if (roll_chance_i(20))
            GetCaster()->CastSpell(GetCaster(), crazyAlchemistTable[urand(0, (GetCaster()->getPowerType() == POWER_MANA ? 4 : 3))], true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_crazy_alchemists_potion::HandleHeal, EFFECT_0, SPELL_EFFECT_HEAL);
    }
};

class spell_item_skull_of_impeding_doom : public AuraScript
{
    PrepareAuraScript(spell_item_skull_of_impeding_doom);

    void CalculateDamageAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (!GetCaster())
            return;

        amount = GetCaster()->GetMaxHealth() * 0.12f; // 5 ticks which reduce health by 60%
    }

    void CalculateManaLeechAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (!GetCaster() || !GetCaster()->HasActivePowerType(POWER_MANA))
            return;

        amount = GetCaster()->GetMaxPower(POWER_MANA) * 0.12f; // 5 ticks which reduce health by 60%
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_item_skull_of_impeding_doom::CalculateDamageAmount, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE);
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_item_skull_of_impeding_doom::CalculateManaLeechAmount, EFFECT_2, SPELL_AURA_PERIODIC_MANA_LEECH);
    }
};

enum Feast
{
    SPELL_GREAT_FEAST                        = 57301,
    SPELL_FISH_FEAST                         = 57426,
    SPELL_SMALL_FEAST                        = 58474,
    SPELL_GIGANTIC_FEAST                     = 58465,

    GREAT_FEAST_BROADCAST_TEXT_ID_PREPARE    = 31843,
    FISH_FEAST_BROADCAST_TEXT_ID_PREPARE     = 31844,
    SMALL_FEAST_BROADCAST_TEXT_ID_PREPARE    = 31845,
    GIGANTIC_FEAST_BROADCAST_TEXT_ID_PREPARE = 31846
};

class spell_item_feast : public SpellScript
{
    PrepareSpellScript(spell_item_feast);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        Unit* caster = GetCaster();
        if (Player* player = caster->ToPlayer())
        {
            LocaleConstant loc_idx = player->GetSession()->GetSessionDbLocaleIndex();

            switch (GetSpellInfo()->Id)
            {
                case SPELL_GREAT_FEAST:
                    if (BroadcastText const* bct = sObjectMgr->GetBroadcastText(GREAT_FEAST_BROADCAST_TEXT_ID_PREPARE))
                        player->TextEmote(bct->GetText(loc_idx, player->getGender()), player);
                    break;
                case SPELL_FISH_FEAST:
                    if (BroadcastText const* bct = sObjectMgr->GetBroadcastText(FISH_FEAST_BROADCAST_TEXT_ID_PREPARE))
                        player->TextEmote(bct->GetText(loc_idx, player->getGender()), player);
                    break;
                case SPELL_SMALL_FEAST:
                    if (BroadcastText const* bct = sObjectMgr->GetBroadcastText(SMALL_FEAST_BROADCAST_TEXT_ID_PREPARE))
                        player->TextEmote(bct->GetText(loc_idx, player->getGender()), player);
                    break;
                case SPELL_GIGANTIC_FEAST:
                    if (BroadcastText const* bct = sObjectMgr->GetBroadcastText(GIGANTIC_FEAST_BROADCAST_TEXT_ID_PREPARE))
                        player->TextEmote(bct->GetText(loc_idx, player->getGender()), player);
                    break;
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_feast::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_item_gnomish_universal_remote : public SpellScript
{
    PrepareSpellScript(spell_item_gnomish_universal_remote);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* target = GetHitUnit();
        if (!target)
            return;

        uint32 spellId = 0;
        switch (urand(0, 2))
        {
            case 0:
                spellId = 8345;
                break; // charm
            case 1:
                spellId = 8346;
                break; // root
            case 2:
                spellId = 8347;
                break; // threat
        }
        if (spellId)
            GetCaster()->CastSpell(target, spellId, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_gnomish_universal_remote::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_item_powerful_anti_venom : public SpellScript
{
    PrepareSpellScript(spell_item_powerful_anti_venom);

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
        {
            std::list<uint32> removeList;
            Unit::AuraMap const& auras = target->GetOwnedAuras();
            for (Unit::AuraMap::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
            {
                Aura* aura = itr->second;
                if (aura->GetSpellInfo()->SpellLevel > 60 || aura->GetSpellInfo()->Dispel != DISPEL_POISON)
                {
                    continue;
                }

                removeList.push_back(aura->GetId());
            }

            for (std::list<uint32>::const_iterator itr = removeList.begin(); itr != removeList.end(); ++itr)
            {
                target->RemoveAurasDueToSpell(*itr);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_powerful_anti_venom::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_item_strong_anti_venom : public SpellScript
{
    PrepareSpellScript(spell_item_strong_anti_venom);

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
        {
            std::list<uint32> removeList;
            Unit::AuraMap const& auras = target->GetOwnedAuras();
            for (Unit::AuraMap::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
            {
                Aura* aura = itr->second;
                if (aura->GetSpellInfo()->SpellLevel > 35 || aura->GetSpellInfo()->Dispel != DISPEL_POISON)
                    continue;

                removeList.push_back(aura->GetId());
            }

            for (std::list<uint32>::const_iterator itr = removeList.begin(); itr != removeList.end(); ++itr)
                target->RemoveAurasDueToSpell(*itr);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_strong_anti_venom::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_item_anti_venom : public SpellScript
{
    PrepareSpellScript(spell_item_anti_venom);

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
        {
            std::list<uint32> removeList;
            Unit::AuraMap const& auras = target->GetOwnedAuras();
            for (Unit::AuraMap::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
            {
                Aura* aura = itr->second;
                if (aura->GetSpellInfo()->SpellLevel > 25 || aura->GetSpellInfo()->Dispel != DISPEL_POISON)
                {
                    continue;
                }

                removeList.push_back(aura->GetId());
            }

            for (std::list<uint32>::const_iterator itr = removeList.begin(); itr != removeList.end(); ++itr)
            {
                target->RemoveAurasDueToSpell(*itr);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_anti_venom::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum GnomishShrinkRay
{
    SPELL_GNOMISH_SHRINK_RAY_SELF = 13004,
    SPELL_GNOMISH_SHRINK_RAY_TARGET = 13003,
};

class spell_item_gnomish_shrink_ray : public SpellScript
{
    PrepareSpellScript(spell_item_gnomish_shrink_ray);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (Unit* target = GetHitUnit())
        {
            if (urand(0, 99) < 15)
                caster->CastSpell(caster, SPELL_GNOMISH_SHRINK_RAY_SELF, true, nullptr);
            else
                caster->CastSpell(target, SPELL_GNOMISH_SHRINK_RAY_TARGET, true, nullptr);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_gnomish_shrink_ray::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum GoblinWeatherMachiene
{
    SPELL_PERSONALIZED_WEATHER_RAIN = 46736,
    SPELL_PERSONALIZED_WEATHER_SNOW = 46738,
    SPELL_PERSONALIZED_WEATHER_SUN  = 46739,
    SPELL_PERSONALIZED_WEATHER_CLOUDS = 46740
};

uint32 WeatherForcast()
{
    if (!SpellScript::ValidateSpellInfo({
        SPELL_PERSONALIZED_WEATHER_RAIN,
        SPELL_PERSONALIZED_WEATHER_SNOW,
        SPELL_PERSONALIZED_WEATHER_SUN,
        SPELL_PERSONALIZED_WEATHER_CLOUDS
        }))
        return 0;

    uint32 spellId = 0;
    switch (urand(0, 3))
    {
        case 0:
            spellId = SPELL_PERSONALIZED_WEATHER_RAIN;
            break;
        case 1:
            spellId = SPELL_PERSONALIZED_WEATHER_SNOW;
            break;
        case 2:
            spellId = SPELL_PERSONALIZED_WEATHER_SUN;
            break;
        case 3:
            spellId = SPELL_PERSONALIZED_WEATHER_CLOUDS;
            break;
    }

    return spellId;
}

class spell_item_goblin_weather_machine : public SpellScript
{
    PrepareSpellScript(spell_item_goblin_weather_machine);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            target->CastSpell(target, WeatherForcast(), true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_goblin_weather_machine::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_item_goblin_weather_machine_aura : public AuraScript
{
    PrepareAuraScript(spell_item_goblin_weather_machine_aura);

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (roll_chance_i(50))
            return;

        GetUnitOwner()->CastSpell(GetUnitOwner(), WeatherForcast(), true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_item_goblin_weather_machine_aura::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_item_light_lamp : public SpellScript
{
    PrepareSpellScript(spell_item_light_lamp);

    void HandleActivateObject(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (GameObject* go = GetHitGObj())
            go->UseDoorOrButton();
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_light_lamp::HandleActivateObject, EFFECT_0, SPELL_EFFECT_ACTIVATE_OBJECT);
    }
};

class spell_item_fetch_ball : public SpellScript
{
    PrepareSpellScript(spell_item_fetch_ball);

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        Creature* target = nullptr;
        for (std::list<WorldObject*>::const_iterator itr = targets.begin(); itr != targets.end(); ++itr)
            if (Creature* creature = (*itr)->ToCreature())
            {
                if (creature->GetOwnerGUID() == GetCaster()->GetOwnerGUID() && !creature->IsNonMeleeSpellCast(false) &&
                        creature->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE)
                {
                    target = creature;
                    break;
                }
            }

        targets.clear();
        if (target)
            targets.push_back(target);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_item_fetch_ball::SelectTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
    }
};

enum oracleAblutions
{
    SPELL_ABLUTION_RUNIC            = 59812,
    SPELL_ABLUTION_MANA             = 59813,
    SPELL_ABLUTION_RAGE             = 59814,
    SPELL_ABLUTION_ENERGY           = 59815,
};

class spell_item_oracle_ablutions : public SpellScript
{
    PrepareSpellScript(spell_item_oracle_ablutions)

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Unit* caster = GetCaster();
        switch (caster->getPowerType())
        {
            case POWER_RUNIC_POWER:
                caster->CastSpell(caster, SPELL_ABLUTION_RUNIC, true);
                break;
            case POWER_MANA:
                {
                    int32 mana = CalculatePct(caster->GetMaxPower(POWER_MANA), 5.0f);
                    caster->CastCustomSpell(SPELL_ABLUTION_MANA, SPELLVALUE_BASE_POINT0, mana, caster, true);
                    break;
                }
            case POWER_RAGE:
                caster->CastSpell(caster, SPELL_ABLUTION_RAGE, true);
                break;
            case POWER_ENERGY:
                caster->CastSpell(caster, SPELL_ABLUTION_ENERGY, true);
                break;
            default:
                break;
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_oracle_ablutions::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_item_trauma : public AuraScript
{
    PrepareAuraScript(spell_item_trauma);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetActionTarget();
    }

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        GetUnitOwner()->CastSpell(eventInfo.GetActionTarget(), GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, true);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_item_trauma::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_item_trauma::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

class spell_item_blade_ward_enchant : public AuraScript
{
    PrepareAuraScript(spell_item_blade_ward_enchant);

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        if (!eventInfo.GetActionTarget())
        {
            return;
        }

        if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(64442 /*SPELL_BLADE_WARDING*/))
        {
            int32 basepoints = spellInfo->Effects[EFFECT_0].CalcValue() * this->GetStackAmount();
            eventInfo.GetActionTarget()->CastCustomSpell(spellInfo->Id, SPELLVALUE_BASE_POINT0, basepoints, eventInfo.GetActor(), true);
        }
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_item_blade_ward_enchant::HandleProc, EFFECT_1, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

class spell_item_blood_draining_enchant : public AuraScript
{
    PrepareAuraScript(spell_item_blood_draining_enchant);

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        if (!eventInfo.GetActionTarget() || !eventInfo.GetDamageInfo() || (eventInfo.GetActionTarget()->GetHealth() - eventInfo.GetDamageInfo()->GetDamage()) >= eventInfo.GetActionTarget()->CountPctFromMaxHealth(35))
        {
            return;
        }

        if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(64569 /*SPELL_BLOOD_RESERVE*/))
        {
            int32 basepoints = spellInfo->Effects[EFFECT_0].CalcValue() * this->GetStackAmount();
            eventInfo.GetActionTarget()->CastCustomSpell(spellInfo->Id, SPELLVALUE_BASE_POINT0, basepoints, eventInfo.GetActionTarget(), true);
            eventInfo.GetActionTarget()->RemoveAurasDueToSpell(GetSpellInfo()->Id); // Remove rest auras
        }

        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(64569 /*SPELL_BLOOD_RESERVE*/);
        int32 basepoints = spellInfo->Effects[EFFECT_0].CalcValue() * this->GetStackAmount();
        eventInfo.GetActionTarget()->CastCustomSpell(spellInfo->Id, SPELLVALUE_BASE_POINT0, basepoints, eventInfo.GetActionTarget(), true);
        eventInfo.GetActionTarget()->RemoveAurasDueToSpell(GetSpellInfo()->Id); // Remove rest auras
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_item_blood_draining_enchant::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

class spell_item_dragon_kite_summon_lightning_bunny : public SpellScript
{
    PrepareSpellScript(spell_item_dragon_kite_summon_lightning_bunny);

    void SetDest(SpellDestination& dest)
    {
        // Adjust effect summon position
        Position const offset = { 3.0f, 3.0f, 20.0f, 0.0f };
        dest.Relocate(*GetCaster());
        dest.RelocateOffset(offset);
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_item_dragon_kite_summon_lightning_bunny::SetDest, EFFECT_0, TARGET_DEST_CASTER_RANDOM);
    }
};

class spell_item_enchanted_broom_periodic : public AuraScript
{
    PrepareAuraScript(spell_item_enchanted_broom_periodic);

    void HandlePeriodicTick(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        if (Unit* owner = GetTarget()->GetOwner())
        {
            if (owner->isMoving())
            {
                GetTarget()->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, GetTarget()->GetFollowAngle(), MOTION_SLOT_ACTIVE);
            }
            else
            {
                GetTarget()->CastSpell(GetTarget(), GetId() - 1, true);
                GetTarget()->GetMotionMaster()->Clear(false);
                GetTarget()->GetMotionMaster()->MoveRandom(5.0f);
            }
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_enchanted_broom_periodic::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_item_summon_or_dismiss : public SpellScript
{
    PrepareSpellScript(spell_item_summon_or_dismiss);

    void HandleSummon(SpellEffIndex effIndex)
    {
        for (Unit::ControlSet::iterator itr = GetCaster()->m_Controlled.begin(); itr != GetCaster()->m_Controlled.end(); ++itr)
        {
            if (GetSpellInfo()->Effects[effIndex].MiscValue >= 0 && (*itr)->GetEntry() == uint32(GetSpellInfo()->Effects[effIndex].MiscValue))
            {
                (*itr)->ToTempSummon()->UnSummon();
                PreventHitDefaultEffect(effIndex);
                return;
            }
        }
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_item_summon_or_dismiss::HandleSummon, EFFECT_ALL, SPELL_EFFECT_SUMMON);
    }
};

enum eDreanicPaleAle
{
    SPELL_PINK_ELEKK            = 49908
};

class spell_item_draenic_pale_ale : public SpellScript
{
    PrepareSpellScript(spell_item_draenic_pale_ale);

    void HandleSummon(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (roll_chance_i(70))
            return;

        GetCaster()->CastSpell(GetCaster(), SPELL_PINK_ELEKK, true);

        float radius = GetSpellInfo()->Effects[effIndex].CalcRadius();
        for (uint8 count = 0; count < GetEffectValue(); ++count)
        {
            Position pos = *GetCaster();
            GetCaster()->GetClosePoint(pos.m_positionX, pos.m_positionY, pos.m_positionZ, pos.GetOrientation(), radius, M_PI - 1.2f + 0.3f * urand(0, 8));
            Creature* summon = GetCaster()->SummonCreature(GetSpellInfo()->Effects[effIndex].MiscValue, pos, TEMPSUMMON_TIMED_DESPAWN, GetSpellInfo()->GetDuration());
            if (!summon)
                continue;

            summon->SetOwnerGUID(GetCaster()->GetGUID());
            summon->SetFaction(GetCaster()->GetFaction());
            summon->SetImmuneToAll(true);
            summon->SetReactState(REACT_PASSIVE);
            summon->GetMotionMaster()->MoveFollow(GetCaster(), PET_FOLLOW_DIST, GetCaster()->GetAngle(summon), MOTION_SLOT_CONTROLLED);
            GetSpell()->ExecuteLogEffectSummonObject(effIndex, summon);
        }
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_item_draenic_pale_ale::HandleSummon, EFFECT_0, SPELL_EFFECT_SUMMON);
    }
};

enum eMoleMachine
{
    SPELL_MOLE_MACHINE_PORT_TO_GRIM_GUZZLER     = 47523,
};

class spell_item_direbrew_remote : public SpellScript
{
    PrepareSpellScript(spell_item_direbrew_remote)

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            target->HandleEmoteCommand(EMOTE_ONESHOT_WAVE);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_direbrew_remote::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_item_direbrew_remote_aura : public AuraScript
{
    PrepareAuraScript(spell_item_direbrew_remote_aura);

    void HandlePeriodicTick(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (aurEff->GetTickNumber() >= 2)
        {
            SetDuration(0);
            GetTarget()->CastSpell(GetTarget(), SPELL_MOLE_MACHINE_PORT_TO_GRIM_GUZZLER, true);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_direbrew_remote_aura::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

enum EyeOfGruul
{
    SPELL_DRUID_ITEM_HEALING_TRANCE   = 37721,
    SPELL_PALADIN_ITEM_HEALING_TRANCE = 37723,
    SPELL_PRIEST_ITEM_HEALING_TRANCE  = 37706,
    SPELL_SHAMAN_ITEM_HEALING_TRANCE  = 37722
};

// 37705 - Healing Discount
class spell_item_eye_of_gruul_healing_discount : public AuraScript
{
    PrepareAuraScript(spell_item_eye_of_gruul_healing_discount);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_DRUID_ITEM_HEALING_TRANCE,
                SPELL_PALADIN_ITEM_HEALING_TRANCE,
                SPELL_PRIEST_ITEM_HEALING_TRANCE,
                SPELL_SHAMAN_ITEM_HEALING_TRANCE
            });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        if (Unit* unitTarget = GetTarget())
        {
            uint32 spell_id = 0;
            switch (unitTarget->getClass())
            {
                case CLASS_DRUID:
                    spell_id = SPELL_DRUID_ITEM_HEALING_TRANCE;
                    break;
                case CLASS_PALADIN:
                    spell_id = SPELL_PALADIN_ITEM_HEALING_TRANCE;
                    break;
                case CLASS_PRIEST:
                    spell_id = SPELL_PRIEST_ITEM_HEALING_TRANCE;
                    break;
                case CLASS_SHAMAN:
                    spell_id = SPELL_SHAMAN_ITEM_HEALING_TRANCE;
                    break;
                default:
                    return; // ignore for non-healing classes
            }

            unitTarget->CastSpell(unitTarget, spell_id, true, nullptr, aurEff);
        }
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_item_eye_of_gruul_healing_discount::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

enum eArgentKnight
{
    SPELL_SUMMON_ARGENT_KNIGHT_ALLIANCE = 54296
};

class spell_item_summon_argent_knight : public SpellScript
{
    PrepareSpellScript(spell_item_summon_argent_knight);

    void HandleOnEffectHit(SpellEffIndex effIndex)
    {
        if (Unit* caster = GetCaster())
        {
            if (caster->IsPlayer())
            {
                // summoning the "Argent Knight (Horde)" is default for spell 54307;
                if (caster->ToPlayer()->GetTeamId() == TEAM_ALLIANCE)
                {
                    // prevent default summoning and summon "Argent Knight (Alliance)" instead
                    PreventHitDefaultEffect(effIndex);
                    caster->CastSpell(caster, SPELL_SUMMON_ARGENT_KNIGHT_ALLIANCE, true);
                }
            }
        }
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_item_summon_argent_knight::HandleOnEffectHit, EFFECT_0, SPELL_EFFECT_SUMMON);
    }
};

enum InstantStatue
{
    CREATURE_INSTANT_STATUE_PEDESTAL = 40246,
    SPELL_INSTANT_STATUE = 75731
};

class spell_item_instant_statue : public AuraScript
{
    PrepareAuraScript(spell_item_instant_statue);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_INSTANT_STATUE });
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();
        if (!caster)
        {
            return;
        }

        if (Creature* creature = caster->FindNearestCreature(CREATURE_INSTANT_STATUE_PEDESTAL, 0.0f, true))
        {
            creature->RemoveAurasDueToSpell(SPELL_INSTANT_STATUE);
        }
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_item_instant_statue::OnRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// Generic script for handling item dummy effects which trigger another spell.
class spell_item_trigger_spell : public SpellScript
{
    PrepareSpellScript(spell_item_trigger_spell);
private:
    uint32 _triggeredSpellId;

public:
    spell_item_trigger_spell(uint32 triggeredSpellId) : SpellScript(), _triggeredSpellId(triggeredSpellId) { }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ _triggeredSpellId });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (Item* item = GetCastItem())
            caster->CastSpell(caster, _triggeredSpellId, true, item);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_item_trigger_spell::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum AegisOfPreservation
{
    SPELL_AEGIS_HEAL   = 23781
};

// 23780 - Aegis of Preservation
class spell_item_aegis_of_preservation : public AuraScript
{
    PrepareAuraScript(spell_item_aegis_of_preservation);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_AEGIS_HEAL });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(GetTarget(), SPELL_AEGIS_HEAL, true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_item_aegis_of_preservation::HandleProc, EFFECT_1, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// 26400 - Arcane Shroud
class spell_item_arcane_shroud : public AuraScript
{
    PrepareAuraScript(spell_item_arcane_shroud);

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        int32 diff = GetUnitOwner()->GetLevel() - 60;
        if (diff > 0)
            amount += 2 * diff;
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_item_arcane_shroud::CalculateAmount, EFFECT_0, SPELL_AURA_MOD_THREAT);
    }
};

// 64415 - Val'anyr Hammer of Ancient Kings - Equip Effect
class spell_item_valanyr_hammer_of_ancient_kings : public AuraScript
{
    PrepareAuraScript(spell_item_valanyr_hammer_of_ancient_kings);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetHealInfo() && eventInfo.GetHealInfo()->GetHeal() > 0;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_item_valanyr_hammer_of_ancient_kings::CheckProc);
    }
};

// 24590 - Brittle Armor
enum BrittleArmor
{
    SPELL_BRITTLE_ARMOR = 24575
};

class spell_item_brittle_armor : public SpellScript
{
    PrepareSpellScript(spell_item_brittle_armor);

    void HandleScript(SpellEffIndex /* effIndex */)
    {
        GetHitUnit()->RemoveAuraFromStack(SPELL_BRITTLE_ARMOR);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_brittle_armor::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 64411 - Blessing of Ancient Kings (Val'anyr, Hammer of Ancient Kings)
enum BlessingOfAncientKings
{
    SPELL_PROTECTION_OF_ANCIENT_KINGS   = 64413
};

class spell_item_blessing_of_ancient_kings : public AuraScript
{
    PrepareAuraScript(spell_item_blessing_of_ancient_kings);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PROTECTION_OF_ANCIENT_KINGS });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetProcTarget();
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        HealInfo* healInfo = eventInfo.GetHealInfo();
        if (!healInfo)
        {
            return;
        }

        int32 absorb = int32(CalculatePct(healInfo->GetHeal(), 15.0f));
        // xinef: all heals contribute to one bubble
        if (AuraEffect* protEff = eventInfo.GetProcTarget()->GetAuraEffect(SPELL_PROTECTION_OF_ANCIENT_KINGS, 0/*, eventInfo.GetActor()->GetGUID()*/))
        {
            // The shield can grow to a maximum size of 20,000 damage absorbtion
            protEff->SetAmount(std::min<int32>(protEff->GetAmount() + absorb, 20000));

            // Refresh and return to prevent replacing the aura
            protEff->GetBase()->RefreshDuration();
        }
        else
            GetTarget()->CastCustomSpell(SPELL_PROTECTION_OF_ANCIENT_KINGS, SPELLVALUE_BASE_POINT0, absorb, eventInfo.GetProcTarget(), true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_item_blessing_of_ancient_kings::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_item_blessing_of_ancient_kings::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 8342  - Defibrillate (Goblin Jumper Cables) have 33% chance on success
// 22999 - Defibrillate (Goblin Jumper Cables XL) have 50% chance on success
// 54732 - Defibrillate (Gnomish Army Knife) have 67% chance on success
enum Defibrillate
{
    SPELL_GOBLIN_JUMPER_CABLES_FAIL     = 8338,
    SPELL_GOBLIN_JUMPER_CABLES_XL_FAIL  = 23055
};

class spell_item_defibrillate : public SpellScript
{
    PrepareSpellScript(spell_item_defibrillate);

public:
    spell_item_defibrillate(uint8 chance, uint32 failSpell = 0) : SpellScript(), _chance(chance), _failSpell(failSpell) { }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        if (_failSpell && !sSpellMgr->GetSpellInfo(_failSpell))
            return false;
        return true;
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        if (roll_chance_i(_chance))
        {
            PreventHitDefaultEffect(effIndex);
            if (_failSpell)
                GetCaster()->CastSpell(GetCaster(), _failSpell, true, GetCastItem());
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_defibrillate::HandleScript, EFFECT_0, SPELL_EFFECT_RESURRECT);
    }

private:
    uint8 _chance;
    uint32 _failSpell;
};

enum DesperateDefense
{
    SPELL_DESPERATE_RAGE    = 33898,
    SPELL_SERVERSIDE_DESPERAT_DEFENSE = 33897 // Root and Pacify
};

// 33896 - Desperate Defense
class spell_item_desperate_defense : public AuraScript
{
    PrepareAuraScript(spell_item_desperate_defense);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DESPERATE_RAGE });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(GetTarget(), SPELL_DESPERATE_RAGE, true, nullptr, aurEff);
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(SPELL_SERVERSIDE_DESPERAT_DEFENSE);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_item_desperate_defense::HandleProc, EFFECT_2, SPELL_AURA_PROC_TRIGGER_SPELL);
        OnEffectRemove += AuraEffectRemoveFn(spell_item_desperate_defense::OnRemove, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB, AURA_EFFECT_HANDLE_REAL);
    }
};

// http://www.wowhead.com/item=6522 Deviate Fish
// 8063 Deviate Fish
enum DeviateFishSpells
{
    SPELL_SLEEPY            = 8064,
    SPELL_INVIGORATE        = 8065,
    SPELL_SHRINK            = 8066,
    SPELL_PARTY_TIME        = 8067,
    SPELL_HEALTHY_SPIRIT    = 8068,
    SPELL_REJUVENATION      = 8070
};

class spell_item_deviate_fish : public SpellScript
{
    PrepareSpellScript(spell_item_deviate_fish);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SLEEPY, SPELL_INVIGORATE, SPELL_SHRINK, SPELL_PARTY_TIME, SPELL_HEALTHY_SPIRIT, SPELL_REJUVENATION });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        uint32 spellId = RAND(SPELL_SLEEPY, SPELL_INVIGORATE, SPELL_SHRINK, SPELL_PARTY_TIME, SPELL_HEALTHY_SPIRIT, SPELL_REJUVENATION);
        caster->CastSpell(caster, spellId, true, nullptr);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_item_deviate_fish::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class PartyTimeEmoteEvent : public BasicEvent
{
public:
    PartyTimeEmoteEvent(Player* player) : _player(player) { }

    bool Execute(uint64 /*time*/, uint32 /*diff*/) override
    {
        if (!_player->HasAura(SPELL_PARTY_TIME))
        {
            return true;
        }

        if (_player->isMoving())
        {
            _player->HandleEmoteCommand(RAND(EMOTE_ONESHOT_APPLAUD, EMOTE_ONESHOT_LAUGH, EMOTE_ONESHOT_CHEER, EMOTE_ONESHOT_CHICKEN));
        }
        else
        {
            _player->HandleEmoteCommand(RAND(EMOTE_ONESHOT_APPLAUD, EMOTE_ONESHOT_DANCESPECIAL, EMOTE_ONESHOT_LAUGH, EMOTE_ONESHOT_CHEER, EMOTE_ONESHOT_CHICKEN));
        }

        _player->m_Events.AddEvent(this, RAND(_player->m_Events.CalculateTime(5000), _player->m_Events.CalculateTime(10000), _player->m_Events.CalculateTime(15000)));

        return false; // do not delete re-added event in EventProcessor::Update
    }

private:
    Player* _player;
};

class spell_item_party_time : public AuraScript
{
    PrepareAuraScript(spell_item_party_time);

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player* player = GetOwner()->ToPlayer();
        if (!player)
        {
            return;
        }

        player->m_Events.AddEvent(new PartyTimeEmoteEvent(player), RAND(player->m_Events.CalculateTime(5000), player->m_Events.CalculateTime(10000), player->m_Events.CalculateTime(15000)));
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_item_party_time::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 71610, 71641 - Echoes of Light (Althor's Abacus)
class spell_item_echoes_of_light : public SpellScript
{
    PrepareSpellScript(spell_item_echoes_of_light);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (targets.size() < 2)
            return;

        targets.sort(Acore::HealthPctOrderPred());

        WorldObject* target = targets.front();
        targets.clear();
        targets.push_back(target);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_item_echoes_of_light::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ALLY);
    }
};

// 7434 - Fate Rune of Unsurpassed Vigor
enum FateRuneOfUnsurpassedVigor
{
    SPELL_UNSURPASSED_VIGOR = 25733
};

class spell_item_fate_rune_of_unsurpassed_vigor : public AuraScript
{
    PrepareAuraScript(spell_item_fate_rune_of_unsurpassed_vigor);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_UNSURPASSED_VIGOR });
    }

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& /*eventInfo*/)
    {
        GetTarget()->CastSpell(GetTarget(), SPELL_UNSURPASSED_VIGOR, true);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_item_fate_rune_of_unsurpassed_vigor::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// http://www.wowhead.com/item=47499 Flask of the North
// 67019 Flask of the North
enum FlaskOfTheNorthSpells
{
    SPELL_FLASK_OF_THE_NORTH_SP = 67016,
    SPELL_FLASK_OF_THE_NORTH_AP = 67017,
    SPELL_FLASK_OF_THE_NORTH_STR = 67018,
};

class spell_item_flask_of_the_north : public SpellScript
{
    PrepareSpellScript(spell_item_flask_of_the_north);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FLASK_OF_THE_NORTH_SP, SPELL_FLASK_OF_THE_NORTH_AP, SPELL_FLASK_OF_THE_NORTH_STR });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        std::vector<uint32> possibleSpells;
        switch (caster->getClass())
        {
            case CLASS_WARLOCK:
            case CLASS_MAGE:
            case CLASS_PRIEST:
                possibleSpells.push_back(SPELL_FLASK_OF_THE_NORTH_SP);
                break;
            case CLASS_DEATH_KNIGHT:
            case CLASS_WARRIOR:
                possibleSpells.push_back(SPELL_FLASK_OF_THE_NORTH_STR);
                break;
            case CLASS_ROGUE:
            case CLASS_HUNTER:
                possibleSpells.push_back(SPELL_FLASK_OF_THE_NORTH_AP);
                break;
            case CLASS_DRUID:
            case CLASS_PALADIN:
                possibleSpells.push_back(SPELL_FLASK_OF_THE_NORTH_SP);
                possibleSpells.push_back(SPELL_FLASK_OF_THE_NORTH_STR);
                break;
            case CLASS_SHAMAN:
                possibleSpells.push_back(SPELL_FLASK_OF_THE_NORTH_SP);
                possibleSpells.push_back(SPELL_FLASK_OF_THE_NORTH_AP);
                break;
        }

        caster->CastSpell(caster, possibleSpells[irand(0, (possibleSpells.size() - 1))], true, nullptr);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_item_flask_of_the_north::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// http://www.wowhead.com/item=10645 Gnomish Death Ray
// 13280 Gnomish Death Ray
enum GnomishDeathRay
{
    SPELL_GNOMISH_DEATH_RAY_TARGET  = 13279,
};

class spell_item_gnomish_death_ray : public SpellScript
{
    PrepareSpellScript(spell_item_gnomish_death_ray);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_GNOMISH_DEATH_RAY_TARGET });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (Unit* target = ObjectAccessor::GetUnit(*caster, caster->GetGuidValue(UNIT_FIELD_CHANNEL_OBJECT)))
            {
                caster->CastSpell(target, SPELL_GNOMISH_DEATH_RAY_TARGET, true);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_gnomish_death_ray::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// http://www.wowhead.com/item=27388 Mr. Pinchy
// 33060 Make a Wish
enum MakeAWish
{
    SPELL_MR_PINCHYS_BLESSING       = 33053,
    SPELL_SUMMON_MIGHTY_MR_PINCHY   = 33057,
    SPELL_SUMMON_FURIOUS_MR_PINCHY  = 33059,
    SPELL_TINY_MAGICAL_CRAWDAD      = 33062,
    SPELL_MR_PINCHYS_GIFT           = 33064,
};

class spell_item_make_a_wish : public SpellScript
{
    PrepareSpellScript(spell_item_make_a_wish);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_MR_PINCHYS_BLESSING,
                SPELL_SUMMON_MIGHTY_MR_PINCHY,
                SPELL_SUMMON_FURIOUS_MR_PINCHY,
                SPELL_TINY_MAGICAL_CRAWDAD,
                SPELL_MR_PINCHYS_GIFT
            });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        uint32 spellId = SPELL_MR_PINCHYS_GIFT;
        switch (urand(1, 5))
        {
            case 1:
                spellId = SPELL_MR_PINCHYS_BLESSING;
                break;
            case 2:
                spellId = SPELL_SUMMON_MIGHTY_MR_PINCHY;
                break;
            case 3:
                spellId = SPELL_SUMMON_FURIOUS_MR_PINCHY;
                break;
            case 4:
                spellId = SPELL_TINY_MAGICAL_CRAWDAD;
                break;
        }
        caster->CastSpell(caster, spellId, true, nullptr);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_item_make_a_wish::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum MingoFortune
{
    SPELL_CREATE_FORTUNE_1       = 40804,
    SPELL_CREATE_FORTUNE_2       = 40805,
    SPELL_CREATE_FORTUNE_3       = 40806,
    SPELL_CREATE_FORTUNE_4       = 40807,
    SPELL_CREATE_FORTUNE_5       = 40808,
    SPELL_CREATE_FORTUNE_6       = 40809,
    SPELL_CREATE_FORTUNE_7       = 40908,
    SPELL_CREATE_FORTUNE_8       = 40910,
    SPELL_CREATE_FORTUNE_9       = 40911,
    SPELL_CREATE_FORTUNE_10      = 40912,
    SPELL_CREATE_FORTUNE_11      = 40913,
    SPELL_CREATE_FORTUNE_12      = 40914,
    SPELL_CREATE_FORTUNE_13      = 40915,
    SPELL_CREATE_FORTUNE_14      = 40916,
    SPELL_CREATE_FORTUNE_15      = 40918,
    SPELL_CREATE_FORTUNE_16      = 40919,
    SPELL_CREATE_FORTUNE_17      = 40920,
    SPELL_CREATE_FORTUNE_18      = 40921,
    SPELL_CREATE_FORTUNE_19      = 40922,
    SPELL_CREATE_FORTUNE_20      = 40923
};

std::array<uint32, 20> const CreateFortuneSpells =
{
    SPELL_CREATE_FORTUNE_1, SPELL_CREATE_FORTUNE_2, SPELL_CREATE_FORTUNE_3, SPELL_CREATE_FORTUNE_4, SPELL_CREATE_FORTUNE_5,
    SPELL_CREATE_FORTUNE_6, SPELL_CREATE_FORTUNE_7, SPELL_CREATE_FORTUNE_8, SPELL_CREATE_FORTUNE_9, SPELL_CREATE_FORTUNE_10,
    SPELL_CREATE_FORTUNE_11, SPELL_CREATE_FORTUNE_12, SPELL_CREATE_FORTUNE_13, SPELL_CREATE_FORTUNE_14, SPELL_CREATE_FORTUNE_15,
    SPELL_CREATE_FORTUNE_16, SPELL_CREATE_FORTUNE_17, SPELL_CREATE_FORTUNE_18, SPELL_CREATE_FORTUNE_19, SPELL_CREATE_FORTUNE_20
};

// 26465 - Mercurial Shield
enum MercurialShield
{
    SPELL_MERCURIAL_SHIELD = 26464
};

class spell_item_mercurial_shield : public SpellScript
{
    PrepareSpellScript(spell_item_mercurial_shield);

    void HandleScript(SpellEffIndex /* effIndex */)
    {
        GetHitUnit()->RemoveAuraFromStack(SPELL_MERCURIAL_SHIELD);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_mercurial_shield::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// http://www.wowhead.com/item=32686 Mingo's Fortune Giblets
// 40802 Mingo's Fortune Generator
class spell_item_mingos_fortune_generator : public SpellScript
{
    PrepareSpellScript(spell_item_mingos_fortune_generator);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(CreateFortuneSpells);
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetCaster(), Acore::Containers::SelectRandomContainerElement(CreateFortuneSpells), true);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_item_mingos_fortune_generator::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 71875, 71877 - Item - Black Bruise: Necrotic Touch Proc
enum NecroticTouch
{
    SPELL_ITEM_NECROTIC_TOUCH_PROC  = 71879
};

class spell_item_necrotic_touch : public AuraScript
{
    PrepareAuraScript(spell_item_necrotic_touch);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ITEM_NECROTIC_TOUCH_PROC });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetProcTarget() && eventInfo.GetProcTarget()->IsAlive();
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        DamageInfo* damageInfo = eventInfo.GetDamageInfo();

        if (!damageInfo || !damageInfo->GetDamage())
        {
            return;
        }

        int32 bp = CalculatePct(static_cast<int32>(damageInfo->GetDamage()), aurEff->GetAmount());
        GetTarget()->CastCustomSpell(SPELL_ITEM_NECROTIC_TOUCH_PROC, SPELLVALUE_BASE_POINT0, bp, eventInfo.GetProcTarget(), true, nullptr, aurEff);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_item_necrotic_touch::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_item_necrotic_touch::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// http://www.wowhead.com/item=10720 Gnomish Net-o-Matic Projector
// 13120 Net-o-Matic
enum NetOMaticSpells
{
    SPELL_NET_O_MATIC_TRIGGERED1 = 16566,
    SPELL_NET_O_MATIC_TRIGGERED2 = 13119,
    SPELL_NET_O_MATIC_TRIGGERED3 = 13099,
};

class spell_item_net_o_matic : public SpellScript
{
    PrepareSpellScript(spell_item_net_o_matic);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_NET_O_MATIC_TRIGGERED1,
                SPELL_NET_O_MATIC_TRIGGERED2,
                SPELL_NET_O_MATIC_TRIGGERED3
            });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            uint32 spellId = SPELL_NET_O_MATIC_TRIGGERED3;
            uint32 roll = urand(0, 99);
            if (roll < 2)                            // 2% for 30 sec self root (off-like chance unknown)
                spellId = SPELL_NET_O_MATIC_TRIGGERED1;
            else if (roll < 4)                       // 2% for 20 sec root, charge to target (off-like chance unknown)
                spellId = SPELL_NET_O_MATIC_TRIGGERED2;

            GetCaster()->CastSpell(target, spellId, true, nullptr);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_net_o_matic::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// http://www.wowhead.com/item=8529 Noggenfogger Elixir
// 16589 Noggenfogger Elixir
enum NoggenfoggerElixirSpells
{
    SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED1 = 16595,
    SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED2 = 16593,
    SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED3 = 16591,
};

class spell_item_noggenfogger_elixir : public SpellScript
{
    PrepareSpellScript(spell_item_noggenfogger_elixir);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED1,
                SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED2,
                SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED3
            });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        uint32 spellId = SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED3;
        switch (urand(1, 3))
        {
            case 1:
                spellId = SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED1;
                break;
            case 2:
                spellId = SPELL_NOGGENFOGGER_ELIXIR_TRIGGERED2;
                break;
        }

        caster->CastSpell(caster, spellId, true, nullptr);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_item_noggenfogger_elixir::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 17512 - Piccolo of the Flaming Fire
class spell_item_piccolo_of_the_flaming_fire : public SpellScript
{
    PrepareSpellScript(spell_item_piccolo_of_the_flaming_fire);

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Player* target = GetHitPlayer())
            target->HandleEmoteCommand(EMOTE_STATE_DANCE);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_piccolo_of_the_flaming_fire::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// http://www.wowhead.com/item=6657 Savory Deviate Delight
// 8213 Savory Deviate Delight
enum SavoryDeviateDelight
{
    SPELL_FLIP_OUT_MALE     = 8219,
    SPELL_FLIP_OUT_FEMALE   = 8220,
    SPELL_YAAARRRR_MALE     = 8221,
    SPELL_YAAARRRR_FEMALE   = 8222,
};

class spell_item_savory_deviate_delight : public SpellScript
{
    PrepareSpellScript(spell_item_savory_deviate_delight);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        for (uint32 spellId = SPELL_FLIP_OUT_MALE; spellId <= SPELL_YAAARRRR_FEMALE; ++spellId)
            if (!sSpellMgr->GetSpellInfo(spellId))
                return false;
        return true;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        uint32 spellId = 0;
        switch (urand(1, 2))
        {
            // Flip Out - ninja
            case 1:
                spellId = (caster->getGender() == GENDER_MALE ? SPELL_FLIP_OUT_MALE : SPELL_FLIP_OUT_FEMALE);
                break;
            // Yaaarrrr - pirate
            case 2:
                spellId = (caster->getGender() == GENDER_MALE ? SPELL_YAAARRRR_MALE : SPELL_YAAARRRR_FEMALE);
                break;
        }
        caster->CastSpell(caster, spellId, true, nullptr);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_item_savory_deviate_delight::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 48129 - Scroll of Recall
// 60320 - Scroll of Recall II
// 60321 - Scroll of Recall III
enum ScrollOfRecall
{
    SPELL_SCROLL_OF_RECALL_I                = 48129,
    SPELL_SCROLL_OF_RECALL_II               = 60320,
    SPELL_SCROLL_OF_RECALL_III              = 60321,
    SPELL_LOST                              = 60444,
    SPELL_SCROLL_OF_RECALL_FAIL_ALLIANCE_1  = 60323,
    SPELL_SCROLL_OF_RECALL_FAIL_HORDE_1     = 60328,
};

class spell_item_scroll_of_recall : public SpellScript
{
    PrepareSpellScript(spell_item_scroll_of_recall);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        Unit* caster = GetCaster();
        uint8 maxSafeLevel = 0;
        switch (GetSpellInfo()->Id)
        {
            case SPELL_SCROLL_OF_RECALL_I:  // Scroll of Recall
                maxSafeLevel = 40;
                break;
            case SPELL_SCROLL_OF_RECALL_II:  // Scroll of Recall II
                maxSafeLevel = 70;
                break;
            case SPELL_SCROLL_OF_RECALL_III:  // Scroll of Recal III
                maxSafeLevel = 80;
                break;
            default:
                break;
        }

        if (caster->GetLevel() > maxSafeLevel)
        {
            caster->CastSpell(caster, SPELL_LOST, true);

            // ALLIANCE from 60323 to 60330 - HORDE from 60328 to 60335
            uint32 spellId = SPELL_SCROLL_OF_RECALL_FAIL_ALLIANCE_1;
            if (GetCaster()->ToPlayer()->GetTeamId() == TEAM_HORDE)
                spellId = SPELL_SCROLL_OF_RECALL_FAIL_HORDE_1;

            GetCaster()->CastSpell(GetCaster(), spellId + urand(0, 7), true);

            PreventHitDefaultEffect(effIndex);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_scroll_of_recall::HandleScript, EFFECT_0, SPELL_EFFECT_TELEPORT_UNITS);
    }
};

// 36890 - Dimensional Ripper - Area 52
enum DimensionalRipperArea52
{
    SPELL_TRANSPORTER_MALFUNCTION    = 36895,
    SPELL_TRANSFORM_HORDE            = 36897,
    SPELL_TRANSFORM_ALLIANCE         = 36899,
    SPELL_SOUL_SPLIT_EVIL            = 36900,
    SPELL_SOUL_SPLIT_GOOD            = 36901
};

class spell_item_dimensional_ripper_area52 : public SpellScript
{
    PrepareSpellScript(spell_item_dimensional_ripper_area52);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    void HandleScript(SpellEffIndex /* effIndex */)
    {
        if (!roll_chance_i(50)) // 50% success
            return;

        Unit* caster = GetCaster();

        uint32 spellId = 0;
        switch (urand(0, 3))
        {
            case 0:
                spellId = SPELL_TRANSPORTER_MALFUNCTION;
                break;
            case 1:
                spellId = SPELL_SOUL_SPLIT_EVIL;
                break;
            case 2:
                spellId = SPELL_SOUL_SPLIT_GOOD;
                break;
            case 3:
                if (caster->ToPlayer()->GetTeamId() == TEAM_ALLIANCE)
                    spellId = SPELL_TRANSFORM_HORDE;
                else
                    spellId = SPELL_TRANSFORM_ALLIANCE;
                break;
        }

        caster->CastSpell(caster, spellId, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_dimensional_ripper_area52::HandleScript, EFFECT_0, SPELL_EFFECT_TELEPORT_UNITS);
    }
};

// 71169 - Shadow's Fate (Shadowmourne questline)
enum ShadowsFate
{
    SPELL_SOUL_FEAST        = 71203,
};

enum ExceptionCreature
{
    NPC_GLUTTONOUS_ABOMINATION = 37886,
    NPC_RISEN_ARCHMAGE         = 37868,
    NPC_BLISTERING_ZOMBIE      = 37934,
    NPC_BLAZING_SKELETON       = 36791,
    NPC_SINDRAGOSA             = 36853
};

class spell_item_unsated_craving : public AuraScript
{
    PrepareAuraScript(spell_item_unsated_craving);

    bool isException(Unit* target) const
    {
        switch (target->GetEntry())
        {
            case NPC_GLUTTONOUS_ABOMINATION:
            case NPC_RISEN_ARCHMAGE:
            case NPC_BLISTERING_ZOMBIE:
            case NPC_BLAZING_SKELETON:
            case NPC_SINDRAGOSA:
                return true;
            default:
                return false;
        }
    }

    bool CheckProc(ProcEventInfo& procInfo)
    {
        Unit* caster = procInfo.GetActor();
        if (!caster || !caster->IsPlayer())
        {
            return false;
        }

        Unit* target = procInfo.GetActionTarget();
        if (target && isException(target))
        {
            return true;
        }

        if (!target || !target->IsCreature() || target->IsCritter() || target->IsSummon())
        {
            return false;
        }

        return true;
    }

    // xinef: prevent default proc with castItem passed, which applies 30 sec cooldown to procing of the aura
    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        eventInfo.GetActor()->CastSpell(eventInfo.GetActionTarget(), GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_item_unsated_craving::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_item_unsated_craving::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

class spell_item_shadows_fate : public AuraScript
{
    PrepareAuraScript(spell_item_shadows_fate);

    void HandleProc(AuraEffect const*  /*aurEff*/, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        Unit* caster = eventInfo.GetActor();
        Unit* target = GetCaster();
        if (!caster || !target)
            return;

        caster->CastSpell(target, SPELL_SOUL_FEAST, TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_item_shadows_fate::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

enum Shadowmourne
{
    SPELL_SHADOWMOURNE_CHAOS_BANE_DAMAGE    = 71904,
    SPELL_SHADOWMOURNE_SOUL_FRAGMENT        = 71905,
    SPELL_SHADOWMOURNE_VISUAL_LOW           = 72521,
    SPELL_SHADOWMOURNE_VISUAL_HIGH          = 72523,
    SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF      = 73422,
    SPELL_BLOOD_PLAGUE                      = 55078,
};

// 71903 - Item - Shadowmourne Legendary
class spell_item_shadowmourne : public AuraScript
{
    PrepareAuraScript(spell_item_shadowmourne);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_SHADOWMOURNE_CHAOS_BANE_DAMAGE,
                SPELL_SHADOWMOURNE_SOUL_FRAGMENT,
                SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF
            });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (GetTarget()->HasAura(SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF)) // cant collect shards while under effect of Chaos Bane buff
            return false;

        // Xinef: Not on BG / Arena
        /*if (!GetTarget()->FindMap() || GetTarget()->FindMap()->IsBattlegroundOrArena())
            return false;*/

        if (SpellInfo const* procSpell = eventInfo.GetSpellInfo())
        {
            if (eventInfo.GetDamageInfo() && !eventInfo.GetDamageInfo()->GetDamage())
            {
                if (!procSpell->SpellFamilyFlags.HasFlag(0x2 | 0x20 | 0x4000, 0x0, 0x0))
                    return false;
            }
            else if (procSpell->SpellFamilyName == SPELLFAMILY_DEATHKNIGHT)
            {
                if (procSpell->Id != SPELL_BLOOD_PLAGUE)
                    return false;
            }
        }

        return true;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(GetTarget(), SPELL_SHADOWMOURNE_SOUL_FRAGMENT, true, nullptr, aurEff);

        // this can't be handled in AuraScript of SoulFragments because we need to know victim
        if (Aura* soulFragments = GetTarget()->GetAura(SPELL_SHADOWMOURNE_SOUL_FRAGMENT))
        {
            if (soulFragments->GetStackAmount() >= 10)
            {
                GetTarget()->CastSpell(eventInfo.GetProcTarget(), SPELL_SHADOWMOURNE_CHAOS_BANE_DAMAGE, true, nullptr, aurEff);
                soulFragments->Remove();
            }
        }
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(SPELL_SHADOWMOURNE_SOUL_FRAGMENT);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_item_shadowmourne::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_item_shadowmourne::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
        AfterEffectRemove += AuraEffectRemoveFn(spell_item_shadowmourne::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 71905 - Soul Fragment
class spell_item_shadowmourne_soul_fragment : public AuraScript
{
    PrepareAuraScript(spell_item_shadowmourne_soul_fragment);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SHADOWMOURNE_VISUAL_LOW, SPELL_SHADOWMOURNE_VISUAL_HIGH, SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF });
    }

    void OnStackChange(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        switch (GetStackAmount())
        {
            case 1:
                target->CastSpell(target, SPELL_SHADOWMOURNE_VISUAL_LOW, true);
                break;
            case 6:
                target->RemoveAurasDueToSpell(SPELL_SHADOWMOURNE_VISUAL_LOW);
                target->CastSpell(target, SPELL_SHADOWMOURNE_VISUAL_HIGH, true);
                break;
            case 10:
                target->RemoveAurasDueToSpell(SPELL_SHADOWMOURNE_VISUAL_HIGH);
                target->CastSpell(target, SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF, true);
                break;
            default:
                break;
        }
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->RemoveAurasDueToSpell(SPELL_SHADOWMOURNE_VISUAL_LOW);
        target->RemoveAurasDueToSpell(SPELL_SHADOWMOURNE_VISUAL_HIGH);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_item_shadowmourne_soul_fragment::OnStackChange, EFFECT_0, SPELL_AURA_MOD_STAT, AuraEffectHandleModes(AURA_EFFECT_HANDLE_REAL | AURA_EFFECT_HANDLE_REAPPLY));
        AfterEffectRemove += AuraEffectRemoveFn(spell_item_shadowmourne_soul_fragment::OnRemove, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_REAL);
    }
};

// http://www.wowhead.com/item=7734 Six Demon Bag
// 14537 Six Demon Bag
enum SixDemonBagSpells
{
    SPELL_FROSTBOLT                 = 11538,
    SPELL_POLYMORPH                 = 14621,
    SPELL_SUMMON_FELHOUND_MINION    = 14642,
    SPELL_FIREBALL                  = 15662,
    SPELL_CHAIN_LIGHTNING           = 21179,
    SPELL_ENVELOPING_WINDS          = 25189,
};

class spell_item_six_demon_bag : public SpellScript
{
    PrepareSpellScript(spell_item_six_demon_bag);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_FROSTBOLT,
                SPELL_POLYMORPH,
                SPELL_SUMMON_FELHOUND_MINION,
                SPELL_FIREBALL,
                SPELL_CHAIN_LIGHTNING,
                SPELL_ENVELOPING_WINDS
            });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (Unit* target = GetHitUnit())
        {
            uint32 spellId = 0;
            uint32 rand = urand(0, 99);
            if (rand < 25)                      // Fireball (25% chance)
                spellId = SPELL_FIREBALL;
            else if (rand < 50)                 // Frostball (25% chance)
                spellId = SPELL_FROSTBOLT;
            else if (rand < 70)                 // Chain Lighting (20% chance)
                spellId = SPELL_CHAIN_LIGHTNING;
            else if (rand < 80)                 // Polymorph (10% chance)
            {
                spellId = SPELL_POLYMORPH;
                if (urand(0, 100) <= 30)        // 30% chance to self-cast
                    target = caster;
            }
            else if (rand < 95)                 // Enveloping Winds (15% chance)
                spellId = SPELL_ENVELOPING_WINDS;
            else                                // Summon Felhund minion (5% chance)
            {
                spellId = SPELL_SUMMON_FELHOUND_MINION;
                target = caster;
            }

            caster->CastSpell(target, spellId, true, GetCastItem());
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_six_demon_bag::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 28862 - The Eye of Diminution
class spell_item_the_eye_of_diminution : public AuraScript
{
    PrepareAuraScript(spell_item_the_eye_of_diminution);

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        int32 diff = GetUnitOwner()->GetLevel() - 60;
        if (diff > 0)
            amount += diff;
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_item_the_eye_of_diminution::CalculateAmount, EFFECT_0, SPELL_AURA_MOD_THREAT);
    }
};

// http://www.wowhead.com/item=44012 Underbelly Elixir
// 59640 Underbelly Elixir
enum UnderbellyElixirSpells
{
    SPELL_UNDERBELLY_ELIXIR_TRIGGERED1  = 59645,
    SPELL_UNDERBELLY_ELIXIR_TRIGGERED2  = 59831,
    SPELL_UNDERBELLY_ELIXIR_TRIGGERED3  = 59843,
    AREA_UNDERBELLY                     = 4560,
};

class spell_item_underbelly_elixir : public SpellScript
{
    PrepareSpellScript(spell_item_underbelly_elixir);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }
    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_UNDERBELLY_ELIXIR_TRIGGERED1,
                SPELL_UNDERBELLY_ELIXIR_TRIGGERED2,
                SPELL_UNDERBELLY_ELIXIR_TRIGGERED3
            });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        uint32 spellId = SPELL_UNDERBELLY_ELIXIR_TRIGGERED2;
        switch (urand(1, (caster->GetPositionZ() < 637 ? 3 : 2)))
        {
            case 1:
                spellId = SPELL_UNDERBELLY_ELIXIR_TRIGGERED1;
                break;
            case 2:
                spellId = SPELL_UNDERBELLY_ELIXIR_TRIGGERED3;
                break;
        }
        caster->CastSpell(caster, spellId, true, GetCastItem(), nullptr, caster->GetGUID());
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_item_underbelly_elixir::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum GenericData
{
    SPELL_ARCANITE_DRAGONLING           = 19804,
    SPELL_BATTLE_CHICKEN                = 13166,
    SPELL_MECHANICAL_DRAGONLING         = 4073,
    SPELL_MITHRIL_MECHANICAL_DRAGONLING = 12749,
};

class spell_item_book_of_glyph_mastery : public SpellScript
{
    PrepareSpellScript(spell_item_book_of_glyph_mastery);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    SpellCastResult CheckRequirement()
    {
        if (HasDiscoveredAllSpells(GetSpellInfo()->Id, GetCaster()->ToPlayer()))
        {
            SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_LEARNED_EVERYTHING);
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
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_item_book_of_glyph_mastery::CheckRequirement);
        OnEffectHitTarget += SpellEffectFn(spell_item_book_of_glyph_mastery::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum Sinkholes
{
    NPC_SOUTH_SINKHOLE      = 25664,
    NPC_NORTHEAST_SINKHOLE  = 25665,
    NPC_NORTHWEST_SINKHOLE  = 25666,
};

class spell_item_map_of_the_geyser_fields : public SpellScript
{
    PrepareSpellScript(spell_item_map_of_the_geyser_fields);

    SpellCastResult CheckSinkholes()
    {
        Unit* caster = GetCaster();
        if (caster->FindNearestCreature(NPC_SOUTH_SINKHOLE, 30.0f, true) ||
                caster->FindNearestCreature(NPC_NORTHEAST_SINKHOLE, 30.0f, true) ||
                caster->FindNearestCreature(NPC_NORTHWEST_SINKHOLE, 30.0f, true))
            return SPELL_CAST_OK;

        SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_MUST_BE_CLOSE_TO_SINKHOLE);
        return SPELL_FAILED_CUSTOM_ERROR;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_item_map_of_the_geyser_fields::CheckSinkholes);
    }
};

enum VanquishedClutchesSpells
{
    SPELL_CRUSHER       = 64982,
    SPELL_CONSTRICTOR   = 64983,
    SPELL_CORRUPTOR     = 64984,
};

class spell_item_vanquished_clutches : public SpellScript
{
    PrepareSpellScript(spell_item_vanquished_clutches);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_CRUSHER,
                SPELL_CONSTRICTOR,
                SPELL_CORRUPTOR
            });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        uint32 spellId = RAND(SPELL_CRUSHER, SPELL_CONSTRICTOR, SPELL_CORRUPTOR);
        Unit* caster = GetCaster();
        caster->CastSpell(caster, spellId, true);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_item_vanquished_clutches::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum AshbringerSounds
{
    SOUND_ASHBRINGER_1  = 8906,                             // "I was pure once"
    SOUND_ASHBRINGER_2  = 8907,                             // "Fought for righteousness"
    SOUND_ASHBRINGER_3  = 8908,                             // "I was once called Ashbringer"
    SOUND_ASHBRINGER_4  = 8920,                             // "Betrayed by my order"
    SOUND_ASHBRINGER_5  = 8921,                             // "Destroyed by Kel'Thuzad"
    SOUND_ASHBRINGER_6  = 8922,                             // "Made to serve"
    SOUND_ASHBRINGER_7  = 8923,                             // "My son watched me die"
    SOUND_ASHBRINGER_8  = 8924,                             // "Crusades fed his rage"
    SOUND_ASHBRINGER_9  = 8925,                             // "Truth is unknown to him"
    SOUND_ASHBRINGER_10 = 8926,                             // "Scarlet Crusade  is pure no longer"
    SOUND_ASHBRINGER_11 = 8927,                             // "Balnazzar's crusade corrupted my son"
    SOUND_ASHBRINGER_12 = 8928,                             // "Kill them all!"
};

class spell_item_ashbringer : public SpellScript
{
    PrepareSpellScript(spell_item_ashbringer);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    void OnDummyEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        Player* player = GetCaster()->ToPlayer();
        uint32 sound_id = RAND( SOUND_ASHBRINGER_1, SOUND_ASHBRINGER_2, SOUND_ASHBRINGER_3, SOUND_ASHBRINGER_4, SOUND_ASHBRINGER_5, SOUND_ASHBRINGER_6,
                                SOUND_ASHBRINGER_7, SOUND_ASHBRINGER_8, SOUND_ASHBRINGER_9, SOUND_ASHBRINGER_10, SOUND_ASHBRINGER_11, SOUND_ASHBRINGER_12 );

        // Ashbringers effect (spellID 28441) retriggers every 5 seconds, with a chance of making it say one of the above 12 sounds
        if (urand(0, 60) < 1)
            player->PlayDirectSound(sound_id, player);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_item_ashbringer::OnDummyEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum MagicEater
{
    SPELL_WILD_MAGIC                             = 58891,
    SPELL_WELL_FED_1                             = 57288,
    SPELL_WELL_FED_2                             = 57139,
    SPELL_WELL_FED_3                             = 57111,
    SPELL_WELL_FED_4                             = 57286,
    SPELL_WELL_FED_5                             = 57291,
};

class spell_magic_eater_food : public AuraScript
{
    PrepareAuraScript(spell_magic_eater_food);

    void HandleTriggerSpell(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        Unit* target = GetTarget();
        switch (urand(0, 5))
        {
            case 0:
                target->CastSpell(target, SPELL_WILD_MAGIC, true);
                break;
            case 1:
                target->CastSpell(target, SPELL_WELL_FED_1, true);
                break;
            case 2:
                target->CastSpell(target, SPELL_WELL_FED_2, true);
                break;
            case 3:
                target->CastSpell(target, SPELL_WELL_FED_3, true);
                break;
            case 4:
                target->CastSpell(target, SPELL_WELL_FED_4, true);
                break;
            case 5:
                target->CastSpell(target, SPELL_WELL_FED_5, true);
                break;
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_magic_eater_food::HandleTriggerSpell, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_item_shimmering_vessel : public SpellScript
{
    PrepareSpellScript(spell_item_shimmering_vessel);

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        if (Creature* target = GetHitCreature())
            target->setDeathState(DeathState::JustRespawned);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_shimmering_vessel::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum PurifyHelboarMeat
{
    SPELL_SUMMON_PURIFIED_HELBOAR_MEAT      = 29277,
    SPELL_SUMMON_TOXIC_HELBOAR_MEAT         = 29278,
};

class spell_item_purify_helboar_meat : public SpellScript
{
    PrepareSpellScript(spell_item_purify_helboar_meat);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_PURIFIED_HELBOAR_MEAT, SPELL_SUMMON_TOXIC_HELBOAR_MEAT });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Unit* caster = GetCaster();
        caster->CastSpell(caster, roll_chance_i(50) ? SPELL_SUMMON_PURIFIED_HELBOAR_MEAT : SPELL_SUMMON_TOXIC_HELBOAR_MEAT, true, nullptr);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_purify_helboar_meat::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum ReindeerTransformation
{
    SPELL_FLYING_REINDEER_310                   = 44827,
    SPELL_FLYING_REINDEER_280                   = 44825,
    SPELL_FLYING_REINDEER_60                    = 44824,
    SPELL_REINDEER_100                          = 25859,
    SPELL_REINDEER_60                           = 25858,
};

class spell_item_reindeer_transformation : public SpellScript
{
    PrepareSpellScript(spell_item_reindeer_transformation);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_FLYING_REINDEER_310,
                SPELL_FLYING_REINDEER_280,
                SPELL_FLYING_REINDEER_60,
                SPELL_REINDEER_100,
                SPELL_REINDEER_60
            });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Unit* caster = GetCaster();
        if (caster->HasAuraType(SPELL_AURA_MOUNTED))
        {
            float flyspeed = caster->GetSpeedRate(MOVE_FLIGHT);
            float speed = caster->GetSpeedRate(MOVE_RUN);

            caster->RemoveAurasByType(SPELL_AURA_MOUNTED);
            //5 different spells used depending on mounted speed and if mount can fly or not

            if (flyspeed >= 4.1f)
                // Flying Reindeer
                caster->CastSpell(caster, SPELL_FLYING_REINDEER_310, true); //310% flying Reindeer
            else if (flyspeed >= 3.8f)
                // Flying Reindeer
                caster->CastSpell(caster, SPELL_FLYING_REINDEER_280, true); //280% flying Reindeer
            else if (flyspeed >= 1.6f)
                // Flying Reindeer
                caster->CastSpell(caster, SPELL_FLYING_REINDEER_60, true); //60% flying Reindeer
            else if (speed >= 2.0f)
                // Reindeer
                caster->CastSpell(caster, SPELL_REINDEER_100, true); //100% ground Reindeer
            else
                // Reindeer
                caster->CastSpell(caster, SPELL_REINDEER_60, true); //60% ground Reindeer
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_reindeer_transformation::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum NighInvulnerability
{
    SPELL_NIGH_INVULNERABILITY                  = 30456,
    SPELL_COMPLETE_VULNERABILITY                = 30457,
};

class spell_item_nigh_invulnerability : public SpellScript
{
    PrepareSpellScript(spell_item_nigh_invulnerability);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_NIGH_INVULNERABILITY, SPELL_COMPLETE_VULNERABILITY });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Unit* caster = GetCaster();
        if (Item* castItem = GetCastItem())
        {
            if (roll_chance_i(86))                  // Nigh-Invulnerability   - success
                caster->CastSpell(caster, SPELL_NIGH_INVULNERABILITY, true, castItem);
            else                                    // Complete Vulnerability - backfire in 14% casts
                caster->CastSpell(caster, SPELL_COMPLETE_VULNERABILITY, true, castItem);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_nigh_invulnerability::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum Poultryzer
{
    SPELL_POULTRYIZER_SUCCESS_1  = 30501,
    SPELL_POULTRYIZER_SUCCESS_2  = 30504, // malfunction
    SPELL_POULTRYIZER_BACKFIRE   = 30506, // Not removed on damage
};

class spell_item_poultryizer : public SpellScript
{
    PrepareSpellScript(spell_item_poultryizer);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_POULTRYIZER_SUCCESS_1, SPELL_POULTRYIZER_SUCCESS_2, SPELL_POULTRYIZER_BACKFIRE });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        if (GetCastItem() && GetHitUnit())
        {
            if (roll_chance_i(80))
            {
                GetCaster()->CastSpell(GetHitUnit(), roll_chance_i(80) ? SPELL_POULTRYIZER_SUCCESS_1 : SPELL_POULTRYIZER_SUCCESS_2, true, GetCastItem());
            }
            else
            {
                GetCaster()->CastSpell(GetCaster(),  SPELL_POULTRYIZER_BACKFIRE, true, GetCastItem());
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_poultryizer::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum SocretharsStone
{
    SPELL_SOCRETHAR_TO_SEAT     = 35743,
    SPELL_SOCRETHAR_FROM_SEAT   = 35744,
};

class spell_item_socrethars_stone : public SpellScript
{
    PrepareSpellScript(spell_item_socrethars_stone);

    bool Load() override
    {
        return (GetCaster()->GetAreaId() == 3900 || GetCaster()->GetAreaId() == 3742);
    }

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_SOCRETHAR_TO_SEAT, SPELL_SOCRETHAR_FROM_SEAT });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Unit* caster = GetCaster();
        switch (caster->GetAreaId())
        {
            case 3900:
                caster->CastSpell(caster, SPELL_SOCRETHAR_TO_SEAT, true);
                break;
            case 3742:
                caster->CastSpell(caster, SPELL_SOCRETHAR_FROM_SEAT, true);
                break;
            default:
                return;
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_socrethars_stone::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum DemonBroiledSurprise
{
    QUEST_SUPER_HOT_STEW                    = 11379,
    SPELL_CREATE_DEMON_BROILED_SURPRISE     = 43753,
    NPC_ABYSSAL_FLAMEBRINGER                = 19973,
};

class spell_item_demon_broiled_surprise : public SpellScript
{
    PrepareSpellScript(spell_item_demon_broiled_surprise);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_CREATE_DEMON_BROILED_SURPRISE });
    }

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Unit* player = GetCaster();
        player->CastSpell(player, SPELL_CREATE_DEMON_BROILED_SURPRISE, false);
    }

    SpellCastResult CheckRequirement()
    {
        Player* player = GetCaster()->ToPlayer();
        if (player->GetQuestStatus(QUEST_SUPER_HOT_STEW) != QUEST_STATUS_INCOMPLETE)
            return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;

        if (Creature* creature = player->FindNearestCreature(NPC_ABYSSAL_FLAMEBRINGER, 10, false))
            if (creature->isDead())
                return SPELL_CAST_OK;
        return SPELL_FAILED_NOT_HERE;
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_demon_broiled_surprise::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
        OnCheckCast += SpellCheckCastFn(spell_item_demon_broiled_surprise::CheckRequirement);
    }
};

enum CompleteRaptorCapture
{
    SPELL_RAPTOR_CAPTURE_CREDIT     = 42337,
};

class spell_item_complete_raptor_capture : public SpellScript
{
    PrepareSpellScript(spell_item_complete_raptor_capture);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_RAPTOR_CAPTURE_CREDIT });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Unit* caster = GetCaster();
        if (GetHitCreature())
        {
            GetHitCreature()->DespawnOrUnsummon();

            //cast spell Raptor Capture Credit
            caster->CastSpell(caster, SPELL_RAPTOR_CAPTURE_CREDIT, true, nullptr);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_complete_raptor_capture::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum ImpaleLeviroth
{
    NPC_LEVIROTH                = 26452,
    SPELL_LEVIROTH_SELF_IMPALE  = 49882,
};

class spell_item_impale_leviroth : public SpellScript
{
    PrepareSpellScript(spell_item_impale_leviroth);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        if (!sObjectMgr->GetCreatureTemplate(NPC_LEVIROTH))
            return false;
        return true;
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        if (Creature* target = GetHitCreature())
            if (target->GetEntry() == NPC_LEVIROTH && target->HealthAbovePct(94))
            {
                target->CastSpell(target, SPELL_LEVIROTH_SELF_IMPALE, true);
                target->SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, 150);
                target->SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, 200);
                target->LowerPlayerDamageReq(target->GetMaxHealth());
            }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_impale_leviroth::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum BrewfestMountTransformation
{
    SPELL_MOUNT_RAM_100                         = 43900,
    SPELL_MOUNT_RAM_60                          = 43899,
    SPELL_MOUNT_KODO_100                        = 49379,
    SPELL_MOUNT_KODO_60                         = 49378,
    SPELL_BREWFEST_MOUNT_TRANSFORM              = 49357,
    SPELL_BREWFEST_MOUNT_TRANSFORM_REVERSE      = 52845,
};

class spell_item_brewfest_mount_transformation : public SpellScript
{
    PrepareSpellScript(spell_item_brewfest_mount_transformation);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_MOUNT_RAM_100,
                SPELL_MOUNT_RAM_60,
                SPELL_MOUNT_KODO_100,
                SPELL_MOUNT_KODO_60
            });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Player* caster = GetCaster()->ToPlayer();

        if (!caster)
        {
            return;
        }

        if (caster->HasAuraType(SPELL_AURA_MOUNTED))
        {
            caster->RemoveAurasByType(SPELL_AURA_MOUNTED);
            uint32 spell_id;

            switch (GetSpellInfo()->Id)
            {
            case SPELL_BREWFEST_MOUNT_TRANSFORM:
                if (caster->GetSpeedRate(MOVE_RUN) >= 2.0f)
                    spell_id = caster->GetTeamId() == TEAM_ALLIANCE ? SPELL_MOUNT_RAM_100 : SPELL_MOUNT_KODO_100;
                else
                    spell_id = caster->GetTeamId() == TEAM_ALLIANCE ? SPELL_MOUNT_RAM_60 : SPELL_MOUNT_KODO_60;
                break;
            case SPELL_BREWFEST_MOUNT_TRANSFORM_REVERSE:
                if (caster->GetSpeedRate(MOVE_RUN) >= 2.0f)
                    spell_id = caster->GetTeamId() == TEAM_HORDE ? SPELL_MOUNT_RAM_100 : SPELL_MOUNT_KODO_100;
                else
                    spell_id = caster->GetTeamId() == TEAM_HORDE ? SPELL_MOUNT_RAM_60 : SPELL_MOUNT_KODO_60;
                break;
            default:
                return;
            }
            caster->CastSpell(caster, spell_id, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_brewfest_mount_transformation::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum NitroBoots
{
    SPELL_NITRO_BOOTS_SUCCESS       = 54861,
    SPELL_NITRO_BOOTS_BACKFIRE      = 46014,
};

class spell_item_nitro_boots : public SpellScript
{
    PrepareSpellScript(spell_item_nitro_boots);

    bool Load() override
    {
        if (!GetCastItem())
            return false;
        return true;
    }

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_NITRO_BOOTS_SUCCESS, SPELL_NITRO_BOOTS_BACKFIRE });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Unit* caster = GetCaster();
        caster->CastSpell(caster, caster->GetMap()->IsDungeon() || roll_chance_i(95) ? SPELL_NITRO_BOOTS_SUCCESS : SPELL_NITRO_BOOTS_BACKFIRE, true, GetCastItem());
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_nitro_boots::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum TeachLanguage
{
    SPELL_LEARN_GNOMISH_BINARY      = 50242,
    SPELL_LEARN_GOBLIN_BINARY       = 50246,
};

class spell_item_teach_language : public SpellScript
{
    PrepareSpellScript(spell_item_teach_language);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_LEARN_GNOMISH_BINARY, SPELL_LEARN_GOBLIN_BINARY });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Player* caster = GetCaster()->ToPlayer();

        if (roll_chance_i(34))
            caster->CastSpell(caster, caster->GetTeamId() == TEAM_ALLIANCE ? SPELL_LEARN_GNOMISH_BINARY : SPELL_LEARN_GOBLIN_BINARY, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_teach_language::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum RocketBoots
{
    SPELL_ROCKET_BOOTS_PROC      = 30452,
};

class spell_item_rocket_boots : public SpellScript
{
    PrepareSpellScript(spell_item_rocket_boots);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_ROCKET_BOOTS_PROC });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Player* caster = GetCaster()->ToPlayer();
        if (Battleground* bg = caster->GetBattleground())
            bg->EventPlayerDroppedFlag(caster);

        caster->RemoveSpellCooldown(SPELL_ROCKET_BOOTS_PROC);
        caster->CastSpell(caster, SPELL_ROCKET_BOOTS_PROC, true, nullptr);
    }

    SpellCastResult CheckCast()
    {
        if (GetCaster()->IsInWater())
            return SPELL_FAILED_ONLY_ABOVEWATER;
        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_item_rocket_boots::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_item_rocket_boots::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_item_healing_injector : public SpellScript
{
    PrepareSpellScript(spell_item_healing_injector);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    void HandleHeal(SpellEffIndex /*effIndex*/)
    {
        if (Player* caster = GetCaster()->ToPlayer())
            if (caster->HasSkill(SKILL_ENGINEERING))
                SetHitHeal(GetHitHeal() * 1.25f);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_healing_injector::HandleHeal, EFFECT_0, SPELL_EFFECT_HEAL);
    }
};

class spell_item_mana_injector : public SpellScript
{
    PrepareSpellScript(spell_item_mana_injector);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    void HandleEnergize(SpellEffIndex /*effIndex*/)
    {
        if (Player* caster = GetCaster()->ToPlayer())
        {
            if (caster->HasSkill(SKILL_ENGINEERING))
            {
                SetEffectValue(GetEffectValue() * 1.25f);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_mana_injector::HandleEnergize, EFFECT_0, SPELL_EFFECT_ENERGIZE);
    }
};

enum PygmyOil
{
    SPELL_PYGMY_OIL_PYGMY_AURA      = 53806,
    SPELL_PYGMY_OIL_SMALLER_AURA    = 53805,
};

class spell_item_pygmy_oil : public SpellScript
{
    PrepareSpellScript(spell_item_pygmy_oil);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_PYGMY_OIL_PYGMY_AURA, SPELL_PYGMY_OIL_SMALLER_AURA });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Unit* caster = GetCaster();
        if (Aura* aura = caster->GetAura(SPELL_PYGMY_OIL_PYGMY_AURA))
            aura->RefreshDuration();
        else
        {
            aura = caster->GetAura(SPELL_PYGMY_OIL_SMALLER_AURA);
            if (!aura || aura->GetStackAmount() < 5 || !roll_chance_i(50))
                caster->CastSpell(caster, SPELL_PYGMY_OIL_SMALLER_AURA, true);
            else
            {
                aura->Remove();
                caster->CastSpell(caster, SPELL_PYGMY_OIL_PYGMY_AURA, true);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_pygmy_oil::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_item_unusual_compass : public SpellScript
{
    PrepareSpellScript(spell_item_unusual_compass);

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Unit* caster = GetCaster();
        caster->SetFacingTo(frand(0.0f, 2.0f * M_PI));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_unusual_compass::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum ChickenCover
{
    SPELL_CHICKEN_NET               = 51959,
    SPELL_CAPTURE_CHICKEN_ESCAPE    = 51037,
    QUEST_CHICKEN_PARTY             = 12702,
    QUEST_FLOWN_THE_COOP            = 12532,
};

class spell_item_chicken_cover : public SpellScript
{
    PrepareSpellScript(spell_item_chicken_cover);

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_CHICKEN_NET, SPELL_CAPTURE_CHICKEN_ESCAPE });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Player* caster = GetCaster()->ToPlayer();

        if (Unit* target = GetHitUnit())
        {
            caster->CastSpell(caster, SPELL_CAPTURE_CHICKEN_ESCAPE, true);
            Unit::Kill(target, target);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_chicken_cover::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum Refocus
{
    SPELL_CATEGORY_AIMED_MULTI = 85
};

class spell_item_refocus : public SpellScript
{
    PrepareSpellScript(spell_item_refocus);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Player* caster = GetCaster()->ToPlayer();

        if (!caster || !caster->IsClass(CLASS_HUNTER, CLASS_CONTEXT_ABILITY))
            return;

        caster->RemoveCategoryCooldown(SPELL_CATEGORY_AIMED_MULTI);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_refocus::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_item_muisek_vessel : public SpellScript
{
    PrepareSpellScript(spell_item_muisek_vessel);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Creature* target = GetHitCreature())
            if (target->isDead())
                target->DespawnOrUnsummon();
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_muisek_vessel::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum GreatmothersSoulcather
{
    SPELL_FORCE_CAST_SUMMON_GNOME_SOUL = 46486,
};

class spell_item_greatmothers_soulcatcher : public SpellScript
{
    PrepareSpellScript(spell_item_greatmothers_soulcatcher);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (GetHitUnit())
            GetCaster()->CastSpell(GetCaster(), SPELL_FORCE_CAST_SUMMON_GNOME_SOUL);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_greatmothers_soulcatcher::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum Eggnog
{
    SPELL_EGG_NOG_REINDEER = 21936,
    SPELL_EGG_NOG_SNOWMAN  = 21980,
};

class spell_item_eggnog : public SpellScript
{
    PrepareSpellScript(spell_item_eggnog);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_EGG_NOG_REINDEER, SPELL_EGG_NOG_SNOWMAN });
    }

    void HandleScript(SpellEffIndex /* effIndex */)
    {
        if (roll_chance_i(40))
            GetCaster()->CastSpell(GetHitUnit(), roll_chance_i(50) ? SPELL_EGG_NOG_REINDEER : SPELL_EGG_NOG_SNOWMAN, GetCastItem());
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_eggnog::HandleScript, EFFECT_2, SPELL_EFFECT_INEBRIATE);
    }
};

enum GoblinBomb
{
    SPELL_SUMMON_GOBLIN_BOMB     = 13258,
    SPELL_MALFUNCTION_EXPLOSION  = 13261
};

// 23134 - Goblin Bomb
class spell_item_goblin_bomb : public SpellScript
{
    PrepareSpellScript(spell_item_goblin_bomb);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_GOBLIN_BOMB, SPELL_MALFUNCTION_EXPLOSION });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            caster->CastSpell(caster, roll_chance_i(95) ? SPELL_SUMMON_GOBLIN_BOMB : SPELL_MALFUNCTION_EXPLOSION, true, GetCastItem());
        }
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_item_goblin_bomb::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum LinkenBoomerang
{
    SPELL_DISARM  = 15752,
    SPELL_STUN    = 15753,
    CHANCE_TO_HIT = 3
};

class spell_item_linken_boomerang : public SpellScript
{
    PrepareSpellScript(spell_item_linken_boomerang)

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({SPELL_DISARM, SPELL_STUN});
    }

    void OnEffectHitTargetDisarm(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
    }

    void OnEffectHitTargetStun(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
    }

    void OnEffectLaunchTargetDisarm(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (roll_chance_i(CHANCE_TO_HIT)) // 3% from wiki
        {
            GetCaster()->CastSpell(GetHitUnit(), SPELL_DISARM, true);
        }
    }

    void OnEffectLaunchTargetStun(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (roll_chance_i(CHANCE_TO_HIT)) // 3% from wiki
        {
            GetCaster()->CastSpell(GetHitUnit(), SPELL_STUN, true);
        }
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_item_linken_boomerang::OnEffectLaunchTargetDisarm, EFFECT_1, SPELL_EFFECT_TRIGGER_SPELL);
        OnEffectLaunchTarget += SpellEffectFn(spell_item_linken_boomerang::OnEffectLaunchTargetStun, EFFECT_2, SPELL_EFFECT_TRIGGER_SPELL);

        OnEffectHitTarget += SpellEffectFn(spell_item_linken_boomerang::OnEffectHitTargetDisarm, EFFECT_1, SPELL_EFFECT_TRIGGER_SPELL);
        OnEffectHitTarget += SpellEffectFn(spell_item_linken_boomerang::OnEffectHitTargetStun, EFFECT_2, SPELL_EFFECT_TRIGGER_SPELL);
    }
};

enum RecallSpellIds
{
    SPELL_RECALL_HORDE = 22563,
    SPELL_RECALL_ALLIANCE = 22564
};

class spell_item_recall : public SpellScript
{
    PrepareSpellScript(spell_item_recall);

    void SetDest(SpellDestination& dest)
    {
        Player* player = GetCaster()->ToPlayer();
        if (!player)
        {
            return;
        }

        TeamId bgTeam = player->GetBgTeamId();
        if (player->GetTeamId(true) != bgTeam)
        {
            if (SpellTargetPosition const* recallSpellTarget = sSpellMgr->GetSpellTargetPosition(bgTeam == TEAM_HORDE ? SPELL_RECALL_HORDE : SPELL_RECALL_ALLIANCE, EFFECT_0))
            {
                Position pos = Position(recallSpellTarget->target_X, recallSpellTarget->target_Y, recallSpellTarget->target_Z, recallSpellTarget->target_Orientation);
                dest.Relocate(pos);
            }
        }
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_item_recall::SetDest, EFFECT_0, TARGET_DEST_DB);
    }
};

// 16414 - Drain Life
class spell_item_wraith_scythe_drain_life : public SpellScript
{
    PrepareSpellScript(spell_item_wraith_scythe_drain_life);

    void CalculateDamage()
    {
        Unit* target = GetHitUnit();
        Unit* caster = GetCaster();
        if (target && caster)
        {
            uint32 sp = caster->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_ALL);
            SetHitDamage(GetHitDamage() + sp);
        }
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_item_wraith_scythe_drain_life::CalculateDamage);
    }
};

enum MirrensDrinkingHat
{
    SPELL_LOCH_MODAN_LAGER      = 29827,
    SPELL_STOUTHAMMER_LITE      = 29828,
    SPELL_AERIE_PEAK_PALE_ALE   = 29829
};

// 29830 - Mirren's Drinking Hat
class spell_item_mirrens_drinking_hat : public SpellScript
{
    PrepareSpellScript(spell_item_mirrens_drinking_hat);

    void HandleScriptEffect(SpellEffIndex /* effIndex */)
    {
        uint32 spellId = 0;
        switch (urand(1, 6))
        {
            case 1:
            case 2:
            case 3:
                spellId = SPELL_LOCH_MODAN_LAGER; break;
            case 4:
            case 5:
                spellId = SPELL_STOUTHAMMER_LITE; break;
            case 6:
                spellId = SPELL_AERIE_PEAK_PALE_ALE; break;
        }

        Unit* caster = GetCaster();
        caster->CastSpell(caster, spellId);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_mirrens_drinking_hat::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_item_snowman : public SpellScript
{
    PrepareSpellScript(spell_item_snowman);

    SpellCastResult CheckCast()
    {
        if (Player* caster = GetCaster()->ToPlayer())
        {
            if (Battleground* bg = caster->GetBattleground())
            {
                if (bg->GetStatus() == STATUS_WAIT_JOIN)
                {
                    return SPELL_FAILED_NOT_READY;
                }
            }
        }

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_item_snowman::CheckCast);
    }
};

// https://www.wowhead.com/wotlk/spell=16028 Freeze Rookery Egg - Prototype
// https://www.wowhead.com/wotlk/spell=15748 Freeze Rookery Egg
class spell_item_freeze_rookery_egg : public SpellScript
{
    PrepareSpellScript(spell_item_freeze_rookery_egg);

    void HandleOpenObject(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (GameObject* rookery = GetHitGObj())
        {
            if (rookery->getLootState() == GO_READY)
                rookery->UseDoorOrButton(0, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_freeze_rookery_egg::HandleOpenObject, EFFECT_0, SPELL_EFFECT_OPEN_LOCK);
    }
};

// 9160 - Sleep
class spell_item_green_whelp_armor : public AuraScript
{
    PrepareAuraScript(spell_item_green_whelp_armor);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (eventInfo.GetActor() && eventInfo.GetActor()->GetLevel() <= 50)
            return true;

        return false;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_item_green_whelp_armor::CheckProc);
    }
};

// 37678 - elixir of shadows
/// @todo Temporary fix until pet restrictions vs player restrictions are investigated
class spell_item_elixir_of_shadows : public SpellScript
{
    PrepareSpellScript(spell_item_elixir_of_shadows);

    void HandleEffect(SpellEffIndex /*effIndex*/)
    {
        if (Player* player = GetCaster()->ToPlayer())
            if (Pet* pet = player->GetPet())
                pet->AddAura(37678 /*Elixir of Shadows*/, pet);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_elixir_of_shadows::HandleEffect, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
        OnEffectHitTarget += SpellEffectFn(spell_item_elixir_of_shadows::HandleEffect, EFFECT_1, SPELL_EFFECT_APPLY_AURA);
    }
};

enum TrollDice
{
    TEXT_WORN_TROLL_DICE = 26152
};

// 47776 - Roll 'dem Bones
class spell_item_worn_troll_dice : public SpellScript
{
    PrepareSpellScript(spell_item_worn_troll_dice);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        if (!sObjectMgr->GetBroadcastText(TEXT_WORN_TROLL_DICE))
            return false;
        return true;
    }

    bool Load() override
    {
        return GetCaster()->IsPlayer();
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->TextEmote(TEXT_WORN_TROLL_DICE, GetHitUnit());

        static uint32 const minimum = 1;
        static uint32 const maximum = 6;

        // roll twice
        GetCaster()->ToPlayer()->DoRandomRoll(minimum, maximum);
        GetCaster()->ToPlayer()->DoRandomRoll(minimum, maximum);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_worn_troll_dice::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum VenomhideHatchling
{
    NPC_VENOMHIDE_HATCHLING = 34320
};

class spell_item_venomhide_feed : public SpellScript
{
    PrepareSpellScript(spell_item_venomhide_feed)

    SpellCastResult CheckCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            std::list<Creature*> hatchling;
            player->GetAllMinionsByEntry(hatchling, NPC_VENOMHIDE_HATCHLING);
            if (!hatchling.empty())
            {
                return SPELL_CAST_OK;
            }
        }

        return SPELL_FAILED_BAD_TARGETS;
    }

    void UpdateTarget(WorldObject*& target)
    {
        if (!target)
        {
            return;
        }

        if (Player* player = GetCaster()->ToPlayer())
        {
            std::list<Creature*> hatchling;
            player->GetAllMinionsByEntry(hatchling, NPC_VENOMHIDE_HATCHLING);
            if (hatchling.empty())
            {
                return;
            }

            for (Creature* creature : hatchling)
            {
                if (creature)
                {
                    target = creature;
                    return;
                }
            }
        }
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_item_venomhide_feed::CheckCast);
        OnObjectTargetSelect  += SpellObjectTargetSelectFn(spell_item_venomhide_feed::UpdateTarget, EFFECT_0, TARGET_UNIT_NEARBY_ENTRY);
    }
};

// 30077 - Carinda's Scroll of Retribution
enum ScrollOfRetribution
{
    NPC_VIERA_SUNWHISPER    = 17226
};

class spell_item_scroll_of_retribution : public SpellScript
{
    PrepareSpellScript(spell_item_scroll_of_retribution)

    SpellCastResult CheckCast()
    {
        if (Unit* target = GetExplTargetUnit())
            if (target->GetEntry() == NPC_VIERA_SUNWHISPER)
                return SPELL_CAST_OK;

        return SPELL_FAILED_BAD_TARGETS;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_item_scroll_of_retribution::CheckCast);
    }
};

// 38554 - Absorb Eye of Grillok (Zezzak's Shard)
enum EyeofGrillok
{
    SPELL_EYE_OF_GRILLOK = 38495,
    NPC_EYE_OF_GRILLOK   = 19440
};

class spell_item_eye_of_grillok : public SpellScript
{
    PrepareSpellScript(spell_item_eye_of_grillok)

    SpellCastResult CheckCast()
    {
        if (Unit* target = GetExplTargetUnit())
            if (target->GetEntry() == NPC_EYE_OF_GRILLOK && !target->isDead())
                return SPELL_CAST_OK;

        return SPELL_FAILED_BAD_TARGETS;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_item_eye_of_grillok::CheckCast);
    }
};

class spell_item_eye_of_grillok_aura : public AuraScript
{
    PrepareAuraScript(spell_item_eye_of_grillok_aura)

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_EYE_OF_GRILLOK });
    }

    void OnPeriodic(AuraEffect const* /*aurEff*/)
    {
        Unit* caster = GetCaster();
        if (!caster || !GetTarget())
            return;

        caster->CastSpell(caster, SPELL_EYE_OF_GRILLOK, true);

        GetTarget()->ToCreature()->DespawnOrUnsummon();
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_eye_of_grillok_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

enum FelManaPotion
{
    SPELL_ALCHEMIST_STONE          = 17619,
    SPELL_ALCHEMIST_STONE_ENERGIZE = 21400
};

class spell_item_fel_mana_potion : public AuraScript
{
    PrepareAuraScript(spell_item_fel_mana_potion)

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ALCHEMIST_STONE, SPELL_ALCHEMIST_STONE_ENERGIZE });
    }

    void OnPeriodic(AuraEffect const* /*aurEff*/)
    {
        if (Unit* caster = GetCaster())
            if (caster->HasAura(SPELL_ALCHEMIST_STONE))
            {
                uint32 val = GetSpellInfo()->Effects[EFFECT_0].BasePoints * 0.4f;
                caster->CastCustomSpell(SPELL_ALCHEMIST_STONE_ENERGIZE, SPELLVALUE_BASE_POINT0, val, caster, true);
            }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_fel_mana_potion::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_ENERGIZE);
    }
};

// 32578 - Gor'drek's Ointment
enum DreksOintment
{
    NPC_THUNDERLORD_DIRE_WOLF = 20748,
    SPELL_GOR_DREKS_OINTMENT  = 32578
};

class spell_item_gor_dreks_ointment : public SpellScript
{
    PrepareSpellScript(spell_item_gor_dreks_ointment)

    SpellCastResult CheckCast()
    {
        if (Unit* target = GetExplTargetUnit())
        {
            if (target->GetEntry() == NPC_THUNDERLORD_DIRE_WOLF && !target->HasAura(SPELL_GOR_DREKS_OINTMENT))
                return SPELL_CAST_OK;
            if (target->GetEntry() != NPC_THUNDERLORD_DIRE_WOLF)
                return SPELL_FAILED_BAD_TARGETS;
        }

        return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_item_gor_dreks_ointment::CheckCast);
    }
};

enum Skettis
{
    QUEST_FIRES_OVER_SKETTIS = 11008
};

class spell_item_skyguard_blasting_charges : public SpellScript
{
    PrepareSpellScript(spell_item_skyguard_blasting_charges);

    void HandleOpenObject(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (GameObject* go = GetHitGObj())
            go->UseDoorOrButton();
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* kaliri = GetHitUnit())
            kaliri->ToCreature()->DespawnOrUnsummon(0s, 30s);
    }

    SpellCastResult CheckQuest()
    {
        if (Player* playerCaster = GetCaster()->ToPlayer())
        {
            if (playerCaster->GetQuestStatus(QUEST_FIRES_OVER_SKETTIS) == QUEST_STATUS_INCOMPLETE)
                return SPELL_CAST_OK;
        }
        return SPELL_FAILED_DONT_REPORT;
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_skyguard_blasting_charges::HandleOpenObject, EFFECT_1, SPELL_EFFECT_ACTIVATE_OBJECT);
        OnEffectHitTarget += SpellEffectFn(spell_item_skyguard_blasting_charges::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        OnCheckCast += SpellCheckCastFn(spell_item_skyguard_blasting_charges::CheckQuest);
    }
};

void AddSC_item_spell_scripts()
{
    RegisterSpellScript(spell_item_massive_seaforium_charge);
    RegisterSpellScript(spell_item_titanium_seal_of_dalaran);
    RegisterSpellScript(spell_item_mind_amplify_dish);
    RegisterSpellScript(spell_item_runescroll_of_fortitude);
    RegisterSpellScript(spell_item_branns_communicator);
    RegisterSpellScript(spell_item_goblin_gumbo_kettle);
    RegisterSpellScript(spell_item_with_mount_speed);
    RegisterSpellScript(spell_item_magic_dust);
    RegisterSpellScript(spell_item_toy_train_set);
    RegisterSpellScript(spell_item_rocket_chicken);
    RegisterSpellScript(spell_item_sleepy_willy);
    RegisterSpellScript(spell_item_lil_phylactery);
    RegisterSpellScript(spell_item_shifting_naaru_silver);
    RegisterSpellScript(spell_item_toxic_wasteling);
    RegisterSpellScript(spell_item_lil_xt);
    RegisterSpellScript(spell_item_essence_of_life);
    RegisterSpellScript(spell_item_crazy_alchemists_potion);
    RegisterSpellScript(spell_item_skull_of_impeding_doom);
    RegisterSpellScript(spell_item_feast);
    RegisterSpellScript(spell_item_gnomish_universal_remote);
    RegisterSpellScript(spell_item_powerful_anti_venom);
    RegisterSpellScript(spell_item_strong_anti_venom);
    RegisterSpellScript(spell_item_anti_venom);
    RegisterSpellScript(spell_item_gnomish_shrink_ray);
    RegisterSpellScript(spell_item_goblin_weather_machine);
    RegisterSpellScript(spell_item_goblin_weather_machine_aura);
    RegisterSpellScript(spell_item_light_lamp);
    RegisterSpellScript(spell_item_fetch_ball);
    RegisterSpellScript(spell_item_oracle_ablutions);
    RegisterSpellScript(spell_item_trauma);
    RegisterSpellScript(spell_item_blade_ward_enchant);
    RegisterSpellScript(spell_item_blood_draining_enchant);
    RegisterSpellScript(spell_item_dragon_kite_summon_lightning_bunny);
    RegisterSpellScript(spell_item_enchanted_broom_periodic);
    RegisterSpellScript(spell_item_summon_or_dismiss);
    RegisterSpellScript(spell_item_draenic_pale_ale);
    RegisterSpellAndAuraScriptPair(spell_item_direbrew_remote, spell_item_direbrew_remote_aura);
    RegisterSpellScript(spell_item_eye_of_gruul_healing_discount);
    RegisterSpellScript(spell_item_summon_argent_knight);
    RegisterSpellScript(spell_item_instant_statue);
    // 23074 Arcanite Dragonling
    RegisterSpellScriptWithArgs(spell_item_trigger_spell, "spell_item_arcanite_dragonling", SPELL_ARCANITE_DRAGONLING);
    // 23133 Gnomish Battle Chicken
    RegisterSpellScriptWithArgs(spell_item_trigger_spell, "spell_item_gnomish_battle_chicken", SPELL_BATTLE_CHICKEN);
    // 23076 Mechanical Dragonling
    RegisterSpellScriptWithArgs(spell_item_trigger_spell, "spell_item_mechanical_dragonling", SPELL_MECHANICAL_DRAGONLING);
    // 23075 Mithril Mechanical Dragonling
    RegisterSpellScriptWithArgs(spell_item_trigger_spell, "spell_item_mithril_mechanical_dragonling", SPELL_MITHRIL_MECHANICAL_DRAGONLING);
    RegisterSpellScript(spell_item_aegis_of_preservation);
    RegisterSpellScript(spell_item_arcane_shroud);
    RegisterSpellScript(spell_item_brittle_armor);
    RegisterSpellScript(spell_item_blessing_of_ancient_kings);
    RegisterSpellScript(spell_item_valanyr_hammer_of_ancient_kings);
    RegisterSpellScriptWithArgs(spell_item_defibrillate, "spell_item_goblin_jumper_cables", 67, SPELL_GOBLIN_JUMPER_CABLES_FAIL);
    RegisterSpellScriptWithArgs(spell_item_defibrillate, "spell_item_goblin_jumper_cables_xl", 50, SPELL_GOBLIN_JUMPER_CABLES_XL_FAIL);
    RegisterSpellScriptWithArgs(spell_item_defibrillate, "spell_item_gnomish_army_knife", 33);
    RegisterSpellScript(spell_item_desperate_defense);
    RegisterSpellScript(spell_item_deviate_fish);
    RegisterSpellScript(spell_item_party_time);
    RegisterSpellScript(spell_item_echoes_of_light);
    RegisterSpellScript(spell_item_fate_rune_of_unsurpassed_vigor);
    RegisterSpellScript(spell_item_flask_of_the_north);
    RegisterSpellScript(spell_item_gnomish_death_ray);
    RegisterSpellScript(spell_item_make_a_wish);
    RegisterSpellScript(spell_item_mercurial_shield);
    RegisterSpellScript(spell_item_mingos_fortune_generator);
    RegisterSpellScript(spell_item_necrotic_touch);
    RegisterSpellScript(spell_item_net_o_matic);
    RegisterSpellScript(spell_item_noggenfogger_elixir);
    RegisterSpellScript(spell_item_piccolo_of_the_flaming_fire);
    RegisterSpellScript(spell_item_savory_deviate_delight);
    RegisterSpellScript(spell_item_scroll_of_recall);
    RegisterSpellScript(spell_item_dimensional_ripper_area52);
    RegisterSpellScript(spell_item_unsated_craving);
    RegisterSpellScript(spell_item_shadows_fate);
    RegisterSpellScript(spell_item_shadowmourne);
    RegisterSpellScript(spell_item_shadowmourne_soul_fragment);
    RegisterSpellScript(spell_item_six_demon_bag);
    RegisterSpellScript(spell_item_the_eye_of_diminution);
    RegisterSpellScript(spell_item_underbelly_elixir);
    RegisterSpellScript(spell_item_book_of_glyph_mastery);
    RegisterSpellScript(spell_item_map_of_the_geyser_fields);
    RegisterSpellScript(spell_item_vanquished_clutches);
    RegisterSpellScript(spell_item_ashbringer);
    RegisterSpellScript(spell_magic_eater_food);
    RegisterSpellScript(spell_item_refocus);
    RegisterSpellScript(spell_item_shimmering_vessel);
    RegisterSpellScript(spell_item_purify_helboar_meat);
    RegisterSpellScript(spell_item_reindeer_transformation);
    RegisterSpellScript(spell_item_nigh_invulnerability);
    RegisterSpellScript(spell_item_poultryizer);
    RegisterSpellScript(spell_item_socrethars_stone);
    RegisterSpellScript(spell_item_demon_broiled_surprise);
    RegisterSpellScript(spell_item_complete_raptor_capture);
    RegisterSpellScript(spell_item_impale_leviroth);
    RegisterSpellScript(spell_item_brewfest_mount_transformation);
    RegisterSpellScript(spell_item_nitro_boots);
    RegisterSpellScript(spell_item_teach_language);
    RegisterSpellScript(spell_item_rocket_boots);
    RegisterSpellScript(spell_item_healing_injector);
    RegisterSpellScript(spell_item_mana_injector);
    RegisterSpellScript(spell_item_pygmy_oil);
    RegisterSpellScript(spell_item_unusual_compass);
    RegisterSpellScript(spell_item_chicken_cover);
    RegisterSpellScript(spell_item_muisek_vessel);
    RegisterSpellScript(spell_item_greatmothers_soulcatcher);
    RegisterSpellScript(spell_item_eggnog);
    RegisterSpellScript(spell_item_goblin_bomb);
    RegisterSpellScript(spell_item_linken_boomerang);
    RegisterSpellScript(spell_item_recall);
    RegisterSpellScript(spell_item_wraith_scythe_drain_life);
    RegisterSpellScript(spell_item_mirrens_drinking_hat);
    RegisterSpellScript(spell_item_snowman);
    RegisterSpellScript(spell_item_freeze_rookery_egg);
    RegisterSpellScript(spell_item_green_whelp_armor);
    RegisterSpellScript(spell_item_elixir_of_shadows);
    RegisterSpellScript(spell_item_worn_troll_dice);
    RegisterSpellScript(spell_item_venomhide_feed);
    RegisterSpellScript(spell_item_scroll_of_retribution);
    RegisterSpellAndAuraScriptPair(spell_item_eye_of_grillok, spell_item_eye_of_grillok_aura);
    RegisterSpellScript(spell_item_fel_mana_potion);
    RegisterSpellScript(spell_item_gor_dreks_ointment);
    RegisterSpellScript(spell_item_skyguard_blasting_charges);
}
