#include "LoadForgeSpells.cpp"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "SpellScript.h"

enum RogueSpells
{
    SPELL_ROGUE_SINISTER_ECHO               = 1200001,
    SPELL_ROGUE_BOOMING_ECHO                = 1200002,
    SPELL_ROGUE_PENETRATING_ECHO            = 1200008,
    SPELL_ROGUE_REFRESHING_ECHO             = 1200009,
    SPELL_ROGUE_CLEAVING_ECHO               = 1200014,
    SPELL_ROGUE_FURTHER_ECHO                = 1200015,
    SPELL_ROGUE_EXPOSE_ARMOR                = 8647,
    SPELL_ROGUE_SLICE_AND_DICE              = 5171,
    SPELL_ROGUE_SINISTER_WOUNDS             = 1200016,
    SPELL_ROGUE_TRANSFUSION                 = 1200022,
    SPELL_ROGUE_COVERED_IN_BLOOD            = 1200027,
    SPELL_ROGUE_COVERED_IN_BLOOD_PROC       = 1200032,
    SPELL_ROGUE_BLOODIER_SINISTER_WOUNDS    = 1200033,
    SPELL_ROGUE_SINISTER_SLAM               = 1200039,
    SPELL_ROGUE_PENETRATING_STING           = 1200052,
    SPELL_ROGUE_PENETRATING_STING_PROC      = 1200078,
    SPELL_ROGUE_APPLY_RED_NOTE              = 1200057,
    SPELL_ROGUE_DEMORALIZING_DURGE          = 1200083,
    SPELL_ROGUE_NIMBLE_SIN_STRIKE           = 1200062,
    SPELL_ROGUE_INVIGORING_SIN_STRIKE       = 1200072,
    SPELL_ROGUE_ADRENALINE_RUSH             = 13750,
    SPELL_ROGUE_ROLL_THE_BONES              = 1200051,
    SPELL_ROGUE_BROADSIDE                   = 1200060,
    SPELL_ROGUE_BURIED_TREASURE             = 1200075,
    SPELL_ROGUE_GRAND_MELEE                 = 1200076,
    SPELL_ROGUE_RUTHLESS_PRECISION          = 1200077,
    SPELL_ROGUE_SKULL_AND_CROSSBONES        = 1200086,
    SPELL_ROGUE_TRUE_BEARING                = 1200087,
    SPELL_ROGUE_LOADED_DICE                 = 1200091,
    SPELL_ROGUE_DASH_AND_GASH               = 1200092,
    SPELL_ROGUE_NIMBLE_MOVEMENT             = 1200093,
    SPELL_ROGUE_CUT_TENDON                  = 1200099,
    SPELL_ROGUE_CULL_THE_WEAK               = 1200105,
    SPELL_ROGUE_AWE_AND_INSPIRE             = 1200107,
    SPELL_ROGUE_AWE_AND_INSPIRE_BLUE_NOTE   = 1200108,
    SPELL_ROGUE_AWE_AND_INSPIRE_RED_NOTE    = 1200109,
    SPELL_ROGUE_AWE_AND_INSPIRE_AURA        = 1200110,
    SPELL_ROGUE_ELEMENTAL_CAROL             = 1200111,
    SPELL_ROGUE_ADVANCING_MARCH             = 1200113,
    SPELL_ROGUE_REFRESHING_TUNE             = 1200115,
    SPELL_ROGUE_BATTLE_CHORUS               = 1200117,
    SPELL_ROGUE_WILD_CUTS                   = 1200119,
    SPELL_ROGUE_UNPREDICTABLE               = 1200120,
    SPELL_ROGUE_BLADE_WALL                  = 1200130,
    SPELL_ROGUE_ADVANCE                     = 1200136,
    SPELL_ROGUE_STRIKING_GLINT              = 1200137,
    SPELL_ROGUE_ALWAYS_READY                = 1200139,
    SPELL_ROGUE_THREATENING_SLICE_AND_DICE  = 1200143,
    SPELL_ROGUE_ACTION_ECONOMY              = 1200145,
    SPELL_ROGUE_AWE_AND_INSPIRE_GREEN_NOTE  = 1200152,
    SPELL_ROGUE_APPLY_GREEN_NOTE            = 1200150,
};

