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
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Unit.h"
#include "karazhan.h"

enum Texts
{
    SAY_KILL                     = 0,
    SAY_RANDOM                   = 1,
    SAY_DISARMED                 = 2,
    SAY_MIDNIGHT_KILL            = 3,
    SAY_APPEAR                   = 4,
    SAY_MOUNT                    = 5,

    SAY_DEATH                    = 3,

    // Midnight
    EMOTE_CALL_ATTUMEN           = 0,
    EMOTE_MOUNT_UP               = 1
};

enum Spells
{
    // Attumen
    SPELL_SHADOWCLEAVE           = 29832,
    SPELL_INTANGIBLE_PRESENCE    = 29833,
    SPELL_SPAWN_SMOKE            = 10389,
    SPELL_CHARGE                 = 29847,
    // Midnight
    SPELL_KNOCKDOWN              = 29711,
    SPELL_SUMMON_ATTUMEN         = 29714,
    SPELL_MOUNT                  = 29770,
    SPELL_SUMMON_ATTUMEN_MOUNTED = 29799
};

enum Phases
{
    PHASE_NONE,
    PHASE_ATTUMEN_ENGAGES,
    PHASE_MOUNTED
};

enum Actions
{
    ACTION_SET_MIDNIGHT_PHASE
};

struct boss_attumen : public BossAI
{
    boss_attumen(Creature* creature) : BossAI(creature, DATA_ATTUMEN)
    {
        Initialize();
    }

    void Initialize()
    {
        _phase = PHASE_NONE;
    }

    void Reset() override
    {
        Initialize();
    }

    bool CanMeleeHit()
    {
        return me->GetVictim() && (me->GetVictim()->GetPositionZ() < 53.0f || me->GetVictim()->GetDistance(me->GetHomePosition()) < 50.0f);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (Creature* midnight = instance->GetCreature(DATA_MIDNIGHT))
        {
            midnight->AI()->EnterEvadeMode(why);
        }
        me->DespawnOrUnsummon();
    }

    void ScheduleTasks() override
    {
        scheduler.Schedule(15s, 25s, [this](TaskContext task)
        {
            DoCastVictim(SPELL_SHADOWCLEAVE);
            task.Repeat(15s, 25s);
        });
        scheduler.Schedule(25s, 45s, [this](TaskContext task)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
            {
                DoCast(target, SPELL_INTANGIBLE_PRESENCE);
            }

            task.Repeat(25s, 45s);
        });
        scheduler.Schedule(30s, 1min, [this](TaskContext task)
        {
            Talk(SAY_RANDOM);
            task.Repeat(30s, 1min);
        });
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        // Attumen does not die until he mounts Midnight, let health fall to 1 and prevent further damage.
        if (damage >= me->GetHealth() && _phase != PHASE_MOUNTED)
        {
            damage = me->GetHealth() - 1;
        }
        if (_phase == PHASE_ATTUMEN_ENGAGES && me->HealthBelowPctDamaged(25, damage))
        {
            _phase = PHASE_NONE;

            if (Creature* midnight = instance->GetCreature(DATA_MIDNIGHT))
            {
                midnight->AI()->DoCastAOE(SPELL_MOUNT, true);
            }
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_KILL);
        }
    }

    void JustSummoned(Creature* summon) override
    {
        if (summon->GetEntry() == NPC_ATTUMEN_THE_HUNTSMAN_MOUNTED)
        {
            if (Creature* midnight = instance->GetCreature(DATA_MIDNIGHT))
            {
                if (midnight->GetHealth() > me->GetHealth())
                {
                    summon->SetHealth(midnight->GetHealth());
                }
                else
                {
                    summon->SetHealth(me->GetHealth());
                }
                summon->AI()->DoZoneInCombat();
            }
        }
        BossAI::JustSummoned(summon);
    }

    void IsSummonedBy(WorldObject* summoner) override
    {
        if (summoner->GetEntry() == NPC_MIDNIGHT)
        {
            _phase = PHASE_ATTUMEN_ENGAGES;
        }
        if (summoner->GetEntry() == NPC_ATTUMEN_THE_HUNTSMAN)
        {
            _phase = PHASE_MOUNTED;
            DoCastSelf(SPELL_SPAWN_SMOKE);
            scheduler.Schedule(10s, 25s, [this](TaskContext task)
            {
                Unit* target = nullptr;
                std::vector<Unit*> target_list;
                for (auto* ref : me->GetThreatMgr().GetUnsortedThreatList())
                {
                    target = ref->GetVictim();
                    if (target && !target->IsWithinDist(me, 8.00f, false) && target->IsWithinDist(me, 25.0f, false))
                    {
                        target_list.push_back(target);
                    }
                    target = nullptr;
                }
                if (!target_list.empty())
                {
                    target = Acore::Containers::SelectRandomContainerElement(target_list);
                }
                DoCast(target, SPELL_CHARGE);
                task.Repeat(10s, 25s);
            });
            scheduler.Schedule(25s, 35s, [this](TaskContext task)
            {
                DoCastVictim(SPELL_KNOCKDOWN);
                task.Repeat(25s, 35s);
            });
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);
        if (Creature* midnight = instance->GetCreature(DATA_MIDNIGHT))
        {
            midnight->KillSelf();
        }
        _JustDied();
    }

    void UpdateAI(uint32 diff) override
    {
        if (_phase != PHASE_NONE)
        {
            if (!UpdateVictim())
            {
                return;
            }
        }
        if (!CanMeleeHit())
        {
            BossAI::EnterEvadeMode(EvadeReason::EVADE_REASON_BOUNDARY);
        }
        scheduler.Update(diff, std::bind(&BossAI::DoMeleeAttackIfReady, this));
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Mechanic == MECHANIC_DISARM)
        {
            Talk(SAY_DISARMED);
        }

        if (spellInfo->Id == SPELL_MOUNT)
        {
            if (Creature* midnight = instance->GetCreature(DATA_MIDNIGHT))
            {
                _phase = PHASE_NONE;
                scheduler.CancelAll();
                midnight->AI()->DoAction(ACTION_SET_MIDNIGHT_PHASE);
                midnight->AttackStop();
                midnight->RemoveAllAttackers();
                midnight->SetReactState(REACT_PASSIVE);
                midnight->GetMotionMaster()->MoveFollow(me, 2.0f, 0.0f);
                midnight->AI()->Talk(EMOTE_MOUNT_UP);
                me->AttackStop();
                me->RemoveAllAttackers();
                me->SetReactState(REACT_PASSIVE);
                me->GetMotionMaster()->MoveFollow(midnight, 2.0f, 0.0f);
                Talk(SAY_MOUNT);
                scheduler.Schedule(1s, [this](TaskContext task)
                {
                    if (Creature* midnight = instance->GetCreature(DATA_MIDNIGHT))
                    {
                        if (me->IsWithinDist2d(midnight, 5.0f))
                        {
                            DoCastAOE(SPELL_SUMMON_ATTUMEN_MOUNTED);
                            me->DespawnOrUnsummon(1s, 0s);
                            midnight->SetVisible(false);
                        }
                        else
                        {
                            midnight->GetMotionMaster()->MoveFollow(me, 2.0f, 0.0f);
                            me->GetMotionMaster()->MoveFollow(midnight, 2.0f, 0.0f);
                            task.Repeat();
                        }
                    }
                });
            }
        }
    }

