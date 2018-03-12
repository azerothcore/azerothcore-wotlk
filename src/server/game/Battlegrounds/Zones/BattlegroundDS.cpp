/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "BattlegroundDS.h"
#include "Creature.h"
#include "GameObject.h"
#include "Language.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "WorldPacket.h"
#include "WorldSession.h"

BattlegroundDS::BattlegroundDS()
{
    BgObjects.resize(BG_DS_OBJECT_MAX);
    BgCreatures.resize(BG_DS_NPC_MAX);

    _waterfallTimer = 0;
    _waterfallStatus = 0;
    _waterfallKnockbackTimer = 0;
    _pipeKnockBackTimer = 0;
    _pipeKnockBackCount = 0;

    StartDelayTimes[BG_STARTING_EVENT_FIRST]  = BG_START_DELAY_1M;
    StartDelayTimes[BG_STARTING_EVENT_SECOND] = BG_START_DELAY_30S;
    StartDelayTimes[BG_STARTING_EVENT_THIRD]  = BG_START_DELAY_15S;
    StartDelayTimes[BG_STARTING_EVENT_FOURTH] = BG_START_DELAY_NONE;
    //we must set messageIds
    StartMessageIds[BG_STARTING_EVENT_FIRST]  = LANG_ARENA_ONE_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_SECOND] = LANG_ARENA_THIRTY_SECONDS;
    StartMessageIds[BG_STARTING_EVENT_THIRD]  = LANG_ARENA_FIFTEEN_SECONDS;
    StartMessageIds[BG_STARTING_EVENT_FOURTH] = LANG_ARENA_HAS_BEGUN;
}

BattlegroundDS::~BattlegroundDS()
{

}

void BattlegroundDS::PostUpdateImpl(uint32 diff)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    if (getPipeKnockBackCount() < BG_DS_PIPE_KNOCKBACK_TOTAL_COUNT)
    {
        if (getPipeKnockBackTimer() < diff)
        {
            for (uint32 i = BG_DS_NPC_PIPE_KNOCKBACK_1; i <= BG_DS_NPC_PIPE_KNOCKBACK_2; ++i)
                if (Creature* waterSpout = GetBgMap()->GetCreature(BgCreatures[i]))
                    waterSpout->CastSpell(waterSpout, BG_DS_SPELL_FLUSH, true);

            setPipeKnockBackCount(getPipeKnockBackCount() + 1);
            setPipeKnockBackTimer(BG_DS_PIPE_KNOCKBACK_DELAY);
        }
        else
            setPipeKnockBackTimer(getPipeKnockBackTimer() - diff);
    }

    if (getWaterFallStatus() == BG_DS_WATERFALL_STATUS_ON) // Repeat knockback while the waterfall still active
    {
        if (getWaterFallKnockbackTimer() < diff)
        {
            if (Creature* waterSpout = GetBgMap()->GetCreature(BgCreatures[BG_DS_NPC_WATERFALL_KNOCKBACK]))
                waterSpout->CastSpell(waterSpout, BG_DS_SPELL_WATER_SPOUT, true);

            setWaterFallKnockbackTimer(BG_DS_WATERFALL_KNOCKBACK_TIMER);
        }
        else
            setWaterFallKnockbackTimer(getWaterFallKnockbackTimer() - diff);
    }

    if (getWaterFallTimer() < diff)
    {
        if (getWaterFallStatus() == BG_DS_WATERFALL_STATUS_OFF) // Add the water
        {
            DoorClose(BG_DS_OBJECT_WATER_2);
            setWaterFallTimer(BG_DS_WATERFALL_WARNING_DURATION);
            setWaterFallStatus(BG_DS_WATERFALL_STATUS_WARNING);
        }
        else if (getWaterFallStatus() == BG_DS_WATERFALL_STATUS_WARNING) // Active collision and perform knockback
        {
            if (GameObject* gob = GetBgMap()->GetGameObject(BgObjects[BG_DS_OBJECT_WATER_1]))
                gob->SetGoState(GO_STATE_READY);

            setWaterFallTimer(BG_DS_WATERFALL_DURATION);
            setWaterFallStatus(BG_DS_WATERFALL_STATUS_ON);
            setWaterFallKnockbackTimer(BG_DS_WATERFALL_KNOCKBACK_TIMER);
        }
        else //if (getWaterFallStatus() == BG_DS_WATERFALL_STATUS_ON) // Remove collision and water
        {
            // turn off collision
            if (GameObject* gob = GetBgMap()->GetGameObject(BgObjects[BG_DS_OBJECT_WATER_1]))
                gob->SetGoState(GO_STATE_ACTIVE);

            DoorOpen(BG_DS_OBJECT_WATER_2);
            setWaterFallTimer(urand(BG_DS_WATERFALL_TIMER_MIN, BG_DS_WATERFALL_TIMER_MAX));
            setWaterFallStatus(BG_DS_WATERFALL_STATUS_OFF);
        }
    }
    else
        setWaterFallTimer(getWaterFallTimer() - diff);
}

