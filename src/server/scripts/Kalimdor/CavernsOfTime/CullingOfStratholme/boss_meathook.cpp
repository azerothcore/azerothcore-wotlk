/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "culling_of_stratholme.h"
#include "SpellScript.h"

enum Spells
{
    SPELL_CONSTRICTING_CHAINS_N                 = 52696,
    SPELL_CONSTRICTING_CHAINS_H                 = 58823,
    SPELL_DISEASE_EXPULSION_N                   = 52666,
    SPELL_DISEASE_EXPULSION_H                   = 58824,
    SPELL_FRENZY                                = 58841,
};

enum Events
{
    EVENT_SPELL_CONSTRICTING_CHAINS             = 1,
    EVENT_SPELL_DISEASE_EXPULSION               = 2,
    EVENT_SPELL_FRENZY                          = 3,
};

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_SLAY                                    = 1,
    SAY_SPAWN                                   = 2,
    SAY_DEATH                                   = 3
};

class boss_meathook : public CreatureScript
{
public:
    boss_meathook() : CreatureScript("boss_meathook") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_meathookAI>(creature);
    }

    struct boss_meathookAI : public npc_escortAI
    {
        boss_meathookAI(Creature* c) : npc_escortAI(c)
        {
            Talk(SAY_SPAWN);

            AddWaypoint(1, 2349.07f, 1181.84f, 130.416f, 0);
            AddWaypoint(2, 2240.9f, 1173.33f, 137.171f, 0);
            AddWaypoint(3, 2171.15f, 1251.85f, 135.168f, 0);
            AddWaypoint(4, 2180.95f, 1329.96f, 129.991f, 0);
            AddWaypoint(5, 2219.12f, 1331.17f, 128.11f, 0);
            AddWaypoint(6, 2139.14f, 1351.94f, 132.072f, 0);
            AddWaypoint(7, 2186.49f, 1335.78f, 130.049f, 0);
            AddWaypoint(8, 2170.9f, 1255.13f, 134.816f, 0);
            AddWaypoint(9, 2245.52f, 1169.46f, 137.59f, 0);
            AddWaypoint(10, 2325.94f, 1176.1f, 132.979f, 0);
            AddWaypoint(11, 2351.52f, 1197.95f, 130.444f, 0);

            Start(true, false, 0, NULL, false, true);
        }

        EventMap events;
        void Reset() { events.Reset(); }

        void WaypointReached(uint32 id) { }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);
            events.RescheduleEvent(EVENT_SPELL_CONSTRICTING_CHAINS, 15000);
            events.RescheduleEvent(EVENT_SPELL_DISEASE_EXPULSION, 4000);
            events.RescheduleEvent(EVENT_SPELL_FRENZY, 20000);
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

        void UpdateEscortAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_SPELL_DISEASE_EXPULSION:
                    me->CastSpell(me, DUNGEON_MODE(SPELL_DISEASE_EXPULSION_N, SPELL_DISEASE_EXPULSION_H), false);
                    events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_FRENZY:
                    me->CastSpell(me, SPELL_FRENZY, false);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_SPELL_CONSTRICTING_CHAINS:
                    if (Unit *pTarget = SelectTarget(SELECT_TARGET_BOTTOMAGGRO, 0, 50.0f, true))
                        me->CastSpell(pTarget, DUNGEON_MODE(SPELL_CONSTRICTING_CHAINS_N, SPELL_CONSTRICTING_CHAINS_H), false);
                    events.RepeatEvent(14000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

};

void AddSC_boss_meathook()
{
    new boss_meathook();
}
