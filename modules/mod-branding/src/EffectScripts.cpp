#include "EffectMgr.h"
#include "mod_branding_loader.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Branding;

// Loads/refreshes effect config on startup and on `.reload config`.
class BrandingEffectWorldScript : public WorldScript
{
public:
    BrandingEffectWorldScript() : WorldScript("BrandingEffectWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sEffectMgr->LoadConfig();
    }
};

// §7.9 effect application: a branded player's OUTGOING damage is multiplied by the personal effect
// during its active window. Composes multiplicatively with §2.1 zone scaling (separate UnitScript):
// scaling reduces, branding boosts -- "scaling first, branding on top".
class BrandingEffectUnitScript : public UnitScript
{
public:
    BrandingEffectUnitScript() : UnitScript("BrandingEffectUnitScript") { }

    void ModifyMeleeDamage(Unit* /*target*/, Unit* attacker, uint32& damage) override
    {
        ApplyPersonal(attacker, damage);
    }

    void ModifyPeriodicDamageAurasTick(Unit* /*target*/, Unit* attacker, uint32& damage, SpellInfo const* /*spellInfo*/) override
    {
        ApplyPersonal(attacker, damage);
    }

    void ModifySpellDamageTaken(Unit* /*target*/, Unit* attacker, int32& damage, SpellInfo const* /*spellInfo*/) override
    {
        if (!sEffectMgr->Enabled() || !attacker)
            return;

        if (Player* player = attacker->ToPlayer())
            damage = static_cast<int32>(damage * sEffectMgr->PersonalMultiplierFor(player));
    }

private:
    static void ApplyPersonal(Unit* attacker, uint32& damage)
    {
        if (!sEffectMgr->Enabled() || !attacker)
            return;

        if (Player* player = attacker->ToPlayer())
            damage = static_cast<uint32>(damage * sEffectMgr->PersonalMultiplierFor(player));
    }
};

void AddBrandingEffectScripts()
{
    new BrandingEffectWorldScript();
    new BrandingEffectUnitScript();
}
