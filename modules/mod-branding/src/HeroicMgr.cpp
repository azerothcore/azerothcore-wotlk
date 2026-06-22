#include "HeroicMgr.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "Field.h"
#include "Group.h"
#include "Log.h"
#include "Map.h"
#include "Player.h"
#include "QueryResult.h"

namespace Branding
{
    HeroicMgr* HeroicMgr::instance()
    {
        static HeroicMgr mgr;
        return &mgr;
    }

    void HeroicMgr::LoadConfig()
    {
        _config.Load();
    }

    void HeroicMgr::LoadExceptions()
    {
        // Advisory only (§2.4.6): recommended group size for body-count-dependent encounters. Never
        // gates entry or disables the overlay -- the group's call to bring a larger raid.
        _exceptions.clear();

        QueryResult result = WorldDatabase.Query(
            "SELECT `map_id`, `boss_entry`, `recommended_min_bodies`, `note` FROM `branding_heroic_exception`");
        if (!result)
        {
            LOG_INFO("module.branding", "Branding: no `branding_heroic_exception` rows (heroic advisories empty).");
            return;
        }

        do
        {
            Field* fields = result->Fetch();
            uint32_t const mapId = fields[0].Get<uint32>();
            uint32_t const bossEntry = fields[1].Get<uint32>();
            Advice advice;
            advice.minBodies = fields[2].Get<uint8>();
            advice.note = fields[3].Get<std::string>();
            _exceptions[Key(mapId, bossEntry)] = std::move(advice);
        } while (result->NextRow());

        LOG_INFO("module.branding", "Branding: loaded {} heroic advisory row(s).", _exceptions.size());
    }

    bool HeroicMgr::HasNativeHeroic(Map* map)
    {
        Difficulty const heroicDiff = map->IsRaid() ? RAID_DIFFICULTY_10MAN_HEROIC : DUNGEON_DIFFICULTY_HEROIC;
        return GetMapDifficultyData(map->GetId(), heroicDiff) != nullptr;
    }

    SelectedDifficulty HeroicMgr::ResolveSelected(Player* player, bool isRaid)
    {
        if (!player)
            return SelectedDifficulty::Normal;

        Difficulty diff;
        if (Group* group = player->GetGroup())
        {
            diff = group->GetDifficulty(isRaid);
        }
        else
        {
            diff = isRaid ? player->GetRaidDifficulty() : player->GetDungeonDifficulty();
        }

        bool const heroic = isRaid ? diff >= RAID_DIFFICULTY_10MAN_HEROIC : diff >= DUNGEON_DIFFICULTY_HEROIC;
        return heroic ? SelectedDifficulty::Heroic : SelectedDifficulty::Normal;
    }

    HeroicContext HeroicMgr::Resolve(Map* map) const
    {
        HeroicContext ctx;
        ctx.maxLevel = _config.LevelCap();
        ctx.nativeHeroicMap = HasNativeHeroic(map);

        // Representative player on the map -- the selection is group-wide, so any member resolves it.
        Player* ref = nullptr;
        for (auto const& it : map->GetPlayers())
        {
            if (Player* candidate = it.GetSource())
            {
                ref = candidate;
                break;
            }
        }

        ctx.selected = ResolveSelected(ref, map->IsRaid());
        return ctx;
    }

    void HeroicMgr::OnPlayerEnterInstance(Map* map, Player* player)
    {
        if (!Enabled() || !map || !map->IsDungeon())
            return;

        HeroicContext ctx;
        ctx.maxLevel = _config.LevelCap();
        ctx.nativeHeroicMap = HasNativeHeroic(map);
        ctx.selected = ResolveSelected(player, map->IsRaid());
        _byInstance[map->GetInstanceId()] = ctx;
    }

    HeroicContext HeroicMgr::ContextFor(Map* map)
    {
        if (!Enabled() || !map || !map->IsDungeon())
            return HeroicContext{};

        auto const it = _byInstance.find(map->GetInstanceId());
        if (it != _byInstance.end())
            return it->second;

        HeroicContext ctx = Resolve(map);
        _byInstance[map->GetInstanceId()] = ctx;
        return ctx;
    }

    bool HeroicMgr::LevelTargetFor(Map* map, uint8_t& outTarget)
    {
        HeroicContext const ctx = ContextFor(map);
        outTarget = HeroicLevelTarget(ctx, _config);
        return HeroicOverlayEngages(ctx);
    }

    double HeroicMgr::HealthMulFor(Map* map)
    {
        return HeroicHealthMul(ContextFor(map), _config);
    }

    double HeroicMgr::DamageMulFor(Map* map)
    {
        return HeroicDamageMul(ContextFor(map), _config);
    }

    uint8_t HeroicMgr::TierBonusFor(Map* map)
    {
        return HeroicTierBonus(ContextFor(map), _config);
    }

    uint8_t HeroicMgr::RecommendedMinBodies(uint32_t mapId, uint32_t bossEntry) const
    {
        if (auto const it = _exceptions.find(Key(mapId, bossEntry)); it != _exceptions.end())
            return it->second.minBodies;
        if (auto const it = _exceptions.find(Key(mapId, 0)); it != _exceptions.end())
            return it->second.minBodies;
        return 0;
    }

    std::string HeroicMgr::ExceptionNote(uint32_t mapId, uint32_t bossEntry) const
    {
        if (auto const it = _exceptions.find(Key(mapId, bossEntry)); it != _exceptions.end())
            return it->second.note;
        if (auto const it = _exceptions.find(Key(mapId, 0)); it != _exceptions.end())
            return it->second.note;
        return {};
    }
}
