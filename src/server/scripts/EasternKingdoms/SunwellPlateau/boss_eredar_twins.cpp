/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "sunwell_plateau.h"
#include "SpellInfo.h"

enum Quotes
{
    YELL_INTRO_SAC              = 0,
    YELL_SAC_DEAD               = 4,
    EMOTE_SHADOW_NOVA           = 5,
    YELL_ENRAGE                 = 6,
    YELL_SISTER_ALYTHESS_DEAD   = 7,
    YELL_SAC_KILL               = 8,
    YELL_SHADOW_NOVA            = 9,

    YELL_INTRO_ALY              = 0,
    EMOTE_CONFLAGRATION         = 4,
    YELL_ALY_KILL               = 5,
    YELL_ALY_DEAD               = 6,
    YELL_SISTER_SACROLASH_DEAD  = 7,
    YELL_CANFLAGRATION          = 8,
    YELL_BERSERK                = 9
};

enum Spells
{
    //Shared spells
    SPELL_ENRAGE                = 46587,
    SPELL_EMPOWER               = 45366,
    SPELL_DARK_FLAME            = 45345,

    //Lady Sacrolash spells
    SPELL_SHADOWFORM            = 45455,
    SPELL_DARK_TOUCHED          = 45347,
    SPELL_SHADOW_BLADES         = 45248,
    SPELL_SHADOW_NOVA           = 45329,
    SPELL_CONFOUNDING_BLOW      = 45256,

    //Grand Warlock Alythess spells
    SPELL_FIREFORM              = 45457,
    SPELL_FLAME_TOUCHED         = 45348,
    SPELL_PYROGENICS            = 45230,
    SPELL_CONFLAGRATION         = 45342,
    SPELL_FLAME_SEAR            = 46771,
    SPELL_BLAZE                 = 45235,
    SPELL_BLAZE_SUMMON          = 45236
};

enum Misc
{
    ACTION_SISTER_DIED          = 1,

    EVENT_SPELL_SHADOW_BLADES   = 1,
    EVENT_SPELL_SHADOW_NOVA     = 2,
    EVENT_SPELL_CONFOUNDING_BLOW= 3,
    EVENT_SHADOW_IMAGE          = 4,
    EVENT_SPELL_ENRAGE          = 5,
    EVENT_SPELL_CONFLAGRATION   = 6,
    EVENT_SPELL_BLAZE           = 7,
    EVENT_SPELL_PYROGENICS      = 8,
    EVENT_SPELL_FLAME_SEAR      = 9
};

class boss_sacrolash : public CreatureScript
{
public:
    boss_sacrolash() : CreatureScript("boss_sacrolash") { }

    struct boss_sacrolashAI : public BossAI
    {
        boss_sacrolashAI(Creature* creature) : BossAI(creature, DATA_EREDAR_TWINS) {}

        bool sisterDied;
        void Reset()
        {
            me->CastSpell(me, SPELL_SHADOWFORM, true);
            sisterDied = false;
            BossAI::Reset();
            me->SetLootMode(0);
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_SISTER_DIED)
            {
                me->ResetLootMode();
                sisterDied = true;
                Talk(YELL_SISTER_ALYTHESS_DEAD);
                me->CastSpell(me, SPELL_EMPOWER, true);

                uint32 timer = events.GetNextEventTime(EVENT_SPELL_SHADOW_NOVA);
                events.CancelEvent(EVENT_SPELL_SHADOW_NOVA);
                events.ScheduleEvent(EVENT_SPELL_CONFLAGRATION, timer-events.GetTimer());
            }
        }

