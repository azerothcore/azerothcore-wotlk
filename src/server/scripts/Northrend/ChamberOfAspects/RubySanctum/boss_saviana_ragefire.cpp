/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ruby_sanctum.h"

enum Texts
{
    SAY_AGGRO                   = 0,
    SAY_CONFLAGRATION           = 1,
    EMOTE_ENRAGED               = 2,
    SAY_KILL                    = 3
};

enum Spells
{
    SPELL_CONFLAGRATION         = 74452,
    SPELL_FLAME_BEACON          = 74453,
    SPELL_CONFLAGRATION_MISSLE  = 74454,
    SPELL_ENRAGE                = 78722,
    SPELL_FLAME_BREATH          = 74403,
};

enum Events
{
    EVENT_ENRAGE                = 1,
    EVENT_FLIGHT                = 2,
    EVENT_FLAME_BREATH          = 3,
    EVENT_CONFLAGRATION         = 4,
    EVENT_LAND_GROUND           = 5,
    EVENT_AIR_MOVEMENT          = 6,
    EVENT_LAND_BACK             = 7,
    EVENT_KILL_TALK             = 8
};

enum Misc
{
    POINT_FLIGHT                = 1,
    POINT_LAND                  = 2,
    POINT_TAKEOFF               = 3,

    SOUND_ID_DEATH              = 17531
};

class boss_saviana_ragefire : public CreatureScript
{
    public:
        boss_saviana_ragefire() : CreatureScript("boss_saviana_ragefire") { }

        struct boss_saviana_ragefireAI : public BossAI
        {
            boss_saviana_ragefireAI(Creature* creature) : BossAI(creature, DATA_SAVIANA_RAGEFIRE)
            {
            }

            void Reset()
            {
                BossAI::Reset();
                me->SetReactState(REACT_AGGRESSIVE);
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
                Talk(SAY_AGGRO);

                events.ScheduleEvent(EVENT_ENRAGE, 15000);
                events.ScheduleEvent(EVENT_FLAME_BREATH, 10000);
                events.ScheduleEvent(EVENT_FLIGHT, 30000);
            }

            void JustDied(Unit* killer)
            {
                BossAI::JustDied(killer);
                me->PlayDirectSound(SOUND_ID_DEATH);
            }

            void MovementInform(uint32 type, uint32 point)
            {
                if (type != POINT_MOTION_TYPE && type != EFFECT_MOTION_TYPE)
                    return;

                switch (point)
                {
                    case POINT_FLIGHT:
                        me->SetFacingTo(4.69f);
                        events.ScheduleEvent(EVENT_CONFLAGRATION, 1000);
                        events.ScheduleEvent(EVENT_LAND_BACK, 7000);        
                        Talk(SAY_CONFLAGRATION);
                        break;
                    case POINT_LAND:
                        me->SetDisableGravity(false);
                        events.ScheduleEvent(EVENT_LAND_GROUND, 500);
                        break;
                }
            }

            void JustReachedHome()
            {
                BossAI::JustReachedHome();
                me->SetDisableGravity(false);
                me->SetHover(false);
            }

            void KilledUnit(Unit*  /*victim*/)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_KILL);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
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
                    case EVENT_FLIGHT:
                    {
                        me->SetReactState(REACT_PASSIVE);
                        me->AttackStop();
                        me->SetDisableGravity(true);
                        me->GetMotionMaster()->MovePoint(POINT_TAKEOFF, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+6.0f, false);
                        events.ScheduleEvent(EVENT_FLIGHT, 50000);
                        events.DelayEvents(15000);
                        events.ScheduleEvent(EVENT_AIR_MOVEMENT, 2000);
                        break;
                    }
                    case EVENT_CONFLAGRATION:
                        me->CastCustomSpell(SPELL_CONFLAGRATION, SPELLVALUE_MAX_TARGETS, RAID_MODE(3, 6, 3, 6), me, true);
                        break;
                    case EVENT_ENRAGE:
                        me->CastSpell(me, SPELL_ENRAGE, false);
                        Talk(EMOTE_ENRAGED);
                        events.ScheduleEvent(EVENT_ENRAGE, urand(15000, 20000));
                        break;
                    case EVENT_FLAME_BREATH:
                        me->CastSpell(me->GetVictim(), SPELL_FLAME_BREATH, false);
                        events.ScheduleEvent(EVENT_FLAME_BREATH, urand(20000, 30000));
                        break;
                    case EVENT_AIR_MOVEMENT:
                        me->GetMotionMaster()->MovePoint(POINT_FLIGHT, 3155.51f, 683.844f, 95.0f, false);
                        break;
                    case EVENT_LAND_BACK:
                        me->GetMotionMaster()->MovePoint(POINT_LAND, 3151.07f, 636.443f, 80.0f, false);
                        break;
                    case EVENT_LAND_GROUND:
                        me->SetReactState(REACT_AGGRESSIVE);
                        if (me->GetVictim())
                            me->GetMotionMaster()->MoveChase(me->GetVictim());
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_saviana_ragefireAI>(creature);
        }
};

class spell_saviana_conflagration_init : public SpellScriptLoader
{
    public:
        spell_saviana_conflagration_init() : SpellScriptLoader("spell_saviana_conflagration_init") { }

        class spell_saviana_conflagration_init_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_saviana_conflagration_init_SpellScript);

            void HandleDummy(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                GetCaster()->CastSpell(GetHitUnit(), SPELL_FLAME_BEACON, true);
                GetCaster()->CastSpell(GetHitUnit(), SPELL_CONFLAGRATION_MISSLE, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_saviana_conflagration_init_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_saviana_conflagration_init_SpellScript();
        }
};

class spell_saviana_conflagration_throwback : public SpellScriptLoader
{
    public:
        spell_saviana_conflagration_throwback() : SpellScriptLoader("spell_saviana_conflagration_throwback") { }

        class spell_saviana_conflagration_throwback_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_saviana_conflagration_throwback_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                GetHitUnit()->CastSpell(GetCaster(), uint32(GetEffectValue()), true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_saviana_conflagration_throwback_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_saviana_conflagration_throwback_SpellScript();
        }
};

void AddSC_boss_saviana_ragefire()
{
    new boss_saviana_ragefire();
    new spell_saviana_conflagration_init();
    new spell_saviana_conflagration_throwback();
}
