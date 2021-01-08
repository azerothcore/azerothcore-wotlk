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
    std::vector<std::tuple<uint32 /*ID*/, uint32 /*CharLowGuid*/>> _questCompleteStore;
    std::vector<std::tuple<uint32 /*ID*/, uint32 /*CharLowGuid*/>> _questAbandonStore;
    std::vector<std::tuple<uint32 /*ID*/, uint32 /*CharLowGuid*/>> _questGMCompleteStore;
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

    scheduler.Schedule(30s, [this](TaskContext context)
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
    /// Insert section
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

    CharacterDatabase.CommitTransaction(trans);

    _questTrackStore.clear();

    // Update section
    auto trans = CharacterDatabase.BeginTransaction();

    auto SendUpdateQuestTrack = [](CharacterDatabaseStatements stmtIndex, uint32 questID, uint32 characterLowGuid)
    {
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(stmtIndex);
        stmt->setUInt32(0, questID);
        stmt->setUInt32(1, characterLowGuid);
        trans->Append(stmt);
    };

    for (auto const& [questID, characterLowGuid] : _questCompleteStore)
        SendUpdateQuestTrack(CHAR_UPD_QUEST_TRACK_COMPLETE_TIME, questID, characterLowGuid);

    for (auto const& [questID, characterLowGuid] : _questAbandonStore)
        SendUpdateQuestTrack(CHAR_UPD_QUEST_TRACK_ABANDON_TIME, questID, characterLowGuid);

    for (auto const& [questID, characterLowGuid] : _questGMCompleteStore)
        SendUpdateQuestTrack(CHAR_UPD_QUEST_TRACK_GM_COMPLETE, questID, characterLowGuid);

    CharacterDatabase.CommitTransaction(trans);
    
    _questCompleteStore.clear();
    _questAbandonStore.clear();
    _questGMCompleteStore.clear();
}

void QuestTracker::Add(uint32 questID, uint32 characterLowGuid, std::string const& coreHash, std::string const& coreRevision)
{
    _questTrackStore.emplace_back(questID, characterLowGuid, coreHash, coreRevision);
}

void QuestTracker::UpdateCompleteTime(uint32 questID, uint32 characterLowGuid)
{
    _questCompleteStore.emplace_back(questID, characterLowGuid);
}

void QuestTracker::UpdateAbandonTime(uint32 questID, uint32 characterLowGuid)
{
    _questAbandonStore.emplace_back(questID, characterLowGuid);
}

void QuestTracker::UpdateGMComplete(uint32 questID, uint32 characterLowGuid)
{
    _questGMCompleteStore.emplace_back(questID, characterLowGuid);
}
