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
#include "mechanar.h"

enum Says
{
    SAY_AGGRO                      = 0,
    SAY_HAMMER                     = 1,
    SAY_SLAY                       = 2,
    SAY_DEATH                      = 3,
    EMOTE_HAMMER                   = 4
};

enum Spells
{
    SPELL_SHADOW_POWER             = 35322,
    SPELL_JACKHAMMER               = 35327,
    SPELL_STREAM_OF_MACHINE_FLUID  = 35311
};

struct boss_gatewatcher_iron_hand : public BossAI
{
    boss_gatewatcher_iron_hand(Creature* creature) : BossAI(creature, DATA_GATEWATCHER_IRON_HAND) { }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();

        scheduler.Schedule(15s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_STREAM_OF_MACHINE_FLUID);
            context.Repeat(20s);
        }).Schedule(35s, [this](TaskContext context)
        {
            Talk(EMOTE_HAMMER);
            Talk(SAY_HAMMER);
            DoCastSelf(SPELL_JACKHAMMER);
            context.Repeat(40s);
        }).Schedule(25s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_SHADOW_POWER);
            context.Repeat(25s);
        });

        Talk(SAY_AGGRO);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }
};

void AddSC_boss_gatewatcher_iron_hand()
{
    RegisterMechanarCreatureAI(boss_gatewatcher_iron_hand);
}
