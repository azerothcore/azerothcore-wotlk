/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "culling_of_stratholme.h"
#include "SpellInfo.h"

enum Spells
{
    SPELL_CURSE_OF_EXERTION                     = 52772,
    SPELL_WOUNDING_STRIKE_N                     = 52771,
    SPELL_WOUNDING_STRIKE_H                     = 58830,
    SPELL_TIME_STOP                             = 58848,
    SPELL_TIME_WARP                             = 52766,
    SPELL_TIME_STEP_N                           = 52737,
    SPELL_TIME_STEP_H                           = 58829,
};

enum Events
{
    EVENT_SPELL_CURSE_OF_EXERTION               = 1,
    EVENT_SPELL_WOUNDING_STRIKE                 = 2,
    EVENT_SPELL_TIME_STOP                       = 3,
    EVENT_SPELL_TIME_WARP                       = 4,
    EVENT_TIME_WARP                             = 5,
};

enum Yells
{
    SAY_INTRO                                   = 0,
    SAY_AGGRO                                   = 1,
    SAY_TIME_WARP                               = 2,
    SAY_SLAY                                    = 3,
    SAY_DEATH                                   = 4
};

class boss_epoch : public CreatureScript
{
public:
    boss_epoch() : CreatureScript("boss_epoch") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_epochAI (creature);
    }

    struct boss_epochAI : public ScriptedAI
    {
        boss_epochAI(Creature* c) : ScriptedAI(c)
        {
        }

        EventMap events;
        uint8 warps;
        void Reset()
        {
            events.Reset();
            warps = 0;
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_SPELL_CURSE_OF_EXERTION, 9000);
            events.ScheduleEvent(EVENT_SPELL_WOUNDING_STRIKE, 3000);
            events.ScheduleEvent(EVENT_SPELL_TIME_WARP, 25000);

            if (IsHeroic())
                events.ScheduleEvent(EVENT_SPELL_TIME_STOP, 20000);
        }

        void SpellHitTarget(Unit* target, const SpellInfo* spellInfo)
        {
            if (spellInfo->Id == SPELL_TIME_STEP_H || spellInfo->Id == SPELL_TIME_STEP_N)
            {
                if (target == me)
                    return;

                if (warps >= 2)
                {
                    warps = 0;
                    return;
                }
                warps++;
                me->CastSpell(target, DUNGEON_MODE(SPELL_TIME_STEP_N, SPELL_TIME_STEP_H), true);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_SPELL_CURSE_OF_EXERTION:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true))
                        me->CastSpell(target, SPELL_CURSE_OF_EXERTION, false);
                    events.RepeatEvent(9000);
                    break;
                case EVENT_SPELL_WOUNDING_STRIKE:
                    me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_WOUNDING_STRIKE_N, SPELL_WOUNDING_STRIKE_H), false);
                    events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_TIME_STOP:
                    me->CastSpell(me, SPELL_TIME_STOP, false);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_SPELL_TIME_WARP:
                    Talk(SAY_TIME_WARP);
                    me->CastSpell(me, SPELL_TIME_WARP, false);
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true))
                        me->CastSpell(target, DUNGEON_MODE(SPELL_TIME_STEP_N, SPELL_TIME_STEP_H), true);

                    events.RepeatEvent(25000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
        }

        void KilledUnit(Unit*  /*victim*/)
        {
            if (!urand(0,1))
                return;

            Talk(SAY_SLAY);
        }
    };

};

void AddSC_boss_epoch()
{
    new boss_epoch();
}
