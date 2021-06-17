/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "GossipDef.h"
#include "Formulas.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "QuestDef.h"
#include "WorldPacket.h"
#include "WorldSession.h"

GossipMenu::GossipMenu()
{
    _menuId = 0;
    _locale = DEFAULT_LOCALE;
}

GossipMenu::~GossipMenu()
{
    ClearMenu();
}

void GossipMenu::AddMenuItem(int32 menuItemId, uint8 icon, std::string const& message, uint32 sender, uint32 action, std::string const& boxMessage, uint32 boxMoney, bool coded /*= false*/)
{
    ASSERT(_menuItems.size() <= GOSSIP_MAX_MENU_ITEMS);

    // Find a free new id - script case
    if (menuItemId == -1)
    {
        menuItemId = 0;
        if (!_menuItems.empty())
        {
            for (GossipMenuItemContainer::const_iterator itr = _menuItems.begin(); itr != _menuItems.end(); ++itr)
            {
                if (int32(itr->first) > menuItemId)
                    break;

                menuItemId = itr->first + 1;
            }
        }
    }

    GossipMenuItem& menuItem = _menuItems[menuItemId];

    menuItem.MenuItemIcon    = icon;
    menuItem.Message         = message;
    menuItem.IsCoded         = coded;
    menuItem.Sender          = sender;
    menuItem.OptionType      = action;
    menuItem.BoxMessage      = boxMessage;
    menuItem.BoxMoney        = boxMoney;
}

/**
 * @name AddMenuItem
 * @brief Adds a localized gossip menu item from db by menu id and menu item id.
 * @param menuId Gossip menu id.
 * @param menuItemId Gossip menu item id.
 * @param sender Identifier of the current menu.
 * @param action Custom action given to OnGossipHello.
 */
void GossipMenu::AddMenuItem(uint32 menuId, uint32 menuItemId, uint32 sender, uint32 action)
{
    /// Find items for given menu id.
    GossipMenuItemsMapBounds bounds = sObjectMgr->GetGossipMenuItemsMapBounds(menuId);
    /// Return if there are none.
    if (bounds.first == bounds.second)
        return;

    /// Iterate over each of them.
    for (GossipMenuItemsContainer::const_iterator itr = bounds.first; itr != bounds.second; ++itr)
    {
        /// Find the one with the given menu item id.
        if (itr->second.OptionID != menuItemId)
            continue;

        /// Store texts for localization.
        std::string strOptionText, strBoxText;
        BroadcastText const* optionBroadcastText = sObjectMgr->GetBroadcastText(itr->second.OptionBroadcastTextID);
        BroadcastText const* boxBroadcastText = sObjectMgr->GetBroadcastText(itr->second.BoxBroadcastTextID);

        /// OptionText
        if (optionBroadcastText)
            ObjectMgr::GetLocaleString(optionBroadcastText->MaleText, GetLocale(), strOptionText);
        else
            strOptionText = itr->second.OptionText;

        /// BoxText
        if (boxBroadcastText)
            ObjectMgr::GetLocaleString(boxBroadcastText->MaleText, GetLocale(), strBoxText);
        else
            strBoxText = itr->second.BoxText;

        /// Check need of localization.
        if (GetLocale() != DEFAULT_LOCALE)
        {
            if (!optionBroadcastText)
            {
                /// Find localizations from database.
                if (GossipMenuItemsLocale const* gossipMenuLocale = sObjectMgr->GetGossipMenuItemsLocale(MAKE_PAIR32(menuId, menuItemId)))
                    ObjectMgr::GetLocaleString(gossipMenuLocale->OptionText, GetLocale(), strOptionText);
            }

            if (!boxBroadcastText)
            {
                /// Find localizations from database.
                if (GossipMenuItemsLocale const* gossipMenuLocale = sObjectMgr->GetGossipMenuItemsLocale(MAKE_PAIR32(menuId, menuItemId)))
                    ObjectMgr::GetLocaleString(gossipMenuLocale->BoxText, GetLocale(), strBoxText);
            }
        }

        /// Add menu item with existing method. Menu item id -1 is also used in ADD_GOSSIP_ITEM macro.
        AddMenuItem(-1, itr->second.OptionIcon, strOptionText, sender, action, strBoxText, itr->second.BoxMoney, itr->second.BoxCoded);
    }
}

