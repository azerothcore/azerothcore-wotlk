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

#include "firework_show.h"
#include "firework_show_BootyBay.h"
#include "firework_show_Exodar.h"
#include "firework_show_Ironforge.h"
#include "firework_show_Orgrimmar.h"
#include "firework_show_Shattrath.h"
#include "firework_show_Silvermoon.h"
#include "firework_show_Stormwind.h"
#include "firework_show_Teldrassil.h"
#include "firework_show_ThunderBluff.h"
#include "firework_show_Undercity.h"
#include "GameObjectAI.h"

// <mapId, zoneId>, show
std::map<std::pair<uint32, uint32>, FireworkShow const *> const FireworkShowStore = {
    { { 0,   1    }, &fireworkShowIronforge    },
    { { 0,   33   }, &fireworkShowBootyBay     },
    { { 0,   1497 }, &fireworkShowUndercity    },
    { { 0,   1519 }, &fireworkShowStormwind    },
    { { 1,   141  }, &fireworkShowTeldrassil   },
    { { 1,   1637 }, &fireworkShowOrgrimmar    },
    { { 1,   1638 }, &fireworkShowThunderBluff },
    { { 530, 3430 }, &fireworkShowSilvermoon   },
    { { 530, 3557 }, &fireworkShowExodar       },
    { { 530, 3703 }, &fireworkShowShattrath    },
};

struct go_firework_show : public GameObjectAI
{
    go_firework_show(GameObject* go) : GameObjectAI(go)
    {
        _curIdx = 0;
        _showRunning = false;
        _show = nullptr;

        initShow();
    }

    void initShow()
    {
        _show = nullptr;

        auto itr = FireworkShowStore.find(std::make_pair(me->GetMapId(), me->GetZoneId()));
        if (itr != FireworkShowStore.end() && itr->second)
        {
            _show = itr->second;

            LOG_ERROR("scripts.midsummer", "initShow(): guid {} _show->schedule.size {} _show->spawns.size {}", me->GetSpawnId(), _show->schedule.size, _show->spawns.size);
        }

        stopShow();

        _scheduler.Schedule(Milliseconds(4200), [this](TaskContext context)
            {
                // check for show start
                if (!_showRunning)
                {
                    tzset(); // set timezone for localtime_r() -> fix issues due to daylight time
                    tm local_tm = Acore::Time::TimeBreakdown();

                    LOG_ERROR("scripts.midsummer", "{}: time check {}:{}:{}", me->GetSpawnId(), local_tm.tm_hour, local_tm.tm_min, local_tm.tm_sec);

                    // each show runs approx. 12 minutes
                    // and starts at the full hour
                    if ((local_tm.tm_min >= 0) && (local_tm.tm_min < 12))
                    {
                        startShow(local_tm.tm_min);
                    }
                }

                context.Repeat();
            });
    }

    // provide start offset to handle a "late start"
    // e.g. if the gameobject is spawned later then the desired start time
    void startShow(int minutesOffset)
    {
        if (!_show || !_show->schedule.entries || !_show->schedule.size || !_show->spawns.entries || !_show->spawns.size)
            return;

        _curIdx = 0;
        _showRunning = true;
        me->setActive(true);

        // fast-forward show if we've got a late start
        if (minutesOffset > 0)
        {
            uint32 ts = 0;
            do {
                ts = _show->schedule.entries[_curIdx].timestamp;
            } while ((ts <= (minutesOffset * MINUTE * IN_MILLISECONDS)) && (++_curIdx < _show->schedule.size));
        }

        if (_curIdx)
            LOG_ERROR("scripts.midsummer", "{}: fast forward {}:{}:{}", me->GetSpawnId(), minutesOffset, _curIdx, _show->schedule.entries[_curIdx].timestamp);

        _scheduler.Schedule(0s, [this](TaskContext context)
            {
                int32 dt = 0;
                do {
                    dt = spawnNextFirework();
                } while (dt == 0);

                if (0 < dt)
                    context.Repeat(Milliseconds(dt));
                else
                {
                    stopShow();
                    LOG_ERROR("scripts.midsummer", "go_firework_show: could not schedule next firework explosion in {} ms.", dt);
                }
            });

        LOG_ERROR("scripts.midsummer", "startShow()");
    }

    void stopShow()
    {
        _showRunning = false;
        me->setActive(false);

        LOG_ERROR("scripts.midsummer", "stopShow()");
    }

    int32 spawnNextFirework()
    {
        if (!_showRunning)
            return -1;

        if (!_show || !_show->schedule.entries || !_show->spawns.entries)
            return -2;

        if (_curIdx >= _show->schedule.size)
            return -3;

        LOG_ERROR("scripts.midsummer", "{}: spawnNextFirework() {}, {}, {}, {}", me->GetSpawnId(), _curIdx, _show->schedule.entries[_curIdx].timestamp, _show->schedule.entries[_curIdx].gameobjectId, _show->schedule.entries[_curIdx].spawnIndex);

        uint32 posIdx = _show->schedule.entries[_curIdx].spawnIndex;
        if (posIdx < _show->spawns.size)
        {
            me->SummonGameObject(_show->schedule.entries[_curIdx].gameobjectId,
                _show->spawns.entries[posIdx].x,
                _show->spawns.entries[posIdx].y,
                _show->spawns.entries[posIdx].z,
                _show->spawns.entries[posIdx].o,
                _show->spawns.entries[posIdx].rot0,
                _show->spawns.entries[posIdx].rot1,
                _show->spawns.entries[posIdx].rot2,
                _show->spawns.entries[posIdx].rot3,
                0);
        }
        else
        {
            LOG_ERROR("scripts.midsummer", "{}: spawnNextFirework() - spawnIndex {} OUT OF BOUNDS ( {} )", me->GetSpawnId(), posIdx, _show->spawns.size);
        }

        uint32 ts = _show->schedule.entries[_curIdx].timestamp;

        if (++_curIdx >= _show->schedule.size)
            return -4;

        if (_show->schedule.entries[_curIdx].timestamp < ts)
            return -5;

        return (_show->schedule.entries[_curIdx].timestamp - ts);
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);
    }

private:
    TaskScheduler _scheduler;
    uint32_t _curIdx;
    bool _showRunning;
    FireworkShow const * _show;
};

void AddSC_event_firework_show_scripts()
{
    // Gameobjects
    RegisterGameObjectAI(go_firework_show);
}
