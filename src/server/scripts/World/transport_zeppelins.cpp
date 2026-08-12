/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "Map.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "TaskScheduler.h"
#include "Transport.h"
#include "TransportMgr.h"
#include "WorldState.h"
#include "transport_zeppelin.h"

// 175080 The Iron Eagle - Grom'gol to Orgrimmar
struct go_transport_the_iron_eagle : GameObjectAI
{
    go_transport_the_iron_eagle(GameObject *object) : GameObjectAI(object) { };

    void EventInform(uint32 eventId) override
    {
        sWorldState->HandleConditionStateChange(WORLD_STATE_CONDITION_THE_IRON_EAGLE, static_cast<WorldStateConditionState>(eventId));
        switch (eventId)
        {
            case EVENT_GROMGOL_FROM_OG_ARRIVAL:
                if (Creature *creature = me->FindNearestCreature(NPC_NEZRAZ, SEARCH_RANGE_ZEPPELIN_MASTER))
                    creature->AI()->Talk(0);
                break;
            case EVENT_OG_FROM_GROMGOL_ARRIVAL:
                if (Creature *creature = me->FindNearestCreature(NPC_SNURK_BUCKSQUICK, 150.0f))
                    creature->AI()->Talk(0);
                break;
            default:
                return;
        }
    }
};

// 164871 The Thundercaller - Undercity to Orgrimmar
struct go_transport_the_thundercaller : GameObjectAI
{
    go_transport_the_thundercaller(GameObject *object) : GameObjectAI(object) { };

    void EventInform(uint32 eventId) override
    {
        sWorldState->HandleConditionStateChange(WORLD_STATE_CONDITION_THE_THUNDERCALLER, static_cast<WorldStateConditionState>(eventId));
        switch (eventId)
        {
            case EVENT_OG_FROM_UC_ARRIVAL:
                if (Creature *creature = me->FindNearestCreature(NPC_FREZZA, SEARCH_RANGE_ZEPPELIN_MASTER))
                    creature->AI()->Talk(0);
                break;
            case EVENT_UC_FROM_OG_ARRIVAL:
                if (Creature *creature = me->FindNearestCreature(NPC_ZAPETTA, SEARCH_RANGE_ZEPPELIN_MASTER))
                    creature->AI()->Talk(0);
                break;
            case EVENT_OG_TO_UC_DEPARTURE:
                break;
            case EVENT_UC_TO_OG_DEPARTURE:
                if (Creature *creature = me->FindNearestCreature(NPC_ZAPETTA, SEARCH_RANGE_ZEPPELIN_MASTER))
                    creature->AI()->Talk(1);
                break;
            default:
                return;
        }
    }
};

// 176495 The Purple Princess - Grom'Gol to Undercity
struct go_transport_the_purple_princess : GameObjectAI
{
    go_transport_the_purple_princess(GameObject *object) : GameObjectAI(object) { };

    void EventInform(uint32 eventId) override
    {
        sWorldState->HandleConditionStateChange(WORLD_STATE_CONDITION_THE_PURPLE_PRINCESS, static_cast<WorldStateConditionState>(eventId));
        switch (eventId)
        {
            case EVENT_GROMGOL_FROM_UC_ARRIVAL:
                if (Creature *creature = me->FindNearestCreature(NPC_SQUIBBY_OVERSPECK, SEARCH_RANGE_ZEPPELIN_MASTER))
                    creature->AI()->Talk(0);
                break;
            case EVENT_UC_FROM_GROMGOL_ARRIVAL:
                if (Creature *creature = me->FindNearestCreature(NPC_HINDENBURG, SEARCH_RANGE_ZEPPELIN_MASTER))
                    creature->AI()->Talk(0);
                break;
            case EVENT_UC_TO_GROMGOL_DEPARTURE:
            case EVENT_GROMGOL_TO_UC_DEPARTURE:
                break;
            default:
                return;
        }
    }
};

// 186371 Zeppelin - Westguard Keep to Shattered Straits
struct go_transport_westguard_zeppelin : GameObjectAI
{
    go_transport_westguard_zeppelin(GameObject* object) : GameObjectAI(object) { };

