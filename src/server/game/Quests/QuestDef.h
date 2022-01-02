/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef AZEROTHCORE_QUEST_H
#define AZEROTHCORE_QUEST_H

#include "DBCEnums.h"
#include "DatabaseEnv.h"
#include "Define.h"
#include "SharedDefines.h"
#include "WorldPacket.h"
#include <string>
#include <vector>

class Player;

class ObjectMgr;

#define MAX_QUEST_LOG_SIZE 25

#define QUEST_OBJECTIVES_COUNT 4
#define QUEST_ITEM_OBJECTIVES_COUNT 6
#define QUEST_SOURCE_ITEM_IDS_COUNT 4
#define QUEST_REWARD_CHOICES_COUNT 6
#define QUEST_REWARDS_COUNT 4
#define QUEST_DEPLINK_COUNT 10
#define QUEST_REPUTATIONS_COUNT 5
#define QUEST_EMOTE_COUNT 4
#define QUEST_PVP_KILL_SLOT 0

// EnumUtils: DESCRIBE THIS
enum QuestFailedReason : uint32
{
    INVALIDREASON_DONT_HAVE_REQ                 = 0,
    INVALIDREASON_QUEST_FAILED_LOW_LEVEL        = 1,        // DESCRIPTION You are not high enough level for that quest.
    INVALIDREASON_QUEST_FAILED_WRONG_RACE       = 6,        // DESCRIPTION That quest is not available to your race.
    INVALIDREASON_QUEST_ALREADY_DONE            = 7,        // DESCRIPTION You have completed that quest.
    INVALIDREASON_QUEST_ONLY_ONE_TIMED          = 12,       // DESCRIPTION You can only be on one timed quest at a time.
    INVALIDREASON_QUEST_ALREADY_ON              = 13,       // DESCRIPTION You are already on that quest.
    INVALIDREASON_QUEST_FAILED_EXPANSION        = 16,       // DESCRIPTION This quest requires an expansion enabled account.
    INVALIDREASON_QUEST_ALREADY_ON2             = 18,       // DESCRIPTION You are already on that quest.
    INVALIDREASON_QUEST_FAILED_MISSING_ITEMS    = 21,       // DESCRIPTION You don't have the required items with you. Check storage.
    INVALIDREASON_QUEST_FAILED_NOT_ENOUGH_MONEY = 23,       // DESCRIPTION You don't have enough money for that quest.
    INVALIDREASON_DAILY_QUESTS_REMAINING        = 26,       // DESCRIPTION You have already completed 25 daily quests today.
    INVALIDREASON_QUEST_FAILED_CAIS             = 27,       // DESCRIPTION You cannot complete quests once you have reached tired time.
    INVALIDREASON_DAILY_QUEST_COMPLETED_TODAY   = 29        // DESCRIPTION You have completed that daily quest today.
};

// EnumUtils: DESCRIBE THIS
enum QuestShareMessages : uint8
{
    QUEST_PARTY_MSG_SHARING_QUEST           = 0,
    QUEST_PARTY_MSG_CANT_TAKE_QUEST         = 1,
    QUEST_PARTY_MSG_ACCEPT_QUEST            = 2,
    QUEST_PARTY_MSG_DECLINE_QUEST           = 3,
    QUEST_PARTY_MSG_BUSY                    = 4,
    QUEST_PARTY_MSG_LOG_FULL                = 5,
    QUEST_PARTY_MSG_HAVE_QUEST              = 6,
    QUEST_PARTY_MSG_FINISH_QUEST            = 7,
    QUEST_PARTY_MSG_CANT_BE_SHARED_TODAY    = 8,
    QUEST_PARTY_MSG_SHARING_TIMER_EXPIRED   = 9,
    QUEST_PARTY_MSG_NOT_IN_PARTY            = 10
};

