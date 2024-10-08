/*
* Copyright (C) 2010 - 2016 Eluna Lua Engine <http://emudevs.com/>
* This program is free software licensed under GPL version 3
* Please see the included DOCS/LICENSE.md for more information
*/

#ifndef ROLLMETHODS_H
#define ROLLMETHODS_H

#include "Group.h"

namespace LuaRoll
{
    /**
     * Returns the rolled [Item]'s GUID.
     *
     * @return ObjectGuid guid
     */
    int GetItemGUID(lua_State* L, Roll* roll)
    {
        Eluna::Push(L, roll->itemGUID.GetCounter());
        return 1;
    }

    /**
     * Returns the rolled [Item]'s entry.
     *
     * @return uint32 entry
     */
    int GetItemId(lua_State* L, Roll* roll)
    {
        Eluna::Push(L, roll->itemid);
        return 1;
    }

    /**
     * Returns the rolled [Item]'s random property ID.
     *
     * @return int32 randomPropId
     */
    int GetItemRandomPropId(lua_State* L, Roll* roll)
    {
        Eluna::Push(L, roll->itemRandomPropId);
        return 1;
    }

    /**
     * Returns the rolled [Item]'s random suffix ID.
     *
     * @return uint32 randomSuffix
     */
    int GetItemRandomSuffix(lua_State* L, Roll* roll)
    {
        Eluna::Push(L, roll->itemRandomSuffix);
        return 1;
    }

    /**
     * Returns the rolled [Item]'s count.
     *
     * @return uint8 count
     */
    int GetItemCount(lua_State* L, Roll* roll)
    {
        Eluna::Push(L, roll->itemCount);
        return 1;
    }

    /**
     * Returns the vote type for a [Player] on this [Roll].
     * See [Roll:GetPlayerVoteGUIDs] to obtain the GUIDs of the [Player]s who rolled.
     *
     * <pre>
     * enum RollVote
     * {
     *     PASS              = 0,
     *     NEED              = 1,
     *     GREED             = 2,
     *     DISENCHANT        = 3,
     *     NOT_EMITED_YET    = 4,
     *     NOT_VALID         = 5
     * };
     * </pre>
     *
     * @param ObjectGuid guid
     * @return [RollVote] vote
     */
    int GetPlayerVote(lua_State* L, Roll* roll)
    {
        ObjectGuid guid = Eluna::CHECKVAL<ObjectGuid>(L, 2);

        bool found = false;
        for (std::pair<const ObjectGuid, RollVote>& pair : roll->playerVote)
        {
            if (pair.first == guid)
            {
                Eluna::Push(L, pair.second);
                found = true;
            }
        }

        if (!found)
        {
            Eluna::Push(L);
        }

        return 1;
    }

    /**
     * Returns the GUIDs of the [Player]s who rolled.
     * See [Roll:GetPlayerVote] to obtain the vote type of a [Player].
     *
     * @return table guids
     */
    int GetPlayerVoteGUIDs(lua_State* L, Roll* roll)
    {
        lua_newtable(L);
        int table = lua_gettop(L);
        uint32 i = 1;
        for (std::pair<const ObjectGuid, RollVote>& pair : roll->playerVote)
        {
            Eluna::Push(L, pair.first);
            lua_rawseti(L, table, i);
            ++i;
        }

        lua_settop(L, table); // push table to top of stack
        return 1;
    }

    /**
     * Returns the total number of players who rolled.
     *
     * @return uint8 playersCount
     */
    int GetTotalPlayersRolling(lua_State* L, Roll* roll)
    {
        Eluna::Push(L, roll->totalPlayersRolling);
        return 1;
    }

    /**
     * Returns the total number of players who rolled need.
     *
     * @return uint8 playersCount
     */
    int GetTotalNeed(lua_State* L, Roll* roll)
    {
        Eluna::Push(L, roll->totalNeed);
        return 1;
    }

    /**
     * Returns the total number of players who rolled greed.
     *
     * @return uint8 playersCount
     */
    int GetTotalGreed(lua_State* L, Roll* roll)
    {
        Eluna::Push(L, roll->totalGreed);
        return 1;
    }

    /**
     * Returns the total number of players who passed.
     *
     * @return uint8 playersCount
     */
    int GetTotalPass(lua_State* L, Roll* roll)
    {
        Eluna::Push(L, roll->totalPass);
        return 1;
    }

    /**
     * Returns the rolled [Item]'s slot in the loot window.
     *
     * @return uint8 slot
     */
    int GetItemSlot(lua_State* L, Roll* roll)
    {
        Eluna::Push(L, roll->itemSlot);
        return 1;
    }

    /**
     * Returns the mask applied to this [Roll].
     *
     * <pre>
     * enum RollMask
     * {
     *     ROLL_FLAG_TYPE_PASS                 = 0x01,
     *     ROLL_FLAG_TYPE_NEED                 = 0x02,
     *     ROLL_FLAG_TYPE_GREED                = 0x04,
     *     ROLL_FLAG_TYPE_DISENCHANT           = 0x08,
     * 
     *     ROLL_ALL_TYPE_NO_DISENCHANT         = 0x07,
     *     ROLL_ALL_TYPE_MASK                  = 0x0F
     * };
     * </pre>
     *
     * @return [RollMask] rollMask
     */
    int GetRollVoteMask(lua_State* L, Roll* roll)
    {
        Eluna::Push(L, roll->rollVoteMask);
        return 1;
    }
}

#endif
