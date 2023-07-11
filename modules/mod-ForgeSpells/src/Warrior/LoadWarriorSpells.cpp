#include "LoadForgeSpells.cpp"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "MapMgr.h"

enum WarriorSpells
{
    SPELL_WARRIOR_SHIELD_SLAM                   = 23922,
    SPELL_WARRIOR_SWORD_AND_BOARD               = 46951,
    SPELL_WARRIOR_CRITICAL_BLOCK                = 47294,
    SPELL_WARRIOR_SWORD_AND_BOARD_AURA          = 50227,
    SPELL_WARRIOR_JUGGERNAUT_CRIT_BONUS_BUFF    = 65156,
    SPELL_WARRIOR_JUGGERNAUT_CRIT_BONUS_TALENT  = 64976,
    SPELL_WARRIOR_HEAVY_SHIELD_SLAM             = 1120000,
    SPELL_WARRIOR_HEAVY_RESILIANT_SHIELD        = 1120001,
    SPELL_WARRIOR_WIDE_SWING                    = 1120007,
    SPELL_WARRIOR_DEFLECTION_STANCE             = 1120008,
    SPELL_WARRIOR_STRONG_ARM                    = 1120014,
    SPELL_WARRIOR_GLAD_SHIELD_SLAM              = 1120018,
    SPELL_WARRIOR_INCREASED_AGGRESSION          = 1120019,
    SPELL_WARRIOR_SWORD_AND_BOARD_4             = 1120022,
    SPELL_WARRIOR_WIDE_SWING_AURA               = 1120023,
    SPELL_WARRIOR_FOLLOW_THROUGH                = 1120031,
    SPELL_WARRIOR_GLAD_STANCE                   = 1120037,
    SPELL_WARRIOR_GLAD_SHIELD_SLAM_2            = 1120038,
    SPELL_WARRIOR_BLEEDING                      = 1120044,
    SPELL_WARRIOR_DEVASTATING_REPOSTE           = 1120045,
    SPELL_WARRIOR_DEVASTATING_REPOSTE_AURA      = 1120046,
    SPELL_WARRIOR_DEVASTATING_CRITICAL          = 1120049,
    SPELL_WARRIOR_DEVASTATE_CRITICAL            = 1120054,
    SPELL_WARRIOR_DEVASTATING_ADVANTAGE         = 1120064,
    SPELL_WARRIOR_DEVASTATE_CHARGE              = 1120069,
    SPELL_WARRIOR_GLAD_DEVASTATE                = 1120070,
    SPELL_WARRIOR_PRESS_THE_ADVANTAGE           = 1120071,
    SPELL_WARRIOR_GLAD_EXPERIENCE               = 1120077,
    SPELL_WARRIOR_GLAD_PRESSURE                 = 1120079,
    SPELL_WARRIOR_HOLD_THE_ADVANTAGE            = 1120080,
    SPELL_WARRIOR_GLAD_FOCUS                    = 1120081,
    SPELL_WARRIOR_GLAD_SECOND_WIND              = 1120084,
    SPELL_WARRIOR_SHIELD_STRIKES                = 1120118,
    SPELL_WARRIOR_GLAD_FLASH_STRIKES            = 1120120,
    SPELL_WARRIOR_FLURRY_OF_STEEL               = 1120124,
    SPELL_WARRIOR_TRAUMATIZING_STRIKES          = 1120126,
    SPELL_WARRIOR_STRIKING_RAGE                 = 1120132,
    SPELL_WARRIOR_STRIKING_FURY                 = 1120134,
    SPELL_WARRIOR_FLASH_ATTACKS                 = 1120136,
    SPELL_WARRIOR_DEEPER_TRAUMA                 = 1120137,
    SPELL_WARRIOR_ANGRY                         = 1120156,
    SPELL_WARRIOR_FURIOUS                       = 1120157,
};

class spell_warr_heavy_shield_slam : public SpellScript
{
    PrepareSpellScript(spell_warr_heavy_shield_slam);

    void HandleAfterHit()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            if (auto resil = player->GetLatestSpellEffect(SPELL_WARRIOR_HEAVY_SHIELD_SLAM, SPELL_WARRIOR_HEAVY_RESILIANT_SHIELD))
                player->AddAura(resil->Id + 1, player);
            if (auto deflect = player->GetLatestSpellEffect(SPELL_WARRIOR_HEAVY_SHIELD_SLAM, SPELL_WARRIOR_DEFLECTION_STANCE))
                player->AddAura(deflect->Id + 1, player);
            if (auto strongArm = player->GetLatestSpellEffect(SPELL_WARRIOR_HEAVY_SHIELD_SLAM, SPELL_WARRIOR_STRONG_ARM))
                player->AddAura(strongArm->Id + 1, player);