enum QuestTradeSkill
{
    QUEST_TRSKILL_NONE           = 0,
    QUEST_TRSKILL_ALCHEMY        = 1,
    QUEST_TRSKILL_BLACKSMITHING  = 2,
    QUEST_TRSKILL_COOKING        = 3,
    QUEST_TRSKILL_ENCHANTING     = 4,
    QUEST_TRSKILL_ENGINEERING    = 5,
    QUEST_TRSKILL_FIRSTAID       = 6,
    QUEST_TRSKILL_HERBALISM      = 7,
    QUEST_TRSKILL_LEATHERWORKING = 8,
    QUEST_TRSKILL_POISONS        = 9,
    QUEST_TRSKILL_TAILORING      = 10,
    QUEST_TRSKILL_MINING         = 11,
    QUEST_TRSKILL_FISHING        = 12,
    QUEST_TRSKILL_SKINNING       = 13,
    QUEST_TRSKILL_JEWELCRAFTING  = 14,
};

enum QuestStatus : uint8
{
    QUEST_STATUS_NONE           = 0,
    QUEST_STATUS_COMPLETE       = 1,
    //QUEST_STATUS_UNAVAILABLE    = 2,
    QUEST_STATUS_INCOMPLETE     = 3,
    //QUEST_STATUS_AVAILABLE      = 4,
    QUEST_STATUS_FAILED         = 5,
    QUEST_STATUS_REWARDED       = 6,        // Not used in DB
    MAX_QUEST_STATUS
};

enum QuestGiverStatus : uint32
{
    DIALOG_STATUS_NONE                     = 0,
    DIALOG_STATUS_UNAVAILABLE              = 1,
    DIALOG_STATUS_LOW_LEVEL_AVAILABLE      = 2,
    DIALOG_STATUS_LOW_LEVEL_REWARD_REP     = 3,
    DIALOG_STATUS_LOW_LEVEL_AVAILABLE_REP  = 4,
    DIALOG_STATUS_INCOMPLETE               = 5,
    DIALOG_STATUS_REWARD_REP               = 6,
    DIALOG_STATUS_AVAILABLE_REP            = 7,
    DIALOG_STATUS_AVAILABLE                = 8,
    DIALOG_STATUS_REWARD2                  = 9,             // no yellow dot on minimap
    DIALOG_STATUS_REWARD                   = 10,            // yellow dot on minimap

    // Custom value meaning that script call did not return any valid quest status
    DIALOG_STATUS_SCRIPTED_NO_STATUS       = 0x1000,
};

enum QuestFlags
{
    // Flags used at server and sent to client
    QUEST_FLAGS_NONE                    = 0x00000000,
    QUEST_FLAGS_STAY_ALIVE              = 0x00000001,   // Not used currently
    QUEST_FLAGS_PARTY_ACCEPT            = 0x00000002,   // Not used currently. If player in party, all players that can accept this quest will receive confirmation box to accept quest CMSG_QUEST_CONFIRM_ACCEPT/SMSG_QUEST_CONFIRM_ACCEPT
    QUEST_FLAGS_EXPLORATION             = 0x00000004,   // Not used currently
    QUEST_FLAGS_SHARABLE                = 0x00000008,   // Can be shared: Player::CanShareQuest()
    QUEST_FLAGS_HAS_CONDITION           = 0x00000010,   // Not used currently
    QUEST_FLAGS_HIDE_REWARD_POI         = 0x00000020,   // Not used currently: Unsure of content
    QUEST_FLAGS_RAID                    = 0x00000040,   // Not used currently
    QUEST_FLAGS_TBC                     = 0x00000080,   // Not used currently: Available if TBC expansion enabled only
    QUEST_FLAGS_NO_MONEY_FROM_XP        = 0x00000100,   // Not used currently: Experience is not converted to gold at max level
    QUEST_FLAGS_HIDDEN_REWARDS          = 0x00000200,   // Items and money rewarded only sent in SMSG_QUESTGIVER_OFFER_REWARD (not in SMSG_QUESTGIVER_QUEST_DETAILS or in client quest log(SMSG_QUEST_QUERY_RESPONSE))
    QUEST_FLAGS_TRACKING                = 0x00000400,   // These quests are automatically rewarded on quest complete and they will never appear in quest log client side.
    QUEST_FLAGS_DEPRECATE_REPUTATION    = 0x00000800,   // Not used currently
    QUEST_FLAGS_DAILY                   = 0x00001000,   // Used to know quest is Daily one
    QUEST_FLAGS_FLAGS_PVP               = 0x00002000,   // Having this quest in log forces PvP flag
    QUEST_FLAGS_UNAVAILABLE             = 0x00004000,   // Used on quests that are not generically available
    QUEST_FLAGS_WEEKLY                  = 0x00008000,
    QUEST_FLAGS_AUTOCOMPLETE            = 0x00010000,   // auto complete
    QUEST_FLAGS_DISPLAY_ITEM_IN_TRACKER = 0x00020000,   // Displays usable item in quest tracker
    QUEST_FLAGS_OBJ_TEXT                = 0x00040000,   // use Objective text as Complete text
    QUEST_FLAGS_AUTO_ACCEPT             = 0x00080000,   // The client recognizes this flag as auto-accept. However, NONE of the current quests (3.3.5a) have this flag. Maybe blizz used to use it, or will use it in the future.

