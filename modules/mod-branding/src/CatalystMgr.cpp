#include "CatalystMgr.h"
#include "LoadoutMgr.h"
#include "ProficiencyMgr.h"
#include "branding/catalyst/CatalystStacking.h"
#include "branding/effects/EffectModel.h"
#include "branding/proficiency/Knowledge.h"
#include "Group.h"
#include "GroupReference.h"
#include "Player.h"
#include <algorithm>
#include <vector>

namespace Branding
{
    CatalystMgr* CatalystMgr::instance()
    {
        static CatalystMgr mgr;
        return &mgr;
    }

    void CatalystMgr::LoadConfig()
    {
        _catalyst.Load();
        _effect.Load();
    }

    namespace
    {
        // A member counts as a same-role specialist if its active brand is expressible by its
        // account. Role is Damage for all in this first cut, so "same role" = "any branded member".
        bool IsExpressibleBranded(Player* member)
        {
            if (!member)
                return false;

            BrandId const brand = sLoadoutMgr->GetLoadout(member->GetGUID()).activeBrand;
            return CanExpressBrand(brand, sProficiencyMgr->AccountKnowledge(member->GetSession()->GetAccountId()));
        }
    }

    uint8_t CatalystMgr::SameRoleBrandedRank(Player* player) const
    {
        if (!player || !IsExpressibleBranded(player))
            return 0;

        // Sampled live (Risk #4): the count reflects who is present and branded right now.
        std::vector<ObjectGuid> branded;
        if (Group const* group = player->GetGroup())
        {
            for (GroupReference const* ref = group->GetFirstMember(); ref; ref = ref->next())
                if (Player* member = ref->GetSource())
                    if (IsExpressibleBranded(member))
                        branded.push_back(member->GetGUID());
        }
        else
        {
            branded.push_back(player->GetGUID());
        }

        // Deterministic rank by GUID order so the same roster always yields the same ranks.
        std::sort(branded.begin(), branded.end());
        auto const self = std::find(branded.begin(), branded.end(), player->GetGUID());
        if (self == branded.end())
            return 0;

        return static_cast<uint8_t>((self - branded.begin()) + 1);
    }

    double CatalystMgr::RaidMultiplierFor(Player* player) const
    {
        if (!_catalyst.Enabled())
            return 1.0;

        uint8_t const rank = SameRoleBrandedRank(player);
        if (rank == 0)
            return 1.0;

        double const weight = CatalystStackWeight(rank, _catalyst);
        BrandId const brand = sLoadoutMgr->GetLoadout(player->GetGUID()).activeBrand;
        uint8_t const level = sProficiencyMgr->BrandLevel(player->GetGUID(), brand);
        EffectProfile const profile = ProfileFor(brand, RoleContribution::Damage);
        return RaidMultiplier(level, profile, weight, _effect);
    }
}
