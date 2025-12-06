/*
* Copyright (C) 2010 - 2016 Eluna Lua Engine <http://emudevs.com/>
* This program is free software licensed under GPL version 3
* Please see the included DOCS/LICENSE.md for more information
*/

#ifndef GUILDMETHODS_H
#define GUILDMETHODS_H

/***
 * Inherits all methods from: none
 */
namespace LuaGuild
{
    /**
     * Returns a table with the [Player]s in this [Guild]
     *
     * Only the players that are online and on some map.
     *
     * @return table guildPlayers : table of [Player]s
     */
    int GetMembers(lua_State* L, Guild* guild)
    {
        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        {
            std::shared_lock<std::shared_mutex> lock(*HashMapHolder<Player>::GetLock());
            const HashMapHolder<Player>::MapType& m = eObjectAccessor()GetPlayers();
            for (HashMapHolder<Player>::MapType::const_iterator it = m.begin(); it != m.end(); ++it)
            {
                if (Player* player = it->second)
                {
                    if (player->IsInWorld() && player->GetGuildId() == guild->GetId())
                    {
                        Eluna::Push(L, player);
                        lua_rawseti(L, tbl, ++i);
                    }
                }
            }
        }

        lua_settop(L, tbl); // push table to top of stack
        return 1;
    }

    /**
     * Returns the member count of this [Guild]
     *
     * @return uint32 memberCount
     */
    int GetMemberCount(lua_State* L, Guild* guild)
    {
        Eluna::Push(L, guild->GetMemberCount());
        return 1;
    }

    /**
     * Finds and returns the [Guild] leader by their GUID if logged in
     *
     * @return [Player] leader
     */
    int GetLeader(lua_State* L, Guild* guild)
    {
        Eluna::Push(L, eObjectAccessor()FindPlayer(guild->GetLeaderGUID()));
        return 1;
    }

    /**
     * Returns [Guild] leader GUID
     *
     * @return ObjectGuid leaderGUID
     */
    int GetLeaderGUID(lua_State* L, Guild* guild)
    {
        Eluna::Push(L, guild->GetLeaderGUID());
        return 1;
    }

    /**
     * Returns the [Guild]s entry ID
     *
     * @return uint32 entryId
     */
    int GetId(lua_State* L, Guild* guild)
    {
        Eluna::Push(L, guild->GetId());
        return 1;
    }

    /**
     * Returns the [Guild]s name
     *
     * @return string guildName
     */
    int GetName(lua_State* L, Guild* guild)
    {
        Eluna::Push(L, guild->GetName());
        return 1;
    }

    /**
     * Returns the [Guild]s current Message Of The Day
     *
     * @return string guildMOTD
     */
    int GetMOTD(lua_State* L, Guild* guild)
    {
        Eluna::Push(L, guild->GetMOTD());
        return 1;
    }

    /**
     * Returns the [Guild]s current info
     *
     * @return string guildInfo
     */
    int GetInfo(lua_State* L, Guild* guild)
    {
        Eluna::Push(L, guild->GetInfo());
        return 1;
    }

    /**
     * Sets the leader of this [Guild]
     *
     * @param [Player] leader : the [Player] leader to change
     */
    int SetLeader(lua_State* L, Guild* guild)
    {
        Player* player = Eluna::CHECKOBJ<Player>(L, 2);

        guild->HandleSetLeader(player->GetSession(), player->GetName());
        return 0;
    }

    /**
     * Sets the information of the bank tab specified
     *
     * @param uint8 tabId : the ID of the tab specified
     * @param string info : the information to be set to the bank tab
     */
    int SetBankTabText(lua_State* L, Guild* guild)
    {
        uint8 tabId = Eluna::CHECKVAL<uint8>(L, 2);
        const char* text = Eluna::CHECKVAL<const char*>(L, 3);
        guild->SetBankTabText(tabId, text);
        return 0;
    }

    // SendPacketToGuild(packet)
    /**
     * Sends a [WorldPacket] to all the [Player]s in the [Guild]
     *
     * @param [WorldPacket] packet : the [WorldPacket] to be sent to the [Player]s
     */
    int SendPacket(lua_State* L, Guild* guild)
    {
        WorldPacket* data = Eluna::CHECKOBJ<WorldPacket>(L, 2);

        guild->BroadcastPacket(data);
        return 0;
    }

