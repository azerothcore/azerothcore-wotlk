/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef __BATTLEGROUNDEY_H
#define __BATTLEGROUNDEY_H

#include "Language.h"
#include "Battleground.h"

enum BG_EY_Events
{
    BG_EY_EVENT_ADD_POINTS          = 1,
    BG_EY_EVENT_FLAG_ON_GROUND      = 2,
    BG_EY_EVENT_RESPAWN_FLAG        = 3,
    BG_EY_EVENT_CHECK_CPOINTS       = 4
};

enum BG_EY_Timers
{
    BG_EY_FLAG_RESPAWN_TIME         = 20*IN_MILLISECONDS,
    BG_EY_FLAG_ON_GROUND_TIME       = 10*IN_MILLISECONDS,
    BG_EY_FPOINTS_CHECK_TIME        = 2*IN_MILLISECONDS,
    BG_EY_FPOINTS_TICK_TIME         = 1*IN_MILLISECONDS
};

enum BG_EY_WorldStates
{
    EY_ALLIANCE_RESOURCES           = 2749,
    EY_HORDE_RESOURCES              = 2750,
    EY_ALLIANCE_BASE                = 2752,
    EY_HORDE_BASE                   = 2753,
    DRAENEI_RUINS_HORDE_CONTROL     = 2733,
    DRAENEI_RUINS_ALLIANCE_CONTROL  = 2732,
    DRAENEI_RUINS_UNCONTROL         = 2731,
    MAGE_TOWER_ALLIANCE_CONTROL     = 2730,
    MAGE_TOWER_HORDE_CONTROL        = 2729,
    MAGE_TOWER_UNCONTROL            = 2728,
    FEL_REAVER_HORDE_CONTROL        = 2727,
    FEL_REAVER_ALLIANCE_CONTROL     = 2726,
    FEL_REAVER_UNCONTROL            = 2725,
    BLOOD_ELF_HORDE_CONTROL         = 2724,
    BLOOD_ELF_ALLIANCE_CONTROL      = 2723,
    BLOOD_ELF_UNCONTROL             = 2722,
    PROGRESS_BAR_PERCENT_GREY       = 2720,                 //100 = empty (only grey), 0 = blue|red (no grey)
    PROGRESS_BAR_STATUS             = 2719,                 //50 init!, 48 ... hordak bere .. 33 .. 0 = full 100% hordacky, 100 = full alliance
    PROGRESS_BAR_SHOW               = 2718,                 //1 init, 0 druhy send - bez messagu, 1 = controlled aliance
    NETHERSTORM_FLAG                = 2757,
    //set to 2 when flag is picked up, and to 1 if it is dropped
    NETHERSTORM_FLAG_STATE_ALLIANCE = 2769,
    NETHERSTORM_FLAG_STATE_HORDE    = 2770
};

enum BG_EY_ProgressBarConsts
{
    BG_EY_POINT_MAX_CAPTURERS_COUNT     = 5,
    BG_EY_POINT_RADIUS                  = 50,
    BG_EY_PROGRESS_BAR_DONT_SHOW        = 0,
    BG_EY_PROGRESS_BAR_SHOW             = 1,
    BG_EY_PROGRESS_BAR_PERCENT_GREY     = 40,
    BG_EY_PROGRESS_BAR_STATE_MIDDLE     = 50,
    BG_EY_PROGRESS_BAR_HORDE_CONTROLLED = 0,
    BG_EY_PROGRESS_BAR_NEUTRAL_LOW      = 30,
    BG_EY_PROGRESS_BAR_NEUTRAL_HIGH     = 70,
    BG_EY_PROGRESS_BAR_ALI_CONTROLLED   = 100
};

enum BG_EY_Sounds
{
    BG_EY_SOUND_FLAG_PICKED_UP_ALLIANCE = 8212,
    BG_EY_SOUND_FLAG_CAPTURED_HORDE     = 8213,
    BG_EY_SOUND_FLAG_PICKED_UP_HORDE    = 8174,
    BG_EY_SOUND_FLAG_CAPTURED_ALLIANCE  = 8173,
    BG_EY_SOUND_FLAG_RESET              = 8192
};

enum BG_EY_Spells
{
    BG_EY_NETHERSTORM_FLAG_SPELL        = 34976,
    BG_EY_PLAYER_DROPPED_FLAG_SPELL     = 34991
};

