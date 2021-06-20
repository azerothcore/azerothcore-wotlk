/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
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

    EVENT_SPELL_REVENGE             = 1,
    EVENT_KILL_TALK                 = 2,
    EVENT_AGGRO_TALK                = 3,
    EVENT_SPELL_FIREBALL            = 4,
    EVENT_SPELL_CONE_OF_FIRE        = 5,
    EVENT_SPELL_BELLOWING_ROAR      = 6,
    EVENT_CHANGE_POS                = 7,
    EVENT_RESTORE_COMBAT            = 8
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

            void Reset()
            {
                BossAI::Reset();
                me->SetVisible(true);
                me->SetReactState(REACT_PASSIVE);
                me->SummonCreature(NPC_HELLFIRE_SENTRY, -1372.56f, 1724.31f, 82.967f, 5.3058f);
                me->SummonCreature(NPC_HELLFIRE_SENTRY, -1383.39f, 1711.82f, 82.7961f, 5.67232f);
            }

            void AttackStart(Unit*)
            {
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                if (summon->GetEntry() != NPC_HELLFIRE_SENTRY)
                    summon->SetInCombatWithZone();
            }

            void JustDied(Unit*)
            {
                instance->SetBossState(DATA_VAZRUDEN, DONE);
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type == POINT_MOTION_TYPE && id == POINT_MIDDLE)
                {
                    me->SetVisible(false);
                    me->SummonCreature(NPC_VAZRUDEN, me->GetPositionX(), me->GetPositionY(), 81.2f, 5.46f);
                    me->SummonCreature(NPC_NAZAN, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 5.46f);
                }
            }

            void SummonedCreatureDies(Creature* summon, Unit*)
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
                    Unit::Kill(me, me);
                }
            }

            void SummonedCreatureDespawn(Creature* summon)
            {
                summons.Despawn(summon);
                if (summon->GetEntry() != NPC_HELLFIRE_SENTRY)
                    BossAI::EnterEvadeMode();
            }

            void UpdateAI(uint32  /*diff*/)
            {
                if (!me->IsVisible() && summons.size() == 0)
                    BossAI::EnterEvadeMode();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_vazruden_the_heraldAI(creature);
        }
};

class boss_nazan : public CreatureScript
{
    public:
        boss_nazan() : CreatureScript("boss_nazan") { }

        struct boss_nazanAI : public ScriptedAI
        {
            boss_nazanAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void Reset()
            {
                me->SetCanFly(true);
                me->SetDisableGravity(true);
                events.Reset();
            }

            void EnterEvadeMode()
            {
                me->DespawnOrUnsummon(1);
            }

            void EnterCombat(Unit*)
            {
                events.ScheduleEvent(EVENT_CHANGE_POS, 0);
                events.ScheduleEvent(EVENT_SPELL_FIREBALL, 5000);
            }

            void AttackStart(Unit* who)
            {
                if (me->IsLevitating())
                    me->Attack(who, true);
                else
                    ScriptedAI::AttackStart(who);
            }

            void DoAction(int32 param)
            {
                if (param == ACTION_FLY_DOWN)
                {
                    Talk(EMOTE_NAZAN);
                    events.Reset();
                    me->GetMotionMaster()->MovePoint(POINT_MIDDLE, -1406.5f, 1746.5f, 81.2f, false);
                }
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type == POINT_MOTION_TYPE && id == POINT_MIDDLE)
                {
                    me->SetDisableGravity(false);
                    me->SetCanFly(false);
                    events.ScheduleEvent(EVENT_RESTORE_COMBAT, 0);
                    events.ScheduleEvent(EVENT_SPELL_CONE_OF_FIRE, 5000);
                    if (IsHeroic())
                        events.ScheduleEvent(EVENT_SPELL_BELLOWING_ROAR, 10000);
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
                    case EVENT_SPELL_FIREBALL:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            me->CastSpell(target, SPELL_FIREBALL, false);
                        events.ScheduleEvent(EVENT_SPELL_FIREBALL, urand(4000, 6000));
                        break;
                    case EVENT_CHANGE_POS:
                        me->GetMotionMaster()->MovePoint(POINT_FLIGHT, NazanPos[urand(0,2)], false);
                        events.DelayEvents(7000);
                        events.ScheduleEvent(EVENT_CHANGE_POS, 30000);
                        break;
                    case EVENT_RESTORE_COMBAT:
                        me->GetMotionMaster()->MoveChase(me->GetVictim());
                        break;
                    case EVENT_SPELL_CONE_OF_FIRE:
                        me->CastSpell(me->GetVictim(), SPELL_CONE_OF_FIRE, false);
                        events.ScheduleEvent(EVENT_SPELL_CONE_OF_FIRE, 12000);
                        break;
                    case EVENT_SPELL_BELLOWING_ROAR:
                        me->CastSpell(me, SPELL_BELLOWING_ROAR, false);
                        events.ScheduleEvent(EVENT_SPELL_BELLOWING_ROAR, 30000);
                        break;
                }

                if (!me->IsLevitating())
                    DoMeleeAttackIfReady();
            }

            private:
                EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_nazanAI(creature);
        }
};

class boss_vazruden : public CreatureScript
{
    public:
        boss_vazruden() : CreatureScript("boss_vazruden") { }

        struct boss_vazrudenAI : public ScriptedAI
        {
            boss_vazrudenAI(Creature* creature) : ScriptedAI(creature) { }

            void Reset()
            {
                events.Reset();
            }

            void EnterEvadeMode()
            {
                Talk(SAY_WIPE);
                me->DespawnOrUnsummon(1);
            }

            void EnterCombat(Unit*)
            {
                events.ScheduleEvent(EVENT_AGGRO_TALK, 5000);
                events.ScheduleEvent(EVENT_SPELL_REVENGE, 4000);
            }

            void KilledUnit(Unit*)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_KILL);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void JustDied(Unit*)
            {
                me->CastSpell(me, SPELL_CALL_NAZAN, true);
                Talk(SAY_DIE);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                switch (events.ExecuteEvent())
                {
                    case EVENT_AGGRO_TALK:
                        Talk(SAY_AGGRO);
                        break;
                    case EVENT_SPELL_REVENGE:
                        me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_REVENGE, SPELL_REVENGE_H), false);
                        events.ScheduleEvent(EVENT_SPELL_REVENGE, 6000);
                        break;
                }

                DoMeleeAttackIfReady();
            }

            private:
                EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_vazrudenAI(creature);
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

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_vazruden_fireball_SpellScript::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
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

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_vazruden_call_nazan_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
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
