/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "CreatureAIImpl.h"
#include "obsidian_sanctum.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

class instance_obsidian_sanctum : public InstanceMapScript
{
public:
    instance_obsidian_sanctum() : InstanceMapScript("instance_obsidian_sanctum", 615) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_obsidian_sanctum_InstanceMapScript(pMap);
    }

    struct instance_obsidian_sanctum_InstanceMapScript : public InstanceScript
    {
        instance_obsidian_sanctum_InstanceMapScript(Map* pMap) : InstanceScript(pMap), portalCount(0)
        {
            SetBossNumber(MAX_ENCOUNTERS);
        }

        bool IsEncounterInProgress() const override
        {
            for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
            {
                if (GetBossState(i) == IN_PROGRESS)
                    return true;
            }

            return false;
        }

        void OnCreatureCreate(Creature* pCreature) override
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

        ObjectGuid GetGuidData(uint32 uiData) const override
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

            return ObjectGuid::Empty;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const* source, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch(criteria_id)
            {
                // Gonna Go When the Volcano Blows (10 player) (2047)
                case 7326:
                // Gonna Go When the Volcano Blows (25 player) (2048)
                case 7327:
                {
                    Creature const* sartharion = instance->GetCreature(m_uiSartharionGUID);
                    return sartharion && !sartharion->AI()->GetData(source->GetGUID().GetCounter());
                }
                // Less Is More (10 player) (624)
                case 7189:
                case 7190:
                case 7191:
                case 522:
                {
                    return instance->GetPlayersCountExceptGMs() < 9;
                }
                // Less Is More (25 player) (1877)
                case 7185:
                case 7186:
                case 7187:
                case 7188:
                {
                    return instance->GetPlayersCountExceptGMs() < 21;
                }
                // Twilight Assist (10 player) (2049)
                case 7328:
                // Twilight Assist (25 player) (2052)
                case 7331:
                {
                    Creature const* sartharion = instance->GetCreature(m_uiSartharionGUID);
                    return sartharion && sartharion->AI()->GetData(DATA_ACHIEVEMENT_DRAGONS_COUNT) >= 1;
                }
                // Twilight Duo (10 player) (2050)
                case 7329:
                // Twilight Duo (25 player) (2053)
                case 7332:
                {
                    Creature const* sartharion = instance->GetCreature(m_uiSartharionGUID);
                    return sartharion && sartharion->AI()->GetData(DATA_ACHIEVEMENT_DRAGONS_COUNT) >= 2;
                }
                // Twilight Zone (10 player) (2051)
                case 7330:
                // Twilight Zone (25 player) (2054)
                case 7333:
                {
                    Creature const* sartharion = instance->GetCreature(m_uiSartharionGUID);
                    return sartharion && sartharion->AI()->GetData(DATA_ACHIEVEMENT_DRAGONS_COUNT) >= 3;
                }
            }

            return false;
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (InstanceScript::SetBossState(type, state))
            {
                return false;
            }

            if (state == DONE)
            {
                SaveToDB();
            }
            return true;
        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_ADD_PORTAL:
                {
                    if (!m_uiPortalGUID)
                    {
                        if (Creature* sartharion = instance->GetCreature(m_uiSartharionGUID))
                        {
                            if (GameObject* portal = sartharion->SummonGameObject(GO_TWILIGHT_PORTAL, 3247.29f, 529.804f, 58.9595f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0))
                            {
                                sartharion->RemoveGameObject(portal, false);
                                m_uiPortalGUID = portal->GetGUID();
                            }
                        }

                        portalCount = 0;
                    }

                    ++portalCount;
                    break;
                }
                case ACTION_CLEAR_PORTAL:
                {
                    --portalCount;
                    if (!portalCount)
                    {
                        if (GameObject* go = instance->GetGameObject(m_uiPortalGUID))
                        {
                            go->Delete();
                        }

                        DoRemoveAurasDueToSpellOnPlayers(SPELL_TWILIGHT_SHIFT);
                        m_uiPortalGUID.Clear();
                    }
                    break;
                }
            }
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "O S " << GetBossSaveData();

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* strIn) override
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
                    uint32 temp;
                    loadStream >> temp;
                    if (temp == IN_PROGRESS)
                        temp = NOT_STARTED;

                    SetBossState(i, static_cast<EncounterState>(temp));
                }
            }

            OUT_LOAD_INST_DATA_COMPLETE;
        }

    private:
        ObjectGuid m_uiSartharionGUID;
        ObjectGuid m_uiTenebronGUID;
        ObjectGuid m_uiShadronGUID;
        ObjectGuid m_uiVesperonGUID;
        ObjectGuid m_uiPortalGUID;
        uint8 portalCount;
    };
};

void AddSC_instance_obsidian_sanctum()
{
    new instance_obsidian_sanctum();
}
