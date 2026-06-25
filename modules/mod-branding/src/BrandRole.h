#ifndef MOD_BRANDING_SRC_BRANDROLE_H
#define MOD_BRANDING_SRC_BRANDROLE_H

#include "branding/common/Brand.h"

class Player;

namespace Branding
{
    // Resolve a player's effective branding role (§7.9 / §14.11 talent-spec seam): an explicit
    // per-loadout choice gated by class capability, otherwise the config-selected default policy
    // (RolePolicy.h). Shared by the §7.9 effect and §14.12 mastery-combat adapters. Live signals
    // (talents/form/presence) are sampled only on the default-policy path AND only when the active
    // policy uses them -- an explicit choice (or the class-default policy) needs no talent walk.
    RoleContribution DetectRole(Player* player);

    // Select the default-role policy from config: Branding.Effect.DefaultRolePolicy = class | talent.
    // Call on startup and on `.reload config`.
    void LoadRolePolicyConfig();
}

#endif // MOD_BRANDING_SRC_BRANDROLE_H