void BattlegroundDS::StartingEventCloseDoors()
{
    for (uint32 i = BG_DS_OBJECT_DOOR_1; i <= BG_DS_OBJECT_DOOR_2; ++i)
        SpawnBGObject(i, RESPAWN_IMMEDIATELY);
}

void BattlegroundDS::StartingEventOpenDoors()
{
    for (uint32 i = BG_DS_OBJECT_DOOR_1; i <= BG_DS_OBJECT_DOOR_2; ++i)
        DoorOpen(i);

    for (uint32 i = BG_DS_OBJECT_BUFF_1; i <= BG_DS_OBJECT_BUFF_2; ++i)
        SpawnBGObject(i, 60);

    setWaterFallTimer(urand(BG_DS_WATERFALL_TIMER_MIN, BG_DS_WATERFALL_TIMER_MAX));
    setWaterFallStatus(BG_DS_WATERFALL_STATUS_OFF);

    setPipeKnockBackTimer(BG_DS_PIPE_KNOCKBACK_FIRST_DELAY);
    setPipeKnockBackCount(0);

    SpawnBGObject(BG_DS_OBJECT_WATER_2, RESPAWN_IMMEDIATELY);
    DoorOpen(BG_DS_OBJECT_WATER_2);

    // Turn off collision
    if (GameObject* gob = GetBgMap()->GetGameObject(BgObjects[BG_DS_OBJECT_WATER_1]))
        gob->SetGoState(GO_STATE_ACTIVE);

    // Remove effects of Demonic Circle Summon
    for (BattlegroundPlayerMap::const_iterator itr = GetPlayers().begin(); itr != GetPlayers().end(); ++itr)
        if (itr->second->HasAura(48018))
            itr->second->RemoveAurasDueToSpell(48018);
}

void BattlegroundDS::AddPlayer(Player* player)
{
    Battleground::AddPlayer(player);
    PlayerScores[player->GetGUID()] = new BattlegroundScore(player);
    Battleground::UpdateArenaWorldState();
}

void BattlegroundDS::RemovePlayer(Player* /*player*/)
{
    if (GetStatus() == STATUS_WAIT_LEAVE)
        return;

    Battleground::UpdateArenaWorldState();
    CheckArenaWinConditions();
}

void BattlegroundDS::HandleKillPlayer(Player* player, Player* killer)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    if (!killer)
    {
        sLog->outError("BattlegroundDS: Killer player not found");
        return;
    }

    Battleground::HandleKillPlayer(player, killer);

    Battleground::UpdateArenaWorldState();
    CheckArenaWinConditions();
}

void BattlegroundDS::HandleAreaTrigger(Player* player, uint32 trigger)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    switch (trigger)
    {
        case 5347:
        case 5348:
            // Remove effects of Demonic Circle Summon
            if (player->HasAura(48018))
                player->RemoveAurasDueToSpell(48018);

            // Someone has get back into the pipes and the knockback has already been performed,
            // so we reset the knockback count for kicking the player again into the arena.
            if (getPipeKnockBackCount() >= BG_DS_PIPE_KNOCKBACK_TOTAL_COUNT)
                setPipeKnockBackCount(0);
            break;
        // OUTSIDE OF ARENA, TELEPORT!
        case 5328:
            player->NearTeleportTo(1290.44f, 744.96f, 3.16f, 1.6f);
            break;
        case 5329:
            player->NearTeleportTo(1292.6f, 837.07f, 3.161f, 4.7f);
            break;
        case 5330:
            player->NearTeleportTo(1250.68f, 790.86f, 3.16f, 0.0f);
            break;
        case 5331:
            player->NearTeleportTo(1332.50f, 790.9f, 3.16f, 3.14f);
            break;
        case 5326: // -10
        case 5343: // -40
        case 5344: // -60
            player->NearTeleportTo(1330.0f, 800.0f, 3.16f, player->GetOrientation());
            break;
    }
}

