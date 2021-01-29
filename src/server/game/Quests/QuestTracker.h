/*
 * Copyright (C) 2016+  AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2020+  WarheadCore <https://github.com/WarheadCore/WarheadCore_AC_Arhive>
 */

#ifndef _QUEST_TRACKER_H
#define _QUEST_TRACKER_H

#include "Common.h"

class QuestTracker
{
public:
    static QuestTracker* instance();

    void InitSystem();
    void Update(uint32 diff);
    void SetExecuteDelay();
    void Execute();

    void Add(uint32 questID, uint32 characterLowGuid, std::string const& coreHash, std::string const& coreRevision);
    void UpdateCompleteTime(uint32 questID, uint32 characterLowGuid);
    void UpdateAbandonTime(uint32 questID, uint32 characterLowGuid);
    void UpdateGMComplete(uint32 questID, uint32 characterLowGuid);
};

#define sQuestTracker QuestTracker::instance()

#endif
