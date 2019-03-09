/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef __BATTLEGROUNDAB_H
#define __BATTLEGROUNDAB_H

#include "Battleground.h"

enum BG_AB_Events
{
    BG_AB_EVENT_UPDATE_BANNER_STABLE        = 1,
    BG_AB_EVENT_UPDATE_BANNER_FARM          = 2,
    BG_AB_EVENT_UPDATE_BANNER_BLACKSMITH    = 3,
    BG_AB_EVENT_UPDATE_BANNER_LUMBERMILL    = 4,
    BG_AB_EVENT_UPDATE_BANNER_GOLDMINE      = 5,

    BG_AB_EVENT_CAPTURE_STABLE              = 6,
    BG_AB_EVENT_CAPTURE_FARM                = 7,
    BG_AB_EVENT_CAPTURE_BLACKSMITH          = 8,
    BG_AB_EVENT_CAPTURE_LUMBERMILL          = 9,
    BG_AB_EVENT_CAPTURE_GOLDMINE            = 10,

    BG_AB_EVENT_ALLIANCE_TICK               = 11,
    BG_AB_EVENT_HORDE_TICK                  = 12
};

enum BG_AB_WorldStates
{
    BG_AB_OP_OCCUPIED_BASES_HORDE       = 1778,
    BG_AB_OP_OCCUPIED_BASES_ALLY        = 1779,
    BG_AB_OP_RESOURCES_ALLY             = 1776,
    BG_AB_OP_RESOURCES_HORDE            = 1777,
    BG_AB_OP_RESOURCES_MAX              = 1780,
    BG_AB_OP_RESOURCES_WARNING          = 1955,

    BG_AB_OP_STABLE_ICON                = 1842,             //Stable map icon (NONE)
    BG_AB_OP_STABLE_STATE_ALIENCE       = 1767,             //Stable map state (ALIENCE)
    BG_AB_OP_STABLE_STATE_HORDE         = 1768,             //Stable map state (HORDE)
    BG_AB_OP_STABLE_STATE_CON_ALI       = 1769,             //Stable map state (CON ALIENCE)
    BG_AB_OP_STABLE_STATE_CON_HOR       = 1770,             //Stable map state (CON HORDE)

    BG_AB_OP_FARM_ICON                  = 1845,             //Farm map icon (NONE)
    BG_AB_OP_FARM_STATE_ALIENCE         = 1772,             //Farm state (ALIENCE)
    BG_AB_OP_FARM_STATE_HORDE           = 1773,             //Farm state (HORDE)
    BG_AB_OP_FARM_STATE_CON_ALI         = 1774,             //Farm state (CON ALIENCE)
    BG_AB_OP_FARM_STATE_CON_HOR         = 1775,             //Farm state (CON HORDE)

    BG_AB_OP_BLACKSMITH_ICON            = 1846,             //Blacksmith map icon (NONE)
    BG_AB_OP_BLACKSMITH_STATE_ALIENCE   = 1782,             //Blacksmith map state (ALIENCE)
    BG_AB_OP_BLACKSMITH_STATE_HORDE     = 1783,             //Blacksmith map state (HORDE)
    BG_AB_OP_BLACKSMITH_STATE_CON_ALI   = 1784,             //Blacksmith map state (CON ALIENCE)
    BG_AB_OP_BLACKSMITH_STATE_CON_HOR   = 1785,             //Blacksmith map state (CON HORDE)

    BG_AB_OP_LUMBERMILL_ICON            = 1844,             //Lumber Mill map icon (NONE)
    BG_AB_OP_LUMBERMILL_STATE_ALIENCE   = 1792,             //Lumber Mill map state (ALIENCE)
    BG_AB_OP_LUMBERMILL_STATE_HORDE     = 1793,             //Lumber Mill map state (HORDE)
    BG_AB_OP_LUMBERMILL_STATE_CON_ALI   = 1794,             //Lumber Mill map state (CON ALIENCE)
    BG_AB_OP_LUMBERMILL_STATE_CON_HOR   = 1795,             //Lumber Mill map state (CON HORDE)

