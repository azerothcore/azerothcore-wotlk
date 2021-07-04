/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef __SAVINGSYSTEM_H
#define __SAVINGSYSTEM_H

#include "Common.h"
#include <list>
#include <mutex>

// to evenly distribute saving players to db

class SavingSystemMgr
{
public:
    static void Update(uint32 diff);

    static uint32 GetSavingCurrentValue()                       { return m_savingCurrentValue; } // modified only during single thread
    static uint32 GetSavingMaxValue()                           { return m_savingMaxValueAssigned; } // modified only during single thread
    static void IncreaseSavingCurrentValue(uint32 inc)          { m_savingCurrentValue += inc; } // used and modified only during single thread
    static uint32 IncreaseSavingMaxValue(uint32 inc)            { std::lock_guard<std::mutex> guard(_savingLock); return (m_savingMaxValueAssigned += inc); }
    static void InsertToSavingSkipListIfNeeded(uint32 id)       { if (id > m_savingCurrentValue) { std::lock_guard<std::mutex> guard(_savingLock); m_savingSkipList.push_back(id); } }

protected:
    static uint32 m_savingCurrentValue;
    static uint32 m_savingMaxValueAssigned;
    static uint32 m_savingDiffSum;
    static std::list<uint32> m_savingSkipList;
    static std::mutex _savingLock;
};

#endif
