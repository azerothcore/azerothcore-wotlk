/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "the_botanica.h"

enum Says
{
    SAY_AGGRO                   = 0,
    SAY_KILL                    = 1,
    SAY_TREE                    = 2,
    SAY_SUMMON                  = 3,
    SAY_DEATH                   = 4,
    SAY_OOC_RANDOM              = 5
};

enum Spells
{
    SPELL_TRANQUILITY           = 34550,
    SPELL_TREE_FORM             = 34551,
    SPELL_SUMMON_FRAYER         = 34557,
    SPELL_PLANT_WHITE           = 34759,
    SPELL_PLANT_GREEN           = 34761,
    SPELL_PLANT_BLUE            = 34762,
    SPELL_PLANT_RED             = 34763
};

enum Misc
{
    NPC_FRAYER                  = 19953,

    EVENT_SUMMON_SEEDLING       = 1,
    EVENT_TREE_FORM             = 2,
    EVENT_CHECK_FRAYERS         = 3,
    EVENT_RESTORE_COMBAT        = 4
};

class boss_high_botanist_freywinn : public CreatureScript
{
    public:

        boss_high_botanist_freywinn() : CreatureScript("boss_high_botanist_freywinn")
        {
        }

        struct boss_high_botanist_freywinnAI : public BossAI
        {
            boss_high_botanist_freywinnAI(Creature* creature) : BossAI(creature, DATA_HIGH_BOTANIST_FREYWINN) { }

            void Reset()
            {
                _Reset();
            }

            void EnterCombat(Unit* /*who*/)
            {
                _EnterCombat();
                Talk(SAY_AGGRO);

                events.ScheduleEvent(EVENT_SUMMON_SEEDLING, 6000);
                events.ScheduleEvent(EVENT_TREE_FORM, 30000);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_KILL);
            }

            void JustDied(Unit* /*killer*/)
            {
                Talk(SAY_DEATH);
                _JustDied();
            }

            void SummonedCreatureDies(Creature* summon, Unit*)
            {
                summons.Despawn(summon);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (!events.IsInPhase(1) && me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_SUMMON_SEEDLING:
                        if (roll_chance_i(20))
                            Talk(SAY_OOC_RANDOM);
                        me->CastSpell(me, RAND(SPELL_PLANT_WHITE, SPELL_PLANT_GREEN, SPELL_PLANT_BLUE, SPELL_PLANT_RED), false);
                        events.ScheduleEvent(EVENT_SUMMON_SEEDLING, 6000);
                        break;
                    case EVENT_TREE_FORM:
                        events.Reset();
                        events.SetPhase(1);
                        events.ScheduleEvent(EVENT_CHECK_FRAYERS, 1000);
                        events.ScheduleEvent(EVENT_TREE_FORM, 75000);
                        events.ScheduleEvent(EVENT_RESTORE_COMBAT, 46000);

                        Talk(SAY_TREE);
                        me->RemoveAllAuras();
                        me->GetMotionMaster()->MoveIdle();
                        me->GetMotionMaster()->Clear(false);

                        me->CastSpell(me, SPELL_SUMMON_FRAYER, true);
                        me->CastSpell(me, SPELL_TRANQUILITY, true);
                        me->CastSpell(me, SPELL_TREE_FORM, true);
                        break;
                    case EVENT_RESTORE_COMBAT:
                        events.SetPhase(0);
                        events.ScheduleEvent(EVENT_SUMMON_SEEDLING, 6000);
                        me->GetMotionMaster()->MoveChase(me->GetVictim());
                        break;
                    case EVENT_CHECK_FRAYERS:
                        if (!summons.HasEntry(NPC_FRAYER))
                        {
                            me->InterruptNonMeleeSpells(true);
                            me->RemoveAllAuras();
                            events.RescheduleEvent(EVENT_RESTORE_COMBAT, 0);
                            events.RescheduleEvent(EVENT_TREE_FORM, 30000);
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_FRAYERS, 500);
                        break;
                }

                if (!events.IsInPhase(1))
                    DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_high_botanist_freywinnAI(creature);
        }
};

void AddSC_boss_high_botanist_freywinn()
{
    new boss_high_botanist_freywinn();
}

