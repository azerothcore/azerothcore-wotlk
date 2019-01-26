/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef __UPDATETIME_H
#define __UPDATETIME_H

#include <array>

#include "Define.h"

#define AVG_DIFF_COUNT 500

class UpdateTime
{
    using DiffTableArray = std::array<uint32, AVG_DIFF_COUNT>;

    public:
        uint32 GetAverageUpdateTime() const;
        uint32 GetTimeWeightedAverageUpdateTime() const;
        uint32 GetMaxUpdateTime() const;
        uint32 GetMaxUpdateTimeOfCurrentTable() const;
        uint32 GetLastUpdateTime() const;

        void UpdateWithDiff(uint32 diff);

        void RecordUpdateTimeReset();

    protected:
        UpdateTime();

        void _RecordUpdateTimeDuration(std::string const& text, uint32 minUpdateTime);

    private:
        DiffTableArray _updateTimeDataTable;
        uint32 _averageUpdateTime;
        uint32 _totalUpdateTime;
        uint32 _updateTimeTableIndex;
        uint32 _maxUpdateTime;
        uint32 _maxUpdateTimeOfLastTable;
        uint32 _maxUpdateTimeOfCurrentTable;

        uint32 _recordedTime;
};

class WorldUpdateTime : public UpdateTime
{
    public:
        WorldUpdateTime() : UpdateTime(), _recordUpdateTimeInverval(0), _recordUpdateTimeMin(0), _lastRecordTime(0) { }
        void LoadFromConfig();
        void SetRecordUpdateTimeInterval(uint32 t);
        void RecordUpdateTime(uint32 gameTimeMs, uint32 diff, uint32 sessionCount);
        void RecordUpdateTimeDuration(std::string const& text);

    private:
        uint32 _recordUpdateTimeInverval;
        uint32 _recordUpdateTimeMin;
        uint32 _lastRecordTime;
};

extern WorldUpdateTime sWorldUpdateTime;

#endif