static bool GetChance(int chance, Player* player)
{
    if (auto economy = player->GetLatestSpellEffectForEnhacement(SPELL_ROGUE_ACTION_ECONOMY))
        if (player->CheckAuraExistsByMiscB(SPELL_ROGUE_ACTION_ECONOMY))
            chance += economy->GetEffect(EFFECT_0).CalcValue();

    return roll_chance_i(chance);
}

static std::vector<Aura*> GetSliceAndDiceAuras(Player* player)
{
    std::vector<Aura*> sndEffects = player->GetAurasByMiscA(SPELL_ROGUE_SLICE_AND_DICE);

    if (sndEffects.empty())
    {
        if (player->HasSpell(SPELL_ROGUE_ROLL_THE_BONES))
            sndEffects = player->GetAurasByMiscA(SPELL_ROGUE_ROLL_THE_BONES);
        else if (player->HasSpell(SPELL_ROGUE_DASH_AND_GASH))
            sndEffects = player->GetAurasByMiscA(SPELL_ROGUE_DASH_AND_GASH);
        else if (player->HasSpell(SPELL_ROGUE_AWE_AND_INSPIRE))
            sndEffects = player->GetAurasByMiscB(SPELL_ROGUE_AWE_AND_INSPIRE);
        else if (player->HasSpell(SPELL_ROGUE_WILD_CUTS))
            sndEffects = player->GetAurasByMiscB(SPELL_ROGUE_WILD_CUTS);
    }

    return sndEffects;
}

static void ApplyNote(Player* player, Unit* target, uint32 noteToApply, int maxStacks)
{
    if (auto aura = target->GetAura(noteToApply, player->GetGUID()))
    {
        aura->SetStackAmount(std::min(aura->GetStackAmount() + 1, maxStacks));
        aura->RefreshDuration();
    }
    else
        player->AddAura(noteToApply, target);
}

static void ApplyNoteEffects(Player* player, Unit* target, uint32 miscAEffect = SPELL_ROGUE_AWE_AND_INSPIRE)
{
    auto tAuras = target->GetAurasByMiscA(miscAEffect, player->GetGUID());

    for (auto tAura : tAuras)
    {
        int stacks = tAura->GetStackAmount();

        auto newAura = player->AddAura(tAura->GetSpellInfo()->GetEffect(EFFECT_0).MiscValueB, target);
        newAura->SetStackAmount(stacks);

        target->RemoveAura(tAura->GetId());
    }
}

class spell_rog_sinister_echo : public SpellScript
{
    PrepareSpellScript(spell_rog_sinister_echo);