enum BG_EY_ObjectEntry
{
    BG_OBJECT_A_DOOR_EY_ENTRY           = 184719,           //Alliance door
    BG_OBJECT_H_DOOR_EY_ENTRY           = 184720,           //Horde door
    BG_OBJECT_FLAG1_EY_ENTRY            = 184493,           //Netherstorm flag (generic)
    BG_OBJECT_FLAG2_EY_ENTRY            = 184141,           //Netherstorm flag (flagstand)
    BG_OBJECT_FLAG3_EY_ENTRY            = 184142,           //Netherstorm flag (flagdrop)
    BG_OBJECT_A_BANNER_EY_ENTRY         = 184381,           //Visual Banner (Alliance)
    BG_OBJECT_H_BANNER_EY_ENTRY         = 184380,           //Visual Banner (Horde)
    BG_OBJECT_N_BANNER_EY_ENTRY         = 184382,           //Visual Banner (Neutral)
    BG_OBJECT_BE_TOWER_CAP_EY_ENTRY     = 184080,           //BE Tower Cap Pt
    BG_OBJECT_FR_TOWER_CAP_EY_ENTRY     = 184081,           //Fel Reaver Cap Pt
    BG_OBJECT_HU_TOWER_CAP_EY_ENTRY     = 184082,           //Human Tower Cap Pt
    BG_OBJECT_DR_TOWER_CAP_EY_ENTRY     = 184083            //Draenei Tower Cap Pt
};

enum BG_EY_AreaTriggers
{
    AT_BLOOD_ELF_POINT                  = 4476,
    AT_FEL_REAVER_POINT                 = 4514,
    AT_MAGE_TOWER_POINT                 = 4516,
    AT_DRAENEI_RUINS_POINT              = 4518,
    AT_BLOOD_ELF_BUFF                   = 4568,
    AT_FEL_REAVER_BUFF                  = 4569,
    AT_MAGE_TOWER_BUFF                  = 4570,
    AT_DRAENEI_RUINS_BUFF               = 4571
};

enum BG_EY_Graveyards
{
    BG_EY_GRAVEYARD_MAIN_ALLIANCE     = 1103,
    BG_EY_GRAVEYARD_MAIN_HORDE        = 1104,
    BG_EY_GRAVEYARD_FEL_REAVER        = 1105,
    BG_EY_GRAVEYARD_BLOOD_ELF         = 1106,
    BG_EY_GRAVEYARD_DRAENEI_RUINS     = 1107,
    BG_EY_GRAVEYARD_MAGE_TOWER        = 1108
};

enum BG_EY_Points
{
    POINT_FEL_REAVER        = 0,
    POINT_BLOOD_ELF         = 1,
    POINT_DRAENEI_RUINS     = 2,
    POINT_MAGE_TOWER        = 3,
    EY_POINTS_MAX           = 4
};

enum BG_EY_CreatureTypes
{
    BG_EY_SPIRIT_FEL_REAVER       = 0,
    BG_EY_SPIRIT_BLOOD_ELF        = 1,
    BG_EY_SPIRIT_DRAENEI_RUINS    = 2,
    BG_EY_SPIRIT_MAGE_TOWER       = 3,
    BG_EY_SPIRIT_MAIN_ALLIANCE    = 4,
    BG_EY_SPIRIT_MAIN_HORDE       = 5,

    BG_EY_TRIGGER_FEL_REAVER      = 6,
    BG_EY_TRIGGER_BLOOD_ELF       = 7,
    BG_EY_TRIGGER_DRAENEI_RUINS   = 8,
    BG_EY_TRIGGER_MAGE_TOWER      = 9,

    BG_EY_CREATURES_MAX           = 10
};