void GossipMenu::AddGossipMenuItemData(uint32 menuItemId, uint32 gossipActionMenuId, uint32 gossipActionPoi)
{
    GossipMenuItemData& itemData = _menuItemData[menuItemId];

    itemData.GossipActionMenuId  = gossipActionMenuId;
    itemData.GossipActionPoi     = gossipActionPoi;
}

uint32 GossipMenu::GetMenuItemSender(uint32 menuItemId) const
{
    GossipMenuItemContainer::const_iterator itr = _menuItems.find(menuItemId);
    if (itr == _menuItems.end())
        return 0;

    return itr->second.Sender;
}

uint32 GossipMenu::GetMenuItemAction(uint32 menuItemId) const
{
    GossipMenuItemContainer::const_iterator itr = _menuItems.find(menuItemId);
    if (itr == _menuItems.end())
        return 0;

    return itr->second.OptionType;
}

bool GossipMenu::IsMenuItemCoded(uint32 menuItemId) const
{
    GossipMenuItemContainer::const_iterator itr = _menuItems.find(menuItemId);
    if (itr == _menuItems.end())
        return false;

    return itr->second.IsCoded;
}

void GossipMenu::ClearMenu()
{
    _menuItems.clear();
    _menuItemData.clear();
}

PlayerMenu::PlayerMenu(WorldSession* session) : _session(session)
{
    _gossipMenu.SetLocale(session->GetSessionDbLocaleIndex());
}

PlayerMenu::~PlayerMenu()
{
    ClearMenus();
}

void PlayerMenu::ClearMenus()
{
    _gossipMenu.ClearMenu();
    _questMenu.ClearMenu();
}

void PlayerMenu::SendGossipMenu(uint32 titleTextId, ObjectGuid objectGUID) const
{
    WorldPacket data(SMSG_GOSSIP_MESSAGE, 24 + _gossipMenu.GetMenuItemCount() * 100 + _questMenu.GetMenuItemCount() * 75);     // guess size
    data << objectGUID;
    data << uint32(_gossipMenu.GetMenuId());            // new 2.4.0
    data << uint32(titleTextId);
    data << uint32(_gossipMenu.GetMenuItemCount());     // max count 0x10

    for (GossipMenuItemContainer::const_iterator itr = _gossipMenu.GetMenuItems().begin(); itr != _gossipMenu.GetMenuItems().end(); ++itr)
    {
        GossipMenuItem const& item = itr->second;
        data << uint32(itr->first);
        data << uint8(item.MenuItemIcon);
        data << uint8(item.IsCoded);                    // makes pop up box password
        data << uint32(item.BoxMoney);                  // money required to open menu, 2.0.3
        data << item.Message;                           // text for gossip item
        data << item.BoxMessage;                        // accept text (related to money) pop up box, 2.0.3
    }

    data << uint32(_questMenu.GetMenuItemCount());      // max count 0x20
    uint32 count = 0;

    for (uint32 iI = 0; iI < _questMenu.GetMenuItemCount(); ++iI)
    {
        ++count;
        QuestMenuItem const& item = _questMenu.GetItem(iI);
        uint32 questID = item.QuestId;
        if (Quest const* quest = sObjectMgr->GetQuestTemplate(questID))
        {
            data << uint32(questID);
            data << uint32(item.QuestIcon);
            data << int32(quest->GetQuestLevel());
            data << uint32(quest->GetFlags());              // 3.3.3 quest flags
            data << uint8(0);                               // 3.3.3 changes icon: blue question or yellow exclamation
            std::string title = quest->GetTitle();

            int32 locale = _session->GetSessionDbLocaleIndex();
            if (QuestLocale const* localeData = sObjectMgr->GetQuestLocale(questID))
                ObjectMgr::GetLocaleString(localeData->Title, locale, title);
            data << title;
        }
    }

    _session->SendPacket(&data);
}

