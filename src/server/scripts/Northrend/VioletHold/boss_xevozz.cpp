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
    //SPELL_SUMMON_PLAYERS                      = 54164, // not used
    //SPELL_POWER_BALL_VISUAL                   = 54141,
};

enum eEvents
{
    EVENT_SPELL_ARCANE_BARRAGE_VOLLEY = 1,
    EVENT_SPELL_ARCANE_BUFFET,
    EVENT_SUMMON_SPHERES,
    EVENT_CHECK_DISTANCE,
};

class boss_xevozz : public CreatureScript
{
public:
    boss_xevozz() : CreatureScript("boss_xevozz") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetVioletHoldAI<boss_xevozzAI>(pCreature);
    }

    struct boss_xevozzAI : public ScriptedAI
    {
        boss_xevozzAI(Creature* c) : ScriptedAI(c), spheres(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList spheres;

        void Reset() override
        {
            events.Reset();
            spheres.DespawnAll();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
            DoZoneInCombat();
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_ARCANE_BARRAGE_VOLLEY, 16s, 20s);
            events.RescheduleEvent(EVENT_SUMMON_SPHERES, 10s);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_ARCANE_BARRAGE_VOLLEY:
                    me->CastSpell((Unit*)nullptr, SPELL_ARCANE_BARRAGE_VOLLEY, false);
                    events.Repeat(20s);
                    break;
                case EVENT_SPELL_ARCANE_BUFFET:
                    me->CastSpell(me->GetVictim(), SPELL_ARCANE_BUFFET, false);
                    break;
                case EVENT_SUMMON_SPHERES:
                    {
                        Talk(SAY_SUMMON_ENERGY);
                        spheres.DespawnAll();
                        uint32 entry1 = RAND(SPELL_SUMMON_ETHEREAL_SPHERE_1, SPELL_SUMMON_ETHEREAL_SPHERE_2, SPELL_SUMMON_ETHEREAL_SPHERE_3);
                        me->CastSpell((Unit*)nullptr, entry1, true);
                        if (IsHeroic())
                        {
                            uint32 entry2;
                            do { entry2 = RAND(SPELL_SUMMON_ETHEREAL_SPHERE_1, SPELL_SUMMON_ETHEREAL_SPHERE_2, SPELL_SUMMON_ETHEREAL_SPHERE_3); }
                            while (entry1 == entry2);
                            me->CastSpell((Unit*)nullptr, entry2, true);
                        }
                        events.RepeatEvent(45000);
                        events.RescheduleEvent(EVENT_SPELL_ARCANE_BUFFET, 5s);
                        events.RescheduleEvent(EVENT_CHECK_DISTANCE, 6s);
                    }
                    break;
                case EVENT_CHECK_DISTANCE:
                    {
                        bool found = false;
                        if (pInstance)
                            for (ObjectGuid const& guid : spheres)
                                if (Creature* c = pInstance->instance->GetCreature(guid))
                                    if (me->GetDistance(c) < 3.0f)
                                    {
                                        c->CastSpell(me, SPELL_ARCANE_POWER, false);
                                        c->DespawnOrUnsummon(8000);
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

            DoMeleeAttackIfReady();
        }

        void JustSummoned(Creature* pSummoned) override
        {
            if (pSummoned)
            {
                pSummoned->GetMotionMaster()->MoveFollow(me, 0.0f, 0.0f);
                pSummoned->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                spheres.Summon(pSummoned);
                if (pInstance)
                    pInstance->SetGuidData(DATA_ADD_TRASH_MOB, pSummoned->GetGUID());
            }
        }

        void SummonedCreatureDespawn(Creature* pSummoned) override
        {
            if (pSummoned)
            {
                spheres.Despawn(pSummoned);
                if (pInstance)
                    pInstance->SetGuidData(DATA_DELETE_TRASH_MOB, pSummoned->GetGUID());
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            spheres.DespawnAll();
            if (pInstance)
                pInstance->SetData(DATA_BOSS_DIED, 0);
        }

        void KilledUnit(Unit* pVictim) override
        {
            if (pVictim && pVictim->GetGUID() == me->GetGUID())
                return;

            Talk(SAY_SLAY);
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}

        void EnterEvadeMode(EvadeReason why) override
        {
            ScriptedAI::EnterEvadeMode(why);
            events.Reset();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            if (pInstance)
                pInstance->SetData(DATA_FAILED, 1);
        }
    };
};

void AddSC_boss_xevozz()
{
    new boss_xevozz();
}
