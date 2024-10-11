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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SharedDefines.h"
#include "TaskScheduler.h"
#include "zulgurub.h"

enum Says
{
    SAY_AGGRO                      = 0,
    SAY_DEATH                      = 1,
    EMOTE_DIES                     = 2,

    EMOTE_ZEALOT_DIES              = 0
};

enum Spells
{
    // Boss - pre-fight
    SPELL_SUMMONTIGERS                  = 24183,

    // Boss
    SPELL_CHARGE                        = 24193,
    SPELL_ENRAGE                        = 8269,
    SPELL_FORCEPUNCH                    = 24189,
    SPELL_FRENZY                        = 8269,
    SPELL_MORTALCLEAVE                  = 22859,
    SPELL_RESURRECTION_IMPACT_VISUAL    = 24171,
    SPELL_SILENCE                       = 22666,
    SPELL_TIGER_FORM                    = 24169,

    // Zealot Lor'Khan Spells
    SPELL_SHIELD                        = 20545,
    SPELL_BLOODLUST                     = 24185,
    SPELL_GREATERHEAL                   = 24208,
    SPELL_DISARM                        = 6713,

    // Zealot Zath Spells
    SPELL_SWEEPINGSTRIKES               = 18765,
    SPELL_SINISTERSTRIKE                = 15581,
    SPELL_GOUGE                         = 12540,
    SPELL_KICK                          = 15614,
    SPELL_BLIND                         = 21060
};

enum Actions
{
    ACTION_RESSURRECT         = 1
};

struct boss_thekal : public BossAI
{
    boss_thekal(Creature* creature) : BossAI(creature, DATA_THEKAL)
    {
        Initialize();
    }

    void Initialize()
    {
        _enraged = false;
        _wasDead = false;
        _lorkhanDied = false;
        _zathDied = false;
    }

    void Reset() override
    {
        _Reset();
        Initialize();

        scheduler.CancelAll();

        me->SetStandState(UNIT_STAND_STATE_STAND);
        me->SetReactState(REACT_AGGRESSIVE);
        me->RemoveAurasDueToSpell(SPELL_FRENZY);
        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        me->LoadEquipment(1, true);

        if (Creature* zealot = instance->GetCreature(DATA_LORKHAN))
        {
            zealot->AI()->Reset();
        }

        if (Creature* zealot = instance->GetCreature(DATA_ZATH))
        {
            zealot->AI()->Reset();
        }

        // emote idle loop
        scheduler.Schedule(5s, 25s, [this](TaskContext context)
        {
            // pick a random emote from the list of available emotes
            me->HandleEmoteCommand(
                RAND(
                    EMOTE_ONESHOT_TALK,
                    EMOTE_ONESHOT_FLEX,
                    EMOTE_ONESHOT_POINT
                )
            );
            context.Repeat(5s, 25s);
        });

        scheduler.SetValidator([this]
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

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();

        scheduler.CancelAll();
        scheduler.Schedule(4s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_MORTALCLEAVE);
            context.Repeat(15s, 20s);
        }).Schedule(9s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SILENCE);
            context.Repeat(20s, 25s);
        }).Schedule(16s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_BLOODLUST);
            context.Repeat(20s, 28s);
        });
    }

    void SetData(uint32 /*type*/, uint32 data) override
    {
        UpdateZealotStatus(data, true);
        CheckPhaseTransition();

        scheduler.Schedule(10s, [this, data](TaskContext /*context*/)
        {
            if (!_lorkhanDied || !_zathDied || !_wasDead)
            {
                ReviveZealot(data);
            }
        });
    }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType damageEffectType, SpellSchoolMask spellSchoolMask) override
    {
        if (!me->HasAura(SPELL_TIGER_FORM) && damage >= me->GetHealth())
        {
            damage = me->GetHealth() - 1;

            if (!_wasDead)
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetReactState(REACT_PASSIVE);
                me->SetStandState(UNIT_STAND_STATE_DEAD);
                me->AttackStop();
                DoResetThreatList();
                _wasDead = true;
                CheckPhaseTransition();
                Talk(EMOTE_DIES);
            }
        }

        BossAI::DamageTaken(attacker, damage, damageEffectType, spellSchoolMask);
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_RESSURRECT)
        {
            me->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->RestoreFaction();
            me->SetReactState(REACT_AGGRESSIVE);
            me->SetFullHealth();
            _wasDead = false;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (me->IsInCombat() && !UpdateVictim())
        {
            return;
        }
        else if (me->IsInCombat())
        {
            scheduler.Update(diff,
            std::bind(&BossAI::DoMeleeAttackIfReady, this));
        }
        else
        {
            scheduler.Update(diff);
        }
    }

    void ReviveZealot(uint32 zealotData)
    {
        if (Creature* zealot = instance->GetCreature(zealotData))
        {
            zealot->Respawn(true);
            zealot->SetInCombatWithZone();
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
        if (_wasDead && _lorkhanDied && _zathDied)
        {
            scheduler.Schedule(3s, [this](TaskContext /*context*/)
            {
                me->SetStandState(UNIT_STAND_STATE_STAND);
                DoCastSelf(SPELL_RESURRECTION_IMPACT_VISUAL, true);

                scheduler.Schedule(50ms, [this](TaskContext /*context*/)
                {
                    Talk(SAY_AGGRO);
                });

                scheduler.Schedule(6s, [this](TaskContext /*context*/)
                {
                    DoCastSelf(SPELL_TIGER_FORM);
                    me->LoadEquipment(0, true);
                    me->SetFullHealth();
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

                    scheduler.Schedule(30s, [this](TaskContext context)
                    {
                        DoCastSelf(SPELL_FRENZY);
                        context.Repeat();
                    }).Schedule(4s, [this](TaskContext context)
                    {
                        DoCastVictim(SPELL_FORCEPUNCH);
                        context.Repeat(16s, 21s);
                    }).Schedule(12s, [this](TaskContext context)
                    {
                        // charge a random target that is at least 8 yards away (min range of charge is 8 yards)
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, -8.0f))
                        {
                            DoCast(target, SPELL_CHARGE);
                            DoResetThreatList();
                            AttackStart(target);
                        }
                        context.Repeat(15s, 22s);
                    }).Schedule(25s, [this](TaskContext context)
                    {
                        DoCastVictim(SPELL_SUMMONTIGERS, true);
                        context.Repeat(10s, 14s);
                    });

                    // schedule Enrage at 20% health
                    ScheduleHealthCheckEvent(20, [this]
                    {
                        DoCastSelf(SPELL_ENRAGE);
                    });
                });
            });
        }
        else
        {
            scheduler.Schedule(10s, [this](TaskContext /*context*/)
            {
                if (!(_wasDead && _lorkhanDied && _zathDied))
                {
                    DoAction(ACTION_RESSURRECT);
                }
            });
        }
    }

    private:
        bool _lorkhanDied;
        bool _zathDied;
        bool _enraged;
        bool _wasDead;
};

