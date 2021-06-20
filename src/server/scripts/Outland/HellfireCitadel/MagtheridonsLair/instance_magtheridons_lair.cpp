/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "InstanceScript.h"
#include "magtheridons_lair.h"


DoorData const doorData[] =
{
    { GO_MAGTHERIDON_DOORS,  TYPE_MAGTHERIDON,   DOOR_TYPE_ROOM,  BOUNDARY_S },
    { 0,                0,              DOOR_TYPE_ROOM,     BOUNDARY_NONE } // END
};

MinionData const minionData[] =
{
    { NPC_HELLFIRE_CHANNELER,   TYPE_MAGTHERIDON }
};

class instance_magtheridons_lair : public InstanceMapScript
{
    public:
        instance_magtheridons_lair() : InstanceMapScript("instance_magtheridons_lair", 544) { }

        struct instance_magtheridons_lair_InstanceMapScript : public InstanceScript
        {
            instance_magtheridons_lair_InstanceMapScript(Map* map) : InstanceScript(map)
            {
                SetBossNumber(MAX_ENCOUNTER);
                LoadDoorData(doorData);
                LoadMinionData(minionData);
            }

            void Initialize()
            {
                _wardersSet.clear();
                _cubesSet.clear();
                _columnSet.clear();
                _magtheridonGUID = 0;
            }

            void OnCreatureCreate(Creature* creature)
            {
                switch (creature->GetEntry())
                {
                    case NPC_MAGTHERIDON:
                        _magtheridonGUID = creature->GetGUID();
                        break;
                    case NPC_HELLFIRE_CHANNELER:
                        AddMinion(creature, true);
                        break;
                    case NPC_HELLFIRE_WARDER:
                        _wardersSet.insert(creature->GetGUID());
                        break;
                }
            }

            void OnCreatureRemove(Creature* creature)
            {
                switch (creature->GetEntry())
                {
                    case NPC_HELLFIRE_CHANNELER:
                        AddMinion(creature, false);
                        break;
                }
            }

            void OnGameObjectCreate(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_MAGTHERIDON_DOORS:
                        AddDoor(go, true);
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

            void OnGameObjectRemove(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_MAGTHERIDON_DOORS:
                        AddDoor(go, false);
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

            bool SetBossState(uint32 id, EncounterState state)
            {
                if (!InstanceScript::SetBossState(id, state))
                    return false;

                if (id == TYPE_MAGTHERIDON)
                {
                    if (state == IN_PROGRESS)
                    {
                        for (std::set<uint64>::const_iterator itr = _wardersSet.begin(); itr != _wardersSet.end(); ++itr)
                            if (Creature* warder = instance->GetCreature(*itr))
                                if (warder->IsAlive())
                                {
                                    warder->InterruptNonMeleeSpells(true);
                                    warder->SetInCombatWithZone();
                                }
                    }
                    else
                    {
                        for (std::set<uint64>::const_iterator itr = _cubesSet.begin(); itr != _cubesSet.end(); ++itr)
                            if (GameObject* cube = instance->GetGameObject(*itr))
                                cube->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);

                        if (state == NOT_STARTED)
                            SetData(DATA_COLLAPSE, GO_READY);
                    }
                }
                return true;
            }

            void SetData(uint32 type, uint32 data)
            {
                switch (type)
                {
                    case DATA_CHANNELER_COMBAT:
                        if (GetBossState(TYPE_MAGTHERIDON) != IN_PROGRESS)
                            if (Creature* magtheridon = instance->GetCreature(_magtheridonGUID))
                                magtheridon->SetInCombatWithZone();
                        break;
                    case DATA_ACTIVATE_CUBES:
                        for (std::set<uint64>::const_iterator itr = _cubesSet.begin(); itr != _cubesSet.end(); ++itr)
                            if (GameObject* cube = instance->GetGameObject(*itr))
                                cube->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        break;
                    case DATA_COLLAPSE:
                        for (std::set<uint64>::const_iterator itr = _columnSet.begin(); itr != _columnSet.end(); ++itr)
                            if (GameObject* column = instance->GetGameObject(*itr))
                                column->SetGoState(GOState(data));
                        break;
                }
            }

            std::string GetSaveData()
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << "M L " << GetBossSaveData();

                OUT_SAVE_INST_DATA_COMPLETE;
                return saveStream.str();
            }

            void Load(char const* str)
            {
                if (!str)
                {
                    OUT_LOAD_INST_DATA_FAIL;
                    return;
                }

                OUT_LOAD_INST_DATA(str);

                char dataHead1, dataHead2;

                std::istringstream loadStream(str);
                loadStream >> dataHead1 >> dataHead2;

                if (dataHead1 == 'M' && dataHead2 == 'L')
                {
                    for (uint32 i = 0; i < MAX_ENCOUNTER; ++i)
                    {
                        uint32 tmpState;
                        loadStream >> tmpState;
                        if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                            tmpState = NOT_STARTED;
                        SetBossState(i, EncounterState(tmpState));
                    }
                }
                else
                    OUT_LOAD_INST_DATA_FAIL;

                OUT_LOAD_INST_DATA_COMPLETE;
            }

        private:
            uint64 _magtheridonGUID;
            std::set<uint64> _wardersSet;
            std::set<uint64> _cubesSet;
            std::set<uint64> _columnSet;

        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_magtheridons_lair_InstanceMapScript(map);
        }
};

void AddSC_instance_magtheridons_lair()
{
    new instance_magtheridons_lair();
}

