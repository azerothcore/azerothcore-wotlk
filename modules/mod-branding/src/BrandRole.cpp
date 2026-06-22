#include "BrandRole.h"
#include "Player.h"

namespace Branding
{
    RoleContribution DetectRole(Player* player)
    {
        if (!player)
            return RoleContribution::Damage;

        switch (player->getClass())
        {
            case CLASS_WARRIOR:
            case CLASS_DEATH_KNIGHT:
                return RoleContribution::Tank;     // coarse: most likely the survivability fantasy
            case CLASS_PRIEST:
            case CLASS_DRUID:
            case CLASS_PALADIN:
            case CLASS_SHAMAN:
                return RoleContribution::Healer;   // hybrid healers -> transform expression
            default:
                return RoleContribution::Damage;
        }
    }
}
