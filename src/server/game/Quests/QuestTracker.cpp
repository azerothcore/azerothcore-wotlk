/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "QuestTracker.h"
#include "DatabaseEnv.h"
#include "World.h"
#include "TaskScheduler.h"
#include <tuple>
#include <vector>

namespace
{
    std::vector<std::tuple<uint32 /*ID*/, uint32 /*CharLowGuid*/, std::string /*Hash*/, std::string /*Rev*/>> _questTrackStore;
    std::vector<PreparedStatement*> _queueStmt;
    TaskScheduler scheduler;
}

QuestTracker* QuestTracker::instance()
{
    static QuestTracker instance;
    return &instance;
}

void QuestTracker::InitSystem()
{
    if (!sWorld->getBoolConfig(CONFIG_QUEST_ENABLE_QUEST_TRACKER))
    {
        sLog->outString(">> System disabled");
        return;
    }

    scheduler.Schedule(15s, [this](TaskContext context)
    {
        Execute();

        context.Repeat();
    });

    sLog->outString(">> System loading");
}

void QuestTracker::Update(uint32 diff)
{
    if (!sWorld->getBoolConfig(CONFIG_QUEST_ENABLE_QUEST_TRACKER))
        return;

    scheduler.Update(diff);
}

void QuestTracker::Execute()
{
    auto trans = CharacterDatabase.BeginTransaction();

    for (auto const& [ID, CharacterLowGuid, Hash, Revision] : _questTrackStore)
    {
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_QUEST_TRACK);
        stmt->setUInt32(0, ID);
        stmt->setUInt32(1, CharacterLowGuid);
        stmt->setString(2, Hash);
        stmt->setString(3, Revision);
        trans->Append(stmt);
    }

    for (auto const& stmt : _queueStmt)
        trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);

    _questTrackStore.clear();
    _queueStmt.clear();
}

void QuestTracker::Add(uint32 questID, uint32 characterLowGuid, std::string const& coreHash, std::string const& coreRevision)
{
    _questTrackStore.emplace_back(std::make_tuple(questID, characterLowGuid, coreHash, coreRevision));
}

void QuestTracker::UpdateCompleteTime(uint32 questID, uint32 characterLowGuid)
{
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_QUEST_TRACK_COMPLETE_TIME);
    stmt->setUInt32(0, questID);
    stmt->setUInt32(1, characterLowGuid);

    _queueStmt.emplace_back(stmt);
}

void QuestTracker::UpdateAbandonTime(uint32 questID, uint32 characterLowGuid)
{
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_QUEST_TRACK_ABANDON_TIME);
    stmt->setUInt32(0, questID);
    stmt->setUInt32(1, characterLowGuid);

    _queueStmt.emplace_back(stmt);
}

void QuestTracker::UpdateGMComplete(uint32 questID, uint32 characterLowGuid)
{
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_QUEST_TRACK_GM_COMPLETE);
    stmt->setUInt32(0, questID);
    stmt->setUInt32(1, characterLowGuid);

    _queueStmt.emplace_back(stmt);
}
