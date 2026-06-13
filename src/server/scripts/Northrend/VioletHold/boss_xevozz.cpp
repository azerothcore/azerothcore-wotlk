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

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_SLAY                                    = 1,
    SAY_DEATH                                   = 2,
    SAY_SPAWN                                   = 3,
    SAY_CHARGED                                 = 4,
    SAY_REPEAT_SUMMON                           = 5,
    SAY_SUMMON_ENERGY                           = 6
};

enum eSpells
{
    SPELL_ARCANE_BARRAGE_VOLLEY                 = 54202,
    SPELL_ARCANE_BUFFET                         = 54226,
    SPELL_SUMMON_ETHEREAL_SPHERE_1              = 54102,
    SPELL_SUMMON_ETHEREAL_SPHERE_2              = 54137,
    SPELL_SUMMON_ETHEREAL_SPHERE_3              = 54138,

    SPELL_ARCANE_POWER                          = 54160
};

enum eEvents
{
    EVENT_SPELL_ARCANE_BARRAGE_VOLLEY = 1,
    EVENT_SPELL_ARCANE_BUFFET,
    EVENT_SUMMON_SPHERES,
    EVENT_CHECK_DISTANCE,
};

struct boss_xevozz : public BossAI
{
    boss_xevozz(Creature* c) : BossAI(c, BOSS_XEVOZZ) { }

    void JustEngagedWith(Unit* who) override
    {
        Talk(SAY_AGGRO);
        BossAI::JustEngagedWith(who);
        events.RescheduleEvent(EVENT_SPELL_ARCANE_BARRAGE_VOLLEY, 16s, 20s);
        events.RescheduleEvent(EVENT_SUMMON_SPHERES, 10s);
    }

    void ExecuteEvent(uint32 eventId) override
    {
        switch (eventId)
        {
            case EVENT_SPELL_ARCANE_BARRAGE_VOLLEY:
                DoCastAOE(SPELL_ARCANE_BARRAGE_VOLLEY);
                events.Repeat(20s);
                break;
            case EVENT_SPELL_ARCANE_BUFFET:
                DoCastVictim(SPELL_ARCANE_BUFFET);
                break;
            case EVENT_SUMMON_SPHERES:
                {
                    Talk(SAY_SUMMON_ENERGY);
                    summons.DespawnAll();
                    uint32 entry1 = RAND(SPELL_SUMMON_ETHEREAL_SPHERE_1, SPELL_SUMMON_ETHEREAL_SPHERE_2, SPELL_SUMMON_ETHEREAL_SPHERE_3);
                    DoCastAOE(entry1, true);
                    if (IsHeroic())
                    {
                        uint32 entry2;
                        do { entry2 = RAND(SPELL_SUMMON_ETHEREAL_SPHERE_1, SPELL_SUMMON_ETHEREAL_SPHERE_2, SPELL_SUMMON_ETHEREAL_SPHERE_3); }
                        while (entry1 == entry2);
                        DoCastAOE(entry2, true);
                    }
                    events.Repeat(45s);
                    events.RescheduleEvent(EVENT_SPELL_ARCANE_BUFFET, 5s);
                    events.RescheduleEvent(EVENT_CHECK_DISTANCE, 6s);
                }
                break;
            case EVENT_CHECK_DISTANCE:
                {
                    bool found = false;
                    for (ObjectGuid const& guid : summons)
                        if (Creature* sphere = instance->instance->GetCreature(guid))
                            if (me->GetDistance(sphere) < 3.0f)
                            {
                                sphere->CastSpell(me, SPELL_ARCANE_POWER, false);
                                sphere->DespawnOrUnsummon(8s);
                                found = true;
                            }
                    if (found)
                    {
                        Talk(SAY_CHARGED);
                        events.Repeat(9s);
                        events.RescheduleEvent(EVENT_SUMMON_SPHERES, 10s);
                    }
                    else
                        events.Repeat(2s);
                }
                break;
        }
    }

    void JustSummoned(Creature* summoned) override
    {
        if (summoned)
        {
            summoned->GetMotionMaster()->MoveFollow(me, 0.0f, 0.0f, MOTION_SLOT_ACTIVE, true, false);
            BossAI::JustSummoned(summoned);
            instance->SetGuidData(DATA_ADD_TRASH_MOB, summoned->GetGUID());
        }
    }

    void SummonedCreatureDespawn(Creature* summoned) override
    {
        if (summoned)
        {
            BossAI::SummonedCreatureDespawn(summoned);
            instance->SetGuidData(DATA_DELETE_TRASH_MOB, summoned->GetGUID());
        }
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim && victim->GetGUID() == me->GetGUID())
            return;

        Talk(SAY_SLAY);
    }

    void MoveInLineOfSight(Unit* /*who*/) override {}

    void EnterEvadeMode(EvadeReason why) override
    {
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        _EnterEvadeMode(why);
    }
};

void AddSC_boss_xevozz()
{
    RegisterVioletHoldCreatureAI(boss_xevozz);
}