    // ... 4.x added flags up to 0x80000000 - all unknown for now
};

enum QuestSpecialFlags
{
    QUEST_SPECIAL_FLAGS_NONE                    = 0x000,
    // Trinity flags for set SpecialFlags in DB if required but used only at server
    QUEST_SPECIAL_FLAGS_REPEATABLE              = 0x001,    // Set by 1 in SpecialFlags from DB
    QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT    = 0x002,    // Set by 2 in SpecialFlags from DB (if required area explore, spell SPELL_EFFECT_QUEST_COMPLETE casting, table `FECT_QUEST_COMPLETE casting, table `*_script` command SCRIPT_COMMAND_QUEST_EXPLORED use, set from script)
    QUEST_SPECIAL_FLAGS_AUTO_ACCEPT             = 0x004,    // Set by 4 in SpecialFlags in DB if the quest is to be auto-accepted.
    QUEST_SPECIAL_FLAGS_DF_QUEST                = 0x008,    // Set by 8 in SpecialFlags in DB if the quest is used by Dungeon Finder.
    QUEST_SPECIAL_FLAGS_MONTHLY                 = 0x010,    // Set by 16 in SpecialFlags in DB if the quest is reset at the begining of the month
    QUEST_SPECIAL_FLAGS_CAST                    = 0x020,    // Set by 32 in SpecialFlags in DB if the quest requires RequiredOrNpcGo killcredit but NOT kill (a spell cast)
    QUEST_SPECIAL_FLAGS_NO_REP_SPILLOVER        = 0x040,    // Set by 64 in SpecialFlags in DB if the quest does not share rewarded reputation with other allied factions
    // room for more custom flags

    QUEST_SPECIAL_FLAGS_DB_ALLOWED              = QUEST_SPECIAL_FLAGS_REPEATABLE | QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT | QUEST_SPECIAL_FLAGS_AUTO_ACCEPT |
                                                  QUEST_SPECIAL_FLAGS_DF_QUEST | QUEST_SPECIAL_FLAGS_MONTHLY | QUEST_SPECIAL_FLAGS_CAST | QUEST_SPECIAL_FLAGS_NO_REP_SPILLOVER,

    QUEST_SPECIAL_FLAGS_DELIVER                 = 0x080,   // Internal flag computed only
    QUEST_SPECIAL_FLAGS_SPEAKTO                 = 0x100,   // Internal flag computed only
    QUEST_SPECIAL_FLAGS_KILL                    = 0x200,   // Internal flag computed only
    QUEST_SPECIAL_FLAGS_TIMED                   = 0x400,   // Internal flag computed only
    QUEST_SPECIAL_FLAGS_PLAYER_KILL             = 0x800    // Internal flag computed only
};

