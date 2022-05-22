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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "TaskScheduler.h"
#include "zulgurub.h"

enum Says
{
    SAY_AGGRO                 = 0,
    SAY_DEATH                 = 1
};

enum Spells
{
    SPELL_MORTALCLEAVE        = 22859,
    SPELL_SILENCE             = 22666,
    SPELL_TIGER_FORM          = 24169,
    SPELL_RESURRECT           = 24173,
    SPELL_FRENZY              = 8269,
    SPELL_FORCEPUNCH          = 24189,
    SPELL_CHARGE              = 24193,
    SPELL_ENRAGE              = 8269,
    SPELL_SUMMONTIGERS        = 24183,

    // Zealot Lor'Khan Spells
    SPELL_SHIELD              = 20545,
    SPELL_BLOODLUST           = 24185,
    SPELL_GREATERHEAL         = 24208,
    SPELL_DISARM              = 6713,
    // Zealot Zath Spells
    SPELL_SWEEPINGSTRIKES     = 18765,
    SPELL_SINISTERSTRIKE      = 15581,
    SPELL_GOUGE               = 12540,
    SPELL_KICK                = 15614,
    SPELL_BLIND               = 21060
};

enum Events
{
    EVENT_CHECK_TIMER         = 3,
    EVENT_RESURRECT_TIMER     = 4,
    EVENT_FRENZY              = 5,
    EVENT_FORCEPUNCH          = 6,
    EVENT_SPELL_CHARGE        = 7,
    EVENT_ENRAGE              = 8,
    EVENT_SUMMONTIGERS        = 9
};

enum Phases
{
    PHASE_ONE                 = 1,
    PHASE_TWO                 = 2
};

enum Actions
{
    ACTION_RESSURRECT         = 1
};

class boss_thekal : public CreatureScript
{
public:
    boss_thekal() : CreatureScript("boss_thekal") { }

    struct boss_thekalAI : public BossAI
    {
        boss_thekalAI(Creature* creature) : BossAI(creature, DATA_THEKAL)
        {
            Initialize();
        }

        bool Enraged;
        bool WasDead;

        void Initialize()
        {
            Enraged = false;
            WasDead = false;
        }

        void Reset() override
        {
            if (events.IsInPhase(PHASE_TWO))
                me->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, 35.0f, false); // hack
            _Reset();
            Initialize();
            me->SetObjectScale(1.0f);
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->SetReactState(REACT_AGGRESSIVE);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

            if (Creature* zealot = instance->GetCreature(DATA_LORKHAN))
            {
                zealot->AI()->Reset();
                zealot->ResetFaction();
            }

            if (Creature* zealot = instance->GetCreature(DATA_ZATH))
            {
                zealot->AI()->Reset();
                zealot->ResetFaction();
            }

            std::list<Creature*> creatureList;
            GetCreatureListWithEntryInGrid(creatureList, me, NPC_ZULGURUB_TIGER, 15.0f);

            for (Creature* creature : creatureList)
            {
                if (!creature->IsAlive())
                {
                    creature->Respawn(true);
                }
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            Talk(SAY_DEATH);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            Talk(SAY_AGGRO);

            _scheduler.Schedule(4s, [this](TaskContext context) {
                DoCastVictim(SPELL_MORTALCLEAVE);
                context.Repeat(15s, 20s);
            }).Schedule(9s, [this](TaskContext context) {
                DoCastVictim(SPELL_SILENCE);
                context.Repeat(20s, 25s);
            });
        }

        void SetData(uint32 /*type*/, uint32 data) override
        {
            UpdateZealotStatus(data, true);
            LOG_ERROR("sql.sql", "Set data........................");
            _scheduler.Schedule(10s, [this, data](TaskContext /*context*/) {
                LOG_ERROR("sql.sql", "happening");
                if (!_lorkhanDied || !_zathDied)
                {
                    LOG_ERROR("sql.sql", "happening 2");
                    ReviveZealot(data);
                }
            });
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!WasDead && damage >= me->GetHealth())
            {
                damage = 0;
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetReactState(REACT_PASSIVE);
                me->SetStandState(UNIT_STAND_STATE_SLEEP);
                me->AttackStop();
                instance->SetBossState(DATA_THEKAL, SPECIAL);
                WasDead = true;

                _scheduler.Schedule(10s, [this](TaskContext /*context*/) {
                    if (_lorkhanDied && _zathDied)
                    {
                        DoCastSelf(SPELL_TIGER_FORM);
                        me->SetObjectScale(2.00f);
                        me->SetStandState(UNIT_STAND_STATE_STAND);
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        me->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, 40.0f, true); // hack
                        DoResetThreat();
                        events.ScheduleEvent(EVENT_FRENZY, 30000, 0, PHASE_TWO);
                        events.ScheduleEvent(EVENT_FORCEPUNCH, 4000, 0, PHASE_TWO);
                        events.ScheduleEvent(EVENT_SPELL_CHARGE, 12000, 0, PHASE_TWO);
                        events.ScheduleEvent(EVENT_SUMMONTIGERS, 25000, 0, PHASE_TWO);
                        events.SetPhase(PHASE_TWO);
                    }
                    else
                    {
                        DoAction(ACTION_RESSURRECT);
                    }
                });
            }

