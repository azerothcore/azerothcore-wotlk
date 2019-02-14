/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "UpdateTime.h"
#include "Timer.h"
#include "Config.h"
#include "Log.h"

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

void UpdateTime::UpdateWithDiff(uint32 diff)
{
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
    _recordedTime = getMSTime();
}

void UpdateTime::_RecordUpdateTimeDuration(std::string const& text, uint32 minUpdateTime)
{
    uint32 thisTime = getMSTime();
    uint32 diff = getMSTimeDiff(_recordedTime, thisTime);

    if (diff > minUpdateTime)
        sLog->outError("Recored Update Time of %s: %u.", text.c_str(), diff);

    _recordedTime = thisTime;
}

void WorldUpdateTime::LoadFromConfig()
{
    _recordUpdateTimeInverval = sConfigMgr->GetIntDefault("RecordUpdateTimeDiffInterval", 60000);
    _recordUpdateTimeMin = sConfigMgr->GetIntDefault("MinRecordUpdateTimeDiff", 100);
}

void WorldUpdateTime::SetRecordUpdateTimeInterval(uint32 t)
{
    _recordUpdateTimeInverval = t;
}

void WorldUpdateTime::RecordUpdateTime(uint32 gameTimeMs, uint32 diff, uint32 sessionCount)
{
    if (_recordUpdateTimeInverval > 0 && diff > _recordUpdateTimeMin)
    {
        if (getMSTimeDiff(_lastRecordTime, gameTimeMs) > _recordUpdateTimeInverval)
        {
            sLog->outError("Update time diff: %u. Players online: %u.", GetAverageUpdateTime(), sessionCount);
            _lastRecordTime = gameTimeMs;
        }
    }
}

void WorldUpdateTime::RecordUpdateTimeDuration(std::string const& text)
{
    _RecordUpdateTimeDuration(text, _recordUpdateTimeMin);
}