/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "gundrak.h"
#include "SpellScript.h"

enum Spells
{
    SPELL_MOJO_PUDDLE                   = 55627,
    SPELL_MOJO_WAVE                     = 55626,
    SPELL_FREEZE_ANIM                   = 52656,
    SPELL_MIGHTY_BLOW                   = 54719,
    SPELL_MORTAL_STRIKE                 = 54715,

    SPELL_ELEMENTAL_SPAWN_EFFECT        = 54888,
    SPELL_EMERGE                        = 54850,
    SPELL_EMERGE_SUMMON                 = 54851,
    SPELL_MOJO_VOLLEY                   = 54849,

    SPELL_SURGE_VISUAL                  = 54827,
    SPELL_SURGE                         = 54801,
    SPELL_SURGE_DAMAGE                  = 54819,

    SPELL_FACE_ME                       = 54991,
    SPELL_MERGE                         = 54878,
};

enum Misc
{
    NPC_LIVING_MOJO                     = 29830,
    NPC_DRAKKARI_ELEMENTAL              = 29573,

    ACTION_MERGE                        = 1,
    ACTION_INFORM                       = 2,

    POINT_MERGE                         = 1,
    SAY_SURGE                           = 0,
    EMOTE_ALTAR                         = 1,

    EVENT_COLOSSUS_MIGHTY_BLOW          = 1,
    EVENT_COLOSSUS_MORTAL_STRIKE        = 2,
    EVENT_COLOSSUS_HEALTH_1             = 3,
    EVENT_COLOSSUS_HEALTH_2             = 4,
    EVENT_COLOSSUS_START_FIGHT          = 5,

    EVENT_ELEMENTAL_HEALTH              = 10,
    EVENT_ELEMENTAL_SURGE               = 11,
    EVENT_ELEMENTAL_VOLLEY              = 12,

    EVENT_MOJO_MOJO_WAVE                = 20,
    EVENT_MOJO_MOJO_PUDDLE              = 21,
};

static Position mojoPosition[] =
{
    {1663.1f, 743.6f, 143.1f, 0.0f},
    {1669.97f, 753.7f, 143.1f, 0.0f},
    {1680.7f, 750.7f, 143.1f, 0.0f},
    {1680.7f, 737.1f, 143.1f, 0.0f},
    {1670.4f, 733.5f, 143.1f, 0.0f}
};

class RestoreFight : public BasicEvent
{
public:
    RestoreFight(Creature* owner) : _owner(owner) { }

    bool Execute(uint64 /*execTime*/, uint32 /*diff*/) override
    {
        _owner->SetReactState(REACT_AGGRESSIVE);
        _owner->SetInCombatWithZone();
        return true;
    }

private:
    Creature* _owner;
};

