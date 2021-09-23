/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Battleground.h"
#include "BattlegroundRV.h"
#include "GameObject.h"
#include "Language.h"
#include "ObjectAccessor.h"
#include "Pet.h"
#include "Player.h"
#include "WorldPacket.h"
#include "WorldSession.h"

BattlegroundRV::BattlegroundRV()
{
    BgObjects.resize(BG_RV_OBJECT_MAX);

    StartDelayTimes[BG_STARTING_EVENT_FIRST]  = BG_START_DELAY_1M;
    StartDelayTimes[BG_STARTING_EVENT_SECOND] = BG_START_DELAY_30S;
    StartDelayTimes[BG_STARTING_EVENT_THIRD]  = BG_START_DELAY_15S;
    StartDelayTimes[BG_STARTING_EVENT_FOURTH] = BG_START_DELAY_NONE;
    StartMessageIds[BG_STARTING_EVENT_FIRST]  = LANG_ARENA_ONE_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_SECOND] = LANG_ARENA_THIRTY_SECONDS;
    StartMessageIds[BG_STARTING_EVENT_THIRD]  = LANG_ARENA_FIFTEEN_SECONDS;
    StartMessageIds[BG_STARTING_EVENT_FOURTH] = LANG_ARENA_HAS_BEGUN;

    CheckPlayersTimer = 0;
}

BattlegroundRV::~BattlegroundRV() { }

void BattlegroundRV::TeleportUnitToNewZ(Unit* unit, float newZ, bool casting)
{
    if (!unit->IsAlive())
        return;
    unit->NearTeleportTo(unit->GetPositionX(), unit->GetPositionY(), newZ, unit->GetOrientation(), casting);
    unit->m_positionZ = newZ;
}

void BattlegroundRV::CheckPositionForUnit(Unit* unit)
{
    // get height at current pos, if something is wrong (below or high above) - teleport
    if (!unit->IsFalling() && unit->IsAlive())
    {
        float groundZ_vmap = unit->GetMap()->GetHeight(unit->GetPositionX(), unit->GetPositionY(), 37.0f, true, 50.0f);
        float groundZ_dyntree = unit->GetMap()->GetDynamicMapTree().getHeight(unit->GetPositionX(), unit->GetPositionY(), 37.0f, 50.0f, unit->GetPhaseMask());
        if ((groundZ_vmap > 28.0f && groundZ_vmap < 29.0f) || (groundZ_dyntree > 28.0f && groundZ_dyntree < 37.0f))
        {
            float groundZ = std::max<float>(groundZ_vmap, groundZ_dyntree);
            if (unit->GetPositionZ() < groundZ - 0.2f || unit->GetPositionZ() > groundZ + 3.5f)
                TeleportUnitToNewZ(unit, groundZ + 1.0f, true);
        }
    }
}