enum BG_EY_ObjectTypes
{
    BG_EY_OBJECT_DOOR_A                         = 0,
    BG_EY_OBJECT_DOOR_H                         = 1,
    BG_EY_OBJECT_A_BANNER_FEL_REAVER_CENTER     = 2,
    BG_EY_OBJECT_A_BANNER_FEL_REAVER_LEFT       = 3,
    BG_EY_OBJECT_A_BANNER_FEL_REAVER_RIGHT      = 4,
    BG_EY_OBJECT_A_BANNER_BLOOD_ELF_CENTER      = 5,
    BG_EY_OBJECT_A_BANNER_BLOOD_ELF_LEFT        = 6,
    BG_EY_OBJECT_A_BANNER_BLOOD_ELF_RIGHT       = 7,
    BG_EY_OBJECT_A_BANNER_DRAENEI_RUINS_CENTER  = 8,
    BG_EY_OBJECT_A_BANNER_DRAENEI_RUINS_LEFT    = 9,
    BG_EY_OBJECT_A_BANNER_DRAENEI_RUINS_RIGHT   = 10,
    BG_EY_OBJECT_A_BANNER_MAGE_TOWER_CENTER     = 11,
    BG_EY_OBJECT_A_BANNER_MAGE_TOWER_LEFT       = 12,
    BG_EY_OBJECT_A_BANNER_MAGE_TOWER_RIGHT      = 13,
    BG_EY_OBJECT_H_BANNER_FEL_REAVER_CENTER     = 14,
    BG_EY_OBJECT_H_BANNER_FEL_REAVER_LEFT       = 15,
    BG_EY_OBJECT_H_BANNER_FEL_REAVER_RIGHT      = 16,
    BG_EY_OBJECT_H_BANNER_BLOOD_ELF_CENTER      = 17,
    BG_EY_OBJECT_H_BANNER_BLOOD_ELF_LEFT        = 18,
    BG_EY_OBJECT_H_BANNER_BLOOD_ELF_RIGHT       = 19,
    BG_EY_OBJECT_H_BANNER_DRAENEI_RUINS_CENTER  = 20,
    BG_EY_OBJECT_H_BANNER_DRAENEI_RUINS_LEFT    = 21,
    BG_EY_OBJECT_H_BANNER_DRAENEI_RUINS_RIGHT   = 22,
    BG_EY_OBJECT_H_BANNER_MAGE_TOWER_CENTER     = 23,
    BG_EY_OBJECT_H_BANNER_MAGE_TOWER_LEFT       = 24,
    BG_EY_OBJECT_H_BANNER_MAGE_TOWER_RIGHT      = 25,
    BG_EY_OBJECT_N_BANNER_FEL_REAVER_CENTER     = 26,
    BG_EY_OBJECT_N_BANNER_FEL_REAVER_LEFT       = 27,
    BG_EY_OBJECT_N_BANNER_FEL_REAVER_RIGHT      = 28,
    BG_EY_OBJECT_N_BANNER_BLOOD_ELF_CENTER      = 29,
    BG_EY_OBJECT_N_BANNER_BLOOD_ELF_LEFT        = 30,
    BG_EY_OBJECT_N_BANNER_BLOOD_ELF_RIGHT       = 31,
    BG_EY_OBJECT_N_BANNER_DRAENEI_RUINS_CENTER  = 32,
    BG_EY_OBJECT_N_BANNER_DRAENEI_RUINS_LEFT    = 33,
    BG_EY_OBJECT_N_BANNER_DRAENEI_RUINS_RIGHT   = 34,
    BG_EY_OBJECT_N_BANNER_MAGE_TOWER_CENTER     = 35,
    BG_EY_OBJECT_N_BANNER_MAGE_TOWER_LEFT       = 36,
    BG_EY_OBJECT_N_BANNER_MAGE_TOWER_RIGHT      = 37,
    BG_EY_OBJECT_TOWER_CAP_FEL_REAVER           = 38,
    BG_EY_OBJECT_TOWER_CAP_BLOOD_ELF            = 39,
    BG_EY_OBJECT_TOWER_CAP_DRAENEI_RUINS        = 40,
    BG_EY_OBJECT_TOWER_CAP_MAGE_TOWER           = 41,
    BG_EY_OBJECT_FLAG_NETHERSTORM               = 42,
    BG_EY_OBJECT_FLAG_FEL_REAVER                = 43,
    BG_EY_OBJECT_FLAG_BLOOD_ELF                 = 44,
    BG_EY_OBJECT_FLAG_DRAENEI_RUINS             = 45,
    BG_EY_OBJECT_FLAG_MAGE_TOWER                = 46,
    //buffs
    BG_EY_OBJECT_SPEEDBUFF_FEL_REAVER           = 47,
    BG_EY_OBJECT_REGENBUFF_FEL_REAVER           = 48,
    BG_EY_OBJECT_BERSERKBUFF_FEL_REAVER         = 49,
    BG_EY_OBJECT_SPEEDBUFF_BLOOD_ELF            = 50,
    BG_EY_OBJECT_REGENBUFF_BLOOD_ELF            = 51,
    BG_EY_OBJECT_BERSERKBUFF_BLOOD_ELF          = 52,
    BG_EY_OBJECT_SPEEDBUFF_DRAENEI_RUINS        = 53,
    BG_EY_OBJECT_REGENBUFF_DRAENEI_RUINS        = 54,
    BG_EY_OBJECT_BERSERKBUFF_DRAENEI_RUINS      = 55,
    BG_EY_OBJECT_SPEEDBUFF_MAGE_TOWER           = 56,
    BG_EY_OBJECT_REGENBUFF_MAGE_TOWER           = 57,
    BG_EY_OBJECT_BERSERKBUFF_MAGE_TOWER         = 58,
    BG_EY_OBJECT_MAX                            = 59
};

