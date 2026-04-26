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
#include "magtheridons_lair.h"

BossBoundaryData const boundaries =
{
    { DATA_MAGTHERIDON, new CircleBoundary(Position(-18.70f, 2.24f), 52.30) }
};

DoorData const doorData[] =
{
    { GO_MAGTHERIDON_DOORS,     DATA_MAGTHERIDON,           DOOR_TYPE_ROOM },
    { 0,                        0,                          DOOR_TYPE_ROOM } // END
};

class instance_magtheridons_lair : public InstanceMapScript
{
public:
    instance_magtheridons_lair() : InstanceMapScript("instance_magtheridons_lair", MAP_MAGTHERIDONS_LAIR) { }

    struct instance_magtheridons_lair_InstanceMapScript : public InstanceScript
    {
        instance_magtheridons_lair_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTER);
            LoadDoorData(doorData);
            LoadBossBoundaries(boundaries);
        }

        void Initialize() override
        {
            _channelersSet.clear();
            _wardersSet.clear();
            _cubesSet.clear();
            _columnSet.clear();
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_MAGTHERIDON:
                    _magtheridonGUID = creature->GetGUID();
                    break;
                case NPC_HELLFIRE_CHANNELER:
                    _channelersSet.insert(creature->GetGUID());
                    break;
                case NPC_HELLFIRE_WARDER:
                    _wardersSet.insert(creature->GetGUID());
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_MAGTHERIDON_DOORS:
                    AddDoor(go);
                    break;
                case GO_MANTICRON_CUBE:
                    _cubesSet.insert(go->GetGUID());
                    break;
                case GO_MAGTHERIDON_HALL:
                case GO_MAGTHERIDON_COLUMN0:
                case GO_MAGTHERIDON_COLUMN1:
                case GO_MAGTHERIDON_COLUMN2:
                case GO_MAGTHERIDON_COLUMN3:
                case GO_MAGTHERIDON_COLUMN4:
                case GO_MAGTHERIDON_COLUMN5:
                    _columnSet.insert(go->GetGUID());
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_MAGTHERIDON_DOORS:
                    RemoveDoor(go);
                    break;
                case GO_MANTICRON_CUBE:
                    _cubesSet.erase(go->GetGUID());
                    break;
                case GO_MAGTHERIDON_HALL:
                case GO_MAGTHERIDON_COLUMN0:
                case GO_MAGTHERIDON_COLUMN1:
                case GO_MAGTHERIDON_COLUMN2:
                case GO_MAGTHERIDON_COLUMN3:
                case GO_MAGTHERIDON_COLUMN4:
                case GO_MAGTHERIDON_COLUMN5:
                    _columnSet.erase(go->GetGUID());
                    break;
            }
        }

        bool SetBossState(uint32 id, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(id, state))
                return false;

            if (id == DATA_MAGTHERIDON)
            {
                if (state == IN_PROGRESS)
                {
                    for (ObjectGuid const& guid : _wardersSet)
                        if (Creature* warder = instance->GetCreature(guid))
                            if (warder->IsAlive())
                            {
                                warder->InterruptNonMeleeSpells(true);
                                warder->SetInCombatWithZone();
                            }
                }
                else
                {
                    for (ObjectGuid const& guid : _cubesSet)
                        if (GameObject* cube = instance->GetGameObject(guid))
                            cube->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);

                    if (state == NOT_STARTED)
                        SetData(DATA_COLLAPSE, GO_READY);

                    // The Channeler formation uses RESPAWN_ON_EVADE, which only
                    // fires when a *living* member evades. If the raid wipes
                    // after every Channeler is already dead (phase 2/3 wipe, or
                    // a wipe during the 3s window before Magtheridon is freed),
                    // no member is alive to trigger the formation respawn, and
                    // the encounter would be left unrecoverable. Respawn the
                    // pack manually in that case.
                    if (state == NOT_STARTED || state == FAIL)
                    {
                        bool anyChannelerAlive = false;
                        for (ObjectGuid const& guid : _channelersSet)
                            if (Creature* channeler = instance->GetCreature(guid))
                                if (channeler->IsAlive())
                                {
                                    anyChannelerAlive = true;
                                    break;
                                }

                        if (!anyChannelerAlive)
                            for (ObjectGuid const& guid : _channelersSet)
                                if (Creature* channeler = instance->GetCreature(guid))
                                    channeler->Respawn(true);
                    }
                }
            }
            return true;
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_CHANNELER_COMBAT:
                    // data == 1: a Channeler entered combat
                    // data == 0: a Channeler evaded (sent from SmartAI on evade)
                    if (data == 1)
                    {
                        if (GetBossState(DATA_MAGTHERIDON) != IN_PROGRESS)
                            if (Creature* magtheridon = instance->GetCreature(_magtheridonGUID))
                                magtheridon->SetInCombatWithZone();
                    }
                    else
                    {
                        // The formation handles respawning dead Channelers
                        // when a living one evades, but Magtheridon himself
                        // is held in combat by SetInCombatWithZone and his
                        // own EnterEvadeMode does not always fire — leaving
                        // his _channelersKilled counter stale, which would
                        // release him prematurely on the next pull. Once
                        // every Channeler has finished evading (and Mag is
                        // still in his pre-release passive state), force a
                        // full encounter reset.
                        if (Creature* magtheridon = instance->GetCreature(_magtheridonGUID))
                        {
                            if (!magtheridon->IsEngaged() && magtheridon->IsImmuneToPC())
                            {
                                bool anyChannelerStillFighting = false;
                                for (ObjectGuid const& guid : _channelersSet)
                                    if (Creature* channeler = instance->GetCreature(guid))
                                        if (channeler->IsAlive() && channeler->IsInCombat())
                                        {
                                            anyChannelerStillFighting = true;
                                            break;
                                        }

                                if (!anyChannelerStillFighting)
                                {
                                    SetBossState(DATA_MAGTHERIDON, NOT_STARTED);
                                    magtheridon->AI()->Reset();
                                }
                            }
                        }
                    }
                    break;
                case DATA_ACTIVATE_CUBES:
                    for (ObjectGuid const& guid : _cubesSet)
                        if (GameObject* cube = instance->GetGameObject(guid))
                            cube->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    break;
                case DATA_COLLAPSE:
                    for (ObjectGuid const& guid : _columnSet)
                        if (GameObject* column = instance->GetGameObject(guid))
                            column->SetGoState(GOState(data));
                    break;
            }
        }

    private:
        ObjectGuid _magtheridonGUID;
        GuidSet _channelersSet;
        GuidSet _wardersSet;
        GuidSet _cubesSet;
        GuidSet _columnSet;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_magtheridons_lair_InstanceMapScript(map);
    }
};

void AddSC_instance_magtheridons_lair()
{
    new instance_magtheridons_lair();
}
