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
#include "GameConfig.h"
#include "TaskScheduler.h"
#include "StringFormat.h"
#include <tuple>
#include <vector>

namespace
{
    // Typdefs
    using QuestTrackInsert = std::vector<std::tuple<uint32 /*ID*/, uint32 /*CharLowGuid*/, std::string /*Hash*/, std::string /*Rev*/>>;
    using QuestTrackUpdate = std::vector<std::tuple<uint32 /*ID*/, uint32 /*CharLowGuid*/>>;

    QuestTrackInsert _questTrackStore;
    QuestTrackUpdate _questCompleteStore;
    QuestTrackUpdate _questAbandonStore;
    QuestTrackUpdate _questGMCompleteStore;

    // Scheduler - for update queue
    TaskScheduler scheduler;
}

QuestTracker* QuestTracker::instance()
{
    static QuestTracker instance;
    return &instance;
}

void QuestTracker::InitSystem()
{
    if (!CONF_GET_BOOL("QuestTracker.Enable"))
    {
        LOG_INFO("server.loading", ">> System disabled");
        return;
    }

    SetExecuteDelay();

    LOG_INFO("server.loading", ">> System loading");
}

void QuestTracker::Update(uint32 diff)
{
    if (!CONF_GET_BOOL("QuestTracker.Enable"))
        return;

    scheduler.Update(diff);
}

void QuestTracker::SetExecuteDelay()
{
    if (!CONF_GET_BOOL("QuestTracker.Queue.Enable") || !CONF_GET_BOOL("QuestTracker.Queue.Enable"))
        return;

    Seconds updateSecs = Seconds(CONF_GET_UINT("QuestTracker.Queue.Delay"));
    if (updateSecs < 1s)
    {
        LOG_ERROR("server", "> QuestTracker: ExecuteDelay < 1 second. Set 10 seconds");
        updateSecs = 10s;
        return;
    }

    scheduler.CancelAll();

    scheduler.Schedule(updateSecs, [this](TaskContext context)
    {
        Execute();

        context.Repeat();
    });
}

void QuestTracker::Execute()
{
    if (_questTrackStore.empty() &&
        _questCompleteStore.empty() &&
        _questAbandonStore.empty() &&
        _questGMCompleteStore.empty())
        return;

    LOG_INFO("server", "> QuestTracker: Start Execute...");

    uint32 msTimeStart = getMSTime();

    /// Insert section
    if (!_questTrackStore.empty())
    {
        for (auto const& [ID, CharacterLowGuid, Hash, Revision] : _questTrackStore)
        {
            PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_QUEST_TRACK);
            stmt->setUInt32(0, ID);
            stmt->setUInt32(1, CharacterLowGuid);
            stmt->setString(2, Hash);
            stmt->setString(3, Revision);
            CharacterDatabase.Execute(stmt);
        }

        LOG_INFO("server", "> QuestTracker: Execute 'CHAR_INS_QUEST_TRACK' (%u)", static_cast<uint32>(_questTrackStore.size()));

        _questTrackStore.clear();
    }

    /// Update section
    auto SendUpdate = [&](QuestTrackUpdate& updateStore, CharacterDatabaseStatements stmtIndex, std::string const& updateType)
    {
        if (updateStore.empty())
            return;

        auto SendUpdateQuestTracker = [&](uint32 questID, uint32 characterLowGuid)
        {
            PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(stmtIndex);
            stmt->setUInt32(0, questID);
            stmt->setUInt32(1, characterLowGuid);
            CharacterDatabase.Execute(stmt);
        };

        for (auto const& [questID, characterLowGuid] : updateStore)
            SendUpdateQuestTracker(questID, characterLowGuid);

        LOG_INFO("server", "> QuestTracker: Execute '%s' (%u)", updateType.c_str(), static_cast<uint32>(updateStore.size()));

        updateStore.clear();
    };

    SendUpdate(_questCompleteStore, CHAR_UPD_QUEST_TRACK_COMPLETE_TIME, "CHAR_UPD_QUEST_TRACK_COMPLETE_TIME");
    SendUpdate(_questAbandonStore, CHAR_UPD_QUEST_TRACK_ABANDON_TIME, "CHAR_UPD_QUEST_TRACK_ABANDON_TIME");
    SendUpdate(_questGMCompleteStore, CHAR_UPD_QUEST_TRACK_GM_COMPLETE, "CHAR_UPD_QUEST_TRACK_GM_COMPLETE");

    LOG_INFO("server", "> QuestTracker: Execute end in %u ms", GetMSTimeDiffToNow(msTimeStart));
}

void QuestTracker::Add(uint32 questID, uint32 characterLowGuid, std::string const& coreHash, std::string const& coreRevision)
{
    if (CONF_GET_BOOL("QuestTracker.Queue.Enable"))
        _questTrackStore.emplace_back(questID, characterLowGuid, coreHash, coreRevision);
    else
    {
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_QUEST_TRACK);
        stmt->setUInt32(0, questID);
        stmt->setUInt32(1, characterLowGuid);
        stmt->setString(2, coreHash);
        stmt->setString(3, coreRevision);
        CharacterDatabase.Execute(stmt);
    }
}

void QuestTracker::UpdateCompleteTime(uint32 questID, uint32 characterLowGuid)
{
    if (CONF_GET_BOOL("QuestTracker.Queue.Enable"))
        _questCompleteStore.emplace_back(questID, characterLowGuid);
    else
    {
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_QUEST_TRACK_COMPLETE_TIME);
        stmt->setUInt32(0, questID);
        stmt->setUInt32(1, characterLowGuid);
        CharacterDatabase.Execute(stmt);
    }
}

void QuestTracker::UpdateAbandonTime(uint32 questID, uint32 characterLowGuid)
{
    if (CONF_GET_BOOL("QuestTracker.Queue.Enable"))
        _questAbandonStore.emplace_back(questID, characterLowGuid);
    else
    {
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_QUEST_TRACK_ABANDON_TIME);
        stmt->setUInt32(0, questID);
        stmt->setUInt32(1, characterLowGuid);
        CharacterDatabase.Execute(stmt);
    }
}

void QuestTracker::UpdateGMComplete(uint32 questID, uint32 characterLowGuid)
{
    if (CONF_GET_BOOL("QuestTracker.Queue.Enable"))
        _questGMCompleteStore.emplace_back(questID, characterLowGuid);
    else
    {
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_QUEST_TRACK_GM_COMPLETE);
        stmt->setUInt32(0, questID);
        stmt->setUInt32(1, characterLowGuid);
        CharacterDatabase.Execute(stmt);
    }
}