    BG_AB_OP_GOLDMINE_ICON              = 1843,             //Gold Mine map icon (NONE)
    BG_AB_OP_GOLDMINE_STATE_ALIENCE     = 1787,             //Gold Mine map state (ALIENCE)
    BG_AB_OP_GOLDMINE_STATE_HORDE       = 1788,             //Gold Mine map state (HORDE)
    BG_AB_OP_GOLDMINE_STATE_CON_ALI     = 1789,             //Gold Mine map state (CON ALIENCE
    BG_AB_OP_GOLDMINE_STATE_CON_HOR     = 1790,             //Gold Mine map state (CON HORDE)
};

enum BG_AB_ObjectIds
{
    BG_AB_OBJECTID_NODE_BANNER_0        = 180087,       // Stables banner
    BG_AB_OBJECTID_NODE_BANNER_1        = 180088,       // Blacksmith banner
    BG_AB_OBJECTID_NODE_BANNER_2        = 180089,       // Farm banner
    BG_AB_OBJECTID_NODE_BANNER_3        = 180090,       // Lumber mill banner
    BG_AB_OBJECTID_NODE_BANNER_4        = 180091,       // Gold mine banner

    BG_AB_OBJECTID_BANNER_A             = 180058,
    BG_AB_OBJECTID_BANNER_CONT_A        = 180059,
    BG_AB_OBJECTID_BANNER_H             = 180060,
    BG_AB_OBJECTID_BANNER_CONT_H        = 180061,

    BG_AB_OBJECTID_AURA_A               = 180100,
    BG_AB_OBJECTID_AURA_H               = 180101,
    BG_AB_OBJECTID_AURA_C               = 180102,

    BG_AB_OBJECTID_GATE_A               = 180255,
    BG_AB_OBJECTID_GATE_H               = 180256
};

enum BG_AB_ObjectType
{
    BG_AB_OBJECT_BANNER_NEUTRAL          = 0,
    BG_AB_OBJECT_BANNER_ALLY             = 1,
    BG_AB_OBJECT_BANNER_HORDE            = 2,
    BG_AB_OBJECT_BANNER_CONT_A           = 3,
    BG_AB_OBJECT_BANNER_CONT_H           = 4,
    BG_AB_OBJECT_AURA_ALLY               = 5,
    BG_AB_OBJECT_AURA_HORDE              = 6,
    BG_AB_OBJECT_AURA_CONTESTED          = 7,
    BG_AB_OBJECTS_PER_NODE               = 8,

    BG_AB_OBJECT_GATE_A                  = 40,
    BG_AB_OBJECT_GATE_H                  = 41,

    BG_AB_OBJECT_SPEEDBUFF_STABLES       = 42,
    BG_AB_OBJECT_REGENBUFF_STABLES       = 43,
    BG_AB_OBJECT_BERSERKBUFF_STABLES     = 44,
    BG_AB_OBJECT_SPEEDBUFF_BLACKSMITH    = 45,
    BG_AB_OBJECT_REGENBUFF_BLACKSMITH    = 46,
    BG_AB_OBJECT_BERSERKBUFF_BLACKSMITH  = 47,
    BG_AB_OBJECT_SPEEDBUFF_FARM          = 48,
    BG_AB_OBJECT_REGENBUFF_FARM          = 49,
    BG_AB_OBJECT_BERSERKBUFF_FARM        = 50,
    BG_AB_OBJECT_SPEEDBUFF_LUMBER_MILL   = 51,
    BG_AB_OBJECT_REGENBUFF_LUMBER_MILL   = 52,
    BG_AB_OBJECT_BERSERKBUFF_LUMBER_MILL = 53,
    BG_AB_OBJECT_SPEEDBUFF_GOLD_MINE     = 54,
    BG_AB_OBJECT_REGENBUFF_GOLD_MINE     = 55,
    BG_AB_OBJECT_BERSERKBUFF_GOLD_MINE   = 56,
    BG_AB_OBJECT_MAX                     = 57,
};