    void SinisterEchoAfterHit()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            if (Unit* victim = GetHitUnit())
            {
                if (!victim->isDead()) // run if target is alive
                {
                    if (GetChance(GetSpellInfo()->GetEffect(EFFECT_2).CalcValue(), player))
                    {
                        bool cleave = false;
                        auto spellId = GetSpellInfo()->Id;

                        std::vector<SpellInfo*> echoRolls = {};

                        uint32 boomId = 0;
                        // Check booming echo
                        if (auto booming = player->GetLatestSpellEffect(spellId, SPELL_ROGUE_BOOMING_ECHO))
                        {
                            echoRolls.push_back(booming);
                            boomId = booming->Id;
                        }

                        uint32 refreshId = 0;
                        std::vector<Aura*> sndEffects;
                        if (auto refreshing = player->GetLatestSpellEffect(spellId, SPELL_ROGUE_REFRESHING_ECHO))
                        {
                            refreshId = refreshing->Id;
                            sndEffects = GetSliceAndDiceAuras(player);

                            if (!sndEffects.empty())
                                echoRolls.push_back(refreshing);
                        }

                        if (auto penetrating = player->GetLatestSpellEffect(spellId, SPELL_ROGUE_PENETRATING_ECHO))
                            echoRolls.push_back(penetrating);

                        if (auto cleaving = player->GetLatestSpellEffect(spellId, SPELL_ROGUE_CLEAVING_ECHO))
                            echoRolls.push_back(cleaving);

                        if (echoRolls.size() > 0)
                        {
                            int rolls = player->HasSpell(SPELL_ROGUE_FURTHER_ECHO) ? 2 : 1;
                            SpellInfo* firstRoll;

                            while (rolls > 0)
                            {
                                int index = rand() % echoRolls.size(); // pick a random index
                                auto rolledAura = echoRolls[index];

                                if (firstRoll != rolledAura) // make sure we dont run the same thing twice
                                {
                                    if (rolledAura->Id == refreshId) // refreshing
                                    {
                                        for (auto sndEffect : sndEffects)
                                        {
                                            int32 duration = sndEffect->GetDuration() + rolledAura->GetEffect(EFFECT_0).CalcValue();
                                            duration = std::min(duration, sndEffect->GetMaxDuration());
                                            sndEffect->SetDuration(duration, false);
                                        }
                                    }
                                    else if (rolledAura->Id == boomId) // booming
                                    {
                                        player->AddAura(rolledAura->Id + 1, player);
                                    }
                                    else if (rolledAura->Id == SPELL_ROGUE_PENETRATING_ECHO)
                                    {
                                        auto ea = victim->GetAura(SPELL_ROGUE_EXPOSE_ARMOR);

                                        if (ea)
                                        {
                                            int32 eaDur = ea->GetDuration();
                                            if (eaDur < rolledAura->GetEffect(EFFECT_0).CalcValue())
                                                ea->SetDuration(rolledAura->GetEffect(EFFECT_0).CalcValue(), false);
                                        }
                                        else
                                        {
                                            auto newEa = player->AddAura(SPELL_ROGUE_EXPOSE_ARMOR, victim);
                                            newEa->SetMaxDuration(rolledAura->GetEffect(EFFECT_0).CalcValue());
                                            newEa->RefreshDuration(false);
                                        }
                                    }
                                    else if (rolledAura->Id == SPELL_ROGUE_CLEAVING_ECHO)
                                        cleave = true;

                                    rolls--;
                                    firstRoll = rolledAura;
                                }
                            }
                        }

                        // do attacks
                        player->CastSpell(victim, SPELL_ROGUE_SINISTER_ECHO, true);

                        if (cleave)
                            if (auto t1 = player->SelectNearbyNoTotemTarget())
                            {
                                player->CastSpell(t1, SPELL_ROGUE_SINISTER_ECHO, true);

                                if (auto t2 = player->SelectNearbyNoTotemTarget(t1))
                                    player->CastSpell(t2, SPELL_ROGUE_SINISTER_ECHO, true);
                            }
                    }
                }
            }
        }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_rog_sinister_echo::SinisterEchoAfterHit);
    }
};

class spell_rog_sinister_wounds : public AuraScript
{
    PrepareAuraScript(spell_rog_sinister_wounds);

