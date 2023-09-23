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

#include "InstanceScript.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"
#include "magisters_terrace.h"

ObjectData const creatureData[] =
{
    { NPC_KALECGOS,        DATA_KALECGOS         },
    { 0,                   0                     }
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
            LoadObjectData(creatureData, nullptr);
        }

        uint32 Encounter[MAX_ENCOUNTER];

        ObjectGuid VexallusDoorGUID;
        ObjectGuid SelinDoorGUID;
        ObjectGuid SelinEncounterDoorGUID;
        ObjectGuid DelrissaDoorGUID;
        ObjectGuid KaelDoorGUID;
        ObjectGuid EscapeOrbGUID;

        ObjectGuid DelrissaGUID;
        ObjectGuid KaelGUID;

        void Initialize() override
        {
            memset(&Encounter, 0, sizeof(Encounter));
        }

        bool IsEncounterInProgress() const override
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (Encounter[i] == IN_PROGRESS)
                    return true;
            return false;
        }

        uint32 GetData(uint32 identifier) const override
        {
            switch (identifier)
            {
                case DATA_SELIN_EVENT:
                case DATA_VEXALLUS_EVENT:
                case DATA_DELRISSA_EVENT:
                case DATA_KAELTHAS_EVENT:
                    return Encounter[identifier];
            }
            return 0;
        }

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

        void SetData(uint32 identifier, uint32 data) override
        {
            switch (identifier)
            {
                case DATA_SELIN_EVENT:
                    HandleGameObject(SelinDoorGUID, data == DONE);
                    HandleGameObject(SelinEncounterDoorGUID, data != IN_PROGRESS);
                    Encounter[identifier] = data;
                    break;
                case DATA_VEXALLUS_EVENT:
                    if (data == DONE)
                        HandleGameObject(VexallusDoorGUID, true);
                    Encounter[identifier] = data;
                    break;
                case DATA_DELRISSA_EVENT:
                    if (data == DONE)
                        HandleGameObject(DelrissaDoorGUID, true);
                    Encounter[identifier] = data;
                    break;
                case DATA_KAELTHAS_EVENT:
                    HandleGameObject(KaelDoorGUID, data != IN_PROGRESS);
                    if (data == DONE)
                        if (GameObject* escapeOrb = instance->GetGameObject(EscapeOrbGUID))
                            escapeOrb->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    Encounter[identifier] = data;
                    break;
            }

            SaveToDB();
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

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_SELIN_DOOR:
                    if (GetData(DATA_SELIN_EVENT) == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    SelinDoorGUID = go->GetGUID();
                    break;
                case GO_SELIN_ENCOUNTER_DOOR:
                    SelinEncounterDoorGUID = go->GetGUID();
                    break;

                case GO_VEXALLUS_DOOR:
                    if (GetData(DATA_VEXALLUS_EVENT) == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    VexallusDoorGUID = go->GetGUID();
                    break;

                case GO_DELRISSA_DOOR:
                    if (GetData(DATA_DELRISSA_EVENT) == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    DelrissaDoorGUID = go->GetGUID();
                    break;
                case GO_KAEL_DOOR:
                    KaelDoorGUID = go->GetGUID();
                    break;
                case GO_ESCAPE_ORB:
                    if (GetData(DATA_KAELTHAS_EVENT) == DONE)
                        go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    EscapeOrbGUID = go->GetGUID();
                    break;
            }
        }

        // @todo: Use BossStates. This is for code compatibility
        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> Encounter[1];
            data >> Encounter[2];
            data >> Encounter[3];
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << Encounter[0] << ' ' << Encounter[1] << ' ' << Encounter[2] << ' ' << Encounter[3];
        }

        ObjectGuid GetGuidData(uint32 identifier) const override
        {
            switch (identifier)
            {
                case NPC_DELRISSA:
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
