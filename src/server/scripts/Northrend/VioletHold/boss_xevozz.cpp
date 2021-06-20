/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
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
    SPELL_ARCANE_BARRAGE_VOLLEY_N               = 54202,
    SPELL_ARCANE_BARRAGE_VOLLEY_H               = 59483,
    SPELL_ARCANE_BUFFET_N                       = 54226,
    SPELL_ARCANE_BUFFET_H                       = 59485,
    SPELL_SUMMON_ETHEREAL_SPHERE_1              = 54102,
    SPELL_SUMMON_ETHEREAL_SPHERE_2              = 54137,
    SPELL_SUMMON_ETHEREAL_SPHERE_3              = 54138,

    SPELL_ARCANE_POWER_N                        = 54160,
    SPELL_ARCANE_POWER_H                        = 59474,
    //SPELL_SUMMON_PLAYERS                      = 54164, // not used
    //SPELL_POWER_BALL_VISUAL                   = 54141,
};

#define SPELL_ARCANE_BARRAGE_VOLLEY             DUNGEON_MODE(SPELL_ARCANE_BARRAGE_VOLLEY_N, SPELL_ARCANE_BARRAGE_VOLLEY_H)
#define SPELL_ARCANE_BUFFET                     DUNGEON_MODE(SPELL_ARCANE_BUFFET_N, SPELL_ARCANE_BUFFET_H)
#define SPELL_ARCANE_POWER                      DUNGEON_MODE(SPELL_ARCANE_POWER_N, SPELL_ARCANE_POWER_H)

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

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_xevozzAI (pCreature);
    }

    struct boss_xevozzAI : public ScriptedAI
    {
        boss_xevozzAI(Creature *c) : ScriptedAI(c), spheres(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList spheres;

        void Reset()
        {
            events.Reset();
            spheres.DespawnAll();
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);
            DoZoneInCombat();
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_ARCANE_BARRAGE_VOLLEY, urand(16000,20000));
            events.RescheduleEvent(EVENT_SUMMON_SPHERES, 10000);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_ARCANE_BARRAGE_VOLLEY:
                    me->CastSpell((Unit*)NULL, SPELL_ARCANE_BARRAGE_VOLLEY, false);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_SPELL_ARCANE_BUFFET:
                    me->CastSpell(me->GetVictim(), SPELL_ARCANE_BUFFET, false);
                    events.PopEvent();
                    break;
                case EVENT_SUMMON_SPHERES:
                    {
                        Talk(SAY_SUMMON_ENERGY);
                        spheres.DespawnAll();
                        uint32 entry1 = RAND(SPELL_SUMMON_ETHEREAL_SPHERE_1, SPELL_SUMMON_ETHEREAL_SPHERE_2, SPELL_SUMMON_ETHEREAL_SPHERE_3);
                        me->CastSpell((Unit*)NULL, entry1, true);
                        if (IsHeroic())
                        {
                            uint32 entry2;
                            do { entry2 = RAND(SPELL_SUMMON_ETHEREAL_SPHERE_1, SPELL_SUMMON_ETHEREAL_SPHERE_2, SPELL_SUMMON_ETHEREAL_SPHERE_3); } while (entry1 == entry2);
                            me->CastSpell((Unit*)NULL, entry2, true);
                        }
                        events.RepeatEvent(45000);
                        events.RescheduleEvent(EVENT_SPELL_ARCANE_BUFFET, 5000);
                        events.RescheduleEvent(EVENT_CHECK_DISTANCE, 6000);
                    }
                    break;
                case EVENT_CHECK_DISTANCE:
                    {
                        bool found = false;
                        if (pInstance)
                            for (std::list<uint64>::iterator itr = spheres.begin(); itr != spheres.end(); ++itr)
                                if (Creature* c = pInstance->instance->GetCreature(*itr))
                                    if (me->GetDistance(c) < 3.0f)
                                    {
                                        c->CastSpell(me, SPELL_ARCANE_POWER, false);
                                        c->DespawnOrUnsummon(8000);
                                        found = true;
                                    }
                        if (found)
                        {
                            Talk(SAY_CHARGED);
                            events.RepeatEvent(9000);
                            events.RescheduleEvent(EVENT_SUMMON_SPHERES, 10000);
                        }
                        else
                            events.RepeatEvent(2000);
                    }
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustSummoned(Creature* pSummoned)
        {
            if (pSummoned)
            {
                pSummoned->GetMotionMaster()->MoveFollow(me, 0.0f, 0.0f);
                pSummoned->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                spheres.Summon(pSummoned);
                if (pInstance)
                    pInstance->SetData64(DATA_ADD_TRASH_MOB, pSummoned->GetGUID());
            }
        }

        void SummonedCreatureDespawn(Creature *pSummoned)
        {
            if (pSummoned)
            {
                spheres.Despawn(pSummoned);
                if (pInstance)
                    pInstance->SetData64(DATA_DELETE_TRASH_MOB, pSummoned->GetGUID());
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            spheres.DespawnAll();
            if (pInstance)
                pInstance->SetData(DATA_BOSS_DIED, 0);
        }

        void KilledUnit(Unit* pVictim)
        {
            if (pVictim && pVictim->GetGUID() == me->GetGUID())
                return;

            Talk(SAY_SLAY);
        }

        void MoveInLineOfSight(Unit* /*who*/) {}

        void EnterEvadeMode()
        {
            ScriptedAI::EnterEvadeMode();
            events.Reset();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            if (pInstance)
                pInstance->SetData(DATA_FAILED, 1);
        }
    };
};

void AddSC_boss_xevozz()
{
    new boss_xevozz();
}
