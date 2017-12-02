/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-AGPL
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "black_temple.h"
#include "Spell.h"

enum Says
{
    //Suffering
    SUFF_SAY_FREED                      = 0,
    SUFF_SAY_AGGRO                      = 1,
    SUFF_SAY_SLAY                       = 2,
    SUFF_SAY_RECAP                      = 3,
    SUFF_SAY_AFTER                      = 4,
    SUFF_SAY_ENRAGE                     = 5,
    SUFF_EMOTE_ENRAGE                   = 6,

    //Desire
    DESI_SAY_FREED                      = 0,
    DESI_SAY_SLAY                       = 1,
    DESI_SAY_SPEC                       = 2,
    DESI_SAY_RECAP                      = 3,
    DESI_SAY_AFTER                      = 4,

    //Anger
    ANGER_SAY_FREED                     = 0,
    ANGER_SAY_SLAY                      = 1,
    ANGER_SAY_SPEC                      = 2,
    ANGER_SAY_RECAP                     = 3,
    ANGER_SAY_DEATH                     = 4
};

enum Spells
{
    SPELL_EMERGE_VISUAL                 = 50142,
    SPELL_SUMMON_ESSENCE_OF_SUFFERING   = 41488,
    SPELL_SUMMON_ESSENCE_OF_DESIRE      = 41493,
    SPELL_SUMMON_ESSENCE_OF_ANGER       = 41496,
    SPELL_SUMMON_ENSLAVED_SOUL          = 41537,

    // Suffering
    SPELL_AURA_OF_SUFFERING             = 41292,
    SPELL_AURA_OF_SUFFERING_TRIGGER     = 42017,
    SPELL_ESSENCE_OF_SUFFERING_PASSIVE  = 41296,
    SPELL_ESSENCE_OF_SUFFERING_PASSIVE2 = 41623,
    SPELL_FRENZY                        = 41305,
    SPELL_SOUL_DRAIN                    = 41303,

    // Desire
    SPELL_AURA_OF_DESIRE                = 41350,
    SPELL_AURA_OF_DESIRE_DAMAGE         = 41352,
    SPELL_RUNE_SHIELD                   = 41431,
    SPELL_DEADEN                        = 41410,
    SPELL_SPIRIT_SHOCK                  = 41426,

    // Anger
    SPELL_AURA_OF_ANGER                 = 41337,
    SPELL_SPITE                         = 41376,
    SPELL_SPITE_DAMAGE                  = 41377,
    SPELL_SOUL_SCREAM                   = 41545,
    SPELL_SEETHE                        = 41364
};

enum Misc
{
    ACTION_ESSENCE_OF_SUFFERING     = 1,
    ACTION_ESSENCE_OF_DESIRE        = 2,
    ACTION_ESSENCE_OF_ANGER         = 3,
    ACTION_ENGAGE_ESSENCE           = 4,

    EVENT_ESSENCE_OF_SUFFERING      = 1,
    EVENT_ESSENCE_OF_DESIRE         = 2,
    EVENT_ESSENCE_OF_ANGER          = 3,
    EVENT_ENGAGE_ESSENCE            = 4,
    EVENT_SPAWN_ENSLAVED_SOULS      = 5,
    EVENT_SPAWN_SOUL                = 6,
    EVENT_SUCK_ESSENCE              = 7,

    EVENT_SUFF_FRENZY               = 10,
    EVENT_SUFF_FRENZY_EMOTE         = 11,
    EVENT_SUFF_SOUL_DRAIN           = 12,

    EVENT_DESI_DEADEN               = 20,
    EVENT_DESI_SPIRIT_SHOCK         = 21,
    EVENT_DESI_RUNE_SHIELD          = 22,

    EVENT_ANGER_SPITE               = 30,
    EVENT_ANGER_SOUL_SCREAM         = 31,
    EVENT_ANGER_SEETHE              = 32,