            if (auto aura = player->GetAura(SPELL_WARRIOR_WIDE_SWING_AURA))
            {
                aura->Remove();

                if (auto t1 = player->SelectNearbyNoTotemTarget())
                {
                    player->CastSpell(t1, SPELL_WARRIOR_HEAVY_SHIELD_SLAM, true);

                    if (auto t2 = player->SelectNearbyNoTotemTarget(t1))
                        player->CastSpell(t2, SPELL_WARRIOR_HEAVY_SHIELD_SLAM, true);
                }
            }
        }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_warr_heavy_shield_slam::HandleAfterHit);
    }
};

static bool SwordAndBoardProc(Player* player, SpellInfo const* spellInfo, bool forcedProc = false)
{
    SpellInfo* rank4;
    SpellInfo* aggression;
    int chance = spellInfo->GetEffect(EFFECT_1).CalcValue();

    if (rank4 = player->GetLatestSpellEffectForDummy(SPELL_WARRIOR_SWORD_AND_BOARD_4))
    {
        if (!player->HasSpellCooldown(SPELL_WARRIOR_SWORD_AND_BOARD_4))
            chance += rank4->GetEffect(EFFECT_0).CalcValue();
        else
            return false;
    }

    if (aggression = player->GetLatestSpellEffectForEnhacement(SPELL_WARRIOR_INCREASED_AGGRESSION))
        chance -= chance * (aggression->GetEffect(EFFECT_1).CalcValue() * 0.01);

    if (roll_chance_i(chance))
    {
        if (forcedProc)
        {
            player->AddAura(SPELL_WARRIOR_SWORD_AND_BOARD_AURA, player);

            if (auto slam = player->GetLatestSpellEffectForEnhacement(SPELL_WARRIOR_SHIELD_SLAM))
                player->ModifySpellCooldown(slam->Id, -60000);
        }

        if (player->HasSpell(SPELL_WARRIOR_WIDE_SWING))
            player->AddAura(SPELL_WARRIOR_WIDE_SWING_AURA, player);

        if (rank4)
            player->AddSpellCooldown(SPELL_WARRIOR_SWORD_AND_BOARD_4, 0, rank4->RecoveryTime);

        if (aggression)
            player->AddAura(aggression->GetEffect(EFFECT_1).MiscValue, player);

        return true;
    }

    return false;
}

class spell_warr_sword_and_board : public AuraScript
{
    PrepareAuraScript(spell_warr_sword_and_board);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        auto aura = GetSpellInfo();

        if (CheckFamilyFlags(eventInfo, EFFECT_0))
        {
            if (Player* player = GetCaster()->ToPlayer())
            {
                SwordAndBoardProc(player, aura, true);
            }
        }

        return false;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_sword_and_board::CheckProc);
    }
};

// custom trigger for stuborn sword and board spells
class spell_warr_trigger_sword_and_board : public SpellScript
{
    PrepareSpellScript(spell_warr_trigger_sword_and_board);

    void HandleAfterHit()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            if (auto aura = player->GetLatestSpellEffectForEnhacement(SPELL_WARRIOR_SWORD_AND_BOARD))
            {
                SwordAndBoardProc(player, aura, true);
            }
        }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_warr_trigger_sword_and_board::HandleAfterHit);
    }
};

class spell_warr_glad_shield_slam : public SpellScript
{
    PrepareSpellScript(spell_warr_glad_shield_slam);

    void HandleOnHit()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            if (auto aura = player->GetAura(SPELL_WARRIOR_SWORD_AND_BOARD_AURA))
            {
                player->ModifyPower(POWER_RAGE, 200);
                aura->Remove();
            }
            else
                player->ModifyPower(POWER_RAGE, 100);

            if (auto follow = player->GetLatestSpellEffect(SPELL_WARRIOR_GLAD_SHIELD_SLAM, SPELL_WARRIOR_FOLLOW_THROUGH))
                player->CastSpell(player, follow->GetEffect(EFFECT_1).MiscValue);
        }
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_warr_glad_shield_slam::HandleOnHit);
    }
};

class spell_warr_glad_shield_slam_2 : public AuraScript
{
    PrepareAuraScript(spell_warr_glad_shield_slam_2);

