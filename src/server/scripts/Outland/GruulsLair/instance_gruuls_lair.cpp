/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "gruuls_lair.h"

DoorData const doorData[] =
{
    { GO_MAULGAR_DOOR,  DATA_MAULGAR,   DOOR_TYPE_PASSAGE,  BOUNDARY_NONE },
    { GO_GRUUL_DOOR,    DATA_GRUUL,     DOOR_TYPE_ROOM,     BOUNDARY_NONE },
    { 0,                0,              DOOR_TYPE_ROOM,     BOUNDARY_NONE } // END
};

MinionData const minionData[] =
{
    { NPC_MAULGAR,              DATA_MAULGAR },
    { NPC_KROSH_FIREHAND,       DATA_MAULGAR },
    { NPC_OLM_THE_SUMMONER,     DATA_MAULGAR },
    { NPC_KIGGLER_THE_CRAZED,   DATA_MAULGAR },
    { NPC_BLINDEYE_THE_SEER,    DATA_MAULGAR }
};

class instance_gruuls_lair : public InstanceMapScript
{
    public:
        instance_gruuls_lair() : InstanceMapScript("instance_gruuls_lair", 565) { }

        struct instance_gruuls_lair_InstanceMapScript : public InstanceScript
        {
            instance_gruuls_lair_InstanceMapScript(Map* map) : InstanceScript(map)
            {
                SetBossNumber(MAX_ENCOUNTER);
                LoadDoorData(doorData);
                LoadMinionData(minionData);

                _maulgarGUID = 0;
                _addsKilled = 0;
            }

            void OnCreatureCreate(Creature* creature)
            {
                switch (creature->GetEntry())
                {
                    case NPC_MAULGAR:
                        _maulgarGUID = creature->GetGUID();
                        // no break;
                    case NPC_KROSH_FIREHAND:
                    case NPC_OLM_THE_SUMMONER:
                    case NPC_KIGGLER_THE_CRAZED:
                    case NPC_BLINDEYE_THE_SEER:
                        AddMinion(creature, true);
                        break;
                }
            }

            void OnCreatureRemove(Creature* creature)
            {
                switch (creature->GetEntry())
                {
                    case NPC_MAULGAR:
                    case NPC_KROSH_FIREHAND:
                    case NPC_OLM_THE_SUMMONER:
                    case NPC_KIGGLER_THE_CRAZED:
                    case NPC_BLINDEYE_THE_SEER:
                        AddMinion(creature, false);
                        break;
                }
            }

            void OnGameObjectCreate(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_MAULGAR_DOOR:
                    case GO_GRUUL_DOOR:
                        AddDoor(go, true);
                        break;
                }
            }

            void OnGameObjectRemove(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_MAULGAR_DOOR:
                    case GO_GRUUL_DOOR:
                        AddDoor(go, false);
                        break;
                }
            }

            bool SetBossState(uint32 id, EncounterState state)
            {
                if (!InstanceScript::SetBossState(id, state))
                    return false;

                if (id == DATA_MAULGAR && state == NOT_STARTED)
                    _addsKilled = 0;
                return true;
            }

            void SetData(uint32 type, uint32  /*id*/)
            {
                if (type == DATA_ADDS_KILLED)
                    if (Creature* maulgar = instance->GetCreature(_maulgarGUID))
                        maulgar->AI()->DoAction(++_addsKilled);
            }

            uint32 GetData(uint32 type) const
            {
                if (type == DATA_ADDS_KILLED)
                    return _addsKilled;
                return 0;
            }

            std::string GetSaveData()
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << "G L " << GetBossSaveData();

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

                if (dataHead1 == 'G' && dataHead2 == 'L')
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

        protected:
            uint32 _addsKilled;
            uint64 _maulgarGUID;
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_gruuls_lair_InstanceMapScript(map);
        }
};

void AddSC_instance_gruuls_lair()
{
    new instance_gruuls_lair();
}
