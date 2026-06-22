#ifndef MOD_BRANDING_SRC_BRANDROLE_H
#define MOD_BRANDING_SRC_BRANDROLE_H

#include "branding/common/Brand.h"

class Player;

namespace Branding
{
    // Coarse role lens for the §7.9 personal/raid asymmetry: tanks get the dramatic personal spike,
    // dps the restrained raid window, hybrid healers the structural transform. Shared by the
    // mastery-combat (§14.12) and §7.9 effect adapters so the heuristic stays in one place. The proper
    // per-spec role detection is the §14.11 talent-spec seam (deferred); defaults to Damage when unsure.
    RoleContribution DetectRole(Player* player);
}

#endif // MOD_BRANDING_SRC_BRANDROLE_H