bool BattlegroundDS::HandlePlayerUnderMap(Player* player)
{
    player->NearTeleportTo(1299.046f, 784.825f, 9.338f, 2.422f);
    return true;
}

void BattlegroundDS::FillInitialWorldStates(WorldPacket &data)
{
    data << uint32(3610) << uint32(1);                                              // 9 show
    Battleground::UpdateArenaWorldState();
}

void BattlegroundDS::Init()
{
    //call parent's class reset
    Battleground::Init();
}

bool BattlegroundDS::SetupBattleground()
{
    // gates
    if (!AddObject(BG_DS_OBJECT_DOOR_1, BG_DS_OBJECT_TYPE_DOOR_1, 1350.95f, 817.2f, 20.8096f, 3.15f, 0, 0, 0.99627f, 0.0862864f, RESPAWN_IMMEDIATELY)
        || !AddObject(BG_DS_OBJECT_DOOR_2, BG_DS_OBJECT_TYPE_DOOR_2, 1232.65f, 764.913f, 20.0729f, 6.3f, 0, 0, 0.0310211f, -0.999519f, RESPAWN_IMMEDIATELY)
    // water
        || !AddObject(BG_DS_OBJECT_WATER_1, BG_DS_OBJECT_TYPE_WATER_1, 1291.56f, 790.837f, 7.1f, 3.14238f, 0, 0, 0.694215f, -0.719768f, 120)
        || !AddObject(BG_DS_OBJECT_WATER_2, BG_DS_OBJECT_TYPE_WATER_2, 1291.56f, 790.837f, 7.1f, 3.14238f, 0, 0, 0.694215f, -0.719768f, 120)
    // buffs
        || !AddObject(BG_DS_OBJECT_BUFF_1, BG_DS_OBJECT_TYPE_BUFF_1, 1291.7f, 813.424f, 7.11472f, 4.64562f, 0, 0, 0.730314f, -0.683111f, 120)
        || !AddObject(BG_DS_OBJECT_BUFF_2, BG_DS_OBJECT_TYPE_BUFF_2, 1291.7f, 768.911f, 7.11472f, 1.55194f, 0, 0, 0.700409f, 0.713742f, 120)
    // knockback creatures
        || !AddCreature(BG_DS_NPC_TYPE_WATER_SPOUT, BG_DS_NPC_WATERFALL_KNOCKBACK, 1291.76f, 791.02f, 7.115f, 3.054326f, RESPAWN_IMMEDIATELY)
        || !AddCreature(BG_DS_NPC_TYPE_WATER_SPOUT, BG_DS_NPC_PIPE_KNOCKBACK_1, 1369.977f, 817.2882f, 16.08718f, 3.106686f, RESPAWN_IMMEDIATELY)
        || !AddCreature(BG_DS_NPC_TYPE_WATER_SPOUT, BG_DS_NPC_PIPE_KNOCKBACK_2, 1212.833f, 765.3871f, 16.09484f, 0.0f, RESPAWN_IMMEDIATELY)
    // Arena Ready Marker
        || !AddObject(BG_DS_OBJECT_READY_MARKER_1, ARENA_READY_MARKER_ENTRY, 1229.44f, 759.35f, 17.89f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 300)
        || !AddObject(BG_DS_OBJECT_READY_MARKER_2, ARENA_READY_MARKER_ENTRY, 1352.90f, 822.77f, 17.96f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 300))
    {
        sLog->outErrorDb("BatteGroundDS: Failed to spawn some object!");
        return false;
    }

    return true;
}
