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
#include "ScriptedCreature.h"

// 2784 - King Magni Bronzebeard
enum KingMagniBronzebeard
{
    SOUND_AGGRO      = 5896,
    SPELL_AVATAR     = 19135,
    SPELL_KNOCK_AWAY = 20686,
    SPELL_STORM_BOLT = 20685
};

struct npc_king_magni_bronzebeard : public ScriptedAI
{
    npc_king_magni_bronzebeard(Creature* creature) : ScriptedAI(creature) { }

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->PlayDirectSound(SOUND_AGGRO);

        ScheduleTimedEvent(5s, 7s, [&]
        {
            DoCastSelf(SPELL_AVATAR);
        }, 25s, 30s);

        ScheduleTimedEvent(8s, 10s, [&]
        {
            DoCastVictim(SPELL_KNOCK_AWAY);
        }, 20s, 30s);

        ScheduleTimedEvent(12s, 15s, [&]
        {
            DoCastRandomTarget(SPELL_STORM_BOLT);
        }, 15s, 20s);
    }

    void JustDied(Unit* /*killer*/) override
    {
        DoRewardPlayersInArea();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }

};

void AddSC_ironforge()
{
    RegisterCreatureAI(npc_king_magni_bronzebeard);
}