void BattlegroundRV::PostUpdateImpl(uint32 diff)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    if (getTimer() < diff)
    {
        switch (getState())
        {
            case BG_RV_STATE_OPEN_FENCES:
                for (uint8 i = BG_RV_OBJECT_FIRE_1; i <= BG_RV_OBJECT_FIREDOOR_2; ++i)
                    DoorOpen(i);
                setTimer(BG_RV_CLOSE_FIRE_TIMER);
                setState(BG_RV_STATE_CLOSE_FIRE);

                for (auto itr = m_Players.begin(); itr != m_Players.end(); ++itr)
                    if (Player* player = itr->second)
                    {
                        // Demonic Circle Summon
                        if (GameObject* gObj = player->GetGameObject(48018))
                        {
                            gObj->Relocate(gObj->GetPositionX(), gObj->GetPositionY(), 28.28f);
                            gObj->UpdateObjectVisibility(true);
                        }

                        if (player->GetPositionZ() < 27.0f)
                            TeleportUnitToNewZ(player, 28.28f, true);

                        for (uint8 i = SUMMON_SLOT_TOTEM; i < MAX_TOTEM_SLOT; ++i)
                            if (player->m_SummonSlot[i])
                                if (Creature* totem = GetBgMap()->GetCreature(player->m_SummonSlot[i]))
                                    if (totem->GetPositionZ() < 28.0f)
                                        TeleportUnitToNewZ(totem, 28.28f, true);

                        for (auto itr2 = player->m_Controlled.begin(); itr2 != player->m_Controlled.end(); ++itr2)
                        {
                            if ((*itr2)->GetPositionZ() < 28.0f)
                                TeleportUnitToNewZ((*itr2), 28.28f, true);

                            // Xinef: override stay position
                            if (CharmInfo* charmInfo = (*itr2)->GetCharmInfo())
                                if (charmInfo->IsAtStay())
                                {
                                    (*itr2)->StopMovingOnCurrentPos();
                                    charmInfo->SaveStayPosition(false);
                                }
                        }
                    }

                // fix ground on elevators (so aoe spells can be casted there)
                {
                    uint32 objects[2] = {BG_RV_OBJECT_ELEVATOR_1, BG_RV_OBJECT_ELEVATOR_2};
                    for (uint8 i = 0; i < 2; ++i)
                        if (GameObject* go = GetBGObject(objects[i]))
                            go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_TRANSPORT);
                }
                break;
            case BG_RV_STATE_CLOSE_FIRE:
                for (uint8 i = BG_RV_OBJECT_FIRE_1; i <= BG_RV_OBJECT_FIREDOOR_2; ++i)
                    DoorClose(i);
                // Fire got closed after five seconds, leaves twenty seconds before toggling pillars
                setTimer(BG_RV_FIRE_TO_PILLAR_TIMER);
                setState(BG_RV_STATE_SWITCH_PILLARS);
                break;
            case BG_RV_STATE_SWITCH_PILLARS:
                UpdatePillars();
                setTimer(BG_RV_PILLAR_SWITCH_TIMER);
                break;
        }
    }
    else
        setTimer(getTimer() - diff);

    if (getState() == BG_RV_STATE_OPEN_FENCES)
        return;

    if (CheckPlayersTimer <= diff)
    {
        CheckPlayersTimer = 0;
        for (BattlegroundPlayerMap::iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
            CheckPositionForUnit(itr->second);

        // maybe for pets and m_Controlled also, but not really necessary
    }
    else
        CheckPlayersTimer -= diff;
}

void BattlegroundRV::StartingEventCloseDoors()
{
}

void BattlegroundRV::StartingEventOpenDoors()
{
    for (BattlegroundPlayerMap::iterator itr = m_Players.begin(); itr != m_Players.end(); ++itr)
        itr->second->SetPhaseMask(1, true);

    // Buff respawn
    SpawnBGObject(BG_RV_OBJECT_BUFF_1, 90);
    SpawnBGObject(BG_RV_OBJECT_BUFF_2, 90);

    // Elevators
    DoorOpen(BG_RV_OBJECT_ELEVATOR_1);
    DoorOpen(BG_RV_OBJECT_ELEVATOR_2);

    setState(BG_RV_STATE_OPEN_FENCES);
    setTimer(BG_RV_FIRST_TIMER);
}

void BattlegroundRV::AddPlayer(Player* player)
{
    if (GetStatus() == STATUS_WAIT_JOIN && player->GetBgTeamId() == TEAM_HORDE)
        player->SetPhaseMask(2, true);

    Battleground::AddPlayer(player);
    PlayerScores[player->GetGUID()] = new BattlegroundScore(player);
    BattlegroundRV::UpdateArenaWorldState();
}

void BattlegroundRV::RemovePlayer(Player* player)
{
    if (GetStatus() == STATUS_WAIT_LEAVE)
        return;

    if (GetStatus() == STATUS_WAIT_JOIN)
        player->SetPhaseMask(1, true);

    BattlegroundRV::UpdateArenaWorldState();
    CheckArenaWinConditions();
}

void BattlegroundRV::HandleKillPlayer(Player* player, Player* killer)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    if (!killer)
        return;

    Battleground::HandleKillPlayer(player, killer);
    BattlegroundRV::UpdateArenaWorldState();

    CheckArenaWinConditions();
}

bool BattlegroundRV::HandlePlayerUnderMap(Player* player)
{
    player->NearTeleportTo(763.5f, -284, 28.276f, 2.422f);
    return true;
}

