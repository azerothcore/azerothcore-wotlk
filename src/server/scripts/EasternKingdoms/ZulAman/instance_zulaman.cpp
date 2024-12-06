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
#include "TemporarySummon.h"
#include "zulaman.h"

enum Misc
{
    RAND_VENDOR                    = 2,
    WORLDSTATE_SHOW_TIMER          = 3104,
    WORLDSTATE_TIME_TO_SACRIFICE   = 3106
};

// Chests spawn at bear/eagle/dragonhawk/lynx bosses
// The loots depend on how many bosses have been killed, but not the entries of the chests
// But we cannot add loots to gameobject, so we have to use the fixed loot_template
struct SHostageInfo
{
    uint32 npc, go; // FIXME go Not used
    Position pos;
};

static SHostageInfo HostageInfo[] =
{
    {23790, 186648, { -57.0f, 1343.0f, 40.77f, 3.2f } }, // bear
    {23999, 187021, { 400.0f, 1414.0f, 74.36f, 3.3f } }, // eagle
    {24001, 186672, { -35.0f, 1134.0f, 18.71f, 1.9f } }, // dragonhawk
    {24024, 186667, { 413.0f, 1117.0f, 6.32f,  3.1f } }  // lynx
};

Position const HarrisonJonesLoc = {120.687f, 1674.0f, 42.0217f, 1.59044f};

DoorData const doorData[] =
{
    { GO_ZULJIN_FIREWALL,      DATA_ZULJIN,  DOOR_TYPE_ROOM    },
    { GO_DOOR_HALAZZI,         DATA_HALAZZI, DOOR_TYPE_PASSAGE },
    { GO_LYNX_TEMPLE_ENTRANCE, DATA_HALAZZI, DOOR_TYPE_ROOM    },
    { GO_DOOR_AKILZON,         DATA_AKILZON, DOOR_TYPE_ROOM    },
    { 0,                       0,            DOOR_TYPE_ROOM    } // END
};

ObjectData const creatureData[] =
{
    { NPC_JANALAI,          DATA_JANALAI        },
    { NPC_SPIRIT_LYNX,      DATA_SPIRIT_LYNX    },
    { NPC_HARRISON_JONES,   DATA_HARRISON_JONES },
    { NPC_AMINISHI_LOOKOUT, DATA_LOOKOUT        },
    { 0,                    0                   }
};

ObjectData const gameObjectData[] =
{
    { GO_STRANGE_GONG, DATA_STRANGE_GONG },
    { GO_MASSIVE_GATE, DATA_MASSIVE_GATE },
    { GO_GATE_HEXLORD, DATA_HEXLORD_GATE },
    { GO_GATE_ZULJIN,  DATA_ZULJIN_GATE  },
    { 0,               0                 }
};

ObjectData const summonData[] =
{
    { NPC_AMANI_HATCHLING, DATA_JANALAI },
    { 0,                   0            }
};

BossBoundaryData const boundaries =
{
    { DATA_HEXLORD,    new RectangleBoundary(80.50557f, 920.9858f, 155.88986f, 1015.27563f)}
};

class instance_zulaman : public InstanceMapScript
{
public:
    instance_zulaman() : InstanceMapScript("instance_zulaman", 568) { }

    struct instance_zulaman_InstanceMapScript : public InstanceScript
    {
        instance_zulaman_InstanceMapScript(Map* map) : InstanceScript(map) {}

        void Initialize() override
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTER);
            SetPersistentDataCount(PersistentDataCount);
            LoadObjectData(creatureData, gameObjectData);
            LoadBossBoundaries(boundaries);
            LoadDoorData(doorData);
            LoadSummonData(summonData);

