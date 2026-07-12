#include "ScalingMgr.h"
#include "mod_branding_loader.h"
#include "LootMgr.h"
#include "Map.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Branding;

// §2.7 branding-rank drop bonus (issue #81): instanced (dungeon/raid) creature drop rate scales with
// the highest branding rank in the looter's party, so farming ranks pays off and a high-rank member
// is worth bringing. Multiplies the engine's per-item roll chance; it is a pure bonus, never a nerf.
class BrandingDropRateGlobalScript : public GlobalScript
{
public:
    BrandingDropRateGlobalScript() : GlobalScript("BrandingDropRateGlobalScript") { }

    bool OnItemRoll(Player const* player, LootStoreItem const* /*lootStoreItem*/, float& chance,
        Loot& /*loot*/, LootStore const& store) override
    {
        if (!player || !sScalingMgr->RankDropBonusEnabled())
            return true;

        // Only instanced content (5-man dungeons + raids) -- IsDungeon() is false in the open world,
        // so world / gathering / quest loot is untouched (issue #81: "dungeon and raid drop rate").
        Map const* map = player->GetMap();
        if (!map || !map->IsDungeon())
            return true;

        // Only creature/boss drops, not skinning/GO/disenchant/etc. tables.
        if (&store != &LootTemplates_Creature)
            return true;

        chance *= static_cast<float>(sScalingMgr->RankLootMultiplier(player));
        return true;
    }
};

void AddBrandingDropRateScripts()
{
    new BrandingDropRateGlobalScript();
}