    void HandleProc(AuraEffect const* aurEff)
    {
        if (_triggerCount <= aurEff->GetMiscValue())
            if (auto caster = GetCaster())
                if (auto target = GetTarget())
                    if (caster->GetDistance(target) <= aurEff->GetSpellInfo()->GetMaxRange())
                        caster->CastSpell(target, SPELL_WARRIOR_GLAD_SHIELD_SLAM_2 + _triggerCount, true, nullptr, aurEff, caster->GetGUID());
                    else
                    {
                        aurEff->GetBase()->Remove();
                        caster->InterruptSpell(CURRENT_MELEE_SPELL, true, true, true);
                        return;
                    }

        _triggerCount++;
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_warr_glad_shield_slam_2::HandleProc, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
private:
    int _triggerCount = 1;
};

class spell_warrior_tearing_swipe : public AuraScript
{
    PrepareAuraScript(spell_warrior_tearing_swipe);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (!eventInfo.GetActor() || !eventInfo.GetProcTarget())
            return false;

        DamageInfo* damageInfo = eventInfo.GetDamageInfo();

        if (!damageInfo || !damageInfo->GetSpellInfo())
        {
            return false;
        }

        return CheckFamilyFlags(eventInfo, EFFECT_0);
    }

    void HandleProc(AuraEffect const*  /*aurEff*/, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        SpellInfo const* igniteDot = sSpellMgr->AssertSpellInfo(SPELL_WARRIOR_BLEEDING);
        int32 pct = GetSpellInfo()->GetEffect(EFFECT_0).CalcValue();

        float dmgRatio;
        int32 amount = int32(CalculatePct(eventInfo.GetDamageInfo()->GetDamage(), pct) / igniteDot->GetMaxTicks(eventInfo.GetActor(), dmgRatio));

        if (dmgRatio != 0)
            amount = amount * dmgRatio;

        // Xinef: implement ignite bug
        eventInfo.GetProcTarget()->CastDelayedSpellWithPeriodicAmount(eventInfo.GetActor(), SPELL_WARRIOR_BLEEDING, SPELL_AURA_PERIODIC_DAMAGE, amount);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warrior_tearing_swipe::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_warrior_tearing_swipe::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

class spell_warr_devastating_reposte : public AuraScript
{
    PrepareAuraScript(spell_warr_devastating_reposte);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (!eventInfo.GetActor() || !eventInfo.GetProcTarget())
            return false;

        DamageInfo* damageInfo = eventInfo.GetDamageInfo();

        if (!damageInfo)
            return false;

        _criticalBlock = damageInfo->GetCriticalBlock();

        return true;
    }

    void HandleProc(ProcEventInfo& eventInfo)
    {
        if (auto caster = GetCaster())
        {
            caster->CastSpell(caster, SPELL_WARRIOR_DEVASTATING_REPOSTE_AURA);

            if (_criticalBlock)
            {
                auto aura = caster->GetAura(SPELL_WARRIOR_DEVASTATING_REPOSTE_AURA);
                aura->GetEffect(EFFECT_0)->SetAmount(aura->GetEffect(EFFECT_0)->GetAmount() * 2);
            }
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_devastating_reposte::CheckProc);
        OnProc += AuraProcFn(spell_warr_devastating_reposte::HandleProc);
    }

private:
    bool _criticalBlock = false;
};

class spell_warr_devastating_guard : public AuraScript
{
    PrepareAuraScript(spell_warr_devastating_guard);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (!eventInfo.GetActor() || !eventInfo.GetProcTarget())
            return false;

        DamageInfo* damageInfo = eventInfo.GetDamageInfo();

        if (!damageInfo)
            return false;

        return damageInfo->GetCriticalBlock();
    }

    void HandleProc(ProcEventInfo& eventInfo)
    {
        if (auto caster = GetCaster())
            GetAura()->Remove();
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_devastating_guard::CheckProc);
        OnProc += AuraProcFn(spell_warr_devastating_guard::HandleProc);
    }
};

class spell_warr_devastating_critical : public AuraScript
{
    PrepareAuraScript(spell_warr_devastating_critical);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (auto caster = GetCaster()->ToPlayer())
        {
            return CheckFamilyFlags(eventInfo, EFFECT_0) && !caster->HasSpellCooldown(SPELL_WARRIOR_DEVASTATING_CRITICAL);
        }

        return false;
    }

    void HandleProc(ProcEventInfo& eventInfo)
    {
        if (auto player = GetCaster()->ToPlayer())
        {
            auto spellInfo = GetSpellInfo();
            player->CastSpell(player, spellInfo->GetEffect(EFFECT_2).TriggerSpell);
            player->AddSpellCooldown(SPELL_WARRIOR_DEVASTATING_CRITICAL, 0, spellInfo->GetEffect(EFFECT_1).CalcValue() * 1000);
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_devastating_critical::CheckProc);
        OnProc += AuraProcFn(spell_warr_devastating_critical::HandleProc);
    }
};

class spell_warr_devastating_critical_aura : public AuraScript
{
    PrepareAuraScript(spell_warr_devastating_critical_aura);

