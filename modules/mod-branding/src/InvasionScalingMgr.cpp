#include "InvasionScalingMgr.h"
#include "EventMgr.h"
#include "branding/contribution/ContributionTypes.h"
#include "branding/scaling/GroupScaling.h"
#include "branding/scaling/InvasionScaling.h"
#include "Creature.h"
#include "Log.h"
#include <algorithm>

namespace Branding
{
    InvasionScalingMgr* InvasionScalingMgr::instance()
    {
        static InvasionScalingMgr mgr;
        return &mgr;
    }

    void InvasionScalingMgr::LoadConfig()
    {
        _scaling.Load();
        _invConfig.Load();
    }

    bool InvasionScalingMgr::InActiveInvasion(Creature const* creature)
    {
        EventType type = EventType::Invasion;
        if (!sEventMgr->ActiveEventType(creature->GetZoneId(), type))
            return false;

        return type == EventType::Invasion;
    }

    bool InvasionScalingMgr::ResolveCrowd(Creature* creature, uint32_t& headcount, bool& isBoss) const
    {
        if (!Enabled() || !creature)
            return false;

        if (!InActiveInvasion(creature))
            return false;

        headcount = sEventMgr->EffectiveHeadcount(creature->GetZoneId());
        isBoss = creature->isWorldBoss() || creature->isElite();
        return true;
    }

    double InvasionScalingMgr::OutgoingMultiplierFor(Creature* attacker) const
    {
        uint32_t headcount = 0;
        bool isBoss = false;
        if (!ResolveCrowd(attacker, headcount, isBoss))
            return 1.0;

        // Boss / mini-boss: full §2.2 curve -- softer for a small crowd, rising to the authored
        // difficulty at the intended size. Trash: the gentle invasion curve.
        double const mul = isBoss
            ? EncounterDamageMul(GroupContext{
                  static_cast<uint8_t>(std::min<uint32_t>(headcount, _invConfig.IntendedInvasionSize())),
                  _invConfig.IntendedInvasionSize()}, _scaling)
            : InvasionTrashMul(headcount, _invConfig);

        LOG_DEBUG("module.branding", "InvasionScalingMgr: dmg x{:.3f} on {} (headcount {}, {})",
            mul, attacker->GetGUID().ToString(), headcount, isBoss ? "boss" : "trash");

        return mul;
    }

    void InvasionScalingMgr::ApplyHealth(Creature* creature) const
    {
        uint32_t headcount = 0;
        bool isBoss = false;
        if (!ResolveCrowd(creature, headcount, isBoss))
            return;     // not an invasion creature -> never touch its health

        double const mul = isBoss
            ? EncounterHealthMul(GroupContext{
                  static_cast<uint8_t>(std::min<uint32_t>(headcount, _invConfig.IntendedInvasionSize())),
                  _invConfig.IntendedInvasionSize()}, _scaling)
            : InvasionTrashMul(headcount, _invConfig);

        uint32 const base = creature->GetCreateHealth();
        if (base == 0)
            return;

        uint32 const target = std::max<uint32>(1, static_cast<uint32>(base * mul));
        if (creature->GetMaxHealth() == target)
            return;     // already at the right pool -- avoids redundant field updates

        float const pct = creature->GetHealthPct();
        creature->SetMaxHealth(target);
        creature->SetHealth(static_cast<uint32>(target * pct / 100.0f));
    }
}
