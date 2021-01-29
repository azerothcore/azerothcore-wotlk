/*
 * Copyright (C) 2016+  AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021   WarheadCore <https://github.com/WarheadCore/WarheadCore_AC_Arhive>
 */

#include "QuestTracker.h"
#include "DatabaseEnv.h"
#include "Duration.h"
#include "World.h"
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
    if (!sWorld->getBoolConfig(CONFIG_QUEST_TRACKER_ENABLE))
    {
        sLog->outString(">> System disabled");
        return;
    }

    SetExecuteDelay();

    sLog->outString(">> System loading");
}

void QuestTracker::Update(uint32 diff)
{
    if (!sWorld->getBoolConfig(CONFIG_QUEST_TRACKER_ENABLE))
        return;

    scheduler.Update(diff);
}

void QuestTracker::SetExecuteDelay()
{
    if (!sWorld->getBoolConfig(CONFIG_QUEST_TRACKER_ENABLE) || !sWorld->getBoolConfig(CONFIG_QUEST_TRACKER_QUEUE_ENABLE))
        return;

    Seconds updateSecs = Seconds(sWorld->getIntConfig(CONFIG_QUEST_TRACKER_QUEUE_DELAY));
    if (updateSecs < 1s)
    {
        sLog->outError("> QuestTracker: ExecuteDelay < 1 second. Set 10 seconds");
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

    sLog->outString("> QuestTracker: Start Execute...");

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

        sLog->outString("> QuestTracker: Execute 'CHAR_INS_QUEST_TRACK' (%u)", static_cast<uint32>(_questTrackStore.size()));

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

        sLog->outString("> QuestTracker: Execute '%s' (%u)", updateType.c_str(), static_cast<uint32>(updateStore.size()));

        updateStore.clear();
    };

    SendUpdate(_questCompleteStore, CHAR_UPD_QUEST_TRACK_COMPLETE_TIME, "CHAR_UPD_QUEST_TRACK_COMPLETE_TIME");
    SendUpdate(_questAbandonStore, CHAR_UPD_QUEST_TRACK_ABANDON_TIME, "CHAR_UPD_QUEST_TRACK_ABANDON_TIME");
    SendUpdate(_questGMCompleteStore, CHAR_UPD_QUEST_TRACK_GM_COMPLETE, "CHAR_UPD_QUEST_TRACK_GM_COMPLETE");

    sLog->outString("> QuestTracker: Execute end in %u ms", GetMSTimeDiffToNow(msTimeStart));
}

void QuestTracker::Add(uint32 questID, uint32 characterLowGuid, std::string const& coreHash, std::string const& coreRevision)
{
    if (sWorld->getBoolConfig(CONFIG_QUEST_TRACKER_QUEUE_ENABLE))
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
    if (sWorld->getBoolConfig(CONFIG_QUEST_TRACKER_QUEUE_ENABLE))
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
    if (sWorld->getBoolConfig(CONFIG_QUEST_TRACKER_QUEUE_ENABLE))
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
    if (sWorld->getBoolConfig(CONFIG_QUEST_TRACKER_QUEUE_ENABLE))
        _questGMCompleteStore.emplace_back(questID, characterLowGuid);
    else
    {
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_QUEST_TRACK_GM_COMPLETE);
        stmt->setUInt32(0, questID);
        stmt->setUInt32(1, characterLowGuid);
        CharacterDatabase.Execute(stmt);
    }
}