void PlayerMenu::SendCloseGossip() const
{
    WorldPacket data(SMSG_GOSSIP_COMPLETE, 0);
    _session->SendPacket(&data);
}

void PlayerMenu::SendPointOfInterest(uint32 poiId) const
{
    PointOfInterest const* poi = sObjectMgr->GetPointOfInterest(poiId);
    if (!poi)
    {
        LOG_ERROR("sql.sql", "Request to send non-existing POI (Id: %u), ignored.", poiId);
        return;
    }

    std::string name = poi->Name;
    int32 locale = _session->GetSessionDbLocaleIndex();
    if (PointOfInterestLocale const* localeData = sObjectMgr->GetPointOfInterestLocale(poiId))
        ObjectMgr::GetLocaleString(localeData->Name, locale, name);

    WorldPacket data(SMSG_GOSSIP_POI, 4 + 4 + 4 + 4 + 4 + 20);  // guess size
    data << uint32(poi->Flags);
    data << float(poi->PositionX);
    data << float(poi->PositionY);
    data << uint32(poi->Icon);
    data << uint32(poi->Importance);
    data << name;

    _session->SendPacket(&data);
}

/*********************************************************/
/***                    QUEST SYSTEM                   ***/
/*********************************************************/

QuestMenu::QuestMenu()
{
    _questMenuItems.reserve(16);                                   // can be set for max from most often sizes to speedup push_back and less memory use
}

QuestMenu::~QuestMenu()
{
    ClearMenu();
}

void QuestMenu::AddMenuItem(uint32 QuestId, uint8 Icon)
{
    if (!sObjectMgr->GetQuestTemplate(QuestId))
        return;

    ASSERT(_questMenuItems.size() <= GOSSIP_MAX_MENU_ITEMS);

    QuestMenuItem questMenuItem;

    questMenuItem.QuestId        = QuestId;
    questMenuItem.QuestIcon      = Icon;

    _questMenuItems.push_back(questMenuItem);
}

bool QuestMenu::HasItem(uint32 questId) const
{
    for (QuestMenuItemList::const_iterator i = _questMenuItems.begin(); i != _questMenuItems.end(); ++i)
        if (i->QuestId == questId)
            return true;

    return false;
}

void QuestMenu::ClearMenu()
{
    _questMenuItems.clear();
}

void PlayerMenu::SendQuestGiverQuestList(QEmote const& eEmote, const std::string& Title, ObjectGuid npcGUID)
{
    WorldPacket data(SMSG_QUESTGIVER_QUEST_LIST, 100 + _questMenu.GetMenuItemCount() * 75);  // guess size
    data << npcGUID;
    data << Title;
    data << uint32(eEmote._Delay);                         // player emote
    data << uint32(eEmote._Emote);                         // NPC emote

    size_t count_pos = data.wpos();
    data << uint8 (_questMenu.GetMenuItemCount());
    uint32 count = 0;
    for (uint32 iI = 0; iI < _questMenu.GetMenuItemCount(); ++iI)
    {
        QuestMenuItem const& qmi = _questMenu.GetItem(iI);

        uint32 questID = qmi.QuestId;

        if (Quest const* quest = sObjectMgr->GetQuestTemplate(questID))
        {
            ++count;
            std::string title = quest->GetTitle();

            int32 locale = _session->GetSessionDbLocaleIndex();
            if (QuestLocale const* localeData = sObjectMgr->GetQuestLocale(questID))
                ObjectMgr::GetLocaleString(localeData->Title, locale, title);

            data << uint32(questID);
            data << uint32(qmi.QuestIcon);
            data << int32(quest->GetQuestLevel());
            data << uint32(quest->GetFlags());             // 3.3.3 quest flags
            data << uint8(0);                               // 3.3.3 changes icon: blue question or yellow exclamation
            data << title;
        }
    }

    data.put<uint8>(count_pos, count);
    _session->SendPacket(&data);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: Sent SMSG_QUESTGIVER_QUEST_LIST NPC %s", npcGUID.ToString().c_str());
#endif
}