    void CalculateAmount(AuraEffect const* aurEff, int32& amount, bool& canBeRecalculated)
    {
        if (Unit* caster = GetCaster())
        {
            // calc damage
            canBeRecalculated = false;

            // $0.2 * (($MWB + $mwb) / 2 + $AP / 14 * $MWS) bonus per tick
            float ap = caster->GetTotalAttackPowerValue(BASE_ATTACK);
            int32 mws = caster->GetAttackTime(BASE_ATTACK);
            float mwbMin = caster->GetWeaponDamageRange(BASE_ATTACK, MINDAMAGE);
            float mwbMax = caster->GetWeaponDamageRange(BASE_ATTACK, MAXDAMAGE);
            float mwb = ((mwbMin + mwbMax) / 2 + ap * mws / 14000) * 0.2f;
            amount += int32(caster->ApplyEffectModifiers(GetSpellInfo(), aurEff->GetEffIndex(), mwb));

            maxShield = std::ceil(aurEff->GetCaster()->GetMaxHealth() / 10);

            if (auto cidAura = aurEff->GetCaster()->AuraExists(SPELL_ROGUE_COVERED_IN_BLOOD_PROC))
            {
                cidAura->GetBase()->RefreshDuration(true);
            }
        }
    }

    void EffectPeriodic(AuraEffect const* aurEff)
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            auto spellId = GetSpellInfo()->Id;

            // check transfusion
            if (auto transfusion = player->GetLatestSpellEffect(spellId, SPELL_ROGUE_TRANSFUSION))
            {
                auto pcnt = transfusion->GetEffect(EFFECT_0).CalcValue() * 0.01;
                auto heal = std::ceil(pcnt * aurEff->GetAmount());
                HealInfo hInfo(player, player, heal, GetSpellInfo(), SPELL_SCHOOL_MASK_NONE);
                player->HealBySpell(hInfo);
            }
            // check Covered in Blood
            else if (auto covered = player->GetLatestSpellEffect(spellId, SPELL_ROGUE_COVERED_IN_BLOOD))
            {
                auto pcnt = covered->GetEffect(EFFECT_0).CalcValue() * 0.01;
                auto shield = int32(std::ceil(pcnt * aurEff->GetAmount()));
                auto cidAura = player->AuraExists(SPELL_ROGUE_COVERED_IN_BLOOD_PROC);

                if (cidAura)
                    cidAura->GetBase()->GetEffect(0)->SetAmount(std::min(cidAura->GetBase()->GetEffect(0)->GetAmount() + shield, maxShield));
                else
                {
                    auto newAura = player->AddAura(SPELL_ROGUE_COVERED_IN_BLOOD_PROC, player);
                    newAura->GetEffect(0)->SetAmount(shield);
                }
            }
        }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_rog_sinister_wounds::CalculateAmount, EFFECT_2, SPELL_AURA_PERIODIC_DAMAGE);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_rog_sinister_wounds::EffectPeriodic, EFFECT_2, SPELL_AURA_PERIODIC_DAMAGE);
    }
private:
    int32 maxShield;
};

class spell_rog_sinister_wounds_spell : public SpellScript
{
    PrepareSpellScript(spell_rog_sinister_wounds_spell);

    void SinWoundsAfterHit()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            if (Unit* victim = GetHitUnit())
            {
                if (player->HasSpell(SPELL_ROGUE_BLOODIER_SINISTER_WOUNDS))
                {
                    auto targets = player->SelectAllNearbyNoTotemTarget(victim);
                    for (auto target : targets)
                        player->AddAura(SPELL_ROGUE_SINISTER_WOUNDS, target);
                }
            }
        }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_rog_sinister_wounds_spell::SinWoundsAfterHit);
    }
};

class spell_rog_sinister_sting : public SpellScript
{
    PrepareSpellScript(spell_rog_sinister_sting);

    void HandleAfterHit()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            auto spellId = GetSpellInfo()->Id;

            if (Unit* target = GetHitUnit())
            {
                // penetrating sting
                if (auto pene = player->GetLatestSpellEffect(spellId, SPELL_ROGUE_PENETRATING_STING))
                    player->AddAura(pene->GetEffect(EFFECT_1).MiscValue, target);

                // apply red note
                if (auto red = player->GetLatestSpellEffect(spellId, SPELL_ROGUE_APPLY_RED_NOTE))
                    if (auto aura = target->GetAura(SPELL_ROGUE_AWE_AND_INSPIRE_RED_NOTE, player->GetGUID()))
                        aura->SetStackAmount(std::min(aura->GetStackAmount() + 1, red->GetEffect(EFFECT_0).CalcValue()));
                    else
                        player->AddAura(SPELL_ROGUE_AWE_AND_INSPIRE_RED_NOTE, target);
            }
        }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_rog_sinister_sting::HandleAfterHit);
    }
};

