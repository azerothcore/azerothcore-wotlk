#include "ScalingMgr.h"
#include "mod_branding_loader.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Branding;

// Loads/refreshes scaling config on startup and on `.reload config`.
class BrandingScalingWorldScript : public WorldScript
{
public:
    BrandingScalingWorldScript() : WorldScript("BrandingScalingWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sScalingMgr->LoadConfig();
    }
};

// §2.1 downward scaling: an over-leveled player's OUTGOING damage is scaled down so old content
// stays dangerous. (Incoming-damage and healing scaling are deliberate future extensions.)
class BrandingScalingUnitScript : public UnitScript
{
public:
    BrandingScalingUnitScript() : UnitScript("BrandingScalingUnitScript") { }

    void ModifyMeleeDamage(Unit* /*target*/, Unit* attacker, uint32& damage) override
    {
        ScaleOutgoing(attacker, damage);
    }

    void ModifyPeriodicDamageAurasTick(Unit* /*target*/, Unit* attacker, uint32& damage, SpellInfo const* /*spellInfo*/) override
    {
        ScaleOutgoing(attacker, damage);
    }

    void ModifySpellDamageTaken(Unit* /*target*/, Unit* attacker, int32& damage, SpellInfo const* /*spellInfo*/) override
    {
        if (!sScalingMgr->Enabled() || !attacker)
            return;

        if (Player* player = attacker->ToPlayer())
            damage = static_cast<int32>(damage * sScalingMgr->PlayerOutgoingFactor(player));
    }

private:
    static void ScaleOutgoing(Unit* attacker, uint32& damage)
    {
        if (!sScalingMgr->Enabled() || !attacker)
            return;

        if (Player* player = attacker->ToPlayer())
            damage = static_cast<uint32>(damage * sScalingMgr->PlayerOutgoingFactor(player));
    }
};

void AddBrandingScalingScripts()
{
    new BrandingScalingWorldScript();
    new BrandingScalingUnitScript();
}