void PlayerMenu::SendQuestGiverStatus(uint8 questStatus, ObjectGuid npcGUID) const
{
    WorldPacket data(SMSG_QUESTGIVER_STATUS, 9);
    data << npcGUID;
    data << uint8(questStatus);

    _session->SendPacket(&data);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: Sent SMSG_QUESTGIVER_STATUS NPC %s, status=%u", npcGUID.ToString().c_str(), questStatus);
#endif
}

void PlayerMenu::SendQuestGiverQuestDetails(Quest const* quest, ObjectGuid npcGUID, bool activateAccept) const
{
    std::string questTitle           = quest->GetTitle();
    std::string questDetails         = quest->GetDetails();
    std::string questObjectives      = quest->GetObjectives();
    std::string questAreaDescription = quest->GetAreaDescription();

    int32 locale = _session->GetSessionDbLocaleIndex();
    if (QuestLocale const* localeData = sObjectMgr->GetQuestLocale(quest->GetQuestId()))
    {
        ObjectMgr::GetLocaleString(localeData->Title, locale, questTitle);
        ObjectMgr::GetLocaleString(localeData->Details, locale, questDetails);
        ObjectMgr::GetLocaleString(localeData->Objectives, locale, questObjectives);
        ObjectMgr::GetLocaleString(localeData->AreaDescription, locale, questAreaDescription);
    }

    WorldPacket data(SMSG_QUESTGIVER_QUEST_DETAILS, 500);   // guess size
    data << npcGUID;
    data << _session->GetPlayer()->GetDivider();
    data << uint32(quest->GetQuestId());
    data << questTitle;
    data << questDetails;
    data << questObjectives;
    data << uint8(activateAccept ? 1 : 0);                  // auto finish
    data << uint32(quest->GetFlags());                      // 3.3.3 questFlags
    data << uint32(quest->GetSuggestedPlayers());
    data << uint8(0);                                       // IsFinished? value is sent back to server in quest accept packet

    if (quest->HasFlag(QUEST_FLAGS_HIDDEN_REWARDS))
    {
        data << uint32(0);                                  // Rewarded chosen items hidden
        data << uint32(0);                                  // Rewarded items hidden
        data << uint32(0);                                  // Rewarded money hidden
        data << uint32(0);                                  // Rewarded XP hidden
    }
    else
    {
        data << uint32(quest->GetRewChoiceItemsCount());
        for (uint32 i = 0; i < QUEST_REWARD_CHOICES_COUNT; ++i)
        {
            if (!quest->RewardChoiceItemId[i])
                continue;

            data << uint32(quest->RewardChoiceItemId[i]);
            data << uint32(quest->RewardChoiceItemCount[i]);

            if (ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(quest->RewardChoiceItemId[i]))
                data << uint32(itemTemplate->DisplayInfoID);
            else
                data << uint32(0x00);
        }

        data << uint32(quest->GetRewItemsCount());

        for (uint32 i = 0; i < QUEST_REWARDS_COUNT; ++i)
        {
            if (!quest->RewardItemId[i])
                continue;

            data << uint32(quest->RewardItemId[i]);
            data << uint32(quest->RewardItemIdCount[i]);

            if (ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(quest->RewardItemId[i]))
                data << uint32(itemTemplate->DisplayInfoID);
            else
                data << uint32(0);
        }

        data << uint32(quest->GetRewOrReqMoney());
        data << uint32(quest->XPValue(_session->GetPlayer()) * _session->GetPlayer()->GetQuestRate());
    }

    // rewarded honor points. Multiply with 10 to satisfy client
    data << uint32(10 * quest->CalculateHonorGain(_session->GetPlayer()->GetQuestLevel(quest)));
    data << float(0.0f);                                    // unk, honor multiplier?
    data << uint32(quest->GetRewSpell());                   // reward spell, this spell will display (icon) (casted if RewSpellCast == 0)
    data << int32(quest->GetRewSpellCast());                // casted spell
    data << uint32(quest->GetCharTitleId());                // CharTitleId, new 2.4.0, player gets this title (id from CharTitles)
    data << uint32(quest->GetBonusTalents());               // bonus talents
    data << uint32(quest->GetRewArenaPoints());             // reward arena points
    data << uint32(0);                                      // unk

    for (uint32 i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)
        data << uint32(quest->RewardFactionId[i]);

    for (uint32 i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)
        data << int32(quest->RewardFactionValueId[i]);

    for (uint32 i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)
        data << int32(quest->RewardFactionValueIdOverride[i]);

    data << uint32(QUEST_EMOTE_COUNT);
    for (uint32 i = 0; i < QUEST_EMOTE_COUNT; ++i)
    {
        data << uint32(quest->DetailsEmote[i]);
        data << uint32(quest->DetailsEmoteDelay[i]);       // DetailsEmoteDelay (in ms)
    }
    _session->SendPacket(&data);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: Sent SMSG_QUESTGIVER_QUEST_DETAILS %s, questid=%u", npcGUID.ToString().c_str(), quest->GetQuestId());
#endif
}

