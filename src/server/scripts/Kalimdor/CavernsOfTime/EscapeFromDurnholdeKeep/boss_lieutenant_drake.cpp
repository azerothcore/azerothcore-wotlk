/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "old_hillsbrad.h"
#include "MoveSplineInit.h"
#include "SmartScriptMgr.h"

enum LieutenantDrake
{
    SAY_ENTER               = 0,
    SAY_AGGRO               = 1,
    SAY_SLAY                = 2,
    SAY_MORTAL              = 3,
    SAY_SHOUT               = 4,
    SAY_DEATH               = 5,

    SPELL_WHIRLWIND         = 31909,
    SPELL_EXPLODING_SHOT    = 33792,
    SPELL_HAMSTRING         = 9080,
    SPELL_MORTAL_STRIKE     = 31911,
    SPELL_FRIGHTENING_SHOUT = 33789,

    EVENT_WHIRLWIND         = 1,
    EVENT_FRIGHTENING_SHOUT = 2,
    EVENT_MORTAL_STRIKE     = 3,
    EVENT_HAMSTRING         = 4,
    EVENT_EXPLODING_SHOT    = 5
};

class boss_lieutenant_drake : public CreatureScript
{
public:
    boss_lieutenant_drake() : CreatureScript("boss_lieutenant_drake") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_lieutenant_drakeAI(creature);
    }

    struct boss_lieutenant_drakeAI : public ScriptedAI
    {
        boss_lieutenant_drakeAI(Creature* creature) : ScriptedAI(creature)
        {
            pathPoints.clear();
            WPPath* path = sSmartWaypointMgr->GetPath(me->GetEntry());
            if (!path || path->empty())
                return;

            pathPoints.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));

            uint32 wpCounter = 1;
            WPPath::const_iterator itr;
            while ((itr = path->find(wpCounter++)) != path->end())
            {
                WayPoint* wp = itr->second;
                pathPoints.push_back(G3D::Vector3(wp->x, wp->y, wp->z));
            }
        }

        void InitializeAI()
        {
            ScriptedAI::InitializeAI();
            //Talk(SAY_ENTER);
            JustReachedHome();
        }

        void JustReachedHome()
        {
            me->SetWalk(true);
            Movement::MoveSplineInit init(me);
            init.MovebyPath(pathPoints);
            init.SetCyclic();
            init.Launch();
        }

        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_WHIRLWIND, 4000);
            events.ScheduleEvent(EVENT_FRIGHTENING_SHOUT, 14000);
            events.ScheduleEvent(EVENT_MORTAL_STRIKE, 9000);
            events.ScheduleEvent(EVENT_HAMSTRING, 18000);
            events.ScheduleEvent(EVENT_EXPLODING_SHOT, 1000);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            if (InstanceScript* instance = me->GetInstanceScript())
                instance->SetData(DATA_ESCORT_PROGRESS, ENCOUNTER_PROGRESS_DRAKE_KILLED);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_WHIRLWIND:
                    me->CastSpell(me, SPELL_WHIRLWIND, false);
                    events.ScheduleEvent(EVENT_WHIRLWIND, 25000);
                    break;
                case EVENT_EXPLODING_SHOT:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 40.0f))
                        me->CastSpell(target, SPELL_EXPLODING_SHOT, false);
                    events.ScheduleEvent(EVENT_EXPLODING_SHOT, 25000);
                    break;
                case EVENT_MORTAL_STRIKE:
                    if (roll_chance_i(40))
                        Talk(SAY_MORTAL);
                    me->CastSpell(me->GetVictim(), SPELL_MORTAL_STRIKE, false);
                    events.ScheduleEvent(EVENT_MORTAL_STRIKE, 10000);
                    break;
                case EVENT_FRIGHTENING_SHOUT:
                    if (roll_chance_i(40))
                        Talk(SAY_SHOUT);
                    me->CastSpell(me, SPELL_FRIGHTENING_SHOUT, false);
                    events.ScheduleEvent(EVENT_FRIGHTENING_SHOUT, 25000);
                    break;
                case EVENT_HAMSTRING:
                    me->CastSpell(me->GetVictim(), SPELL_HAMSTRING, false);
                    events.ScheduleEvent(EVENT_HAMSTRING, 25000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        private:
            EventMap events;
            Movement::PointsArray pathPoints;
    };

};

void AddSC_boss_lieutenant_drake()
{
    new boss_lieutenant_drake();
}