    void HandleProc(ProcEventInfo& eventInfo)
    {
        if (auto player = GetCaster()->ToPlayer())
        {
            GetAura()->Remove();
        }
    }

    void Register() override
    {
        OnProc += AuraProcFn(spell_warr_devastating_critical_aura::HandleProc);
    }
};

class spell_warr_attack_replacers : public SpellScript
{
    PrepareSpellScript(spell_warr_attack_replacers);

    void HandleAfterCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            player->AddCategoryCooldowns(GetSpellInfo(), player->GetAttackTime(BASE_ATTACK));

            if (auto exp = player->GetLatestSpellEffect(SPELL_WARRIOR_GLAD_DEVASTATE, SPELL_WARRIOR_GLAD_EXPERIENCE))
                player->AddAura(exp->Id + 1, player);

            if (SpellIsCrit(GetSpell()))
            {
                bool applied = false;

                if (player->HasSpell(SPELL_WARRIOR_GLAD_PRESSURE))
                    if (auto aura = player->GetAura(SPELL_WARRIOR_PRESS_THE_ADVANTAGE))
                        if (aura->GetStackAmount() == 10)
                        {
                            aura->Remove();

                            if (player->HasSpell(SPELL_WARRIOR_GLAD_FOCUS))
                                player->AddAura(SPELL_WARRIOR_GLAD_FOCUS + 1, player);
                            else
                                player->AddAura(SPELL_WARRIOR_HOLD_THE_ADVANTAGE, player);

                            applied = true;
                        }

                if (!applied)
                    if (auto auraSW = player->GetAura(SPELL_WARRIOR_GLAD_SECOND_WIND))
                    {
                        auto aura = player->GetAura(SPELL_WARRIOR_HOLD_THE_ADVANTAGE);

                        if (!aura)
                            aura = player->GetAura(SPELL_WARRIOR_GLAD_FOCUS + 1);

                        if (aura)
                            aura->AddDuration(auraSW->GetEffect(EFFECT_0)->GetAmount() * 1000);
                    }
            }

            if (!GetSpell()->IsTriggered())
                if (auto aura = player->GetAura(SPELL_WARRIOR_FLASH_ATTACKS))
                    if (auto victim = player->GetTargetUnit())
                        if (victim->IsAlive())
                            if (player->GetAura(SPELL_WARRIOR_FLURRY_OF_STEEL))
                                player->CastSpell(victim, GetSpellInfo(), true, nullptr, aura->GetEffect(EFFECT_0));
        }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_warr_attack_replacers::HandleAfterCast);
    }
};

class spell_warr_devastating_resiliance : public AuraScript
{
    PrepareAuraScript(spell_warr_devastating_resiliance);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (auto player = GetCaster())
        {
            if (player->GetAura(GetSpellInfo()->GetEffect(EFFECT_2).TriggerSpell))
                return false;
        }

        return CheckFamilyFlags(eventInfo, EFFECT_0);
    }

    void HandleProc(ProcEventInfo& eventInfo)
    {
        if (auto player = GetCaster()->ToPlayer())
        {
            auto spellInfo = GetSpellInfo();
            auto immovableObject = spellInfo->GetEffect(EFFECT_1).TriggerSpell;

            player->CastSpell(player, immovableObject);
            auto immovableObjectAura = player->GetAura(immovableObject);

            if (immovableObjectAura->GetStackAmount() >= 3)
            {
                immovableObjectAura->Remove();
                player->CastSpell(player, spellInfo->GetEffect(EFFECT_2).TriggerSpell);
            }
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_devastating_resiliance::CheckProc);
        OnProc += AuraProcFn(spell_warr_devastating_resiliance::HandleProc);
    }
};

class spell_warr_proc_family_flags_0 : public AuraScript
{
    PrepareAuraScript(spell_warr_proc_family_flags_0);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return CheckFamilyFlags(eventInfo, EFFECT_0);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_proc_family_flags_0::CheckProc);
    }
};

class spell_warr_devastate : public SpellScript
{
    PrepareSpellScript(spell_warr_devastate);

    void HandleBeforeCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            player->AddAura(SPELL_WARRIOR_DEVASTATE_CRITICAL, player);
        }
    }

    void Register() override
    {
        BeforeCast += SpellCastFn(spell_warr_devastate::HandleBeforeCast);
    }
};

class spell_warr_glad_devastate : public SpellScript
{
    PrepareSpellScript(spell_warr_glad_devastate);