    // SendPacketToRankedInGuild(packet, rankId)
    /**
     * Sends a [WorldPacket] to all the [Player]s at the specified rank in the [Guild]
     *
     * @param [WorldPacket] packet : the [WorldPacket] to be sent to the [Player]s
     * @param uint8 rankId : the rank ID
     */
    int SendPacketToRanked(lua_State* L, Guild* guild)
    {
        WorldPacket* data = Eluna::CHECKOBJ<WorldPacket>(L, 2);
        uint8 ranked = Eluna::CHECKVAL<uint8>(L, 3);

        guild->BroadcastPacketToRank(data, ranked);
        return 0;
    }

    /**
     * Disbands the [Guild]
     */
    int Disband(lua_State* /*L*/, Guild* guild)
    {
        guild->Disband();
        return 0;
    }

    /**
     * Adds the specified [Player] to the [Guild] at the specified rank.
     *
     * If no rank is specified, defaults to none.
     *
     * @param [Player] player : the [Player] to be added to the guild
     * @param uint8 rankId : the rank ID
     */
    int AddMember(lua_State* L, Guild* guild)
    {
        Player* player = Eluna::CHECKOBJ<Player>(L, 2);
        uint8 rankId = Eluna::CHECKVAL<uint8>(L, 3, GUILD_RANK_NONE);

        guild->AddMember(player->GET_GUID(), rankId);
        return 0;
    }

    /**
     * Removes the specified [Player] from the [Guild].
     *
     * @param [Player] player : the [Player] to be removed from the guild
     * @param bool isDisbanding : default 'false', should only be set to 'true' if the guild is triggered to disband
     */
    int DeleteMember(lua_State* L, Guild* guild)
    {
        Player* player = Eluna::CHECKOBJ<Player>(L, 2);
        bool isDisbanding = Eluna::CHECKVAL<bool>(L, 3, false);

        guild->DeleteMember(player->GET_GUID(), isDisbanding);
        return 0;
    }

    /**
     * Promotes/demotes the [Player] to the specified rank.
     *
     * @param [Player] player : the [Player] to be promoted/demoted
     * @param uint8 rankId : the rank ID
     */
    int SetMemberRank(lua_State* L, Guild* guild)
    {
        Player* player = Eluna::CHECKOBJ<Player>(L, 2);
        uint8 newRank = Eluna::CHECKVAL<uint8>(L, 3);

        guild->ChangeMemberRank(player->GET_GUID(), newRank);
        return 0;
    }

    /**
     * Sets the new name of the specified [Guild].
     *
     * @param string name : new name of this guild
     */
    int SetName(lua_State* L, Guild* guild)
    {
        std::string name = Eluna::CHECKVAL<std::string>(L, 2);
        
        guild->SetName(name);
        return 0;
    }

    /**
     * Update [Player] data in [Guild] member list.
     * 
     *     enum GuildMemberData
     *     {
     *         GUILD_MEMBER_DATA_ZONEID =  0
     *         GUILD_MEMBER_DATA_LEVEL  =  1
     *     };
     * 
     *  @param [Player] player : plkayer you need to update data
     *  @param [GuildMemberData] dataid : data you need to update
     *  @param uint32 value
     */
    int UpdateMemberData(lua_State* L, Guild* guild)
    {
        Player* player = Eluna::CHECKOBJ<Player>(L, 2);
        uint8 dataid = Eluna::CHECKVAL<uint8>(L, 3);
        uint32 value = Eluna::CHECKVAL<uint32>(L, 4);

        guild->UpdateMemberData(player, dataid, value);
        return 0;
    }

    /**
     * Send message to [Guild] from specific [Player].
     * 
     * @param [Player] player : the [Player] is the author of the message
     * @param bool officierOnly : send message only on officier channel
     * @param string msg : the message you need to send
     * @param uint32 lang : language the [Player] will speak
     */
    int SendMessage(lua_State* L, Guild* guild)
    {
        Player* player = Eluna::CHECKOBJ<Player>(L, 2);
        bool officierOnly = Eluna::CHECKVAL<bool>(L, 3, false);
        std::string msg = Eluna::CHECKVAL<std::string>(L, 4);
        uint32 language = Eluna::CHECKVAL<uint32>(L, 5, false);

        guild->BroadcastToGuild(player->GetSession(), officierOnly, msg, language);
        return 0;
    }

