/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "QuestDef.h"
#include "Player.h"
#include "World.h"
#include "Opcodes.h"
#include "Formulas.h"

Quest::Quest(Field* questRecord)
{
    Id = questRecord[0].GetUInt32();
    Method = questRecord[1].GetUInt8();
    Level = questRecord[2].GetInt16();
    MinLevel = questRecord[3].GetUInt8();
    ZoneOrSort = questRecord[4].GetInt16();
    Type = questRecord[5].GetUInt16();
    SuggestedPlayers = questRecord[6].GetUInt8();
    LimitTime = questRecord[7].GetUInt32();
    RequiredRaces = questRecord[8].GetUInt16();
    RequiredFactionId1 = questRecord[9].GetUInt16();
    RequiredFactionId2 = questRecord[10].GetUInt16();
    RequiredFactionValue1 = questRecord[11].GetInt32();
    RequiredFactionValue2 = questRecord[12].GetInt32();
    NextQuestIdChain = questRecord[13].GetUInt32();
    RewardXPId = questRecord[14].GetUInt8();
    RewardOrRequiredMoney = questRecord[15].GetInt32();
    RewardMoneyMaxLevel = questRecord[16].GetUInt32();
    RewardSpell = questRecord[17].GetUInt32();
    RewardSpellCast = questRecord[18].GetInt32();
    RewardHonor = questRecord[19].GetUInt32();
    RewardHonorMultiplier = questRecord[20].GetFloat();
    SourceItemId = questRecord[21].GetUInt32();
    Flags = questRecord[22].GetUInt32();
    RewardTitleId = questRecord[23].GetUInt8();
    RequiredPlayerKills = questRecord[24].GetUInt8();
    RewardTalents = questRecord[25].GetUInt8();
    RewardArenaPoints = questRecord[26].GetUInt16();

    for (int i = 0; i < QUEST_REWARDS_COUNT; ++i)
        RewardItemId[i] = questRecord[27+i].GetUInt32();

    for (int i = 0; i < QUEST_REWARDS_COUNT; ++i)
        RewardItemIdCount[i] = questRecord[31+i].GetUInt16();

    for (int i = 0; i < QUEST_REWARD_CHOICES_COUNT; ++i)
        RewardChoiceItemId[i] = questRecord[35+i].GetUInt32();

    for (int i = 0; i < QUEST_REWARD_CHOICES_COUNT; ++i)
        RewardChoiceItemCount[i] = questRecord[41+i].GetUInt16();

    for (int i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)
        RewardFactionId[i] = questRecord[47+i].GetUInt16();

    for (int i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)
        RewardFactionValueId[i] = questRecord[52+i].GetInt32();

    for (int i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)
        RewardFactionValueIdOverride[i] = questRecord[57+i].GetInt32();

    PointMapId = questRecord[62].GetUInt16();
    PointX = questRecord[63].GetFloat();
    PointY = questRecord[64].GetFloat();
    PointOption = questRecord[65].GetUInt32();
    Title = questRecord[66].GetString();
    Objectives = questRecord[67].GetString();
    Details = questRecord[68].GetString();
    EndText = questRecord[69].GetString();
    OfferRewardText = questRecord[70].GetString();
    RequestItemsText = questRecord[71].GetString();
    CompletedText = questRecord[72].GetString();

    for (int i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
        RequiredNpcOrGo[i] = questRecord[73+i].GetInt32();

    for (int i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
        RequiredNpcOrGoCount[i] = questRecord[77+i].GetUInt16();

    for (int i = 0; i < QUEST_SOURCE_ITEM_IDS_COUNT; ++i)
        RequiredSourceItemId[i] = questRecord[81+i].GetUInt32();

    for (int i = 0; i < QUEST_SOURCE_ITEM_IDS_COUNT; ++i)
        RequiredSourceItemCount[i] = questRecord[85+i].GetUInt16();

    for (int i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
        RequiredItemId[i] = questRecord[89+i].GetUInt32();

    for (int i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
        RequiredItemCount[i] = questRecord[95+i].GetUInt16();

    // int8 Unknown0 = questRecord[101].GetUInt8();

    for (int i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
        ObjectiveText[i] = questRecord[102+i].GetString();

    for (int i = 0; i < QUEST_EMOTE_COUNT; ++i)
        DetailsEmote[i] = questRecord[106+i].GetUInt16();

    for (int i = 0; i < QUEST_EMOTE_COUNT; ++i)
        DetailsEmoteDelay[i] = questRecord[110+i].GetUInt32();

    EmoteOnIncomplete = questRecord[114].GetUInt16();
    EmoteOnComplete = questRecord[115].GetUInt16();

    for (int i = 0; i < QUEST_EMOTE_COUNT; ++i)
        OfferRewardEmote[i] = questRecord[116+i].GetInt16();

    for (int i = 0; i < QUEST_EMOTE_COUNT; ++i)
        OfferRewardEmoteDelay[i] = questRecord[120+i].GetInt32();

    //int32 VerifiedBuild = questRecord[124].GetInt32();

    _reqItemsCount = 0;
    _reqCreatureOrGOcount = 0;
    _rewItemsCount = 0;
    _rewChoiceItemsCount = 0;

    for (int i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
        if (RequiredItemId[i])
            ++_reqItemsCount;

    for (int i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
        if (RequiredNpcOrGo[i])
            ++_reqCreatureOrGOcount;

    for (int i = 0; i < QUEST_REWARDS_COUNT; ++i)
        if (RewardItemId[i])
            ++_rewItemsCount;

    for (int i = 0; i < QUEST_REWARD_CHOICES_COUNT; ++i)
        if (RewardChoiceItemId[i])
            ++_rewChoiceItemsCount;

    _eventIdForQuest = 0;
}

void Quest::LoadQuestTemplateAddon(Field* fields)
{
    MaxLevel = fields[1].GetUInt8();
    RequiredClasses = fields[2].GetUInt32();
    SourceSpellid = fields[3].GetUInt32();
    PrevQuestId = fields[4].GetInt32();
    NextQuestId = fields[5].GetInt32();
    ExclusiveGroup = fields[6].GetInt32();
    RewardMailTemplateId = fields[7].GetUInt32();
    RewardMailDelay = fields[8].GetUInt32();
    RequiredSkillId = fields[9].GetUInt16();
    RequiredSkillPoints = fields[10].GetUInt16();
    RequiredMinRepFaction = fields[11].GetUInt16();
    RequiredMaxRepFaction = fields[12].GetUInt16();
    RequiredMinRepValue = fields[13].GetInt32();
    RequiredMaxRepValue = fields[14].GetInt32();
    SourceItemIdCount = fields[15].GetUInt8();
    SpecialFlags = fields[16].GetUInt8();

    if (SpecialFlags & QUEST_SPECIAL_FLAGS_AUTO_ACCEPT)
        Flags |= QUEST_FLAGS_AUTO_ACCEPT;
}

uint32 Quest::XPValue(Player* player) const
{
    if (player)
    {
        int32 quest_level = (Level == -1 ? player->getLevel() : Level);
        const QuestXPEntry* xpentry = sQuestXPStore.LookupEntry(quest_level);
        if (!xpentry)
            return 0;

        int32 diffFactor = 2 * (quest_level - player->getLevel()) + 20;
        if (diffFactor < 1)
            diffFactor = 1;
        else if (diffFactor > 10)
            diffFactor = 10;

        uint32 xp = diffFactor * xpentry->Exp[RewardXPId] / 10;
        if (xp <= 100)
            xp = 5 * ((xp + 2) / 5);
        else if (xp <= 500)
            xp = 10 * ((xp + 5) / 10);
        else if (xp <= 1000)
            xp = 25 * ((xp + 12) / 25);
        else
            xp = 50 * ((xp + 25) / 50);

        return xp;
    }

    return 0;
}

int32 Quest::GetRewOrReqMoney() const
{
    if (RewardOrRequiredMoney <= 0)
        return RewardOrRequiredMoney;

    return int32(RewardOrRequiredMoney * sWorld->getRate(RATE_DROP_MONEY));
}

uint32 Quest::GetRewMoneyMaxLevel() const
{
    if (HasFlag(QUEST_FLAGS_NO_MONEY_FROM_XP))
        return 0;

    return RewardMoneyMaxLevel;
}

bool Quest::IsAutoAccept() const
{
    return sWorld->getBoolConfig(CONFIG_QUEST_IGNORE_AUTO_ACCEPT) ? false : (Flags & QUEST_FLAGS_AUTO_ACCEPT);
}

bool Quest::IsAutoComplete() const
{
    return sWorld->getBoolConfig(CONFIG_QUEST_IGNORE_AUTO_COMPLETE) ? false : (Method == 0 || HasFlag(QUEST_FLAGS_AUTOCOMPLETE));
}

bool Quest::IsRaidQuest(Difficulty difficulty) const
{
    switch (Type)
    {
        case QUEST_TYPE_RAID:
            return true;
        case QUEST_TYPE_RAID_10:
            return !(difficulty & RAID_DIFFICULTY_MASK_25MAN);
        case QUEST_TYPE_RAID_25:
            return difficulty & RAID_DIFFICULTY_MASK_25MAN;
        default:
            break;
    }

    return false;
}

bool Quest::IsAllowedInRaid(Difficulty difficulty) const
{
    if (IsRaidQuest(difficulty))
        return true;

    return sWorld->getBoolConfig(CONFIG_QUEST_IGNORE_RAID);
}

uint32 Quest::CalculateHonorGain(uint8 level) const
{
    if (level > GT_MAX_LEVEL)
        level = GT_MAX_LEVEL;

    uint32 honor = 0;

    if (GetRewHonorAddition() > 0 || GetRewHonorMultiplier() > 0.0f)
    {
        // values stored from 0.. for 1...
        TeamContributionPointsEntry const* tc = sTeamContributionPointsStore.LookupEntry(level);
        if (!tc)
            return 0;
        honor = uint32(tc->value * GetRewHonorMultiplier() * 0.1000000014901161);

        // Xinef: exactly this is calculated above, however with higher precision...
        //honor += Trinity::Honor::hk_honor_at_level(level, GetRewHonorMultiplier());
        honor += GetRewHonorAddition();
    }

    return honor;
}

void Quest::InitializeQueryData()
{
    queryData.Initialize(SMSG_QUEST_QUERY_RESPONSE, 1);

    queryData << uint32(GetQuestId());                    // quest id
    queryData << uint32(GetQuestMethod());                // Accepted values: 0, 1 or 2. 0 == IsAutoComplete() (skip objectives/details)
    queryData << uint32(GetQuestLevel());                 // may be -1, static data, in other cases must be used dynamic level: Player::GetQuestLevel (0 is not known, but assuming this is no longer valid for quest intended for client)
    queryData << uint32(GetMinLevel());                   // min level
    queryData << uint32(GetZoneOrSort());                 // zone or sort to display in quest log

    queryData << uint32(GetType());                       // quest type
    queryData << uint32(GetSuggestedPlayers());           // suggested players count

    queryData << uint32(GetRepObjectiveFaction());        // shown in quest log as part of quest objective
    queryData << uint32(GetRepObjectiveValue());          // shown in quest log as part of quest objective

    queryData << uint32(GetRepObjectiveFaction2());       // shown in quest log as part of quest objective OPPOSITE faction
    queryData << uint32(GetRepObjectiveValue2());         // shown in quest log as part of quest objective OPPOSITE faction

    queryData << uint32(GetNextQuestInChain());           // client will request this quest from NPC, if not 0
    queryData << uint32(GetXPId());                       // used for calculating rewarded experience

    if (HasFlag(QUEST_FLAGS_HIDDEN_REWARDS))
        queryData << uint32(0);                                  // Hide money rewarded
    else
        queryData << uint32(GetRewOrReqMoney());          // reward money (below max lvl)

    queryData << uint32(GetRewMoneyMaxLevel());           // used in XP calculation at client
    queryData << uint32(GetRewSpell());                   // reward spell, this spell will display (icon) (casted if RewSpellCast == 0)
    queryData << int32(GetRewSpellCast());                // casted spell

    // rewarded honor points
    queryData << uint32(GetRewHonorAddition());
    queryData << float(GetRewHonorMultiplier());
    queryData << uint32(GetSrcItemId());                  // source item id
    queryData << uint32(GetFlags() & 0xFFFF);             // quest flags
    queryData << uint32(GetCharTitleId());                // CharTitleId, new 2.4.0, player gets this title (id from CharTitles)
    queryData << uint32(GetPlayersSlain());               // players slain
    queryData << uint32(GetBonusTalents());               // bonus talents
    queryData << uint32(GetRewArenaPoints());             // bonus arena points
    queryData << uint32(0);                                      // review rep show mask

    if (HasFlag(QUEST_FLAGS_HIDDEN_REWARDS))
    {
        for (uint32 i = 0; i < QUEST_REWARDS_COUNT; ++i)
            queryData << uint32(0) << uint32(0);
        for (uint32 i = 0; i < QUEST_REWARD_CHOICES_COUNT; ++i)
            queryData << uint32(0) << uint32(0);
    }
    else
    {
        for (uint32 i = 0; i < QUEST_REWARDS_COUNT; ++i)
        {
            queryData << uint32(RewardItemId[i]);
            queryData << uint32(RewardItemIdCount[i]);
        }
        for (uint32 i = 0; i < QUEST_REWARD_CHOICES_COUNT; ++i)
        {
            queryData << uint32(RewardChoiceItemId[i]);
            queryData << uint32(RewardChoiceItemCount[i]);
        }
    }

    for (uint32 i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)        // reward factions ids
        queryData << uint32(RewardFactionId[i]);

    for (uint32 i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)        // columnid+1 QuestFactionReward.dbc?
        queryData << int32(RewardFactionValueId[i]);

    for (int i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)           // unk (0)
        queryData << int32(RewardFactionValueIdOverride[i]);

    queryData << GetPointMapId();
    queryData << GetPointX();
    queryData << GetPointY();
    queryData << GetPointOpt();

    queryData << GetTitle();
    queryData << GetObjectives();
    queryData << GetDetails();
    queryData << GetEndText();
    queryData << GetCompletedText();                                  // display in quest objectives window once all objectives are completed

    for (uint32 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
    {
        if (RequiredNpcOrGo[i] < 0)
            queryData << uint32((RequiredNpcOrGo[i] * (-1)) | 0x80000000);    // client expects gameobject template id in form (id|0x80000000)
        else
            queryData << uint32(RequiredNpcOrGo[i]);

        queryData << uint32(RequiredNpcOrGoCount[i]);
        queryData << uint32(RequiredSourceItemId[i]);
        queryData << uint32(0);                                  // req source count?
    }

    for (uint32 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
    {
        queryData << uint32(RequiredItemId[i]);
        queryData << uint32(RequiredItemCount[i]);
    }

    for (uint32 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
        queryData << ObjectiveText[i];
}
