#include "Contribution.h"
#include <algorithm>
#include <cmath>

namespace Branding
{
    uint32_t ScoreAction(EventAction action, uint32_t magnitude, IContributionConfig const& cfg)
    {
        if (action == EventAction::Heal)
        {
            uint32_t const units = cfg.HealUnitsPerPoint();
            uint32_t const extra = units == 0 ? 0 : magnitude / units;
            return std::min(1u + extra, cfg.HealMaxPoints());
        }

        return cfg.ActionBasePoints(action);
    }

    namespace
    {
        // A player below BOTH the damage and action floors did not meaningfully participate (§9.3).
        // Damage OR actions clears the gate, so low-damage controllers/healers still count.
        bool IsLeech(ActivitySignal const& signal, IContributionConfig const& cfg)
        {
            return signal.damageDealt < cfg.LeechDamageFloor() && signal.actions < cfg.LeechActionFloor();
        }

        bool WindowElapsed(uint64_t now, uint64_t start, uint64_t window)
        {
            return start == 0 || (now >= start && now - start >= window);
        }
    }

    uint32_t ApplyEventAction(ParticipationState& state, EventType type, EventAction action,
        uint32_t magnitude, ActivitySignal const& signal, IContributionConfig const& cfg, IClock const& clock)
    {
        uint64_t const now = clock.NowUnix();

        // Roll the rolling-hour and daily windows forward when they elapse.
        if (WindowElapsed(now, state.hourWindowStart, cfg.HourWindowSeconds()))
        {
            state.pointsThisHour = 0;
            state.hourWindowStart = now;
        }
        if (WindowElapsed(now, state.dayStart, cfg.DayWindowSeconds()))
        {
            state.dailyCount.fill(0);
            state.dayStart = now;
        }

        // Guardrail 1 -- anti-leech: no own activity, no points, no state change.
        if (IsLeech(signal, cfg))
            return 0;

        uint32_t const base = ScoreAction(action, magnitude, cfg);

        // Guardrail 2 -- daily diminishing returns per event type.
        uint32_t const count = state.dailyCount[static_cast<size_t>(type)];
        double const drMul = std::max(cfg.EventDrFloor(), 1.0 - static_cast<double>(count) * cfg.EventDrSlope());
        uint32_t const scored = static_cast<uint32_t>(std::llround(static_cast<double>(base) * drMul));

        // Guardrail 3 -- hourly cap.
        uint32_t const remaining = state.pointsThisHour >= cfg.HourlyCap() ? 0 : cfg.HourlyCap() - state.pointsThisHour;
        uint32_t const granted = std::min(scored, remaining);

        state.pointsThisHour += granted;
        state.dailyCount[static_cast<size_t>(type)] = count + 1;
        return granted;
    }
}
