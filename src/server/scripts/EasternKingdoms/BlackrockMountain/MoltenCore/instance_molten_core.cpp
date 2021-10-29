/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "InstanceScript.h"
#include "TemporarySummon.h"
#include "molten_core.h"

Position const MajordomoSummonPos = {759.542f, -1173.43f, -118.974f, 3.3048f};

MinionData const minionData[] =
{
    { NPC_FIRESWORN, DATA_GARR },
    { NPC_FLAMEWALKER, DATA_GEHENNAS },
    { 0, 0 } // END
};

class instance_molten_core : public InstanceMapScript
{
public:
    instance_molten_core() : InstanceMapScript(MCScriptName, 409) {}

    struct instance_molten_core_InstanceMapScript : public InstanceScript
    {
        instance_molten_core_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(MAX_ENCOUNTER);
            LoadMinionData(minionData);
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
                    _golemaggGUID = creature->GetGUID();
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
                case NPC_FIRESWORN:
                {
                    AddMinion(creature, true);
                    _garrMinionsGUIDs.insert(creature->GetGUID());
                    break;
                }
                case NPC_FLAMEWALKER:
                {
                    AddMinion(creature, true);
                    break;
                }
            }
        }

        void OnCreatureRemove(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_FIRESWORN:
                {
                    AddMinion(creature, false);
                    _garrMinionsGUIDs.erase(creature->GetGUID());
                    break;
                }
                case NPC_FLAMEWALKER:
                {
                    AddMinion(creature, false);
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
                case GO_CIRCLE_GEDDON:
                {
                    if (GetBossState(DATA_GEDDON) == DONE)
                    {
                        go->SetLootMode(GO_JUST_DEACTIVATED);
                    }
                    else
                    {
                        _circlesGUIDs[DATA_GEDDON] = go->GetGUID();
                    }
                    break;
                }
                case GO_CIRCLE_GARR:
                {
                    if (GetBossState(DATA_GARR) == DONE)
                    {
                        go->SetLootMode(GO_JUST_DEACTIVATED);
                    }
                    else
                    {
                        _circlesGUIDs[DATA_GARR] = go->GetGUID();
                    }
                    break;
                }
                case GO_CIRCLE_GEHENNAS:
                {
                    if (GetBossState(DATA_GEHENNAS) == DONE)
                    {
                        go->SetLootMode(GO_JUST_DEACTIVATED);
                    }
                    else
                    {
                        _circlesGUIDs[DATA_GEHENNAS] = go->GetGUID();
                    }
                    break;
                }
                case GO_CIRCLE_GOLEMAGG:
                {
                    if (GetBossState(DATA_GOLEMAGG) == DONE)
                    {
                        go->SetLootMode(GO_JUST_DEACTIVATED);
                    }
                    else
                    {
                        _circlesGUIDs[DATA_GOLEMAGG] = go->GetGUID();
                    }
                    break;
                }
                case GO_CIRCLE_MAGMADAR:
                {
                    if (GetBossState(DATA_MAGMADAR) == DONE)
                    {
                        go->SetLootMode(GO_JUST_DEACTIVATED);
                    }
                    else
                    {
                        _circlesGUIDs[DATA_MAGMADAR] = go->GetGUID();
                    }
                    break;
                }
                case GO_CIRCLE_SHAZZRAH:
                {
                    if (GetBossState(DATA_SHAZZRAH) == DONE)
                    {
                        go->SetLootMode(GO_JUST_DEACTIVATED);
                    }
                    else
                    {
                        _circlesGUIDs[DATA_SHAZZRAH] = go->GetGUID();
                    }
                    break;
                }
                case GO_CIRCLE_SULFURON:
                {
                    if (GetBossState(DATA_SULFURON) == DONE)
                    {
                        go->SetLootMode(GO_JUST_DEACTIVATED);
                    }
                    else
                    {
                        _circlesGUIDs[DATA_SULFURON] = go->GetGUID();
                    }
                    break;
                }
            }
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_GOLEMAGG:
                    return _golemaggGUID;
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

            if (bossId == DATA_GARR && state == DONE)
            {
                if (!_garrMinionsGUIDs.empty())
                {
                    for (ObjectGuid const& guid : _garrMinionsGUIDs)
                    {
                        if (Creature* minion = instance->GetCreature(guid))
                        {
                            minion->DespawnOrUnsummon();
                        }
                    }

                    _garrMinionsGUIDs.clear();
                }
            }

            if (bossId == DATA_MAJORDOMO_EXECUTUS && state == DONE)
            {
                DoRespawnGameObject(_cacheOfTheFirelordGUID, 7 * DAY);
            }

            // Perform needed checks for Majordomu
            if (bossId < DATA_MAJORDOMO_EXECUTUS && state == DONE)
            {
                if (GameObject* circle = instance->GetGameObject(_circlesGUIDs[bossId]))
                {
                    circle->SetLootMode(GO_JUST_DEACTIVATED);
                    _circlesGUIDs[bossId].Clear();
                }

                if (CheckMajordomoExecutus())
                {
                    SummonMajordomoExecutus();
                }
            }

            return true;
        }

        void SummonMajordomoExecutus()
        {
            if (instance->GetCreature(_majordomoExecutusGUID))
            {
                return;
            }

            instance->SummonCreature(NPC_MAJORDOMO_EXECUTUS, GetBossState(DATA_MAJORDOMO_EXECUTUS) != DONE ? MajordomoSummonPos : RagnarosTelePos);
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
        std::unordered_map<uint32/*bossid*/, ObjectGuid/*circleGUID*/> _circlesGUIDs;
        ObjectGuid _golemaggGUID;
        ObjectGuid _majordomoExecutusGUID;
        ObjectGuid _cacheOfTheFirelordGUID;
        ObjectGuid _garrGUID;

        GuidSet _garrMinionsGUIDs;
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
