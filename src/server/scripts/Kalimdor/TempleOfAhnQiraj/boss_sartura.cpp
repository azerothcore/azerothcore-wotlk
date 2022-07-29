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

/* ScriptData
SDName: Boss_Sartura
SD%Complete: 95
SDComment:
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "temple_of_ahnqiraj.h"

enum Says
{
    SAY_AGGRO               = 0,
    SAY_SLAY                = 1,
    SAY_DEATH               = 2
};

enum Spells
{
    SPELL_WHIRLWIND         = 26083,
    SPELL_ENRAGE            = 8269,
    SPELL_BERSERK           = 27680,

    // Sartura's Royal Guard
    SPELL_WHIRLWINDADD      = 26038,
    SPELL_KNOCKBACK         = 26027
};

enum events
{
    EVENT_WHIRLWIND         = 1,
    EVENT_WHIRLWIND_RANDOM  = 2,
    EVENT_WHIRLWIND_END     = 3,
    EVENT_SPELL_BERSERK     = 5,
    EVENT_AGGRO_RESET       = 6,
    EVENT_AGGRO_RESET_END   = 7
};

struct boss_sartura : public BossAI
{

    boss_sartura(Creature* creature) : BossAI(creature, DATA_SARTURA) {}

    void Reset() override
    {
        _Reset();
        whirlwind = false;
        enraged = false;
        berserked = false;
        aggroReset = false;
    }

    void EnterCombat(Unit* who) override
    {
        BossAI::EnterCombat(who);
        Talk(SAY_AGGRO);
        //events.ScheduleEvent(EVENT_STONE_PHASE, 90000);
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_SLAY);
    }

    void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
    {
        if (!enraged && HealthBelowPct(20))
        {
            DoCastSelf(SPELL_ENRAGE);
            enraged = true;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_WHIRLWIND:
                    DoCastSelf(SPELL_WHIRLWIND);
                    whirlwind = true;
                    events.ScheduleEvent(EVENT_WHIRLWIND_RANDOM, urand(3000, 7000));
                    events.ScheduleEvent(EVENT_WHIRLWIND_END, 15000);
                    break;
                case EVENT_WHIRLWIND_RANDOM:
                    if (whirlwind == true)
                    {
                        if (Unit* pUnit = SelectTarget(SELECT_TARGET_RANDOM, 1, 100.0f, true))
                        {
                            me->AddThreat(pUnit, 1.0f);
                            me->TauntApply(pUnit);
                            AttackStart(pUnit);
                        }
                        events.RepeatEvent(urand(3000, 7000));
                    }
                    break;
                case EVENT_WHIRLWIND_END:
                    events.CancelEvent(EVENT_WHIRLWIND_RANDOM);
                    whirlwind = false;
                    events.ScheduleEvent(EVENT_WHIRLWIND, urand(25000, 40000));
                    break;
                case EVENT_AGGRO_RESET:
                    if (aggroReset != true)
                    {
                        aggroReset = true;
                        events.ScheduleEvent(EVENT_AGGRO_RESET_END, 15000);
                    }
                    if (Unit* pUnit = SelectTarget(SELECT_TARGET_RANDOM, 1, 100.0f, true))
                    {
                        me->AddThreat(pUnit, 1.0f);
                        me->TauntApply(pUnit);
                        AttackStart(pUnit);
                    }
                    events.RepeatEvent(urand(2000, 5000));
                    break;
                case EVENT_AGGRO_RESET_END:
                    aggroReset = false;
                    events.RescheduleEvent(EVENT_AGGRO_RESET, urand(30000, 40000));
                    break;
                case EVENT_SPELL_BERSERK:
                    DoCastSelf(SPELL_BERSERK);
                    break;
                default:
                    break;
            }
        }

        if (WhirlWind)
        {
            if (WhirlWindRandom_Timer <= diff)
            {
                //Attack random Gamers
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100.0f, true))
                {
                    me->AddThreat(target, 1.0f);
                    me->TauntApply(target);
                    AttackStart(target);
                }
                WhirlWindRandom_Timer = urand(3000, 7000);
            }
            else WhirlWindRandom_Timer -= diff;

            if (WhirlWindEnd_Timer <= diff)
            {
                WhirlWind = false;
                WhirlWind_Timer = urand(25000, 40000);
            }
            else WhirlWindEnd_Timer -= diff;
        }

        if (!WhirlWind)
        {
            if (WhirlWind_Timer <= diff)
            {
                DoCast(me, SPELL_WHIRLWIND);
                WhirlWind = true;
                WhirlWindEnd_Timer = 15000;
            }
            else WhirlWind_Timer -= diff;

            if (AggroReset_Timer <= diff)
            {
                //Attack random Gamers
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100.0f, true))
                {
                    me->AddThreat(target, 1.0f);
                    me->TauntApply(target);
                    AttackStart(target);
                }
                AggroReset = true;
                AggroReset_Timer = urand(2000, 5000);
            }
            else AggroReset_Timer -= diff;

            if (AggroReset)
            {
                if (AggroResetEnd_Timer <= diff)
                {
                    AggroReset = false;
                    AggroResetEnd_Timer = 5000;
                    AggroReset_Timer = urand(35000, 45000);
                }
                else AggroResetEnd_Timer -= diff;
            }

            //After 10 minutes hard enrage
            if (!EnragedHard)
            {
                if (EnrageHard_Timer <= diff)
                {
                    DoCast(me, SPELL_BERSERK, true);
                    EnragedHard = true;
                }
                else EnrageHard_Timer -= diff;
            }
        }
        DoMeleeAttackIfReady();
    };
    private:
        bool whirlwind;
        bool enraged;
        bool berserked;
        bool aggroReset;
};

class npc_sartura_royal_guard : public CreatureScript
{
public:
    npc_sartura_royal_guard() : CreatureScript("npc_sartura_royal_guard") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetTempleOfAhnQirajAI<npc_sartura_royal_guardAI>(creature);
    }

    struct npc_sartura_royal_guardAI : public ScriptedAI
    {
        npc_sartura_royal_guardAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 WhirlWind_Timer;
        uint32 WhirlWindRandom_Timer;
        uint32 WhirlWindEnd_Timer;
        uint32 AggroReset_Timer;
        uint32 AggroResetEnd_Timer;
        uint32 KnockBack_Timer;

        bool WhirlWind;
        bool AggroReset;

        void Reset() override
        {
            WhirlWind_Timer = 30000;
            WhirlWindRandom_Timer = urand(3000, 7000);
            WhirlWindEnd_Timer = 15000;
            AggroReset_Timer = urand(45000, 55000);
            AggroResetEnd_Timer = 5000;
            KnockBack_Timer = 10000;

            WhirlWind = false;
            AggroReset = false;
        }

        void EnterCombat(Unit* /*who*/) override
        {
        }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            if (!WhirlWind && WhirlWind_Timer <= diff)
            {
                DoCast(me, SPELL_WHIRLWINDADD);
                WhirlWind = true;
                WhirlWind_Timer = urand(25000, 40000);
                WhirlWindEnd_Timer = 15000;
            }
            else WhirlWind_Timer -= diff;

            if (WhirlWind)
            {
                if (WhirlWindRandom_Timer <= diff)
                {
                    //Attack random Gamers
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100.0f, true))
                    {
                        me->AddThreat(target, 1.0f);
                        me->TauntApply(target);
                        AttackStart(target);
                    }

                    WhirlWindRandom_Timer = urand(3000, 7000);
                }
                else WhirlWindRandom_Timer -= diff;

                if (WhirlWindEnd_Timer <= diff)
                {
                    WhirlWind = false;
                }
                else WhirlWindEnd_Timer -= diff;
            }

            if (!WhirlWind)
            {
                if (AggroReset_Timer <= diff)
                {
                    //Attack random Gamers
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100.0f, true))
                    {
                        me->AddThreat(target, 1.0f);
                        me->TauntApply(target);
                        AttackStart(target);
                    }

                    AggroReset = true;
                    AggroReset_Timer = urand(2000, 5000);
                }
                else AggroReset_Timer -= diff;

                if (KnockBack_Timer <= diff)
                {
                    DoCast(me, SPELL_WHIRLWINDADD);
                    KnockBack_Timer = urand(10000, 20000);
                }
                else KnockBack_Timer -= diff;
            }

            if (AggroReset)
            {
                if (AggroResetEnd_Timer <= diff)
                {
                    AggroReset = false;
                    AggroResetEnd_Timer = 5000;
                    AggroReset_Timer = urand(30000, 40000);
                }
                else AggroResetEnd_Timer -= diff;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_sartura()
{
    RegisterRuinsOfAhnQirajCreatureAI(boss_sartura);
    new npc_sartura_royal_guard();
}
