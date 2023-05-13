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
#include "hellfire_ramparts.h"

enum Says
{
    SAY_INTRO                       = 0,
    SAY_WIPE                        = 0,
    SAY_AGGRO                       = 1,
    SAY_KILL                        = 2,
    SAY_DIE                         = 3,
    EMOTE_NAZAN                     = 0
};

enum Spells
{
    SPELL_FIREBALL                  = 33793,
    SPELL_SUMMON_LIQUID_FIRE        = 31706,
    SPELL_REVENGE                   = 19130,
    SPELL_REVENGE_H                 = 40392,
    SPELL_CALL_NAZAN                = 30693,
    SPELL_BELLOWING_ROAR            = 39427,
    SPELL_CONE_OF_FIRE              = 30926
};

enum Misc
{
    ACTION_FLY_DOWN                 = 0,

    POINT_MIDDLE                    = 0,
    POINT_FLIGHT                    = 1,

    EVENT_KILL_TALK                 = 1,
};

enum GroupPhase
{
    GROUP_PHASE_1                   = 0,
    GROUP_PHASE_2                   = 1
};

const Position NazanPos[3] =
{
    {-1430.37f, 1710.03f, 111.0f, 0.0f},
    {-1428.40f, 1772.09f, 111.0f, 0.0f},
    {-1373.84f, 1771.57f, 111.0f, 0.0f}
};

class boss_vazruden_the_herald : public CreatureScript
{
public:
    boss_vazruden_the_herald() : CreatureScript("boss_vazruden_the_herald") { }

    struct boss_vazruden_the_heraldAI : public BossAI
    {
        boss_vazruden_the_heraldAI(Creature* creature) : BossAI(creature, DATA_VAZRUDEN)
        {
        }

        void Reset() override
        {
            BossAI::Reset();
            me->SetVisible(true);
            me->SetReactState(REACT_PASSIVE);
            me->SummonCreature(NPC_HELLFIRE_SENTRY, -1372.56f, 1724.31f, 82.967f, 5.3058f);
            me->SummonCreature(NPC_HELLFIRE_SENTRY, -1383.39f, 1711.82f, 82.7961f, 5.67232f);
        }

        void AttackStart(Unit*) override
        {
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            if (summon->GetEntry() != NPC_HELLFIRE_SENTRY)
                summon->SetInCombatWithZone();
        }

        void JustDied(Unit*) override
        {
            instance->SetBossState(DATA_VAZRUDEN, DONE);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == POINT_MIDDLE)
            {
                me->SetVisible(false);
                me->SummonCreature(NPC_VAZRUDEN, me->GetPositionX(), me->GetPositionY(), 81.2f, 5.46f);
                me->SummonCreature(NPC_NAZAN, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 5.46f);
            }
        }

        void SummonedCreatureDies(Creature* summon, Unit*) override
        {
            summons.Despawn(summon);
            if (summon->GetEntry() == NPC_HELLFIRE_SENTRY && summons.size() == 0)
            {
                Talk(SAY_INTRO);
                me->GetMotionMaster()->MovePoint(POINT_MIDDLE, -1406.5f, 1746.5f, 85.0f, false);
                me->setActive(true);
            }
            else if (summons.size() == 0)
            {
                me->KillSelf();
            }
        }

        void SummonedCreatureDespawn(Creature* summon) override
        {
            summons.Despawn(summon);
            if (summon->GetEntry() != NPC_HELLFIRE_SENTRY)
                BossAI::EnterEvadeMode();
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == 0 && data == 1)
            {
                summons.DoZoneInCombat(NPC_HELLFIRE_SENTRY);
            }
        }

        void UpdateAI(uint32  /*diff*/) override
        {
            if (!me->IsVisible() && summons.size() == 0)
                BossAI::EnterEvadeMode();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHellfireRampartsAI<boss_vazruden_the_heraldAI>(creature);
    }
};

class boss_nazan : public CreatureScript
{
public:
    boss_nazan() : CreatureScript("boss_nazan") { }

    struct boss_nazanAI : public BossAI
    {
        boss_nazanAI(Creature* creature) : BossAI(creature, DATA_VAZRUDEN)
        {
            scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
        }

        void Reset() override
        {
            me->SetCanFly(true);
            me->SetDisableGravity(true);
            events.Reset();
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            me->DespawnOrUnsummon(1);
        }

