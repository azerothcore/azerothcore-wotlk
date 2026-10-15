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

#include "trial_of_the_crusader.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"

enum BarrettMenus
{
    MENU_NORTHREND_BEASTS_START         = 10600,
    MENU_JARAXXUS_START                 = 10610,
    MENU_FACTION_CHAMPIONS_START        = 10687,
    MENU_VALKYR_START                   = 10688,
    MENU_LICH_KING_START                = 10693,
};

struct npc_barrett_toc : public ScriptedAI
{
    npc_barrett_toc(Creature* creature) : ScriptedAI(creature) { }

    void sGossipSelect(Player* player, uint32 menuId, uint32 /*gossipListId*/) override
    {
        switch (menuId)
        {
            case MENU_NORTHREND_BEASTS_START:
            case MENU_JARAXXUS_START:
            case MENU_FACTION_CHAMPIONS_START:
            case MENU_VALKYR_START:
            case MENU_LICH_KING_START:
                break;
            default:
                return;
        }

        CloseGossipMenuFor(player);

        if (!me->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
            return;

        if (InstanceScript* instance = me->GetInstanceScript())
            instance->SetData(TYPE_ANNOUNCER_GOSSIP_SELECT, 0);

        Leave();
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_BARRETT_LEAVE && me->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
            Leave();
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE && id == POINT_BARRETT_EXIT)
            me->DespawnOrUnsummon();
    }

private:
    void Leave()
    {
        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->GetMotionMaster()->MovePoint(POINT_BARRETT_EXIT, Locs[LOC_BARRETT_EXIT]);
    }
};

void AddSC_trial_of_the_crusader()
{
    RegisterTrialOfTheCrusaderCreatureAI(npc_barrett_toc);
}