            if (!Enraged && WasDead && me->HealthBelowPctDamaged(20, damage))
            {
                DoCastSelf(SPELL_ENRAGE);
                Enraged = true;
            }
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_RESSURRECT)
            {
                me->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->ResetFaction();
                me->SetReactState(REACT_AGGRESSIVE);
                me->SetFullHealth();
                WasDead = false;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() && instance->GetBossState(DATA_THEKAL) != SPECIAL)
                return;

            events.Update(diff);
            _scheduler.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_FRENZY:
                        DoCastSelf(SPELL_FRENZY);
                        events.ScheduleEvent(EVENT_FRENZY, 30000, 0, PHASE_TWO);
                        break;
                    case EVENT_FORCEPUNCH:
                        DoCastVictim(SPELL_FORCEPUNCH, true);
                        events.ScheduleEvent(EVENT_FORCEPUNCH, urand(16000, 21000), 0, PHASE_TWO);
                        break;
                    case EVENT_CHARGE:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        {
                            DoCast(target, SPELL_CHARGE);
                            DoResetThreat();
                            AttackStart(target);
                        }
                        events.ScheduleEvent(EVENT_CHARGE, urand(15000, 22000), 0, PHASE_TWO);
                        break;
                    case EVENT_SUMMONTIGERS:
                        DoCastVictim(SPELL_SUMMONTIGERS, true);
                        events.ScheduleEvent(EVENT_SUMMONTIGERS, urand(10000, 14000), 0, PHASE_TWO);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void ReviveZealot(uint32 zealotData)
        {
            if (Creature* zealot = instance->GetCreature(zealotData))
            {
                zealot->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
                zealot->ResetFaction();
                zealot->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                zealot->SetReactState(REACT_AGGRESSIVE);
                zealot->SetFullHealth();
                instance->SetData(zealotData, DONE);
                UpdateZealotStatus(zealotData, false);
            }
        }

        void UpdateZealotStatus(uint32 data, bool dead)
        {
            if (data == DATA_LORKHAN)
            {
                _lorkhanDied = dead ? true : false;
            }
            else if (data == DATA_ZATH)
            {
                _zathDied = dead ? true : false;
            }
        }

        private:
            TaskScheduler _scheduler;
            bool _lorkhanDied;
            bool _zathDied;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<boss_thekalAI>(creature);
    }
};

class npc_zealot_lorkhan : public CreatureScript
{
public:
    npc_zealot_lorkhan() : CreatureScript("npc_zealot_lorkhan") { }

    struct npc_zealot_lorkhanAI : public ScriptedAI
    {
        npc_zealot_lorkhanAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        uint32 Shield_Timer;
        uint32 BloodLust_Timer;
        uint32 GreaterHeal_Timer;
        uint32 Disarm_Timer;
        uint32 Check_Timer;

        bool FakeDeath;

        InstanceScript* instance;

        void Reset() override
        {
            Shield_Timer = 1000;
            BloodLust_Timer = 16000;
            GreaterHeal_Timer = 32000;
            Disarm_Timer = 6000;
            Check_Timer = 10000;

            FakeDeath = false;

            me->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth() && !FakeDeath)
            {
                me->RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE_PERCENT);
                me->RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE);
                me->RemoveAurasByType(SPELL_AURA_PERIODIC_LEECH);
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetStandState(UNIT_STAND_STATE_SLEEP);
                me->SetReactState(REACT_PASSIVE);
                me->AttackStop();

                damage = 0;
                FakeDeath = true;

                if (Creature* thekal = instance->GetCreature(DATA_THEKAL))
                {
                    LOG_ERROR("sql.sql", "here");
                    thekal->AI()->SetData(ACTION_RESSURRECT, DATA_LORKHAN);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!FakeDeath)
            {
                if (!UpdateVictim())
                    return;
            }

