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

#include "SavingSystem.h"
#include "World.h"

uint32 SavingSystemMgr::m_savingCurrentValue = 0;
uint32 SavingSystemMgr::m_savingMaxValueAssigned = 0;
uint32 SavingSystemMgr::m_savingDiffSum = 0;
std::list<uint32> SavingSystemMgr::m_savingSkipList;
std::mutex SavingSystemMgr::_savingLock;

void SavingSystemMgr::Update(uint32 diff)
{
    if (GetSavingMaxValue() > GetSavingCurrentValue())
    {
        const uint32 step = 120;

        float multiplicator;
        uint32 playerCount = sWorld->GetPlayerCount();
        if (!playerCount)
        {
            m_savingCurrentValue = 0;
            m_savingMaxValueAssigned = 0;
            m_savingDiffSum = 0;
            m_savingSkipList.clear();
            return;
        }

        if (GetSavingMaxValue() - GetSavingCurrentValue() > playerCount + m_savingSkipList.size()) // this should not happen, but just in case
            m_savingMaxValueAssigned = m_savingCurrentValue + playerCount + m_savingSkipList.size();

        if (playerCount <= 1500) // every 2min
            multiplicator = 1000.0f / playerCount;
        else if (playerCount <= 2500) // every 3min
            multiplicator = 1500.0f / playerCount;
        else if (playerCount <= 2750) // every 4min
            multiplicator = 2000.0f / playerCount;
        else if (playerCount <= 3000) // every 6min
            multiplicator = 3000.0f / playerCount;
        else if (playerCount <= 3250) // every 7min
            multiplicator = 3500.0f / playerCount;
        else // every 8min
            multiplicator = 4000.0f / playerCount;

        m_savingDiffSum += diff;
        while (m_savingDiffSum >= (uint32)(step * multiplicator))
        {
            IncreaseSavingCurrentValue(1);

            while (m_savingSkipList.size() && *(m_savingSkipList.begin()) <= GetSavingCurrentValue())
            {
                IncreaseSavingCurrentValue(1);
                m_savingSkipList.pop_front();
            }

            m_savingDiffSum -= (uint32)(step * multiplicator);

            if (GetSavingCurrentValue() > GetSavingMaxValue())
            {
                m_savingDiffSum = 0;
                break;
            }

            if (m_savingDiffSum > 60000)
                m_savingDiffSum = 60000;
        }
    }
}