class spell_rog_sinister_nimble_sin_strike : public SpellScript
{
    PrepareSpellScript(spell_rog_sinister_nimble_sin_strike);

    void SinStrikeAfterHit()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            if (auto nimble = player->GetLatestSpellEffectForEnhacement(SPELL_ROGUE_NIMBLE_SIN_STRIKE))
                if (GetChance(nimble->GetEffect(EFFECT_2).CalcValue(), player))
                    player->AddAura(nimble->Id + 1, player);
        }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_rog_sinister_nimble_sin_strike::SinStrikeAfterHit);
    }
};

class spell_rog_sinister_invigorating_sin_strike : public SpellScript
{
    PrepareSpellScript(spell_rog_sinister_invigorating_sin_strike);

    void SinStrikeBeforeCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
            proc = player->GetComboPoints() == 0;
    }

    void SinStrikeAfterHit()
    {
        if (proc)
            if (Player* player = GetCaster()->ToPlayer())
                if (auto invigorating = player->GetLatestSpellEffectForEnhacement(SPELL_ROGUE_INVIGORING_SIN_STRIKE))
                    player->ModifyPower(POWER_ENERGY, invigorating->GetEffect(EFFECT_0).CalcValue());
    }

    void Register() override
    {
        BeforeCast += SpellCastFn(spell_rog_sinister_invigorating_sin_strike::SinStrikeBeforeCast);
        AfterHit += SpellHitFn(spell_rog_sinister_invigorating_sin_strike::SinStrikeAfterHit);
    }

private:
    bool proc = false;
};

class spell_rog_roll_the_bones : public SpellScript
{
    PrepareSpellScript(spell_rog_roll_the_bones);

    std::vector<uint32> BoneRolls = { SPELL_ROGUE_BROADSIDE, SPELL_ROGUE_BURIED_TREASURE, SPELL_ROGUE_GRAND_MELEE, SPELL_ROGUE_RUTHLESS_PRECISION, SPELL_ROGUE_SKULL_AND_CROSSBONES, SPELL_ROGUE_TRUE_BEARING };
    
    void RollTheBonesCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            int comboPoints = player->GetComboPoints();

            if (comboPoints > 0)
            {
                int count = 0;
                int mincount = 1;

                if (player->HasSpell(SPELL_ROGUE_LOADED_DICE) && player->GetAura(SPELL_ROGUE_ADRENALINE_RUSH))
                    mincount = 2;

                while (count < mincount)
                    if (GetChance(1, player)) // roll for 5
                        count = 5;
                    else if (GetChance(20, player)) // roll for 2
                        count = 2;
                    else
                        count = 1;

                std::vector<uint32> rolls;

                while (count > 0)
                {
                    uint32 roll = BoneRolls[irand(0, 5)];
                    bool exists = false;

                    for (auto itr : rolls)
                        if (itr == roll)
                        {
                            exists = true;
                            break;
                        }

                    if (!exists)
                    {
                        rolls.push_back(roll);
                        count--;
                    }
                }

                for (auto roll : rolls)
                    auto aura = player->AddAura(roll, player);
            }
        }
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_rog_roll_the_bones::RollTheBonesCast);
    }
};