        void JustEngagedWith(Unit*) override
        {
            scheduler.CancelGroup(GROUP_PHASE_2);
            scheduler.Schedule(5ms, GROUP_PHASE_1, [this](TaskContext context)
            {
                me->GetMotionMaster()->MovePoint(POINT_FLIGHT, NazanPos[urand(0, 2)], false);
                scheduler.DelayAll(7s);
                context.Repeat(30s);
            }).Schedule(5s, GROUP_PHASE_1, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_FIREBALL);
                context.Repeat(4s, 6s);
            });
        }

        void AttackStart(Unit* who) override
        {
            if (me->IsLevitating())
                me->Attack(who, true);
            else
                ScriptedAI::AttackStart(who);
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_FLY_DOWN)
            {
                Talk(EMOTE_NAZAN);
                events.Reset();
                me->SetReactState(REACT_PASSIVE);
                me->InterruptNonMeleeSpells(true);
                me->GetMotionMaster()->MovePoint(POINT_MIDDLE, -1406.5f, 1746.5f, 81.2f, false);
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == POINT_MIDDLE)
            {
                me->SetCanFly(false);
                me->SetDisableGravity(false);
                me->SetReactState(REACT_AGGRESSIVE);
                scheduler.CancelGroup(GROUP_PHASE_1);
                me->GetMotionMaster()->MoveChase(me->GetVictim());

                scheduler.Schedule(5s, GROUP_PHASE_2, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_CONE_OF_FIRE);
                    context.Repeat(12s);
                }).Schedule(6s, GROUP_PHASE_2, [this](TaskContext context)
                {
                    DoCastRandomTarget(SPELL_FIREBALL);
                    context.Repeat(4s, 6s);
                });
                if (IsHeroic())
                {
                    scheduler.Schedule(10s, GROUP_PHASE_2, [this](TaskContext context)
                    {
                        DoCastSelf(SPELL_BELLOWING_ROAR);
                        context.Repeat(30s);
                    });
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (!me->IsLevitating())
                DoMeleeAttackIfReady();
        }

    private:
        EventMap events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHellfireRampartsAI<boss_nazanAI>(creature);
    }
};

class boss_vazruden : public CreatureScript
{
public:
    boss_vazruden() : CreatureScript("boss_vazruden") { }

    struct boss_vazrudenAI : public BossAI
    {
        boss_vazrudenAI(Creature* creature) : BossAI(creature, DATA_VAZRUDEN)
        {
            scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
        }

        void Reset() override
        {
            events.Reset();
            _nazanCalled = false;
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            Talk(SAY_WIPE);
            me->DespawnOrUnsummon(1);
        }

        void JustEngagedWith(Unit*) override
        {
            scheduler.Schedule(5s, [this](TaskContext /*context*/)
            {
                Talk(SAY_AGGRO);
            }).Schedule(4s, [this](TaskContext context)
            {
                DoCastVictim(DUNGEON_MODE(SPELL_REVENGE, SPELL_REVENGE_H));
                context.Repeat(6s);
            });
        }

        void KilledUnit(Unit*) override
        {
            if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
            {
                Talk(SAY_KILL);
                events.ScheduleEvent(EVENT_KILL_TALK, 6000);
            }
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*type*/, SpellSchoolMask /*school*/) override
        {
            if (!_nazanCalled && me->HealthBelowPctDamaged(35, damage))
            {
                _nazanCalled = true;
                me->CastSpell(me, SPELL_CALL_NAZAN, true);
            }
        }

        void JustDied(Unit*) override
        {
            Talk(SAY_DIE);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

    private:
        EventMap events;
        bool _nazanCalled;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHellfireRampartsAI<boss_vazrudenAI>(creature);
    }
};

class spell_vazruden_fireball : public SpellScriptLoader
{
public:
    spell_vazruden_fireball() : SpellScriptLoader("spell_vazruden_fireball") { }

    class spell_vazruden_fireball_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_vazruden_fireball_SpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            if (Unit* target = GetHitUnit())
                target->CastSpell(target, SPELL_SUMMON_LIQUID_FIRE, true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_vazruden_fireball_SpellScript::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_vazruden_fireball_SpellScript();
    }
};

class spell_vazruden_call_nazan : public SpellScriptLoader
{
public:
    spell_vazruden_call_nazan() : SpellScriptLoader("spell_vazruden_call_nazan") { }

    class spell_vazruden_call_nazan_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_vazruden_call_nazan_SpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            if (Unit* target = GetHitUnit())
                target->GetAI()->DoAction(ACTION_FLY_DOWN);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_vazruden_call_nazan_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_vazruden_call_nazan_SpellScript();
    }
};

void AddSC_boss_vazruden_the_herald()
{
    new boss_vazruden_the_herald();
    new boss_vazruden();
    new boss_nazan();
    new spell_vazruden_fireball();
    new spell_vazruden_call_nazan();
}
