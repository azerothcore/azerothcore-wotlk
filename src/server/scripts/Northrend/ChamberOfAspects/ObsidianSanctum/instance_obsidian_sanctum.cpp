/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "obsidian_sanctum.h"
#include "Player.h"

class instance_obsidian_sanctum : public InstanceMapScript
{
public:
    instance_obsidian_sanctum() : InstanceMapScript("instance_obsidian_sanctum", 615) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_obsidian_sanctum_InstanceMapScript(pMap);
    }

    struct instance_obsidian_sanctum_InstanceMapScript : public InstanceScript
    {
        instance_obsidian_sanctum_InstanceMapScript(Map* pMap) : InstanceScript(pMap) {}

        uint64 m_uiSartharionGUID;
        uint64 m_uiTenebronGUID;
        uint64 m_uiShadronGUID;
        uint64 m_uiVesperonGUID;
        uint32 Encounters[MAX_ENCOUNTERS];
        uint64 m_uiPortalGUID;
        uint8 portalCount;

        void Initialize()
        {
            m_uiSartharionGUID = 0;
            m_uiTenebronGUID   = 0;
            m_uiShadronGUID    = 0;
            m_uiVesperonGUID   = 0;
            m_uiPortalGUID     = 0;
            portalCount        = 0;
            memset(&Encounters, 0, sizeof(Encounters));
        };

        bool IsEncounterInProgress() const
        {
            if (Encounters[BOSS_SARTHARION_EVENT] == IN_PROGRESS)
                return true;

            return false;
        }

        void OnCreatureCreate(Creature* pCreature)
        {
            switch(pCreature->GetEntry())
            {
                case NPC_SARTHARION:
                    m_uiSartharionGUID = pCreature->GetGUID();
                    break;
                case NPC_TENEBRON:
                    m_uiTenebronGUID = pCreature->GetGUID();
                    break;
                case NPC_SHADRON:
                    m_uiShadronGUID = pCreature->GetGUID();
                    break;
                case NPC_VESPERON:
                    m_uiVesperonGUID = pCreature->GetGUID();
                    break;
            }
        }

        uint32 GetData(uint32 id) const
        {
            switch (id)
            {
                case BOSS_SARTHARION_EVENT:
                case BOSS_TENEBRON_EVENT:
                case BOSS_SHADRON_EVENT:
                case BOSS_VESPERON_EVENT:
                    return Encounters[id];
            }

            return 0;
        }

        uint64 GetData64(uint32 uiData) const
        {
            switch(uiData)
            {
                case DATA_SARTHARION:
                    return m_uiSartharionGUID;
                case DATA_TENEBRON:
                    return m_uiTenebronGUID;
                case DATA_SHADRON:
                    return m_uiShadronGUID;
                case DATA_VESPERON:
                    return m_uiVesperonGUID;
            }
            return 0;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const* source, Unit const*  /*target*/, uint32  /*miscvalue1*/)
        {
            switch(criteria_id)
            {
                // Gonna Go When the Volcano Blows (10 player) (2047)
                case 7326:
                // Gonna Go When the Volcano Blows (25 player) (2048)
                case 7327:
                    if (Creature* cr = instance->GetCreature(m_uiSartharionGUID))
                        if (!cr->AI()->GetData(source->GetGUIDLow()))
                            return true;
                    break;
                // Less Is More (10 player) (624)
                case 7189:
                case 7190:
                case 7191:
                case 522:
                    if (instance->GetPlayersCountExceptGMs() < 9)
                        return true;
                    break;
                // Less Is More (25 player) (1877)
                case 7185:
                case 7186:
                case 7187:
                case 7188:
                    if (instance->GetPlayersCountExceptGMs() < 21)
                        return true;
                    break;
                // Twilight Assist (10 player) (2049)
                case 7328:
                // Twilight Assist (25 player) (2052)
                case 7331:
                    if (Creature* cr = instance->GetCreature(m_uiSartharionGUID))
                        if (cr->AI()->GetData(DATA_ACHIEVEMENT_DRAGONS_COUNT) >= 1)
                            return true;
                    break;
                // Twilight Duo (10 player) (2050)
                case 7329:
                // Twilight Duo (25 player) (2053)
                case 7332:
                    if (Creature* cr = instance->GetCreature(m_uiSartharionGUID))
                        if (cr->AI()->GetData(DATA_ACHIEVEMENT_DRAGONS_COUNT) >= 2)
                            return true;
                    break;
                // Twilight Zone (10 player) (2051)
                case 7330:
                // Twilight Zone (25 player) (2054)
                case 7333:
                    if (Creature* cr = instance->GetCreature(m_uiSartharionGUID))
                        if (cr->AI()->GetData(DATA_ACHIEVEMENT_DRAGONS_COUNT) >= 3)
                            return true;
                    break;
                
            }
            return false;
        }

        void SetData(uint32 type, uint32 data)
        {
            switch(type)
            {
                case BOSS_SARTHARION_EVENT:
                case BOSS_TENEBRON_EVENT:
                case BOSS_SHADRON_EVENT:
                case BOSS_VESPERON_EVENT:
                    Encounters[type] = data;
                    break;
                case DATA_ADD_PORTAL:
                    if (!m_uiPortalGUID)
                    {
                        if (Creature* cr = instance->GetCreature(m_uiSartharionGUID))
                            if (GameObject* go = cr->SummonGameObject(GO_TWILIGHT_PORTAL, 3247.29f, 529.804f, 58.9595f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0))
                            {
                                cr->RemoveGameObject(go, false);
                                m_uiPortalGUID = go->GetGUID();
                            }

                        portalCount = 0;
                    }

                    portalCount++;
                    break;
                case DATA_CLEAR_PORTAL:
                    portalCount--;
                    if (!portalCount || data == 2)
                    {
                        if (GameObject* go = instance->GetGameObject(m_uiPortalGUID))
                            go->Delete();

                        DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_SHIFT);
                        m_uiPortalGUID = 0;
                    }
                    break;
            }

            if (data == DONE)
                SaveToDB();
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "O S " << Encounters[0] << ' ' << Encounters[1] << ' ' << Encounters[2] << ' ' << Encounters[3];

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

            char dataHead1, dataHead2;

            std::istringstream loadStream(strIn);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'O' && dataHead2 == 'S')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                {
                    loadStream >> Encounters[i];
                    if (Encounters[i] == IN_PROGRESS)
                        Encounters[i] = NOT_STARTED;
                }
            }

            OUT_LOAD_INST_DATA_COMPLETE;
        }
    };
};

void AddSC_instance_obsidian_sanctum()
{
    new instance_obsidian_sanctum();
}
