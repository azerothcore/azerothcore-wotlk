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

// <mapId, zoneId>, show index
std::map<std::pair<uint32, uint32>, uint32> const FireworkShowStore = {
    { { 0,   1    }, FIREWORK_SHOW_IRONFORGE    },
    { { 0,   33   }, FIREWORK_SHOW_BOOTYBAY     },
    { { 0,   1497 }, FIREWORK_SHOW_UNDERCITY    },
    { { 0,   1519 }, FIREWORK_SHOW_STORMWIND    },
    { { 1,   141  }, FIREWORK_SHOW_TELDRASSIL   },
    { { 1,   1637 }, FIREWORK_SHOW_ORGRIMMAR    },
    { { 1,   1638 }, FIREWORK_SHOW_THUNDERBLUFF },
    { { 530, 3430 }, FIREWORK_SHOW_SILVERMOON   },
    { { 530, 3557 }, FIREWORK_SHOW_EXODAR       },
    { { 530, 3703 }, FIREWORK_SHOW_SHATTRATH    },
};

struct go_cheer_speaker : public GameObjectAI
{
    go_cheer_speaker(GameObject* go) : GameObjectAI(go)
    {
        _curIdx = 0;
        _showRunning = false;
        _fireworkShow = nullptr;

        initShow();
    }

    ~go_cheer_speaker()
    {
        delete _fireworkShow;
    }

    void initShow()
    {
        _fireworkShow = nullptr;

        auto itr = FireworkShowStore.find(std::make_pair(me->GetMapId(), me->GetZoneId()));
        if (itr != FireworkShowStore.end())
        {
            switch(itr->second)
            {
                case FIREWORK_SHOW_IRONFORGE:
                    _fireworkShow = new FireworkShow(fireworkShowIronforge, fireworkShowIronforge + sizeof(fireworkShowIronforge) / sizeof(fireworkShowIronforge[0]));
                    break;
                case FIREWORK_SHOW_BOOTYBAY:
                    _fireworkShow = new FireworkShow(fireworkShowBootyBay, fireworkShowBootyBay + sizeof(fireworkShowBootyBay) / sizeof(fireworkShowBootyBay[0]));
                    break;
                case FIREWORK_SHOW_UNDERCITY:
                    _fireworkShow = new FireworkShow(fireworkShowUndercity, fireworkShowUndercity + sizeof(fireworkShowUndercity) / sizeof(fireworkShowUndercity[0]));
                    break;
                case FIREWORK_SHOW_STORMWIND:
                    _fireworkShow = new FireworkShow(fireworkShowStormwind, fireworkShowStormwind + sizeof(fireworkShowStormwind) / sizeof(fireworkShowStormwind[0]));
                    break;
                case FIREWORK_SHOW_TELDRASSIL:
                    _fireworkShow = new FireworkShow(fireworkShowTeldrassil, fireworkShowTeldrassil + sizeof(fireworkShowTeldrassil) / sizeof(fireworkShowTeldrassil[0]));
                    break;
                case FIREWORK_SHOW_ORGRIMMAR:
                    _fireworkShow = new FireworkShow(fireworkShowOrgrimmar, fireworkShowOrgrimmar + sizeof(fireworkShowOrgrimmar) / sizeof(fireworkShowOrgrimmar[0]));
                    break;
                case FIREWORK_SHOW_THUNDERBLUFF:
                   _fireworkShow = new FireworkShow(fireworkShowThunderBluff, fireworkShowThunderBluff + sizeof(fireworkShowThunderBluff) / sizeof(fireworkShowThunderBluff[0]));
                    break;
                case FIREWORK_SHOW_SILVERMOON:
                    _fireworkShow = new FireworkShow(fireworkShowSilvermoon, fireworkShowSilvermoon + sizeof(fireworkShowSilvermoon) / sizeof(fireworkShowSilvermoon[0]));
                    break;
                case FIREWORK_SHOW_EXODAR:
                    _fireworkShow = new FireworkShow(fireworkShowExodar, fireworkShowExodar + sizeof(fireworkShowExodar) / sizeof(fireworkShowExodar[0]));
                    break;
                case FIREWORK_SHOW_SHATTRATH:
                    _fireworkShow = new FireworkShow(fireworkShowShattrath, fireworkShowShattrath + sizeof(fireworkShowShattrath) / sizeof(fireworkShowShattrath[0]));
                    break;
                default:
                    return;
            }

            LOG_ERROR("scripts.midsummer", "initShow(): guid {} _fireworkShow.size() {}", me->GetSpawnId(), _fireworkShow->size());
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
        if (!_fireworkShow)
            return;

        _curIdx = 0;
        _showRunning = true;
        me->setActive(true);

        // fast-forward show if we've got a late start
        if (minutesOffset > 0)
        {
            uint32 ts = 0;
            do {
                ts = (*_fireworkShow)[_curIdx].timestamp;
            } while ((ts <= (minutesOffset * MINUTE * IN_MILLISECONDS)) && (++_curIdx < _fireworkShow->size()));
        }

        if (_curIdx)
            LOG_ERROR("scripts.midsummer", "{}: fast forward {}:{}:{}", me->GetSpawnId(), minutesOffset, _curIdx, (*_fireworkShow)[_curIdx].timestamp);

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
                    LOG_ERROR("scripts.midsummer", "go_cheer_speaker: could not schedule next firework explosion in {} ms.", dt);
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

        if (!_fireworkShow)
            return -2;

        if (_curIdx >= _fireworkShow->size())
            return -3;

        LOG_ERROR("scripts.midsummer", "spawnNextFirework() {}, {}, {}, {}", _curIdx, (*_fireworkShow)[_curIdx].timestamp, (*_fireworkShow)[_curIdx].gameobjectId, (*_fireworkShow)[_curIdx].spawnIndex);

        uint32 posIdx = (*_fireworkShow)[_curIdx].spawnIndex;
//         if (posIdx < COUNT_FIREWORK_SPAWN_POSITIONS)
//         {
//             me->SummonGameObject((*_fireworkShow)[_curIdx][1],
//                 fireworkSpawnPosition[posIdx][0],
//                 fireworkSpawnPosition[posIdx][1],
//                 fireworkSpawnPosition[posIdx][2],
//                 fireworkSpawnPosition[posIdx][3],
//                 fireworkSpawnPosition[posIdx][4],
//                 fireworkSpawnPosition[posIdx][5],
//                 fireworkSpawnPosition[posIdx][6],
//                 fireworkSpawnPosition[posIdx][7],
//                 0);
//         }

        uint32 ts = (*_fireworkShow)[_curIdx].timestamp;

        if (++_curIdx >= _fireworkShow->size())
            return -4;

        if ((*_fireworkShow)[_curIdx].timestamp < ts)
            return -5;

        return ((*_fireworkShow)[_curIdx].timestamp - ts);
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);
    }

private:
    TaskScheduler _scheduler;
    uint32_t _curIdx;
    bool _showRunning;
    FireworkShow* _fireworkShow;
};

void AddSC_event_firework_show_scripts()
{
    // Gameobjects
    RegisterGameObjectAI(go_cheer_speaker);
}
