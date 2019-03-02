/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "the_eye.h"

enum voidReaver
{
    SAY_AGGRO                   = 0,
    SAY_SLAY                    = 1,
    SAY_DEATH                   = 2,
    SAY_POUNDING                = 3,

    SPELL_POUNDING              = 34162,
    SPELL_ARCANE_ORB            = 34172,
    SPELL_KNOCK_AWAY            = 25778,
    SPELL_BERSERK               = 26662,

    EVENT_SPELL_POUNDING        = 1,
    EVENT_SPELL_ARCANEORB       = 2,
    EVENT_SPELL_KNOCK_AWAY      = 3,
    EVENT_SPELL_BERSERK         = 4
};

class boss_void_reaver : public CreatureScript
{
    public:

        boss_void_reaver() : CreatureScript("boss_void_reaver") { }

        struct boss_void_reaverAI : public BossAI
        {
            boss_void_reaverAI(Creature* creature) : BossAI(creature, DATA_REAVER)
            {
                me->ApplySpellImmune(0, IMMUNITY_DISPEL, DISPEL_POISON, true);
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_HEALTH_LEECH, true);
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_POWER_DRAIN, true);
                me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_PERIODIC_LEECH, true);
                me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_PERIODIC_MANA_LEECH, true);
            }

            void Reset()
            {
                BossAI::Reset();
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER && roll_chance_i(50))
                    Talk(SAY_SLAY);
            }

            void JustDied(Unit* killer)
            {
                Talk(SAY_DEATH);
                BossAI::JustDied(killer);
            }

            void EnterCombat(Unit* who)
            {
                Talk(SAY_AGGRO);
                BossAI::EnterCombat(who);

                events.ScheduleEvent(EVENT_SPELL_POUNDING, 15000);
                events.ScheduleEvent(EVENT_SPELL_ARCANEORB, 3000);
                events.ScheduleEvent(EVENT_SPELL_KNOCK_AWAY, 30000);
                events.ScheduleEvent(EVENT_SPELL_BERSERK, 600000);
                me->CallForHelp(105.0f);
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
                    case EVENT_SPELL_BERSERK:
                        me->CastSpell(me, SPELL_BERSERK, true);
                        break;
                    case EVENT_SPELL_POUNDING:
                        Talk(SAY_POUNDING);
                        me->CastSpell(me, SPELL_POUNDING, false);
                        events.ScheduleEvent(EVENT_SPELL_POUNDING, 15000);
                        break;
                    case EVENT_SPELL_ARCANEORB:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, -18.0f, true))
                            me->CastSpell(target, SPELL_ARCANE_ORB, false);
                        else if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 20.0f, true))
                            me->CastSpell(target, SPELL_ARCANE_ORB, false);
                        events.ScheduleEvent(EVENT_SPELL_ARCANEORB, 4000);
                        break;
                    case EVENT_SPELL_KNOCK_AWAY:
                        me->CastSpell(me->GetVictim(), SPELL_KNOCK_AWAY, false);
                        events.ScheduleEvent(EVENT_SPELL_POUNDING, 25000);
                        break;
                }

                DoMeleeAttackIfReady();
                EnterEvadeIfOutOfCombatArea();
            }
                    
            bool CheckEvadeIfOutOfCombatArea() const
            {
                return me->GetDistance2d(432.59f, 371.93f) > 105.0f;
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_void_reaverAI>(creature);
        }
};

void AddSC_boss_void_reaver()
{
    new boss_void_reaver();
}

