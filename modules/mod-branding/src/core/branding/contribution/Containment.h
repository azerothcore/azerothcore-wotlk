#ifndef MOD_BRANDING_CORE_CONTRIBUTION_CONTAINMENT_H
#define MOD_BRANDING_CORE_CONTRIBUTION_CONTAINMENT_H

#include <cstdint>

namespace Branding
{
    // §9.6: region containment as a pure aggregation of contributed progress vs the event goal.
    // Returns a fraction in [0, 1]; monotonic non-decreasing in `contributed`, saturating at 1.0.
    // (The server broadcasts this number; the client renders "Fel Incursion: 62% contained".)
    double Containment(uint64_t contributed, uint64_t goal);
}

#endif // MOD_BRANDING_CORE_CONTRIBUTION_CONTAINMENT_H