void PlayerMenu::SendQuestQueryResponse(Quest const* quest) const
{
    std::string questTitle           = quest->GetTitle();
    std::string questDetails         = quest->GetDetails();
    std::string questObjectives      = quest->GetObjectives();
    std::string questAreaDescription = quest->GetAreaDescription();
    std::string questCompletedText   = quest->GetCompletedText();

    std::string questObjectiveText[QUEST_OBJECTIVES_COUNT];
    for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
        questObjectiveText[i] = quest->ObjectiveText[i];

    int32 locale = _session->GetSessionDbLocaleIndex();
    if (QuestLocale const* localeData = sObjectMgr->GetQuestLocale(quest->GetQuestId()))
    {
        ObjectMgr::GetLocaleString(localeData->Title, locale, questTitle);
        ObjectMgr::GetLocaleString(localeData->Details, locale, questDetails);
        ObjectMgr::GetLocaleString(localeData->Objectives, locale, questObjectives);
        ObjectMgr::GetLocaleString(localeData->AreaDescription, locale, questAreaDescription);
        ObjectMgr::GetLocaleString(localeData->CompletedText, locale, questCompletedText);

        for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
            ObjectMgr::GetLocaleString(localeData->ObjectiveText[i], locale, questObjectiveText[i]);
    }

    WorldPacket data(SMSG_QUEST_QUERY_RESPONSE, 100);       // guess size

    data << uint32(quest->GetQuestId());                    // quest id
    data << uint32(quest->GetQuestMethod());                // Accepted values: 0, 1 or 2. 0 == IsAutoComplete() (skip objectives/details)
    data << uint32(quest->GetQuestLevel());                 // may be -1, static data, in other cases must be used dynamic level: Player::GetQuestLevel (0 is not known, but assuming this is no longer valid for quest intended for client)
    data << uint32(quest->GetMinLevel());                   // min level
    data << uint32(quest->GetZoneOrSort());                 // zone or sort to display in quest log

    data << uint32(quest->GetType());                       // quest type
    data << uint32(quest->GetSuggestedPlayers());           // suggested players count

    data << uint32(quest->GetRepObjectiveFaction());        // shown in quest log as part of quest objective
    data << uint32(quest->GetRepObjectiveValue());          // shown in quest log as part of quest objective

    data << uint32(quest->GetRepObjectiveFaction2());       // shown in quest log as part of quest objective OPPOSITE faction
    data << uint32(quest->GetRepObjectiveValue2());         // shown in quest log as part of quest objective OPPOSITE faction

    data << uint32(quest->GetNextQuestInChain());           // client will request this quest from NPC, if not 0
    data << uint32(quest->GetXPId());                       // used for calculating rewarded experience

    if (quest->HasFlag(QUEST_FLAGS_HIDDEN_REWARDS))
        data << uint32(0);                                  // Hide money rewarded
    else
        data << uint32(quest->GetRewOrReqMoney());          // reward money (below max lvl)

    data << uint32(quest->GetRewMoneyMaxLevel());           // used in XP calculation at client
    data << uint32(quest->GetRewSpell());                   // reward spell, this spell will display (icon) (cast if RewSpellCast == 0)
    data << int32(quest->GetRewSpellCast());                // cast spell

    // rewarded honor points
    data << uint32(quest->GetRewHonorAddition());
    data << float(quest->GetRewHonorMultiplier());
    data << uint32(quest->GetSrcItemId());                  // source item id
    data << uint32(quest->GetFlags() & 0xFFFF);             // quest flags
    data << uint32(quest->GetCharTitleId());                // CharTitleId, new 2.4.0, player gets this title (id from CharTitles)
    data << uint32(quest->GetPlayersSlain());               // players slain
    data << uint32(quest->GetBonusTalents());               // bonus talents
    data << uint32(quest->GetRewArenaPoints());             // bonus arena points
    data << uint32(0);                                      // review rep show mask

    if (quest->HasFlag(QUEST_FLAGS_HIDDEN_REWARDS))
    {
        for (uint8 i = 0; i < QUEST_REWARDS_COUNT; ++i)
            data << uint32(0) << uint32(0);
        for (uint8 i = 0; i < QUEST_REWARD_CHOICES_COUNT; ++i)
            data << uint32(0) << uint32(0);
    }
    else
    {
        for (uint8 i = 0; i < QUEST_REWARDS_COUNT; ++i)
        {
            data << uint32(quest->RewardItemId[i]);
            data << uint32(quest->RewardItemIdCount[i]);
        }
        for (uint8 i = 0; i < QUEST_REWARD_CHOICES_COUNT; ++i)
        {
            data << uint32(quest->RewardChoiceItemId[i]);
            data << uint32(quest->RewardChoiceItemCount[i]);
        }
    }

    for (uint8 i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)        // reward factions ids
        data << uint32(quest->RewardFactionId[i]);

    for (uint8 i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)        // columnid+1 QuestFactionReward.dbc?
        data << int32(quest->RewardFactionValueId[i]);

    for (uint8 i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)        // unk (0)
        data << int32(quest->RewardFactionValueIdOverride[i]);

    data << uint32(quest->GetPOIContinent());
    data << float(quest->GetPOIx());
    data << float(quest->GetPOIy());
    data << uint32(quest->GetPointOpt());

    data << questTitle;
    data << questObjectives;
    data << questDetails;
    data << questAreaDescription;
    data << questCompletedText;                                 // display in quest objectives window once all objectives are completed

    for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
    {
        if (quest->RequiredNpcOrGo[i] < 0)
            data << uint32((quest->RequiredNpcOrGo[i] * (-1)) | 0x80000000);    // client expects gameobject template id in form (id|0x80000000)
        else
            data << uint32(quest->RequiredNpcOrGo[i]);

        data << uint32(quest->RequiredNpcOrGoCount[i]);
        data << uint32(quest->ItemDrop[i]);
        data << uint32(0);                                  // req source count?
    }

    for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
    {
        data << uint32(quest->RequiredItemId[i]);
        data << uint32(quest->RequiredItemCount[i]);
    }

    for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
        data << questObjectiveText[i];

    _session->SendPacket(&data);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: Sent SMSG_QUEST_QUERY_RESPONSE questid=%u", quest->GetQuestId());
#endif
}