    void HandleAfterHit()
    {
        if (firstCast)
        {
            firstCast = false;

            if (Player* player = GetCaster()->ToPlayer())
            {
                if (auto victim = GetHitUnit())
                    if (SpellIsCrit(GetSpell(), victim->GetGUID()))
                        player->ModifyPower(POWER_RAGE, 100);
                    else
                        player->ModifyPower(POWER_RAGE, 50);

                if (auto aura = player->GetAura(SPELL_WARRIOR_PRESS_THE_ADVANTAGE))
                {
                    auto pressure = player->GetLatestSpellEffect(SPELL_WARRIOR_GLAD_DEVASTATE, SPELL_WARRIOR_GLAD_PRESSURE);
                    int maxStacks = pressure ? pressure->GetEffect(EFFECT_0).CalcValue() : 5;

                    if (aura->GetStackAmount() < maxStacks)
                        aura->SetStackAmount(aura->GetStackAmount() + 1);

                    aura->RefreshDuration();
                }
                else
                    player->CastSpell(player, SPELL_WARRIOR_PRESS_THE_ADVANTAGE);

                if (auto gladExp = player->GetLatestSpellEffect(SPELL_WARRIOR_GLAD_DEVASTATE, SPELL_WARRIOR_GLAD_EXPERIENCE))
                    if (auto aura = player->GetAura(gladExp->Id + 1))
                        aura->Remove();
            }
        }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_warr_glad_devastate::HandleAfterHit);
    }
private:
    bool firstCast = true;
};

class spell_warr_glad_focus : public AuraScript
{
    PrepareAuraScript(spell_warr_glad_focus);

    void HandleAuraApply()
    {
        if (auto player = GetCaster()->ToPlayer())
        {
            GetAura()->GetEffect(EFFECT_2)->SetStoredValue(0, player->GetTarget().GetRawValue());
        }
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (eventInfo.GetActionTarget()->IsAlive())
        {
            auto storeEffect = GetAura()->GetEffect(EFFECT_2);
            auto stored = storeEffect->GetStoredValue(0);

            if (stored != 0)
                return eventInfo.GetActionTarget()->GetGUID().GetRawValue() != stored;
            else
                storeEffect->SetStoredValue(0, eventInfo.GetActionTarget()->GetGUID().GetRawValue());
        }
        else
            GetAura()->GetEffect(EFFECT_2)->SetStoredValue(0, 0);

        return false;
    }

    void HandleProc(ProcEventInfo& eventInfo)
    {
        if (auto player = GetCaster()->ToPlayer())
        {
            player->AddAura(SPELL_WARRIOR_GLAD_FOCUS + 2, player);
            GetAura()->Remove();
        }
    }

    void Register() override
    {
        OnAuraApply += AuraApplyFn(spell_warr_glad_focus::HandleAuraApply);
        DoCheckProc += AuraCheckProcFn(spell_warr_glad_focus::CheckProc);
        OnProc += AuraProcFn(spell_warr_glad_focus::HandleProc);
    }
};

class spell_warr_fort_shield_block : public SpellScript
{
    PrepareSpellScript(spell_warr_fort_shield_block);

    SpellCastResult CheckCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            auto spellInfo = GetSpellInfo();
            auto id = spellInfo->Id;

            if (auto aura = player->GetAura(id))
            {
                aura->Remove();
                return SPELL_FAILED_DONT_REPORT;
            }
        }

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_warr_fort_shield_block::CheckCast);
    }
};

class spell_warr_fort_shield_block_aura : public AuraScript
{
    PrepareAuraScript(spell_warr_fort_shield_block_aura);

    void HandleOnApply()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            auto id = GetSpellInfo()->Id;
            auto auras = player->GetAurasByMiscA(id);

            for (auto aura : auras)
            {
                if (aura->GetEffect(EFFECT_0)->GetMiscValueB() == 1 && !player->GetLatestSpellEffectForDummy(SPELL_WARRIOR_CRITICAL_BLOCK))
                    continue;

                player->AddAura(aura->GetId() + 1, player);
            }
        }
    }

    void HandleOnRemove()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            auto spellInfo = GetSpellInfo();
            auto id = spellInfo->Id;
            auto auras = player->GetAurasByMiscB(id);

            for (auto aur : auras)
                aur->Remove();

            player->AddSpellCooldown(id, 0, spellInfo->GetEffect(EFFECT_2).MiscValue, true);
        }
    }

    void Register() override
    {
        OnAuraApply += AuraApplyFn(spell_warr_fort_shield_block_aura::HandleOnApply);
        OnAuraRemove += AuraRemoveFn(spell_warr_fort_shield_block_aura::HandleOnRemove);
    }
};

class spell_warr_shield_strikes : public SpellScript
{
    PrepareSpellScript(spell_warr_shield_strikes);

    SpellCastResult CheckCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            auto spellInfo = GetSpellInfo();
            auto id = spellInfo->Id;

