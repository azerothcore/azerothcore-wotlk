/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Instance_Molten_Core
SD%Complete: 0
SDComment: Place Holder
SDCategory: Molten Core
EndScriptData */

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "CreatureAI.h"
#include "molten_core.h"
#include "TemporarySummon.h"

Position const SummonPositions[10] =
{
    {759.542f, -1173.43f, -118.974f, 3.3048f},
    {761.652f, -1164.30f, -119.533f, 3.3919f},
    {747.323f, -1149.24f, -120.060f, 3.6629f},
    {766.734f, -1183.16f, -119.292f, 2.9889f},
    {757.364f, -1198.31f, -118.652f, 2.3095f},
    {752.349f, -1159.19f, -119.261f, 3.6032f},
    {738.015f, -1152.22f, -119.512f, 4.0792f},
    {757.246f, -1189.79f, -118.633f, 2.5333f},
    {745.916f, -1199.35f, -118.119f, 1.8932f},
    {838.510f, -829.840f, -232.000f, 2.00000f},
};

class instance_molten_core : public InstanceMapScript
{
    public:
        instance_molten_core() : InstanceMapScript("instance_molten_core", 409) { }

        struct instance_molten_core_InstanceMapScript : public InstanceScript
        {
            instance_molten_core_InstanceMapScript(Map* map) : InstanceScript(map)
            {
                SetBossNumber(MAX_ENCOUNTER);
                _golemaggTheIncineratorGUID = 0;
                _majordomoExecutusGUID = 0;
                _cacheOfTheFirelordGUID = 0;
                _deadBossCount = 0;
                _ragnarosAddDeaths = 0;
            }

            void OnPlayerEnter(Player* /*player*/) override
            {
                if (CheckMajordomoExecutus())
                    SummonMajordomoExecutus();
            }

            void OnCreatureCreate(Creature* creature) override
            {
                switch (creature->GetEntry())
                {
                    case NPC_GOLEMAGG_THE_INCINERATOR:
                        _golemaggTheIncineratorGUID = creature->GetGUID();
                        break;
                    case NPC_MAJORDOMO_EXECUTUS:
                        _majordomoExecutusGUID = creature->GetGUID();
                        break;
                    default:
                        break;
                }
            }

            void OnGameObjectCreate(GameObject* go) override
            {
                switch (go->GetEntry())
                {
                    case GO_CACHE_OF_THE_FIRELORD:
                        _cacheOfTheFirelordGUID = go->GetGUID();
                        break;
                    case GO_CIRCLE_BARON:
                        _circlesGUIDs[5] = go->GetGUID();
                        break;
                    case GO_CIRCLE_GARR:
                        _circlesGUIDs[3] = go->GetGUID();
                        break;
                    case GO_CIRCLE_GEHENNAS:
                        _circlesGUIDs[2] = go->GetGUID();
                        break;
                    case GO_CIRCLE_GOLEMAGG:
                        _circlesGUIDs[7] = go->GetGUID();
                        break;
                    case GO_CIRCLE_MAGMADAR:
                        _circlesGUIDs[1] = go->GetGUID();
                        break;
                    case GO_CIRCLE_SHAZZRAH:
                        _circlesGUIDs[4] = go->GetGUID();
                        break;
                    case GO_CIRCLE_SULFURON:
                        _circlesGUIDs[6] = go->GetGUID();
                        break;
                    default:
                        break;
                }
            }

            void SetData(uint32 type, uint32 data) override
            {
                if (type == DATA_RAGNAROS_ADDS)
                {
                    if (data == 1)
                        ++_ragnarosAddDeaths;
                    else if (data == 0)
                        _ragnarosAddDeaths = 0;
                }
            }

            uint32 GetData(uint32 type) const  override
            {
                switch (type)
                {
                    case DATA_RAGNAROS_ADDS:
                        return _ragnarosAddDeaths;
                }

                return 0;
            }

            uint64 GetData64(uint32 type) const  override
            {
                switch (type)
                {
                    case BOSS_GOLEMAGG_THE_INCINERATOR:
                        return _golemaggTheIncineratorGUID;
                    case BOSS_MAJORDOMO_EXECUTUS:
                        return _majordomoExecutusGUID;
                }

                return 0;
            }

            bool SetBossState(uint32 bossId, EncounterState state) override
            {
                if (!InstanceScript::SetBossState(bossId, state))
                    return false;
                
                if (state == DONE && bossId < BOSS_MAJORDOMO_EXECUTUS)
                    if (CheckMajordomoExecutus())
                        SummonMajordomoExecutus();
                
                if (bossId == BOSS_MAJORDOMO_EXECUTUS && state == DONE) {
                    DoRespawnGameObject(_cacheOfTheFirelordGUID, 7 * DAY);
                }

                return true;
            }

            void SummonMajordomoExecutus()
            {
                if (_majordomoExecutusGUID)
                    return;

                if (GetBossState(BOSS_MAJORDOMO_EXECUTUS) != DONE)
                {
                    instance->SummonCreature(NPC_MAJORDOMO_EXECUTUS, SummonPositions[0]);
                    instance->SummonCreature(NPC_FLAMEWAKER_HEALER, SummonPositions[1]);
                    instance->SummonCreature(NPC_FLAMEWAKER_HEALER, SummonPositions[2]);
                    instance->SummonCreature(NPC_FLAMEWAKER_HEALER, SummonPositions[3]);
                    instance->SummonCreature(NPC_FLAMEWAKER_HEALER, SummonPositions[4]);
                    instance->SummonCreature(NPC_FLAMEWAKER_ELITE, SummonPositions[5]);
                    instance->SummonCreature(NPC_FLAMEWAKER_ELITE, SummonPositions[6]);
                    instance->SummonCreature(NPC_FLAMEWAKER_ELITE, SummonPositions[7]);
                    instance->SummonCreature(NPC_FLAMEWAKER_ELITE, SummonPositions[8]);
                }
                else if (TempSummon* summon = instance->SummonCreature(NPC_MAJORDOMO_EXECUTUS, RagnarosTelePos))
                    summon->AI()->DoAction(ACTION_START_RAGNAROS_ALT);
            }

            bool CheckMajordomoExecutus() const
            {
                if (GetBossState(BOSS_RAGNAROS) == DONE)
                    return false;

                for (uint8 i = 0; i < BOSS_MAJORDOMO_EXECUTUS; ++i)
                    if (GetBossState(i) != DONE)
                        return false;

                return true;
            }

            std::string GetSaveData()  override
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << "M C " << GetBossSaveData();

                OUT_SAVE_INST_DATA_COMPLETE;
                return saveStream.str();
            }

            void Load(char const* data)  override
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
                            tmpState = NOT_STARTED;

                        SetBossState(i, EncounterState(tmpState));
                    }

                    if (CheckMajordomoExecutus())
                        SummonMajordomoExecutus();
                }
                else
                    OUT_LOAD_INST_DATA_FAIL;

                OUT_LOAD_INST_DATA_COMPLETE;
            }

        private:
            uint64 _golemaggTheIncineratorGUID;
            uint64 _majordomoExecutusGUID;
            uint64 _cacheOfTheFirelordGUID;
            uint8 _deadBossCount;
            uint8 _ragnarosAddDeaths;
            std::unordered_map<uint8, uint64> _circlesGUIDs;
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_molten_core_InstanceMapScript(map);
        }
};

void AddSC_instance_molten_core()
{
    new instance_molten_core();
}
