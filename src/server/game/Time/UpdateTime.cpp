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

#include "UpdateTime.h"
#include "Config.h"
#include "Log.h"
#include "Timer.h"
#include <algorithm>
#include <cmath>
#include <iterator>

// create instance
WorldUpdateTime sWorldUpdateTime;

UpdateTime::UpdateTime()
{
    _averageUpdateTime = 0;
    _totalUpdateTime = 0;
    _updateTimeTableIndex = 0;
    _maxUpdateTime = 0;
    _maxUpdateTimeOfLastTable = 0;
    _maxUpdateTimeOfCurrentTable = 0;

    _updateTimeDataTable = { };
}

uint32 UpdateTime::GetAverageUpdateTime() const
{
    return _averageUpdateTime;
}

uint32 UpdateTime::GetTimeWeightedAverageUpdateTime() const
{
    uint32 sum = 0, weightsum = 0;

    for (uint32 diff : _updateTimeDataTable)
    {
        sum += diff * diff;
        weightsum += diff;
    }

    if (weightsum == 0)
        return 0;

    return sum / weightsum;
}

uint32 UpdateTime::GetMaxUpdateTime() const
{
    return _maxUpdateTime;
}

uint32 UpdateTime::GetMaxUpdateTimeOfCurrentTable() const
{
    return std::max(_maxUpdateTimeOfCurrentTable, _maxUpdateTimeOfLastTable);
}

uint32 UpdateTime::GetLastUpdateTime() const
{
    return _updateTimeDataTable[_updateTimeTableIndex != 0 ? _updateTimeTableIndex - 1 : _updateTimeDataTable.size() - 1];
}

uint32 UpdateTime::GetDatasetSize() const
{
    return _updateTimeDataTable[_updateTimeDataTable.size() - 1] == 0 ? _updateTimeTableIndex : _orderedUpdateTimeDataTable.size();
}

uint32 UpdateTime::GetPercentile(uint8 p)
{
    if (_needsReorder)
        SortUpdateTimeDataTable();

    // Calculate the index of the element corresponding to the percentile
    double index = (double(p) / 100.0) * (GetDatasetSize() - 1);

    // If the index is an integer, return the value at that index
    if (index == std::floor(index))
       return _orderedUpdateTimeDataTable[index];

    // Otherwise, perform linear interpolation
    int lowerIndex = std::floor(index);
    int upperIndex = std::ceil(index);
    double fraction = index - lowerIndex;

    return _orderedUpdateTimeDataTable[lowerIndex] * (1 - fraction) + _orderedUpdateTimeDataTable[upperIndex] * fraction;
}

void UpdateTime::UpdateWithDiff(uint32 diff)
{
    _needsReorder = true;
    _totalUpdateTime = _totalUpdateTime - _updateTimeDataTable[_updateTimeTableIndex] + diff;
    _updateTimeDataTable[_updateTimeTableIndex] = diff;

    if (diff > _maxUpdateTime)
        _maxUpdateTime = diff;

    if (diff > _maxUpdateTimeOfCurrentTable)
        _maxUpdateTimeOfCurrentTable = diff;

    if (++_updateTimeTableIndex >= _updateTimeDataTable.size())
    {
        _updateTimeTableIndex = 0;
        _maxUpdateTimeOfLastTable = _maxUpdateTimeOfCurrentTable;
        _maxUpdateTimeOfCurrentTable = 0;
    }

    if (_updateTimeDataTable[_updateTimeDataTable.size() - 1])
        _averageUpdateTime = _totalUpdateTime / _updateTimeDataTable.size();
    else if (_updateTimeTableIndex)
        _averageUpdateTime = _totalUpdateTime / _updateTimeTableIndex;
}

void UpdateTime::RecordUpdateTimeReset()
{
    _recordedTime = GetTimeMS();
}

void UpdateTime::SortUpdateTimeDataTable()
{
    if (!_needsReorder)
        return;

    auto endUpdateTable = _updateTimeDataTable.end();
    if (!_updateTimeDataTable[_updateTimeDataTable.size() - 1])
        endUpdateTable = std::next(_updateTimeDataTable.begin(), _updateTimeTableIndex);

    std::copy(_updateTimeDataTable.begin(), endUpdateTable, _orderedUpdateTimeDataTable.begin());

    auto endOrderedUpdateTable = _orderedUpdateTimeDataTable.end();
    if (!_updateTimeDataTable[_updateTimeDataTable.size() - 1])
        endOrderedUpdateTable = std::next(_orderedUpdateTimeDataTable.begin(), _updateTimeTableIndex);

    std::sort(_orderedUpdateTimeDataTable.begin(), endOrderedUpdateTable);

    _needsReorder = false;
}

void WorldUpdateTime::LoadFromConfig()
{
    _recordUpdateTimeInverval = Milliseconds(sConfigMgr->GetOption<uint32>("RecordUpdateTimeDiffInterval", 60000));
    _recordUpdateTimeMin = Milliseconds(sConfigMgr->GetOption<uint32>("MinRecordUpdateTimeDiff", 100));
}

void WorldUpdateTime::SetRecordUpdateTimeInterval(Milliseconds t)
{
    _recordUpdateTimeInverval = t;
}

void WorldUpdateTime::RecordUpdateTime(Milliseconds gameTimeMs, uint32 diff, uint32 sessionCount)
{
    if (_recordUpdateTimeInverval > 0s && diff > _recordUpdateTimeMin.count())
    {
        if (GetMSTimeDiff(_lastRecordTime, gameTimeMs) > _recordUpdateTimeInverval)
        {
            LOG_INFO("time.update", "Update time diff: {}ms with {} players online", GetLastUpdateTime(), sessionCount);
            LOG_INFO("time.update", "Last {} diffs summary:", GetDatasetSize());
            LOG_INFO("time.update", "|- Mean: {}ms", GetAverageUpdateTime());
            LOG_INFO("time.update", "|- Median: {}ms", GetPercentile(50));
            LOG_INFO("time.update", "|- Percentiles (95, 99, max): {}ms, {}ms, {}ms", GetPercentile(95), GetPercentile(99), GetPercentile(100));
            _lastRecordTime = gameTimeMs;
        }
    }
}
