/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "InstanceMapScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "violet_hold.h"

enum vYells
{
    CYANIGOSA_SAY_SPAWN       = 3,
    SAY_SINCLARI_LEAVING      = 0,
    SAY_SINCLARI_DOOR_LOCK    = 1,
    SAY_SINCLARI_COMPLETE     = 2,
};

class instance_violet_hold : public InstanceMapScript
{
public:
    instance_violet_hold() : InstanceMapScript("instance_violet_hold", 608) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
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

        GuidVector GO_ActivationCrystalGUID;
        ObjectGuid GO_MainGateGUID;

        ObjectGuid GO_MoraggCellGUID;
        ObjectGuid GO_ErekemCellGUID;
        ObjectGuid GO_ErekemRightGuardCellGUID;
        ObjectGuid GO_ErekemLeftGuardCellGUID;
        ObjectGuid GO_IchoronCellGUID;
        ObjectGuid GO_LavanthorCellGUID;
        ObjectGuid GO_XevozzCellGUID;
        ObjectGuid GO_ZuramatCellGUID;

        GuidSet trashMobs;
        ObjectGuid NPC_SinclariGUID;
        ObjectGuid NPC_GuardGUID[4];
        ObjectGuid NPC_PortalGUID;
        ObjectGuid NPC_DoorSealGUID;

        ObjectGuid NPC_MoraggGUID;
        ObjectGuid NPC_ErekemGUID;
        ObjectGuid NPC_ErekemGuardGUID[2];
        ObjectGuid NPC_IchoronGUID;
        ObjectGuid NPC_LavanthorGUID;
        ObjectGuid NPC_XevozzGUID;
        ObjectGuid NPC_ZuramatGUID;
        ObjectGuid NPC_CyanigosaGUID;

        void Initialize() override
        {
            SetHeaders(DataHeader);
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
        }

        bool IsEncounterInProgress() const override
        {
            return false;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch(creature->GetEntry())
            {
                case NPC_SINCLARI:
                    NPC_SinclariGUID = creature->GetGUID();
                    break;
                case NPC_VIOLET_HOLD_GUARD:
                    for (uint8 i = 0; i < 4; ++i)
                        if (!NPC_GuardGUID[i])
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
                    if (!NPC_ErekemGuardGUID[0])
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

        void OnGameObjectCreate(GameObject* go) override
        {
            switch(go->GetEntry())
            {
                case GO_ACTIVATION_CRYSTAL:
                    HandleGameObject(ObjectGuid::Empty, false, go); // make go not used yet
                    go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE); // not useable at the beginning
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

        void SetData(uint32 type, uint32 data) override
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
                            c->AI()->Talk(SAY_SINCLARI_LEAVING);
                        events.RescheduleEvent(EVENT_GUARDS_FALL_BACK, 4s);
                    }
                    break;
                case DATA_PORTAL_DEFEATED:
                    events.RescheduleEvent(EVENT_SUMMON_PORTAL, 3s);
                    break;
                case DATA_PORTAL_LOCATION:
                    PortalLocation = data;
                    break;
                case DATA_DECRASE_DOOR_HEALTH:
                    if (GateHealth > 0)
                        --GateHealth;
                    if (GateHealth == 0)
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
                        if (Creature* c = instance->GetCreature(NPC_SinclariGUID))
                        {
                            c->AI()->Talk(SAY_SINCLARI_COMPLETE);
                            c->DespawnOrUnsummon();
                            c->SetRespawnTime(3);
                        }
                    }
                    SaveToDB();
                    if (WaveCount < 18)
                        events.RescheduleEvent(EVENT_SUMMON_PORTAL, 35s);
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

        void SetGuidData(uint32 type, ObjectGuid data) override
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

        uint32 GetData(uint32 type) const override
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

        ObjectGuid GetGuidData(uint32 identifier) const override
        {
            switch (identifier)
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

            return ObjectGuid::Empty;
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
                        pGuard1->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        pGuard1->SetImmuneToNPC(false);
                        pGuard1->GetMotionMaster()->MovePoint(0, BossStartMove21);
                    }
                    if (Creature* pGuard2 = instance->GetCreature(NPC_ErekemGuardGUID[1]))
                    {
                        pGuard2->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        pGuard2->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        pGuard2->SetImmuneToNPC(false);
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
                pBoss->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                pBoss->SetImmuneToNPC(false);
                pBoss->SetReactState(REACT_AGGRESSIVE);
                if ((WaveCount == 6 && m_auiEncounter[0] == DONE) || (WaveCount == 12 && m_auiEncounter[1] == DONE))
                    pBoss->SetLootMode(0);
            }
        }