enum BG_AB_BattlegroundNodes
{
    BG_AB_NODE_STABLES          = 0,
    BG_AB_NODE_BLACKSMITH       = 1,
    BG_AB_NODE_FARM             = 2,
    BG_AB_NODE_LUMBER_MILL      = 3,
    BG_AB_NODE_GOLD_MINE        = 4,
    BG_AB_DYNAMIC_NODES_COUNT   = 5,                        // dynamic nodes that can be captured

    BG_AB_SPIRIT_ALIANCE        = 5,
    BG_AB_SPIRIT_HORDE          = 6,
    BG_AB_ALL_NODES_COUNT       = 7,                        // all nodes (dynamic and static)
};

enum BG_AB_NodeStatus
{
    BG_AB_NODE_STATE_NEUTRAL            = 0,
    BG_AB_NODE_STATE_ALLY_OCCUPIED      = 1,
    BG_AB_NODE_STATE_HORDE_OCCUPIED     = 2,
    BG_AB_NODE_STATE_ALLY_CONTESTED     = 3,
    BG_AB_NODE_STATE_HORDE_CONTESTED    = 4
};

enum BG_AB_Sounds
{
    BG_AB_SOUND_NODE_CLAIMED            = 8192,
    BG_AB_SOUND_NODE_CAPTURED_ALLIANCE  = 8173,
    BG_AB_SOUND_NODE_CAPTURED_HORDE     = 8213,
    BG_AB_SOUND_NODE_ASSAULTED_ALLIANCE = 8212,
    BG_AB_SOUND_NODE_ASSAULTED_HORDE    = 8174,
    BG_AB_SOUND_NEAR_VICTORY            = 8456
};

enum BG_AB_Misc
{
    BG_AB_OBJECTIVE_ASSAULT_BASE        = 122,
    BG_AB_OBJECTIVE_DEFEND_BASE         = 123,
    BG_AB_EVENT_START_BATTLE            = 9158, // Achievement: Let's Get This Done
    BG_AB_QUEST_CREDIT_BASE             = 15001,

    BG_AB_HONOR_TICK_NORMAL             = 260,
    BG_AB_HONOR_TICK_WEEKEND            = 160,
    BG_AB_REP_TICK_NORMAL               = 160,
    BG_AB_REP_TICK_WEEKEND              = 120,

    BG_AB_WARNING_NEAR_VICTORY_SCORE    = 1400,
    BG_AB_MAX_TEAM_SCORE                = 1600,

    BG_AB_FLAG_CAPTURING_TIME           = 60000,
    BG_AB_BANNER_UPDATE_TIME            = 2000
};

const uint32 BG_AB_TickIntervals[BG_AB_DYNAMIC_NODES_COUNT+1] = {0, 12000, 9000, 6000, 3000, 1000};
const uint32 BG_AB_TickPoints[BG_AB_DYNAMIC_NODES_COUNT+1] = {0, 10, 10, 10, 10, 30};
const uint32 BG_AB_GraveyardIds[BG_AB_ALL_NODES_COUNT] = {895, 894, 893, 897, 896, 898, 899};

const float BG_AB_BuffPositions[BG_AB_DYNAMIC_NODES_COUNT][4] =
{
    {1185.71f, 1185.24f, -56.36f, 2.56f},                   // stables
    {990.75f, 1008.18f, -42.60f, 2.43f},                    // blacksmith
    {817.66f, 843.34f, -56.54f, 3.01f},                     // farm
    {807.46f, 1189.16f, 11.92f, 5.44f},                     // lumber mill
    {1146.62f, 816.94f, -98.49f, 6.14f}                     // gold mine
};