            if (auto aura = player->GetAura(id))
            {
                aura->Remove();

                if (player->GetPower(POWER_RAGE) == 1000 && !player->HasSpellCooldown(SPELL_WARRIOR_SHIELD_SLAM))
                    if (auto victim = player->GetTargetUnit())
                        if (victim->IsAlive())
                        {
                            auto triggered = false;

                            if (player->HasSpell(SPELL_WARRIOR_STRIKING_RAGE))
                            {
                                player->CastSpell(victim, SPELL_WARRIOR_STRIKING_RAGE + 1);
                                triggered = true;
                            }
                            if (player->HasSpell(SPELL_WARRIOR_STRIKING_FURY))
                            {
                                player->CastSpell(victim, SPELL_WARRIOR_STRIKING_FURY + 1);
                                triggered = true;
                            }

                            if (triggered)
                            {
                                player->SetPower(POWER_RAGE, 0);
                                auto shieldSlam = sSpellMgr->GetSpellInfo(SPELL_WARRIOR_SHIELD_SLAM);
                                player->AddCategoryCooldowns(sSpellMgr->GetSpellInfo(SPELL_WARRIOR_SHIELD_SLAM), spellInfo->GetEffect(EFFECT_2).MiscValue);
                            }
                        }

                player->AddSpellCooldown(id, 0, spellInfo->GetEffect(EFFECT_2).MiscValue, true);
                return SPELL_FAILED_DONT_REPORT;
            }
        }

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_warr_shield_strikes::CheckCast);
    }
};

class spell_warr_shield_strikes_aura : public AuraScript
{
    PrepareAuraScript(spell_warr_shield_strikes_aura);

    void HandleOnProc(ProcEventInfo& eventInfo)
    {
        // dont trigger on the shield bash. Why is it triggering on the shield bash...
        if (!eventInfo.GetProcSpell())
            if (Player* player = GetCaster()->ToPlayer())
            {
                if (auto aura = player->GetLatestSpellEffect(SPELL_WARRIOR_SHIELD_STRIKES, SPELL_WARRIOR_GLAD_FLASH_STRIKES))
                    player->CastSpell(player, aura->GetEffect(EFFECT_0).TriggerSpell);
                else
                    if (auto victim = eventInfo.GetActionTarget())
                        player->CastSpell(victim, GetId() + 1);
            }
    }

    void Register() override
    {
        OnProc += AuraProcFn(spell_warr_shield_strikes_aura::HandleOnProc);
    }
};

class spell_warr_shield_strike : public SpellScript
{
    PrepareSpellScript(spell_warr_shield_strike);

    void HandleAfterHit()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            if (auto victim = GetHitUnit())
                if (victim->IsAlive())
                    if (auto trauma = player->GetLatestSpellEffect(SPELL_WARRIOR_SHIELD_STRIKES, SPELL_WARRIOR_TRAUMATIZING_STRIKES))
                    {
                        auto id = trauma->Id + 1;

                        if (auto aura = victim->GetAura(id))
                        {
                            auto deeper = player->GetLatestSpellEffect(SPELL_WARRIOR_SHIELD_STRIKES, SPELL_WARRIOR_DEEPER_TRAUMA);
                            int maxStacks = deeper ? deeper->GetEffect(EFFECT_0).CalcValue() : trauma->GetEffect(EFFECT_2).CalcValue();

                            if (aura->GetStackAmount() < maxStacks)
                                aura->SetStackAmount(aura->GetStackAmount() + 1);

                            aura->RefreshDuration();
                        }
                        else
                            player->CastSpell(victim, id);
                    }
        }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_warr_shield_strike::HandleAfterHit);
    }
};

class spell_warr_furious_strike : public AuraScript
{
    PrepareAuraScript(spell_warr_furious_strike);

    void CalculateAmount(AuraEffect const* aurEff, int32& amount, bool& canBeRecalculated)
    {
        if (Unit* caster = GetCaster())
        {
            // calc damage
            canBeRecalculated = false;

            auto atkPct = GetSpellInfo()->GetEffect(EFFECT_1).CalcValue() * 0.01f;
            amount += int32((caster->GetTotalAttackPowerValue(BASE_ATTACK) * atkPct) / 3);
        }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warr_furious_strike::CalculateAmount, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

class spell_warr_taste_for_blood : public AuraScript
{
    PrepareAuraScript(spell_warr_taste_for_blood);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (Unit* player = GetCaster()->ToPlayer())
            if (!player->HasSpellCooldown(GetId()))
            {
                player->AddSpellCooldown(GetId(), 0, GetSpellInfo()->GetRecoveryTime());
                return true;
            }

        return false;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_taste_for_blood::CheckProc);
    }
};