void PlayerMenu::SendQuestGiverOfferReward(Quest const* quest, ObjectGuid npcGUID, bool enableNext) const
{
    std::string questTitle = quest->GetTitle();
    std::string RewardText = quest->GetOfferRewardText();

    int32 locale = _session->GetSessionDbLocaleIndex();
    if (QuestLocale const* localeData = sObjectMgr->GetQuestLocale(quest->GetQuestId()))
        ObjectMgr::GetLocaleString(localeData->Title, locale, questTitle);

    if (QuestOfferRewardLocale const* questOfferRewardLocale = sObjectMgr->GetQuestOfferRewardLocale(quest->GetQuestId()))
        ObjectMgr::GetLocaleString(questOfferRewardLocale->RewardText, locale, RewardText);

    WorldPacket data(SMSG_QUESTGIVER_OFFER_REWARD, 400);    // guess size
    data << npcGUID;
    data << uint32(quest->GetQuestId());
    data << questTitle;
    data << RewardText;

    data << uint8(enableNext ? 1 : 0);                      // Auto Finish
    data << uint32(quest->GetFlags());                      // 3.3.3 questFlags
    data << uint32(quest->GetSuggestedPlayers());           // SuggestedGroupNum

    uint32 emoteCount = 0;
    for (uint32 i = 0; i < QUEST_EMOTE_COUNT; ++i)
    {
        if (quest->OfferRewardEmote[i] <= 0)
            break;
        ++emoteCount;
    }

    data << emoteCount;                                     // Emote Count
    for (uint32 i = 0; i < emoteCount; ++i)
    {
        data << uint32(quest->OfferRewardEmoteDelay[i]);    // Delay Emote
        data << uint32(quest->OfferRewardEmote[i]);
    }

    data << uint32(quest->GetRewChoiceItemsCount());
    for (uint32 i = 0; i < quest->GetRewChoiceItemsCount(); ++i)
    {
        data << uint32(quest->RewardChoiceItemId[i]);
        data << uint32(quest->RewardChoiceItemCount[i]);

        if (ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(quest->RewardChoiceItemId[i]))
            data << uint32(itemTemplate->DisplayInfoID);
        else
            data << uint32(0);
    }

    data << uint32(quest->GetRewItemsCount());
    for (uint32 i = 0; i < quest->GetRewItemsCount(); ++i)
    {
        data << uint32(quest->RewardItemId[i]);
        data << uint32(quest->RewardItemIdCount[i]);

        if (ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(quest->RewardItemId[i]))
            data << uint32(itemTemplate->DisplayInfoID);
        else
            data << uint32(0);
    }

    data << uint32(quest->GetRewOrReqMoney());
    data << uint32(quest->XPValue(_session->GetPlayer()) * _session->GetPlayer()->GetQuestRate());

    // rewarded honor points. Multiply with 10 to satisfy client
    data << uint32(10 * quest->CalculateHonorGain(_session->GetPlayer()->GetQuestLevel(quest)));
    data << float(0.0f);                                    // unk, honor multiplier?
    data << uint32(0x08);                                   // unused by client?
    data << uint32(quest->GetRewSpell());                   // reward spell, this spell will display (icon) (casted if RewSpellCast == 0)
    data << int32(quest->GetRewSpellCast());                // casted spell
    data << uint32(quest->GetCharTitleId());                // CharTitleId, new 2.4.0, player gets this title (id from CharTitles)
    data << uint32(quest->GetBonusTalents());               // bonus talents
    data << uint32(quest->GetRewArenaPoints());             // arena points
    data << uint32(0);

    for (uint32 i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)    // reward factions ids
        data << uint32(quest->RewardFactionId[i]);

    for (uint32 i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)    // columnid in QuestFactionReward.dbc (zero based)?
        data << int32(quest->RewardFactionValueId[i]);

    for (uint32 i = 0; i < QUEST_REPUTATIONS_COUNT; ++i)    // reward reputation override?
        data << uint32(quest->RewardFactionValueIdOverride[i]);

    _session->SendPacket(&data);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: Sent SMSG_QUESTGIVER_OFFER_REWARD %s, questid=%u", npcGUID.ToString().c_str(), quest->GetQuestId());
#endif
}

