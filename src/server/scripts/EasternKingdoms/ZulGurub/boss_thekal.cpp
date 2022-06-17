/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
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
    SAY_DEATH                 = 1,

    EMOTE_ZEALOT_DIES         = 0,
    EMOTE_THEKAL_DIES         = 2
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
            _lorkhanDied = false;
            _zathDied = false;
        }

        void Reset() override
        {
            _Reset();
            Initialize();

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

            // TODO: do this in formations, once a flag is added to prevent leaders from respawning as well.
            std::list<Creature*> creatureList;
            GetCreatureListWithEntryInGrid(creatureList, me, NPC_ZULGURUB_TIGER, 15.0f);

            if (_catGuids.empty())
            {
                for (Creature* creature : creatureList)
                {
                    _catGuids.push_back(creature->GetGUID());
                    if (!creature->IsAlive())
                    {
                        creature->Respawn(true);
                    }
                }
            }
            else
            {
                for (ObjectGuid guid : _catGuids)
                {
                    if (Creature* creature = ObjectAccessor::GetCreature(*me, guid))
                    {
                        if (!creature->IsAlive())
                        {
                            creature->Respawn(true);
                        }
                    }
                }
            }

            _scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            Talk(SAY_DEATH);

            if (Creature* zealot = instance->GetCreature(DATA_LORKHAN))
            {
                zealot->Kill(zealot, zealot);
            }

            if (Creature* zealot = instance->GetCreature(DATA_ZATH))
            {
                zealot->Kill(zealot, zealot);
            }
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();

            _scheduler.CancelAll();
            _scheduler.Schedule(4s, [this](TaskContext context) {
                DoCastVictim(SPELL_MORTALCLEAVE);
                context.Repeat(15s, 20s);
            }).Schedule(9s, [this](TaskContext context) {
                DoCastVictim(SPELL_SILENCE);
                context.Repeat(20s, 25s);
            }).Schedule(16s, [this](TaskContext context) {
                DoCastSelf(SPELL_BLOODLUST);
                context.Repeat(20s, 28s);
            });
        }

        void SetData(uint32 /*type*/, uint32 data) override
        {
            UpdateZealotStatus(data, true);
            CheckPhaseTransition();

            _scheduler.Schedule(10s, [this, data](TaskContext /*context*/) {
                if ((!_lorkhanDied || !_zathDied) && !WasDead)
                {
                    ReviveZealot(data);
                }
            });
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!WasDead && damage >= me->GetHealth())
            {
                damage = me->GetHealth() - 1;
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetReactState(REACT_PASSIVE);
                me->SetStandState(UNIT_STAND_STATE_SLEEP);
                me->AttackStop();
                WasDead = true;
                CheckPhaseTransition();
                Talk(EMOTE_THEKAL_DIES);
            }

            if (!Enraged && me->HealthBelowPctDamaged(20, damage) && me->GetEntry() != NPC_HIGH_PRIEST_THEKAL)
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
            if (me->GetReactState() != REACT_PASSIVE && !UpdateVictim())
                return;

            _scheduler.Update(diff,
                std::bind(&BossAI::DoMeleeAttackIfReady, this));
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
                UpdateZealotStatus(zealotData, false);
            }
        }

        void UpdateZealotStatus(uint32 data, bool dead)
        {
            if (data == DATA_LORKHAN)
            {
                _lorkhanDied = dead;
            }
            else if (data == DATA_ZATH)
            {
                _zathDied = dead;
            }
        }

        void CheckPhaseTransition()
        {
            if (WasDead && _lorkhanDied && _zathDied)
            {
                _scheduler.Schedule(3s, [this](TaskContext /*context*/) {
                    Talk(SAY_AGGRO);
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    DoResetThreat();

                    _scheduler.Schedule(6s, [this](TaskContext /*context*/) {
                        DoCastSelf(SPELL_TIGER_FORM);
                        me->SetReactState(REACT_AGGRESSIVE);

                        _scheduler.Schedule(30s, [this](TaskContext context) {
                            DoCastSelf(SPELL_FRENZY);
                            context.Repeat();
                        }).Schedule(4s, [this](TaskContext context) {
                            DoCastVictim(SPELL_FORCEPUNCH);
                            context.Repeat(16s, 21s);
                        }).Schedule(12s, [this](TaskContext context) {
                            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                            {
                                DoCast(target, SPELL_CHARGE);
                                DoResetThreat();
                                AttackStart(target);
                            }
                            context.Repeat(15s, 22s);
                        }).Schedule(25s, [this](TaskContext context) {
                            DoCastVictim(SPELL_SUMMONTIGERS, true);
                            context.Repeat(10s, 14s);
                        });
                    });
                });
            }
            else
            {
                _scheduler.Schedule(10s, [this](TaskContext /*context*/) {
                    DoAction(ACTION_RESSURRECT);
                });
            }
        }

        private:
            TaskScheduler _scheduler;
            GuidVector _catGuids;
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

        InstanceScript* instance;

        void Reset() override
        {
            me->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->SetReactState(REACT_AGGRESSIVE);

            _scheduler.CancelAll();

            _scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING) && !me->HasReactState(REACT_PASSIVE);
            });
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _scheduler.Schedule(1s, [this](TaskContext context) {
                DoCastSelf(SPELL_SHIELD);
                context.Repeat(1min);
            }).Schedule(32s, [this](TaskContext context) {
                Unit* thekal = instance->GetCreature(DATA_THEKAL);
                Unit* zath = instance->GetCreature(DATA_ZATH);

                if (!thekal || !zath)
                    return;

                if ((me->GetHealthPct() <= thekal->GetHealthPct()) || (me->GetHealthPct() <= zath->GetHealthPct()))
                {
                    DoCastSelf(SPELL_GREATERHEAL);
                }
                else if (zath->GetHealthPct() <= thekal->GetHealthPct())
                {
                    DoCast(zath, SPELL_GREATERHEAL);
                }
                else
                {
                    DoCast(thekal, SPELL_GREATERHEAL);
                }

                context.Repeat(15s, 20s);
            }).Schedule(6s, [this](TaskContext context) {
                DoCastVictim(SPELL_DISARM);
                context.Repeat(15s, 25s);
            });
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth() && me->HasReactState(REACT_AGGRESSIVE))
            {
                Talk(EMOTE_ZEALOT_DIES);
                me->RemoveAllAuras();
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetStandState(UNIT_STAND_STATE_SLEEP);
                me->SetReactState(REACT_PASSIVE);
                me->InterruptNonMeleeSpells(false);
                me->AttackStop();

                damage = 0;

                if (Creature* thekal = instance->GetCreature(DATA_THEKAL))
                {
                    thekal->AI()->SetData(ACTION_RESSURRECT, DATA_LORKHAN);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (me->GetReactState() != REACT_PASSIVE && !UpdateVictim())
                return;

            _scheduler.Update(diff,
                std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
        }

        private:
            TaskScheduler _scheduler;
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

        InstanceScript* instance;

        void Reset() override
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->SetReactState(REACT_AGGRESSIVE);

            _scheduler.CancelAll();

            _scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING) && !me->HasReactState(REACT_PASSIVE);
            });
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _scheduler.Schedule(13s, [this](TaskContext context) {
                DoCastSelf(SPELL_SWEEPINGSTRIKES);
                context.Repeat(1min);
            }).Schedule(16s, [this](TaskContext context) {
                DoCastSelf(SPELL_BLOODLUST);
                context.Repeat(22s, 26s);
            }).Schedule(8s, [this](TaskContext context) {
                DoCastVictim(SPELL_SINISTERSTRIKE);
                context.Repeat(8s, 16s);
            }).Schedule(25s, [this](TaskContext context) {
                DoCastVictim(SPELL_GOUGE);

                if (DoGetThreat(me->GetVictim()))
                {
                    DoModifyThreatPercent(me->GetVictim(), -100);
                }

                context.Repeat(17s, 27s);
            }).Schedule(18s, [this](TaskContext context) {
                DoCastVictim(SPELL_KICK);
                context.Repeat(15s, 25s);
            }).Schedule(5s, [this](TaskContext context) {
                DoCastVictim(SPELL_BLIND);
                context.Repeat(10s, 20s);
            });
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth() && me->HasReactState(REACT_AGGRESSIVE))
            {
                Talk(EMOTE_ZEALOT_DIES);
                me->RemoveAllAuras();
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetStandState(UNIT_STAND_STATE_SLEEP);
                me->SetReactState(REACT_PASSIVE);
                me->AttackStop();

                damage = 0;

                if (Creature* thekal = instance->GetCreature(DATA_THEKAL))
                {
                    thekal->AI()->SetData(ACTION_RESSURRECT, DATA_ZATH);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (me->GetReactState() != REACT_PASSIVE && !UpdateVictim())
                return;

            _scheduler.Update(diff,
                std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
        }

        private:
            TaskScheduler _scheduler;
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
