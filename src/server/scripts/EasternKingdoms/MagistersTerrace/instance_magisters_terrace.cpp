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

#include "CreatureScript.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "ScriptedCreature.h"
#include "magisters_terrace.h"

ObjectData const creatureData[] =
{
    { NPC_KALECGOS,        DATA_KALECGOS         },
    { 0,                   0                     }
};

ObjectData const gameobjectData[] =
{
    { GO_ESCAPE_ORB, DATA_ESCAPE_ORB },
    { 0,             0,              }
};

DoorData const doorData[] =
{
    { GO_SELIN_DOOR,           DATA_SELIN_FIREHEART, DOOR_TYPE_PASSAGE },
    { GO_SELIN_ENCOUNTER_DOOR, DATA_SELIN_FIREHEART, DOOR_TYPE_ROOM    },
    { GO_VEXALLUS_DOOR,        DATA_VEXALLUS,        DOOR_TYPE_PASSAGE },
    { GO_DELRISSA_DOOR,        DATA_DELRISSA,        DOOR_TYPE_PASSAGE },
    { 0,                       0,                    DOOR_TYPE_ROOM    } // END
};

Position const KalecgosSpawnPos = { 164.3747f, -397.1197f, 2.151798f, 1.66219f };

class instance_magisters_terrace : public InstanceMapScript
{
public:
    instance_magisters_terrace() : InstanceMapScript("instance_magisters_terrace", 585) { }

    struct instance_magisters_terrace_InstanceMapScript : public InstanceScript
    {
        instance_magisters_terrace_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTER);
            LoadObjectData(creatureData, gameobjectData);
            LoadDoorData(doorData);
        }

        ObjectGuid EscapeOrbGUID;

        ObjectGuid DelrissaGUID;
        ObjectGuid KaelGUID;

        void ProcessEvent(WorldObject* /*obj*/, uint32 eventId) override
        {
            if (eventId == EVENT_SPAWN_KALECGOS)
            {
                if (!GetCreature(DATA_KALECGOS) && !scheduler.IsGroupScheduled(DATA_KALECGOS))
                {
                    scheduler.Schedule(1min, 1min, DATA_KALECGOS,[this](TaskContext)
                    {
                        if (Creature* kalecgos = instance->SummonCreature(NPC_KALECGOS, KalecgosSpawnPos))
                        {
                            kalecgos->GetMotionMaster()->MovePath(PATH_KALECGOS_FLIGHT, false);
                            kalecgos->AI()->Talk(SAY_KALECGOS_SPAWN);
                        }
                    });
                }
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_DELRISSA:
                    DelrissaGUID = creature->GetGUID();
                    break;
                case NPC_KAEL_THAS:
                    KaelGUID = creature->GetGUID();
                    break;
                case NPC_PHOENIX:
                case NPC_PHOENIX_EGG:
                    if (Creature* kael = instance->GetCreature(KaelGUID))
                        kael->AI()->JustSummoned(creature);
                    break;
            }

            InstanceScript::OnCreatureCreate(creature);
        }

        ObjectGuid GetGuidData(uint32 identifier) const override
        {
            if (identifier == NPC_DELRISSA)
            {
                return DelrissaGUID;
            }

            return ObjectGuid::Empty;
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_magisters_terrace_InstanceMapScript(map);
    }
};

enum Spells
{
    SPELL_KALECGOS_TRANSFORM = 44670,
    SPELL_TRANSFORM_VISUAL   = 24085,
    SPELL_CAMERA_SHAKE       = 44762,
    SPELL_ORB_KILL_CREDIT    = 46307
};

enum MovementPoints
{
    POINT_ID_PREPARE_LANDING = 6
};

struct npc_kalecgos : public ScriptedAI
{
    npc_kalecgos(Creature* creature) : ScriptedAI(creature) { }

    void MovementInform(uint32 type, uint32 pointId) override
    {
        if (type != WAYPOINT_MOTION_TYPE)
            return;

        if (pointId == POINT_ID_PREPARE_LANDING)
        {
            me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
            me->SetDisableGravity(false);
            me->SetHover(false);

            me->m_Events.AddEventAtOffset([this]()
            {
                DoCastAOE(SPELL_CAMERA_SHAKE);
                me->SetObjectScale(0.6f);

                me->m_Events.AddEventAtOffset([this]()
                {
                    DoCastSelf(SPELL_ORB_KILL_CREDIT, true);
                    DoCastSelf(SPELL_TRANSFORM_VISUAL);
                    DoCastSelf(SPELL_KALECGOS_TRANSFORM);
                    me->UpdateEntry(NPC_HUMAN_KALECGOS);
                }, 1s);
            }, 2s);
        }
    }
};

void AddSC_instance_magisters_terrace()
{
    new instance_magisters_terrace();
    RegisterMagistersTerraceCreatureAI(npc_kalecgos);
}