struct QuestLocale
{
    QuestLocale() { ObjectiveText.resize(QUEST_OBJECTIVES_COUNT); }

    std::vector<std::string> Title;
    std::vector<std::string> Details;
    std::vector<std::string> Objectives;
    std::vector<std::string> OfferRewardText;
    std::vector<std::string> RequestItemsText;
    std::vector<std::string> AreaDescription;
    std::vector<std::string> CompletedText;
    std::vector< std::vector<std::string> > ObjectiveText;
};

struct QuestRequestItemsLocale
{
    std::vector<std::string> CompletionText;
};

struct QuestOfferRewardLocale
{
    std::vector<std::string> RewardText;
};

// This Quest class provides a convenient way to access a few pretotaled (cached) quest details,
// all base quest information, and any utility functions such as generating the amount of
// xp to give
class Quest
{
    friend class ObjectMgr;
public:
    Quest(Field* questRecord);
    void LoadQuestDetails(Field* fields);
    void LoadQuestRequestItems(Field* fields);
    void LoadQuestOfferReward(Field* fields);
    void LoadQuestTemplateAddon(Field* fields);

    [[nodiscard]] auto XPValue(uint8 playerLevel = 0) const -> uint32;

    [[nodiscard]] auto HasFlag(uint32 flag) const -> bool { return (Flags & flag) != 0; }
    void SetFlag(uint32 flag) { Flags |= flag; }

    [[nodiscard]] auto HasSpecialFlag(uint32 flag) const -> bool { return (SpecialFlags & flag) != 0; }
    void SetSpecialFlag(uint32 flag) { SpecialFlags |= flag; }

