#include "MasteryEnemyMgr.h"
#include "mod_branding_loader.h"
#include "Creature.h"
#include "ScriptMgr.h"

using namespace Branding;

// §14.8 (issue #31): refreshes the enemy-mastery config on startup / `.reload config`.
class BrandingMasteryEnemyWorldScript : public WorldScript
{
public:
    BrandingMasteryEnemyWorldScript() : WorldScript("BrandingMasteryEnemyWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sMasteryEnemyMgr->LoadConfig();
    }
};

// §14.8 application: an invasion ELITE/BOSS creature's OUTGOING damage is multiplied by the bounded,
// group-size-invariant enemy mastery multiplier (boss = max mastery; elite = scaled level). This runs
// on the CREATURE-attacker branch -- the §2.1 player downscale + §7.9 player branding UnitScripts only
// touch Player attackers, so the enemy multiplier always rides ON TOP of the already §2.2-scaled
// encounter baseline (scaling-then-branding, §2.1), never before it. The magnitude is bounded to
// MaxEnemyMul inside the pure helper, so this script is a dumb applier.
class BrandingMasteryEnemyUnitScript : public UnitScript
{
public:
    BrandingMasteryEnemyUnitScript() : UnitScript("BrandingMasteryEnemyUnitScript") { }

    void ModifyMeleeDamage(Unit* /*target*/, Unit* attacker, uint32& damage) override
    {
        ApplyEnemy(attacker, damage);
    }

    void ModifyPeriodicDamageAurasTick(Unit* /*target*/, Unit* attacker, uint32& damage, SpellInfo const* /*spellInfo*/) override
    {
        ApplyEnemy(attacker, damage);
    }

    void ModifySpellDamageTaken(Unit* /*target*/, Unit* attacker, int32& damage, SpellInfo const* /*spellInfo*/) override
    {
        if (!sMasteryEnemyMgr->Enabled() || !attacker)
            return;

        if (Creature* creature = attacker->ToCreature())
            damage = static_cast<int32>(damage * sMasteryEnemyMgr->OutgoingMultiplierFor(creature));
    }

private:
    static void ApplyEnemy(Unit* attacker, uint32& damage)
    {
        if (!sMasteryEnemyMgr->Enabled() || !attacker)
            return;

        if (Creature* creature = attacker->ToCreature())
            damage = static_cast<uint32>(damage * sMasteryEnemyMgr->OutgoingMultiplierFor(creature));
    }
};

void AddBrandingMasteryEnemyScripts()
{
    new BrandingMasteryEnemyWorldScript();
    new BrandingMasteryEnemyUnitScript();
}