class spell_warr_iron_will : public AuraScript
{
    PrepareAuraScript(spell_warr_iron_will);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return !eventInfo.GetProcSpell() || GetSpellInfo()->CheckFamilyFlagsApply(eventInfo.GetProcSpell()->GetSpellInfo()->SpellFamilyFlags, EFFECT_1);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_iron_will::CheckProc);
    }
};

class spell_warr_anger_management : public AuraScript
{
    PrepareAuraScript(spell_warr_anger_management);

    void HandleTick(AuraEffect const* aurEff)
    {
        if (Unit* caster = GetCaster())
        {
            if (caster->GetPowerPct(POWER_RAGE) < 50)
            {
                if (!caster->HasAura(SPELL_WARRIOR_ANGRY))
                {
                    caster->RemoveAura(SPELL_WARRIOR_FURIOUS);
                    caster->AddAura(SPELL_WARRIOR_ANGRY, caster);
                }
            }
            else
            {
                if (!caster->HasAura(SPELL_WARRIOR_FURIOUS))
                {
                    caster->RemoveAura(SPELL_WARRIOR_ANGRY);
                    caster->AddAura(SPELL_WARRIOR_FURIOUS, caster);
                }
            }
        }
    }

    void OnRemove()
    {
        if (Unit* caster = GetCaster())
        {
            caster->RemoveAura(SPELL_WARRIOR_FURIOUS);
            caster->RemoveAura(SPELL_WARRIOR_ANGRY);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_warr_anger_management::HandleTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        OnAuraRemove += AuraRemoveFn(spell_warr_anger_management::OnRemove);
    }
};

class spell_warr_calculated_strikes : public AuraScript
{
    PrepareAuraScript(spell_warr_calculated_strikes);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return !eventInfo.GetProcSpell() || GetSpellInfo()->CheckFamilyFlagsApply(eventInfo.GetProcSpell()->GetSpellInfo()->SpellFamilyFlags, EFFECT_1);
    }

    void HandleProc(ProcEventInfo& eventInfo)
    {
        if (Unit* caster = GetCaster())
        {
            if (auto aura = caster->GetAura(GetSpellInfo()->GetEffect(EFFECT_0).TriggerSpell))
                aura->SetCharges(aura->CalcMaxCharges());
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_calculated_strikes::CheckProc);
        AfterProc += AuraProcFn(spell_warr_calculated_strikes::HandleProc);
    }
};

class spell_warr_weapon_specialization : public AuraScript
{
    PrepareAuraScript(spell_warr_weapon_specialization);

    void OnApply()
    {
        if (Unit* caster = GetCaster())
        {
            auto spellInfo = GetSpellInfo();
            caster->AddAura(spellInfo->GetEffect(EFFECT_1).MiscValue, caster);
            caster->AddAura(spellInfo->GetEffect(EFFECT_1).MiscValueB, caster);
            caster->AddAura(spellInfo->GetEffect(EFFECT_2).MiscValue, caster);
        }
    }

    void OnRemove()
    {
        if (Unit* caster = GetCaster())
        {
            auto spellInfo = GetSpellInfo();
            caster->RemoveAura(spellInfo->GetEffect(EFFECT_1).MiscValue);
            caster->RemoveAura(spellInfo->GetEffect(EFFECT_1).MiscValueB);
            caster->RemoveAura(spellInfo->GetEffect(EFFECT_2).MiscValue);
        }
    }

    void Register() override
    {
        OnAuraApply += AuraApplyFn(spell_warr_weapon_specialization::OnApply);
        OnAuraRemove += AuraRemoveFn(spell_warr_weapon_specialization::OnRemove);
    }
};

class spell_warr_second_wind : public AuraScript
{
    PrepareAuraScript(spell_warr_second_wind);

    void HandleTick(AuraEffect const* aurEff)
    {
        if (Unit* caster = GetCaster())
        {
            auto eff = GetSpellInfo()->GetEffect(EFFECT_0);

            if (caster->GetHealthPct() <= eff.CalcValue())
            {
                if (!caster->HasAura(eff.MiscValue))
                {
                    caster->AddAura(eff.MiscValue, caster);
                }
            }
            else
            {
                caster->RemoveAura(eff.MiscValue);
            }
        }
    }

    void OnRemove()
    {
        if (Unit* caster = GetCaster())
        {
            caster->RemoveAura(GetSpellInfo()->GetEffect(EFFECT_0).MiscValue);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_warr_second_wind::HandleTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        OnAuraRemove += AuraRemoveFn(spell_warr_second_wind::OnRemove);
    }
};

class spell_warr_juggernaut : public SpellScript
{
    PrepareSpellScript(spell_warr_juggernaut);