            //Shield_Timer
            if (Shield_Timer <= diff)
            {
                DoCast(me, SPELL_SHIELD);
                Shield_Timer = 61000;
            }
            else Shield_Timer -= diff;

            //BloodLust_Timer
            if (BloodLust_Timer <= diff)
            {
                DoCast(me, SPELL_BLOODLUST);
                BloodLust_Timer = 20000 + rand() % 8000;
            }
            else BloodLust_Timer -= diff;

            //Casting Greaterheal to Thekal or Zath if they are in meele range.
            if (GreaterHeal_Timer <= diff)
            {
                Unit* pThekal = instance->GetCreature(DATA_THEKAL);
                Unit* pZath = instance->GetCreature(DATA_ZATH);

                if (!pThekal || !pZath)
                    return;

                switch (urand(0, 1))
                {
                    case 0:
                        if (me->IsWithinMeleeRange(pThekal))
                            DoCast(pThekal, SPELL_GREATERHEAL);
                        break;
                    case 1:
                        if (me->IsWithinMeleeRange(pZath))
                            DoCast(pZath, SPELL_GREATERHEAL);
                        break;
                }

                GreaterHeal_Timer = 15000 + rand() % 5000;
            }
            else GreaterHeal_Timer -= diff;

            //Disarm_Timer
            if (Disarm_Timer <= diff)
            {
                DoCastVictim(SPELL_DISARM);
                Disarm_Timer = 15000 + rand() % 10000;
            }
            else Disarm_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<npc_zealot_lorkhanAI>(creature);
    }
};

class npc_zealot_zath : public CreatureScript
{
public:
    npc_zealot_zath() : CreatureScript("npc_zealot_zath") { }

    struct npc_zealot_zathAI : public ScriptedAI
    {
        npc_zealot_zathAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        uint32 SweepingStrikes_Timer;
        uint32 SinisterStrike_Timer;
        uint32 Gouge_Timer;
        uint32 Kick_Timer;
        uint32 Blind_Timer;
        uint32 Check_Timer;

        bool FakeDeath;

        InstanceScript* instance;

        void Reset() override
        {
            SweepingStrikes_Timer = 13000;
            SinisterStrike_Timer = 8000;
            Gouge_Timer = 25000;
            Kick_Timer = 18000;
            Blind_Timer = 5000;
            Check_Timer = 10000;

            FakeDeath = false;

            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth() && !FakeDeath)
            {
                me->RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE_PERCENT);
                me->RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE);
                me->RemoveAurasByType(SPELL_AURA_PERIODIC_LEECH);
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetStandState(UNIT_STAND_STATE_SLEEP);
                me->SetReactState(REACT_PASSIVE);
                me->AttackStop();

                FakeDeath = true;
                damage = 0;

                if (Creature* thekal = instance->GetCreature(DATA_THEKAL))
                {
                    thekal->AI()->SetData(ACTION_RESSURRECT, DATA_ZATH);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!FakeDeath)
            {
                if (!UpdateVictim())
                    return;
            }

            //SweepingStrikes_Timer
            if (SweepingStrikes_Timer <= diff)
            {
                DoCastVictim(SPELL_SWEEPINGSTRIKES);
                SweepingStrikes_Timer = 22000 + rand() % 4000;
            }
            else SweepingStrikes_Timer -= diff;

            //SinisterStrike_Timer
            if (SinisterStrike_Timer <= diff)
            {
                DoCastVictim(SPELL_SINISTERSTRIKE);
                SinisterStrike_Timer = 8000 + rand() % 8000;
            }
            else SinisterStrike_Timer -= diff;

            //Gouge_Timer
            if (Gouge_Timer <= diff)
            {
                DoCastVictim(SPELL_GOUGE);

                if (DoGetThreat(me->GetVictim()))
                    DoModifyThreatPercent(me->GetVictim(), -100);

                Gouge_Timer = 17000 + rand() % 10000;
            }
            else Gouge_Timer -= diff;

            //Kick_Timer
            if (Kick_Timer <= diff)
            {
                DoCastVictim(SPELL_KICK);
                Kick_Timer = 15000 + rand() % 10000;
            }
            else Kick_Timer -= diff;

            //Blind_Timer
            if (Blind_Timer <= diff)
            {
                DoCastVictim(SPELL_BLIND);
                Blind_Timer = 10000 + rand() % 10000;
            }
            else Blind_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<npc_zealot_zathAI>(creature);
    }
};

void AddSC_boss_thekal()
{
    new boss_thekal();
    new npc_zealot_lorkhan();
    new npc_zealot_zath();
}
