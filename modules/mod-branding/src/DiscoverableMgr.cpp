#include "DiscoverableMgr.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Player.h"

namespace Branding
{
    namespace
    {
        // Map a raw tier/reward-type column to the typed enums, rejecting out-of-range data.
        bool ParseTier(uint8_t raw, DiscoveryTier& out)
        {
            if (raw > static_cast<uint8_t>(DiscoveryTier::Epic))
                return false;

            out = static_cast<DiscoveryTier>(raw);
            return true;
        }

        bool ParseRewardType(uint8_t raw, DiscoveryRewardType& out)
        {
            if (raw > static_cast<uint8_t>(DiscoveryRewardType::HiddenQuest))
                return false;

            out = static_cast<DiscoveryRewardType>(raw);
            return true;
        }
    }

    DiscoverableMgr* DiscoverableMgr::instance()
    {
        static DiscoverableMgr mgr;
        return &mgr;
    }

    void DiscoverableMgr::LoadConfig()
    {
        _config.Load();
    }

    void DiscoverableMgr::LoadDiscoverables()
    {
        _objects.clear();

        if (!_config.Enabled())
            return;

        QueryResult result = WorldDatabase.Query(
            "SELECT `object_entry`, `tier`, `reward_type`, `payload_id`, `payload_amount` "
            "FROM `branding_discovery_object`");
        if (!result)
            return;

        uint32 rejected = 0;
        do
        {
            Field* fields = result->Fetch();

            DiscoverableReward def;
            def.objectEntry = fields[0].Get<uint32>();

            if (!ParseTier(fields[1].Get<uint8>(), def.tier) || !ParseRewardType(fields[2].Get<uint8>(), def.rewardType))
            {
                ++rejected;
                continue;
            }

            def.payloadId = fields[3].Get<uint32>();
            def.payloadAmount = fields[4].Get<uint32>();

            // §8.3 contract: the authored reward flavour must match its tier. Off-contract rows are
            // dropped so bad bulk content can't grant the wrong-tier reward.
            if (!RewardFitsTier(def.tier, def.rewardType))
            {
                ++rejected;
                continue;
            }

            _objects[def.objectEntry] = def;
        } while (result->NextRow());

        LOG_INFO("server.loading", "mod-branding: loaded {} discovery objects ({} rejected).",
            _objects.size(), rejected);
    }

    void DiscoverableMgr::LoadPlayer(Player* player)
    {
        if (!_config.Enabled() || !player)
            return;

        std::unordered_set<uint32_t>& seen = _seen[player->GetGUID()];
        seen.clear();

        QueryResult result = CharacterDatabase.Query(
            "SELECT `object_entry` FROM `character_branding_discovery` WHERE `guid` = {}",
            player->GetGUID().GetCounter());
        if (!result)
            return;

        do
        {
            seen.insert(result->Fetch()[0].Get<uint32>());
        } while (result->NextRow());
    }

    void DiscoverableMgr::UnloadPlayer(ObjectGuid guid)
    {
        _seen.erase(guid);
    }

    bool DiscoverableMgr::HasDiscovered(ObjectGuid guid, uint32_t objectEntry) const
    {
        auto it = _seen.find(guid);
        return it != _seen.end() && it->second.count(objectEntry) > 0;
    }

    void DiscoverableMgr::RecordDiscovery(Player* player, uint32_t objectEntry)
    {
        _seen[player->GetGUID()].insert(objectEntry);

        CharacterDatabase.Execute(
            "INSERT IGNORE INTO `character_branding_discovery` (`guid`, `object_entry`, `discovered_at`) "
            "VALUES ({}, {}, UNIX_TIMESTAMP())",
            player->GetGUID().GetCounter(), objectEntry);
    }

    ResolvedReward DiscoverableMgr::OnInteract(Player* player, uint32_t objectEntry)
    {
        if (!_config.Enabled() || !player)
            return ResolvedReward{};

        auto it = _objects.find(objectEntry);
        if (it == _objects.end())
            return ResolvedReward{};        // not a branding discoverable

        // Dedupe is enforced by the pure core; we feed it the per-character first-visit state.
        bool const already = HasDiscovered(player->GetGUID(), objectEntry);
        ResolvedReward reward = ResolveDiscoverable(it->second, already);
        if (reward.granted)
            RecordDiscovery(player, objectEntry);

        return reward;
    }
}