struct npc_zealot_lorkhan : public ScriptedAI
{
    npc_zealot_lorkhan(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    InstanceScript* instance;

    void Reset() override
    {
        _scheduler.CancelAll();

        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });

        // emote idle loop
        _scheduler.Schedule(5s, 25s, [this](TaskContext context)
        {
            // pick a random emote from the list of available emotes
            me->HandleEmoteCommand(
                RAND(
                    EMOTE_ONESHOT_QUESTION,
                    EMOTE_ONESHOT_YES,
                    EMOTE_ONESHOT_NO
                )
            );
            context.Repeat(5s, 25s);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _scheduler.CancelAll();

        _scheduler.Schedule(1s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_SHIELD);
            context.Repeat(1min);
        }).Schedule(32s, [this](TaskContext context)
        {
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
        }).Schedule(6s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_DISARM);
            context.Repeat(15s, 25s);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(EMOTE_ZEALOT_DIES);

        if (Creature* thekal = instance->GetCreature(DATA_THEKAL))
        {
            thekal->AI()->SetData(ACTION_RESSURRECT, DATA_LORKHAN);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (me->IsInCombat() && !UpdateVictim())
        {
            return;
        }
        else if (me->IsInCombat())
        {
            _scheduler.Update(diff,
            std::bind(&BossAI::DoMeleeAttackIfReady, this));
        }
        else
        {
            _scheduler.Update(diff);
        }
    }

    private:
        TaskScheduler _scheduler;
};

struct npc_zealot_zath : public ScriptedAI
{
    npc_zealot_zath(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    InstanceScript* instance;

    void Reset() override
    {
        _scheduler.CancelAll();

        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });

        // emote idle loop
        _scheduler.Schedule(5s, 25s, [this](TaskContext context)
        {
            // pick a random emote from the list of available emotes
            me->HandleEmoteCommand(
                RAND(
                    EMOTE_ONESHOT_TALK,
                    EMOTE_ONESHOT_BEG,
                    EMOTE_ONESHOT_YES
                )
            );
            context.Repeat(5s, 25s);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _scheduler.CancelAll();

        _scheduler.Schedule(13s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_SWEEPINGSTRIKES);
            context.Repeat(1min);
        }).Schedule(16s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_BLOODLUST);
            context.Repeat(22s, 26s);
        }).Schedule(8s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SINISTERSTRIKE);
            context.Repeat(8s, 16s);
        }).Schedule(25s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_GOUGE);

            if (DoGetThreat(me->GetVictim()))
            {
                DoModifyThreatByPercent(me->GetVictim(), -100);
            }

            context.Repeat(17s, 27s);
        }).Schedule(18s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_KICK);
            context.Repeat(15s, 25s);
        }).Schedule(5s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_BLIND);
            context.Repeat(10s, 20s);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(EMOTE_ZEALOT_DIES);

        if (Creature* thekal = instance->GetCreature(DATA_THEKAL))
        {
            thekal->AI()->SetData(ACTION_RESSURRECT, DATA_ZATH);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (me->IsInCombat() && !UpdateVictim())
        {
            return;
        }
        else if (me->IsInCombat())
        {
            _scheduler.Update(diff,
            std::bind(&BossAI::DoMeleeAttackIfReady, this));
        }
        else
        {
            _scheduler.Update(diff);
        }
    }

    private:
        TaskScheduler _scheduler;
};

void AddSC_boss_thekal()
{
    RegisterCreatureAI(boss_thekal);
    RegisterCreatureAI(npc_zealot_lorkhan);
    RegisterCreatureAI(npc_zealot_zath);
}