    void HandleAfterCast()
    {
        if (Unit* caster = GetCaster())
        {
            if (caster->HasAura(SPELL_WARRIOR_JUGGERNAUT_CRIT_BONUS_TALENT))
            {
                caster->AddAura(SPELL_WARRIOR_JUGGERNAUT_CRIT_BONUS_BUFF, caster);
            }
        }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_warr_juggernaut::HandleAfterCast);
    }
};

class spell_warr_tactician : public AuraScript
{
    PrepareAuraScript(spell_warr_tactician);

    void HandleProc(ProcEventInfo& eventInfo)
    {
        if (auto procSpell = eventInfo.GetProcSpell())
            if (!procSpell->IsTriggered())
            {
                if (roll_chance_i((GetEffect(EFFECT_0)->GetAmount() * 0.01) * procSpell->GetPowerCost()))
                {
                    if (Unit* caster = GetCaster())
                    {
                        auto target = procSpell->m_targets.GetUnitTarget();

                        if (target->IsAlive())
                            caster->CastSpell(target, procSpell->GetSpellInfo()->Id, true, nullptr, GetEffect(EFFECT_0));
                    }
                }
            }
    }

    void Register() override
    {
        AfterProc += AuraProcFn(spell_warr_tactician::HandleProc);
    }
};

class spell_sudden_death : public AuraScript
{
    PrepareAuraScript(spell_sudden_death);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetProcSpell() && GetCaster()->GetHealthPct() <= GetEffect(EFFECT_0)->GetAmount();
    }

    void HandleProc(ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        SpellInfo const* igniteDot = sSpellMgr->AssertSpellInfo(SPELL_WARRIOR_BLEEDING);
        int32 pct = GetSpellInfo()->GetEffect(EFFECT_0).CalcValue();

        float dmgRatio;
        int32 amount = int32(CalculatePct(eventInfo.GetDamageInfo()->GetDamage(), pct) / igniteDot->GetMaxTicks(eventInfo.GetActor(), dmgRatio));

        if (dmgRatio != 0)
            amount = amount * dmgRatio;

        // Xinef: implement ignite bug
        eventInfo.GetProcTarget()->CastDelayedSpellWithPeriodicAmount(eventInfo.GetActor(), SPELL_WARRIOR_BLEEDING, SPELL_AURA_PERIODIC_DAMAGE, amount);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_sudden_death::CheckProc);
        AfterProc += AuraProcFn(spell_sudden_death::HandleProc);
    }
};

class LoadWarriorSpells : LoadForgeSpells
{
public:
    LoadWarriorSpells() : LoadForgeSpells()
    {

    }

    void Load() override
    {
        RegisterSpellScript(spell_warr_sword_and_board);
        RegisterSpellScript(spell_warr_trigger_sword_and_board);
        RegisterSpellScript(spell_warr_heavy_shield_slam);
        RegisterSpellScript(spell_warr_glad_shield_slam);
        RegisterSpellScript(spell_warr_glad_shield_slam_2);
        RegisterSpellScript(spell_warrior_tearing_swipe);
        RegisterSpellScript(spell_warr_devastating_reposte);
        RegisterSpellScript(spell_warr_devastating_guard);
        RegisterSpellScript(spell_warr_devastating_critical);
        RegisterSpellScript(spell_warr_devastating_critical_aura);
        RegisterSpellScript(spell_warr_attack_replacers);
        RegisterSpellScript(spell_warr_devastating_resiliance);
        RegisterSpellScript(spell_warr_devastate);
        RegisterSpellScript(spell_warr_proc_family_flags_0);
        RegisterSpellScript(spell_warr_glad_devastate);
        RegisterSpellScript(spell_warr_glad_focus);
        RegisterSpellScript(spell_warr_fort_shield_block);
        RegisterSpellScript(spell_warr_fort_shield_block_aura);
        RegisterSpellScript(spell_warr_shield_strikes);
        RegisterSpellScript(spell_warr_shield_strikes_aura);
        RegisterSpellScript(spell_warr_shield_strike);
        RegisterSpellScript(spell_warr_furious_strike);
        RegisterSpellScript(spell_warr_taste_for_blood);
        RegisterSpellScript(spell_warr_iron_will);
        RegisterSpellScript(spell_warr_anger_management);
        RegisterSpellScript(spell_warr_calculated_strikes);
        RegisterSpellScript(spell_warr_weapon_specialization);
        RegisterSpellScript(spell_warr_second_wind);
        RegisterSpellScript(spell_warr_juggernaut);
        RegisterSpellScript(spell_warr_tactician);
        RegisterSpellScript(spell_sudden_death);
    }
};
