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

#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "stratholme.h"

const Position BlackGuardPos[10] =
{
    {4032.73f + 0.0f, -3378.26f + 0.0f, 119.76f, 4.67f},
    {4032.73f + 2.0f, -3378.26f + 2.0f, 119.76f, 4.67f},
    {4032.73f + 2.0f, -3378.26f - 2.0f, 119.76f, 4.67f},
    {4032.73f - 2.0f, -3378.26f + 2.0f, 119.76f, 4.67f},
    {4032.73f - 2.0f, -3378.26f - 2.0f, 119.76f, 4.67f},

    {4032.73f + 0.0f, -3407.38f + 0.0f, 115.56f, 0.0f},
    {4032.73f + 2.0f, -3407.38f + 2.0f, 115.56f, 0.0f},
    {4032.73f + 2.0f, -3407.38f - 2.0f, 115.56f, 0.0f},
    {4032.73f - 2.0f, -3407.38f + 2.0f, 115.56f, 0.0f},
    {4032.73f - 2.0f, -3407.38f - 2.0f, 115.56f, 0.0f}
};

// Creatures to be spawned during the trap events
static const uint32 aPlaguedCritters[] =
{
    NPC_PLAGUED_RAT, NPC_PLAGUED_MAGGOT, NPC_PLAGUED_INSECT
};

// Positions of the two Gate Traps
static const Position aGateTrap[] =
{
    {3612.29f, -3335.39f, 124.077f, 3.14159f},  // Scarlet side
    {3919.88f, -3547.34f, 134.269f, 2.94961f}   // Undead side
};

Position const MindlessUndeadPos = { 3941.75f, -3393.06f, 119.70f, 0.0f };
Position const BarthilasPos = { 4068.74f, -3535.97f, 122.825f, 2.478367567062377929f };
Position const SlaughterPos = { 4032.20f, -3378.06f, 119.75f, 4.67f };

// uint32 m_uiGateTrapTimers[2][3] = { {0,0,0}, {0,0,0} };

class instance_stratholme : public InstanceMapScript
{
public:
    instance_stratholme() : InstanceMapScript("instance_stratholme", MAP_STRATHOLME) { }

    struct instance_stratholme_InstanceMapScript : public InstanceScript
    {
        instance_stratholme_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
        }

        void Initialize() override
        {
            _baronRunProgress = 0;
            _baronRunTime = 0;
            _zigguratState1 = 0;
            _zigguratState2 = 0;
            _zigguratState3 = 0;
            _slaughterProgress = 0;
            _slaughterNPCs = 0;
            _postboxesOpened = 0;

            _gateTrapsCooldown[0] = false;
            _gateTrapsCooldown[1] = false;

            events.Reset();
        }

