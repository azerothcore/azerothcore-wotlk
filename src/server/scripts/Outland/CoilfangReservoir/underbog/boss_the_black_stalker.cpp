/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_the_black_stalker
SD%Complete: 95
SDComment: Timers may be incorrect
SDCategory: Coilfang Resevoir, Underbog
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"

enum eBlackStalker
{
    SPELL_LEVITATE                  = 31704,
    SPELL_SUSPENSION                = 31719,
    SPELL_LEVITATION_PULSE          = 31701,
    SPELL_MAGNETIC_PULL             = 31705,
    SPELL_CHAIN_LIGHTNING           = 31717,
    SPELL_STATIC_CHARGE             = 31715,
    SPELL_SUMMON_SPORE_STRIDER      = 38755,

    EVENT_LEVITATE                  = 1,
    EVENT_SPELL_CHAIN               = 2,
    EVENT_SPELL_STATIC              = 3,
    EVENT_SPELL_SPORES              = 4,
    EVENT_CHECK                     = 5,
    EVENT_LEVITATE_TARGET_1         = 6,
    EVENT_LEVITATE_TARGET_2         = 7,

    ENTRY_SPORE_STRIDER             = 22299
};

class boss_the_black_stalker : public CreatureScript
{
public:
    boss_the_black_stalker() : CreatureScript("boss_the_black_stalker") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_the_black_stalkerAI (creature);
    }

    struct boss_the_black_stalkerAI : public ScriptedAI
    {
        boss_the_black_stalkerAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
        }

        EventMap events;
        SummonList summons;
        uint64 lTarget;

        void Reset()
        {
            events.Reset();
            summons.DespawnAll();
            lTarget = 0;
        }

        void EnterCombat(Unit*)
        {
            events.ScheduleEvent(EVENT_LEVITATE, 12000);
            events.ScheduleEvent(EVENT_SPELL_CHAIN, 6000);
            events.ScheduleEvent(EVENT_SPELL_STATIC, 10000);
            events.ScheduleEvent(EVENT_CHECK, 5000);
            if (IsHeroic())
                events.ScheduleEvent(EVENT_SPELL_SPORES, urand(10000, 15000));
        }


        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);
            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                summon->AI()->AttackStart(target);
            else if (me->GetVictim())
                summon->AI()->AttackStart(me->GetVictim());
        }

        void SummonedCreatureDies(Creature* summon, Unit*)
        {
            summons.Despawn(summon);
            for (uint8 i = 0; i < 3; ++i)
                me->CastSpell(me, SPELL_SUMMON_SPORE_STRIDER, false);
        }

        void JustDied(Unit*)
        {
            summons.DespawnAll();
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (events.GetEvent())
            {
                case EVENT_CHECK:
                    float x, y, z, o;
                    me->GetHomePosition(x, y, z, o);
                    if (!me->IsWithinDist3d(x, y, z, 60))
                    {
                        EnterEvadeMode();
                        return;
                    }
                    events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_SPORES:
                    me->CastSpell(me, SPELL_SUMMON_SPORE_STRIDER, false);
                    events.RepeatEvent(urand(10000, 15000));
                    break;
                case EVENT_SPELL_CHAIN:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        me->CastSpell(target, SPELL_CHAIN_LIGHTNING, false);
                    events.DelayEvents(3000);
                    events.RepeatEvent(9000);
                    break;
                case EVENT_SPELL_STATIC:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 30, true))
                        me->CastSpell(target, SPELL_STATIC_CHARGE, false);
                    events.RepeatEvent(10000);
                    break;
                case EVENT_LEVITATE:
                    events.RepeatEvent(15000);
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                    {
                        me->CastSpell(target, SPELL_LEVITATE, false);
                        lTarget = target->GetGUID();
                        events.DelayEvents(5000);
                        events.ScheduleEvent(EVENT_LEVITATE_TARGET_1, 2000);
                    }
                    break;
                case EVENT_LEVITATE_TARGET_1:
                    if (Unit* target = ObjectAccessor::GetUnit(*me, lTarget))
                    {
                        if (!target->HasAura(SPELL_LEVITATE))
                            lTarget = 0;
                        else
                        {
                            target->CastSpell(target, SPELL_MAGNETIC_PULL, true);
                            events.ScheduleEvent(EVENT_LEVITATE_TARGET_2, 1500);
                        }
                    }
                    events.PopEvent();
                    break;
                case EVENT_LEVITATE_TARGET_2:
                    if (Unit* target = ObjectAccessor::GetUnit(*me, lTarget))
                    {
                        if (!target->HasAura(SPELL_LEVITATE))
                            lTarget = 0;
                        else
                        {
                            target->AddAura(SPELL_SUSPENSION, target);
                            lTarget = 0;
                        }
                    }
                    events.PopEvent();
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_gen_allergies : public SpellScriptLoader
{
public:
    spell_gen_allergies() : SpellScriptLoader("spell_gen_allergies") { }

    class spell_gen_allergies_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_gen_allergies_AuraScript);

        void CalcPeriodic(AuraEffect const* /*effect*/, bool& isPeriodic, int32& amplitude)
        {
            isPeriodic = true;
            amplitude = urand(10*IN_MILLISECONDS, 200*IN_MILLISECONDS);
        }

        void Update(AuraEffect*  /*effect*/)
        {
            SetDuration(0);
        }

        void Register()
        {
            DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_gen_allergies_AuraScript::CalcPeriodic, EFFECT_0, SPELL_AURA_DUMMY);
            OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_gen_allergies_AuraScript::Update, EFFECT_0, SPELL_AURA_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_gen_allergies_AuraScript();
    }
};

void AddSC_boss_the_black_stalker()
{
    new boss_the_black_stalker();
    new spell_gen_allergies();
}
