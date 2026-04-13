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

#include "CreatureScript.h"
#include "InstanceMapScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "WorldStateDefines.h"
#include "violet_hold.h"

enum VHYells
{
    CYANIGOSA_SAY_SPAWN       = 3,
    SAY_SINCLARI_LEAVING      = 0,
    SAY_SINCLARI_DOOR_LOCK    = 1,
    SAY_SINCLARI_COMPLETE     = 2,
};

ObjectData const creatureData[] =
{
    { NPC_MORAGG,                BOSS_MORAGG                },
    { NPC_EREKEM,                BOSS_EREKEM                },
    { NPC_ICHORON,               BOSS_ICHORON               },
    { NPC_LAVANTHOR,             BOSS_LAVANTHOR             },
    { NPC_XEVOZZ,                BOSS_XEVOZZ                },
    { NPC_ZURAMAT,               BOSS_ZURAMAT               },
    { NPC_CYANIGOSA,             DATA_CYANIGOSA             },
    { NPC_SINCLARI,              DATA_SINCLARI              },
    { NPC_PRISON_DOOR_SEAL,      DATA_DOOR_SEAL             },
    { NPC_TELEPORTATION_PORTAL,  DATA_TELEPORTATION_PORTAL  },
    { 0,                         0                          }
};

ObjectData const goData[] =
{
    { GO_MAIN_DOOR,              DATA_MAIN_DOOR             },
    { GO_MORAGG_DOOR,            DATA_MORAGG_CELL           },
    { GO_EREKEM_DOOR,            DATA_EREKEM_CELL           },
    { GO_EREKEM_GUARD_1_DOOR,    DATA_EREKEM_GUARD_1_CELL   },
    { GO_EREKEM_GUARD_2_DOOR,    DATA_EREKEM_GUARD_2_CELL   },
    { GO_ICHORON_DOOR,           DATA_ICHORON_CELL          },
    { GO_LAVANTHOR_DOOR,         DATA_LAVANTHOR_CELL        },
    { GO_XEVOZZ_DOOR,            DATA_XEVOZZ_CELL           },
    { GO_ZURAMAT_DOOR,           DATA_ZURAMAT_CELL          },
    { 0,                         0                          }
};

