/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "AreaDefines.h"
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
#include "GameObjectScript.h"
#include "Timer.h"

// <mapId, zoneId>, show
std::map<std::pair<uint32, uint32>, FireworkShow const *> const FireworkShowStore = {
    { { MAP_EASTERN_KINGDOMS, AREA_DUN_MOROGH         }, &fireworkShowIronforge    },
    { { MAP_EASTERN_KINGDOMS, AREA_STRANGLETHORN_VALE }, &fireworkShowBootyBay     },
    { { MAP_EASTERN_KINGDOMS, AREA_UNDERCITY          }, &fireworkShowUndercity    },
    { { MAP_EASTERN_KINGDOMS, AREA_STORMWIND_CITY     }, &fireworkShowStormwind    },
    { { MAP_KALIMDOR,         AREA_TELDRASSIL         }, &fireworkShowTeldrassil   },
    { { MAP_KALIMDOR,         AREA_ORGRIMMAR          }, &fireworkShowOrgrimmar    },
    { { MAP_KALIMDOR,         AREA_THUNDER_BLUFF      }, &fireworkShowThunderBluff },
    { { MAP_OUTLAND,          AREA_EVERSONG_WOODS     }, &fireworkShowSilvermoon   },
    { { MAP_OUTLAND,          AREA_THE_EXODAR         }, &fireworkShowExodar       },
    { { MAP_OUTLAND,          AREA_SHATTRATH_CITY     }, &fireworkShowShattrath    },
};

struct go_firework_show : public GameObjectAI
{
    go_firework_show(GameObject* go) : GameObjectAI(go)
    {
        _curIdx = 0;
        _showRunning = false;
        _show = nullptr;

        InitShow();
    }

    void InitShow()
    {
        _show = nullptr;

        auto itr = FireworkShowStore.find(std::make_pair(me->GetMapId(), me->GetZoneId()));
        if (itr != FireworkShowStore.end() && itr->second)
            _show = itr->second;

        StopShow();

        _scheduler.Schedule(Milliseconds(4200), [this](TaskContext context)
            {
                // check for show start
                if (!_showRunning)
                {
                    tzset(); // set timezone for localtime_r() -> fix issues due to daylight time
                    tm local_tm = Acore::Time::TimeBreakdown();

                    // each show runs approx. 12 minutes
                    // and starts at the full hour
                    if ((local_tm.tm_min >= 0) && (local_tm.tm_min < 12))
                    {
                        StartShow(local_tm.tm_min);
                    }
                }

                context.Repeat();
            });
    }

    // provide start offset to handle a "late start"
    // e.g. if the gameobject is spawned later then the desired start time
    void StartShow(int minutesOffset)
    {
        if (!_show || !_show->schedule.entries || !_show->schedule.size || !_show->spawns.entries || !_show->spawns.size)
            return;

        _curIdx = 0;
        _showRunning = true;
        me->setActive(true);

        // fast-forward show if we've got a late start
        if (minutesOffset > 0)
        {
            int ts = 0;
            do {
                ts = _show->schedule.entries[_curIdx].timestamp;
            } while ((ts <= (minutesOffset * MINUTE * IN_MILLISECONDS)) && (++_curIdx < _show->schedule.size));
        }

        _scheduler.Schedule(0s, [this](TaskContext context)
            {
                int32 dt = 0;
                do {
                    dt = SpawnNextFirework();
                } while (dt == 0);

                if (0 < dt)
                    context.Repeat(Milliseconds(dt));
                else
                    StopShow();
            });
    }

    void StopShow()
    {
        if (_showRunning)
        {
            // Trigger SAI to spawn 'Toasting Goblets' on show end
            std::list<GameObject*> _goList;
            me->GetGameObjectListWithEntryInGrid(_goList, GO_TOASTING_GOBLET, 1420.0f);

            for (std::list<GameObject*>::const_iterator itr = _goList.begin(); itr != _goList.end(); ++itr)
            {
                if (GameObjectAI* ai = (*itr)->AI())
                    ai->SetData(0, 1);
            }

            // Trigger SAI to make Revelers cheer on show end
            for (uint32 i = 0; i < COUNT_REVELER_ID; i++)
            {
                std::list<Creature*> _crList;
                me->GetCreatureListWithEntryInGrid(_crList, _show->revelerId[i], 1420.0f);

                for (std::list<Creature*>::const_iterator itr = _crList.begin(); itr != _crList.end(); ++itr)
                {
                    if (CreatureAI* ai = (*itr)->AI())
                        ai->SetData(0, 1);
                }
            }
        }

        _showRunning = false;
        me->setActive(false);
    }

    int32 SpawnNextFirework()
    {
        if (!_showRunning)
            return -1;

        if (!_show || !_show->schedule.entries || !_show->spawns.entries)
            return -2;

        if (_curIdx >= _show->schedule.size)
            return -3;

        uint32 posIdx = _show->schedule.entries[_curIdx].spawnIndex;
        if (posIdx < _show->spawns.size)
        {
            GameObject* go = me->SummonGameObject(_show->schedule.entries[_curIdx].gameobjectId,
                _show->spawns.entries[posIdx].x,
                _show->spawns.entries[posIdx].y,
                _show->spawns.entries[posIdx].z,
                _show->spawns.entries[posIdx].o,
                _show->spawns.entries[posIdx].rot0,
                _show->spawns.entries[posIdx].rot1,
                _show->spawns.entries[posIdx].rot2,
                _show->spawns.entries[posIdx].rot3,
                0);

            // trigger despawn animation for firework explosion
            if (go)
            {
                go->setActive(true);
                go->DespawnOrUnsummon();
                go->AddObjectToRemoveList();
            }
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
