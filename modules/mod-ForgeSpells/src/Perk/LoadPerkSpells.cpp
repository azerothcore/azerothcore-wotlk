#include "LoadForgeSpells.cpp"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "SpellScript.h"


// 600608
class spell_arch_wild_magic : public AuraScript
{
    PrepareAuraScript(spell_arch_wild_magic);

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        if (DamageInfo* damageInfo = eventInfo.GetDamageInfo()) {
            auto damage = damageInfo->GetDamage();

            SpellInfo const* procSpell = eventInfo.GetSpellInfo();
            auto cost = procSpell->ManaCostPercentage;
            if(roll_chance_f(procSpell->ManaCostPercentage) * 2) // 2% per 1% mana spent
                if (auto player = GetOwner()->ToPlayer())
                    player->CastCustomSpell(aurEff->GetTriggerSpell(), SPELLVALUE_BASE_POINT0, damage, eventInfo.GetProcTarget(), true);
        }
    }

    void Register()
    {
        OnEffectProc += AuraEffectProcFn(spell_arch_wild_magic::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// 500546
class spell_arch_mana_battery : public AuraScript
{
    PrepareAuraScript(spell_arch_mana_battery);

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        if(auto* healInfo = eventInfo.GetHealInfo())
            if (auto player = GetOwner()->ToPlayer())
                player->CastCustomSpell(aurEff->GetTriggerSpell(), SPELLVALUE_BASE_POINT0, healInfo->GetEffectiveHeal() * .07, eventInfo.GetProcTarget(), true);

    }

    void Register()
    {
        OnEffectProc += AuraEffectProcFn(spell_arch_mana_battery::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// 600600
class spell_perk_fire_explosion : public AuraScript
{
    PrepareAuraScript(spell_perk_fire_explosion);

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        if (DamageInfo* damageInfo = eventInfo.GetDamageInfo()) {
            auto damage = CalculatePct(damageInfo->GetDamage(), aurEff->GetAmount());

            SpellInfo const* procSpell = eventInfo.GetSpellInfo();
            if (auto player = GetOwner()->ToPlayer())
                player->CastCustomSpell(aurEff->GetTriggerSpell(), SPELLVALUE_BASE_POINT0, damage, eventInfo.GetProcTarget(), true);
        }
    }

    void Register()
    {
        OnEffectProc += AuraEffectProcFn(spell_perk_fire_explosion::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// Snappy anything
class spell_perk_refund_cost : public AuraScript
{
    PrepareAuraScript(spell_perk_refund_cost);

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        if(SpellInfo const* spellProto = aurEff->GetSpellInfo())
            if (auto player = GetOwner()->ToPlayer()) {
                auto timeOff = aurEff->GetAmount();
                auto spell = aurEff->GetMiscValue();

                if (player->HasSpellCooldown(spell)) {
                    SpellCooldowns& cds = player->GetSpellCooldownMap();
                    auto target = cds.find(spell);
                    if (target != cds.end())
                        target->second.end = std::max((uint32)0, target->second.end - timeOff);
                }
            }
    }

    void Register()
    {
        OnEffectProc += AuraEffectProcFn(spell_perk_refund_cost::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

class spell_perk_any_proc : public AuraScript
{
    PrepareAuraScript(spell_perk_any_proc);

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        SpellInfo const* spellProto = aurEff->GetSpellInfo();

        if (SpellInfo const* procSpell = eventInfo.GetSpellInfo()) {
            if (procSpell->SpellFamilyName == SPELLFAMILY_PERK)
                return;
        }

        else
            return;
        
        if (auto player = GetOwner()->ToPlayer()) {
            if (!player->HasSpellCooldown(aurEff->GetId())) {
                player->CastSpell(eventInfo.GetActionTarget(), aurEff->GetTriggerSpell(), true);
                player->AddSpellCooldown(aurEff->GetId(), 0, aurEff->GetAmount() * IN_MILLISECONDS);

            }
        }
    }

    void Register()
    {
        OnEffectProc += AuraEffectProcFn(spell_perk_any_proc::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

class LoadPerkSpells : LoadForgeSpells
{
public:
    LoadPerkSpells() : LoadForgeSpells()
    {

    }

    void Load() override
    {
        RegisterSpellScript(spell_arch_wild_magic);
        RegisterSpellScript(spell_arch_mana_battery);
        RegisterSpellScript(spell_perk_refund_cost);
        RegisterSpellScript(spell_perk_any_proc);
        RegisterSpellScript(spell_perk_fire_explosion);
    }
};