    EVENT_KILL_TALK                 = 100,
    POINT_GO_BACK                   = 1
};

class SuckBackEvent : public BasicEvent
{
    public:
        SuckBackEvent(Creature& owner, uint32 action) : BasicEvent(), _owner(owner), _action(action) { }

        bool Execute(uint64 /*eventTime*/, uint32 /*diff*/)
        {
            if (_owner.IsSummon())
                if (Unit* summoner = _owner.ToTempSummon()->GetSummoner())
                {
                    summoner->GetAI()->DoAction(_action);
                    _owner.SetStandState(UNIT_STAND_STATE_SUBMERGED);
                    _owner.DespawnOrUnsummon(200);
                }
            return true;
        }

    private:
        Creature& _owner;
        uint32 _action;
};

class boss_reliquary_of_souls : public CreatureScript
{
    public:
        boss_reliquary_of_souls() : CreatureScript("boss_reliquary_of_souls") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_reliquary_of_soulsAI>(creature);
        }

        struct boss_reliquary_of_soulsAI : public BossAI
        {
            boss_reliquary_of_soulsAI(Creature* creature) : BossAI(creature, DATA_RELIQUARY_OF_SOULS)
            {
            }

            void Reset()
            {
                BossAI::Reset();
                me->SetStandState(UNIT_STAND_STATE_SLEEP);
            }

            void MoveInLineOfSight(Unit* who)
            {
                if (!who || me->getStandState() != UNIT_STAND_STATE_SLEEP || who->GetTypeId() != TYPEID_PLAYER || me->GetDistance2d(who) > 90.0f || who->ToPlayer()->IsGameMaster())
                    return;

                me->SetInCombatWithZone();
                events.ScheduleEvent(EVENT_ESSENCE_OF_SUFFERING, 5000); // ZOMG! 15000);
                me->SetStandState(UNIT_STAND_STATE_STAND);
            }

            void DoAction(int32 param)
            {
                if (param == ACTION_ESSENCE_OF_SUFFERING)
                {
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    events.ScheduleEvent(EVENT_SUCK_ESSENCE, 1000);
                    events.ScheduleEvent(EVENT_SPAWN_ENSLAVED_SOULS, 8000);
                    events.ScheduleEvent(EVENT_ESSENCE_OF_DESIRE, 38000);
                }
                else if (param == ACTION_ESSENCE_OF_DESIRE)
                {
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    events.ScheduleEvent(EVENT_SUCK_ESSENCE, 1000);
                    events.ScheduleEvent(EVENT_SPAWN_ENSLAVED_SOULS, 8000);
                    events.ScheduleEvent(EVENT_ESSENCE_OF_ANGER, 38000);
                }
                else if (param == ACTION_ESSENCE_OF_ANGER)
                {
                }
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                if (summon->GetEntry() == NPC_ENSLAVED_SOUL)
                    return;

                summon->SetReactState(REACT_PASSIVE);
                summon->CastSpell(summon, SPELL_EMERGE_VISUAL, true);
                events.ScheduleEvent(EVENT_ENGAGE_ESSENCE, 4000);
            }

            void SummonedCreatureDies(Creature* summon, Unit*)
            {
                summons.Despawn(summon);
            }

            void AttackStart(Unit*) { }


            void JustDied(Unit* killer)
            {
                summons.clear();
                BossAI::JustDied(killer);
            }

            void UpdateAI(uint32 diff)
            {
                if (me->getStandState() == UNIT_STAND_STATE_SLEEP)
                    return;

                events.Update(diff);
                switch (events.ExecuteEvent())
                {
                    case EVENT_SUCK_ESSENCE:
                        me->SetStandState(UNIT_STAND_STATE_STAND);
                        break;
                    case EVENT_ENGAGE_ESSENCE:
                        summons.DoAction(ACTION_ENGAGE_ESSENCE);
                        break;
                    case EVENT_ESSENCE_OF_SUFFERING:
                        me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
                        me->CastSpell(me, SPELL_SUMMON_ESSENCE_OF_SUFFERING, false);
                        break;
                    case EVENT_ESSENCE_OF_DESIRE:
                        summons.DespawnAll();
                        me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
                        me->CastSpell(me, SPELL_SUMMON_ESSENCE_OF_DESIRE, false);
                        break;
                    case EVENT_ESSENCE_OF_ANGER:
                        summons.DespawnAll();
                        me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
                        me->CastSpell(me, SPELL_SUMMON_ESSENCE_OF_ANGER, false);
                        break;
                    case EVENT_SPAWN_ENSLAVED_SOULS:
                        events.ScheduleEvent(EVENT_SPAWN_SOUL, 0);
                        events.ScheduleEvent(EVENT_SPAWN_SOUL, 0);
                        for (uint8 i = 0; i < 16; ++i)
                            events.ScheduleEvent(EVENT_SPAWN_SOUL, i*1200);
                        break;
                    case EVENT_SPAWN_SOUL:
                        me->CastCustomSpell(SPELL_SUMMON_ENSLAVED_SOUL, SPELLVALUE_MAX_TARGETS, 1, me, false);
                        break;
                }

                EnterEvadeIfOutOfCombatArea();
            }
    
            bool CheckEvadeIfOutOfCombatArea() const
            {
                return !SelectTargetFromPlayerList(80.0f);
            }
        };
};