            for (uint8 i = 0; i < RAND_VENDOR; ++i)
                RandVendor[i] = NOT_STARTED;
        }

        void OnPlayerEnter(Player* /*player*/) override
        {
            if (!scheduler.IsGroupScheduled(GROUP_TIMED_RUN))
                DoAction(ACTION_START_TIMED_RUN);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                // Akil'zon gauntlet
                case NPC_AMINISHI_TEMPEST:
                    if (creature->GetPositionZ() >= 50.0f) // excludes Tempest in Hexlord Malacrass' trash
                        AkilzonTrash.insert(creature->GetGUID());
                    break;
                case NPC_AMINISHI_LOOKOUT:
                case NPC_AMINISHI_PROTECTOR:
                case NPC_EAGLE_TRASH_AGGRO_TRIGGER:
                    AkilzonTrash.insert(creature->GetGUID());
                    break;
                case NPC_AMANISHI_WIND_WALKER:
                    if (creature->GetPositionZ() >= 26.0f) // excludes Wind Walker in first patrol
                        AkilzonTrash.insert(creature->GetGUID());
                    break;
            }

            InstanceScript::OnCreatureCreate(creature);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            if (go->GetEntry() == GO_GATE_HEXLORD)
                CheckInstanceStatus();

            InstanceScript::OnGameObjectCreate(go);
        }

        void SummonHostage(uint8 num)
        {
            if (!GetPersistentData(DATA_TIMED_RUN))
                return;

            instance->SummonCreature(HostageInfo[num].npc, HostageInfo[num].pos);
        }

        void DoAction(int32 actionId) override
        {
            if (actionId == ACTION_START_TIMED_RUN)
            {
                if (uint32 timer = GetPersistentData(DATA_TIMED_RUN))
                {
                    DoUpdateWorldState(WORLDSTATE_SHOW_TIMER, 1);
                    DoUpdateWorldState(WORLDSTATE_TIME_TO_SACRIFICE, timer);
                }

                scheduler.Schedule(1min, GROUP_TIMED_RUN, [this](TaskContext context)
                {
                    if (uint32 timer = GetPersistentData(DATA_TIMED_RUN))
                    {
                        --timer;
                        DoUpdateWorldState(WORLDSTATE_SHOW_TIMER, 1);
                        DoUpdateWorldState(WORLDSTATE_TIME_TO_SACRIFICE, timer);
                        StorePersistentData(DATA_TIMED_RUN, timer);
                        context.Repeat();
                    }
                    else
                        DoUpdateWorldState(WORLDSTATE_SHOW_TIMER, 0);
                });
            }
        }

        void CheckInstanceStatus()
        {
            if (AllBossesDone({ DATA_NALORAKK, DATA_AKILZON, DATA_JANALAI, DATA_HALAZZI }))
                HandleGameObject(ObjectGuid::Empty, true, GetGameObject(DATA_HEXLORD_GATE));
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == TYPE_RAND_VENDOR_1)
                RandVendor[0] = data;
            else if (type == TYPE_RAND_VENDOR_2)
                RandVendor[1] = data;
            else if (type == TYPE_AKILZON_GAUNTLET)
            {
                if (data == IN_PROGRESS)
                    StartAkilzonGauntlet();
                else if (data == NOT_STARTED)
                    ResetAkilzonGauntlet();
                else if (data == DONE)
                    _akilzonGauntlet = DONE;
            }
        }

        void StartAkilzonGauntlet()
        {
            _akilzonGauntlet = IN_PROGRESS;
            for (ObjectGuid const& guid : AkilzonTrash)
                if (Creature* creature = instance->GetCreature(guid))
                    switch (creature->GetEntry())
                    {
                        case NPC_EAGLE_TRASH_AGGRO_TRIGGER:
                            creature->DisappearAndDie();
                            break;
                        case NPC_AMINISHI_LOOKOUT:
                        case NPC_AMINISHI_TEMPEST:
                            creature->AI()->DoAction(ACTION_START_AKILZON_GAUNTLET);
                            break;
                        default:
                            break;
                    }
        }

        void ResetAkilzonGauntlet()
        {
            _akilzonGauntlet = NOT_STARTED;
            for (ObjectGuid guid : AkilzonTrash)
                if (Creature* creature = instance->GetCreature(guid))
                    if (!creature->IsAlive())
                        creature->Respawn();
            if (Creature* creature = GetCreature(DATA_LOOKOUT))
                if (creature->isMoving())
                    creature->Respawn(true);
        }

        void OnCreatureEvade(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_AMINISHI_TEMPEST:
                case NPC_AMINISHI_PROTECTOR:
                case NPC_AMANISHI_WIND_WALKER:
                    if (AkilzonTrash.contains(creature->GetGUID()))
                        ResetAkilzonGauntlet();
                    break;
                default:
                    break;
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
                case DATA_NALORAKK:
                    if (state == DONE)
                    {
                        if (uint32 timer = GetPersistentData(DATA_TIMED_RUN))
                        {
                            StorePersistentData(DATA_TIMED_RUN, timer += 15);
                            DoUpdateWorldState(WORLDSTATE_TIME_TO_SACRIFICE, timer);
                        }
                        SummonHostage(0);
                    }
                    break;
                case DATA_AKILZON:
                    if (state == DONE)
                    {
                        if (uint32 timer = GetPersistentData(DATA_TIMED_RUN))
                        {
                            StorePersistentData(DATA_TIMED_RUN, timer += 10);
                            DoUpdateWorldState(WORLDSTATE_TIME_TO_SACRIFICE, timer);
                        }
                        SummonHostage(1);
                    }
                    break;
                case DATA_JANALAI:
                    if (state == DONE)
                        SummonHostage(2);
                    break;
                case DATA_HALAZZI:
                    if (state == DONE)
                        SummonHostage(3);
                    break;
                case DATA_HEXLORD:
                    if (state == IN_PROGRESS)
                        HandleGameObject(ObjectGuid::Empty, false, GetGameObject(DATA_HEXLORD_GATE));
                    else if (state == NOT_STARTED)
                        CheckInstanceStatus();
                    else if (state == DONE)
                    {
                        if (GameObject* zuljinGate = GetGameObject(DATA_ZULJIN_GATE))
                            zuljinGate->RemoveGameObjectFlag(GO_FLAG_LOCKED);
                    }
                    break;
            }

            if (state == DONE)
            {
                if (GetPersistentData(DATA_TIMED_RUN) && AllBossesDone({ DATA_NALORAKK, DATA_AKILZON, DATA_JANALAI, DATA_HALAZZI }))
                {
                    StorePersistentData(DATA_TIMED_RUN, 0);
                    DoUpdateWorldState(WORLDSTATE_SHOW_TIMER, 0);
                }

                CheckInstanceStatus();
            }

            return true;
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == TYPE_RAND_VENDOR_1)
                return RandVendor[0];
            else if (type == TYPE_RAND_VENDOR_2)
                return RandVendor[1];
            else if (type == TYPE_AKILZON_GAUNTLET)
                return _akilzonGauntlet;

            return 0;
        }

        void Update(uint32 diff) override
        {
            scheduler.Update(diff);
        }

        private:
            uint32 RandVendor[RAND_VENDOR];
            GuidSet AkilzonTrash;
            EncounterState _akilzonGauntlet = NOT_STARTED;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_zulaman_InstanceMapScript(map);
    }
};

void AddSC_instance_zulaman()
{
    new instance_zulaman();
}
