/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "violet_hold.h"
#include "Player.h"

#define CLEANUP_CHECK_INTERVAL  5000
#define SPAWN_TIME              20000

enum vYells
{
    CYANIGOSA_SAY_SPAWN       = 3,
    SAY_SINCLARI_1            = 0
};

class instance_violet_hold : public InstanceMapScript
{
public:
    instance_violet_hold() : InstanceMapScript("instance_violet_hold", 608) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_violet_hold_InstanceMapScript(pMap);
    }

    struct instance_violet_hold_InstanceMapScript : public InstanceScript
    {
        instance_violet_hold_InstanceMapScript(Map* pMap) : InstanceScript(pMap) {}

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        bool CLEANED;
        uint8 EncounterStatus;
        uint32 uiFirstBoss, uiSecondBoss;
        std::string str_data;
        EventMap events;
        uint8 GateHealth;
        uint8 WaveCount;
        uint8 PortalLocation;
        bool bAchiev;
        bool bDefensesUsed;

        std::vector<uint64> GO_ActivationCrystalGUID;
        uint64 GO_MainGateGUID;

        uint64 GO_MoraggCellGUID;
        uint64 GO_ErekemCellGUID;
        uint64 GO_ErekemRightGuardCellGUID;
        uint64 GO_ErekemLeftGuardCellGUID;
        uint64 GO_IchoronCellGUID;
        uint64 GO_LavanthorCellGUID;
        uint64 GO_XevozzCellGUID;
        uint64 GO_ZuramatCellGUID;

        std::set<uint64> trashMobs;
        uint64 NPC_SinclariGUID;
        uint64 NPC_GuardGUID[4];
        uint64 NPC_PortalGUID;
        uint64 NPC_DoorSealGUID;

        uint64 NPC_MoraggGUID;
        uint64 NPC_ErekemGUID;
        uint64 NPC_ErekemGuardGUID[2];
        uint64 NPC_IchoronGUID;
        uint64 NPC_LavanthorGUID;
        uint64 NPC_XevozzGUID;
        uint64 NPC_ZuramatGUID;
        uint64 NPC_CyanigosaGUID;

        void Initialize()
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
            CLEANED = false;
            EncounterStatus = NOT_STARTED;
            uiFirstBoss = 0;
            uiSecondBoss = 0;
            events.Reset();
            events.RescheduleEvent(EVENT_CHECK_PLAYERS, 0);
            GateHealth = 100;
            WaveCount = 0;
            PortalLocation = 0;
            bDefensesUsed = false;

            GO_ActivationCrystalGUID.clear();
            GO_MainGateGUID = 0;

            GO_MoraggCellGUID = 0;
            GO_ErekemCellGUID = 0;
            GO_ErekemRightGuardCellGUID = 0;
            GO_ErekemLeftGuardCellGUID = 0;
            GO_IchoronCellGUID = 0;
            GO_LavanthorCellGUID = 0;
            GO_XevozzCellGUID = 0;
            GO_ZuramatCellGUID = 0;

            NPC_SinclariGUID = 0;
            memset(&NPC_GuardGUID, 0, sizeof(NPC_GuardGUID));
            NPC_PortalGUID = 0;
            NPC_DoorSealGUID = 0;

            NPC_MoraggGUID = 0;
            NPC_ErekemGUID = 0;
            NPC_ErekemGuardGUID[0] = NPC_ErekemGuardGUID[1] = 0;
            NPC_IchoronGUID = 0;
            NPC_LavanthorGUID = 0;
            NPC_XevozzGUID = 0;
            NPC_ZuramatGUID = 0;
            NPC_CyanigosaGUID = 0;
        }

        bool IsEncounterInProgress() const
        {
            return false;
        }

        void OnCreatureCreate(Creature* creature)
        {
            switch(creature->GetEntry())
            {
                case NPC_SINCLARI:
                    NPC_SinclariGUID = creature->GetGUID();
                    break;
                case NPC_VIOLET_HOLD_GUARD:
                    for (uint8 i=0; i<4; ++i)
                        if (NPC_GuardGUID[i] == 0)
                        {
                            NPC_GuardGUID[i] = creature->GetGUID();
                            break;
                        }
                    break;
                case NPC_DEFENSE_DUMMY_TARGET:
                    creature->ApplySpellImmune(0, IMMUNITY_ID, SPELL_ARCANE_LIGHTNING, true);
                    break;
                case NPC_TELEPORTATION_PORTAL:
                    NPC_PortalGUID = creature->GetGUID();
                    break;
                case NPC_PRISON_DOOR_SEAL:
                    NPC_DoorSealGUID = creature->GetGUID();
                    break;
                // BOSSES BELOW:
                case NPC_XEVOZZ:
                    NPC_XevozzGUID = creature->GetGUID();
                    break;
                case NPC_LAVANTHOR:
                    NPC_LavanthorGUID = creature->GetGUID();
                    break;
                case NPC_ICHORON:
                    NPC_IchoronGUID = creature->GetGUID();
                    break;
                case NPC_ZURAMAT:
                    NPC_ZuramatGUID = creature->GetGUID();
                    break;
                case NPC_EREKEM:
                    NPC_ErekemGUID = creature->GetGUID();
                    break;
                case NPC_EREKEM_GUARD:
                    if (NPC_ErekemGuardGUID[0] == 0)
                        NPC_ErekemGuardGUID[0] = creature->GetGUID();
                    else
                        NPC_ErekemGuardGUID[1] = creature->GetGUID();
                    break;
                case NPC_MORAGG:
                    NPC_MoraggGUID = creature->GetGUID();
                    break;
                case NPC_CYANIGOSA:
                    NPC_CyanigosaGUID = creature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go)
        {
            switch(go->GetEntry())
            {
                case GO_ACTIVATION_CRYSTAL:
                    HandleGameObject(0, false, go); // make go not used yet
                    go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE); // not useable at the beginning
                    GO_ActivationCrystalGUID.push_back(go->GetGUID());
                    break;
                case GO_MAIN_DOOR:
                    GO_MainGateGUID = go->GetGUID();
                    break;
                // BOSS GATES BELOW:
                case GO_EREKEM_GUARD_1_DOOR:
                    GO_ErekemLeftGuardCellGUID = go->GetGUID();
                    break;
                case GO_EREKEM_GUARD_2_DOOR:
                    GO_ErekemRightGuardCellGUID = go->GetGUID();
                    break;
                case GO_EREKEM_DOOR:
                    GO_ErekemCellGUID = go->GetGUID();
                    break;
                case GO_ZURAMAT_DOOR:
                    GO_ZuramatCellGUID = go->GetGUID();
                    break;
                case GO_LAVANTHOR_DOOR:
                    GO_LavanthorCellGUID = go->GetGUID();
                    break;
                case GO_MORAGG_DOOR:
                    GO_MoraggCellGUID = go->GetGUID();
                    break;
                case GO_ICHORON_DOOR:
                    GO_IchoronCellGUID = go->GetGUID();
                    break;
                case GO_XEVOZZ_DOOR:
                    GO_XevozzCellGUID = go->GetGUID();
                    break;
            }
        }

        void SetData(uint32 type, uint32 data)
        {
            switch(type)
            {
                case DATA_ACTIVATE_DEFENSE_SYSTEM:
                    {
                        if (data)
                            bDefensesUsed = true;
                        const Position pos = {1919.09546f, 812.29724f, 86.2905f, M_PI};
                        instance->SummonCreature(NPC_DEFENSE_SYSTEM, pos, 0, 6499);
                    }
                    break;
                case DATA_START_INSTANCE:
                    if (EncounterStatus == NOT_STARTED)
                    {
                        EncounterStatus = IN_PROGRESS;
                        if (Creature* c = instance->GetCreature(NPC_SinclariGUID))
                            c->AI()->Talk(SAY_SINCLARI_1);
                        events.RescheduleEvent(EVENT_GUARDS_FALL_BACK, 4000);
                    }
                    break;
                case DATA_PORTAL_DEFEATED:
                    events.RescheduleEvent(EVENT_SUMMON_PORTAL, 3000);
                    break;
                case DATA_PORTAL_LOCATION:
                    PortalLocation = data;
                    break;
                case DATA_DECRASE_DOOR_HEALTH:
                    if (GateHealth>0)
                        --GateHealth;
                    if (GateHealth==0)
                    {
                        CLEANED = false;
                        InstanceCleanup();
                    }
                    DoUpdateWorldState(WORLD_STATE_VH_PRISON_STATE, (uint32)GateHealth);
                    break;
                case DATA_RELEASE_BOSS:
                    if (WaveCount == 6)
                        StartBossEncounter(uiFirstBoss);
                    else
                        StartBossEncounter(uiSecondBoss);
                    break;
                case DATA_BOSS_DIED:
                    if (WaveCount == 6)
                        m_auiEncounter[0] = DONE;
                    else if (WaveCount == 12)
                        m_auiEncounter[1] = DONE;
                    else if (WaveCount == 18)
                    {
                        m_auiEncounter[2] = DONE;
                        EncounterStatus = DONE;
                        HandleGameObject(GO_MainGateGUID, true);
                        DoUpdateWorldState(WORLD_STATE_VH_SHOW, 0);
                        if (Creature* c = instance->GetCreature(NPC_SinclariGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); }
                    }
                    SaveToDB();
                    if (WaveCount < 18)
                        events.RescheduleEvent(EVENT_SUMMON_PORTAL, 35000);
                    break;
                case DATA_FAILED:
                    CLEANED = false;
                    InstanceCleanup();
                    break;
                case DATA_ACHIEV:
                    bAchiev = !!data;
                    break;
            }
        }

        void SetData64(uint32 type, uint64 data)
        {
            switch(type)
            {
                case DATA_ADD_TRASH_MOB:
                    trashMobs.insert(data);
                    break;
                case DATA_DELETE_TRASH_MOB:
                    if (!CLEANED)
                        trashMobs.erase(data);
                    break;
            }
        }

        uint32 GetData(uint32 type) const
        {
            switch(type)
            {
                case DATA_ENCOUNTER_STATUS:
                    return (uint32)EncounterStatus;
                case DATA_WAVE_COUNT:
                    return (uint32)WaveCount;
                case DATA_PORTAL_LOCATION:
                    return PortalLocation;
                case DATA_FIRST_BOSS_NUMBER:
                    return uiFirstBoss;
                case DATA_SECOND_BOSS_NUMBER:
                    return uiSecondBoss;
            }

            return 0;
        }

        uint64 GetData64(uint32 identifier) const
        {
            switch(identifier)
            {
                case DATA_TELEPORTATION_PORTAL_GUID:
                    return NPC_PortalGUID;
                case DATA_DOOR_SEAL_GUID:
                    return NPC_DoorSealGUID;
                case DATA_EREKEM_GUID:
                    return NPC_ErekemGUID;
                case DATA_EREKEM_GUARD_1_GUID:
                    return NPC_ErekemGuardGUID[0];
                case DATA_EREKEM_GUARD_2_GUID:
                    return NPC_ErekemGuardGUID[1];
                case DATA_ICHORON_GUID:
                    return NPC_IchoronGUID;
            }

            return 0;
        }

        void StartBossEncounter(uint8 uiBoss)
        {
            Creature* pBoss = nullptr;

            switch(uiBoss)
            {
                case BOSS_MORAGG:
                    HandleGameObject(GO_MoraggCellGUID, true);
                    pBoss = instance->GetCreature(NPC_MoraggGUID);
                    if (pBoss)
                        pBoss->GetMotionMaster()->MovePoint(0, BossStartMove1);
                    break;
                case BOSS_EREKEM:
                    HandleGameObject(GO_ErekemCellGUID, true);
                    HandleGameObject(GO_ErekemRightGuardCellGUID, true);
                    HandleGameObject(GO_ErekemLeftGuardCellGUID, true);
                    pBoss = instance->GetCreature(NPC_ErekemGUID);
                    if (pBoss)
                        pBoss->GetMotionMaster()->MovePoint(0, BossStartMove2);
                    if (Creature* pGuard1 = instance->GetCreature(NPC_ErekemGuardGUID[0]))
                    {
                        pGuard1->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        pGuard1->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC);
                        pGuard1->GetMotionMaster()->MovePoint(0, BossStartMove21);
                    }
                    if (Creature* pGuard2 = instance->GetCreature(NPC_ErekemGuardGUID[1]))
                    {
                        pGuard2->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        pGuard2->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC);
                        pGuard2->GetMotionMaster()->MovePoint(0, BossStartMove22);
                    }
                    break;
                case BOSS_ICHORON:
                    HandleGameObject(GO_IchoronCellGUID, true);
                    pBoss = instance->GetCreature(NPC_IchoronGUID);
                    if (pBoss)
                        pBoss->GetMotionMaster()->MovePoint(0, BossStartMove3);
                    break;
                case BOSS_LAVANTHOR:
                    HandleGameObject(GO_LavanthorCellGUID, true);
                    pBoss = instance->GetCreature(NPC_LavanthorGUID);
                    if (pBoss)
                        pBoss->GetMotionMaster()->MovePoint(0, BossStartMove4);
                    break;
                case BOSS_XEVOZZ:
                    HandleGameObject(GO_XevozzCellGUID, true);
                    pBoss = instance->GetCreature(NPC_XevozzGUID);
                    if (pBoss)
                        pBoss->GetMotionMaster()->MovePoint(0, BossStartMove5);
                    break;
                case BOSS_ZURAMAT:
                    HandleGameObject(GO_ZuramatCellGUID, true);
                    pBoss = instance->GetCreature(NPC_ZuramatGUID);
                    if (pBoss)
                        pBoss->GetMotionMaster()->MovePoint(0, BossStartMove6);
                    break;
            }

            if (pBoss)
            {
                pBoss->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                pBoss->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC);
                pBoss->SetReactState(REACT_AGGRESSIVE);
                if ((WaveCount == 6 && m_auiEncounter[0] == DONE) || (WaveCount == 12 && m_auiEncounter[1] == DONE))
                    pBoss->SetLootMode(0);
            }
        }

        void Update(uint32 diff)
        {
            events.Update(diff);
            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_CHECK_PLAYERS:
                    {
                        if( DoNeedCleanup(false) )
                            InstanceCleanup();
                        events.RepeatEvent(CLEANUP_CHECK_INTERVAL);
                    }
                    break;
                case EVENT_GUARDS_FALL_BACK:
                    {
                        for (uint8 i=0; i<4; ++i)
                            if (Creature* c = instance->GetCreature(NPC_GuardGUID[i]))
                            {
                                c->SetReactState(REACT_PASSIVE);
                                c->CombatStop();
                                c->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                                c->GetMotionMaster()->MovePoint(0, guardMovePosition);
                            }
                        events.PopEvent();
                        events.RescheduleEvent(EVENT_GUARDS_DISAPPEAR, 5000);
                    }
                    break;
                case EVENT_GUARDS_DISAPPEAR:
                    {
                        for (uint8 i=0; i<4; ++i)
                            if (Creature* c = instance->GetCreature(NPC_GuardGUID[i]))
                                c->SetVisible(false);
                        events.PopEvent();
                        events.RescheduleEvent(EVENT_SINCLARI_FALL_BACK, 2000);
                    }
                    break;
                case EVENT_SINCLARI_FALL_BACK:
                    {
                        if (Creature* c = instance->GetCreature(NPC_SinclariGUID))
                        {
                            c->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            c->GetMotionMaster()->MovePoint(0, sinclariOutsidePosition);
                        }
                        SetData(DATA_ACTIVATE_DEFENSE_SYSTEM, 0);
                        events.PopEvent();
                        events.RescheduleEvent(EVENT_START_ENCOUNTER, 4000);
                    }
                    break;
                case EVENT_START_ENCOUNTER:
                    {
                        if (Creature* c = instance->GetCreature(NPC_DoorSealGUID))
                            c->RemoveAllAuras(); // just to be sure...
                        GateHealth = 100;
                        HandleGameObject(GO_MainGateGUID, false);
                        DoUpdateWorldState(WORLD_STATE_VH_SHOW, 1);
                        DoUpdateWorldState(WORLD_STATE_VH_PRISON_STATE, (uint32)GateHealth);
                        DoUpdateWorldState(WORLD_STATE_VH_WAVE_COUNT, (uint32)WaveCount);

                        for (std::vector<uint64>::iterator itr = GO_ActivationCrystalGUID.begin(); itr != GO_ActivationCrystalGUID.end(); ++itr)
                            if (GameObject* go = instance->GetGameObject(*itr))
                            {
                                HandleGameObject(0, false, go); // not used yet
                                go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE); // make it useable
                            }
                        events.PopEvent();
                        events.RescheduleEvent(EVENT_SUMMON_PORTAL, 4000);
                    }
                    break;
                case EVENT_SUMMON_PORTAL:
                    ++WaveCount;
                    DoUpdateWorldState(WORLD_STATE_VH_WAVE_COUNT, (uint32)WaveCount);
                    SetData(DATA_PORTAL_LOCATION, (GetData(DATA_PORTAL_LOCATION) + urand(1, 5))%6);
                    if (Creature* c = instance->GetCreature(NPC_SinclariGUID))
                    {
                        if (WaveCount%6 != 0)
                            c->SummonCreature(NPC_TELEPORTATION_PORTAL, PortalLocations[GetData(DATA_PORTAL_LOCATION)], TEMPSUMMON_CORPSE_DESPAWN);
                        else if (WaveCount == 6 || WaveCount == 12) // first or second boss
                        {
                            if (!uiFirstBoss || !uiSecondBoss)
                            {
                                uiFirstBoss = urand(1,6);
                                do { uiSecondBoss = urand(1,6); } while (uiFirstBoss==uiSecondBoss);
                                SaveToDB();
                            }
                            c->SummonCreature(NPC_TELEPORTATION_PORTAL, MiddleRoomPortalSaboLocation, TEMPSUMMON_CORPSE_DESPAWN);
                        }
                        else // cyanigossa
                        {
                            if (Creature* cyanigosa = c->SummonCreature(NPC_CYANIGOSA, CyanigosasSpawnLocation, TEMPSUMMON_DEAD_DESPAWN))
                            {
                                cyanigosa->CastSpell(cyanigosa, SPELL_CYANIGOSA_BLUE_AURA, false);
                                cyanigosa->AI()->Talk(CYANIGOSA_SAY_SPAWN);
                                cyanigosa->GetMotionMaster()->MoveJump(MiddleRoomLocation.GetPositionX(), MiddleRoomLocation.GetPositionY(), MiddleRoomLocation.GetPositionZ(), 10.0f, 20.0f);
                            }
                            events.RescheduleEvent(EVENT_CYANIGOSSA_TRANSFORM, 10000);
                        }
                    }
                    events.PopEvent();
                    break;
                case EVENT_CYANIGOSSA_TRANSFORM:
                    if (Creature* c = instance->GetCreature(NPC_CyanigosaGUID))
                    {
                        c->RemoveAurasDueToSpell(SPELL_CYANIGOSA_BLUE_AURA);
                        c->CastSpell(c, SPELL_CYANIGOSA_TRANSFORM, 0);
                        events.RescheduleEvent(EVENT_CYANIGOSA_ATTACK, 2500);
                    }
                    events.PopEvent();
                    break;
                case EVENT_CYANIGOSA_ATTACK:
                    if (Creature* c = instance->GetCreature(NPC_CyanigosaGUID))
                        c->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC);
                    events.PopEvent();
                    break;
            }
        }

        void OnPlayerEnter(Player* plr)
        {
            if( DoNeedCleanup(plr->IsAlive()) )
                InstanceCleanup();

            if (EncounterStatus == IN_PROGRESS)
            {
                plr->SendUpdateWorldState(WORLD_STATE_VH_SHOW, 1);
                plr->SendUpdateWorldState(WORLD_STATE_VH_PRISON_STATE, (uint32)GateHealth);
                plr->SendUpdateWorldState(WORLD_STATE_VH_WAVE_COUNT, (uint32)WaveCount);
            }
            else
                plr->SendUpdateWorldState(WORLD_STATE_VH_SHOW, 0);

            events.RescheduleEvent(EVENT_CHECK_PLAYERS, CLEANUP_CHECK_INTERVAL);
        }

        bool DoNeedCleanup(bool enter)
        {
            uint8 aliveCount = 0;
            Map::PlayerList const &pl = instance->GetPlayers();
            for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                if( Player* plr = itr->GetSource() )
                    if( plr->IsAlive() && !plr->IsGameMaster() && !plr->HasAura(27827)/*spirit of redemption aura*/ )
                        ++aliveCount;

            bool need = enter ? aliveCount<=1 : aliveCount==0;
            if( !need && CLEANED )
                CLEANED = false;
            return need;
        }

        void InstanceCleanup()
        {
            if( CLEANED )
                return;
            CLEANED = true;

            // reset defense crystals
            for (std::vector<uint64>::iterator itr = GO_ActivationCrystalGUID.begin(); itr != GO_ActivationCrystalGUID.end(); ++itr)
                if (GameObject* go = instance->GetGameObject(*itr))
                {
                    HandleGameObject(0, false, go); // not used yet
                    go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE); // not useable at the beginning
                }

            // reset positions of Sinclari and Guards
            if (Creature* c = instance->GetCreature(NPC_SinclariGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); }
            for (uint8 i=0; i<4; ++i)
                if (Creature* c = instance->GetCreature(NPC_GuardGUID[i]))
                {
                    c->DespawnOrUnsummon();
                    c->SetRespawnTime(3);
                    if (m_auiEncounter[MAX_ENCOUNTER-1] == DONE)
                        c->SetVisible(false);
                    else
                        c->SetVisible(true);
                    c->SetReactState(REACT_AGGRESSIVE);
                }

            // remove portal if any
            if (Creature* c = instance->GetCreature(NPC_PortalGUID))
                c->DespawnOrUnsummon();
            NPC_PortalGUID = 0;

            // remove trash
            for (std::set<uint64>::iterator itr = trashMobs.begin(); itr != trashMobs.end(); ++itr)
                if (Creature* c = instance->GetCreature(*itr))
                    c->DespawnOrUnsummon();
            trashMobs.clear();

            // clear door seal damaging auras:
            if (Creature* c = instance->GetCreature(NPC_DoorSealGUID))
                c->RemoveAllAuras();

            // open main gate
            HandleGameObject(GO_MainGateGUID, true);

            if (m_auiEncounter[MAX_ENCOUNTER-1] != DONE) // instance not finished
            {
                // close all cells
                HandleGameObject(GO_MoraggCellGUID, false);
                HandleGameObject(GO_ErekemCellGUID, false);
                HandleGameObject(GO_ErekemRightGuardCellGUID, false);
                HandleGameObject(GO_ErekemLeftGuardCellGUID, false);
                HandleGameObject(GO_IchoronCellGUID, false);
                HandleGameObject(GO_LavanthorCellGUID, false);
                HandleGameObject(GO_XevozzCellGUID, false);
                HandleGameObject(GO_ZuramatCellGUID, false);

                // respawn bosses
                if (Creature* c = instance->GetCreature(NPC_MoraggGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC); }
                if (Creature* c = instance->GetCreature(NPC_MoraggGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC); }
                if (Creature* c = instance->GetCreature(NPC_ErekemGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC); }
                if (Creature* c = instance->GetCreature(NPC_ErekemGuardGUID[0])) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC); }
                if (Creature* c = instance->GetCreature(NPC_ErekemGuardGUID[1])) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC); }
                if (Creature* c = instance->GetCreature(NPC_IchoronGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC); }
                if (Creature* c = instance->GetCreature(NPC_LavanthorGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC); }
                if (Creature* c = instance->GetCreature(NPC_XevozzGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC); }
                if (Creature* c = instance->GetCreature(NPC_ZuramatGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_NPC); }
                if (Creature* c = instance->GetCreature(NPC_CyanigosaGUID)) { c->DespawnOrUnsummon(); }
            }

            // reinitialize variables and events
            DoUpdateWorldState(WORLD_STATE_VH_SHOW, 0);
            EncounterStatus = NOT_STARTED;
            GateHealth = 100;
            WaveCount = 0;
            bDefensesUsed = false;
            if (m_auiEncounter[MAX_ENCOUNTER-1] == DONE)
                EncounterStatus = DONE;
            events.Reset();
            events.RescheduleEvent(EVENT_CHECK_PLAYERS, CLEANUP_CHECK_INTERVAL);
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/)
        {
            switch(criteria_id)
            {
                case CRITERIA_DEFENSELESS:
                    return GateHealth == 100 && !bDefensesUsed;
                case CRITERIA_A_VOID_DANCE:
                case CRITERIA_DEHYDRATION:
                    return bAchiev;
            }
            return false;
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "V H " << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' ' << m_auiEncounter[2] << ' ' << uiFirstBoss << ' ' << uiSecondBoss;
            str_data = saveStream.str();

            OUT_SAVE_INST_DATA_COMPLETE;
            return str_data;
        }

        void Load(const char* in)
        {
            EncounterStatus = NOT_STARTED;
            CLEANED = false;
            events.Reset();
            events.RescheduleEvent(EVENT_CHECK_PLAYERS, 0);

            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;
            uint32 data0, data1, data2, data3, data4;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0 >> data1 >> data2 >> data3 >> data4;

            if (dataHead1 == 'V' && dataHead2 == 'H')
            {
                m_auiEncounter[0] = data0;
                m_auiEncounter[1] = data1;
                m_auiEncounter[2] = data2;
                uiFirstBoss = data3;
                uiSecondBoss = data4;

                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    if (m_auiEncounter[i] == IN_PROGRESS)
                        m_auiEncounter[i] = NOT_STARTED;

                if (m_auiEncounter[MAX_ENCOUNTER-1] == DONE)
                    EncounterStatus = DONE;
            }
                else OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }
    };
};

void AddSC_instance_violet_hold()
{
    new instance_violet_hold();
}
