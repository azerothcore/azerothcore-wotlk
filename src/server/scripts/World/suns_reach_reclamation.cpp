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
#include "WorldState.h"

class npc_suns_reach_reclamation : public CreatureScript
{
public:
    npc_suns_reach_reclamation() : CreatureScript("npc_suns_reach_reclamation") { }

    bool OnQuestReward(Player* /*player*/, Creature* /*creature*/, const Quest* quest, uint32 /*slot*/) override
    {
        sWorldState->AddSunsReachProgress(quest->GetQuestId());
        return true;
    }
};

class npc_sunwell_gate : public CreatureScript
{
public:
    npc_sunwell_gate() : CreatureScript("npc_sunwell_gate") { }

    bool OnQuestReward(Player* /*player*/, Creature* /*creature*/, const Quest* quest, uint32 /*slot*/) override
    {
        sWorldState->AddSunwellGateProgress(quest->GetQuestId());
        return true;
    }
};

void AddSC_suns_reach_reclamation()
{
    new npc_suns_reach_reclamation();
    new npc_sunwell_gate();
}
