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
#include "nexus.h"

enum Spells
{
    SPELL_BATTLE_SHOUT              = 31403,
    SPELL_CHARGE                    = 60067,
    SPELL_FRIGHTENING_SHOUT         = 19134,
    SPELL_WHIRLWIND                 = 38618
};

enum Says
{
    SAY_AGGRO                       = 0,
    SAY_DEATH                       = 1,
    SAY_KILL                        = 2
};

struct boss_commander_stoutbeard : public BossAI
{
    boss_commander_stoutbeard(Creature* creature) : BossAI(creature, DATA_COMMANDER_EVENT) { }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);

        me->RemoveAllAuras();

        ScheduleTimedEvent(1s, [&]
        {
            DoCastSelf(SPELL_BATTLE_SHOUT, true);
        }, 2min);

        ScheduleTimedEvent(10s, [&]
        {
            DoCastVictim(SPELL_FRIGHTENING_SHOUT);
        }, 15s, 20s);

        ScheduleTimedEvent(15s, [&]
        {
            DoCastAOE(SPELL_WHIRLWIND);
        }, 16s);

        ScheduleTimedEvent(1s, [&]
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::MinDistance, 0, 25.0f))
                DoCast(target, SPELL_CHARGE);
        }, 20s);
    }

    void KilledUnit(Unit*) override
    {
        Talk(SAY_KILL);
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }
};

void AddSC_boss_commander_stoutbeard()
{
    RegisterNexusCreatureAI(boss_commander_stoutbeard);
}