    // table data accessors:
    [[nodiscard]] auto GetQuestId() const -> uint32 { return Id; }
    [[nodiscard]] auto GetQuestMethod() const -> uint32 { return Method; }
    [[nodiscard]] auto  GetZoneOrSort() const -> int32 { return ZoneOrSort; }
    [[nodiscard]] auto GetMinLevel() const -> uint32 { return MinLevel; }
    [[nodiscard]] auto GetMaxLevel() const -> uint32 { return MaxLevel; }
    [[nodiscard]] auto  GetQuestLevel() const -> int32 { return Level; }
    [[nodiscard]] auto GetType() const -> uint32 { return Type; }
    [[nodiscard]] auto GetRequiredClasses() const -> uint32 { return RequiredClasses; }
    [[nodiscard]] auto GetAllowableRaces() const -> uint32 { return AllowableRaces; }
    [[nodiscard]] auto GetRequiredSkill() const -> uint32 { return RequiredSkillId; }
    [[nodiscard]] auto GetRequiredSkillValue() const -> uint32 { return RequiredSkillPoints; }
    [[nodiscard]] auto GetRepObjectiveFaction() const -> uint32 { return RequiredFactionId1; }
    [[nodiscard]] auto  GetRepObjectiveValue() const -> int32 { return RequiredFactionValue1; }
    [[nodiscard]] auto GetRepObjectiveFaction2() const -> uint32 { return RequiredFactionId2; }
    [[nodiscard]] auto  GetRepObjectiveValue2() const -> int32 { return RequiredFactionValue2; }
    [[nodiscard]] auto GetRequiredMinRepFaction() const -> uint32 { return RequiredMinRepFaction; }
    [[nodiscard]] auto  GetRequiredMinRepValue() const -> int32 { return RequiredMinRepValue; }
    [[nodiscard]] auto GetRequiredMaxRepFaction() const -> uint32 { return RequiredMaxRepFaction; }
    [[nodiscard]] auto  GetRequiredMaxRepValue() const -> int32 { return RequiredMaxRepValue; }
    [[nodiscard]] auto GetSuggestedPlayers() const -> uint32 { return SuggestedPlayers; }
    [[nodiscard]] auto GetTimeAllowed() const -> uint32 { return TimeAllowed; }
    [[nodiscard]] auto  GetPrevQuestId() const -> int32 { return PrevQuestId; }
    [[nodiscard]] auto GetNextQuestId() const -> uint32 { return NextQuestId; }
    [[nodiscard]] auto  GetExclusiveGroup() const -> int32 { return ExclusiveGroup; }
    [[nodiscard]] auto GetNextQuestInChain() const -> uint32 { return RewardNextQuest; }
    [[nodiscard]] auto GetCharTitleId() const -> uint32 { return RewardTitleId; }
    [[nodiscard]] auto GetPlayersSlain() const -> uint32 { return RequiredPlayerKills; }
    [[nodiscard]] auto GetBonusTalents() const -> uint32 { return RewardTalents; }
    [[nodiscard]] auto  GetRewArenaPoints() const -> int32 {return RewardArenaPoints; }
    [[nodiscard]] auto GetXPId() const -> uint32 { return RewardXPDifficulty; }
    [[nodiscard]] auto GetSrcItemId() const -> uint32 { return StartItem; }
    [[nodiscard]] auto GetSrcItemCount() const -> uint32 { return StartItemCount; }
    [[nodiscard]] auto GetSrcSpell() const -> uint32 { return SourceSpellid; }
    [[nodiscard]] auto GetTitle() const -> std::string const& { return Title; }
    [[nodiscard]] auto GetDetails() const -> std::string const& { return Details; }
    [[nodiscard]] auto GetObjectives() const -> std::string const& { return Objectives; }
    [[nodiscard]] auto GetOfferRewardText() const -> std::string const& { return OfferRewardText; }
    [[nodiscard]] auto GetRequestItemsText() const -> std::string const& { return RequestItemsText; }
    [[nodiscard]] auto GetAreaDescription() const -> std::string const& { return AreaDescription; }
    [[nodiscard]] auto GetCompletedText() const -> std::string const& { return CompletedText; }
    [[nodiscard]] auto  GetRewOrReqMoney(uint8 playerLevel = 0) const -> int32;
    [[nodiscard]] auto GetRewHonorAddition() const -> uint32 { return RewardHonor; }
    [[nodiscard]] auto GetRewHonorMultiplier() const -> float { return RewardKillHonor; }
    [[nodiscard]] auto GetRewMoneyMaxLevel() const -> uint32; // use in XP calculation at client
    [[nodiscard]] auto GetRewSpell() const -> uint32 { return RewardDisplaySpell; }
    [[nodiscard]] auto  GetRewSpellCast() const -> int32 { return RewardSpell; }
    [[nodiscard]] auto GetRewMailTemplateId() const -> uint32 { return RewardMailTemplateId; }
    [[nodiscard]] auto GetRewMailDelaySecs() const -> uint32 { return RewardMailDelay; }
    [[nodiscard]] auto GetRewMailSenderEntry() const -> uint32 { return RewardMailSenderEntry; }
    [[nodiscard]] auto GetPOIContinent() const -> uint32 { return POIContinent; }
    [[nodiscard]] auto  GetPOIx() const -> float { return POIx; }
    [[nodiscard]] auto  GetPOIy() const -> float { return POIy; }
    [[nodiscard]] auto GetPointOpt() const -> uint32 { return POIPriority; }
    [[nodiscard]] auto GetIncompleteEmote() const -> uint32 { return EmoteOnIncomplete; }
    [[nodiscard]] auto GetCompleteEmote() const -> uint32 { return EmoteOnComplete; }
    [[nodiscard]] auto   IsRepeatable() const -> bool { return SpecialFlags & QUEST_SPECIAL_FLAGS_REPEATABLE; }
    [[nodiscard]] auto   IsAutoAccept() const -> bool;
    [[nodiscard]] auto   IsAutoComplete() const -> bool;
    [[nodiscard]] auto GetFlags() const -> uint32 { return Flags; }
    [[nodiscard]] auto   IsDaily() const -> bool { return Flags & QUEST_FLAGS_DAILY; }
    [[nodiscard]] auto   IsWeekly() const -> bool { return Flags & QUEST_FLAGS_WEEKLY; }
    [[nodiscard]] auto   IsMonthly() const -> bool { return SpecialFlags & QUEST_SPECIAL_FLAGS_MONTHLY; }
    [[nodiscard]] auto   IsSeasonal() const -> bool { return (ZoneOrSort == -QUEST_SORT_SEASONAL || ZoneOrSort == -QUEST_SORT_SPECIAL || ZoneOrSort == -QUEST_SORT_LUNAR_FESTIVAL || ZoneOrSort == -QUEST_SORT_MIDSUMMER || ZoneOrSort == -QUEST_SORT_BREWFEST || ZoneOrSort == -QUEST_SORT_LOVE_IS_IN_THE_AIR || ZoneOrSort == -QUEST_SORT_NOBLEGARDEN) && !IsRepeatable(); }
    [[nodiscard]] auto   IsDailyOrWeekly() const -> bool { return Flags & (QUEST_FLAGS_DAILY | QUEST_FLAGS_WEEKLY); }
    [[nodiscard]] auto   IsRaidQuest(Difficulty difficulty) const -> bool;
    [[nodiscard]] auto   IsAllowedInRaid(Difficulty difficulty) const -> bool;
    [[nodiscard]] auto   IsDFQuest() const -> bool { return SpecialFlags & QUEST_SPECIAL_FLAGS_DF_QUEST; }
    [[nodiscard]] auto   IsPVPQuest() const -> bool { return Type == QUEST_TYPE_PVP; }
    [[nodiscard]] auto CalculateHonorGain(uint8 level) const -> uint32;