class spell_rog_true_bearing : public AuraScript
{
    PrepareAuraScript(spell_rog_true_bearing);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return CheckFamilyFlags(eventInfo);
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            player->ModifySpellCooldowns(aurEff->GetBase()->GetEffect(EFFECT_0)->GetAmount() * player->GetComboPoints());
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_rog_true_bearing::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_rog_true_bearing::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

class spell_rog_skull_and_crossbones : public AuraScript
{
    PrepareAuraScript(spell_rog_skull_and_crossbones);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return CheckFamilyFlags(eventInfo);
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            if (!eventInfo.GetProcSpell()->IsTriggered() && GetChance(GetSpellInfo()->GetEffect(EFFECT_0).CalcValue(), player))
                if (Unit* victim = eventInfo.GetActionTarget())
                    player->CastSpell(victim, eventInfo.GetProcSpell()->GetSpellInfo()->Id, true, nullptr, aurEff, player->GetGUID());
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_rog_skull_and_crossbones::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_rog_skull_and_crossbones::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

class spell_rog_broadside : public AuraScript
{
    PrepareAuraScript(spell_rog_broadside);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return CheckFamilyFlags(eventInfo);
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        if (Player* player = GetCaster()->ToPlayer())
            player->AddComboPoints(1);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_rog_broadside::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_rog_broadside::HandleProc, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
    }
};

class spell_rog_dash_and_gash : public SpellScript
{
    PrepareSpellScript(spell_rog_dash_and_gash);

    void HandleCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            if (auto nimble = player->GetLatestSpellEffect(GetSpellInfo()->Id, SPELL_ROGUE_NIMBLE_MOVEMENT))
            {
                auto aura = player->AddAura(nimble->Id + 1, player);
                aura->SetMaxDuration(GetSpellInfo()->GetMaxDuration());
                aura->RefreshDuration(false);
            }

            if (auto cull = player->GetLatestSpellEffect(GetSpellInfo()->Id, SPELL_ROGUE_CULL_THE_WEAK))
            {
                auto aura = player->AddAura(cull->Id + 1, player);
                aura->SetMaxDuration(GetSpellInfo()->GetMaxDuration());
                aura->RefreshDuration(false);
            }
        }
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_rog_dash_and_gash::HandleCast);
    }
};

class spell_rog_dash_and_gash_aura : public AuraScript
{
    PrepareAuraScript(spell_rog_dash_and_gash_aura);

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            if (Unit* victim = eventInfo.GetActionTarget())
            {
                if (auto cut = player->GetLatestSpellEffect(GetSpellInfo()->Id, SPELL_ROGUE_CUT_TENDON))
                {
                    if (GetSpellInfo()->CheckFamilyFlagsApply(eventInfo.GetProcSpell()->GetSpellInfo()->SpellFamilyFlags))
                    {
                        auto aura = player->AddAura(cut->Id + 1, victim);
                        int duration = player->GetComboPoints() * aura->GetMaxDuration();

                        aura->SetMaxDuration(duration);
                        aura->RefreshDuration(false);
                    }
                }
            }
        }
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_rog_dash_and_gash_aura::HandleProc, EFFECT_0, SPELL_AURA_MOD_MELEE_HASTE);
    }
};

class spell_rog_wild_cuts : public SpellScript
{
    PrepareSpellScript(spell_rog_wild_cuts);

    void HandleCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            if (auto unpredictable = player->GetLatestSpellEffect(GetSpellInfo()->Id, SPELL_ROGUE_UNPREDICTABLE))
                auto aura = player->AddAura(unpredictable->Id + 1, player);

            if (auto wall = player->GetLatestSpellEffect(GetSpellInfo()->Id, SPELL_ROGUE_BLADE_WALL))
                auto aura = player->AddAura(wall->Id + 1, player);

            if (player->GetLatestSpellEffect(GetSpellInfo()->Id, SPELL_ROGUE_ADVANCE))
                player->AddComboPoints(1);
        }
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_rog_wild_cuts::HandleCast);
    }
};

class spell_rog_wild_always_ready : public SpellScript
{
    PrepareSpellScript(spell_rog_wild_always_ready);

