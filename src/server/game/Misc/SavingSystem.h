#ifndef __SAVINGSYSTEM_H
#define __SAVINGSYSTEM_H

#include "Common.h"

// to evenly distribute saving players to db

class SavingSystemMgr
{
public:
    static void Update(uint32 diff);

    static uint32 GetSavingCurrentValue()                       { return m_savingCurrentValue; } // modified only during single thread
    static uint32 GetSavingMaxValue()                           { return m_savingMaxValueAssigned; } // modified only during single thread
    static void IncreaseSavingCurrentValue(uint32 inc)          { m_savingCurrentValue += inc; } // used and modified only during single thread
    static uint32 IncreaseSavingMaxValue(uint32 inc)            { ACORE_GUARD(ACE_Thread_Mutex, _savingLock); return (m_savingMaxValueAssigned += inc); }
    static void InsertToSavingSkipListIfNeeded(uint32 id)       { if (id > m_savingCurrentValue) { ACORE_GUARD(ACE_Thread_Mutex, _savingLock); m_savingSkipList.push_back(id); } }

protected:
    static uint32 m_savingCurrentValue;
    static uint32 m_savingMaxValueAssigned;
    static uint32 m_savingDiffSum;
    static std::list<uint32> m_savingSkipList;
    static ACE_Thread_Mutex _savingLock;
};

#endif
