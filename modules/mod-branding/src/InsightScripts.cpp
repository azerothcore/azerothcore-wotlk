#include "InsightMgr.h"
#include "LoadoutMgr.h"
#include "mod_branding_loader.h"
#include "branding/common/Brand.h"
#include "branding/insight/Insight.h"
#include "Creature.h"
#include "Map.h"
#include "Player.h"
#include "Random.h"
#include "ScriptMgr.h"

using namespace Branding;

namespace
{
    // Maps a killed creature to its Insight source rank (design §14.13.1). World/raid bosses are the
    // backbone (RaidBoss, no intra-week DR -- the lockout throttles). Dungeon bosses are farmable and
    // DR'd, heroic above normal. Everything else is a generic trash "mote".
    SourceRank RankOf(Creature const* killed)
    {
        if (!killed)
            return SourceRank::TrashMote;

        Map const* map = killed->GetMap();
        bool const heroic = map && map->IsHeroic();

        // Raid bosses (open-world or raid-instance) are the weekly-locked backbone.
        if (killed->isWorldBoss() || (map && map->IsRaid() && killed->IsDungeonBoss()))
            return SourceRank::RaidBoss;

        // Dungeon bosses: farmable, so DR is essential. Heroic yields more than normal.
        if (map && map->IsDungeon() && killed->IsDungeonBoss())
            return heroic ? SourceRank::DungeonBossHeroic : SourceRank::DungeonBossNormal;

        return SourceRank::TrashMote;
    }
}

// Loads/refreshes the Insight config on startup and on `.reload config`.
class BrandingInsightWorldScript : public WorldScript
{
public:
    BrandingInsightWorldScript() : WorldScript("BrandingInsightWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sInsightMgr->LoadConfig();
    }
};

// Account lifecycle + the kill faucet (design §14.13.1). On a kill, the source rank picks the
// Insight amount and the trash mote is gated by a VERY low per-kill chance. School resolution is a
// config-mappable seam: v1 feeds the player's active loadout school (the wildcard pool) -- the full
// boss->school DATA table is DEFERRED (see issue #18 / §14.13.1).
class BrandingInsightPlayerScript : public PlayerScript
{
public:
    BrandingInsightPlayerScript() : PlayerScript("BrandingInsightPlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        if (player && sInsightMgr->Enabled())
            sInsightMgr->LoadAccount(player->GetSession()->GetAccountId());
    }

    void OnPlayerLogout(Player* player) override
    {
        // The account may be shared by other logged-in characters; only drop the cache when no other
        // session would need it. Keeping it cached is harmless (it reloads on demand), so simply
        // unload on logout -- a re-login reloads from the DB.
        if (player)
            sInsightMgr->UnloadAccount(player->GetSession()->GetAccountId());
    }

    void OnPlayerCreatureKill(Player* killer, Creature* killed) override
    {
        if (!killer || !sInsightMgr->Enabled())
            return;

        SourceRank const rank = RankOf(killed);

        // Trash motes are the only viable source for the exotic schools but must stay a trickle: gate
        // them behind a low per-kill chance. Boss kills always award.
        if (rank == SourceRank::TrashMote && !roll_chance_f(static_cast<float>(sInsightMgr->Config().MoteChance() * 100.0)))
            return;

        // School = the player's active loadout brand (the §14.13.1 "currently-selected school /
        // wildcard pool"). DEFERRED: a per-boss school DATA table would override this for themed bosses.
        BrandId const school = sLoadoutMgr->GetLoadout(killer->GetGUID()).activeBrand;

        sInsightMgr->Earn(killer->GetSession()->GetAccountId(), school, rank);
    }
};

void AddBrandingInsightScripts()
{
    new BrandingInsightWorldScript();
    new BrandingInsightPlayerScript();
}