    void HandleCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            
        }
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_rog_wild_always_ready::HandleCast);
    }
};

class spell_rog_slice_and_dice : public SpellScript
{
    PrepareSpellScript(spell_rog_slice_and_dice);

    void HandleCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            std::vector<Aura*> newAuras = {};

            if (auto alwaysReady = player->GetLatestSpellEffect(SPELL_ROGUE_SLICE_AND_DICE, SPELL_ROGUE_ALWAYS_READY))
                newAuras.push_back(player->AddAura(alwaysReady->Id + 1, player));

            if (player->HasSpell(SPELL_ROGUE_THREATENING_SLICE_AND_DICE))
                newAuras.push_back(player->AddAura(SPELL_ROGUE_THREATENING_SLICE_AND_DICE + 1, player));

            if (auto actionEcon = player->GetLatestSpellEffect(SPELL_ROGUE_SLICE_AND_DICE, SPELL_ROGUE_ACTION_ECONOMY))
                newAuras.push_back(player->AddAura(actionEcon->Id + 1, player));

            // special check for wild cuts since its duration is static and not based on combo points
            if (GetSpellInfo()->Id == SPELL_ROGUE_WILD_CUTS)
            {
                int duration = GetSpellInfo()->GetMaxDuration();

                for (Aura* aura : newAuras)
                {
                    aura->SetMaxDuration(duration);
                    aura->RefreshDuration(false);
                }
            }
        }
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_rog_slice_and_dice::HandleCast);
    }
};

class spell_rog_always_ready : public AuraScript
{
    PrepareAuraScript(spell_rog_always_ready);

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            if (Unit* victim = eventInfo.GetActionTarget())
            {
                if (roll_chance_i(aurEff->GetAmount()))
                    player->AddComboPoints(1);
            }
        }
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_rog_always_ready::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

class spell_rog_wild_cuts_proc : public AuraScript
{
    PrepareAuraScript(spell_rog_wild_cuts_proc);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            if (auto glint = player->GetLatestSpellEffect(GetSpellInfo()->Id, SPELL_ROGUE_STRIKING_GLINT))
                return roll_chance_i(glint->GetEffect(EFFECT_0).CalcValue());
        }

        return false;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        auto player = GetCaster()->ToPlayer();

        player->AddAura(SPELL_ROGUE_STRIKING_GLINT + 1, player);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_rog_wild_cuts_proc::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_rog_wild_cuts_proc::HandleProc, EFFECT_0, SPELL_AURA_MOD_MELEE_HASTE);
    }
};

class spell_rog_awe_and_inspire : public SpellScript
{
    PrepareSpellScript(spell_rog_awe_and_inspire);

    void HandleCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            auto comboPoints = player->GetComboPoints();
            int duration = 0;

            if (auto note = player->GetAura(SPELL_ROGUE_AWE_AND_INSPIRE_BLUE_NOTE))
                duration = note->GetStackAmount();
            else
            {
                auto newAura = player->AddAura(SPELL_ROGUE_AWE_AND_INSPIRE_BLUE_NOTE, player);
                newAura->SetStackAmount(comboPoints);
                return;
            }

            // 2nd cast, causing effect.
            auto partyMembers = player->SelectAllNearbyNoTotemParty(nullptr, 100);
            auto enemies = player->SelectAllNearbyNoTotemTarget(nullptr, true, 100);
            int auraToCast = SPELL_ROGUE_AWE_AND_INSPIRE_AURA;

            switch (comboPoints)
            {
            case 5:
                if (player->HasSpell(SPELL_ROGUE_BATTLE_CHORUS))
                    auraToCast = SPELL_ROGUE_BATTLE_CHORUS + 1;
                break;
            case 4:
                if (player->HasSpell(SPELL_ROGUE_REFRESHING_TUNE))
                    auraToCast = SPELL_ROGUE_REFRESHING_TUNE + 1;
                break;
            case 3:
                if (player->HasSpell(SPELL_ROGUE_ADVANCING_MARCH))
                    auraToCast = SPELL_ROGUE_ADVANCING_MARCH + 1;
                break;
            case 2:
                if (player->HasSpell(SPELL_ROGUE_ELEMENTAL_CAROL))
                    auraToCast = SPELL_ROGUE_ELEMENTAL_CAROL + 1;
                break;
            default:
                break;
            }