const float BG_AB_NodePositions[BG_AB_DYNAMIC_NODES_COUNT][4] =
{
    {1166.785f, 1200.132f, -56.70859f, 0.9075713f},         // stables
    {977.0156f, 1046.616f, -44.80923f, -2.600541f},         // blacksmith
    {806.1821f, 874.2723f, -55.99371f, -2.303835f},         // farm
    {856.1419f, 1148.902f, 11.18469f, -2.303835f},          // lumber mill
    {1146.923f, 848.1782f, -110.917f, -0.7330382f}          // gold mine
};

const float BG_AB_DoorPositions[2][8] =
{
    {1284.597f, 1281.167f, -15.97792f, 0.7068594f, 0.012957f, -0.060288f, 0.344959f, 0.93659f},
    {708.0903f, 708.4479f, -17.8342f, -2.391099f, 0.050291f, 0.015127f, 0.929217f, -0.365784f}
};

const float BG_AB_SpiritGuidePos[BG_AB_ALL_NODES_COUNT][4] =
{
    {1200.03f, 1171.09f, -56.47f, 5.15f},                   // stables
    {1017.43f, 960.61f, -42.95f, 4.88f},                    // blacksmith
    {833.00f, 793.00f, -57.25f, 5.27f},                     // farm
    {775.17f, 1206.40f, 15.79f, 1.90f},                     // lumber mill
    {1207.48f, 787.00f, -83.36f, 5.51f},                    // gold mine
    {1354.05f, 1275.48f, -11.30f, 4.77f},                   // alliance starting base
    {714.61f, 646.15f, -10.87f, 4.34f}                      // horde starting base
};

struct BattlegroundABScore : public BattlegroundScore
{
    BattlegroundABScore(Player* player) : BattlegroundScore(player), BasesAssaulted(0), BasesDefended(0) { }
    ~BattlegroundABScore() { }
    uint32 BasesAssaulted;
    uint32 BasesDefended;

    uint32 GetAttr1() const final override { return BasesAssaulted; }
    uint32 GetAttr2() const final override { return BasesDefended; }
};

class BattlegroundAB : public Battleground
{
    public:
        BattlegroundAB();
        ~BattlegroundAB();

        void AddPlayer(Player* player);
        void StartingEventCloseDoors();
        void StartingEventOpenDoors();
        void RemovePlayer(Player* player);
        void HandleAreaTrigger(Player* player, uint32 trigger);
        bool SetupBattleground();
        void Init();
        void EndBattleground(TeamId winnerTeamId);
        GraveyardStruct const* GetClosestGraveyard(Player* player);

        void UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor = true);
        void FillInitialWorldStates(WorldPacket& data);
        void EventPlayerClickedOnFlag(Player* source, GameObject* gameObject);

        bool AllNodesConrolledByTeam(TeamId teamId) const;
        bool IsTeamScores500Disadvantage(TeamId teamId) const { return _teamScores500Disadvantage[teamId]; }
        
        TeamId GetPrematureWinner();
    private:
        void PostUpdateImpl(uint32 diff);

        void DeleteBanner(uint8 node);
        void CreateBanner(uint8 node, bool delay);
        void SendNodeUpdate(uint8 node);
        void NodeOccupied(uint8 node);
        void NodeDeoccupied(uint8 node);
        void ApplyPhaseMask();

        struct CapturePointInfo
        {
            CapturePointInfo() : _ownerTeamId(TEAM_NEUTRAL), _iconNone(0), _iconCapture(0), _state(BG_AB_NODE_STATE_NEUTRAL), _captured(false)
            {
            }

            TeamId _ownerTeamId;
            uint32 _iconNone;
            uint32 _iconCapture;
            uint8 _state;

            bool _captured;
        };

        CapturePointInfo _capturePointInfo[BG_AB_DYNAMIC_NODES_COUNT];
        EventMap _bgEvents;
        uint32 _honorTics;
        uint32 _reputationTics;
        uint8 _controlledPoints[BG_TEAMS_COUNT];
        bool _teamScores500Disadvantage[BG_TEAMS_COUNT];
};
#endif