        void EnterEvadeMode()
        {
            BossAI::EnterEvadeMode();
            if (Creature* alythess = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_GRAND_WARLOCK_ALYTHESS)))
            {
                if (!alythess->IsAlive())
                    alythess->Respawn(true);
                else if (!alythess->IsInEvadeMode())
                    alythess->AI()->EnterEvadeMode();
            }
        }

        void EnterCombat(Unit* who)
        {
            BossAI::EnterCombat(who);
            if (Creature* alythess = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_GRAND_WARLOCK_ALYTHESS)))
                if (alythess->IsAlive() && !alythess->IsInCombat())
                    alythess->AI()->AttackStart(who);

            events.ScheduleEvent(EVENT_SPELL_SHADOW_BLADES, 10000);
            events.ScheduleEvent(EVENT_SPELL_SHADOW_NOVA, 36000);
            events.ScheduleEvent(EVENT_SPELL_CONFOUNDING_BLOW, 25000);
            events.ScheduleEvent(EVENT_SHADOW_IMAGE, 20000);
            events.ScheduleEvent(EVENT_SPELL_ENRAGE, 360000);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER && urand(0,1))
                Talk(YELL_SAC_KILL);
        }

        void JustDied(Unit* /*killer*/)
        {
            events.Reset();
            summons.DespawnAll();

            if (sisterDied)
            {
                Talk(YELL_SAC_DEAD);
                instance->SetBossState(DATA_EREDAR_TWINS, DONE);
            }
            else if (Creature* alythess = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_GRAND_WARLOCK_ALYTHESS)))
                alythess->AI()->DoAction(ACTION_SISTER_DIED);
        }

        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);
            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true))
            {
                summon->AI()->AttackStart(target);
                summon->AddThreat(target, 10000000);
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
                case EVENT_SPELL_ENRAGE:
                    Talk(YELL_ENRAGE);
                    me->CastSpell(me, SPELL_ENRAGE, true);
                    break;
                case EVENT_SPELL_CONFOUNDING_BLOW:
                    me->CastSpell(me->GetVictim(), SPELL_CONFOUNDING_BLOW, false);
                    events.ScheduleEvent(EVENT_SPELL_CONFOUNDING_BLOW, urand(20000, 25000));
                    break;
                case EVENT_SPELL_SHADOW_BLADES:
                    me->CastSpell(me, SPELL_SHADOW_BLADES, false);
                    events.ScheduleEvent(EVENT_SPELL_SHADOW_BLADES, 10000);
                    break;
                case EVENT_SPELL_SHADOW_NOVA:
                {
                    Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 1, 100.0f);
                    if (!target)
                        target = me->GetVictim();
                    Talk(EMOTE_SHADOW_NOVA, target);
                    Talk(YELL_SHADOW_NOVA);
                    me->CastSpell(target, SPELL_SHADOW_NOVA, false);
                    events.ScheduleEvent(EVENT_SPELL_SHADOW_NOVA, urand(30000, 35000));
                    break;
                }
                case EVENT_SHADOW_IMAGE:
                    me->SummonCreature(NPC_SHADOW_IMAGE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 12000);
                    events.ScheduleEvent(EVENT_SHADOW_IMAGE, 6000);
                    break;
                case EVENT_SPELL_CONFLAGRATION:
                {
                    Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 1, 100.0f);
                    if (!target)
                        target = me->GetVictim();
                    me->CastSpell(target, SPELL_CONFLAGRATION, false);
                    events.ScheduleEvent(EVENT_SPELL_CONFLAGRATION, urand(30000, 35000));
                    break;
                }   
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_sacrolashAI>(creature);
    };
};

class boss_alythess : public CreatureScript
{
public:
    boss_alythess() : CreatureScript("boss_alythess") { }

    struct boss_alythessAI : public BossAI
    {
        boss_alythessAI(Creature* creature) : BossAI(creature, DATA_EREDAR_TWINS) { }

        bool sisterDied;
        void Reset()
        {
            me->CastSpell(me, SPELL_FIREFORM, true);
            sisterDied = false;
            BossAI::Reset();
            me->SetLootMode(0);
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_SISTER_DIED)
            {
                me->ResetLootMode();
                sisterDied = true;
                Talk(YELL_SISTER_SACROLASH_DEAD);
                me->CastSpell(me, SPELL_EMPOWER, true);

                uint32 timer = events.GetNextEventTime(EVENT_SPELL_CONFLAGRATION);
                events.CancelEvent(EVENT_SPELL_CONFLAGRATION);
                events.ScheduleEvent(EVENT_SPELL_SHADOW_NOVA, timer-events.GetTimer());
            }
        }

