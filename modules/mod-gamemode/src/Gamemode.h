#pragma once

#include "Player.h"
#include "World.h"
#include "WorldSession.h"
#include "Map.h"
#include "DBCStores.h"
#include "DBCStore.h"
#include "Creature.h"
#include "ObjectMgr.h"
#include "Log.h"
#include "CreatureAI.h"
#include "GameObject.h"
#include "TemporarySummon.h"
#include "Unit.h"
#include "MotionMaster.h"
#include "SmartAI.h"
#include "SmartScript.h"

enum class GameModeType
{
    HARDCORE = 1910003,
    CLASSIC = 1910001,
    IRON_MAN = 1910000,
    BLOOD_THIRSTY = 1910002,
    INSANE = 1910004,
    ALL = 0
};

enum class GameModeRewardType
{
    Mount = 0,
    Title = 1,
    Item = 2
};

struct GameModeReward
{
    GameModeRewardType RewardType;
    uint32 Entry;
};

class Gamemode {
public:
    static std::vector<GameModeType> GameModeTypes;
    static std::unordered_map<GameModeType, std::vector<GameModeReward*>> Rewards;
    static std::unordered_map<uint32 /*guid*/, std::vector<GameModeType> /*level*/> PlayersMode;
    static void PreloadAllModesPlayers();
    static void SetGameMode(Player* player, std::vector<GameModeType> gamemodeIds);
    static void OnDeath(Player* player, Creature* killer);
    static void RemoveGamemode(Player* player, bool remove);
    static bool CanAddGroupPlayer(Player* player, Player* invitingPlayer);
    static bool CanSendMail(Player* receveirGuid);
    static bool CanSendMail(uint32 receveirGuid);
    static void OnLevelUp(Player* player);
    static void IssueRewards(Player* player, GameModeType mode);
    static void AddModeName(const GameModeType& modeId, std::string& mode);
    static bool CanJoinRDF(Player* player);
    static bool CanTrade(Player* player);
    static bool CanAddQuest(Player* guid);
    static bool HasGameMode(Player* player, GameModeType gamemodeId);
    static bool HasGameMode(uint32 player, GameModeType gamemodeId);
    static std::vector<GameModeType> GetGameMode(Player* guid);
    static std::vector<GameModeType> GetGameMode(uint32 guid);
};
