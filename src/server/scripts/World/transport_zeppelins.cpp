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

#include "GameObjectAI.h"
#include "GameObjectScript.h"
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

void AddSC_transport_zeppelins()
{
    RegisterGameObjectAI(go_transport_the_iron_eagle);
    RegisterGameObjectAI(go_transport_the_thundercaller);
    RegisterGameObjectAI(go_transport_the_purple_princess);
}
