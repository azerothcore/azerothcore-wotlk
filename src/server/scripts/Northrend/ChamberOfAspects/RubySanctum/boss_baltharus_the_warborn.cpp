/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "ruby_sanctum.h"

enum Texts
{
    SAY_BALTHARUS_INTRO         = 0,
    SAY_AGGRO                   = 1,
    SAY_KILL                    = 2,
    SAY_CLONE                   = 3,
    SAY_DEATH                   = 4,

    SAY_XERESTRASZA_EVENT       = 0,
    SAY_XERESTRASZA_EVENT_1     = 1,
    SAY_XERESTRASZA_EVENT_2     = 2,
    SAY_XERESTRASZA_EVENT_3     = 3,
    SAY_XERESTRASZA_EVENT_4     = 4,
    SAY_XERESTRASZA_EVENT_5     = 5,
    SAY_XERESTRASZA_EVENT_6     = 6,
    SAY_XERESTRASZA_EVENT_7     = 7,
    SAY_XERESTRASZA_INTRO       = 8
};

enum Spells
{
    SPELL_BARRIER_CHANNEL       = 76221,

    SPELL_ENERVATING_BRAND      = 74502,
    SPELL_SIPHONED_MIGHT        = 74507,
    SPELL_CLEAVE                = 40504,
    SPELL_BLADE_TEMPEST         = 75125,
    SPELL_CLONE                 = 74511,
    SPELL_REPELLING_WAVE        = 74509,
    SPELL_CLEAR_DEBUFFS         = 34098,
    SPELL_SPAWN_EFFECT          = 64195
};

enum Events
{
    EVENT_BLADE_TEMPEST         = 1,
    EVENT_CLEAVE                = 2,
    EVENT_ENERVATING_BRAND      = 3,
    EVENT_CHECK_HEALTH1         = 4,
    EVENT_CHECK_HEALTH2         = 5,
    EVENT_CHECK_HEALTH3         = 6,
    EVENT_KILL_TALK             = 7,
    EVENT_SUMMON_CLONE          = 8,

    EVENT_XERESTRASZA_EVENT_0   = 1,
    EVENT_XERESTRASZA_EVENT_1   = 2,
    EVENT_XERESTRASZA_EVENT_2   = 3,
    EVENT_XERESTRASZA_EVENT_3   = 4,
    EVENT_XERESTRASZA_EVENT_4   = 5,
    EVENT_XERESTRASZA_EVENT_5   = 6,
    EVENT_XERESTRASZA_EVENT_6   = 7,
    EVENT_XERESTRASZA_EVENT_7   = 8
};

enum Actions
{
    ACTION_INTRO_BALTHARUS      = -3975101,
    ACTION_BALTHARUS_DEATH      = -3975102,
    ACTION_CLONE                = 1
};

class DelayedTalk : public BasicEvent
{
    public:
        DelayedTalk(Creature* owner, uint32 talkId) : _owner(owner), _talkId(talkId) { }

        bool Execute(uint64 /*execTime*/, uint32 /*diff*/)
        {
            _owner->AI()->Talk(_talkId);
            return true;
        }

    private:
        Creature* _owner;
        uint32 _talkId;
};

class RestoreFight : public BasicEvent
{
    public:
        RestoreFight(Creature* owner) : _owner(owner) { }

        bool Execute(uint64 /*execTime*/, uint32 /*diff*/)
        {
            _owner->SetReactState(REACT_AGGRESSIVE);
            _owner->SetInCombatWithZone();
            return true;
        }

    private:
        Creature* _owner;
};

class boss_baltharus_the_warborn : public CreatureScript
{
    public:
        boss_baltharus_the_warborn() : CreatureScript("boss_baltharus_the_warborn") { }

        struct boss_baltharus_the_warbornAI : public BossAI
        {
            boss_baltharus_the_warbornAI(Creature* creature) : BossAI(creature, DATA_BALTHARUS_THE_WARBORN)
            {
                _introDone = false;
            }

            void Reset()
            {
                BossAI::Reset();
            }

            void InitializeAI()
            {
                BossAI::InitializeAI();
                me->CastSpell(me, SPELL_BARRIER_CHANNEL, false);
            }

            void JustReachedHome()
            {
                BossAI::JustReachedHome();
                me->CastSpell(me, SPELL_BARRIER_CHANNEL, false);
            }

            void DoAction(int32 action)
            {
                if (action == ACTION_INTRO_BALTHARUS && !_introDone)
                {
                    _introDone = true;
                    me->m_Events.AddEvent(new DelayedTalk(me, SAY_BALTHARUS_INTRO), me->m_Events.CalculateTime(6000));
                }
                else if (action == ACTION_CLONE)
                {
                    me->CastSpell(me, SPELL_REPELLING_WAVE, false);
                    me->CastSpell(me, SPELL_CLEAR_DEBUFFS, false);
                    events.ScheduleEvent(EVENT_SUMMON_CLONE, 1000);
                }
            }