private:
    uint8 _phase;
};

struct boss_midnight : public BossAI
{
    boss_midnight(Creature* creature) : BossAI(creature, DATA_ATTUMEN), _phase(PHASE_NONE) { }

    void Reset() override
    {
        BossAI::Reset();
        me->SetVisible(true);
        me->SetReactState(REACT_DEFENSIVE);
    }

    bool CanMeleeHit()
    {
        return me->GetVictim() && (me->GetVictim()->GetPositionZ() < 53.0f || me->GetVictim()->GetDistance(me->GetHomePosition()) < 50.0f);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        // Midnight never dies, let health fall to 1 and prevent further damage.
        if (damage >= me->GetHealth())
        {
            damage = me->GetHealth() - 1;
        }

        if (_phase == PHASE_NONE && me->HealthBelowPctDamaged(95, damage))
        {
            _phase = PHASE_ATTUMEN_ENGAGES;
            Talk(EMOTE_CALL_ATTUMEN);
            DoCastAOE(SPELL_SUMMON_ATTUMEN);
        }
        else if (_phase == PHASE_ATTUMEN_ENGAGES && me->HealthBelowPctDamaged(25, damage))
        {
            _phase = PHASE_MOUNTED;
            DoCastAOE(SPELL_MOUNT, true);
        }
    }

    void JustSummoned(Creature* summon) override
    {
        if (summon->GetEntry() == NPC_ATTUMEN_THE_HUNTSMAN)
        {
            summon->AI()->AttackStart(me->GetVictim());
            summon->AI()->Talk(SAY_APPEAR);
        }
        BossAI::JustSummoned(summon);
    }

    void DoAction(int32 actionId) override
    {
        if (actionId == ACTION_SET_MIDNIGHT_PHASE)
        {
            _phase = PHASE_MOUNTED;
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        scheduler.Schedule(15s, 25s, [this](TaskContext task)
        {
            DoCastVictim(SPELL_KNOCKDOWN);
            task.Repeat(15s, 25s);
        });
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        me->DespawnOnEvade(10s);
        _phase = PHASE_NONE;
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        if (_phase == PHASE_ATTUMEN_ENGAGES)
        {
            if (Creature* attumen = instance->GetCreature(DATA_ATTUMEN))
            {
                Talk(SAY_MIDNIGHT_KILL, attumen);
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (_phase != PHASE_MOUNTED)
        {
            if (!UpdateVictim())
            {
                return;
            }
            if (!CanMeleeHit())
            {
                BossAI::EnterEvadeMode(EvadeReason::EVADE_REASON_BOUNDARY);
            }
        }
        scheduler.Update(diff, std::bind(&BossAI::DoMeleeAttackIfReady, this));
    }

private:
    uint8 _phase;
};

class spell_midnight_fixate : public AuraScript
{
    PrepareAuraScript(spell_midnight_fixate)

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (Unit* caster = GetCaster())
        {
            caster->TauntApply(target);
        }
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (Unit* caster = GetCaster())
        {
            caster->TauntFadeOut(target);
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_midnight_fixate::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_midnight_fixate::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_attumen()
{
    RegisterKarazhanCreatureAI(boss_midnight);
    RegisterKarazhanCreatureAI(boss_attumen);
    RegisterSpellScript(spell_midnight_fixate);
}
