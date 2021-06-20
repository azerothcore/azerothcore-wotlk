/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "drak_tharon_keep.h"
#include "SpellScript.h"

enum Spells
{
    SPELL_BELLOWING_ROAR                = 22686,
    SPELL_GRIEVOUS_BITE                 = 48920,
    SPELL_MANGLING_SLASH                = 48873,
    SPELL_FEARSOME_ROAR                 = 48849,
    SPELL_PIERCING_SLASH                = 48878,
    SPELL_RAPTOR_CALL                   = 59416
};

enum Misc
{
    NPC_DRAKKARI_SCYTHECLAW             = 26628,
    NPC_DRAKKARI_GUTRIPPER              = 26641,

    SAY_CLAW_EMOTE                      = 0,

    EVENT_SPELL_BELLOWING_ROAR          = 1,
    EVENT_SPELL_GRIEVOUS_BITE           = 2,
    EVENT_SPELL_MANGLING_SLASH          = 3,
    EVENT_SPELL_FEARSOME_ROAR           = 4,
    EVENT_SPELL_PIERCING_SLASH          = 5,
    EVENT_SPELL_RAPTOR_CALL             = 6,
    EVENT_MENACING_CLAW                 = 7
};

class boss_dred : public CreatureScript
{
    public:
        boss_dred() : CreatureScript("boss_dred") {}

        CreatureAI *GetAI(Creature *creature) const
        {
            return GetInstanceAI<boss_dredAI>(creature);
        }

        struct boss_dredAI : public BossAI
        {
            boss_dredAI(Creature* creature) : BossAI(creature, DATA_DRED)
            {
            }

            void Reset()
            {
                BossAI::Reset();
                _raptorCount = 0;
            }

            uint32 GetData(uint32 data) const
            {
                if (data == me->GetEntry())
                    return uint32(_raptorCount);
                return 0;
            }

            void SetData(uint32 type, uint32)
            {
                if (type == me->GetEntry())
                    ++_raptorCount;
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
                _raptorCount = 0;

                events.ScheduleEvent(EVENT_SPELL_BELLOWING_ROAR, 33000);
                events.ScheduleEvent(EVENT_SPELL_GRIEVOUS_BITE, 20000);
                events.ScheduleEvent(EVENT_SPELL_MANGLING_SLASH, 18500);
                events.ScheduleEvent(EVENT_SPELL_FEARSOME_ROAR, urand(10000,20000));
                events.ScheduleEvent(EVENT_SPELL_PIERCING_SLASH, 17000);
                if (IsHeroic())
                {
                    events.ScheduleEvent(EVENT_MENACING_CLAW, 21000);
                    events.ScheduleEvent(EVENT_SPELL_RAPTOR_CALL, urand(20000,25000));
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_SPELL_BELLOWING_ROAR:
                        me->CastSpell(me, SPELL_BELLOWING_ROAR, false);
                        events.ScheduleEvent(EVENT_SPELL_BELLOWING_ROAR, 40000);
                        break;
                    case EVENT_SPELL_GRIEVOUS_BITE:
                        me->CastSpell(me->GetVictim(), SPELL_GRIEVOUS_BITE, false);
                        events.ScheduleEvent(EVENT_SPELL_GRIEVOUS_BITE, 20000);
                        break;
                    case EVENT_SPELL_MANGLING_SLASH:
                        me->CastSpell(me->GetVictim(), SPELL_MANGLING_SLASH, false);
                        events.ScheduleEvent(EVENT_SPELL_MANGLING_SLASH, 20000);
                        break;
                    case EVENT_SPELL_FEARSOME_ROAR:
                        me->CastSpell(me, SPELL_FEARSOME_ROAR, false);
                        events.ScheduleEvent(EVENT_SPELL_FEARSOME_ROAR, 17000);
                        break;
                    case EVENT_SPELL_PIERCING_SLASH:
                        me->CastSpell(me->GetVictim(), SPELL_PIERCING_SLASH, false);
                        events.ScheduleEvent(EVENT_SPELL_PIERCING_SLASH, 20000);
                        break;
                    case EVENT_SPELL_RAPTOR_CALL:
                        me->CastSpell(me, SPELL_RAPTOR_CALL, false);
                        events.ScheduleEvent(EVENT_SPELL_RAPTOR_CALL, 20000);
                        break;
                    case EVENT_MENACING_CLAW:
                        Talk(SAY_CLAW_EMOTE);
                        me->setAttackTimer(BASE_ATTACK, 2000);
                        me->AttackerStateUpdate(me->GetVictim());
                        if (me->GetVictim())
                            me->AttackerStateUpdate(me->GetVictim());
                        if (me->GetVictim())
                            me->AttackerStateUpdate(me->GetVictim());
                        events.ScheduleEvent(EVENT_MENACING_CLAW, 20000);
                        break;
                }

                DoMeleeAttackIfReady();
            }

        private:
            uint8 _raptorCount;
        };
};

class spell_dred_grievious_bite : public SpellScriptLoader
{
    public:
        spell_dred_grievious_bite() : SpellScriptLoader("spell_dred_grievious_bite") { }

        class spell_dred_grievious_bite_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dred_grievious_bite_AuraScript);

            void OnPeriodic(AuraEffect const* /*aurEff*/)
            {
                if (Unit* target = GetTarget())
                    if (target->GetHealth() == target->GetMaxHealth())
                    {
                        PreventDefaultAction();
                        SetDuration(0);
                    }
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_dred_grievious_bite_AuraScript::OnPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dred_grievious_bite_AuraScript();
        }
};

class spell_dred_raptor_call : public SpellScriptLoader
{
    public:
        spell_dred_raptor_call() : SpellScriptLoader("spell_dred_raptor_call") { }

        class spell_dred_raptor_call_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dred_raptor_call_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                GetCaster()->SummonCreature(RAND(NPC_DRAKKARI_GUTRIPPER, NPC_DRAKKARI_SCYTHECLAW), -522.02f, -718.89f, 30.26f, 2.41f);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dred_raptor_call_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dred_raptor_call_SpellScript();
        }
};

class achievement_better_off_dred : public AchievementCriteriaScript
{
    public:
        achievement_better_off_dred() : AchievementCriteriaScript("achievement_better_off_dred")
        {
        }

        bool OnCheck(Player* /*player*/, Unit* target)
        {
            if (!target)
                return false;

            return target->GetAI()->GetData(target->GetEntry());
        }
};

void AddSC_boss_dred()
{
    new boss_dred();
    new spell_dred_grievious_bite();
    new spell_dred_raptor_call();
    new achievement_better_off_dred();
}