class boss_essence_of_suffering : public CreatureScript
{
    public:
        boss_essence_of_suffering() : CreatureScript("boss_essence_of_suffering") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_essence_of_sufferingAI(creature);
        }

        struct boss_essence_of_sufferingAI : public ScriptedAI
        {
            boss_essence_of_sufferingAI(Creature* creature) : ScriptedAI(creature) { }

            EventMap events;

            void Reset()
            {
                events.Reset();
            }

            void DoAction(int32 param)
            {
                if (param == ACTION_ENGAGE_ESSENCE)
                {
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_NON_ATTACKABLE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetInCombatWithZone();
                }
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type != POINT_MOTION_TYPE || id != POINT_GO_BACK)
                    return;

                me->m_Events.AddEvent(new SuckBackEvent(*me, ACTION_ESSENCE_OF_SUFFERING), me->m_Events.CalculateTime(1500));
                me->SetTarget(0);
                me->SetFacingTo(M_PI/2.0f);
            }

            void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
            {
                if (damage >= me->GetHealth())
                {
                    damage = 0;
                    if (!me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                    {
                        me->RemoveAurasDueToSpell(SPELL_ESSENCE_OF_SUFFERING_PASSIVE); // prevent fixate from triggering
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        Talk(SUFF_SAY_RECAP);
                        me->SetReactState(REACT_PASSIVE);
                        me->GetMotionMaster()->Clear();
                        me->GetMotionMaster()->MovePoint(POINT_GO_BACK, me->GetHomePosition(), false);
                        events.Reset();
                    }
                }
            }

            void KilledUnit(Unit* /*victim*/)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SUFF_SAY_SLAY);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void EnterCombat(Unit* /*who*/)
            {
                Talk(SUFF_SAY_FREED);
                me->CastSpell(me, SPELL_AURA_OF_SUFFERING, true);
                me->CastSpell(me, SPELL_ESSENCE_OF_SUFFERING_PASSIVE, true);
                me->CastSpell(me, SPELL_ESSENCE_OF_SUFFERING_PASSIVE2, true);

                events.ScheduleEvent(EVENT_SUFF_FRENZY, 45000);
                events.ScheduleEvent(EVENT_SUFF_SOUL_DRAIN, 25000);
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
                    case EVENT_SUFF_SOUL_DRAIN:
                        me->CastCustomSpell(SPELL_SOUL_DRAIN, SPELLVALUE_MAX_TARGETS, 3, me, false);
                        events.ScheduleEvent(EVENT_SUFF_SOUL_DRAIN, 30000);
                        break;
                    case EVENT_SUFF_FRENZY:
                        Talk(SUFF_SAY_ENRAGE);
                        Talk(SUFF_EMOTE_ENRAGE);
                        me->CastSpell(me, SPELL_FRENZY, false);
                        events.ScheduleEvent(EVENT_SUFF_FRENZY, 45000);
                        events.ScheduleEvent(EVENT_SUFF_FRENZY_EMOTE, 3000);
                        break;
                    case EVENT_SUFF_FRENZY_EMOTE:
                        Talk(SUFF_EMOTE_ENRAGE);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };
};