            void EnterCombat(Unit* who)
            {
                Talk(SAY_AGGRO);
                BossAI::EnterCombat(who);
                me->InterruptNonMeleeSpells(false);

                events.ScheduleEvent(EVENT_CLEAVE, 11000);
                events.ScheduleEvent(EVENT_ENERVATING_BRAND, 13000);
                events.ScheduleEvent(EVENT_BLADE_TEMPEST, 15000);
                if (!Is25ManRaid())
                    events.ScheduleEvent(EVENT_CHECK_HEALTH1, 1000);
                else
                {
                    events.ScheduleEvent(EVENT_CHECK_HEALTH2, 1000);
                    events.ScheduleEvent(EVENT_CHECK_HEALTH3, 1000);
                }
            }

            void JustDied(Unit* killer)
            {
                Talk(SAY_DEATH);
                BossAI::JustDied(killer);

                if (Creature* xerestrasza = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_XERESTRASZA)))
                    xerestrasza->AI()->DoAction(ACTION_BALTHARUS_DEATH);
            }

            void KilledUnit(Unit*  /*victim*/)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_KILL);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                summon->SetHealth(me->GetHealth());
                summon->CastSpell(summon, SPELL_SPAWN_EFFECT, true);
                summon->SetReactState(REACT_PASSIVE);
                summon->m_Events.AddEvent(new RestoreFight(summon), summon->m_Events.CalculateTime(2000));
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
                    case EVENT_CLEAVE:
                        me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                        events.ScheduleEvent(EVENT_CLEAVE, 24000);
                        break;
                    case EVENT_BLADE_TEMPEST:
                        me->CastSpell(me, SPELL_BLADE_TEMPEST, false);
                        events.ScheduleEvent(EVENT_BLADE_TEMPEST, 24000);
                        break;
                    case EVENT_ENERVATING_BRAND:
                        for (uint8 i = 0; i < RAID_MODE<uint8>(2, 4, 2, 4); i++)
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 45.0f, true, -SPELL_ENERVATING_BRAND))
                                me->CastSpell(target, SPELL_ENERVATING_BRAND, true);
                        events.ScheduleEvent(EVENT_ENERVATING_BRAND, 26000);
                        break;
                    case EVENT_CHECK_HEALTH1:
                        if (me->HealthBelowPct(50))
                        {
                            DoAction(ACTION_CLONE);
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH1, 1000);
                        break;
                    case EVENT_CHECK_HEALTH2:
                        if (me->HealthBelowPct(66))
                        {
                            DoAction(ACTION_CLONE);
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH2, 1000);
                        break;
                    case EVENT_CHECK_HEALTH3:
                        if (me->HealthBelowPct(33))
                        {
                            DoAction(ACTION_CLONE);
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH3, 1000);
                        break;
                    case EVENT_SUMMON_CLONE:
                        me->CastSpell(me, SPELL_CLONE, false);
                        Talk(SAY_CLONE);
                        break;
                }

                DoMeleeAttackIfReady();
            }

        private:
            bool _introDone;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_baltharus_the_warbornAI>(creature);
        }
};

class npc_baltharus_the_warborn_clone : public CreatureScript
{
    public:
        npc_baltharus_the_warborn_clone() : CreatureScript("npc_baltharus_the_warborn_clone") { }

        struct npc_baltharus_the_warborn_cloneAI : public ScriptedAI
        {
            npc_baltharus_the_warborn_cloneAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void EnterCombat(Unit* /*who*/)
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_CLEAVE, urand(5000, 10000));
                _events.ScheduleEvent(EVENT_BLADE_TEMPEST, urand(18000, 25000));
                _events.ScheduleEvent(EVENT_ENERVATING_BRAND, urand(10000, 15000));
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                _events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (_events.ExecuteEvent())
                {
                    case EVENT_CLEAVE:
                        me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                        _events.ScheduleEvent(EVENT_CLEAVE, 24000);
                        break;
                    case EVENT_BLADE_TEMPEST:
                        me->CastSpell(me, SPELL_BLADE_TEMPEST, false);
                        _events.ScheduleEvent(EVENT_BLADE_TEMPEST, 24000);
                       break;
                    case EVENT_ENERVATING_BRAND:
                        for (uint8 i = 0; i < RAID_MODE<uint8>(4, 10, 4, 10); i++)
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 45.0f, true, -SPELL_ENERVATING_BRAND))
                                me->CastSpell(target, SPELL_ENERVATING_BRAND, true);
                        _events.ScheduleEvent(EVENT_ENERVATING_BRAND, 26000);
                        break;
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap _events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<npc_baltharus_the_warborn_cloneAI>(creature);
        }
};

class spell_baltharus_enervating_brand_trigger : public SpellScriptLoader
{
    public:
        spell_baltharus_enervating_brand_trigger() : SpellScriptLoader("spell_baltharus_enervating_brand_trigger") { }