        void EnterEvadeMode()
        {
            BossAI::EnterEvadeMode();
            if (Creature* scorlash = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_LADY_SACROLASH)))
            {
                if (!scorlash->IsAlive())
                    scorlash->Respawn(true);
                else if (!scorlash->IsInEvadeMode())
                    scorlash->AI()->EnterEvadeMode();
            }
        }

        void EnterCombat(Unit* who)
        {
            BossAI::EnterCombat(who);
            if (Creature* scorlash = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_LADY_SACROLASH)))
                if (scorlash->IsAlive() && !scorlash->IsInCombat())
                    scorlash->AI()->AttackStart(who);

            events.ScheduleEvent(EVENT_SPELL_BLAZE, 100);
            events.ScheduleEvent(EVENT_SPELL_PYROGENICS, 15000);
            events.ScheduleEvent(EVENT_SPELL_FLAME_SEAR, 20000);
            events.ScheduleEvent(EVENT_SPELL_CONFLAGRATION, 30000);
            events.ScheduleEvent(EVENT_SPELL_ENRAGE, 360000);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER && urand(0,1))
                Talk(YELL_SAC_KILL);
        }

        void JustDied(Unit* /*killer*/)
        {
            events.Reset();
            summons.DespawnAll();

            if (sisterDied)
            {
                Talk(YELL_SAC_DEAD);
                instance->SetBossState(DATA_EREDAR_TWINS, DONE);
            }
            else if (Creature* scorlash = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_LADY_SACROLASH)))
                scorlash->AI()->DoAction(ACTION_SISTER_DIED);
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
                case EVENT_SPELL_ENRAGE:
                    Talk(YELL_BERSERK);
                    me->CastSpell(me, SPELL_ENRAGE, true);
                    break;
                case EVENT_SPELL_PYROGENICS:
                    me->CastSpell(me, SPELL_PYROGENICS, false);
                    events.ScheduleEvent(EVENT_SPELL_PYROGENICS, 15000);
                    break;
                case EVENT_SPELL_FLAME_SEAR:
                    me->CastCustomSpell(SPELL_FLAME_SEAR, SPELLVALUE_MAX_TARGETS, 5, me, TRIGGERED_NONE);
                    events.ScheduleEvent(EVENT_SPELL_FLAME_SEAR, 15000);
                    break;
                case EVENT_SPELL_BLAZE:
                    me->CastSpell(me->GetVictim(), SPELL_BLAZE, false);
                    events.ScheduleEvent(EVENT_SPELL_BLAZE, 3800);
                    break;
                case EVENT_SPELL_SHADOW_NOVA:
                {
                    Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 1, 100.0f);
                    if (!target)
                        target = me->GetVictim();
                    me->CastSpell(target, SPELL_SHADOW_NOVA, false);
                    events.ScheduleEvent(EVENT_SPELL_SHADOW_NOVA, urand(30000, 35000));
                    break;
                }
                case EVENT_SPELL_CONFLAGRATION:
                {
                    Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 1, 100.0f);
                    if (!target)
                        target = me->GetVictim();
                    Talk(EMOTE_CONFLAGRATION, target);
                    Talk(YELL_CANFLAGRATION);
                    me->CastSpell(target, SPELL_CONFLAGRATION, false);
                    events.ScheduleEvent(EVENT_SPELL_CONFLAGRATION, urand(30000, 35000));
                    break;
                }   
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_alythessAI>(creature);
    };
};

class spell_eredar_twins_apply_dark_touched : public SpellScriptLoader
{
    public:
        spell_eredar_twins_apply_dark_touched() : SpellScriptLoader("spell_eredar_twins_apply_dark_touched") { }

        class spell_eredar_twins_apply_dark_touched_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_eredar_twins_apply_dark_touched_SpellScript);

            void HandleApplyTouch()
            {
                if (Player* target = GetHitPlayer())
                    target->CastSpell(target, SPELL_DARK_TOUCHED, true);
            }

            void Register()
            {
                AfterHit += SpellHitFn(spell_eredar_twins_apply_dark_touched_SpellScript::HandleApplyTouch);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_eredar_twins_apply_dark_touched_SpellScript();
        }
};