class boss_essence_of_desire : public CreatureScript
{
    public:
        boss_essence_of_desire() : CreatureScript("boss_essence_of_desire") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_essence_of_desireAI(creature);
        }

        struct boss_essence_of_desireAI : public ScriptedAI
        {
            boss_essence_of_desireAI(Creature* creature) : ScriptedAI(creature) { }

            EventMap events;

            void Reset()
            {
                events.Reset();
            }

            void DoAction(int32 param)
            {
                if (param == ACTION_ENGAGE_ESSENCE)
                {
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_NON_ATTACKABLE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetInCombatWithZone();
                }
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type != POINT_MOTION_TYPE || id != POINT_GO_BACK)
                    return;

                me->m_Events.AddEvent(new SuckBackEvent(*me, ACTION_ESSENCE_OF_DESIRE), me->m_Events.CalculateTime(1500));
                me->SetTarget(0);
                me->SetFacingTo(M_PI/2.0f);
            }

            void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
            {
                if (damage >= me->GetHealth())
                {
                    damage = 0;
                    if (!me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                    {
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        Talk(DESI_SAY_RECAP);
                        me->SetReactState(REACT_PASSIVE);
                        me->GetMotionMaster()->Clear();
                        me->GetMotionMaster()->MovePoint(POINT_GO_BACK, me->GetHomePosition(), false);
                        events.Reset();
                    }
                }
            }

            void KilledUnit(Unit* /*victim*/)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(DESI_SAY_SLAY);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void EnterCombat(Unit* /*who*/)
            {
                Talk(DESI_SAY_FREED);
                me->CastSpell(me, SPELL_AURA_OF_DESIRE, true);
                    
                events.ScheduleEvent(EVENT_DESI_DEADEN, 28000);
                events.ScheduleEvent(EVENT_DESI_SPIRIT_SHOCK, 20000);
                events.ScheduleEvent(EVENT_DESI_RUNE_SHIELD, 13000);
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
                    case EVENT_DESI_DEADEN:
                        if (roll_chance_i(50))
                            Talk(DESI_SAY_SPEC);
                        me->CastSpell(me->GetVictim(), SPELL_DEADEN, false);
                        events.ScheduleEvent(EVENT_DESI_DEADEN, 31000);
                        break;
                    case EVENT_DESI_SPIRIT_SHOCK:
                        me->CastSpell(me->GetVictim(), SPELL_SPIRIT_SHOCK, false);
                        events.ScheduleEvent(EVENT_DESI_SPIRIT_SHOCK, 12000);
                        break;
                    case EVENT_DESI_RUNE_SHIELD:
                        me->CastSpell(me, SPELL_RUNE_SHIELD, false);
                        events.ScheduleEvent(EVENT_DESI_RUNE_SHIELD, 15000);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };
};

