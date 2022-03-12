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

#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnBattlegroundStart(Battleground* bg)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundStart(bg);
    });
}

void ScriptMgr::OnBattlegroundEndReward(Battleground* bg, Player* player, TeamId winnerTeamId)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundEndReward(bg, player, winnerTeamId);
    });
}

void ScriptMgr::OnBattlegroundUpdate(Battleground* bg, uint32 diff)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundUpdate(bg, diff);
    });
}

void ScriptMgr::OnBattlegroundAddPlayer(Battleground* bg, Player* player)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundAddPlayer(bg, player);
    });
}

void ScriptMgr::OnBattlegroundBeforeAddPlayer(Battleground* bg, Player* player)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundBeforeAddPlayer(bg, player);
    });
}

void ScriptMgr::OnBattlegroundRemovePlayerAtLeave(Battleground* bg, Player* player)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundRemovePlayerAtLeave(bg, player);
    });
}

void ScriptMgr::OnAddGroup(BattlegroundQueue* queue, GroupQueueInfo* ginfo, uint32& index, Player* leader, Group* grp, PvPDifficultyEntry const* bracketEntry, bool isPremade)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnAddGroup(queue, ginfo, index, leader, grp, bracketEntry, isPremade);
    });
}

bool ScriptMgr::CanFillPlayersToBG(BattlegroundQueue* queue, Battleground* bg, const int32 aliFree, const int32 hordeFree, BattlegroundBracketId bracket_id)
{
    auto ret = IsValidBoolScript<BGScript>([&](BGScript* script)
    {
        return !script->CanFillPlayersToBG(queue, bg, aliFree, hordeFree, bracket_id);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanFillPlayersToBGWithSpecific(BattlegroundQueue* queue, Battleground* bg, const int32 aliFree, const int32 hordeFree,
        BattlegroundBracketId thisBracketId, BattlegroundQueue* specificQueue, BattlegroundBracketId specificBracketId)
{
    auto ret = IsValidBoolScript<BGScript>([&](BGScript* script)
    {
        return !script->CanFillPlayersToBGWithSpecific(queue, bg, aliFree, hordeFree, thisBracketId, specificQueue, specificBracketId);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnCheckNormalMatch(BattlegroundQueue* queue, uint32& Coef, Battleground* bgTemplate, BattlegroundBracketId bracket_id, uint32& minPlayers, uint32& maxPlayers)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnCheckNormalMatch(queue, Coef, bgTemplate, bracket_id, minPlayers, maxPlayers);
    });
}

void ScriptMgr::OnQueueUpdate(BattlegroundQueue* queue, BattlegroundBracketId bracket_id, bool isRated, uint32 arenaRatedTeamId)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnQueueUpdate(queue, bracket_id, isRated, arenaRatedTeamId);
    });
}

bool ScriptMgr::CanSendMessageBGQueue(BattlegroundQueue* queue, Player* leader, Battleground* bg, PvPDifficultyEntry const* bracketEntry)
{
    auto ret = IsValidBoolScript<BGScript>([&](BGScript* script)
    {
        return !script->CanSendMessageBGQueue(queue, leader, bg, bracketEntry);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::OnBeforeSendJoinMessageArenaQueue(BattlegroundQueue* queue, Player* leader, GroupQueueInfo* ginfo, PvPDifficultyEntry const* bracketEntry, bool isRated)
{
    auto ret = IsValidBoolScript<BGScript>([&](BGScript* script)
    {
        return !script->OnBeforeSendJoinMessageArenaQueue(queue, leader, ginfo, bracketEntry, isRated);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::OnBeforeSendExitMessageArenaQueue(BattlegroundQueue* queue, GroupQueueInfo* ginfo)
{
    auto ret = IsValidBoolScript<BGScript>([&](BGScript* script)
    {
        return !script->OnBeforeSendExitMessageArenaQueue(queue, ginfo);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnBattlegroundEnd(Battleground* bg, TeamId winnerTeam)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundEnd(bg, winnerTeam);
    });
}

void ScriptMgr::OnBattlegroundDestroy(Battleground* bg)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundDestroy(bg);
    });
}

void ScriptMgr::OnBattlegroundCreate(Battleground* bg)
{
    ExecuteScript<BGScript>([&](BGScript* script)
    {
        script->OnBattlegroundCreate(bg);
    });
}