enum BG_EY_Score
{
    BG_EY_WARNING_NEAR_VICTORY_SCORE    = 1400,
    BG_EY_MAX_TEAM_SCORE                = 1600,

    BG_EY_HONOR_TICK_WEEKEND            = 160,
    BG_EY_HONOR_TICK_NORMAL             = 260,

    BG_EY_EVENT_START_BATTLE            = 13180, // Achievement: Flurry
    BG_EY_OBJECTIVE_CAPTURE_FLAG        = 183
};

enum BG_EY_FlagState
{
    BG_EY_FLAG_STATE_ON_BASE      = 1,
    BG_EY_FLAG_STATE_ON_PLAYER    = 2,
    BG_EY_FLAG_STATE_ON_GROUND    = 3
};

struct BattlegroundEYPointIconsStruct
{
    BattlegroundEYPointIconsStruct(uint32 _WorldStateControlIndex, uint32 _WorldStateAllianceControlledIndex, uint32 _WorldStateHordeControlledIndex)
        : WorldStateControlIndex(_WorldStateControlIndex), WorldStateAllianceControlledIndex(_WorldStateAllianceControlledIndex), WorldStateHordeControlledIndex(_WorldStateHordeControlledIndex) {}
    uint32 WorldStateControlIndex;
    uint32 WorldStateAllianceControlledIndex;
    uint32 WorldStateHordeControlledIndex;
};

const float BG_EY_TriggerPositions[EY_POINTS_MAX][4] =
{
    {2044.28f, 1729.68f, 1189.96f, 0.017453f},  // FEL_REAVER center
    {2048.83f, 1393.65f, 1194.49f, 0.20944f},   // BLOOD_ELF center
    {2286.56f, 1402.36f, 1197.11f, 3.72381f},   // DRAENEI_RUINS center
    {2284.48f, 1731.23f, 1189.99f, 2.89725f}    // MAGE_TOWER center
};

struct BattlegroundEYLosingPointStruct
{
    BattlegroundEYLosingPointStruct(uint32 _SpawnNeutralObjectType, uint32 _DespawnObjectTypeAlliance, uint32 _MessageIdAlliance, uint32 _DespawnObjectTypeHorde, uint32 _MessageIdHorde)
        : SpawnNeutralObjectType(_SpawnNeutralObjectType),
        DespawnObjectTypeAlliance(_DespawnObjectTypeAlliance), MessageIdAlliance(_MessageIdAlliance),
        DespawnObjectTypeHorde(_DespawnObjectTypeHorde), MessageIdHorde(_MessageIdHorde)
    {}

    uint32 SpawnNeutralObjectType;
    uint32 DespawnObjectTypeAlliance;
    uint32 MessageIdAlliance;
    uint32 DespawnObjectTypeHorde;
    uint32 MessageIdHorde;
};

struct BattlegroundEYCapturingPointStruct
{
    BattlegroundEYCapturingPointStruct(uint32 _DespawnNeutralObjectType, uint32 _SpawnObjectTypeAlliance, uint32 _MessageIdAlliance, uint32 _SpawnObjectTypeHorde, uint32 _MessageIdHorde, uint32 _GraveYardId)
        : DespawnNeutralObjectType(_DespawnNeutralObjectType),
        SpawnObjectTypeAlliance(_SpawnObjectTypeAlliance), MessageIdAlliance(_MessageIdAlliance),
        SpawnObjectTypeHorde(_SpawnObjectTypeHorde), MessageIdHorde(_MessageIdHorde),
        GraveYardId(_GraveYardId)
    {}

    uint32 DespawnNeutralObjectType;
    uint32 SpawnObjectTypeAlliance;
    uint32 MessageIdAlliance;
    uint32 SpawnObjectTypeHorde;
    uint32 MessageIdHorde;
    uint32 GraveYardId;
};

const uint32 BG_EY_TickPoints[EY_POINTS_MAX] = {1, 2, 5, 10};
const uint32 BG_EY_FlagPoints[EY_POINTS_MAX] = {75, 85, 100, 500};