        void OnPlayerEnter(Player* player) override
        {
            if (_baronRunTime > 0)
                if (Aura* aura = player->AddAura(SPELL_BARON_ULTIMATUM, player))
                    aura->SetDuration(_baronRunTime * MINUTE * IN_MILLISECONDS);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_BARON_RIVENDARE:
                    _baronRivendareGUID = creature->GetGUID();
                    break;
                case NPC_VENOM_BELCHER:
                case NPC_BILE_SPEWER:
                    if (_slaughterProgress == 0)
                        ++_slaughterNPCs;
                    break;
                case NPC_RAMSTEIN_THE_GORGER:
                    if (_slaughterProgress == 1)
                        ++_slaughterNPCs;
                    break;
                case NPC_MINDLESS_UNDEAD:
                    if (_slaughterProgress == 2)
                        ++_slaughterNPCs;
                    break;
                case NPC_BLACK_GUARD:
                    if (_slaughterProgress == 3)
                        ++_slaughterNPCs;
                    break;
                case NPC_BARTHILAS:
                    _barthilasGUID = creature->GetGUID();
                    break;
                default:
                    break;
            }
        }

        void ProcessSlaughterEvent()
        {
            if (_slaughterProgress == 1)
            {
                if (Creature* baron = instance->GetCreature(_baronRivendareGUID))
                    baron->AI()->Talk(SAY_BRAON_SUMMON_RAMSTEIN);

                instance->SummonCreature(NPC_RAMSTEIN_THE_GORGER, SlaughterPos);
            }
            if (_slaughterProgress == 2)
            {
                for (uint32 i = 0; i < 33; ++i)
                    events.ScheduleEvent(EVENT_SPAWN_MINDLESS, Milliseconds(5000 + i * 210));
                if (Creature* baron = instance->GetCreature(_baronRivendareGUID))
                    if (GameObject* gate = baron->FindNearestGameObject(GO_SLAUGHTER_GATE_SIDE, 200.0f))
                        gate->SetGoState(GO_STATE_ACTIVE);
            }
            if (_slaughterProgress == 3)
            {
                events.ScheduleEvent(EVENT_SPAWN_BLACK_GUARD, 20s);
            }
            if (_slaughterProgress == 4)
            {
                if (Creature* baron = instance->GetCreature(_baronRivendareGUID))
                    baron->AI()->Talk(SAY_BARON_GUARD_DEAD);
                if (GameObject* gate = instance->GetGameObject(_zigguratDoorsGUID5))
                    gate->SetGoState(GO_STATE_ACTIVE);
            }
        }

        void OnUnitDeath(Unit* unit) override
        {
            switch (unit->GetEntry())
            {
                case NPC_VENOM_BELCHER:
                case NPC_BILE_SPEWER:
                case NPC_RAMSTEIN_THE_GORGER:
                case NPC_MINDLESS_UNDEAD:
                case NPC_BLACK_GUARD:
                    if (--_slaughterNPCs == 0)
                    {
                        ++_slaughterProgress;
                        ProcessSlaughterEvent();
                        SaveToDB();
                    }
                    break;
                case NPC_BARON_RIVENDARE:
                    events.CancelEvent(EVENT_BARON_TIME);
                    DoRemoveAurasDueToSpellOnPlayers(SPELL_BARON_ULTIMATUM);
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_CRUSADER_SQUARE_DOOR:
                case GO_HOARD_DOOR:
                case GO_HALL_OF_HIGH_COMMAND:
                case GO_GAUNTLET_DOOR_1:
                case GO_GAUNTLET_DOOR_2:
                    go->AllowSaveToDB(true);
                    break;
                case GO_ZIGGURAT_DOORS1:
                    go->AllowSaveToDB(true);
                    _zigguratDoorsGUID1 = go->GetGUID();
                    if (GetData(TYPE_ZIGGURAT1) >= 1)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_ZIGGURAT_DOORS2:
                    go->AllowSaveToDB(true);
                    _zigguratDoorsGUID2 = go->GetGUID();
                    if (GetData(TYPE_ZIGGURAT2) >= 1)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_ZIGGURAT_DOORS3:
                    go->AllowSaveToDB(true);
                    _zigguratDoorsGUID3 = go->GetGUID();
                    if (GetData(TYPE_ZIGGURAT3) >= 1)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_GAUNTLET_GATE:
                    go->AllowSaveToDB(true);
                    _gauntletGateGUID = go->GetGUID();
                    if (_zigguratState1 == 2 && _zigguratState2 == 2 && _zigguratState3 == 2)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_SLAUGTHER_GATE:
                    go->AllowSaveToDB(true);
                    _slaughterGateGUID = go->GetGUID();
                    if (_zigguratState1 == 2 && _zigguratState2 == 2 && _zigguratState3 == 2)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_ZIGGURAT_DOORS4:
                    go->AllowSaveToDB(true);
                    _zigguratDoorsGUID4 = go->GetGUID();
                    if (_slaughterProgress == 4)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_ZIGGURAT_DOORS5:
                    go->AllowSaveToDB(true);
                    _zigguratDoorsGUID5 = go->GetGUID();
                    if (_slaughterProgress == 4)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_SLAUGHTER_GATE_SIDE:
                    go->AllowSaveToDB(true);
                    if (_slaughterProgress >= 2)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_PORT_TRAP_GATE_1:
                    go->AllowSaveToDB(true);
                    _trapGatesGUIDs[0] = go->GetGUID();
                    break;
                case GO_PORT_TRAP_GATE_2:
                    go->AllowSaveToDB(true);
                    _trapGatesGUIDs[1] = go->GetGUID();
                    break;
                case GO_PORT_TRAP_GATE_3:
                    go->AllowSaveToDB(true);
                    _trapGatesGUIDs[2] = go->GetGUID();
                    break;
                case GO_PORT_TRAP_GATE_4:
                    go->AllowSaveToDB(true);
                    _trapGatesGUIDs[3] = go->GetGUID();
                    break;
                default:
                    break;
            }
        }

        void CheckZiggurats()
        {
            if (_zigguratState1 == 2 && _zigguratState2 == 2 && _zigguratState3 == 2)
            {
                if (Creature* baron = instance->GetCreature(_baronRivendareGUID))
                    baron->AI()->Talk(SAY_BRAON_ZIGGURAT_FALL_YELL);

                if (GameObject* gate = instance->GetGameObject(_gauntletGateGUID))
                    gate->SetGoState(GO_STATE_ACTIVE);
                if (GameObject* gate = instance->GetGameObject(_slaughterGateGUID))
                    gate->SetGoState(GO_STATE_ACTIVE);
            }
        }

        void DoSpawnPlaguedCritters(uint8 /*uiGate*/, Player* player)
        {
            if (!player)
                return;

            uint32 uiEntry = aPlaguedCritters[urand(0, 2)];
            for (uint8 i = 0; i < 30; ++i)
            {
                float x, y, z;
                const Position pPos = { player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetOrientation() };
                player->GetRandomPoint(pPos, 8.0f, x, y, z);
                z = player->GetPositionZ() + 1;
                player->SummonCreature(uiEntry, x, y, z, 0, TEMPSUMMON_DEAD_DESPAWN, 0)->AI()->AttackStart(player);
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case TYPE_BARON_RUN:
                {
                    if (_baronRunProgress == DATA_BARON_RUN_NONE)
                    {
                        _baronRunProgress = DATA_BARON_RUN_GATE;
                        _baronRunTime = 45;
                        DoCastSpellOnPlayers(SPELL_BARON_ULTIMATUM);
                        events.ScheduleEvent(EVENT_BARON_TIME, 60s);

                        if (Creature* baron = instance->GetCreature(_baronRivendareGUID))
                            baron->AI()->Talk(SAY_BARON_INIT_YELL);
                    }
                    break;
                }
                case TYPE_ZIGGURAT1:
                {
                    if (data == _zigguratState1 + 1)
                        ++_zigguratState1;

                    if (_zigguratState1 == 1)
                        if (GameObject* ziggurat = instance->GetGameObject(_zigguratDoorsGUID1))
                            ziggurat->SetGoState(GO_STATE_ACTIVE);

                    CheckZiggurats();
                    break;
                }
                case TYPE_ZIGGURAT2:
                {
                    if (data == _zigguratState2 + 1)
                        ++_zigguratState2;

                    if (_zigguratState2 == 1)
                        if (GameObject* ziggurat = instance->GetGameObject(_zigguratDoorsGUID2))
                            ziggurat->SetGoState(GO_STATE_ACTIVE);

                    CheckZiggurats();
                    break;
                }
                case TYPE_ZIGGURAT3:
                {
                    if (data == _zigguratState3 + 1)
                        ++_zigguratState3;

                    if (_zigguratState3 == 1)
                        if (GameObject* ziggurat = instance->GetGameObject(_zigguratDoorsGUID3))
                            ziggurat->SetGoState(GO_STATE_ACTIVE);

                    CheckZiggurats();
                    break;
                }
                case TYPE_BARON_FIGHT:
                {
                    if (GameObject* gate = instance->GetGameObject(_zigguratDoorsGUID5))
                        gate->SetGoState(data == IN_PROGRESS ? GO_STATE_READY : GO_STATE_ACTIVE);
                    return;
                }
                case TYPE_MALLOW:
                    ++_postboxesOpened;
                    break;
                case TYPE_BARTHILAS_RUN:
                    if (data == DONE)
                    {
                        if (Creature* barthilas = instance->GetCreature(_barthilasGUID))
                        {
                            if (barthilas->IsAlive())
                            {
                                barthilas->NearTeleportTo(BarthilasPos.GetPositionX(), BarthilasPos.GetPositionY(), BarthilasPos.GetPositionZ(), BarthilasPos.GetOrientation());
                                barthilas->SetHomePosition(BarthilasPos);
                            }
                        }
                    }
                    _barthilasrunProgress = data;
                    break;
            }

            SaveToDB();
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> _baronRunProgress;
            data >> _baronRunTime;
            data >> _zigguratState1;
            data >> _zigguratState2;
            data >> _zigguratState3;
            data >> _slaughterProgress;
            data >> _postboxesOpened;
            data >> _barthilasrunProgress;
            if (_baronRunTime)
            {
                events.ScheduleEvent(EVENT_BARON_TIME, 60s);
            }

            if (_slaughterProgress > 0 && _slaughterProgress < 4)
            {
                events.ScheduleEvent(EVENT_FORCE_SLAUGHTER_EVENT, 5s);
            }
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << _baronRunProgress << ' '
                << _baronRunTime << ' '
                << _zigguratState1 << ' '
                << _zigguratState2 << ' '
                << _zigguratState3 << ' '
                << _slaughterProgress << ' '
                << _postboxesOpened << ' '
                << _barthilasrunProgress;
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case TYPE_ZIGGURAT1:
                    return _zigguratState1;
                case TYPE_ZIGGURAT2:
                    return _zigguratState2;
                case TYPE_ZIGGURAT3:
                    return _zigguratState3;
                case TYPE_MALLOW:
                    return _postboxesOpened;
                case TYPE_BARTHILAS_RUN:
                    return _barthilasrunProgress;
            }
            return 0;
        }

        void Update(uint32 diff) override
        {
            events.Update(diff);

            Map::PlayerList const& players = instance->GetPlayers();
            // Loop over the two Gate traps, each one has up to three timers (trap reset, gate opening delay, critters spawning delay)
            for (uint8 i = 0; i < 2; i++)
            {
                // if the gate is in cooldown, skip the other checks
                if (_gateTrapsCooldown[i])
                    break;

                // Check that the trap is not on cooldown, if so check if player/pet is in range
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                {
                    if (Player* player = itr->GetSource())
                    {
                        // should pet also trigger the trap? could not find any source for it
                        if (!player->IsGameMaster() && player->IsWithinDist2d(aGateTrap[i].m_positionX, aGateTrap[i].m_positionY, 5.5f))
                        {
                            // Check if timer was not already set by another player/pet a few milliseconds before
                            if (_gateTrapsCooldown[i])
                                return;

                            _gateTrapsCooldown[i] = true;

                            // close the gates
                            if (_trapGatesGUIDs[2 * i])
                                DoUseDoorOrButton(_trapGatesGUIDs[2 * i]);
                            if (_trapGatesGUIDs[2 * i + 1])
                                DoUseDoorOrButton(_trapGatesGUIDs[2 * i + 1]);

                            _trappedPlayerGUID = player->GetGUID();

                            if (i == 0)
                            {
                                // set timer to reset the trap
                                events.ScheduleEvent(EVENT_GATE1_TRAP, 1800s);
                                // set timer to reopen gates
                                events.ScheduleEvent(EVENT_GATE1_DELAY, 20s);
                                // set timer to spawn the plagued critters
                                events.ScheduleEvent(EVENT_GATE1_CRITTER_DELAY, 2s);
                            }
                            else if (i == 1)
                            {
                                // set timer to reset the trap
                                events.ScheduleEvent(EVENT_GATE2_TRAP, 1800s);
                                // set timer to reopen gates
                                events.ScheduleEvent(EVENT_GATE2_DELAY, 20s);
                                // set timer to spawn the plagued critters
                                events.ScheduleEvent(EVENT_GATE2_CRITTER_DELAY, 2s);
                            }
                        }
                    }
                }
            }

            const int GATE1 = 0;
            const int GATE2 = 1;

            switch (events.ExecuteEvent())
            {
                case EVENT_GATE1_TRAP:
                    _gateTrapsCooldown[GATE1] = false;
                    break;
                case EVENT_GATE2_TRAP:
                    _gateTrapsCooldown[GATE2] = false;
                    break;
                case EVENT_GATE1_DELAY:
                    gate_delay(GATE1);
                    break;
                case EVENT_GATE2_DELAY:
                    gate_delay(GATE2);
                    break;
                case EVENT_GATE1_CRITTER_DELAY:
                    gate_critter_delay(GATE1);
                    break;
                case EVENT_GATE2_CRITTER_DELAY:
                    gate_critter_delay(GATE2);
                    break;
                case EVENT_BARON_TIME:
                {
                    --_baronRunTime;
                    Creature* baron = instance->GetCreature(_baronRivendareGUID);
                    if (baron && !baron->IsInCombat())
                    {
                        switch (_baronRunTime)
                        {
                            case 10:
                                baron->AI()->Talk(SAY_BARON_10M);
                                break;
                            case 5:
                                baron->AI()->Talk(SAY_BARON_5M);
                                if (Creature* ysida = baron->FindNearestCreature(NPC_YSIDA, 50.0f))
                                    ysida->AI()->SetData(1, 1);
                                break;
                            case 0:
                                baron->AI()->Talk(SAY_BARON_0M);
                                DoRemoveAurasDueToSpellOnPlayers(SPELL_BARON_ULTIMATUM);
                                break;
                        }
                    }

                    if (_baronRunTime > 0)
                        events.ScheduleEvent(EVENT_BARON_TIME, 60s);
                    else
                        events.ScheduleEvent(EVENT_EXECUTE_PRISONER, 0ms);

                    SaveToDB();
                    break;
                }
                case EVENT_EXECUTE_PRISONER:
                {
                    Creature* baron = instance->GetCreature(_baronRivendareGUID);
                    if (baron && baron->IsAlive())
                    {
                        if (!baron->IsInCombat())
                        {
                            baron->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H);
                            if (Creature* ysida = baron->FindNearestCreature(NPC_YSIDA, 50.0f))
                                Unit::Kill(baron, ysida);
                        }
                        else
                            events.ScheduleEvent(EVENT_EXECUTE_PRISONER, 1s);
                    }
                    break;
                }
                case EVENT_SPAWN_MINDLESS:
                {
                    instance->SummonCreature(NPC_MINDLESS_UNDEAD, MindlessUndeadPos);
                    break;
                }
                case EVENT_FORCE_SLAUGHTER_EVENT:
                {
                    Map::PlayerList const& PlayerList = instance->GetPlayers();
                    if (!PlayerList.IsEmpty())
                        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                            if (Player* player = i->GetSource())
                                if (player->GetDistance2d(4034.97f, -3402.13f) < 50.0f)
                                {
                                    ProcessSlaughterEvent();
                                    return;
                                }

                    events.ScheduleEvent(EVENT_FORCE_SLAUGHTER_EVENT, 3s);
                    break;
                }
                case EVENT_SPAWN_BLACK_GUARD:
                {
                    for (uint8 i = 0; i < 5; ++i)
                        if (Creature* guard = instance->SummonCreature(NPC_BLACK_GUARD, BlackGuardPos[i]))
                        {
                            guard->SetWalk(true);
                            guard->GetMotionMaster()->MovePoint(0, BlackGuardPos[i + 5]);
                            guard->SetHomePosition(BlackGuardPos[i + 5]);
                            if (i == 0 && guard->AI())
                                guard->AI()->Talk(SAY_BLACK_GUARD_INIT);
                        }

                    if (GameObject* gate = instance->GetGameObject(_zigguratDoorsGUID4))
                        gate->SetGoState(GO_STATE_ACTIVE);
                    break;
                }
                default:
                    break;
            }
        }

    private:
        uint32 _baronRunProgress;
        uint32 _baronRunTime;
        uint32 _zigguratState1;
        uint32 _zigguratState2;
        uint32 _zigguratState3;
        uint32 _slaughterProgress;
        uint32 _slaughterNPCs;
        uint32 _barthilasrunProgress{};
        uint32 _postboxesOpened;
        EventMap events;

        ObjectGuid _zigguratDoorsGUID1;
        ObjectGuid _zigguratDoorsGUID2;
        ObjectGuid _zigguratDoorsGUID3;
        ObjectGuid _zigguratDoorsGUID4;
        ObjectGuid _zigguratDoorsGUID5;
        ObjectGuid _slaughterGateGUID;
        ObjectGuid _gauntletGateGUID;
        ObjectGuid _baronRivendareGUID;
        ObjectGuid _barthilasGUID;

        bool _gateTrapsCooldown[2];
        ObjectGuid _trappedPlayerGUID;
        ObjectGuid _trapGatesGUIDs[4];

        void gate_delay(int gate)
        {
            if (_trapGatesGUIDs[2 * gate])
            {
                DoUseDoorOrButton(_trapGatesGUIDs[2 * gate]);
            }
            if (_trapGatesGUIDs[2 * gate + 1])
            {
                DoUseDoorOrButton(_trapGatesGUIDs[2 * gate + 1]);
            }
        }

        void gate_critter_delay(int gate)
        {
            if (_trappedPlayerGUID)
            {
                if (Player* pPlayer = ObjectAccessor::GetPlayer(instance, _trappedPlayerGUID))
                {
                    DoSpawnPlaguedCritters(gate, pPlayer);
                }
            }
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_stratholme_InstanceMapScript(map);
    }
};

void AddSC_instance_stratholme()
{
    new instance_stratholme();
}
