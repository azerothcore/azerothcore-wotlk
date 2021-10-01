/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Instance_Molten_Core
SD%Complete: 0
SDComment: Place Holder
SDCategory: Molten Core
EndScriptData */

#include "InstanceScript.h"
#include "molten_core.h"
#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "molten_core.h"
#include "InstanceScript.h"
#include "TemporarySummon.h"

Position const MajordomoSummonPos = {759.542f, -1173.43f, -118.974f, 3.3048f};
class instance_molten_core : public InstanceMapScript
{
public:
    instance_molten_core() : InstanceMapScript(MCScriptName, 409) { }

    struct instance_molten_core_InstanceMapScript : public InstanceScript
    {
        instance_molten_core_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(MAX_ENCOUNTER);
        }

        void OnPlayerEnter(Player* /*player*/) override
        {
            if (CheckMajordomoExecutus())
            {
                SummonMajordomoExecutus();
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_GOLEMAGG_THE_INCINERATOR:
                {
                    _golemaggTheIncineratorGUID = creature->GetGUID();
                    break;
                }
                case NPC_MAJORDOMO_EXECUTUS:
                {
                    _majordomoExecutusGUID = creature->GetGUID();
                    break;
                }
                case NPC_GARR:
                {
                    _garrGUID = creature->GetGUID();
                    break;
                }
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_CACHE_OF_THE_FIRELORD:
                {
                    _cacheOfTheFirelordGUID = go->GetGUID();
                    break;
                }
                case GO_CIRCLE_BARON:
                {
                    _circlesGUIDs[5] = go->GetGUID();
                    break;
                }
                case GO_CIRCLE_GARR:
                {
                    _circlesGUIDs[3] = go->GetGUID();
                    break;
                }
                case GO_CIRCLE_GEHENNAS:
                {
                    _circlesGUIDs[2] = go->GetGUID();
                    break;
                }
                case GO_CIRCLE_GOLEMAGG:
                {
                    _circlesGUIDs[7] = go->GetGUID();
                    break;
                }
                case GO_CIRCLE_MAGMADAR:
                {
                    _circlesGUIDs[1] = go->GetGUID();
                    break;
                }
                case GO_CIRCLE_SHAZZRAH:
                {
                    _circlesGUIDs[4] = go->GetGUID();
                    break;
                }
                case GO_CIRCLE_SULFURON:
                {
                    _circlesGUIDs[6] = go->GetGUID();
                    break;
                }
            }
        }


        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_GOLEMAGG_THE_INCINERATOR:
                    return _golemaggTheIncineratorGUID;
                case DATA_MAJORDOMO_EXECUTUS:
                    return _majordomoExecutusGUID;
                case DATA_GARR:
                    return _garrGUID;
            }

            return ObjectGuid::Empty;
        }


        bool SetBossState(uint32 bossId, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(bossId, state))
            {
                return false;
            }

            if (state == DONE && bossId < DATA_MAJORDOMO_EXECUTUS && CheckMajordomoExecutus())
            {
                SummonMajordomoExecutus();
            }

            if (bossId == DATA_MAJORDOMO_EXECUTUS && state == DONE)
            {
                DoRespawnGameObject(_cacheOfTheFirelordGUID, 7 * DAY);
            }

            if (canSaveBossState)
            {
                SaveToDB();
            }
            return true;
        }

        void SummonMajordomoExecutus()
        {
            if (instance->GetCreature(_majordomoExecutusGUID))
            {
                return;
            }

            if (GetBossState(DATA_MAJORDOMO_EXECUTUS) != DONE)
            {
                instance->SummonCreature(NPC_MAJORDOMO_EXECUTUS, MajordomoSummonPos);
            }
            else if (TempSummon* summon = instance->SummonCreature(NPC_MAJORDOMO_EXECUTUS, RagnarosTelePos))
            {
                summon->AI()->DoAction(ACTION_START_RAGNAROS_ALT);
            }
        }

        bool CheckMajordomoExecutus() const
        {
            if (GetBossState(DATA_RAGNAROS) == DONE)
            {
                return false;
            }

            for (uint8 i = 0; i < DATA_MAJORDOMO_EXECUTUS; ++i)
            {
                if (GetBossState(i) != DONE)
                {
                    return false;
                }
            }

            return true;
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "M C " << GetBossSaveData();

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(char const* data) override
        {
            if (!data)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(data);

            char dataHead1, dataHead2;

            std::istringstream loadStream(data);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'M' && dataHead2 == 'C')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > TO_BE_DECIDED)
                    {
                        tmpState = NOT_STARTED;
                    }

                    SetBossState(i, static_cast<EncounterState>(tmpState));
                }

                if (CheckMajordomoExecutus())
                {
                    SummonMajordomoExecutus();
                }
            }
            else
            {
                OUT_LOAD_INST_DATA_FAIL;
            }

            OUT_LOAD_INST_DATA_COMPLETE;
        }

    private:
        std::unordered_map<uint8, ObjectGuid> _circlesGUIDs;
        ObjectGuid _golemaggTheIncineratorGUID;
        ObjectGuid _majordomoExecutusGUID;
        ObjectGuid _cacheOfTheFirelordGUID;
        ObjectGuid _garrGUID;
        bool canSaveBossState;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_molten_core_InstanceMapScript(map);
    }
};

void AddSC_instance_molten_core()
{
    new instance_molten_core();
}
