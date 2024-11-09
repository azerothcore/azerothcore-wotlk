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

/* ScriptData
SDName: instance_zulaman
SD%Complete: 80
SDComment:
SDCategory: Zul'Aman
EndScriptData */

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
    float x, y, z, o;
};

static SHostageInfo HostageInfo[] =
{
    {23790, 186648, -57, 1343, 40.77f, 3.2f}, // bear
    {23999, 187021, 400, 1414, 74.36f, 3.3f}, // eagle
    {24001, 186672, -35, 1134, 18.71f, 1.9f}, // dragonhawk
    {24024, 186667, 413, 1117,  6.32f, 3.1f}  // lynx
};

Position const HarrisonJonesLoc = {120.687f, 1674.0f, 42.0217f, 1.59044f};

DoorData const doorData[] =
{
    { GO_ZULJIN_FIREWALL, DATA_ZULJIN,  DOOR_TYPE_ROOM },
    { GO_DOOR_HALAZZI,    DATA_HALAZZI, DOOR_TYPE_ROOM },
    { GO_DOOR_AKILZON,    DATA_AKILZON, DOOR_TYPE_ROOM },
    { 0,                  0,            DOOR_TYPE_ROOM } // END
};

ObjectData const creatureData[] =
{
    { NPC_SPIRIT_LYNX, DATA_SPIRIT_LYNX },
    { 0,               0                }
};

ObjectData const gameObjectData[] =
{
    { GO_STRANGE_GONG, DATA_STRANGE_GONG },
    { GO_MASSIVE_GATE, DATA_MASSIVE_GATE },
    { GO_GATE_HEXLORD, DATA_HEXLORD_GATE },
    { GO_GATE_ZULJIN,  DATA_ZULJIN_GATE  },
    { 0,               0                 }
};

BossBoundaryData const boundaries =
{
    { DATA_HEXLORD,    new RectangleBoundary(80.50557f, 920.9858f, 155.88986f, 1015.27563f)}
};

class instance_zulaman : public InstanceMapScript
{
public:
    instance_zulaman()
        : InstanceMapScript("instance_zulaman", 568)
    {
    }

    struct instance_zulaman_InstanceMapScript : public InstanceScript
    {
        instance_zulaman_InstanceMapScript(Map* map) : InstanceScript(map) {}

        ObjectGuid HarrisonJonesGUID;

        ObjectGuid AkilzonDoorGUID;
        ObjectGuid HalazziDoorGUID;

        uint32 QuestTimer;
        uint16 BossKilled;
        uint16 QuestMinute;
        uint16 ChestLooted;
        uint32 RandVendor[RAND_VENDOR];

        void Initialize() override
        {
            SetHeaders(DataHeader);
            LoadObjectData(creatureData, gameObjectData);
            SetBossNumber(MAX_ENCOUNTER);
            LoadBossBoundaries(boundaries);
            LoadDoorData(doorData);

            QuestTimer = 0;
            QuestMinute = 0;
            BossKilled = 0;
            ChestLooted = 0;

            for (uint8 i = 0; i < RAND_VENDOR; ++i)
                RandVendor[i] = NOT_STARTED;
        }

        void OnPlayerEnter(Player* /*player*/) override
        {
            if (!HarrisonJonesGUID)
                instance->SummonCreature(NPC_HARRISON_JONES, HarrisonJonesLoc);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            if (creature->GetEntry() == NPC_HARRISON_JONES)
                HarrisonJonesGUID = creature->GetGUID();

            InstanceScript::OnCreatureCreate(creature);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            CheckInstanceStatus();
            InstanceScript::OnGameObjectCreate(go);
        }

        void SummonHostage(uint8 num)
        {
            if (!QuestMinute)
                return;

            Map::PlayerList const& PlayerList = instance->GetPlayers();
            if (PlayerList.IsEmpty())
                return;

            Map::PlayerList::const_iterator i = PlayerList.begin();
            if (Player* i_pl = i->GetSource())
            {
                if (Unit* Hostage = i_pl->SummonCreature(HostageInfo[num].npc, HostageInfo[num].x, HostageInfo[num].y, HostageInfo[num].z, HostageInfo[num].o, TEMPSUMMON_DEAD_DESPAWN, 0))
                {
                    Hostage->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    Hostage->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                }
            }
        }

        void CheckInstanceStatus()
        {
            if (BossKilled >= DATA_HALAZZI)
                HandleGameObject(ObjectGuid::Empty, true, GetGameObject(DATA_HEXLORD_GATE));

            if (BossKilled >= DATA_HEXLORD)
                HandleGameObject(ObjectGuid::Empty, true, GetGameObject(DATA_ZULJIN_GATE));
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream ss;
            ss << "S " << BossKilled << ' ' << ChestLooted << ' ' << QuestMinute;

            OUT_SAVE_INST_DATA_COMPLETE;
            return ss.str();
        }

        void Load(const char* load) override
        {
            if (!load)
                return;

            std::istringstream ss(load);
            char dataHead; // S
            uint16 data1, data2, data3;
            ss >> dataHead >> data1 >> data2 >> data3;

            if (dataHead == 'S')
            {
                BossKilled = data1;
                ChestLooted = data2;
                QuestMinute = data3;
            }
            else
            {
                LOG_ERROR("misc", "Zul'aman: corrupted save data.");
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_CHESTLOOTED:
                    ++ChestLooted;
                    SaveToDB();
                    break;
                case TYPE_RAND_VENDOR_1:
                    RandVendor[0] = data;
                    break;
                case TYPE_RAND_VENDOR_2:
                    RandVendor[1] = data;
                    break;
                case DATA_UPDATE_INSTANCE_TIMER:
                    QuestMinute = data;
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
                        if (QuestMinute)
                        {
                            QuestMinute += 15;
                            DoUpdateWorldState(WORLDSTATE_TIME_TO_SACRIFICE, QuestMinute);
                        }
                        SummonHostage(0);
                    }
                    break;
                case DATA_AKILZON:
                    if (state == DONE)
                    {
                        if (QuestMinute)
                        {
                            QuestMinute += 10;
                            DoUpdateWorldState(WORLDSTATE_TIME_TO_SACRIFICE, QuestMinute);
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
                    break;
            }

            if (state == DONE)
            {
                ++BossKilled;
                if (QuestMinute && BossKilled >= DATA_HALAZZI)
                {
                    QuestMinute = 0;
                    DoUpdateWorldState(WORLDSTATE_SHOW_TIMER, 0);
                }

                CheckInstanceStatus();
            }

            return true;
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_CHESTLOOTED:
                    return ChestLooted;
                case TYPE_RAND_VENDOR_1:
                    return RandVendor[0];
                case TYPE_RAND_VENDOR_2:
                    return RandVendor[1];
                default:
                    return 0;
            }
        }

        void Update(uint32 diff) override
        {
            if (QuestMinute)
            {
                if (QuestTimer <= diff)
                {
                    QuestMinute--;
                    SaveToDB();
                    QuestTimer += 60000;
                    if (QuestMinute)
                    {
                        DoUpdateWorldState(WORLDSTATE_SHOW_TIMER, 1);
                        DoUpdateWorldState(WORLDSTATE_TIME_TO_SACRIFICE, QuestMinute);
                    }
                    else DoUpdateWorldState(WORLDSTATE_SHOW_TIMER, 0);
                }
                QuestTimer -= diff;
            }
        }
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
