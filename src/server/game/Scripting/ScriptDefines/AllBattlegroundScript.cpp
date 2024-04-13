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

#include "AllBattlegroundScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnBattlegroundStart(Battleground* bg)
{
    CALL_ENABLED_HOOKS(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_START, script->OnBattlegroundStart(bg));
}

void ScriptMgr::OnBattlegroundEndReward(Battleground* bg, Player* player, TeamId winnerTeamId)
{
    CALL_ENABLED_HOOKS(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_END_REWARD, script->OnBattlegroundEndReward(bg, player, winnerTeamId));
}

void ScriptMgr::OnBattlegroundUpdate(Battleground* bg, uint32 diff)
{
    CALL_ENABLED_HOOKS(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_UPDATE, script->OnBattlegroundUpdate(bg, diff));
}

void ScriptMgr::OnBattlegroundAddPlayer(Battleground* bg, Player* player)
{
    CALL_ENABLED_HOOKS(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_ADD_PLAYER, script->OnBattlegroundAddPlayer(bg, player));
}

void ScriptMgr::OnBattlegroundBeforeAddPlayer(Battleground* bg, Player* player)
{
    CALL_ENABLED_HOOKS(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_BEFORE_ADD_PLAYER, script->OnBattlegroundBeforeAddPlayer(bg, player));
}

void ScriptMgr::OnBattlegroundRemovePlayerAtLeave(Battleground* bg, Player* player)
{
    CALL_ENABLED_HOOKS(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_REMOVE_PLAYER_AT_LEAVE, script->OnBattlegroundRemovePlayerAtLeave(bg, player));
}

void ScriptMgr::OnQueueUpdate(BattlegroundQueue* queue, uint32 diff, BattlegroundTypeId bgTypeId, BattlegroundBracketId bracket_id, uint8 arenaType, bool isRated, uint32 arenaRating)
{
    CALL_ENABLED_HOOKS(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_ON_QUEUE_UPDATE, script->OnQueueUpdate(queue, diff, bgTypeId, bracket_id, arenaType, isRated, arenaRating));
}

void ScriptMgr::OnAddGroup(BattlegroundQueue* queue, GroupQueueInfo* ginfo, uint32& index, Player* leader, Group* group, BattlegroundTypeId bgTypeId, PvPDifficultyEntry const* bracketEntry, uint8 arenaType, bool isRated, bool isPremade, uint32 arenaRating, uint32 matchmakerRating, uint32 arenaTeamId, uint32 opponentsArenaTeamId)
{
    CALL_ENABLED_HOOKS(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_ON_ADD_GROUP, script->OnAddGroup(queue, ginfo, index, leader, group, bgTypeId, bracketEntry, arenaType, isRated, isPremade, arenaRating, matchmakerRating, arenaTeamId, opponentsArenaTeamId));
}

bool ScriptMgr::CanFillPlayersToBG(BattlegroundQueue* queue, Battleground* bg, BattlegroundBracketId bracket_id)
{
    CALL_ENABLED_BOOLEAN_HOOKS(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_CAN_FILL_PLAYERS_TO_BG, !script->CanFillPlayersToBG(queue, bg, bracket_id));
}

bool ScriptMgr::IsCheckNormalMatch(BattlegroundQueue* queue, Battleground* bgTemplate, BattlegroundBracketId bracket_id, uint32 minPlayers, uint32 maxPlayers)
{
    CALL_ENABLED_BOOLEAN_HOOKS_WITH_DEFAULT_FALSE(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_IS_CHECK_NORMAL_MATCH, script->IsCheckNormalMatch(queue, bgTemplate, bracket_id, minPlayers, maxPlayers));
}

bool ScriptMgr::CanSendMessageBGQueue(BattlegroundQueue* queue, Player* leader, Battleground* bg, PvPDifficultyEntry const* bracketEntry)
{
    CALL_ENABLED_BOOLEAN_HOOKS(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_CAN_SEND_MESSAGE_BG_QUEUE, !script->CanSendMessageBGQueue(queue, leader, bg, bracketEntry));
}

bool ScriptMgr::OnBeforeSendJoinMessageArenaQueue(BattlegroundQueue* queue, Player* leader, GroupQueueInfo* ginfo, PvPDifficultyEntry const* bracketEntry, bool isRated)
{
    CALL_ENABLED_BOOLEAN_HOOKS(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_ON_BEFORE_SEND_JOIN_MESSAGE_ARENA_QUEUE, !script->OnBeforeSendJoinMessageArenaQueue(queue, leader, ginfo, bracketEntry, isRated));
}

bool ScriptMgr::OnBeforeSendExitMessageArenaQueue(BattlegroundQueue* queue, GroupQueueInfo* ginfo)
{
    CALL_ENABLED_BOOLEAN_HOOKS(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_ON_BEFORE_SEND_EXIT_MESSAGE_ARENA_QUEUE, !script->OnBeforeSendExitMessageArenaQueue(queue, ginfo));
}

void ScriptMgr::OnBattlegroundEnd(Battleground* bg, TeamId winnerTeam)
{
    CALL_ENABLED_HOOKS(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_END, script->OnBattlegroundEnd(bg, winnerTeam));
}

void ScriptMgr::OnBattlegroundDestroy(Battleground* bg)
{
    CALL_ENABLED_HOOKS(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_DESTROY, script->OnBattlegroundDestroy(bg));
}

void ScriptMgr::OnBattlegroundCreate(Battleground* bg)
{
    CALL_ENABLED_HOOKS(AllBattlegroundScript, ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_CREATE, script->OnBattlegroundCreate(bg));
}

AllBattlegroundScript::AllBattlegroundScript(char const* name, std::vector<uint16> enabledHooks) :
    ScriptObject(name, ALLBATTLEGROUNDHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < ALLBATTLEGROUNDHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<AllBattlegroundScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<AllBattlegroundScript>;
