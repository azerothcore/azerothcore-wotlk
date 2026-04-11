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
#include "violet_hold.h"

enum eSpells
{
    SPELL_CAUTERIZING_FLAMES                  = 59466,
    SPELL_FIREBOLT                            = 54235,
    SPELL_FLAME_BREATH                        = 54282,
    SPELL_LAVA_BURN                           = 54249
};

enum eEvents
{
    EVENT_SPELL_FIREBOLT = 1,
    EVENT_SPELL_FLAME_BREATH,
    EVENT_SPELL_LAVA_BURN,
    EVENT_SPELL_CAUTERIZING_FLAMES,
};

struct boss_lavanthor : public BossAI
{
    boss_lavanthor(Creature* c) : BossAI(c, BOSS_LAVANTHOR) { }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        events.RescheduleEvent(EVENT_SPELL_FIREBOLT, 1s);
        events.RescheduleEvent(EVENT_SPELL_FLAME_BREATH, 5s);
        events.RescheduleEvent(EVENT_SPELL_LAVA_BURN, 10s);
        if (IsHeroic())
            events.RescheduleEvent(EVENT_SPELL_CAUTERIZING_FLAMES, 3s);
    }

    void ExecuteEvent(uint32 eventId) override
    {
        switch (eventId)
        {
            case EVENT_SPELL_FIREBOLT:
                DoCastVictim(SPELL_FIREBOLT);
                events.Repeat(5s, 13s);
                break;
            case EVENT_SPELL_FLAME_BREATH:
                DoCastVictim(SPELL_FLAME_BREATH);
                events.Repeat(10s, 15s);
                break;
            case EVENT_SPELL_LAVA_BURN:
                DoCastVictim(SPELL_LAVA_BURN);
                events.Repeat(14s, 20s);
                break;
            case EVENT_SPELL_CAUTERIZING_FLAMES:
                DoCastAOE(SPELL_CAUTERIZING_FLAMES);
                events.Repeat(10s, 16s);
                break;
        }
    }

    void MoveInLineOfSight(Unit* /*who*/) override {}

    void EnterEvadeMode(EvadeReason why) override
    {
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        _EnterEvadeMode(why);
    }
};

void AddSC_boss_lavanthor()
{
    RegisterVioletHoldCreatureAI(boss_lavanthor);
}