        class spell_baltharus_enervating_brand_trigger_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_baltharus_enervating_brand_trigger_SpellScript);

            void CheckDistance()
            {
                if (Unit* caster = GetOriginalCaster())
                    if (Unit* target = GetHitUnit())
                        if (target == GetCaster() 
                            // the spell has an unlimited range, so we need this check
                            && target->GetDistance2d(caster) <= 12.0f)
                            target->CastSpell(caster, SPELL_SIPHONED_MIGHT, true);
            }

            void Register()
            {
                OnHit += SpellHitFn(spell_baltharus_enervating_brand_trigger_SpellScript::CheckDistance);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_baltharus_enervating_brand_trigger_SpellScript();
        }
};

class npc_xerestrasza : public CreatureScript
{
    public:
        npc_xerestrasza() : CreatureScript("npc_xerestrasza") { }

        struct npc_xerestraszaAI : public ScriptedAI
        {
            npc_xerestraszaAI(Creature* creature) : ScriptedAI(creature)
            {
                _isIntro = true;
                _introDone = false;
            }

            void Reset()
            {
                _events.Reset();
                me->RemoveFlag(UNIT_NPC_FLAGS, GOSSIP_OPTION_QUESTGIVER);

                // Xinef: after soft reset npc is no longer present
                if (me->GetInstanceScript()->GetBossState(DATA_BALTHARUS_THE_WARBORN) == DONE)
                    me->DespawnOrUnsummon(1);
            }

            void DoAction(int32 action)
            {
                if (action == ACTION_BALTHARUS_DEATH)
                {
                    me->setActive(true);
                    _isIntro = false;

                    _events.ScheduleEvent(EVENT_XERESTRASZA_EVENT_0, 6000);
                    _events.ScheduleEvent(EVENT_XERESTRASZA_EVENT_1, 22000);
                    _events.ScheduleEvent(EVENT_XERESTRASZA_EVENT_2, 31000);
                    _events.ScheduleEvent(EVENT_XERESTRASZA_EVENT_3, 38000);
                    _events.ScheduleEvent(EVENT_XERESTRASZA_EVENT_4, 48000);
                    _events.ScheduleEvent(EVENT_XERESTRASZA_EVENT_5, 57000);
                    _events.ScheduleEvent(EVENT_XERESTRASZA_EVENT_6, 67000);
                    _events.ScheduleEvent(EVENT_XERESTRASZA_EVENT_7, 75000);
                }
                else if (action == ACTION_INTRO_BALTHARUS && !_introDone && me->IsAlive())
                {
                    _introDone = true;
                    Talk(SAY_XERESTRASZA_INTRO);
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (_isIntro)
                    return;

                _events.Update(diff);
                switch (_events.ExecuteEvent())
                {
                    case EVENT_XERESTRASZA_EVENT_0:
                        Talk(SAY_XERESTRASZA_EVENT);
                        me->SetWalk(true);
                        me->GetMotionMaster()->MovePoint(0, 3151.236f, 379.8733f, 86.31996f);
                        break;
                    case EVENT_XERESTRASZA_EVENT_1:
                        Talk(SAY_XERESTRASZA_EVENT_1);
                        break;
                    case EVENT_XERESTRASZA_EVENT_2:
                        Talk(SAY_XERESTRASZA_EVENT_2);
                        break;
                    case EVENT_XERESTRASZA_EVENT_3:
                        Talk(SAY_XERESTRASZA_EVENT_3);
                        break;
                    case EVENT_XERESTRASZA_EVENT_4:
                        Talk(SAY_XERESTRASZA_EVENT_4);
                        break;
                    case EVENT_XERESTRASZA_EVENT_5:
                        Talk(SAY_XERESTRASZA_EVENT_5);
                        break;
                    case EVENT_XERESTRASZA_EVENT_6:
                        Talk(SAY_XERESTRASZA_EVENT_6);
                        break;
                    case EVENT_XERESTRASZA_EVENT_7:
                        me->SetFlag(UNIT_NPC_FLAGS, GOSSIP_OPTION_QUESTGIVER);
                        Talk(SAY_XERESTRASZA_EVENT_7);
                        me->setActive(false);
                        break;
                }
            }

        private:
            EventMap _events;
            bool _isIntro;
            bool _introDone;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<npc_xerestraszaAI>(creature);
        }
};

class at_baltharus_plateau : public AreaTriggerScript
{
    public:
        at_baltharus_plateau() : AreaTriggerScript("at_baltharus_plateau") { }

        bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/)
        {
            if (InstanceScript* instance = player->GetInstanceScript())
            {
                if (Creature* xerestrasza = ObjectAccessor::GetCreature(*player, instance->GetData64(NPC_XERESTRASZA)))
                    xerestrasza->AI()->DoAction(ACTION_INTRO_BALTHARUS);

                if (Creature* baltharus = ObjectAccessor::GetCreature(*player, instance->GetData64(NPC_BALTHARUS_THE_WARBORN)))
                    baltharus->AI()->DoAction(ACTION_INTRO_BALTHARUS);
            }

            return true;
        }
};

void AddSC_boss_baltharus_the_warborn()
{
    new boss_baltharus_the_warborn();
    new npc_baltharus_the_warborn_clone();
    new spell_baltharus_enervating_brand_trigger();
    new npc_xerestrasza();
    new at_baltharus_plateau();
}