void PlayerMenu::SendQuestGiverRequestItems(Quest const* quest, ObjectGuid npcGUID, bool canComplete, bool closeOnCancel) const
{
    // We can always call to RequestItems, but this packet only goes out if there are actually
    // items.  Otherwise, we'll skip straight to the OfferReward

    std::string questTitle = quest->GetTitle();
    std::string requestItemsText = quest->GetRequestItemsText();

    int32 locale = _session->GetSessionDbLocaleIndex();
    if (QuestLocale const* localeData = sObjectMgr->GetQuestLocale(quest->GetQuestId()))
        ObjectMgr::GetLocaleString(localeData->Title, locale, questTitle);

    if (QuestRequestItemsLocale const* questRequestItemsLocale = sObjectMgr->GetQuestRequestItemsLocale(quest->GetQuestId()))
        ObjectMgr::GetLocaleString(questRequestItemsLocale->CompletionText, locale, requestItemsText);

    if (!quest->GetReqItemsCount() && canComplete)
    {
        SendQuestGiverOfferReward(quest, npcGUID, true);
        return;
    }

    // Xinef: recheck completion on reward display
    Player* _player = _session->GetPlayer();
    QuestStatusMap::iterator qsitr = _player->getQuestStatusMap().find(quest->GetQuestId());
    if (qsitr != _player->getQuestStatusMap().end() && qsitr->second.Status == QUEST_STATUS_INCOMPLETE)
    {
        for (uint8 i = 0; i < 6; ++i)
            if (quest->RequiredItemId[i] && qsitr->second.ItemCount[i] < quest->RequiredItemCount[i])
                if (_player->GetItemCount(quest->RequiredItemId[i], false) >= quest->RequiredItemCount[i])
                    qsitr->second.ItemCount[i] = quest->RequiredItemCount[i];

        if (_player->CanCompleteQuest(quest->GetQuestId()))
        {
            _player->CompleteQuest(quest->GetQuestId());
            canComplete = true;
        }
    }

    WorldPacket data(SMSG_QUESTGIVER_REQUEST_ITEMS, 300);   // guess size
    data << npcGUID;
    data << uint32(quest->GetQuestId());
    data << questTitle;
    data << requestItemsText;

    data << uint32(0x00);                                   // unknown

    if (canComplete)
        data << quest->GetCompleteEmote();
    else
        data << quest->GetIncompleteEmote();

    // Close Window after cancel
    if (closeOnCancel)
        data << uint32(0x01);
    else
        data << uint32(0x00);

    data << uint32(quest->GetFlags());                      // 3.3.3 questFlags
    data << uint32(quest->GetSuggestedPlayers());           // SuggestedGroupNum

    // Required Money
    data << uint32(quest->GetRewOrReqMoney() < 0 ? -quest->GetRewOrReqMoney() : 0);

    data << uint32(quest->GetReqItemsCount());
    for (int i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
    {
        if (!quest->RequiredItemId[i])
            continue;

        data << uint32(quest->RequiredItemId[i]);
        data << uint32(quest->RequiredItemCount[i]);

        if (ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(quest->RequiredItemId[i]))
            data << uint32(itemTemplate->DisplayInfoID);
        else
            data << uint32(0);
    }

    if (!canComplete)
        data << uint32(0x00);
    else
        data << uint32(0x03);

    data << uint32(0x04);
    data << uint32(0x08);
    data << uint32(0x10);

    _session->SendPacket(&data);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: Sent SMSG_QUESTGIVER_REQUEST_ITEMS %s, questid=%u", npcGUID.ToString().c_str(), quest->GetQuestId());
#endif
}