class boss_drakkari_colossus : public CreatureScript
{
public:
    boss_drakkari_colossus() : CreatureScript("boss_drakkari_colossus") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetGundrakAI<boss_drakkari_colossusAI>(creature);
    }
    struct boss_drakkari_colossusAI : public BossAI
    {
        boss_drakkari_colossusAI(Creature* creature) : BossAI(creature, DATA_DRAKKARI_COLOSSUS)
        {
        }

        void MoveInLineOfSight(Unit*  /*who*/) override
        {
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_INFORM)
            {
                me->SetInCombatWithZone();
                summons.DoAction(ACTION_MERGE);
                events.ScheduleEvent(EVENT_COLOSSUS_START_FIGHT, 3500ms);
            }
        }

        void Reset() override
        {
            BossAI::Reset();
            if (!me->IsInEvadeMode())
            {
              me->CastSpell(me, SPELL_FREEZE_ANIM, true);
              me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
              for (const auto & i : mojoPosition)
                  me->SummonCreature(NPC_LIVING_MOJO, i.GetPositionX(), i.GetPositionY(), i.GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN, 0);
            }
            else
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            }
        }

        void JustReachedHome() override
        {
            BossAI::JustReachedHome();
            me->CastSpell(me, SPELL_FREEZE_ANIM, true);
        }

        void ScheduleTasks() override
        {
            events.ScheduleEvent(EVENT_COLOSSUS_START_FIGHT, 1s);
            events.ScheduleEvent(EVENT_COLOSSUS_MIGHTY_BLOW, 10s);
            events.ScheduleEvent(EVENT_COLOSSUS_MORTAL_STRIKE, 7s);
            events.ScheduleEvent(EVENT_COLOSSUS_HEALTH_1, 1s);
            events.ScheduleEvent(EVENT_COLOSSUS_HEALTH_2, 1s);
        }

        void JustSummoned(Creature* summon) override
        {
            if (summon->GetEntry() == NPC_DRAKKARI_ELEMENTAL)
            {
                summon->SetRegeneratingHealth(false);
                summon->SetReactState(REACT_PASSIVE);
                summon->m_Events.AddEventAtOffset(new RestoreFight(summon), 3s);
                if (!events.HasTimeUntilEvent(EVENT_COLOSSUS_HEALTH_2))
                {
                    summon->SetHealth(summon->GetMaxHealth() / 2);
                    summon->LowerPlayerDamageReq(summon->GetMaxHealth() / 2);
                    summon->AI()->DoAction(ACTION_INFORM);
                }
            }

            summons.Summon(summon);
        }

        void SummonedCreatureDies(Creature* summon, Unit*) override
        {
            summons.Despawn(summon);
            if (summon->GetEntry() == NPC_DRAKKARI_ELEMENTAL)
                me->KillSelf();
        }

        void SummonedCreatureDespawn(Creature* summon) override
        {
            summons.Despawn(summon);
            if (summon->GetEntry() == NPC_DRAKKARI_ELEMENTAL)
            {
                me->SetHealth(me->GetMaxHealth() / 2);
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->RemoveAurasDueToSpell(SPELL_FREEZE_ANIM);
                if (me->GetVictim())
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
            }
        }

        void DamageTaken(Unit*  /*attacker*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
                damage = 0;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_COLOSSUS_START_FIGHT:
                    me->RemoveAurasDueToSpell(SPELL_FREEZE_ANIM);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    break;
                case EVENT_COLOSSUS_MIGHTY_BLOW:
                    me->CastSpell(me->GetVictim(), SPELL_MIGHTY_BLOW, false);
                    events.ScheduleEvent(EVENT_COLOSSUS_MIGHTY_BLOW, 10s);
                    break;
                case EVENT_COLOSSUS_MORTAL_STRIKE:
                    DoCastVictim(SPELL_MORTAL_STRIKE);
                    events.ScheduleEvent(EVENT_COLOSSUS_MORTAL_STRIKE, 7s);
                    break;
                case EVENT_COLOSSUS_HEALTH_1:
                    if (me->HealthBelowPct(51))
                    {
                        me->CastSpell(me, SPELL_EMERGE, false);
                        me->CastSpell(me, SPELL_EMERGE_SUMMON, true);
                        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        me->GetMotionMaster()->Clear();
                        break;
                    }
                    events.ScheduleEvent(EVENT_COLOSSUS_HEALTH_1, 1s);
                    break;
                case EVENT_COLOSSUS_HEALTH_2:
                    if (me->HealthBelowPct(2))
                    {
                        me->CastSpell(me, SPELL_EMERGE, false);
                        me->CastSpell(me, SPELL_EMERGE_SUMMON, true);
                        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        me->GetMotionMaster()->Clear();
                        break;
                    }
                    events.ScheduleEvent(EVENT_COLOSSUS_HEALTH_2, 1s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class boss_drakkari_elemental : public CreatureScript
{
public:
    boss_drakkari_elemental() : CreatureScript("boss_drakkari_elemental") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetGundrakAI<boss_drakkari_elementalAI>(pCreature);
    }

    struct boss_drakkari_elementalAI : public ScriptedAI
    {
        boss_drakkari_elementalAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            events.ScheduleEvent(EVENT_ELEMENTAL_HEALTH, 1s);
            events.ScheduleEvent(EVENT_ELEMENTAL_SURGE, 7s);
            events.ScheduleEvent(EVENT_ELEMENTAL_VOLLEY, 0ms);
        }

        EventMap events;

        void DoAction(int32 param) override
        {
            if (param == ACTION_INFORM)
                events.CancelEvent(EVENT_ELEMENTAL_HEALTH);
        }

        void Reset() override
        {
            me->CastSpell(me, SPELL_ELEMENTAL_SPAWN_EFFECT, false);
        }

        void JustDied(Unit*) override
        {
            Talk(EMOTE_ALTAR);
        }

        void JustEngagedWith(Unit*) override
        {
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING) || me->HasUnitState(UNIT_STATE_CHARGING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_ELEMENTAL_HEALTH:
                    if (me->HealthBelowPct(56))
                    {
                        me->CastSpell(me, SPELL_FACE_ME, true);
                        me->CastSpell(me, SPELL_SURGE_VISUAL, true);
                        me->CastSpell(me, SPELL_MERGE, false);
                        me->DespawnOrUnsummon(2s);
                        events.Reset();
                        break;
                    }
                    events.ScheduleEvent(EVENT_ELEMENTAL_HEALTH, 1s);
                    break;
                case EVENT_ELEMENTAL_SURGE:
                    Talk(SAY_SURGE);
                    me->CastSpell(me, SPELL_SURGE_VISUAL, true);
                    DoCastRandomTarget(SPELL_SURGE, 0, 40, true, false, true);
                    events.ScheduleEvent(EVENT_ELEMENTAL_SURGE, 15s);
                    break;
                case EVENT_ELEMENTAL_VOLLEY:
                    me->CastSpell(me, SPELL_MOJO_VOLLEY, true);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_living_mojo : public CreatureScript
{
public:
    npc_living_mojo() : CreatureScript("npc_living_mojo") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetGundrakAI<npc_living_mojoAI>(pCreature);
    }

    struct npc_living_mojoAI : public ScriptedAI
    {
        npc_living_mojoAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
        }

        EventMap events;

        void Reset() override
        {
            events.Reset();
            events.ScheduleEvent(EVENT_MOJO_MOJO_PUDDLE, 13s);
            events.ScheduleEvent(EVENT_MOJO_MOJO_WAVE, 15s);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (me->ToTempSummon())
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void AttackStart(Unit* who) override
        {
            if (me->ToTempSummon())
            {
                if (who->IsPlayer() || who->GetOwnerGUID().IsPlayer())
                    if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                        summoner->GetAI()->DoAction(ACTION_INFORM);
                return;
            }

            ScriptedAI::AttackStart(who);
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_MERGE)
            {
                me->SetReactState(REACT_PASSIVE);
                me->GetMotionMaster()->MoveCharge(1672.96f, 743.488f, 143.338f, 7.0f, POINT_MERGE);
                me->DespawnOrUnsummon(1200ms);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (me->ToTempSummon() || !UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_MOJO_MOJO_PUDDLE:
                    {
                        me->CastSpell(me, SPELL_MOJO_PUDDLE, false);
                        events.ScheduleEvent(EVENT_MOJO_MOJO_PUDDLE, 13s);
                        break;
                    }
                case EVENT_MOJO_MOJO_WAVE:
                    {
                        me->CastSpell(me->GetVictim(), SPELL_MOJO_WAVE, false);
                        events.ScheduleEvent(EVENT_MOJO_MOJO_WAVE, 15s);
                        break;
                    }
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_drakkari_colossus_emerge : public SpellScript
{
    PrepareSpellScript(spell_drakkari_colossus_emerge);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FREEZE_ANIM });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetCaster(), SPELL_FREEZE_ANIM, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_drakkari_colossus_emerge::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_drakkari_colossus_surge : public SpellScript
{
    PrepareSpellScript(spell_drakkari_colossus_surge);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SURGE_DAMAGE });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, SPELL_SURGE_DAMAGE, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_drakkari_colossus_surge::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_drakkari_colossus_face_me : public SpellScript
{
    PrepareSpellScript(spell_drakkari_colossus_face_me);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            GetCaster()->SetInFront(target);
            GetCaster()->SetFacingTo(GetCaster()->GetAngle(target));
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_drakkari_colossus_face_me::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_drakkari_colossus()
{
    new boss_drakkari_colossus();
    new boss_drakkari_elemental();
    new npc_living_mojo();
    RegisterSpellScript(spell_drakkari_colossus_emerge);
    RegisterSpellScript(spell_drakkari_colossus_surge);
    RegisterSpellScript(spell_drakkari_colossus_face_me);
}