    // multiple values
    std::string ObjectiveText[QUEST_OBJECTIVES_COUNT];
    uint32 RequiredItemId[QUEST_ITEM_OBJECTIVES_COUNT];
    uint32 RequiredItemCount[QUEST_ITEM_OBJECTIVES_COUNT];
    uint32 ItemDrop[QUEST_SOURCE_ITEM_IDS_COUNT];
    uint32 ItemDropQuantity[QUEST_SOURCE_ITEM_IDS_COUNT];
    int32  RequiredNpcOrGo[QUEST_OBJECTIVES_COUNT];   // >0 Creature <0 Gameobject
    uint32 RequiredNpcOrGoCount[QUEST_OBJECTIVES_COUNT];
    uint32 RewardChoiceItemId[QUEST_REWARD_CHOICES_COUNT];
    uint32 RewardChoiceItemCount[QUEST_REWARD_CHOICES_COUNT];
    uint32 RewardItemId[QUEST_REWARDS_COUNT];
    uint32 RewardItemIdCount[QUEST_REWARDS_COUNT];
    uint32 RewardFactionId[QUEST_REPUTATIONS_COUNT];
    int32  RewardFactionValueId[QUEST_REPUTATIONS_COUNT];
    int32  RewardFactionValueIdOverride[QUEST_REPUTATIONS_COUNT];
    uint32 DetailsEmote[QUEST_EMOTE_COUNT];
    uint32 DetailsEmoteDelay[QUEST_EMOTE_COUNT];
    uint32 OfferRewardEmote[QUEST_EMOTE_COUNT];
    uint32 OfferRewardEmoteDelay[QUEST_EMOTE_COUNT];

    [[nodiscard]] auto GetReqItemsCount() const -> uint32 { return _reqItemsCount; }
    [[nodiscard]] auto GetReqCreatureOrGOcount() const -> uint32 { return _reqCreatureOrGOcount; }
    [[nodiscard]] auto GetRewChoiceItemsCount() const -> uint32 { return _rewChoiceItemsCount; }
    [[nodiscard]] auto GetRewItemsCount() const -> uint32 { return _rewItemsCount; }