//constant arrays:
const BattlegroundEYPointIconsStruct m_PointsIconStruct[EY_POINTS_MAX] =
{
    BattlegroundEYPointIconsStruct(FEL_REAVER_UNCONTROL, FEL_REAVER_ALLIANCE_CONTROL, FEL_REAVER_HORDE_CONTROL),
    BattlegroundEYPointIconsStruct(BLOOD_ELF_UNCONTROL, BLOOD_ELF_ALLIANCE_CONTROL, BLOOD_ELF_HORDE_CONTROL),
    BattlegroundEYPointIconsStruct(DRAENEI_RUINS_UNCONTROL, DRAENEI_RUINS_ALLIANCE_CONTROL, DRAENEI_RUINS_HORDE_CONTROL),
    BattlegroundEYPointIconsStruct(MAGE_TOWER_UNCONTROL, MAGE_TOWER_ALLIANCE_CONTROL, MAGE_TOWER_HORDE_CONTROL)
};

const BattlegroundEYLosingPointStruct m_LosingPointTypes[EY_POINTS_MAX] =
{
    BattlegroundEYLosingPointStruct(BG_EY_OBJECT_N_BANNER_FEL_REAVER_CENTER, BG_EY_OBJECT_A_BANNER_FEL_REAVER_CENTER, LANG_BG_EY_HAS_LOST_A_F_RUINS, BG_EY_OBJECT_H_BANNER_FEL_REAVER_CENTER, LANG_BG_EY_HAS_LOST_H_F_RUINS),
    BattlegroundEYLosingPointStruct(BG_EY_OBJECT_N_BANNER_BLOOD_ELF_CENTER, BG_EY_OBJECT_A_BANNER_BLOOD_ELF_CENTER, LANG_BG_EY_HAS_LOST_A_B_TOWER, BG_EY_OBJECT_H_BANNER_BLOOD_ELF_CENTER, LANG_BG_EY_HAS_LOST_H_B_TOWER),
    BattlegroundEYLosingPointStruct(BG_EY_OBJECT_N_BANNER_DRAENEI_RUINS_CENTER, BG_EY_OBJECT_A_BANNER_DRAENEI_RUINS_CENTER, LANG_BG_EY_HAS_LOST_A_D_RUINS, BG_EY_OBJECT_H_BANNER_DRAENEI_RUINS_CENTER, LANG_BG_EY_HAS_LOST_H_D_RUINS),
    BattlegroundEYLosingPointStruct(BG_EY_OBJECT_N_BANNER_MAGE_TOWER_CENTER, BG_EY_OBJECT_A_BANNER_MAGE_TOWER_CENTER, LANG_BG_EY_HAS_LOST_A_M_TOWER, BG_EY_OBJECT_H_BANNER_MAGE_TOWER_CENTER, LANG_BG_EY_HAS_LOST_H_M_TOWER)
};

const BattlegroundEYCapturingPointStruct m_CapturingPointTypes[EY_POINTS_MAX] =
{
    BattlegroundEYCapturingPointStruct(BG_EY_OBJECT_N_BANNER_FEL_REAVER_CENTER, BG_EY_OBJECT_A_BANNER_FEL_REAVER_CENTER, LANG_BG_EY_HAS_TAKEN_A_F_RUINS, BG_EY_OBJECT_H_BANNER_FEL_REAVER_CENTER, LANG_BG_EY_HAS_TAKEN_H_F_RUINS, BG_EY_GRAVEYARD_FEL_REAVER),
    BattlegroundEYCapturingPointStruct(BG_EY_OBJECT_N_BANNER_BLOOD_ELF_CENTER, BG_EY_OBJECT_A_BANNER_BLOOD_ELF_CENTER, LANG_BG_EY_HAS_TAKEN_A_B_TOWER, BG_EY_OBJECT_H_BANNER_BLOOD_ELF_CENTER, LANG_BG_EY_HAS_TAKEN_H_B_TOWER, BG_EY_GRAVEYARD_BLOOD_ELF),
    BattlegroundEYCapturingPointStruct(BG_EY_OBJECT_N_BANNER_DRAENEI_RUINS_CENTER, BG_EY_OBJECT_A_BANNER_DRAENEI_RUINS_CENTER, LANG_BG_EY_HAS_TAKEN_A_D_RUINS, BG_EY_OBJECT_H_BANNER_DRAENEI_RUINS_CENTER, LANG_BG_EY_HAS_TAKEN_H_D_RUINS, BG_EY_GRAVEYARD_DRAENEI_RUINS),
    BattlegroundEYCapturingPointStruct(BG_EY_OBJECT_N_BANNER_MAGE_TOWER_CENTER, BG_EY_OBJECT_A_BANNER_MAGE_TOWER_CENTER, LANG_BG_EY_HAS_TAKEN_A_M_TOWER, BG_EY_OBJECT_H_BANNER_MAGE_TOWER_CENTER, LANG_BG_EY_HAS_TAKEN_H_M_TOWER, BG_EY_GRAVEYARD_MAGE_TOWER)
};

