#include "MasteryCombatMgr.h"
#include "mod_branding_loader.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Branding;

// §14.12 (issue #27): refreshes the combat-mastery config on startup / `.reload config`. The config is
// owned by MasteryLoadoutMgr (the production MasteryConfig implements all three injected interfaces);
// this just rides its load + enable switch so the combat layer and the loadout layer stay in lockstep.
class BrandingMasteryCombatWorldScript : public WorldScript
{
public:
    BrandingMasteryCombatWorldScript() : WorldScript("BrandingMasteryCombatWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sMasteryCombatMgr->LoadConfig();
    }
};

// §14.12 application: a branded player's OUTGOING damage is multiplied by the aggregate of their
// currently-active mastery cells (windowed Off/Def during their phase + sustained Support always on).
// Composes multiplicatively with §2.1 zone scaling and the §7.9 effect multiplier (separate UnitScripts)
// -- scaling reduces first, branding/mastery boost on top. The magnitudes are already bounded to the
// §7.9 caps + catalyst DR inside the pure MasteryPlan, so this script is a dumb applier.
//
// First cut: the aggregate OUTGOING-damage multiplier is the observable application point (mirrors the
// §7.9 EffectMgr UnitScript). The per-cell proc-cadence buff/debuff auras (PPM via ExpectedProcs +
// EventMap/TaskScheduler) and the personal-spike tank-survivability auras are the data-layer expansion;
// the testable decision (WHICH cells, HOW strong, WHEN active) lives in the pure plan and is covered.
class BrandingMasteryCombatUnitScript : public UnitScript
{
public:
    BrandingMasteryCombatUnitScript() : UnitScript("BrandingMasteryCombatUnitScript") { }

    void ModifyMeleeDamage(Unit* /*target*/, Unit* attacker, uint32& damage) override
    {
        ApplyMastery(attacker, damage);
    }

    void ModifyPeriodicDamageAurasTick(Unit* /*target*/, Unit* attacker, uint32& damage, SpellInfo const* /*spellInfo*/) override
    {
        ApplyMastery(attacker, damage);
    }

    void ModifySpellDamageTaken(Unit* /*target*/, Unit* attacker, int32& damage, SpellInfo const* /*spellInfo*/) override
    {
        if (!sMasteryCombatMgr->Enabled() || !attacker)
            return;

        if (Player* player = attacker->ToPlayer())
            damage = static_cast<int32>(damage * sMasteryCombatMgr->OutgoingMultiplierFor(player));
    }

private:
    static void ApplyMastery(Unit* attacker, uint32& damage)
    {
        if (!sMasteryCombatMgr->Enabled() || !attacker)
            return;

        if (Player* player = attacker->ToPlayer())
            damage = static_cast<uint32>(damage * sMasteryCombatMgr->OutgoingMultiplierFor(player));
    }
};

void AddBrandingMasteryCombatScripts()
{
    new BrandingMasteryCombatWorldScript();
    new BrandingMasteryCombatUnitScript();
}