            player->SetComboPoints(duration); // set current combo points to the duration count stored to properly calculate aura durations.

            // notes notes
            player->RemoveAura(SPELL_ROGUE_AWE_AND_INSPIRE_BLUE_NOTE);

            // player notes
            auto castAura = player->AddAura(auraToCast, player); // blue
            ApplyNoteEffects(player, player); // other

            // party notes
            for (auto ptyMember : partyMembers)
            {
                castAura = player->AddAura(auraToCast, ptyMember); // blue
                ApplyNoteEffects(player, ptyMember); // other
            }

            // enemy notes
            for (auto target : enemies)
            {
                ApplyNoteEffects(player, target); // other
            }
        }
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_rog_awe_and_inspire::HandleCast);
    }
};

class spell_rog_pitch_correction : public SpellScript
{
    PrepareSpellScript(spell_rog_pitch_correction);

    SpellCastResult CheckCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
            return player->GetComboPoints() > 0 ? SPELL_CAST_OK : SPELL_FAILED_NO_COMBO_POINTS;
        else
            return SPELL_FAILED_ERROR;

        return SPELL_CAST_OK;
    }

    void HandleAfterHit()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            player->AddComboPoints(-1);

            // apply green
            if (auto green = player->GetLatestSpellEffectForEnhacement(SPELL_ROGUE_APPLY_GREEN_NOTE))
            {
                auto maxStacks = green->GetEffect(EFFECT_0).CalcValue();

                ApplyNote(player, player, SPELL_ROGUE_AWE_AND_INSPIRE_GREEN_NOTE, maxStacks);

                auto partyMembers = player->SelectAllNearbyNoTotemParty(nullptr, 10);

                for (auto ptyMember : partyMembers)
                {
                    ApplyNote(player, ptyMember, SPELL_ROGUE_AWE_AND_INSPIRE_GREEN_NOTE, maxStacks);
                }
            }
        }
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_rog_pitch_correction::CheckCast);
        AfterHit += SpellHitFn(spell_rog_pitch_correction::HandleAfterHit);
    }
};

class LoadRogueSpells : LoadForgeSpells
{
public:
    LoadRogueSpells() : LoadForgeSpells()
    {

    }

    void Load() override
    {
        RegisterSpellScript(spell_rog_sinister_echo);
        RegisterSpellScript(spell_rog_sinister_wounds);
        RegisterSpellScript(spell_rog_sinister_wounds_spell);
        RegisterSpellScript(spell_rog_sinister_sting);
        RegisterSpellScript(spell_rog_sinister_nimble_sin_strike);
        RegisterSpellScript(spell_rog_sinister_invigorating_sin_strike);
        RegisterSpellScript(spell_rog_roll_the_bones);
        RegisterSpellScript(spell_rog_true_bearing);
        RegisterSpellScript(spell_rog_skull_and_crossbones);
        RegisterSpellScript(spell_rog_broadside);
        RegisterSpellScript(spell_rog_dash_and_gash);
        RegisterSpellScript(spell_rog_dash_and_gash_aura);
        RegisterSpellScript(spell_rog_wild_cuts);
        RegisterSpellScript(spell_rog_slice_and_dice);
        RegisterSpellScript(spell_rog_always_ready);
        RegisterSpellScript(spell_rog_wild_cuts_proc);
        RegisterSpellScript(spell_rog_pitch_correction);
        RegisterSpellScript(spell_rog_awe_and_inspire);
    }
};
