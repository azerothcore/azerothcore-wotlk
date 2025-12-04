/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef SCRIPT_OBJECT_ALL_BATTLEGROUND_SCRIPT_H_
#define SCRIPT_OBJECT_ALL_BATTLEGROUND_SCRIPT_H_

#include "ScriptObject.h"
#include <vector>

enum AllBattlegroundHook
{
    ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_START,
    ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_END_REWARD,
    ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_UPDATE,
    ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_ADD_PLAYER,
    ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_BEFORE_ADD_PLAYER,
    ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_REMOVE_PLAYER_AT_LEAVE,
    ALLBATTLEGROUNDHOOK_ON_QUEUE_UPDATE,
    ALLBATTLEGROUNDHOOK_ON_QUEUE_UPDATE_VALIDITY,
    ALLBATTLEGROUNDHOOK_ON_ADD_GROUP,
    ALLBATTLEGROUNDHOOK_CAN_FILL_PLAYERS_TO_BG,
    ALLBATTLEGROUNDHOOK_IS_CHECK_NORMAL_MATCH,
    ALLBATTLEGROUNDHOOK_CAN_SEND_MESSAGE_BG_QUEUE,
    ALLBATTLEGROUNDHOOK_ON_BEFORE_SEND_JOIN_MESSAGE_ARENA_QUEUE,
    ALLBATTLEGROUNDHOOK_ON_BEFORE_SEND_EXIT_MESSAGE_ARENA_QUEUE,
    ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_END,
    ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_DESTROY,
    ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_CREATE,
    ALLBATTLEGROUNDHOOK_END
};

enum BattlegroundBracketId : uint8;
enum BattlegroundTypeId : uint8;
enum TeamId : uint8;

class AllBattlegroundScript : public ScriptObject
{
protected:
    AllBattlegroundScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    /**
     * @brief This hook runs before start Battleground
     *
     * @param bg Contains information about the Battleground
     */
    virtual void OnBattlegroundStart(Battleground* /*bg*/) { }

    // End Battleground
    virtual void OnBattlegroundEndReward(Battleground* /*bg*/, Player* /*player*/, TeamId /*winnerTeamId*/) { }

    // Update Battlegroud
    virtual void OnBattlegroundUpdate(Battleground* /*bg*/, uint32 /*diff*/) { }

    // Add Player in Battlegroud
    virtual void OnBattlegroundAddPlayer(Battleground* /*bg*/, Player* /*player*/) { }

    // Before added player in Battlegroud
    virtual void OnBattlegroundBeforeAddPlayer(Battleground* /*bg*/, Player* /*player*/) { }

    // Remove player at leave BG
    virtual void OnBattlegroundRemovePlayerAtLeave(Battleground* /*bg*/, Player* /*player*/) { }

    virtual void OnQueueUpdate(BattlegroundQueue* /*queue*/, uint32 /* diff */, BattlegroundTypeId /* bgTypeId */, BattlegroundBracketId /* bracket_id */, uint8 /* arenaType */, bool /* isRated */, uint32 /* arenaRating */) { }

    [[nodiscard]] virtual bool OnQueueUpdateValidity(BattlegroundQueue* /*queue*/, uint32 /* diff */, BattlegroundTypeId /* bgTypeId */, BattlegroundBracketId /* bracket_id */, uint8 /* arenaType */, bool /* isRated */, uint32 /* arenaRating */) { return true; }

    virtual void OnAddGroup(BattlegroundQueue* /*queue*/, GroupQueueInfo* /*ginfo*/, uint32& /*index*/, Player* /*leader*/, Group* /*group*/, BattlegroundTypeId /* bgTypeId */, PvPDifficultyEntry const* /* bracketEntry */,
            uint8 /* arenaType */, bool /* isRated */, bool /* isPremade */, uint32 /* arenaRating */, uint32 /* matchmakerRating */, uint32 /* arenaTeamId */, uint32 /* opponentsArenaTeamId */) { }

    [[nodiscard]] virtual bool CanFillPlayersToBG(BattlegroundQueue* /*queue*/, Battleground* /*bg*/, BattlegroundBracketId /*bracket_id*/) { return true; }

    [[nodiscard]] virtual bool IsCheckNormalMatch(BattlegroundQueue* /*queue*/, Battleground* /*bgTemplate*/, BattlegroundBracketId /*bracket_id*/, uint32 /*minPlayers*/, uint32 /*maxPlayers*/) { return false; };

    [[nodiscard]] virtual bool CanSendMessageBGQueue(BattlegroundQueue* /*queue*/, Player* /*leader*/, Battleground* /*bg*/, PvPDifficultyEntry const* /*bracketEntry*/) { return true; }

    /**
     * @brief This hook runs before sending the join message during the arena queue, allowing you to run extra operations or disabling the join message
     *
     * @param queue Contains information about the Arena queue
     * @param leader Contains information about the player leader
     * @param ginfo Contains information about the group of the queue
     * @param bracketEntry Contains information about the bracket
     * @param isRated Contains information about rated arena or skirmish
     * @return True if you want to continue sending the message, false if you want to disable the message
     */
    [[nodiscard]] virtual bool OnBeforeSendJoinMessageArenaQueue(BattlegroundQueue* /*queue*/, Player* /*leader*/, GroupQueueInfo* /*ginfo*/, PvPDifficultyEntry const* /*bracketEntry*/, bool /*isRated*/) { return true; }

    /**
     * @brief This hook runs before sending the exit message during the arena queue, allowing you to run extra operations or disabling the exit message
     *
     * @param queue Contains information about the Arena queue
     * @param ginfo Contains information about the group of the queue
     * @return True if you want to continue sending the message, false if you want to disable the message
     */
    [[nodiscard]] virtual bool OnBeforeSendExitMessageArenaQueue(BattlegroundQueue* /*queue*/, GroupQueueInfo* /*ginfo*/) { return true; }

    /**
     * @brief This hook runs after end Battleground
     *
     * @param bg Contains information about the Battleground
     * @param TeamId Contains information about the winneer team
     */
    virtual void OnBattlegroundEnd(Battleground* /*bg*/, TeamId /*winner team*/) { }

    /**
     * @brief This hook runs before Battleground destroy
     *
     * @param bg Contains information about the Battleground
     */
    virtual void OnBattlegroundDestroy(Battleground* /*bg*/) { }

    /**
     * @brief This hook runs after Battleground create
     *
     * @param bg Contains information about the Battleground
     */
    virtual void OnBattlegroundCreate(Battleground* /*bg*/) { }
};

// Compatibility for old scripts
using BGScript = AllBattlegroundScript;

#endif
