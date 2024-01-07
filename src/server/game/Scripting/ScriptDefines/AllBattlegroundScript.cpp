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
    ExecuteScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        script->OnBattlegroundStart(bg);
    });
}

void ScriptMgr::OnBattlegroundEndReward(Battleground* bg, Player* player, TeamId winnerTeamId)
{
    ExecuteScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        script->OnBattlegroundEndReward(bg, player, winnerTeamId);
    });
}

void ScriptMgr::OnBattlegroundUpdate(Battleground* bg, uint32 diff)
{
    ExecuteScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        script->OnBattlegroundUpdate(bg, diff);
    });
}

void ScriptMgr::OnBattlegroundAddPlayer(Battleground* bg, Player* player)
{
    ExecuteScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        script->OnBattlegroundAddPlayer(bg, player);
    });
}

void ScriptMgr::OnBattlegroundBeforeAddPlayer(Battleground* bg, Player* player)
{
    ExecuteScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        script->OnBattlegroundBeforeAddPlayer(bg, player);
    });
}

void ScriptMgr::OnBattlegroundRemovePlayerAtLeave(Battleground* bg, Player* player)
{
    ExecuteScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        script->OnBattlegroundRemovePlayerAtLeave(bg, player);
    });
}

void ScriptMgr::OnAddGroup(BattlegroundQueue* queue, GroupQueueInfo* ginfo, uint32& index, Player* leader, Group* group, BattlegroundTypeId bgTypeId, PvPDifficultyEntry const* bracketEntry,
    uint8 arenaType, bool isRated, bool isPremade, uint32 arenaRating, uint32 matchmakerRating, uint32 arenaTeamId, uint32 opponentsArenaTeamId)
{
    ExecuteScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        script->OnAddGroup(queue, ginfo, index, leader, group, bgTypeId, bracketEntry,
            arenaType, isRated, isPremade, arenaRating, matchmakerRating, arenaTeamId, opponentsArenaTeamId);
    });
}

bool ScriptMgr::CanFillPlayersToBG(BattlegroundQueue* queue, Battleground* bg, BattlegroundBracketId bracket_id)
{
    auto ret = IsValidBoolScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        return !script->CanFillPlayersToBG(queue, bg, bracket_id);
    });

    return ReturnValidBool(ret);
}

bool ScriptMgr::IsCheckNormalMatch(BattlegroundQueue* queue, Battleground* bgTemplate, BattlegroundBracketId bracket_id, uint32 minPlayers, uint32 maxPlayers)
{
    auto ret = IsValidBoolScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        return script->IsCheckNormalMatch(queue, bgTemplate, bracket_id, minPlayers, maxPlayers);
    });

    return ReturnValidBool(ret, true);
}

void ScriptMgr::OnQueueUpdate(BattlegroundQueue* queue, uint32 diff, BattlegroundTypeId bgTypeId, BattlegroundBracketId bracket_id, uint8 arenaType, bool isRated, uint32 arenaRating)
{
    ExecuteScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        script->OnQueueUpdate(queue, diff, bgTypeId, bracket_id, arenaType, isRated, arenaRating);
    });
}

bool ScriptMgr::CanSendMessageBGQueue(BattlegroundQueue* queue, Player* leader, Battleground* bg, PvPDifficultyEntry const* bracketEntry)
{
    auto ret = IsValidBoolScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        return !script->CanSendMessageBGQueue(queue, leader, bg, bracketEntry);
    });

    return ReturnValidBool(ret);
}

bool ScriptMgr::OnBeforeSendJoinMessageArenaQueue(BattlegroundQueue* queue, Player* leader, GroupQueueInfo* ginfo, PvPDifficultyEntry const* bracketEntry, bool isRated)
{
    auto ret = IsValidBoolScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        return !script->OnBeforeSendJoinMessageArenaQueue(queue, leader, ginfo, bracketEntry, isRated);
    });

    return ReturnValidBool(ret);
}

bool ScriptMgr::OnBeforeSendExitMessageArenaQueue(BattlegroundQueue* queue, GroupQueueInfo* ginfo)
{
    auto ret = IsValidBoolScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        return !script->OnBeforeSendExitMessageArenaQueue(queue, ginfo);
    });

    return ReturnValidBool(ret);
}

void ScriptMgr::OnBattlegroundEnd(Battleground* bg, TeamId winnerTeam)
{
    ExecuteScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        script->OnBattlegroundEnd(bg, winnerTeam);
    });
}

void ScriptMgr::OnBattlegroundDestroy(Battleground* bg)
{
    ExecuteScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        script->OnBattlegroundDestroy(bg);
    });
}

void ScriptMgr::OnBattlegroundCreate(Battleground* bg)
{
    ExecuteScript<AllBattlegroundScript>([&](AllBattlegroundScript* script)
    {
        script->OnBattlegroundCreate(bg);
    });
}

AllBattlegroundScript::AllBattlegroundScript(char const* name) :
    ScriptObject(name)
{
    ScriptRegistry<AllBattlegroundScript>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<AllBattlegroundScript>;
