#ifndef HEARTHSTONE_MODE_H
#define HEARTHSTONE_MODE_H

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Player.h"
#include "WorldSession.h"
#include "WorldPacket.h"
#include "Chat.h"
#include "Spell.h"
#include "Define.h"
#include "GossipDef.h"
#include "Item.h"
#include "Common.h"
#include "Opcodes.h"
#include "Log.h"
#include "ObjectMgr.h"

struct HearthstoneAchievement
{
    uint32 data0;
    uint32 data1;
    uint32 creature;
    uint32 type;
};

enum bitmasksHs
{
    BITMASK_PVE = 1,
    BITMASK_PVP = 2,
    BITMASK_EXTRA = 4
};

enum miscHs
{
    PVE_QUEST_NUMBER        = 1,
    MAX_PVE_QUEST_NUMBER    = 3,
    AZTH_REPUTATION_ID      = 948,
    PVE_LOWER_RANGE         = 100000,
    PVE_UPPER_RANGE         = 100080,
    PVE_RANGE               = PVE_UPPER_RANGE - PVE_LOWER_RANGE
};

enum otherMiscHs
{
    QUALITY_TO_FILL_PERCENTAGE  = 1,
    ONLY_COMMON                 = 2,
    NOT_COMMON                  = 1,
    EVERYTHING                  = 2,
    TIME_TO_RECEIVE_MAIL        = 0,
    SUPPORTED_CRITERIA_NUMBER   = 15
};

class HearthstoneMode
{
    public:
        void AzthSendListInventory(uint64 vendorGuid, WorldSession * session, uint32 extendedCostStartValue);
        void sendQuestCredit(Player *player, AchievementCriteriaEntry const* criteria);
        int returnData0(AchievementCriteriaEntry const* criteria);
        int returnData1(AchievementCriteriaEntry const* criteria);
        std::vector<HearthstoneAchievement> hsAchievementTable;
        void getItems();
        int getQuality();
        std::vector<int> items[8]; // <---- THIS
        bool isInArray(int val);

    private:
        float CHANCES[8] = { 10.f, 30.f, 20.f, 15.f, 5.f, 1.f, 0.5f, 1.f };
};

#define sHearthstoneMode ACE_Singleton<HearthstoneMode, ACE_Null_Mutex>::instance()

#endif // !HEARTHSTONE_MODE