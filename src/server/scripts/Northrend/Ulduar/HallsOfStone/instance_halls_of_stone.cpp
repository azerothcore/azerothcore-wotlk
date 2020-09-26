/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "halls_of_stone.h"

class instance_halls_of_stone : public InstanceMapScript
{
public:
    instance_halls_of_stone() : InstanceMapScript("instance_halls_of_stone", 599) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_halls_of_stone_InstanceMapScript(pMap);
    }

    struct instance_halls_of_stone_InstanceMapScript : public InstanceScript
    {
        instance_halls_of_stone_InstanceMapScript(Map* map) : InstanceScript(map){ Initialize(); }

        uint32 Encounter[MAX_ENCOUNTER];

        uint64 goKaddrakGUID;
        uint64 goMarnakGUID;
        uint64 goAbedneumGUID;
        uint64 goTribunalConsoleGUID;
        uint64 goSkyRoomFloorGUID;
        uint64 goSjonnirConsoleGUID;
        uint64 goSjonnirDoorGUID;
        uint64 goLeftPipeGUID;
        uint64 goRightPipeGUID;
        uint64 goTribunalDoorGUID;

        uint64 SjonnirGUID;
        uint64 BrannGUID;

        bool brannAchievement;
        bool sjonnirAchievement;
        bool isMaidenOfGriefDead;
        bool isKrystalusDead;

        void Initialize()
        {
            memset(&Encounter, 0, sizeof(Encounter));

            goKaddrakGUID = 0;
            goMarnakGUID = 0;
            goAbedneumGUID = 0;
            goTribunalConsoleGUID = 0;
            goSkyRoomFloorGUID = 0;
            goSjonnirConsoleGUID = 0;
            goSjonnirDoorGUID = 0;
            goLeftPipeGUID = 0;
            goRightPipeGUID = 0;
            goTribunalDoorGUID = 0;

            SjonnirGUID = 0;
            BrannGUID = 0;

            brannAchievement = false;
            sjonnirAchievement = false;
            isMaidenOfGriefDead = false;
            isKrystalusDead = false;
        }

        bool IsEncounterInProgress() const
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
            {
                if (Encounter[i] == IN_PROGRESS)
                    return true;
            }
            return false;
        }

        void OnGameObjectCreate(GameObject *go)
        {
            switch(go->GetEntry())
            {
                case GO_KADDRAK: 
                    goKaddrakGUID = go->GetGUID();
                    break;
                case GO_ABEDNEUM: 
                    goAbedneumGUID = go->GetGUID();
                    if (Encounter[BOSS_TRIBUNAL_OF_AGES] == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_MARNAK: 
                    goMarnakGUID = go->GetGUID(); 
                    break;
                case GO_TRIBUNAL_CONSOLE: 
                    goTribunalConsoleGUID = go->GetGUID(); 
                    break;
                case GO_TRIBUNAL_ACCESS_DOOR:
                    goTribunalDoorGUID = go->GetGUID();
                    go->SetGoState(GO_STATE_READY);
                    break;
                case GO_SKY_FLOOR: 
                    goSkyRoomFloorGUID = go->GetGUID();
                    if (Encounter[BOSS_TRIBUNAL_OF_AGES] == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_SJONNIR_CONSOLE: 
                    goSjonnirConsoleGUID = go->GetGUID();
                    break;
                case GO_SJONNIR_DOOR: 
                    goSjonnirDoorGUID = go->GetGUID();
                    if (Encounter[BOSS_TRIBUNAL_OF_AGES] == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_LEFT_PIPE:
                    goLeftPipeGUID = go->GetGUID();
                    break;
                case GO_RIGHT_PIPE:
                    goRightPipeGUID = go->GetGUID();
                    break;
            }
        }


        void OnCreatureCreate(Creature *creature)
        {
            switch(creature->GetEntry())
            {
            case NPC_SJONNIR:   
                SjonnirGUID = creature->GetGUID();
                break;
            case NPC_BRANN:
                BrannGUID = creature->GetGUID();
                break;
            }
        }

        uint64 GetData64(uint32 id) const
        {
            switch(id)
            {
                case GO_TRIBUNAL_CONSOLE:       return goTribunalConsoleGUID;
                case GO_TRIBUNAL_ACCESS_DOOR:   return goTribunalDoorGUID;
                case GO_SJONNIR_CONSOLE:        return goSjonnirConsoleGUID;
                case GO_SJONNIR_DOOR:           return goSjonnirDoorGUID;
                case GO_LEFT_PIPE:              return goLeftPipeGUID;
                case GO_RIGHT_PIPE:             return goRightPipeGUID;
                case GO_KADDRAK:                return goKaddrakGUID;
                case GO_MARNAK:                 return goMarnakGUID;
                case GO_ABEDNEUM:               return goAbedneumGUID;

                case NPC_SJONNIR:               return SjonnirGUID;
                case NPC_BRANN:                 return BrannGUID;
            }
            return 0;
        }

        uint32 GetData(uint32 id) const
        {
            switch(id)
            {
                case BOSS_KRYSTALLUS:
                case BOSS_MAIDEN_OF_GRIEF:
                case BOSS_TRIBUNAL_OF_AGES:
                case BOSS_SJONNIR:
                case BRANN_BRONZEBEARD:
                    return Encounter[id];
            }
            return 0;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/)
        {
            switch(criteria_id)
            {
                case 7590: // Brann Spankin' New (2154)
                    return brannAchievement;
                case 7593: // Abuse the Ooze (2155)
                    return sjonnirAchievement;
            }
            return false;
        }

        void SetData(uint32 type, uint32 data)
        {
            if (type < MAX_ENCOUNTER)
                Encounter[type] = data;

            if (data == DONE)
            {
                isMaidenOfGriefDead = (type == BOSS_MAIDEN_OF_GRIEF ? true : isMaidenOfGriefDead);
                isKrystalusDead = (type == BOSS_KRYSTALLUS ? true : isKrystalusDead);
            }

            if (isMaidenOfGriefDead && isKrystalusDead)
                if (GameObject* tribunalDoor = instance->GetGameObject(goTribunalDoorGUID))
                    tribunalDoor->SetGoState(GO_STATE_ACTIVE);

            if (type == BOSS_TRIBUNAL_OF_AGES && data == DONE)
            {
                if (GameObject* pA = instance->GetGameObject(goAbedneumGUID))
                    pA->SetGoState(GO_STATE_ACTIVE);
                if (GameObject* pF = instance->GetGameObject(goSkyRoomFloorGUID))
                    pF->SetGoState(GO_STATE_ACTIVE);

                // Make sjonnir attackable
                if (Creature *cr = instance->GetCreature(SjonnirGUID))
                    cr->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            }
            if (type == BOSS_TRIBUNAL_OF_AGES && data == NOT_STARTED)
            {
                if (GameObject* pA = instance->GetGameObject(goAbedneumGUID))
                    pA->SetGoState(GO_STATE_READY);
                if (GameObject* pF = instance->GetGameObject(goSkyRoomFloorGUID))
                    pF->SetGoState(GO_STATE_READY);
            }

            if (type == DATA_BRANN_ACHIEVEMENT)
            {
                brannAchievement = (bool)data;
                return;
            }
            if (type == DATA_SJONNIR_ACHIEVEMENT)
            {
                sjonnirAchievement = (bool)data;
                return;
            }
            
            if (data == DONE)
                SaveToDB();
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "H O S " << Encounter[0] << ' ' << Encounter[1] << ' ' << Encounter[2] << ' ' << Encounter[3] << ' ' << Encounter[4];

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* strIn)
        {
            if (!strIn)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(strIn);

            char dataHead1, dataHead2, dataHead3;

            std::istringstream loadStream(strIn);
            loadStream >> dataHead1 >> dataHead2 >> dataHead3;

            if (dataHead1 == 'H' && dataHead2 == 'O' && dataHead3 == 'S')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                {
                    loadStream >> Encounter[i];
                    if( Encounter[i] == IN_PROGRESS )
                        Encounter[i] = NOT_STARTED;
                }
            }
            OUT_LOAD_INST_DATA_COMPLETE;
        }
    };
};

void AddSC_instance_halls_of_stone()
{
    new instance_halls_of_stone();
}