class instance_violet_hold : public InstanceMapScript
{
public:
    instance_violet_hold() : InstanceMapScript("instance_violet_hold", MAP_VIOLET_HOLD) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_violet_hold_InstanceMapScript(map);
    }

    struct instance_violet_hold_InstanceMapScript : public InstanceScript
    {
        instance_violet_hold_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_BOSS);
            SetPersistentDataCount(PERSISTENT_DATA_COUNT);
            LoadObjectData(creatureData, goData);
        }

        void Initialize() override
        {
            _cleaned = false;
            _encounterStatus = NOT_STARTED;
            _events.Reset();
            _gateHealth = 100;
            _waveCount = 0;
            _portalLocation = 0;
            _defensesUsed = false;

            _activationCrystalGuidList.clear();
        }

        bool IsEncounterInProgress() const override
        {
            return _encounterStatus == IN_PROGRESS;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);

            switch (creature->GetEntry())
            {
                case NPC_VIOLET_HOLD_GUARD:
                    for (ObjectGuid& guid : _guardGuid)
                        if (!guid)
                        {
                            guid = creature->GetGUID();
                            break;
                        }
                    break;
                case NPC_DEFENSE_DUMMY_TARGET:
                    creature->ApplySpellImmune(0, IMMUNITY_ID, SPELL_ARCANE_LIGHTNING, true);
                    break;
                case NPC_EREKEM_GUARD:
                    if (!_erekemGuardGuid[0])
                        _erekemGuardGuid[0] = creature->GetGUID();
                    else
                        _erekemGuardGuid[1] = creature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            InstanceScript::OnGameObjectCreate(go);

            if (go->GetEntry() == GO_ACTIVATION_CRYSTAL)
            {
                HandleGameObject(ObjectGuid::Empty, false, go);
                go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                _activationCrystalGuidList.push_back(go->GetGUID());
            }
        }

        bool SetBossState(uint32 id, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(id, state))
                return false;

            switch (id)
            {
                case BOSS_MORAGG:
                case BOSS_EREKEM:
                case BOSS_ICHORON:
                case BOSS_LAVANTHOR:
                case BOSS_XEVOZZ:
                case BOSS_ZURAMAT:
                    if (state == DONE)
                    {
                        if (_waveCount == 6)
                            SetBossState(DATA_1ST_BOSS, DONE);
                        else if (_waveCount == 12)
                            SetBossState(DATA_2ND_BOSS, DONE);
                        _events.RescheduleEvent(EVENT_SUMMON_PORTAL, 35s);
                    }
                    else if (state == FAIL || state == NOT_STARTED)
                    {
                        _cleaned = false;
                        InstanceCleanup();
                    }
                    break;
                case DATA_CYANIGOSA:
                    if (state == DONE)
                    {
                        _events.Reset();
                        _encounterStatus = DONE;
                        HandleGameObject(DATA_MAIN_DOOR, true);
                        DoUpdateWorldState(WORLD_STATE_VIOLET_HOLD_SHOW, 0);
                        if (Creature* sinclari = GetCreature(DATA_SINCLARI))
                        {
                            sinclari->AI()->Talk(SAY_SINCLARI_COMPLETE);
                            sinclari->DespawnOrUnsummon();
                            sinclari->SetRespawnTime(3);
                        }
                    }
                    else if (state == FAIL || state == NOT_STARTED)
                    {
                        _cleaned = false;
                        InstanceCleanup();
                    }
                    break;
                default:
                    break;
            }

            return true;
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_ACTIVATE_DEFENSE_SYSTEM:
                    {
                        if (data)
                            _defensesUsed = true;
                        Position const pos = {1919.09546f, 812.29724f, 86.2905f, M_PI};
                        instance->SummonCreature(NPC_DEFENSE_SYSTEM, pos, 0, 6499);
                    }
                    break;
                case DATA_START_INSTANCE:
                    if (_encounterStatus == NOT_STARTED)
                    {
                        _encounterStatus = IN_PROGRESS;
                        if (Creature* sinclari = GetCreature(DATA_SINCLARI))
                        {
                            sinclari->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                            sinclari->AI()->Talk(SAY_SINCLARI_LEAVING);
                        }
                        _events.RescheduleEvent(EVENT_GUARDS_FALL_BACK, 4s);
                        _events.RescheduleEvent(EVENT_CHECK_PLAYERS, 5s);
                    }
                    break;
                case DATA_PORTAL_DEFEATED:
                    _events.RescheduleEvent(EVENT_SUMMON_PORTAL, 3s);
                    break;
                case DATA_PORTAL_LOCATION:
                    _portalLocation = data;
                    break;
                case DATA_DECREASE_DOOR_HEALTH:
                    if (_gateHealth > 0)
                        --_gateHealth;
                    if (_gateHealth == 0)
                    {
                        _cleaned = false;
                        InstanceCleanup();
                    }
                    DoUpdateWorldState(WORLD_STATE_VIOLET_HOLD_PRISON_STATE, (uint32)_gateHealth);
                    break;
                case DATA_RELEASE_BOSS:
                    if (_waveCount == 6)
                        StartBossEncounter(GetPersistentData(PERSISTENT_DATA_FIRST_BOSS));
                    else
                        StartBossEncounter(GetPersistentData(PERSISTENT_DATA_SECOND_BOSS));
                    break;
                case DATA_ACHIEV:
                    _achievementCompleted = !!data;
                    break;
            }
        }

        void SetGuidData(uint32 type, ObjectGuid data) override
        {
            if (type == DATA_ADD_TRASH_MOB)
                _trashMobs.insert(data);
            else if (type == DATA_DELETE_TRASH_MOB && !_cleaned)
                _trashMobs.erase(data);
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_ENCOUNTER_STATUS:
                    return (uint32)_encounterStatus;
                case DATA_WAVE_COUNT:
                    return (uint32)_waveCount;
                case DATA_PORTAL_LOCATION:
                    return _portalLocation;
            }

            return 0;
        }

        ObjectGuid GetGuidData(uint32 identifier) const override
        {
            if (identifier == DATA_EREKEM_GUARD_1_GUID)
                return _erekemGuardGuid[0];
            if (identifier == DATA_EREKEM_GUARD_2_GUID)
                return _erekemGuardGuid[1];
            return ObjectGuid::Empty;
        }

        void StartBossEncounter(uint32 bossId)
        {
            switch (bossId)
            {
                case BOSS_MORAGG:
                    HandleGameObject(DATA_MORAGG_CELL, true);
                    break;
                case BOSS_EREKEM:
                    HandleGameObject(DATA_EREKEM_CELL, true);
                    HandleGameObject(DATA_EREKEM_GUARD_2_CELL, true);
                    HandleGameObject(DATA_EREKEM_GUARD_1_CELL, true);
                    if (Creature* guard1 = instance->GetCreature(_erekemGuardGuid[0]))
                    {
                        guard1->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        guard1->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        guard1->SetImmuneToNPC(false);
                        guard1->GetMotionMaster()->MovePoint(0, BossStartMove21);
                    }
                    if (Creature* guard2 = instance->GetCreature(_erekemGuardGuid[1]))
                    {
                        guard2->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        guard2->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        guard2->SetImmuneToNPC(false);
                        guard2->GetMotionMaster()->MovePoint(0, BossStartMove22);
                    }
                    break;
                case BOSS_ICHORON:
                    HandleGameObject(DATA_ICHORON_CELL, true);
                    break;
                case BOSS_LAVANTHOR:
                    HandleGameObject(DATA_LAVANTHOR_CELL, true);
                    break;
                case BOSS_XEVOZZ:
                    HandleGameObject(DATA_XEVOZZ_CELL, true);
                    break;
                case BOSS_ZURAMAT:
                    HandleGameObject(DATA_ZURAMAT_CELL, true);
                    break;
            }

            static Position const BossStartPositions[] =
            {
                BossStartMove1,  // BOSS_MORAGG
                BossStartMove2,  // BOSS_EREKEM
                BossStartMove3,  // BOSS_ICHORON
                BossStartMove4,  // BOSS_LAVANTHOR
                BossStartMove5,  // BOSS_XEVOZZ
                BossStartMove6,  // BOSS_ZURAMAT
            };

            Creature* boss = GetCreature(bossId);
            if (boss)
            {
                boss->GetMotionMaster()->MovePoint(0, BossStartPositions[bossId - BOSS_MORAGG]);
                boss->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                boss->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                boss->SetImmuneToNPC(false);
                boss->SetReactState(REACT_AGGRESSIVE);
                if ((_waveCount == 6 && GetBossState(DATA_1ST_BOSS) == DONE) || (_waveCount == 12 && GetBossState(DATA_2ND_BOSS) == DONE))
                    boss->SetLootMode(0);
            }
        }

        void Update(uint32 diff) override
        {
            _events.Update(diff);
            switch (_events.ExecuteEvent())
            {
                case EVENT_CHECK_PLAYERS:
                    if (DoNeedCleanup(false))
                        InstanceCleanup();
                    _events.Repeat(5s);
                    break;
                case EVENT_GUARDS_FALL_BACK:
                    for (ObjectGuid const& guid : _guardGuid)
                        if (Creature* guard = instance->GetCreature(guid))
                        {
                            guard->SetReactState(REACT_PASSIVE);
                            guard->CombatStop();
                            guard->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            guard->GetMotionMaster()->MovePoint(0, guardMovePosition);
                        }
                    _events.RescheduleEvent(EVENT_GUARDS_DISAPPEAR, 5s);
                    break;
                case EVENT_GUARDS_DISAPPEAR:
                    for (ObjectGuid const& guid : _guardGuid)
                        if (Creature* guard = instance->GetCreature(guid))
                            guard->SetVisible(false);
                    _events.RescheduleEvent(EVENT_SINCLARI_FALL_BACK, 2s);
                    break;
                case EVENT_SINCLARI_FALL_BACK:
                    if (Creature* sinclari = GetCreature(DATA_SINCLARI))
                    {
                        sinclari->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        sinclari->GetMotionMaster()->MovePoint(0, sinclariOutsidePosition);
                    }
                    SetData(DATA_ACTIVATE_DEFENSE_SYSTEM, 0);
                    _events.RescheduleEvent(EVENT_START_ENCOUNTER, 4s);
                    break;
                case EVENT_START_ENCOUNTER:
                    if (Creature* sinclari = GetCreature(DATA_SINCLARI))
                    {
                        sinclari->AI()->Talk(SAY_SINCLARI_DOOR_LOCK);
                        sinclari->SetVisible(false);
                    }
                    if (Creature* doorSeal = GetCreature(DATA_DOOR_SEAL))
                        doorSeal->RemoveAllAuras();
                    _gateHealth = 100;
                    HandleGameObject(DATA_MAIN_DOOR, false);
                    DoUpdateWorldState(WORLD_STATE_VIOLET_HOLD_SHOW, 1);
                    DoUpdateWorldState(WORLD_STATE_VIOLET_HOLD_PRISON_STATE, (uint32)_gateHealth);
                    DoUpdateWorldState(WORLD_STATE_VIOLET_HOLD_WAVE_COUNT, (uint32)_waveCount);

                    for (ObjectGuid const& guid : _activationCrystalGuidList)
                        if (GameObject* go = instance->GetGameObject(guid))
                        {
                            HandleGameObject(ObjectGuid::Empty, false, go);
                            go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                        }
                    _events.RescheduleEvent(EVENT_SUMMON_PORTAL, 4s);
                    break;
                case EVENT_SUMMON_PORTAL:
                    ++_waveCount;
                    DoUpdateWorldState(WORLD_STATE_VIOLET_HOLD_WAVE_COUNT, (uint32)_waveCount);
                    SetData(DATA_PORTAL_LOCATION, (GetData(DATA_PORTAL_LOCATION) + urand(1, 5)) % 6);
                    if (Creature* sinclari = GetCreature(DATA_SINCLARI))
                    {
                        if (_waveCount % 6 != 0)
                            sinclari->SummonCreature(NPC_TELEPORTATION_PORTAL, PortalLocations[GetData(DATA_PORTAL_LOCATION)], TEMPSUMMON_CORPSE_DESPAWN);
                        else if (_waveCount == 6 || _waveCount == 12)
                        {
                            if (!GetPersistentData(PERSISTENT_DATA_FIRST_BOSS) || !GetPersistentData(PERSISTENT_DATA_SECOND_BOSS))
                            {
                                uint32 firstBoss = urand(BOSS_MORAGG, BOSS_ZURAMAT);
                                uint32 secondBoss;
                                do { secondBoss = urand(BOSS_MORAGG, BOSS_ZURAMAT); }
                                while (firstBoss == secondBoss);
                                StorePersistentData(PERSISTENT_DATA_FIRST_BOSS, firstBoss);
                                StorePersistentData(PERSISTENT_DATA_SECOND_BOSS, secondBoss);
                            }
                            sinclari->SummonCreature(NPC_TELEPORTATION_PORTAL, MiddleRoomPortalSaboLocation, TEMPSUMMON_CORPSE_DESPAWN);
                        }
                        else
                        {
                            if (Creature* cyanigosa = sinclari->SummonCreature(NPC_CYANIGOSA, CyanigosasSpawnLocation, TEMPSUMMON_DEAD_DESPAWN))
                            {
                                cyanigosa->CastSpell(cyanigosa, SPELL_CYANIGOSA_BLUE_AURA, false);
                                cyanigosa->AI()->Talk(CYANIGOSA_SAY_SPAWN);
                                cyanigosa->GetMotionMaster()->MoveJump(MiddleRoomLocation.GetPositionX(), MiddleRoomLocation.GetPositionY(), MiddleRoomLocation.GetPositionZ(), 10.0f, 20.0f);
                            }
                            _events.RescheduleEvent(EVENT_CYANIGOSA_TRANSFORM, 10s);
                        }
                    }
                    break;
                case EVENT_CYANIGOSA_TRANSFORM:
                    if (Creature* cyanigosa = GetCreature(DATA_CYANIGOSA))
                    {
                        cyanigosa->RemoveAurasDueToSpell(SPELL_CYANIGOSA_BLUE_AURA);
                        cyanigosa->CastSpell(cyanigosa, SPELL_CYANIGOSA_TRANSFORM, 0);
                        _events.RescheduleEvent(EVENT_CYANIGOSA_ATTACK, 2500ms);
                    }
                    break;
                case EVENT_CYANIGOSA_ATTACK:
                    if (Creature* cyanigosa = GetCreature(DATA_CYANIGOSA))
                    {
                        cyanigosa->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        cyanigosa->SetImmuneToNPC(false);
                    }
                    break;
            }
        }

        void OnPlayerEnter(Player* plr) override
        {
            if (_encounterStatus == IN_PROGRESS)
            {
                if (DoNeedCleanup(plr->IsAlive()))
                    InstanceCleanup();

                plr->SendUpdateWorldState(WORLD_STATE_VIOLET_HOLD_SHOW, 1);
                plr->SendUpdateWorldState(WORLD_STATE_VIOLET_HOLD_PRISON_STATE, (uint32)_gateHealth);
                plr->SendUpdateWorldState(WORLD_STATE_VIOLET_HOLD_WAVE_COUNT, (uint32)_waveCount);
            }
            else
                plr->SendUpdateWorldState(WORLD_STATE_VIOLET_HOLD_SHOW, 0);
        }

        bool DoNeedCleanup(bool enter)
        {
            uint32 aliveCount = instance->GetPlayersCountExceptGMs(true);
            bool need = enter ? aliveCount <= 1 : aliveCount == 0;
            if (!need && _cleaned)
                _cleaned = false;
            return need;
        }

        void InstanceCleanup()
        {
            if (_cleaned)
                return;
            _cleaned = true;

            for (ObjectGuid const& guid : _activationCrystalGuidList)
                if (GameObject* go = instance->GetGameObject(guid))
                {
                    HandleGameObject(ObjectGuid::Empty, false, go);
                    go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                }

            if (Creature* sinclari = GetCreature(DATA_SINCLARI))
            {
                sinclari->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                sinclari->DespawnOrUnsummon(0ms, 3s);
            }

            for (ObjectGuid& guid : _guardGuid)
            {
                if (Creature* guard = instance->GetCreature(guid))
                {
                    guard->SetVisible(GetBossState(DATA_CYANIGOSA) != DONE);
                    guard->SetReactState(REACT_AGGRESSIVE);
                    guard->DespawnOrUnsummon(0ms, 3s);
                }
                guid.Clear();
            }

            if (Creature* portal = GetCreature(DATA_TELEPORTATION_PORTAL))
                portal->DespawnOrUnsummon();

            for (ObjectGuid const& guid : _trashMobs)
                if (Creature* trash = instance->GetCreature(guid))
                    trash->DespawnOrUnsummon();

            _trashMobs.clear();

            if (Creature* doorSeal = GetCreature(DATA_DOOR_SEAL))
                doorSeal->RemoveAllAuras();

            HandleGameObject(DATA_MAIN_DOOR, true);

            if (GetBossState(DATA_CYANIGOSA) != DONE)
            {
                HandleGameObject(DATA_MORAGG_CELL, false);
                HandleGameObject(DATA_EREKEM_CELL, false);
                HandleGameObject(DATA_EREKEM_GUARD_2_CELL, false);
                HandleGameObject(DATA_EREKEM_GUARD_1_CELL, false);
                HandleGameObject(DATA_ICHORON_CELL, false);
                HandleGameObject(DATA_LAVANTHOR_CELL, false);
                HandleGameObject(DATA_XEVOZZ_CELL, false);
                HandleGameObject(DATA_ZURAMAT_CELL, false);

                for (uint32 id = BOSS_MORAGG; id <= BOSS_ZURAMAT; ++id)
                {
                    if (Creature* boss = GetCreature(id))
                    {
                        boss->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        boss->SetImmuneToNPC(true);
                        boss->DespawnOrUnsummon(0ms, 3s);
                    }
                }

                if (Creature* guard1 = instance->GetCreature(_erekemGuardGuid[0]))
                {
                    guard1->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    guard1->SetImmuneToNPC(true);
                    guard1->DespawnOrUnsummon(0ms, 3s);
                }
                _erekemGuardGuid[0].Clear();
                if (Creature* guard2 = instance->GetCreature(_erekemGuardGuid[1]))
                {
                    guard2->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    guard2->SetImmuneToNPC(true);
                    guard2->DespawnOrUnsummon(0ms, 3s);
                }
                _erekemGuardGuid[1].Clear();

                if (Creature* cyanigosa = GetCreature(DATA_CYANIGOSA))
                    cyanigosa->DespawnOrUnsummon();
            }

            DoUpdateWorldState(WORLD_STATE_VIOLET_HOLD_SHOW, 0);
            _encounterStatus = NOT_STARTED;
            _gateHealth = 100;
            if (GetBossState(DATA_2ND_BOSS) == DONE)
                _waveCount = 12;
            else if (GetBossState(DATA_1ST_BOSS) == DONE)
                _waveCount = 6;
            else
                _waveCount = 0;
            _defensesUsed = false;
            if (GetBossState(DATA_CYANIGOSA) == DONE)
                _encounterStatus = DONE;
            _events.Reset();
            _events.RescheduleEvent(EVENT_CHECK_PLAYERS, 5s);
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch (criteria_id)
            {
                case CRITERIA_DEFENSELESS:
                    return _gateHealth == 100 && !_defensesUsed;
                case CRITERIA_A_VOID_DANCE:
                case CRITERIA_DEHYDRATION:
                    return _achievementCompleted;
            }
            return false;
        }

    private:
        bool _cleaned{ false };
        uint8 _encounterStatus{ NOT_STARTED };
        EventMap _events;
        uint8 _gateHealth{ 100 };
        uint8 _waveCount{ 0 };
        uint8 _portalLocation{ 0 };
        bool _achievementCompleted{ false };
        bool _defensesUsed{ false };

        GuidVector _activationCrystalGuidList;

        // Multi-instance creature tracking (can't use ObjectData)
        ObjectGuid _guardGuid[4];
        ObjectGuid _erekemGuardGuid[2];

        GuidSet _trashMobs;
    };
};

void AddSC_instance_violet_hold()
{
    new instance_violet_hold();
}
