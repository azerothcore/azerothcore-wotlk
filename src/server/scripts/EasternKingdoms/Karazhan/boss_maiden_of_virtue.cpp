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
#include "ScriptedCreature.h"
#include "karazhan.h"

enum Text
{
    SAY_AGGRO           = 0,
    SAY_SLAY            = 1,
    SAY_REPENTANCE      = 2,
    SAY_DEATH           = 3
};

enum Spells
{
    SPELL_REPENTANCE    = 29511,
    SPELL_HOLY_FIRE     = 29522,
    SPELL_HOLY_WRATH    = 32445,
    SPELL_HOLY_GROUND   = 29523,
    SPELL_BERSERK       = 26662
};

struct boss_maiden_of_virtue : public BossAI
{
    boss_maiden_of_virtue(Creature* creature) : BossAI(creature, DATA_MAIDEN)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        DoCastAOE(SPELL_HOLY_GROUND, true);
        scheduler.Schedule(25s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_REPENTANCE);
            Talk(SAY_REPENTANCE);
            context.Repeat(25s, 35s);
        }).Schedule(8s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_HOLY_FIRE, 0, 50.0f);
            context.Repeat(8s, 18s);
        }).Schedule(15s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_HOLY_WRATH, 0, 80.0f);
            context.Repeat(20s, 25s);
        }).Schedule(10min, [this](TaskContext /*context*/)
        {
            DoCastSelf(SPELL_BERSERK, true);
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }
};

void AddSC_boss_maiden_of_virtue()
{
    RegisterKarazhanCreatureAI(boss_maiden_of_virtue);
}