    void EventInform(uint32 eventId) override
    {
        if (eventId != EVENT_WK_ARRIVAL)
            return;

        if (Creature* creature = me->FindNearestCreature(NPC_HARROWMEISER, SEARCH_RANGE_ZEPPELIN_MASTER))
            creature->AI()->Talk(0);

        // the dock is covered by two stop frames of 60s each, so EVENT_WK_DEPARTURE
        // only fires two minutes later - warn one minute before it does
        _scheduler.Schedule(1min, [this](TaskContext /*context*/)
        {
            if (Creature* creature = me->FindNearestCreature(NPC_HARROWMEISER, SEARCH_RANGE_ZEPPELIN_MASTER))
                creature->AI()->Talk(1);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);
    }

private:
    TaskScheduler _scheduler;
};

enum WestguardZeppelinGossip
{
    GOSSIP_TEXT_PETROV_EN_ROUTE       = 11322,
    GOSSIP_TEXT_PETROV_ARRIVING       = 11324,
    GOSSIP_TEXT_HARROWMEISER_DOCKED   = 11328,
    GOSSIP_TEXT_HARROWMEISER_ARRIVING = 11330,
    GOSSIP_TEXT_HARROWMEISER_EN_ROUTE = 11332,
};

// The two "en route" texts above read "in less than $3078w minutes". The client
// substitutes that token with the world state below, so it renders 0 unless a value
// has been pushed to the player first.
enum WestguardZeppelinWorldState
{
    WORLD_STATE_ZEPPELIN_ETA = 3078,
};

enum WestguardZeppelinState
{
    ZEPPELIN_STATE_EN_ROUTE,
    ZEPPELIN_STATE_ARRIVING,
    ZEPPELIN_STATE_DOCKED,
};

// Reports where the Westguard Keep zeppelin is in its path. While it is still touring the
// bay the remaining minutes are pushed to the player as WORLD_STATE_ZEPPELIN_ETA.
WestguardZeppelinState GetWestguardZeppelinState(Player* player, Map* map)
{
    MotionTransport const* zeppelin = nullptr;
    for (Transport* transport : map->GetAllTransports())
        if (transport->GetEntry() == GO_WESTGUARD_ZEPPELIN)
        {
            zeppelin = transport->ToMotionTransport();
            break;
        }

    if (!zeppelin || !zeppelin->GetPeriod())
        return ZEPPELIN_STATE_EN_ROUTE;

    uint32 dockArriveTime = 0;
    uint32 dockDepartTime = 0;
    for (KeyFrame const& frame : zeppelin->GetKeyFrames())
    {
        if (frame.Node->arrivalEventID == EVENT_WK_ARRIVAL)
            dockArriveTime = frame.ArriveTime;
        else if (frame.Node->departureEventID == EVENT_WK_DEPARTURE)
            dockDepartTime = frame.DepartureTime;
    }

    if (!dockArriveTime)
        return ZEPPELIN_STATE_EN_ROUTE;

    uint32 const period = zeppelin->GetPeriod();
    uint32 const timer = zeppelin->GetPathProgress() % period;

    // the dock is covered by the last and the first stop frame of the path, so the docked
    // window normally wraps the end of one period into the start of the next
    bool const docked = dockArriveTime > dockDepartTime
        ? timer >= dockArriveTime || timer < dockDepartTime
        : timer >= dockArriveTime && timer < dockDepartTime;

    if (docked)
        return ZEPPELIN_STATE_DOCKED;

    // modular so it stays correct whichever way around the two stop frames sit
    uint32 const msUntilArrival = (dockArriveTime + period - timer) % period;
    if (msUntilArrival <= MINUTE * IN_MILLISECONDS)
        return ZEPPELIN_STATE_ARRIVING;

    // the texts read "less than X minutes", so round up
    player->SendUpdateWorldState(WORLD_STATE_ZEPPELIN_ETA,
        (msUntilArrival + MINUTE * IN_MILLISECONDS - 1) / (MINUTE * IN_MILLISECONDS));

    return ZEPPELIN_STATE_EN_ROUTE;
}

// 23823 Harrowmeiser
class npc_harrowmeiser : public CreatureScript
{
public:
    npc_harrowmeiser() : CreatureScript("npc_harrowmeiser") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        uint32 textId = GOSSIP_TEXT_HARROWMEISER_EN_ROUTE;
        switch (GetWestguardZeppelinState(player, creature->GetMap()))
        {
            case ZEPPELIN_STATE_DOCKED:
                textId = GOSSIP_TEXT_HARROWMEISER_DOCKED;
                break;
            case ZEPPELIN_STATE_ARRIVING:
                textId = GOSSIP_TEXT_HARROWMEISER_ARRIVING;
                break;
            default:
                break;
        }

        SendGossipMenuFor(player, textId, creature->GetGUID());
        return true;
    }
};

// 23895 Bombardier Petrov
class npc_bombardier_petrov : public CreatureScript
{
public:
    npc_bombardier_petrov() : CreatureScript("npc_bombardier_petrov") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        // he has no docked text of his own, "she's almost here" covers being at the dock too
        uint32 const textId = GetWestguardZeppelinState(player, creature->GetMap()) == ZEPPELIN_STATE_EN_ROUTE
            ? GOSSIP_TEXT_PETROV_EN_ROUTE
            : GOSSIP_TEXT_PETROV_ARRIVING;

        SendGossipMenuFor(player, textId, creature->GetGUID());
        return true;
    }
};

void AddSC_transport_zeppelins()
{
    RegisterGameObjectAI(go_transport_the_iron_eagle);
    RegisterGameObjectAI(go_transport_the_thundercaller);
    RegisterGameObjectAI(go_transport_the_purple_princess);
    RegisterGameObjectAI(go_transport_westguard_zeppelin);
    new npc_harrowmeiser();
    new npc_bombardier_petrov();
}