class spell_eredar_twins_apply_flame_touched : public SpellScriptLoader
{
    public:
        spell_eredar_twins_apply_flame_touched() : SpellScriptLoader("spell_eredar_twins_apply_flame_touched") { }

        class spell_eredar_twins_apply_flame_touched_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_eredar_twins_apply_flame_touched_SpellScript);

            void HandleApplyTouch()
            {
                if (Player* target = GetHitPlayer())
                    target->CastSpell(target, SPELL_FLAME_TOUCHED, true);
            }

            void Register()
            {
                AfterHit += SpellHitFn(spell_eredar_twins_apply_flame_touched_SpellScript::HandleApplyTouch);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_eredar_twins_apply_flame_touched_SpellScript();
        }
};

class spell_eredar_twins_handle_touch : public SpellScriptLoader
{
    public:
        spell_eredar_twins_handle_touch() : SpellScriptLoader("spell_eredar_twins_handle_touch") { }

        class spell_eredar_twins_handle_touch_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_eredar_twins_handle_touch_SpellScript);

            SpellCastResult CheckCast()
            {
                if (GetCaster()->HasAura(SPELL_DARK_FLAME))
                    return SPELL_FAILED_DONT_REPORT;

                if (GetSpellInfo()->Id == SPELL_DARK_TOUCHED)
                {
                    if (GetCaster()->HasAura(SPELL_FLAME_TOUCHED))
                    {
                        GetCaster()->RemoveAurasDueToSpell(SPELL_FLAME_TOUCHED);
                        GetCaster()->CastSpell(GetCaster(), SPELL_DARK_FLAME, true);
                        return SPELL_FAILED_DONT_REPORT;
                    }
                }
                else // if (m_spellInfo->Id == SPELL_FLAME_TOUCHED)
                {
                    if (GetCaster()->HasAura(SPELL_DARK_TOUCHED))
                    {
                        GetCaster()->RemoveAurasDueToSpell(SPELL_DARK_TOUCHED);
                        GetCaster()->CastSpell(GetCaster(), SPELL_DARK_FLAME, true);
                        return SPELL_FAILED_DONT_REPORT;
                    }
                }
                return SPELL_CAST_OK;
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_eredar_twins_handle_touch_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_eredar_twins_handle_touch_SpellScript();
        }
};

class spell_eredar_twins_blaze : public SpellScriptLoader
{
    public:
        spell_eredar_twins_blaze() : SpellScriptLoader("spell_eredar_twins_blaze") { }

        class spell_eredar_twins_blaze_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_eredar_twins_blaze_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                    target->CastSpell(target, SPELL_BLAZE_SUMMON, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_eredar_twins_blaze_SpellScript::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_eredar_twins_blaze_SpellScript();
        }
};

class AreaTrigger_at_sunwell_eredar_twins : public AreaTriggerScript
{
    public:

        AreaTrigger_at_sunwell_eredar_twins() : AreaTriggerScript("at_sunwell_eredar_twins") {}

        bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/)
        {
            if (InstanceScript* instance = player->GetInstanceScript())
                if (instance->GetBossState(DATA_EREDAR_TWINS_INTRO) != DONE)
                {
                    instance->SetBossState(DATA_EREDAR_TWINS_INTRO, DONE);
                    if (Creature* creature = ObjectAccessor::GetCreature(*player, instance->GetData64(NPC_LADY_SACROLASH)))
                        creature->AI()->Talk(YELL_INTRO_SAC);
                    if (Creature* creature = ObjectAccessor::GetCreature(*player, instance->GetData64(NPC_GRAND_WARLOCK_ALYTHESS)))
                        creature->AI()->Talk(YELL_INTRO_ALY);
                }

            return true;
        }
};

void AddSC_boss_eredar_twins()
{
    new boss_sacrolash();
    new boss_alythess();
    new spell_eredar_twins_apply_dark_touched();
    new spell_eredar_twins_apply_flame_touched();
    new spell_eredar_twins_handle_touch();
    new spell_eredar_twins_blaze();
    new AreaTrigger_at_sunwell_eredar_twins();
}