    /**
     * Invites [Guild] members to events based on level and rank filters.
     * 
     * @param Player player : who sends the invitation
     * @param uint32 minLevel : the required min level
     * @param uint32 maxLevel : the required max level
     * @param uint32 minRank : the required min rank
     */
    int MassInviteToEvent(lua_State* L, Guild* guild)
    { 
        Player* player = Eluna::CHECKOBJ<Player>(L, 2);
        uint32 minLevel = Eluna::CHECKVAL<uint32>(L, 3);
        uint32 maxLevel = Eluna::CHECKVAL<uint32>(L, 4);
        uint32 minRank = Eluna::CHECKVAL<uint32>(L, 5);

        guild->MassInviteToEvent(player->GetSession(), minLevel, maxLevel, minRank);
        return 0;
    }

    /**
     * Swap item from a specific tab and slot [Guild] bank to another one.
     * 
     * @param [Player] player : who Swap the item
     * @param uint8 tabId : source tab id
     * @param uint8 slotId : source slot id
     * @param uint8 destTabId : destination tab id
     * @param uint8 destSlotId : destination slot id
     * @param uint8 splitedAmount : if the item is stackable, how much should be swaped
     */
    int SwapItems(lua_State* L, Guild* guild)
    { 
        Player* player = Eluna::CHECKOBJ<Player>(L, 2);
        uint8 tabId = Eluna::CHECKVAL<uint32>(L, 3);
        uint8 slotId = Eluna::CHECKVAL<uint32>(L, 4);
        uint8 destTabId = Eluna::CHECKVAL<uint32>(L, 5);
        uint8 destSlotId = Eluna::CHECKVAL<uint32>(L, 6);
        uint32 splitedAmount = Eluna::CHECKVAL<uint32>(L, 7);

        guild->SwapItems(player, tabId, slotId, destTabId, destSlotId, splitedAmount);
        return 0;
    }

    /**
     * Swap an item from a specific tab and location in the [guild] bank to the bags and locations in the inventory of a specific [player] and vice versa.
     * 
     * @param [Player] player : who Swap the item
     * @param bool toChar : the item goes to the [Player]'s inventory or comes from the [Player]'s inventory
     * @param uint8 tabId : tab id
     * @param uint8 slotId : slot id
     * @param uint8 playerBag : bag id
     * @param uint8 playerSlotId : slot id
     * @param uint32 splitedAmount : if the item is stackable, how much should be swaped
     */
    int SwapItemsWithInventory(lua_State* L, Guild* guild)
    { 
        Player* player = Eluna::CHECKOBJ<Player>(L, 2);
        bool toChar = Eluna::CHECKVAL<bool>(L, 3, false);
        uint8 tabId = Eluna::CHECKVAL<uint8>(L, 4);
        uint8 slotId = Eluna::CHECKVAL<uint8>(L, 5);
        uint8 playerBag = Eluna::CHECKVAL<uint8>(L, 6);
        uint8 playerSlotId = Eluna::CHECKVAL<uint8>(L, 7);
        uint32 splitedAmount = Eluna::CHECKVAL<uint32>(L, 8);

        guild->SwapItemsWithInventory(player, toChar, tabId, slotId, playerBag, playerSlotId, splitedAmount);
        return 0;
    }

    /**
     * Return the total bank money.
     * 
     * @return number totalBankMoney
     */
    int GetTotalBankMoney(lua_State* L, Guild* guild)
    { 
        Eluna::Push(L, guild->GetTotalBankMoney());
        return 1;
    }

    /**
     * Return the created date.
     * 
     * @return uint64 created date
     */
    int GetCreatedDate(lua_State* L, Guild* guild)
    { 
        Eluna::Push(L, guild->GetCreatedDate());
        return 1;
    }

    /**
     * Resets the number of item withdraw in all tab's for all [Guild] members.
     */
    int ResetTimes(lua_State* /*L*/, Guild* guild)
    { 
        guild->ResetTimes();
        return 0;
    }

    /**
     * Modify the [Guild] bank money. You can deposit or withdraw.
     * 
     * @param uint64 amount : amount to add or remove
     * @param bool add : true (add money) | false (withdraw money)
     * @return bool is_applied
     */
    int ModifyBankMoney(lua_State* L, Guild* guild)
    { 
        uint64 amount = Eluna::CHECKVAL<uint64>(L, 2);
        bool add = Eluna::CHECKVAL<bool>(L, 2);

        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        Eluna::Push(L, guild->ModifyBankMoney(trans, amount, add));

        CharacterDatabase.CommitTransaction(trans);
        return 1;
    }
};
#endif
