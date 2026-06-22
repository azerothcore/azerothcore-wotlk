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

    double InvasionScalingMgr::OutgoingMultiplierFor(Creature* attacker) const
    {
        if (!Enabled() || !attacker)
            return 1.0;

        if (!InActiveInvasion(attacker))
            return 1.0;

        uint32_t const headcount = sEventMgr->EffectiveHeadcount(attacker->GetZoneId());

        // Boss / mini-boss (worldboss or elite): full §2.2 curve -- softer for a small crowd, rising
        // to the authored difficulty at the intended size. Trash: the gentle invasion curve.
        double mul;
        if (attacker->isWorldBoss() || attacker->isElite())
        {
            GroupContext const group{
                static_cast<uint8_t>(std::min<uint32_t>(headcount, _invConfig.IntendedInvasionSize())),
                _invConfig.IntendedInvasionSize()};
            mul = EncounterDamageMul(group, _scaling);
        }
        else
            mul = InvasionTrashMul(headcount, _invConfig);

        LOG_DEBUG("module.branding", "InvasionScalingMgr: x{:.3f} on {} (headcount {}, {})",
            mul, attacker->GetGUID().ToString(), headcount,
            (attacker->isWorldBoss() || attacker->isElite()) ? "boss" : "trash");

        return mul;
    }
}
