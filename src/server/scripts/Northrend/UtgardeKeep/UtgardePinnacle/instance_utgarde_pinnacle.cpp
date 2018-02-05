/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "utgarde_pinnacle.h"

class instance_pinnacle : public InstanceMapScript
{
public:
    instance_pinnacle() : InstanceMapScript("instance_pinnacle", 575) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_pinnacle_InstanceMapScript(pMap);
    }

    struct instance_pinnacle_InstanceMapScript : public InstanceScript
    {
        instance_pinnacle_InstanceMapScript(Map* pMap) : InstanceScript(pMap) {Initialize();};

        uint64 SvalaSorrowgrave;
        uint64 GortokPalehoof;
        uint64 SkadiRuthless;
        uint64 KingYmiron;
        uint64 FrenziedWorgen;
        uint64 RavenousFurbolg;
        uint64 MassiveJormungar;
        uint64 FerociousRhino;
        uint64 Grauf;

        uint64 SvalaMirrorGUID;
        uint64 SkadiRuthlessDoor;
        uint64 YmironDoor;
        uint64 StatisGenerator;
        uint32 FightStatus;
        uint32 Encounters[MAX_ENCOUNTERS];
        uint8 SkadiHits;
        uint8 SkadiInRange;

        bool svalaAchievement;
        bool skadiAchievement;
        bool ymironAchievement;

        void Initialize()
        {
           SvalaSorrowgrave = 0;
           GortokPalehoof   = 0;
           SkadiRuthless    = 0;
           KingYmiron       = 0;
           FrenziedWorgen   = 0;
           RavenousFurbolg  = 0;
           MassiveJormungar = 0;
           FerociousRhino   = 0;
           Grauf            = 0;

           SvalaMirrorGUID  = 0;
           StatisGenerator  = 0;
           SkadiHits        = 0;
           SkadiInRange     = 0;
           SkadiRuthlessDoor= 0;
           YmironDoor       = 0;
           FightStatus      = 0;

           svalaAchievement = false;
           skadiAchievement = false;
           ymironAchievement = false;
           
           for(uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
               Encounters[i] = NOT_STARTED;
        }

        bool IsEncounterInProgress() const
        {
            for(uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                if(Encounters[i] == IN_PROGRESS) 
                    return true;

            return false;
        }
        void OnCreatureCreate(Creature* pCreature)
        {
            switch(pCreature->GetEntry())
            {
                case NPC_SVALA_SORROWGRAVE: SvalaSorrowgrave = pCreature->GetGUID();         break;
                case NPC_GORTOK_PALEHOOF: GortokPalehoof = pCreature->GetGUID();           break;
                case NPC_SKADI_THE_RUTHLESS: SkadiRuthless = pCreature->GetGUID();            break;
                case NPC_KING_YMIRON: KingYmiron = pCreature->GetGUID();               break;
                case NPC_FRENZIED_WORGEN: FrenziedWorgen = pCreature->GetGUID();           break;
                case NPC_RAVENOUS_FURBOLG: RavenousFurbolg = pCreature->GetGUID();          break;
                case NPC_MASSIVE_JORMUNGAR: MassiveJormungar = pCreature->GetGUID();         break;
                case NPC_FEROCIOUS_RHINO: FerociousRhino = pCreature->GetGUID();           break;
                case NPC_GARUF: Grauf = pCreature->GetGUID();                    break;
            }
        }

        void OnGameObjectCreate(GameObject* pGo)
        {
            switch(pGo->GetEntry())
            {
                case GO_SKADI_THE_RUTHLESS_DOOR:
                    SkadiRuthlessDoor = pGo->GetGUID();
                    if (Encounters[DATA_SKADI_THE_RUTHLESS] == DONE)
                        HandleGameObject(0,true,pGo);
                    break;
                case GO_KING_YMIRON_DOOR:
                    YmironDoor = pGo->GetGUID();
                    if (Encounters[DATA_KING_YMIRON] == DONE) 
                        HandleGameObject(0,true,pGo);
                    break;
                case GO_GORK_PALEHOOF_SPHERE: 
                    StatisGenerator = pGo->GetGUID();
                    break;
                case GO_SVALA_MIRROR:
                    SvalaMirrorGUID = pGo->GetGUID();
                    break;
            }
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/)
        {
            switch(criteria_id)
            {
                case 7322: // The Incredible Hulk (2043)
                    return svalaAchievement;
                case 7595: // My Girl Loves to Skadi All the Time (2156)
                    return skadiAchievement;
                case 7598: // King's Bane (2157)
                    return ymironAchievement;
            }
            return false;
        }

        void SetData(uint32 type, uint32 data)
        {
            switch(type)
            {
                case DATA_SVALA_SORROWGRAVE:
                case DATA_GORTOK_PALEHOOF:
                    Encounters[type] = data;
                    break;
                case DATA_SKADI_THE_RUTHLESS:
                    if (data == DONE)
                    {
                        HandleGameObject(SkadiRuthlessDoor,true);
                        // Make ymiron attackable
                        if (Creature *cr = instance->GetCreature(KingYmiron))
                            cr->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    }
                    Encounters[type] = data;
                    break;
                case DATA_KING_YMIRON:
                    if (data == DONE)
                        HandleGameObject(YmironDoor,true);
                    Encounters[type] = data;
                    break;
                case SKADI_HITS:
                    SkadiHits = data;
                    break;
                case SKADI_IN_RANGE:
                    SkadiInRange = data;
                    break;
                case DATA_SVALA_ACHIEVEMENT:
                    svalaAchievement = (bool)data;
                    return;
                case DATA_SKADI_ACHIEVEMENT:
                    skadiAchievement = (bool)data;
                    return;
                case DATA_YMIRON_ACHIEVEMENT:
                    ymironAchievement = (bool)data;
                    return;

            }
            OUT_SAVE_INST_DATA;

            SaveToDB();
            OUT_SAVE_INST_DATA_COMPLETE;
        }

        std::string GetSaveData()
        {
            std::ostringstream saveStream;
            saveStream << "U P " << Encounters[0] << ' ' << Encounters[1] << ' ' << Encounters[2] << ' ' << Encounters[3];
            return saveStream.str();
        }

        void Load(const char* in)
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;
            uint16 data0, data1, data2, data3;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0 >> data1 >> data2 >> data3;

            if (dataHead1 == 'U' && dataHead2 == 'P')
            {
                Encounters[0] = data0;
                Encounters[1] = data1;
                Encounters[2] = data2;
                Encounters[3] = data3;

                for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                    if (Encounters[i] == IN_PROGRESS)
                        Encounters[i] = NOT_STARTED;

            } else OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        uint32 GetData(uint32 type) const
        {
            switch(type)
            {
                case DATA_SVALA_SORROWGRAVE:        return Encounters[0];
                case DATA_GORTOK_PALEHOOF:          return Encounters[1];
                case DATA_SKADI_THE_RUTHLESS:       return Encounters[2];
                case DATA_KING_YMIRON:              return Encounters[3];
                case SKADI_HITS:                    return SkadiHits;
                case SKADI_IN_RANGE:                return SkadiInRange;
            }
            return 0;
        }

        uint64 GetData64(uint32 identifier) const
        {
            switch(identifier)
            {
                case DATA_SVALA_SORROWGRAVE:          return SvalaSorrowgrave;
                case DATA_GORTOK_PALEHOOF:            return GortokPalehoof;
                case DATA_SKADI_THE_RUTHLESS:         return SkadiRuthless;
                case DATA_KING_YMIRON:                return KingYmiron;
                case DATA_NPC_FRENZIED_WORGEN:        return FrenziedWorgen;
                case DATA_NPC_RAVENOUS_FURBOLG:       return RavenousFurbolg;
                case DATA_NPC_MASSIVE_JORMUNGAR:      return MassiveJormungar;
                case DATA_NPC_FEROCIOUS_RHINO:        return FerociousRhino;
                case YMIRON_DOOR:                     return YmironDoor;
                case STATIS_GENERATOR:                return StatisGenerator;
                case SKADI_DOOR:                      return SkadiRuthlessDoor;
                case DATA_GRAUF:                      return Grauf;
                case GO_SVALA_MIRROR:                 return SvalaMirrorGUID;
            }

            return 0;
        }
    };
};

void AddSC_instance_utgarde_pinnacle()
{
    new instance_pinnacle();
}