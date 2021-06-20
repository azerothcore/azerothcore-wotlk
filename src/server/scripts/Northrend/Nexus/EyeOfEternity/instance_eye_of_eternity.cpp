/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "eye_of_eternity.h"
#include "Vehicle.h"
#include "Player.h"

bool EoEDrakeEnterVehicleEvent::Execute(uint64 /*eventTime*/, uint32 /*updateTime*/)
{
    if (Player* p = ObjectAccessor::GetPlayer(_owner, _playerGUID))
        if (p->IsInWorld() && !p->IsDuringRemoveFromWorld() && !p->isBeingLoaded() && p->FindMap() == _owner.FindMap())
        {
            p->CastCustomSpell(60683, SPELLVALUE_BASE_POINT0, 1, &_owner, true);
            return true;
        }
    _owner.DespawnOrUnsummon(1);
    return true;
}

class instance_eye_of_eternity : public InstanceMapScript
{
public:
    instance_eye_of_eternity() : InstanceMapScript("instance_eye_of_eternity", 616) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_eye_of_eternity_InstanceMapScript(pMap);
    }

    struct instance_eye_of_eternity_InstanceMapScript : public InstanceScript
    {
        instance_eye_of_eternity_InstanceMapScript(Map* pMap) : InstanceScript(pMap) { Initialize(); }

        uint32 EncounterStatus;
        std::string str_data;

        uint64 NPC_MalygosGUID;
        uint64 GO_IrisGUID;
        uint64 GO_ExitPortalGUID;
        uint64 GO_PlatformGUID;
        bool bPokeAchiev;

        void Initialize() override
        {
            EncounterStatus = NOT_STARTED;

            NPC_MalygosGUID = 0;
            GO_IrisGUID = 0;
            GO_ExitPortalGUID = 0;
            GO_PlatformGUID = 0;
            bPokeAchiev = false;
        }
        
        bool IsEncounterInProgress() const override
        {
            return EncounterStatus == IN_PROGRESS;
        }

        void OnPlayerEnter(Player* pPlayer) override
        {
            if (EncounterStatus == DONE)
            {
                // destroy platform, hide iris (actually ensure, done at loading, but doesn't always work
                ProcessEvent(nullptr, 20158);
                if (GameObject* go = instance->GetGameObject(GO_IrisGUID))
                    if (go->GetPhaseMask() != 2)
                        go->SetPhaseMask(2, true);

                // no floor, so put players on drakes
                if (pPlayer)
                {
                    if (!pPlayer->IsAlive())
                        return;

                    if (Creature* c = pPlayer->SummonCreature(NPC_WYRMREST_SKYTALON, pPlayer->GetPositionX(), pPlayer->GetPositionY(), pPlayer->GetPositionZ()-20.0f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN, 0))
                    {
                        c->SetCanFly(true);
                        c->setFaction(pPlayer->getFaction());
                        //pPlayer->CastCustomSpell(60683, SPELLVALUE_BASE_POINT0, 1, c, true);
                        c->m_Events.AddEvent(new EoEDrakeEnterVehicleEvent(*c, pPlayer->GetGUID()), c->m_Events.CalculateTime(500));
                    }
                }
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch(creature->GetEntry())
            {
                case NPC_MALYGOS:
                    NPC_MalygosGUID = creature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch(go->GetEntry())
            {
                case GO_IRIS_N:
                case GO_IRIS_H:
                    GO_IrisGUID = go->GetGUID();
                    break;
                case GO_EXIT_PORTAL:
                    GO_ExitPortalGUID = go->GetGUID();
                    break;
                case GO_NEXUS_PLATFORM:
                    GO_PlatformGUID = go->GetGUID();
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch(type)
            {
                case DATA_IRIS_ACTIVATED:
                    if (EncounterStatus == NOT_STARTED)
                        if (Creature* c = instance->GetCreature(NPC_MalygosGUID))
                            if (Player* plr = c->SelectNearestPlayer(250.0f))
                                c->AI()->AttackStart(plr);
                    break;
                case DATA_ENCOUNTER_STATUS:
                    EncounterStatus = data;
                    switch(data)
                    {
                        case NOT_STARTED:
                            bPokeAchiev = false;
                            if (GameObject* go = instance->GetGameObject(GO_IrisGUID))
                            {
                                go->SetPhaseMask(1, true);
                                HandleGameObject(GO_IrisGUID, false, go);
                            }
                            if (GameObject* go = instance->GetGameObject(GO_ExitPortalGUID))
                                go->SetPhaseMask(1, true);
                            if (GameObject* go = instance->GetGameObject(GO_PlatformGUID))
                            {
                                go->SetDestructibleState(GO_DESTRUCTIBLE_REBUILDING, nullptr, true);
                                go->EnableCollision(true);
                            }
                            break;
                        case IN_PROGRESS:
                            bPokeAchiev = (instance->GetPlayersCountExceptGMs() < (instance->GetSpawnMode() == 0 ? (uint32)9 : (uint32)21));
                            break;
                        case DONE:
                            bPokeAchiev = false;
                            if (GameObject* go = instance->GetGameObject(GO_ExitPortalGUID))
                                go->SetPhaseMask(1, true);
                            if (Creature* c = instance->GetCreature(NPC_MalygosGUID))
                                if (c->SummonCreature(NPC_ALEXSTRASZA, 798.0f, 1268.0f, 299.0f, 2.45f ,TEMPSUMMON_TIMED_DESPAWN, 604800000))
                            break;
                    }
                    if (data == DONE)
                        SaveToDB();
                    break;
                case DATA_SET_IRIS_INACTIVE:
                    if (GameObject* go = instance->GetGameObject(GO_IrisGUID))
                    {
                        HandleGameObject(GO_IrisGUID, true, go);
                        if (Creature* c = go->SummonCreature(NPC_WORLD_TRIGGER_LAOI, *go, TEMPSUMMON_TIMED_DESPAWN, 10000))
                            c->CastSpell(c, SPELL_IRIS_ACTIVATED, true);
                    }
                    break;
                case DATA_HIDE_IRIS_AND_PORTAL:
                    if (GameObject* go = instance->GetGameObject(GO_IrisGUID))
                        go->SetPhaseMask(2, true);
                    if (GameObject* go = instance->GetGameObject(GO_ExitPortalGUID))
                        go->SetPhaseMask(2, true);
                    break;
            }
        }

        uint64 GetData64(uint32 type) const override
        {
            switch(type)
            {
                case DATA_MALYGOS_GUID:         return NPC_MalygosGUID;
            }
            return 0;
        }

        void ProcessEvent(WorldObject* /*unit*/, uint32 eventId) override
        {
            switch(eventId)
            {
                case 20158:
                    if (GameObject* go = instance->GetGameObject(GO_PlatformGUID))
                        if (Creature* c = instance->GetCreature(NPC_MalygosGUID))
                        {
                            go->ModifyHealth(-6500000, c); // We have HP 6 million in the database... So we have to do at least that
                            go->EnableCollision(false);
                        }
                    break;
            }
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;
            std::ostringstream saveStream;
            saveStream << "E E " << EncounterStatus;
            str_data = saveStream.str();
            OUT_SAVE_INST_DATA_COMPLETE;
            return str_data;
        }

        void Load(const char* in) override
        {
            if( !in )
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;
            uint32 data0;
            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0;

            if( dataHead1 == 'E' && dataHead2 == 'E' )
            {
                EncounterStatus = data0;
                switch(EncounterStatus)
                {
                    case IN_PROGRESS:
                        EncounterStatus = NOT_STARTED;
                        break;
                    case DONE:
                        // destroy platform, hide iris
                        ProcessEvent(nullptr, 20158);
                        if (GameObject* go = instance->GetGameObject(GO_IrisGUID))
                            go->SetPhaseMask(2, true);
                        break;
                }
            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const* source, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch(criteria_id)
            {
                case ACHIEV_CRITERIA_A_POKE_IN_THE_EYE_10:
                case ACHIEV_CRITERIA_A_POKE_IN_THE_EYE_25:
                    return bPokeAchiev;
                case ACHIEV_CRITERIA_DENYIN_THE_SCION_10:
                case ACHIEV_CRITERIA_DENYIN_THE_SCION_25:
                    return (source && source->GetVehicle() && source->GetVehicle()->GetVehicleInfo()->m_ID == 224);
            }
            return false;
        }
    };
};

void AddSC_instance_eye_of_eternity()
{
    new instance_eye_of_eternity();
}
