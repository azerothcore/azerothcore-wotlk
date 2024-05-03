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

// timestamp[ms], firework gameobject ID, fireworkSpawnPositionIndex
typedef std::vector<std::array<uint32, 3>> const FireworkShow;

// <mapId, zoneId>, fireworkShow pointer
// std::map<std::pair<uint32, uint32>, FireworkShow*> const FireworkShowStore = {
//     // Teldrassil
//     { { 1, 141 }, fireworkShowTeldrassil },
//     // Stormwind
//     { { 0, 1519 }, fireworkShowStormwind },
//     // Shattrath
//     { { 530, 3703 }, fireworkShowShattrath },
//     // Silvermoon
//     { { 530, 3430 }, fireworkShowSilvermoon },
//     // Booty Bay
//     { { 0, 33 }, fireworkShowBootyBay },
//     // Thunder Bluff
//     { { 1, 1638 }, fireworkShowThunderBluff },
//     // Exodar
//     { { 530, 3557 }, fireworkShowExodar },
//     // Undercity
//     { { 0, 1497 }, fireworkShowUndercity },
//     // Orgrimmar
//     { { 1, 1637 }, fireworkShowOrgrimmar },
//     // Ironforge
//     { { 0, 1 }, fireworkShowIronforge },
// };

struct go_cheer_speaker : public GameObjectAI
{
    go_cheer_speaker(GameObject* go) : GameObjectAI(go)
    {
        _curIdx = 0;
        _showRunning = false;
        _fireworkShow = nullptr;

        initShow();
    }

    void initShow()
    {
        _fireworkShow = nullptr;

//         auto itr = FireworkShowStore.find(std::make_pair(me->GetMapId(), me->GetZoneId()));
//         if (itr != FireworkShowStore.end())
//         {
//             if (itr->second)
//             {
//                 _fireworkShow = itr->second;
// 
//                 LOG_ERROR("scripts.midsummer", "initShow(): guid {} _fireworkShow.size() {}", me->GetSpawnId(), _fireworkShow->size());
//             }
//         }

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
                ts = (*_fireworkShow)[_curIdx][0];
            } while ((ts <= (minutesOffset * MINUTE * IN_MILLISECONDS)) && (++_curIdx < _fireworkShow->size()));
        }

        if (_curIdx)
            LOG_ERROR("scripts.midsummer", "{}: fast forward {}:{}:{}", me->GetSpawnId(), minutesOffset, _curIdx, (*_fireworkShow)[_curIdx][0]);

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

        LOG_ERROR("scripts.midsummer", "spawnNextFirework() {}, {}, {}, {}", _curIdx, (*_fireworkShow)[_curIdx][0], (*_fireworkShow)[_curIdx][1], (*_fireworkShow)[_curIdx][2]);

        uint32 posIdx = (*_fireworkShow)[_curIdx][2];
        if (posIdx < COUNT_FIREWORK_SPAWN_POSITIONS)
        {
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
        }

        uint32 ts = (*_fireworkShow)[_curIdx][0];

        if (++_curIdx >= _fireworkShow->size())
            return -4;

        if ((*_fireworkShow)[_curIdx][0] < ts)
            return -5;

        return ((*_fireworkShow)[_curIdx][0] - ts);
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