class boss_essence_of_anger : public CreatureScript
{
    public:
        boss_essence_of_anger() : CreatureScript("boss_essence_of_anger") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_essence_of_angerAI(creature);
        }

        struct boss_essence_of_angerAI : public ScriptedAI
        {
            boss_essence_of_angerAI(Creature* creature) : ScriptedAI(creature) { }

            EventMap events;
            uint64 targetGUID;

            void Reset()
            {
                targetGUID = 0;
                events.Reset();
            }

            void DoAction(int32 param)
            {
                if (param == ACTION_ENGAGE_ESSENCE)
                {
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_NON_ATTACKABLE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetInCombatWithZone();
                }
            }

            void KilledUnit(Unit* /*victim*/)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(ANGER_SAY_SLAY);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void JustDied(Unit*  /*killer*/)
            {
                Talk(ANGER_SAY_DEATH);
                if (me->IsSummon())
                    if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                        Unit::Kill(summoner, summoner);
            }

            void EnterCombat(Unit* /*who*/)
            {
                Talk(ANGER_SAY_FREED);
                me->CastSpell(me, SPELL_AURA_OF_ANGER, true);
                    
                events.ScheduleEvent(EVENT_ANGER_SPITE, 15000);
                events.ScheduleEvent(EVENT_ANGER_SOUL_SCREAM, 10000);
                events.ScheduleEvent(EVENT_ANGER_SEETHE, 1000);
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
                    case EVENT_ANGER_SPITE:
                        if (roll_chance_i(30))
                            Talk(ANGER_SAY_SPEC);
                        me->CastCustomSpell(SPELL_SPITE, SPELLVALUE_MAX_TARGETS, 3, me, false);
                        events.ScheduleEvent(EVENT_ANGER_SPITE, 25000);
                        break;
                    case EVENT_ANGER_SOUL_SCREAM:
                        me->CastSpell(me->GetVictim(), SPELL_SOUL_SCREAM, false);
                        events.ScheduleEvent(EVENT_ANGER_SOUL_SCREAM, 10000);
                        break;
                    case EVENT_ANGER_SEETHE:
                        if (targetGUID && targetGUID != me->GetVictim()->GetGUID())
                            me->CastSpell(me, SPELL_SEETHE, false);
                        // victim can be lost
                        if (me->GetVictim())
                            targetGUID = me->GetVictim()->GetGUID();
                        events.ScheduleEvent(EVENT_ANGER_SEETHE, 1000);
                        break;

                }

                DoMeleeAttackIfReady();
            }
        };
};

class spell_reliquary_of_souls_aura_of_suffering : public SpellScriptLoader
{
    public:
        spell_reliquary_of_souls_aura_of_suffering() : SpellScriptLoader("spell_reliquary_of_souls_aura_of_suffering") { }

        class spell_reliquary_of_souls_aura_of_suffering_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_reliquary_of_souls_aura_of_suffering_AuraScript)

            void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetTarget()->CastSpell(GetTarget(), SPELL_AURA_OF_SUFFERING_TRIGGER, true);
            }

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetTarget()->RemoveAurasDueToSpell(SPELL_AURA_OF_SUFFERING_TRIGGER);
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_reliquary_of_souls_aura_of_suffering_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_MOD_HEALING_PCT, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_reliquary_of_souls_aura_of_suffering_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_MOD_HEALING_PCT, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_reliquary_of_souls_aura_of_suffering_AuraScript();
        }
};

class spell_reliquary_of_souls_fixate : public SpellScriptLoader
{
    public:
        spell_reliquary_of_souls_fixate() : SpellScriptLoader("spell_reliquary_of_souls_fixate") { }

        class spell_reliquary_of_souls_fixate_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_reliquary_of_souls_fixate_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                if (targets.empty())
                    return;

                targets.sort(Trinity::ObjectDistanceOrderPred(GetCaster()));
                WorldObject* target = targets.front();
                targets.clear();
                targets.push_back(target);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_reliquary_of_souls_fixate_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_reliquary_of_souls_fixate_SpellScript();
        }

        class spell_reliquary_of_souls_fixate_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_reliquary_of_souls_fixate_AuraScript)

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* caster = GetCaster())
                    caster->RemoveAurasDueToSpell(GetSpellInfo()->Effects[EFFECT_1].TriggerSpell, GetTarget()->GetGUID());
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_reliquary_of_souls_fixate_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_reliquary_of_souls_fixate_AuraScript();
        }
};