    typedef std::vector<int32> PrevQuests;
    PrevQuests prevQuests;
    typedef std::vector<uint32> PrevChainQuests;
    PrevChainQuests prevChainQuests;

    WorldPacket queryData; // pussywizard
    void InitializeQueryData(); // pussywizard

    void SetEventIdForQuest(uint16 eventId) { _eventIdForQuest = eventId; }
    [[nodiscard]] auto GetEventIdForQuest() const -> uint16 { return _eventIdForQuest; }

    // cached data
private:
    uint32 _reqItemsCount;
    uint32 _reqCreatureOrGOcount;
    uint32 _rewChoiceItemsCount;
    uint32 _rewItemsCount;

    uint16 _eventIdForQuest; // pussywizard

    // table data
protected:
    uint32 Id;
    uint32 Method;
    int32  ZoneOrSort;
    uint32 MinLevel;
    int32  Level;
    uint32 Type;
    uint32 AllowableRaces;
    uint32 RequiredFactionId1;
    int32  RequiredFactionValue1;
    uint32 RequiredFactionId2;
    int32  RequiredFactionValue2;
    uint32 SuggestedPlayers;
    uint32 TimeAllowed;
    uint32 Flags;
    uint32 RewardTitleId;
    uint32 RequiredPlayerKills;
    uint32 RewardTalents;
    int32  RewardArenaPoints;
    uint32 RewardNextQuest;
    uint32 RewardXPDifficulty;
    uint32 StartItem;
    std::string Title;
    std::string Details;
    std::string Objectives;
    std::string OfferRewardText;
    std::string RequestItemsText;
    std::string AreaDescription;
    std::string CompletedText;
    uint32 RewardHonor;
    float RewardKillHonor;
    int32  RewardMoney;
    uint32 RewardMoneyDifficulty;
    uint32 RewardBonusMoney;
    uint32 RewardDisplaySpell;
    int32  RewardSpell;
    uint32 POIContinent;
    float  POIx;
    float  POIy;
    uint32 POIPriority;
    uint32 EmoteOnIncomplete;
    uint32 EmoteOnComplete;

    // quest_template_addon table (custom data)
    uint32 MaxLevel               = 0;
    uint32 RequiredClasses        = 0;
    uint32 SourceSpellid          = 0;
    int32  PrevQuestId            = 0;
    uint32 NextQuestId            = 0;
    int32  ExclusiveGroup         = 0;
    uint32 RewardMailTemplateId   = 0;
    uint32 RewardMailDelay        = 0;
    uint32 RequiredSkillId        = 0;
    uint32 RequiredSkillPoints    = 0;
    uint32 RequiredMinRepFaction  = 0;
    int32  RequiredMinRepValue    = 0;
    uint32 RequiredMaxRepFaction  = 0;
    int32  RequiredMaxRepValue    = 0;
    uint32 StartItemCount         = 0;
    uint32 RewardMailSenderEntry  = 0;
    uint32 SpecialFlags           = 0; // custom flags, not sniffed/WDB
};

struct QuestStatusData
{
    QuestStatusData()
    {
        memset(ItemCount, 0, QUEST_ITEM_OBJECTIVES_COUNT * sizeof(uint16));
        memset(CreatureOrGOCount, 0, QUEST_OBJECTIVES_COUNT * sizeof(uint16));
    }

    QuestStatus Status{QUEST_STATUS_NONE};
    uint32 Timer{0};
    uint16 ItemCount[QUEST_ITEM_OBJECTIVES_COUNT];
    uint16 CreatureOrGOCount[QUEST_OBJECTIVES_COUNT];
    uint16 PlayerCount{0};
    bool Explored{false};
};
#endif
