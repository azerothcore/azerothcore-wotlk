#include "InvasionScalingMgr.h"
#include "mod_branding_loader.h"
#include "Creature.h"
#include "ScriptMgr.h"

using namespace Branding;

// §2.5 (issue #26): refreshes the invasion-scaling config on startup / `.reload config`.
class BrandingInvasionScalingWorldScript : public WorldScript
{
public:
    BrandingInvasionScalingWorldScript() : WorldScript("BrandingInvasionScalingWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sInvasionScalingMgr->LoadConfig();
    }
};

// §2.5.1 application: an invasion creature's OUTGOING damage is multiplied by the crowd-keyed curve
// (boss via the §2.2 group curve, trash via the gentle invasion curve). This runs on the CREATURE-
// attacker branch -- the §2.1 player downscale + §7.9 player branding UnitScripts only touch Player
// attackers -- so it rides on the encounter baseline. The magnitude is bounded inside the pure
// helpers, so this script is a dumb applier (mirrors BrandingMasteryEnemyUnitScript).
class BrandingInvasionScalingUnitScript : public UnitScript
{
public:
    BrandingInvasionScalingUnitScript() : UnitScript("BrandingInvasionScalingUnitScript") { }

    void ModifyMeleeDamage(Unit* /*target*/, Unit* attacker, uint32& damage) override
    {
        Apply(attacker, damage);
    }

    void ModifyPeriodicDamageAurasTick(Unit* /*target*/, Unit* attacker, uint32& damage, SpellInfo const* /*spellInfo*/) override
    {
        Apply(attacker, damage);
    }

    void ModifySpellDamageTaken(Unit* /*target*/, Unit* attacker, int32& damage, SpellInfo const* /*spellInfo*/) override
    {
        if (!sInvasionScalingMgr->Enabled() || !attacker)
            return;

        if (Creature* creature = attacker->ToCreature())
            damage = static_cast<int32>(damage * sInvasionScalingMgr->OutgoingMultiplierFor(creature));
    }

private:
    static void Apply(Unit* attacker, uint32& damage)
    {
        if (!sInvasionScalingMgr->Enabled() || !attacker)
            return;

        if (Creature* creature = attacker->ToCreature())
            damage = static_cast<uint32>(damage * sInvasionScalingMgr->OutgoingMultiplierFor(creature));
    }
};

void AddBrandingInvasionScalingScripts()
{
    new BrandingInvasionScalingWorldScript();
    new BrandingInvasionScalingUnitScript();
}