void BattlegroundRV::HandleAreaTrigger(Player* player, uint32 trigger)
{
    if (GetStatus() != STATUS_IN_PROGRESS || getState() == BG_RV_STATE_OPEN_FENCES /*during elevator rising it's possible to jump and cause areatrigger*/)
        return;

    switch (trigger)
    {
        // fire was removed in 3.2.0
        case 5473:
        case 5474:
            break;
        // OUTSIDE OF ARENA, TELEPORT!
        case 5224:
            player->NearTeleportTo(765.0f, -294.0f, 28.3f, player->GetOrientation());
            break;
        case 5226:
            player->NearTeleportTo(765.0f, -272.0f, 28.3f, player->GetOrientation());
            break;
        case 5447:
            player->NearTeleportTo(763.5f, -284, 28.276f, 2.422f);
            break;
    }
}

void BattlegroundRV::FillInitialWorldStates(WorldPacket& data)
{
    data << uint32(BG_RV_WORLD_STATE) << uint32(1);
    BattlegroundRV::UpdateArenaWorldState();
}

void BattlegroundRV::UpdateArenaWorldState()
{
    UpdateWorldState(BG_RV_WORLD_STATE_A, GetAlivePlayersCountByTeam(TEAM_ALLIANCE));
    UpdateWorldState(BG_RV_WORLD_STATE_H, GetAlivePlayersCountByTeam(TEAM_HORDE));
}

void BattlegroundRV::Init()
{
    //call parent's class reset
    Battleground::Init();
}

bool BattlegroundRV::SetupBattleground()
{
    // elevators
    if (!AddObject(BG_RV_OBJECT_ELEVATOR_1, BG_RV_OBJECT_TYPE_ELEVATOR_1, 763.536377f, -294.535767f, 0.505383f, 3.141593f, 0, 0, 0, RESPAWN_IMMEDIATELY)
            || !AddObject(BG_RV_OBJECT_ELEVATOR_2, BG_RV_OBJECT_TYPE_ELEVATOR_2, 763.506348f, -273.873352f, 0.505383f, 0.000000f, 0, 0, 0, RESPAWN_IMMEDIATELY)
            // buffs
            || !AddObject(BG_RV_OBJECT_BUFF_1, BG_RV_OBJECT_TYPE_BUFF_1, 735.551819f, -284.794678f, 28.276682f, 0.034906f, 0, 0, 0, RESPAWN_IMMEDIATELY)
            || !AddObject(BG_RV_OBJECT_BUFF_2, BG_RV_OBJECT_TYPE_BUFF_2, 791.224487f, -284.794464f, 28.276682f, 2.600535f, 0, 0, 0, RESPAWN_IMMEDIATELY)
            // fire
            || !AddObject(BG_RV_OBJECT_FIRE_1, BG_RV_OBJECT_TYPE_FIRE_1, 743.543457f, -283.799469f, 28.286655f, 3.141593f, 0, 0, 0, RESPAWN_IMMEDIATELY)
            || !AddObject(BG_RV_OBJECT_FIRE_2, BG_RV_OBJECT_TYPE_FIRE_2, 782.971802f, -283.799469f, 28.286655f, 3.141593f, 0, 0, 0, RESPAWN_IMMEDIATELY)
            || !AddObject(BG_RV_OBJECT_FIREDOOR_1, BG_RV_OBJECT_TYPE_FIREDOOR_1, 743.711060f, -284.099609f, 27.542587f, 3.141593f, 0, 0, 0, RESPAWN_IMMEDIATELY)
            || !AddObject(BG_RV_OBJECT_FIREDOOR_2, BG_RV_OBJECT_TYPE_FIREDOOR_2, 783.221252f, -284.133362f, 27.535686f, 0.000000f, 0, 0, 0, RESPAWN_IMMEDIATELY)
            // Gear
            || !AddObject(BG_RV_OBJECT_GEAR_1, BG_RV_OBJECT_TYPE_GEAR_1, 763.664551f, -261.872986f, 26.686588f, 0.000000f, 0, 0, 0, RESPAWN_IMMEDIATELY)
            || !AddObject(BG_RV_OBJECT_GEAR_2, BG_RV_OBJECT_TYPE_GEAR_2, 763.578979f, -306.146149f, 26.665222f, 3.141593f, 0, 0, 0, RESPAWN_IMMEDIATELY)
            // Pulley
            || !AddObject(BG_RV_OBJECT_PULLEY_1, BG_RV_OBJECT_TYPE_PULLEY_1, 700.722290f, -283.990662f, 39.517582f, 3.141593f, 0, 0, 0, RESPAWN_IMMEDIATELY)
            || !AddObject(BG_RV_OBJECT_PULLEY_2, BG_RV_OBJECT_TYPE_PULLEY_2, 826.303833f, -283.996429f, 39.517582f, 0.000000f, 0, 0, 0, RESPAWN_IMMEDIATELY)
            // Pilars
            || !AddObject(BG_RV_OBJECT_PILAR_1, BG_RV_OBJECT_TYPE_PILAR_1, 763.632385f, -306.162384f, 25.909504f, 3.141593f, 0, 0, 0, RESPAWN_IMMEDIATELY)
            || !AddObject(BG_RV_OBJECT_PILAR_2, BG_RV_OBJECT_TYPE_PILAR_2, 723.644287f, -284.493256f, 24.648525f, 3.141593f, 0, 0, 0, RESPAWN_IMMEDIATELY)
            || !AddObject(BG_RV_OBJECT_PILAR_3, BG_RV_OBJECT_TYPE_PILAR_3, 763.611145f, -261.856750f, 25.909504f, 0.000000f, 0, 0, 0, RESPAWN_IMMEDIATELY)
            || !AddObject(BG_RV_OBJECT_PILAR_4, BG_RV_OBJECT_TYPE_PILAR_4, 802.211609f, -284.493256f, 24.648525f, 0.000000f, 0, 0, 0, RESPAWN_IMMEDIATELY)

            // Arena Ready Marker
            || !AddObject(BG_RV_OBJECT_READY_MARKER_1, ARENA_READY_MARKER_ENTRY, 769.93f, -301.04f, 2.80f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 300)
            || !AddObject(BG_RV_OBJECT_READY_MARKER_2, ARENA_READY_MARKER_ENTRY, 757.02f, -267.30f, 2.80f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 300)
       )
    {
        LOG_ERROR("sql.sql", "BatteGroundRV: Failed to spawn some object!");
        return false;
    }

    for (uint8 i = 0; i < BG_RV_OBJECT_MAX; ++i)
        if (GameObject* go = GetBGObject(i))
            go->SetPhaseMask(3, true);

    return true;
}

