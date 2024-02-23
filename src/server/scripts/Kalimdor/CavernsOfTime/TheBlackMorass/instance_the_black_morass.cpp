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

#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "SpellInfo.h"
#include "TemporarySummon.h"
#include "the_black_morass.h"

const Position PortalLocation[4] =
{
    { -2030.8318f, 7024.9443f, 23.071817f, 3.14159f },
    { -1961.7335f, 7029.5280f, 21.811401f, 2.12931f },
    { -1887.6950f, 7106.5570f, 22.049500f, 4.95673f },
    { -1930.9106f, 7183.5970f, 23.007639f, 3.59537f }
};

ObjectData const creatureData[] =
{
    { NPC_MEDIVH, DATA_MEDIVH },
    { 0,          0           }
};

class instance_the_black_morass : public InstanceMapScript
{
public:
    instance_the_black_morass() : InstanceMapScript("instance_the_black_morass", 269) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_the_black_morass_InstanceMapScript(map);
    }

    struct instance_the_black_morass_InstanceMapScript : public InstanceScript
    {
        instance_the_black_morass_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(EncounterCount);
            LoadObjectData(creatureData, nullptr);
            _currentRift = 0;
            _shieldPercent = 100;
            _encounterNPCs.clear();
            _noBossSpawnDelay = true; // Delay after bosses
            _eventStatus = EVENT_PREPARE;
        }

        void CleanupInstance()
        {
            _currentRift = 0;
            _shieldPercent = 100;

            _availableRiftPositions.clear();
            _scheduler.CancelAll();

            for (Position const& pos : PortalLocation)
            {
                _availableRiftPositions.push_back(pos);
            }

            // prevent getting stuck if event fails during boss break
            _noBossSpawnDelay = true;

            instance->LoadGrid(-2023.0f, 7121.0f);
            if (Creature* medivh = GetCreature(DATA_MEDIVH))
            {
                medivh->Respawn();
            }
            for (ObjectGuid const& guid : _encounterNPCs)
            {
                if (guid.GetEntry() == NPC_DP_BEAM_STALKER)
                {
                    if (Creature* creature = instance->GetCreature(guid))
                    {
                            creature->Respawn();
                    }
                    break;
                }
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
            {
                return false;
            }

            if (state == DONE)
            {
                switch (type)
                {
                    case DATA_AEONUS:
                    {
                        if (Creature* medivh = GetCreature(DATA_MEDIVH))
                        {
                            medivh->AI()->DoAction(ACTION_OUTRO);
                        }

                        instance->DoForAllPlayers([&](Player* player)
                        {
                            if (player->GetQuestStatus(QUEST_OPENING_PORTAL) == QUEST_STATUS_INCOMPLETE)
                            {
                                player->AreaExploredOrEventHappens(QUEST_OPENING_PORTAL);
                            }

                            if (player->GetQuestStatus(QUEST_MASTER_TOUCH) == QUEST_STATUS_INCOMPLETE)
                            {
                                player->AreaExploredOrEventHappens(QUEST_MASTER_TOUCH);
                            }
                        });

                        for (ObjectGuid const& guid : _encounterNPCs)
                        {
                            if (Creature* creature = instance->GetCreature(guid))
                            {
                                switch (creature->GetEntry())
                                {
                                    case NPC_RIFT_KEEPER_WARLOCK:
                                    case NPC_RIFT_KEEPER_MAGE:
                                    case NPC_RIFT_LORD:
                                    case NPC_RIFT_LORD_2:
                                    case NPC_TIME_RIFT:
                                    case NPC_INFINITE_ASSASSIN:
                                    case NPC_INFINITE_ASSASSIN_2:
                                    case NPC_INFINITE_WHELP:
                                    case NPC_INFINITE_CHRONOMANCER:
                                    case NPC_INFINITE_CHRONOMANCER_2:
                                    case NPC_INFINITE_EXECUTIONER:
                                    case NPC_INFINITE_EXECUTIONER_2:
                                    case NPC_INFINITE_VANQUISHER:
                                    case NPC_INFINITE_VANQUISHER_2:
                                        creature->DespawnOrUnsummon(1);
                                        break;
                                    default:
                                        break;
                                }
                            }
                        }

                        break;
                    }
                    case DATA_CHRONO_LORD_DEJA:
                    case DATA_TEMPORUS:
                    {
                        _noBossSpawnDelay = false;

                        _scheduler.Schedule(2min + 30s, [this](TaskContext)
                        {
                            _noBossSpawnDelay = true;
                            ScheduleNextPortal(0s, Position(0.0f, 0.0f, 0.0f, 0.0f));
                        });

                        break;
                    }
                    default:
                        break;
                }
            }

            return true;
        }

        void OnPlayerEnter(Player* player) override
        {
            if (instance->GetPlayersCountExceptGMs() <= 1 && GetBossState(DATA_AEONUS) != DONE && _eventStatus != EVENT_IN_PROGRESS)
            {
                CleanupInstance();
            }

            player->SendUpdateWorldState(WORLD_STATE_BM, _eventStatus);
            player->SendUpdateWorldState(WORLD_STATE_BM_SHIELD, _shieldPercent);
            player->SendUpdateWorldState(WORLD_STATE_BM_RIFT, _currentRift);
        }

        void ScheduleNextPortal(Milliseconds time, Position lastPosition)
        {
            // only one rift can be scheduled at any time
            _scheduler.CancelGroup(CONTEXT_GROUP_RIFTS);

            _scheduler.Schedule(time, [this, lastPosition](TaskContext context)
            {
                if (GetCreature(DATA_MEDIVH))
                {
                    // Spawning prevented: after-boss-delay or event failed/not started or last portal spawned
                    if (!_noBossSpawnDelay || _eventStatus == EVENT_PREPARE || _currentRift >= 18)
                    {
                        return;
                    }

                    Position spawnPos;
                    if (!_availableRiftPositions.empty())
                    {
                        if (_availableRiftPositions.size() > 1)
                        {
                            spawnPos = Acore::Containers::SelectRandomContainerElementIf(_availableRiftPositions, [&](Position pos) -> bool
                            {
                                return pos != lastPosition;
                            });
                        }
                        else
                        {
                            spawnPos = Acore::Containers::SelectRandomContainerElement(_availableRiftPositions);
                        }

                        _availableRiftPositions.remove(spawnPos);

                        DoUpdateWorldState(WORLD_STATE_BM_RIFT, ++_currentRift);

                        instance->SummonCreature(NPC_TIME_RIFT, spawnPos);

                        // queue next portal if group doesn't kill keepers fast enough
                        context.Repeat((_currentRift >= 13 ? 2min : 90s));
                    }
                    // if no rift positions are available, the next rift will be scheduled in OnCreatureRemove
                }

                context.SetGroup(CONTEXT_GROUP_RIFTS);
            });
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_TIME_RIFT:
                case NPC_CHRONO_LORD_DEJA:
                case NPC_INFINITE_CHRONO_LORD:
                case NPC_TEMPORUS:
                case NPC_INFINITE_TIMEREAVER:
                case NPC_AEONUS:
                case NPC_RIFT_KEEPER_WARLOCK:
                case NPC_RIFT_KEEPER_MAGE:
                case NPC_RIFT_LORD:
                case NPC_RIFT_LORD_2:
                case NPC_INFINITE_ASSASSIN:
                case NPC_INFINITE_ASSASSIN_2:
                case NPC_INFINITE_WHELP:
                case NPC_INFINITE_CHRONOMANCER:
                case NPC_INFINITE_CHRONOMANCER_2:
                case NPC_INFINITE_EXECUTIONER:
                case NPC_INFINITE_EXECUTIONER_2:
                case NPC_INFINITE_VANQUISHER:
                case NPC_INFINITE_VANQUISHER_2:
                case NPC_DP_BEAM_STALKER:
                case NPC_DP_EMITTER_STALKER:
                    _encounterNPCs.insert(creature->GetGUID());
                    break;
            }

            InstanceScript::OnCreatureCreate(creature);
        }

        void OnCreatureRemove(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_TIME_RIFT:
                    if (_currentRift < 18 && _noBossSpawnDelay && _eventStatus == EVENT_IN_PROGRESS)
                    {
                        if (_availableRiftPositions.size() < 3)
                        {
                            ScheduleNextPortal((_currentRift >= 13 ? 2min : 90s), creature->GetHomePosition());
                        }
                        else
                        {
                            ScheduleNextPortal(1s, creature->GetHomePosition());
                        }
                    }

                    _availableRiftPositions.push_back(creature->GetHomePosition());
                    [[fallthrough]];
                case NPC_CHRONO_LORD_DEJA:
                case NPC_INFINITE_CHRONO_LORD:
                case NPC_TEMPORUS:
                case NPC_INFINITE_TIMEREAVER:
                case NPC_AEONUS:
                case NPC_RIFT_KEEPER_WARLOCK:
                case NPC_RIFT_KEEPER_MAGE:
                case NPC_RIFT_LORD:
                case NPC_RIFT_LORD_2:
                case NPC_INFINITE_ASSASSIN:
                case NPC_INFINITE_ASSASSIN_2:
                case NPC_INFINITE_WHELP:
                case NPC_INFINITE_CHRONOMANCER:
                case NPC_INFINITE_CHRONOMANCER_2:
                case NPC_INFINITE_EXECUTIONER:
                case NPC_INFINITE_EXECUTIONER_2:
                case NPC_INFINITE_VANQUISHER:
                case NPC_INFINITE_VANQUISHER_2:
                case NPC_DP_EMITTER_STALKER:
                    _encounterNPCs.erase(creature->GetGUID());
                    break;
            }

            InstanceScript::OnCreatureRemove(creature);
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_MEDIVH:
                {
                    _eventStatus = EVENT_IN_PROGRESS;

                    DoUpdateWorldState(WORLD_STATE_BM, _eventStatus);
                    DoUpdateWorldState(WORLD_STATE_BM_SHIELD, _shieldPercent);
                    DoUpdateWorldState(WORLD_STATE_BM_RIFT, _currentRift);

                    ScheduleNextPortal(3s, Position(0.0f, 0.0f, 0.0f, 0.0f));

                    break;
                }
                case DATA_DAMAGE_SHIELD:
                {
                    if (_shieldPercent <= 0)
                    {
                        return;
                    }

                    _shieldPercent -= data;
                    if (_shieldPercent < 0)
                    {
                        _shieldPercent = 0;
                    }

                    DoUpdateWorldState(WORLD_STATE_BM_SHIELD, _shieldPercent);

                    if (!_shieldPercent)
                    {
                        _eventStatus = EVENT_PREPARE;

                        if (Creature* medivh = GetCreature(DATA_MEDIVH))
                        {
                            if (medivh->IsAlive() && medivh->IsAIEnabled)
                            {
                                medivh->SetImmuneToNPC(true);
                                medivh->AI()->Talk(SAY_MEDIVH_DEATH);

                                for (ObjectGuid const& guid : _encounterNPCs)
                                {
                                    if (Creature* creature = instance->GetCreature(guid))
                                    {
                                        creature->InterruptNonMeleeSpells(true);
                                    }
                                }

                                // Step 1 - Medivh loses all auras.
                                _scheduler.Schedule(4s, [this](TaskContext)
                                {
                                    if (Creature* medivh = GetCreature(DATA_MEDIVH))
                                    {
                                        medivh->RemoveAllAuras();
                                    }

                                    // Step 2 - Medivh dies and visual effect NPCs are despawned.
                                    _scheduler.Schedule(500ms, [this](TaskContext)
                                    {
                                        if (Creature* medivh = GetCreature(DATA_MEDIVH))
                                        {
                                            medivh->KillSelf(false);

                                            GuidSet encounterNPCSCopy = _encounterNPCs;
                                            for (ObjectGuid const& guid : encounterNPCSCopy)
                                            {
                                                switch (guid.GetEntry())
                                                {
                                                    case NPC_TIME_RIFT:
                                                    case NPC_DP_EMITTER_STALKER:
                                                    case NPC_DP_CRYSTAL_STALKER:
                                                    case NPC_DP_BEAM_STALKER:
                                                        if (Creature* creature = instance->GetCreature(guid))
                                                        {
                                                            creature->DespawnOrUnsummon();
                                                        }
                                                        break;
                                                    default:
                                                        break;
                                                }
                                            }
                                        }

                                        // Step 3 - All summoned creatures despawn
                                        _scheduler.Schedule(2s, [this](TaskContext)
                                        {
                                            GuidSet encounterNPCSCopy = _encounterNPCs;
                                            for (ObjectGuid const& guid : encounterNPCSCopy)
                                            {
                                                // Don't despawn permanent visual effect NPC twice or it won't respawn correctly
                                                if (guid.GetEntry() == NPC_DP_BEAM_STALKER)
                                                {
                                                    continue;
                                                }

                                                if (Creature* creature = instance->GetCreature(guid))
                                                {
                                                    creature->CastSpell(creature, SPELL_TELEPORT_VISUAL, true);
                                                    creature->DespawnOrUnsummon(1200ms, 0s);
                                                }
                                            }

                                            _scheduler.CancelAll();

                                            // Step 4 - Schedule instance cleanup without player interaction
                                            _scheduler.Schedule(300s, [this](TaskContext)
                                            {
                                                CleanupInstance();

                                                DoUpdateWorldState(WORLD_STATE_BM, _eventStatus);
                                                DoUpdateWorldState(WORLD_STATE_BM_SHIELD, _shieldPercent);
                                                DoUpdateWorldState(WORLD_STATE_BM_RIFT, _currentRift);
                                            });
                                        });
                                    });
                                });
                            }
                        }
                    }
                    break;
                }
                default:
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_SHIELD_PERCENT:
                    return _shieldPercent;
                case DATA_RIFT_NUMBER:
                    return _currentRift;
            }
            return 0;
        }

        void Update(uint32 diff) override
        {
            _scheduler.Update(diff);
        }

    protected:
        std::list<Position> _availableRiftPositions;
        GuidSet _encounterNPCs;
        uint8 _currentRift;
        int8 _shieldPercent;
        bool _noBossSpawnDelay;
        EventStatus _eventStatus;
        TaskScheduler _scheduler;
    };
};

void AddSC_instance_the_black_morass()
{
    new instance_the_black_morass();
}