struct BattlegroundEYScore : public BattlegroundScore
{
    BattlegroundEYScore(Player* player) : BattlegroundScore(player), FlagCaptures(0) { }
    ~BattlegroundEYScore() { }
    uint32 FlagCaptures;

    uint32 GetAttr1() const final override { return FlagCaptures; }
};

class BattlegroundEY : public Battleground
{
    public:
        BattlegroundEY();
        ~BattlegroundEY();

        /* inherited from BattlegroundClass */
        void AddPlayer(Player* player);
        void StartingEventCloseDoors();
        void StartingEventOpenDoors();

        /* BG Flags */
        uint64 GetFlagPickerGUID(TeamId /*teamId*/ = TEAM_NEUTRAL) const    { return _flagKeeperGUID; }
        void SetFlagPicker(uint64 guid)     { _flagKeeperGUID = guid; }
        uint8 GetFlagState() const          { return _flagState; }
        void RespawnFlag();
        void RespawnFlagAfterDrop();

        void RemovePlayer(Player* player);
        void HandleBuffUse(uint64 buff_guid);
        void HandleAreaTrigger(Player* player, uint32 trigger);
        void HandleKillPlayer(Player* player, Player* killer);
        GraveyardStruct const* GetClosestGraveyard(Player* player);
        bool SetupBattleground();
        void Init();
        void EndBattleground(TeamId winnerTeamId);
        void UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor = true);
        void FillInitialWorldStates(WorldPacket& data);
        void SetDroppedFlagGUID(uint64 guid, TeamId /*teamId*/ = TEAM_NEUTRAL)  { _droppedFlagGUID = guid; }
        uint64 GetDroppedFlagGUID() const { return _droppedFlagGUID; }

        /* Battleground Events */
        void EventPlayerClickedOnFlag(Player* player, GameObject* gameObject);
        void EventPlayerDroppedFlag(Player* player);

        /* achievement req. */
        bool AllNodesConrolledByTeam(TeamId teamId) const;
        TeamId GetPrematureWinner();

    private:
        void PostUpdateImpl(uint32 diff);

        void EventPlayerCapturedFlag(Player* Source, uint32 BgObjectType);
        void EventTeamLostPoint(TeamId teamId, uint32 point);
        void EventTeamCapturedPoint(TeamId teamId, uint32 point);
        void UpdatePointsCount();
        void UpdatePointsIcons(uint32 point);

        /* Point status updating procedures */
        void UpdatePointsState();

        /* Scorekeeping */
        void AddPoints(TeamId teamId, uint32 points);

        struct CapturePointInfo
        {
            CapturePointInfo() : _ownerTeamId(TEAM_NEUTRAL), _barStatus(BG_EY_PROGRESS_BAR_STATE_MIDDLE), _areaTrigger(0)
            {
                _playersCount[TEAM_ALLIANCE] = 0;
                _playersCount[TEAM_HORDE] = 0;
            }

            TeamId _ownerTeamId;
            int8 _barStatus;
            uint32 _areaTrigger;
            int8 _playersCount[BG_TEAMS_COUNT];

            bool IsUnderControl(TeamId teamId) const { return _ownerTeamId == teamId; }
            bool IsUnderControl() const { return _ownerTeamId != TEAM_NEUTRAL; }
            bool IsUncontrolled() const { return _ownerTeamId == TEAM_NEUTRAL; }
        };

        CapturePointInfo _capturePointInfo[EY_POINTS_MAX];
        EventMap _bgEvents;
        uint32 _honorTics;
        uint8 _ownedPointsCount[BG_TEAMS_COUNT];
        uint64 _flagKeeperGUID;
        uint64 _droppedFlagGUID;
        uint8 _flagState;
        uint32 _flagCapturedObject;
};
#endif

