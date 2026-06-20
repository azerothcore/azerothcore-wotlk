#ifndef MOD_BRANDING_CORE_CONTRIBUTION_CONTRIBUTIONTYPES_H
#define MOD_BRANDING_CORE_CONTRIBUTION_CONTRIBUTIONTYPES_H

#include <array>
#include <cstddef>
#include <cstdint>

namespace Branding
{
    // Zone-hosted public event categories (§9.1).
    enum class EventType : uint8_t
    {
        Invasion = 0,
        ResourceSurge,
        EliteHunt,
        ProfessionAnomaly,
        COUNT
    };

    // Scored actions, not quest objectives (§9.2).
    enum class EventAction : uint8_t
    {
        InvadingKill = 0,
        EliteKill,
        MiniBoss,
        Heal,
        GatherResource,
        CraftItem,
        DiscoverObjective,
        COUNT
    };

    // Reward tier reached for an event (§9.4).
    enum class RewardTier : uint8_t
    {
        None = 0,
        Bronze,
        Silver,
        Gold
    };

    // Anti-leech heuristics captured by the adapter (§9.3): a player below the floors scores 0.
    struct ActivitySignal
    {
        uint32_t damageDealt = 0;
        uint32_t actions = 0;
        uint32_t movement = 0;
    };

    // Per-character pacing state (§9.3). The account-wide economy ceiling is separate (Pass B).
    struct ParticipationState
    {
        uint32_t pointsThisHour = 0;
        uint64_t hourWindowStart = 0;                                            // 0 = no window yet
        std::array<uint32_t, static_cast<size_t>(EventType::COUNT)> dailyCount{}; // per-type DR counter
        uint64_t dayStart = 0;
    };
}

#endif // MOD_BRANDING_CORE_CONTRIBUTION_CONTRIBUTIONTYPES_H
