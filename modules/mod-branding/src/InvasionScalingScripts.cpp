#include "InvasionScalingMgr.h"
#include "mod_branding_loader.h"
#include "Creature.h"
#include "ScriptMgr.h"
#include <algorithm>

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

// §2.5.1 health lever: an invasion creature's max health is scaled once when it enters the world
// (snapshot-not-pull, §2.3 Risk #4). Boss/elite via the §2.2 EncounterHealthMul curve (softer for a
// small crowd), trash via the gentle InvasionTrashMul. Applied relative to GetCreateHealth() so a
// grid reload re-applies the same target rather than compounding; the current-health % is preserved.
class BrandingInvasionScalingCreatureScript : public AllCreatureScript
{
public:
    BrandingInvasionScalingCreatureScript() : AllCreatureScript("BrandingInvasionScalingCreatureScript") { }

    void OnCreatureAddWorld(Creature* creature) override
    {
        if (!sInvasionScalingMgr->Enabled() || !creature)
            return;

        double const mul = sInvasionScalingMgr->HealthMultiplierFor(creature);
        if (mul == 1.0)
            return;

        uint32 const base = creature->GetCreateHealth();
        if (base == 0)
            return;

        float const pct = creature->GetHealthPct();
        uint32 const target = std::max<uint32>(1, static_cast<uint32>(base * mul));
        creature->SetMaxHealth(target);
        creature->SetHealth(static_cast<uint32>(target * pct / 100.0f));
    }
};

void AddBrandingInvasionScalingScripts()
{
    new BrandingInvasionScalingWorldScript();
    new BrandingInvasionScalingUnitScript();
    new BrandingInvasionScalingCreatureScript();
}
