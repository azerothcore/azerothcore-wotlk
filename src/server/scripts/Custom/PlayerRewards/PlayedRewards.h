/*
    Written by Alistar@AC-WEB
    Discord: Alistar#2047
*/

#ifndef _PLAYEDREWARDS_H_
#define _PLAYEDREWARDS_H_

#include "Player.h"
#include "DBCStores.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Util.h"
#include "World.h"
#include "Chat.h"
#include "ObjectMgr.h"
#include "WorldSession.h"

enum class RewardType : uint8
{
    GOLD = 0,
    ITEM,
    TITLE,
    ACHIEVEMENT,
    EXP,
    LEVEL,
    HONOR_POINTS,
    ARENA_POINTS,
    VOTE_POINTS,
    DONATION_POINTS
};

const std::unordered_map<RewardType, std::string_view> RewardTypeToStr =
{
    {RewardType::GOLD,            "Gold"},
    {RewardType::TITLE,           "Title"},
    {RewardType::ACHIEVEMENT,     "Achievement"},
    {RewardType::EXP,             "Experience"},
    {RewardType::LEVEL,           "Level"},
    {RewardType::ITEM,            "Item"},
    {RewardType::HONOR_POINTS,    "Honor points"},
    {RewardType::ARENA_POINTS,    "Arena points"},
    {RewardType::VOTE_POINTS,     "Vote points"},
    {RewardType::DONATION_POINTS, "Donation points"}
};

struct RewardData
{
    RewardData() = delete;
    RewardData(const std::string_view t_PlayedTimeStr,
               const uint32 t_PlayedTime,
               const RewardType t_Type,
               const uint32 t_Amount,
               const std::unordered_map<uint32, uint32>& t_Id = {})
        : playedTimeStr(t_PlayedTimeStr), playedTime(t_PlayedTime), type(t_Type), amount(t_Amount), items(t_Id) { }

    std::string playedTimeStr;
    uint32 playedTime;
    RewardType type;
    uint32 amount;
    std::unordered_map<uint32, uint32> items;
};

class PlayedRewards
{
public:
    typedef std::unordered_multimap<uint32, RewardData> RewardMap;
    typedef std::unordered_map<uint64, std::unordered_set<uint32>> RewardedMap;

    static PlayedRewards* instance();

    const uint32 PLAYED_UPDATE_TIME = 1 * IN_MILLISECONDS; // 1 second(s)
    LocaleConstant SERVER_LOCALE = LOCALE_ruRU;

    void LoadConfig();
    void LoadFromDB();

    bool IsEnabled() const;

    bool IsEligible(Player* player, const uint32 playTime, const uint32 rewardId);
    void AnnounceReward(Player* player, const std::string_view str, const std::string_view playedTime);
    void ConcatRewardMsg(Player* player, const RewardData& data,
        std::string& message,
        const ItemTemplate* item = nullptr,
        const CharTitlesEntry* const title = nullptr,
        const AchievementEntry* const achiv = nullptr);

    void SendReward(Player* player);

    void SendWebReward(Player* player, const RewardType type, const uint32 amount);

    void LoadRewardedMap(Player* player);
    void SaveRewardedMap(Player* player);

private:
    bool m_IsEnabled;
    std::array<std::string, 5> m_SiteData;

    RewardMap m_RewardMap;
    RewardedMap m_RewardedMap;
};

#define sPlayedRewards PlayedRewards::instance()

#endif // _PLAYEDREWARDS_H_