        void Update(uint32 diff) override
        {
            events.Update(diff);
            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_CHECK_PLAYERS:
                    {
                        if( DoNeedCleanup(false) )
                            InstanceCleanup();
                        events.Repeat(5s);
                    }
                    break;
                case EVENT_GUARDS_FALL_BACK:
                    {
                        for (uint8 i = 0; i < 4; ++i)
                            if (Creature* c = instance->GetCreature(NPC_GuardGUID[i]))
                            {
                                c->SetReactState(REACT_PASSIVE);
                                c->CombatStop();
                                c->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                                c->GetMotionMaster()->MovePoint(0, guardMovePosition);
                            }
                        events.RescheduleEvent(EVENT_GUARDS_DISAPPEAR, 5s);
                    }
                    break;
                case EVENT_GUARDS_DISAPPEAR:
                    {
                        for (uint8 i = 0; i < 4; ++i)
                            if (Creature* c = instance->GetCreature(NPC_GuardGUID[i]))
                                c->SetVisible(false);
                        events.RescheduleEvent(EVENT_SINCLARI_FALL_BACK, 2s);
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
                        events.RescheduleEvent(EVENT_START_ENCOUNTER, 4s);
                    }
                    break;
                case EVENT_START_ENCOUNTER:
                    {
                        if (Creature* c = instance->GetCreature(NPC_SinclariGUID))
                        {
                            c->AI()->Talk(SAY_SINCLARI_DOOR_LOCK);
                        }
                        if (Creature* c = instance->GetCreature(NPC_DoorSealGUID))
                        {
                            c->RemoveAllAuras(); // just to be sure...
                        }
                        GateHealth = 100;
                        HandleGameObject(GO_MainGateGUID, false);
                        DoUpdateWorldState(WORLD_STATE_VH_SHOW, 1);
                        DoUpdateWorldState(WORLD_STATE_VH_PRISON_STATE, (uint32)GateHealth);
                        DoUpdateWorldState(WORLD_STATE_VH_WAVE_COUNT, (uint32)WaveCount);

                        for (ObjectGuid const& guid : GO_ActivationCrystalGUID)
                            if (GameObject* go = instance->GetGameObject(guid))
                            {
                                HandleGameObject(ObjectGuid::Empty, false, go); // not used yet
                                go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE); // make it useable
                            }
                        events.RescheduleEvent(EVENT_SUMMON_PORTAL, 4s);
                    }
                    break;
                case EVENT_SUMMON_PORTAL:
                    ++WaveCount;
                    DoUpdateWorldState(WORLD_STATE_VH_WAVE_COUNT, (uint32)WaveCount);
                    SetData(DATA_PORTAL_LOCATION, (GetData(DATA_PORTAL_LOCATION) + urand(1, 5)) % 6);
                    if (Creature* c = instance->GetCreature(NPC_SinclariGUID))
                    {
                        if (WaveCount % 6 != 0)
                            c->SummonCreature(NPC_TELEPORTATION_PORTAL, PortalLocations[GetData(DATA_PORTAL_LOCATION)], TEMPSUMMON_CORPSE_DESPAWN);
                        else if (WaveCount == 6 || WaveCount == 12) // first or second boss
                        {
                            if (!uiFirstBoss || !uiSecondBoss)
                            {
                                uiFirstBoss = urand(1, 6);
                                do { uiSecondBoss = urand(1, 6); }
                                while (uiFirstBoss == uiSecondBoss);
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
                            events.RescheduleEvent(EVENT_CYANIGOSSA_TRANSFORM, 10s);
                        }
                    }
                    break;
                case EVENT_CYANIGOSSA_TRANSFORM:
                    if (Creature* c = instance->GetCreature(NPC_CyanigosaGUID))
                    {
                        c->RemoveAurasDueToSpell(SPELL_CYANIGOSA_BLUE_AURA);
                        c->CastSpell(c, SPELL_CYANIGOSA_TRANSFORM, 0);
                        events.RescheduleEvent(EVENT_CYANIGOSA_ATTACK, 2500ms);
                    }
                    break;
                case EVENT_CYANIGOSA_ATTACK:
                    if (Creature* c = instance->GetCreature(NPC_CyanigosaGUID))
                    {
                        c->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        c->SetImmuneToNPC(false);
                    }
                    break;
            }
        }

        void OnPlayerEnter(Player* plr) override
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

            events.RescheduleEvent(EVENT_CHECK_PLAYERS, 5s);
        }

        bool DoNeedCleanup(bool enter)
        {
            uint8 aliveCount = 0;
            Map::PlayerList const& pl = instance->GetPlayers();
            for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                if( Player* plr = itr->GetSource() )
                    if( plr->IsAlive() && !plr->IsGameMaster() && !plr->HasAura(27827)/*spirit of redemption aura*/ )
                        ++aliveCount;

            bool need = enter ? aliveCount <= 1 : aliveCount == 0;
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
            for (ObjectGuid const& guid : GO_ActivationCrystalGUID)
                if (GameObject* go = instance->GetGameObject(guid))
                {
                    HandleGameObject(ObjectGuid::Empty, false, go); // not used yet
                    go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE); // not useable at the beginning
                }

            // reset positions of Sinclari and Guards
            if (Creature* c = instance->GetCreature(NPC_SinclariGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); }
            for (uint8 i = 0; i < 4; ++i)
                if (Creature* c = instance->GetCreature(NPC_GuardGUID[i]))
                {
                    c->DespawnOrUnsummon();
                    c->SetRespawnTime(3);
                    if (m_auiEncounter[MAX_ENCOUNTER - 1] == DONE)
                        c->SetVisible(false);
                    else
                        c->SetVisible(true);
                    c->SetReactState(REACT_AGGRESSIVE);
                }

            // remove portal if any
            if (Creature* c = instance->GetCreature(NPC_PortalGUID))
                c->DespawnOrUnsummon();
            NPC_PortalGUID.Clear();

            // remove trash
            for (ObjectGuid const& guid : trashMobs)
                if (Creature* c = instance->GetCreature(guid))
                    c->DespawnOrUnsummon();

            trashMobs.clear();

            // clear door seal damaging auras:
            if (Creature* c = instance->GetCreature(NPC_DoorSealGUID))
                c->RemoveAllAuras();

            // open main gate
            HandleGameObject(GO_MainGateGUID, true);

            if (m_auiEncounter[MAX_ENCOUNTER - 1] != DONE) // instance not finished
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
                if (Creature* c = instance->GetCreature(NPC_MoraggGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE); c->SetImmuneToNPC(true); }
                if (Creature* c = instance->GetCreature(NPC_MoraggGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE); c->SetImmuneToNPC(true); }
                if (Creature* c = instance->GetCreature(NPC_ErekemGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE); c->SetImmuneToNPC(true); }
                if (Creature* c = instance->GetCreature(NPC_ErekemGuardGUID[0])) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE); c->SetImmuneToNPC(true); }
                if (Creature* c = instance->GetCreature(NPC_ErekemGuardGUID[1])) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE); c->SetImmuneToNPC(true); }
                if (Creature* c = instance->GetCreature(NPC_IchoronGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE); c->SetImmuneToNPC(true); }
                if (Creature* c = instance->GetCreature(NPC_LavanthorGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE); c->SetImmuneToNPC(true); }
                if (Creature* c = instance->GetCreature(NPC_XevozzGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE); c->SetImmuneToNPC(true); }
                if (Creature* c = instance->GetCreature(NPC_ZuramatGUID)) { c->DespawnOrUnsummon(); c->SetRespawnTime(3); c->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE); c->SetImmuneToNPC(true); }
                if (Creature* c = instance->GetCreature(NPC_CyanigosaGUID)) { c->DespawnOrUnsummon(); }
            }

            // reinitialize variables and events
            DoUpdateWorldState(WORLD_STATE_VH_SHOW, 0);
            EncounterStatus = NOT_STARTED;
            GateHealth = 100;
            WaveCount = 0;
            bDefensesUsed = false;
            if (m_auiEncounter[MAX_ENCOUNTER - 1] == DONE)
                EncounterStatus = DONE;
            events.Reset();
            events.RescheduleEvent(EVENT_CHECK_PLAYERS, 5s);
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
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

        void ReadSaveDataMore(std::istringstream& data) override
        {
            EncounterStatus = NOT_STARTED;
            CLEANED = false;
            events.Reset();
            events.RescheduleEvent(EVENT_CHECK_PLAYERS, 0);

            data >> m_auiEncounter[0];
            data >> m_auiEncounter[1];
            data >> m_auiEncounter[2];
            data >> uiFirstBoss;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << m_auiEncounter[0] << ' '
                << m_auiEncounter[1] << ' '
                << m_auiEncounter[2] << ' '
                << uiFirstBoss << ' '
                << uiSecondBoss << ' ';
        }
    };
};

void AddSC_instance_violet_hold()
{
    new instance_violet_hold();
}