void BattlegroundRV::UpdatePillars()
{
    GameObject* test = GetBgMap()->GetGameObject(BgObjects[BG_RV_OBJECT_PILAR_1]);
    if (!test)
        return;

    if (test->GetGoState() == GO_STATE_READY)
    {
        for (uint8 i = BG_RV_OBJECT_PILAR_1; i <= BG_RV_OBJECT_GEAR_2; ++i)
            if (GameObject* go = GetBgMap()->GetGameObject(BgObjects[i]))
                go->SetGoState(GO_STATE_ACTIVE);
        for (uint8 i = BG_RV_OBJECT_PILAR_2; i <= BG_RV_OBJECT_PULLEY_2; ++i)
            if (GameObject* go = GetBgMap()->GetGameObject(BgObjects[i]))
                go->SetGoState(GO_STATE_READY);
    }
    else
    {
        for (uint8 i = BG_RV_OBJECT_PILAR_1; i <= BG_RV_OBJECT_GEAR_2; ++i)
            if (GameObject* go = GetBgMap()->GetGameObject(BgObjects[i]))
                go->SetGoState(GO_STATE_READY);
        for (uint8 i = BG_RV_OBJECT_PILAR_2; i <= BG_RV_OBJECT_PULLEY_2; ++i)
            if (GameObject* go = GetBgMap()->GetGameObject(BgObjects[i]))
                go->SetGoState(GO_STATE_ACTIVE);
    }
}

uint32 BattlegroundRV::GetPillarIdForPos(Position* p)
{
    float range = 1.75f;
    if (p->GetExactDist2d(763.632385f, -306.162384f) < range)
        return BG_RV_OBJECT_PILAR_1;
    if (p->GetExactDist2d(723.644287f, -284.493256f) < 2.0f * range)
        return BG_RV_OBJECT_PILAR_2;
    if (p->GetExactDist2d(763.611145f, -261.856750f) < range)
        return BG_RV_OBJECT_PILAR_3;
    if (p->GetExactDist2d(802.211609f, -284.493256f) < 2.0f * range)
        return BG_RV_OBJECT_PILAR_4;
    return 0;
}

GameObject* BattlegroundRV::GetPillarAtPosition(Position* p)
{
    uint32 pillar = GetPillarIdForPos(p);
    if (!pillar)
        return nullptr;
    return GetBgMap()->GetGameObject(BgObjects[pillar]);
}
