/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"

enum ExarchMaladaar
{
    SAY_INTRO                   = 0,
    SAY_SUMMON                  = 1,
    SAY_AGGRO                   = 2,
    SAY_ROAR                    = 3,
    SAY_SLAY                    = 4,
    SAY_DEATH                   = 5,

    SPELL_RIBBON_OF_SOULS       = 32422,
    SPELL_SOUL_SCREAM           = 32421,
    SPELL_STOLEN_SOUL           = 32346,
    SPELL_STOLEN_SOUL_VISUAL    = 32395,
    SPELL_SUMMON_AVATAR         = 32424,

    ENTRY_STOLEN_SOUL           = 18441,

    EVENT_SPELL_FEAR            = 1,
    EVENT_SPELL_RIBBON          = 2,
    EVENT_SPELL_SOUL            = 3,
    EVENT_CHECK_HEALTH          = 4
};

class boss_exarch_maladaar : public CreatureScript
{
public:
    boss_exarch_maladaar() : CreatureScript("boss_exarch_maladaar") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_exarch_maladaarAI (creature);
    }

    struct boss_exarch_maladaarAI : public ScriptedAI
    {
        boss_exarch_maladaarAI(Creature* creature) : ScriptedAI(creature)
        {
            _talked = false;
        }

        bool _talked;
        EventMap events;

        void Reset()
        {
            events.Reset();
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (!_talked && who->GetTypeId() == TYPEID_PLAYER && me->IsWithinDistInMap(who, 150.0f))
            {
                Talk(SAY_INTRO);
                _talked = true;
            }

            ScriptedAI::MoveInLineOfSight(who);
        }

        void EnterCombat(Unit*)
        {
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_SPELL_FEAR, 15000);
            events.ScheduleEvent(EVENT_SPELL_RIBBON, 5000);
            events.ScheduleEvent(EVENT_SPELL_SOUL, 25000);
            events.ScheduleEvent(EVENT_CHECK_HEALTH, 5000);
        }

        void KilledUnit(Unit*)
        {
            if (urand(0,1))
                Talk(SAY_SLAY);
        }

        void JustDied(Unit*)
        {
            Talk(SAY_DEATH);

            //When Exarch Maladar is defeated D'ore appear.
            me->SummonCreature(19412, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 600000);
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
                case EVENT_CHECK_HEALTH:
                    if (HealthBelowPct(25))
                    {
                        Talk(SAY_SUMMON);
                        me->CastSpell(me, SPELL_SUMMON_AVATAR, false);
                        events.PopEvent();
                        return;
                    }
                    events.RepeatEvent(2000);
                    break;
                case EVENT_SPELL_SOUL:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                    {
                        Talk(SAY_ROAR);
                        me->CastSpell(target, SPELL_STOLEN_SOUL, false);
                        if (Creature* summon = me->SummonCreature(ENTRY_STOLEN_SOUL, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000))
                        {
                            summon->CastSpell(summon, SPELL_STOLEN_SOUL_VISUAL, false);
                            summon->SetDisplayId(target->GetDisplayId());
                            summon->AI()->DoAction(target->getClass());
                            summon->AI()->AttackStart(target);
                        }
                    }
                    events.RepeatEvent(urand(25000, 30000));
                    break;
                case EVENT_SPELL_RIBBON:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        me->CastSpell(target, SPELL_RIBBON_OF_SOULS, false);
                    events.RepeatEvent(urand(10000, 20000));
                    break;
                case EVENT_SPELL_FEAR:
                    me->CastSpell(me, SPELL_SOUL_SCREAM, false);
                    events.RepeatEvent(urand(15000, 25000));
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

enum stolenSoul
{
    SPELL_MOONFIRE              = 37328,
    SPELL_FIREBALL              = 37329,
    SPELL_MIND_FLAY             = 37330,
    SPELL_HEMORRHAGE            = 37331,
    SPELL_FROSTSHOCK            = 37332,
    SPELL_CURSE_OF_AGONY        = 37334,
    SPELL_MORTAL_STRIKE         = 37335,
    SPELL_FREEZING_TRAP         = 37368,
    SPELL_HAMMER_OF_JUSTICE     = 37369,
    SPELL_PLAGUE_STRIKE         = 58839,

    EVENT_STOLEN_SOUL_SPELL     = 1,
};

class npc_stolen_soul : public CreatureScript
{
public:
    npc_stolen_soul() : CreatureScript("npc_stolen_soul") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_stolen_soulAI (creature);
    }

    struct npc_stolen_soulAI : public ScriptedAI
    {
        npc_stolen_soulAI(Creature* creature) : ScriptedAI(creature) {}

        uint8 myClass;
        EventMap events;

        void Reset()
        {
            myClass = CLASS_WARRIOR;
            events.ScheduleEvent(EVENT_STOLEN_SOUL_SPELL, 1000);
        }

        void DoAction(int32 pClass)
        {
            myClass = pClass;
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (events.GetEvent() == EVENT_STOLEN_SOUL_SPELL)
            {
                switch (myClass)
                {
                    case CLASS_WARRIOR:
                        me->CastSpell(me->GetVictim(), SPELL_MORTAL_STRIKE, false);
                        events.RepeatEvent(6000);
                        break;
                    case CLASS_PALADIN:
                        me->CastSpell(me->GetVictim(), SPELL_HAMMER_OF_JUSTICE, false);
                        events.RepeatEvent(6000);
                        break;
                    case CLASS_HUNTER:
                        me->CastSpell(me->GetVictim(), SPELL_FREEZING_TRAP, false);
                        events.RepeatEvent(20000);
                        break;
                    case CLASS_ROGUE:
                        me->CastSpell(me->GetVictim(), SPELL_HEMORRHAGE, false);
                        events.RepeatEvent(10000);
                        break;
                    case CLASS_PRIEST:
                        me->CastSpell(me->GetVictim(), SPELL_MIND_FLAY, false);
                        events.RepeatEvent(5000);
                        break;
                    case CLASS_SHAMAN:
                        me->CastSpell(me->GetVictim(), SPELL_FROSTSHOCK, false);
                        events.RepeatEvent(8000);
                        break;
                    case CLASS_MAGE:
                        me->CastSpell(me->GetVictim(), SPELL_FIREBALL, false);
                        events.RepeatEvent(5000);
                        break;
                    case CLASS_WARLOCK:
                        me->CastSpell(me->GetVictim(), SPELL_CURSE_OF_AGONY, false);
                        events.RepeatEvent(20000);
                        break;
                    case CLASS_DRUID:
                        me->CastSpell(me->GetVictim(), SPELL_MOONFIRE, false);
                        events.RepeatEvent(10000);
                        break;
                    case CLASS_DEATH_KNIGHT:
                        me->CastSpell(me->GetVictim(), SPELL_PLAGUE_STRIKE, false);
                        events.RepeatEvent(6000);
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_exarch_maladaar()
{
    new boss_exarch_maladaar();
    new npc_stolen_soul();
}
