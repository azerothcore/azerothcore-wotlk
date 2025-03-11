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

#include "BattlegroundDS.h"
#include "Creature.h"
#include "GameObject.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "WorldPacket.h"
#include "WorldStatePackets.h"

BattlegroundDS::BattlegroundDS()
{
    BgObjects.resize(BG_DS_OBJECT_MAX);
    BgCreatures.resize(BG_DS_NPC_MAX);

    _pipeKnockBackTimer = 0;
    _pipeKnockBackCount = 0;
}

void BattlegroundDS::PostUpdateImpl(uint32 diff)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    _events.Update(diff);

    while (uint32 eventId = _events.ExecuteEvent())
    {
        switch (eventId)
        {
        case BG_DS_EVENT_WATERFALL_WARNING:
            // Add the water
            DoorClose(BG_DS_OBJECT_WATER_2);
            _events.ScheduleEvent(BG_DS_EVENT_WATERFALL_ON, BG_DS_WATERFALL_WARNING_DURATION);
            break;
        case BG_DS_EVENT_WATERFALL_ON:
            // Active collision and start knockback timer
            DoorClose(BG_DS_OBJECT_WATER_1);
            _events.ScheduleEvent(BG_DS_EVENT_WATERFALL_OFF, BG_DS_WATERFALL_DURATION);
            _events.ScheduleEvent(BG_DS_EVENT_WATERFALL_KNOCKBACK, BG_DS_WATERFALL_KNOCKBACK_TIMER);
            break;
        case BG_DS_EVENT_WATERFALL_OFF:
            // Remove collision and water
            DoorOpen(BG_DS_OBJECT_WATER_1);
            DoorOpen(BG_DS_OBJECT_WATER_2);
            _events.CancelEvent(BG_DS_EVENT_WATERFALL_KNOCKBACK);
            _events.ScheduleEvent(BG_DS_EVENT_WATERFALL_WARNING, BG_DS_WATERFALL_TIMER_MIN, BG_DS_WATERFALL_TIMER_MAX);
            break;
        case BG_DS_EVENT_WATERFALL_KNOCKBACK:
            // Repeat knockback while the waterfall still active
            if (Creature* waterSpout = GetBGCreature(BG_DS_NPC_WATERFALL_KNOCKBACK))
                waterSpout->CastSpell(waterSpout, BG_DS_SPELL_WATER_SPOUT, true);
            _events.ScheduleEvent(eventId, BG_DS_WATERFALL_KNOCKBACK_TIMER);
            break;
        case BG_DS_EVENT_PIPE_KNOCKBACK:
            for (uint32 i = BG_DS_NPC_PIPE_KNOCKBACK_1; i <= BG_DS_NPC_PIPE_KNOCKBACK_2; ++i)
                if (Creature* waterSpout = GetBGCreature(i))
                    waterSpout->CastSpell(waterSpout, BG_DS_SPELL_FLUSH, true);
            break;
        }
    }

    if (_pipeKnockBackCount < BG_DS_PIPE_KNOCKBACK_TOTAL_COUNT)
    {
        if (_pipeKnockBackTimer < diff)
        {
            for (uint32 i = BG_DS_NPC_PIPE_KNOCKBACK_1; i <= BG_DS_NPC_PIPE_KNOCKBACK_2; ++i)
                if (Creature* waterSpout = GetBGCreature(i))
                    waterSpout->CastSpell(waterSpout, BG_DS_SPELL_FLUSH, true);

            ++_pipeKnockBackCount;
            _pipeKnockBackTimer = BG_DS_PIPE_KNOCKBACK_DELAY;
        }
        else
            _pipeKnockBackTimer -= diff;
    }
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
        SpawnBGObject(i, 90);

    _events.ScheduleEvent(BG_DS_EVENT_WATERFALL_WARNING, BG_DS_WATERFALL_TIMER_MIN, BG_DS_WATERFALL_TIMER_MAX);
    //for (uint8 i = 0; i < BG_DS_PIPE_KNOCKBACK_TOTAL_COUNT; ++i)
    //    _events.ScheduleEvent(BG_DS_EVENT_PIPE_KNOCKBACK, BG_DS_PIPE_KNOCKBACK_FIRST_DELAY + i * BG_DS_PIPE_KNOCKBACK_DELAY);

    _pipeKnockBackCount = 0;
    _pipeKnockBackTimer = BG_DS_PIPE_KNOCKBACK_FIRST_DELAY;

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

void BattlegroundDS::HandleAreaTrigger(Player* player, uint32 trigger)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    switch (trigger)
    {
        case 5347:
        case 5348:
            // Remove effects of Demonic Circle Summon
            if (player->HasAura(SPELL_WARL_DEMONIC_CIRCLE))
                player->RemoveAurasDueToSpell(SPELL_WARL_DEMONIC_CIRCLE);

            // Someone has get back into the pipes and the knockback has already been performed,
            // so we reset the knockback count for kicking the player again into the arena.
            if (_pipeKnockBackCount >= BG_DS_PIPE_KNOCKBACK_TOTAL_COUNT)
                _pipeKnockBackCount = 0;
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
        /*default:
            Battleground::HandleAreaTrigger(player, trigger);
            break;*/
    }
}

bool BattlegroundDS::HandlePlayerUnderMap(Player* player)
{
    player->NearTeleportTo(1299.046f, 784.825f, 9.338f, 2.422f);
    return true;
}

void BattlegroundDS::FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet)
{
    packet.Worldstates.emplace_back(0xe1a, 1); // ARENA_WORLD_STATE_ALIVE_PLAYERS_SHOW
    Arena::FillInitialWorldStates(packet);
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
        LOG_ERROR("sql.sql", "BatteGroundDS: Failed to spawn some object!");
        return false;
    }

    return true;
}