class spell_reliquary_of_souls_aura_of_desire : public SpellScriptLoader
{
    public:
        spell_reliquary_of_souls_aura_of_desire() : SpellScriptLoader("spell_reliquary_of_souls_aura_of_desire") { }

        class spell_reliquary_of_souls_aura_of_desire_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_reliquary_of_souls_aura_of_desire_AuraScript);

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return eventInfo.GetActor() && eventInfo.GetActionTarget();
            }

            void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                eventInfo.GetActionTarget()->CastCustomSpell(SPELL_AURA_OF_DESIRE_DAMAGE, SPELLVALUE_BASE_POINT0, eventInfo.GetDamageInfo()->GetDamage()/2, eventInfo.GetActor(), true);
            }

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (AuraEffect* effect = GetAura()->GetEffect(EFFECT_2))
                    amount = std::max<int32>(-100, -5*int32(effect->GetTickNumber()));
            }

            void Update(AuraEffect const*  /*effect*/)
            {                
                PreventDefaultAction();
                if (AuraEffect* effect = GetAura()->GetEffect(EFFECT_1))
                    effect->RecalculateAmount();
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_reliquary_of_souls_aura_of_desire_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_reliquary_of_souls_aura_of_desire_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_MOD_HEALING_PCT);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_reliquary_of_souls_aura_of_desire_AuraScript::CalculateAmount, EFFECT_1, SPELL_AURA_MOD_INCREASE_ENERGY_PERCENT);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_reliquary_of_souls_aura_of_desire_AuraScript::Update, EFFECT_2, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_reliquary_of_souls_aura_of_desire_AuraScript();
        }
};

class spell_reliquary_of_souls_aura_of_anger : public SpellScriptLoader
{
    public:
        spell_reliquary_of_souls_aura_of_anger() : SpellScriptLoader("spell_reliquary_of_souls_aura_of_anger") { }

        class spell_reliquary_of_souls_aura_of_anger_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_reliquary_of_souls_aura_of_anger_AuraScript);

            void CalculateAmount(AuraEffect const*  /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (AuraEffect* effect = GetAura()->GetEffect(EFFECT_0))
                    amount = amount*effect->GetTickNumber();
            }

            void Update(AuraEffect const*  /*effect*/)
            {
                if (AuraEffect* effect = GetAura()->GetEffect(EFFECT_0))
                    effect->RecalculateAmount();
                if (AuraEffect* effect = GetAura()->GetEffect(EFFECT_1))
                    effect->RecalculateAmount();
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_reliquary_of_souls_aura_of_anger_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_reliquary_of_souls_aura_of_anger_AuraScript::CalculateAmount, EFFECT_1, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_reliquary_of_souls_aura_of_anger_AuraScript::Update, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_reliquary_of_souls_aura_of_anger_AuraScript();
        }
};

class spell_reliquary_of_souls_spite : public SpellScriptLoader
{
    public:
        spell_reliquary_of_souls_spite() : SpellScriptLoader("spell_reliquary_of_souls_spite") { }

        class spell_reliquary_of_souls_spite_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_reliquary_of_souls_spite_AuraScript)

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* caster = GetCaster())
                    caster->CastSpell(GetTarget(), SPELL_SPITE_DAMAGE, true);
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_reliquary_of_souls_spite_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DAMAGE_IMMUNITY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_reliquary_of_souls_spite_AuraScript();
        }
};

void AddSC_boss_reliquary_of_souls()
{
    new boss_reliquary_of_souls();
    new boss_essence_of_suffering();
    new boss_essence_of_desire();
    new boss_essence_of_anger();
    new spell_reliquary_of_souls_aura_of_suffering();
    new spell_reliquary_of_souls_fixate();
    new spell_reliquary_of_souls_aura_of_desire();
    new spell_reliquary_of_souls_aura_of_anger();
    new spell_reliquary_of_souls_spite();
}
