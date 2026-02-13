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
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "the_eye.h"

ObjectData const creatureData[] =
{
    { NPC_ALAR,             DATA_ALAR           },
    { NPC_KAELTHAS,         DATA_KAELTHAS       },
    { NPC_THALADRED,        DATA_THALADRED      },
    { NPC_LORD_SANGUINAR,   DATA_LORD_SANGUINAR },
    { NPC_CAPERNIAN,        DATA_CAPERNIAN      },
    { NPC_TELONICUS,        DATA_TELONICUS      },
    { 0,                    0                   }
};

ObjectData const gameObjectData[] =
{
    { 0,              0,               }
};

DoorData const doorData[] =
{
    { GO_KAEL_DOOR_1, DATA_KAELTHAS, DOOR_TYPE_ROOM },
    { GO_KAEL_DOOR_2, DATA_KAELTHAS, DOOR_TYPE_ROOM },
    { 0,              0,             DOOR_TYPE_ROOM }
};

BossBoundaryData const boundaries =
{
    { DATA_REAVER,      new CircleBoundary(Position(432.741809f, 371.8595890f), 115.0f)     },
    { DATA_ALAR,        new CircleBoundary(Position(331.000000f, -2.38000000f), 108.29246f) },
    { DATA_ASTROMANCER, new CircleBoundary(Position(432.869202f, -374.213806f), 103.74374f) }
};

class instance_the_eye : public InstanceMapScript
{
public:
    instance_the_eye() : InstanceMapScript("instance_the_eye", MAP_TEMPEST_KEEP) { }

    struct instance_the_eye_InstanceMapScript : public InstanceScript
    {
        instance_the_eye_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTER);
            LoadObjectData(creatureData, gameObjectData);
            LoadDoorData(doorData);
            LoadBossBoundaries(boundaries);
        }

        ObjectGuid ThaladredTheDarkenerGUID;
        ObjectGuid LordSanguinarGUID;
        ObjectGuid GrandAstromancerCapernianGUID;
        ObjectGuid MasterEngineerTelonicusGUID;
        ObjectGuid AlarGUID;
        ObjectGuid KaelthasGUID;
        ObjectGuid BridgeWindowGUID;
        ObjectGuid KaelStateRightGUID;
        ObjectGuid KaelStateLeftGUID;

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_ALAR:
                    AlarGUID = creature->GetGUID();
                    break;
                case NPC_KAELTHAS:
                    KaelthasGUID = creature->GetGUID();
                    break;
                case NPC_THALADRED:
                    ThaladredTheDarkenerGUID = creature->GetGUID();
                    break;
                case NPC_TELONICUS:
                    MasterEngineerTelonicusGUID = creature->GetGUID();
                    break;
                case NPC_CAPERNIAN:
                    GrandAstromancerCapernianGUID = creature->GetGUID();
                    break;
                case NPC_LORD_SANGUINAR:
                    LordSanguinarGUID = creature->GetGUID();
                    break;
            }
            InstanceScript::OnCreatureCreate(creature);
        }

        void OnGameObjectCreate(GameObject* gobject) override
        {
            switch (gobject->GetEntry())
            {
                case GO_BRIDGE_WINDOW:
                    BridgeWindowGUID = gobject->GetGUID();
                    break;
                case GO_KAEL_STATUE_RIGHT:
                    KaelStateRightGUID = gobject->GetGUID();
                    break;
                case GO_KAEL_STATUE_LEFT:
                    KaelStateLeftGUID = gobject->GetGUID();
                    break;
            }
            InstanceScript::OnGameObjectCreate(gobject);
        }

        ObjectGuid GetGuidData(uint32 identifier) const override
        {
            switch (identifier)
            {
                case GO_BRIDGE_WINDOW:
                    return BridgeWindowGUID;
                case GO_KAEL_STATUE_RIGHT:
                    return KaelStateRightGUID;
                case GO_KAEL_STATUE_LEFT:
                    return KaelStateLeftGUID;
                case NPC_ALAR:
                    return AlarGUID;
                case NPC_KAELTHAS:
                    return KaelthasGUID;
            }

            return ObjectGuid::Empty;
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_the_eye_InstanceMapScript(map);
    }
};

void AddSC_instance_the_eye()
{
    new instance_the_eye();
}
