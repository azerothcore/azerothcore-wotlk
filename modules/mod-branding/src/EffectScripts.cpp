#include "EffectMgr.h"
#include "mod_branding_loader.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellInfo.h"

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

// §7.9 effect application. Composes multiplicatively with §2.1 zone scaling (separate UnitScript):
// scaling reduces, branding boosts -- "scaling first, branding on top". The §7.9 caps and the windowed
// "no passive uptime" rule already live in the pure model, so this script is a dumb applier:
//   - OUTGOING damage  x OutgoingMultiplierFor       (RaidWindow/PersonalSpike during their window)
//   - INCOMING damage  x IncomingDamageMultiplierFor (tank PersonalSpike survivability spike)
//   - on heal received: branded-healer overheal -> absorb shield on the target (MechanicTransform)
class BrandingEffectUnitScript : public UnitScript
{
public:
    BrandingEffectUnitScript() : UnitScript("BrandingEffectUnitScript") { }

    void ModifyMeleeDamage(Unit* /*target*/, Unit* attacker, uint32& damage) override
    {
        ApplyOutgoing(attacker, damage);
    }

    void ModifyPeriodicDamageAurasTick(Unit* /*target*/, Unit* attacker, uint32& damage, SpellInfo const* /*spellInfo*/) override
    {
        ApplyOutgoing(attacker, damage);
    }

    void ModifySpellDamageTaken(Unit* /*target*/, Unit* attacker, int32& damage, SpellInfo const* /*spellInfo*/) override
    {
        if (!sEffectMgr->Enabled() || !attacker)
            return;

        if (Player* player = attacker->ToPlayer())
            damage = static_cast<int32>(damage * sEffectMgr->OutgoingMultiplierFor(player));
    }

    // Tank survivability: reduce INCOMING damage during the branded tank's PersonalSpike window. This
    // is the single incoming chokepoint (melee + spell), so it never double-applies with the outgoing
    // hooks, which key off the attacker.
    void OnDamage(Unit* /*attacker*/, Unit* victim, uint32& damage) override
    {
        if (!sEffectMgr->Enabled() || !victim)
            return;

        if (Player* player = victim->ToPlayer())
            damage = static_cast<uint32>(damage * sEffectMgr->IncomingDamageMultiplierFor(player));
    }

    // Healer MechanicTransform: a branded healer's wasted overheal becomes a temporary absorb on the
    // target. Fires before the heal is clamped/absorbed, so overheal is measurable vs missing health.
    void ModifyHealReceived(Unit* target, Unit* healer, uint32& heal, SpellInfo const* /*spellInfo*/) override
    {
        if (!sEffectMgr->Enabled() || !target || !healer)
            return;

        Player* healerPlayer = healer->ToPlayer();
        if (!healerPlayer)
            return;

        uint32 const shield = sEffectMgr->OverhealShieldFor(healerPlayer, target, heal);
        if (shield == 0)
            return;

        if (uint32 const spellId = sEffectMgr->OverhealShieldSpell())
            target->CastCustomSpell(spellId, SPELLVALUE_BASE_POINT0, static_cast<int32>(shield), target, TRIGGERED_FULL_MASK);
    }

private:
    static void ApplyOutgoing(Unit* attacker, uint32& damage)
    {
        if (!sEffectMgr->Enabled() || !attacker)
            return;

        if (Player* player = attacker->ToPlayer())
            damage = static_cast<uint32>(damage * sEffectMgr->OutgoingMultiplierFor(player));
    }
};

void AddBrandingEffectScripts()
{
    new BrandingEffectWorldScript();
    new BrandingEffectUnitScript();
}
