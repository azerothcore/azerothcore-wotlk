/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "InstanceScript.h"
#include "magtheridons_lair.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

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

        void Initialize() override
        {
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
                    AddMinion(creature, true);
                    break;
                case NPC_HELLFIRE_WARDER:
                    _wardersSet.insert(creature->GetGUID());
                    break;
            }
        }

        void OnCreatureRemove(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_HELLFIRE_CHANNELER:
                    AddMinion(creature, false);
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
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

        void OnGameObjectRemove(GameObject* go) override
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

        bool SetBossState(uint32 id, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(id, state))
                return false;

            if (id == TYPE_MAGTHERIDON)
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
                            cube->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);

                    if (state == NOT_STARTED)
                        SetData(DATA_COLLAPSE, GO_READY);
                }
            }
            return true;
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_CHANNELER_COMBAT:
                    if (GetBossState(TYPE_MAGTHERIDON) != IN_PROGRESS)
                        if (Creature* magtheridon = instance->GetCreature(_magtheridonGUID))
                            magtheridon->SetInCombatWithZone();
                    break;
                case DATA_ACTIVATE_CUBES:
                    for (ObjectGuid const& guid : _cubesSet)
                        if (GameObject* cube = instance->GetGameObject(guid))
                            cube->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    break;
                case DATA_COLLAPSE:
                    for (ObjectGuid const& guid : _columnSet)
                        if (GameObject* column = instance->GetGameObject(guid))
                            column->SetGoState(GOState(data));
                    break;
            }
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "M L " << GetBossSaveData();

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(char const* str) override
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
        ObjectGuid _magtheridonGUID;
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
