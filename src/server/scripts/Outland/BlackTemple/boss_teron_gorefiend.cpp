/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "black_temple.h"

enum Says
{
    SAY_INTRO                       = 0,
    SAY_AGGRO                       = 1,
    SAY_SLAY                        = 2,
    SAY_BLOSSOM                     = 3,
    SAY_INCINERATE                  = 4,
    SAY_CRUSHING                    = 5,
    SAY_DEATH                       = 6
};

enum Spells
{
    SPELL_INCINERATE                = 40239,
    SPELL_SUMMON_DOOM_BLOSSOM       = 40188,
    SPELL_CRUSHING_SHADOWS          = 40243,
    SPELL_SHADOW_OF_DEATH           = 40251,
    SPELL_SHADOW_OF_DEATH_REMOVE    = 41999,
    SPELL_SUMMON_SPIRIT             = 40266,
    SPELL_SUMMON_SKELETON1          = 40270,
    SPELL_SUMMON_SKELETON2          = 41948,
    SPELL_SUMMON_SKELETON3          = 41949,
    SPELL_SUMMON_SKELETON4          = 41950,
    SPELL_POSSESS_SPIRIT_IMMUNE     = 40282,
    SPELL_SPIRITUAL_VENGEANCE       = 40268,
    SPELL_BRIEF_STUN                = 41421,

    SPELL_SPIRIT_LANCE              = 40157,
    SPELL_SPIRIT_CHAINS             = 40175,
    SPELL_SPIRIT_VOLLEY             = 40314
};

enum Misc
{
    SET_DATA_INTRO                  = 1,

    EVENT_SPELL_INCINERATE          = 1,
    EVENT_SPELL_DOOM_BLOSSOM        = 2,
    EVENT_SPELL_CRUSHING_SHADOWS    = 3,
    EVENT_SPELL_SHADOW_OF_DEATH     = 4,
    EVENT_TALK_KILL                 = 10
};

struct ShadowOfDeathSelector : public acore::unary_function<Unit*, bool>
{
    bool operator()(Unit const* target) const
    {
        return target && !target->HasAura(SPELL_SHADOW_OF_DEATH) && !target->HasAura(SPELL_POSSESS_SPIRIT_IMMUNE);
    }
};

class boss_teron_gorefiend : public CreatureScript
{
    public:
        boss_teron_gorefiend() : CreatureScript("boss_teron_gorefiend") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_teron_gorefiendAI>(creature);
        }

        struct boss_teron_gorefiendAI : public BossAI
        {
            boss_teron_gorefiendAI(Creature* creature) : BossAI(creature, DATA_TERON_GOREFIEND)
            {
                intro = false;
            }

            bool intro;

            void Reset()
            {
                BossAI::Reset();
                me->CastSpell(me, SPELL_SHADOW_OF_DEATH_REMOVE, true);
            }

            void SetData(uint32 type, uint32 id)
            {
                if (type || !me->IsAlive())
                    return;

                if (id == SET_DATA_INTRO && !intro)
                {
                    intro = true;
                    Talk(SAY_INTRO);
                }
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
                events.ScheduleEvent(EVENT_SPELL_INCINERATE, 24000);
                events.ScheduleEvent(EVENT_SPELL_DOOM_BLOSSOM, 10000);
                events.ScheduleEvent(EVENT_SPELL_CRUSHING_SHADOWS, 17000);
                events.ScheduleEvent(EVENT_SPELL_SHADOW_OF_DEATH, 20000);
            }

            void KilledUnit(Unit*  /*victim*/)
            {
                if (events.GetNextEventTime(EVENT_TALK_KILL) == 0)
                {
                    Talk(SAY_SLAY);
                    events.ScheduleEvent(EVENT_TALK_KILL, 6000);
                }
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
            }

            void JustDied(Unit* killer)
            {
                BossAI::JustDied(killer);
                Talk(SAY_DEATH);
                me->CastSpell(me, SPELL_SHADOW_OF_DEATH_REMOVE, true);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim() )
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_SPELL_INCINERATE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        {
                            if (roll_chance_i(50))
                                Talk(SAY_INCINERATE);
                            me->CastSpell(target, SPELL_INCINERATE, false);
                        }
                        events.ScheduleEvent(EVENT_SPELL_INCINERATE, 25000);
                        break;
                    case EVENT_SPELL_DOOM_BLOSSOM:
                        if (roll_chance_i(50))
                            Talk(SAY_BLOSSOM);

                        me->CastSpell(me, SPELL_SUMMON_DOOM_BLOSSOM, false);
                        events.ScheduleEvent(EVENT_SPELL_DOOM_BLOSSOM, 40000);
                        break;
                    case EVENT_SPELL_CRUSHING_SHADOWS:
                        if (roll_chance_i(20))
                            Talk(SAY_CRUSHING);
                        me->CastCustomSpell(SPELL_CRUSHING_SHADOWS, SPELLVALUE_MAX_TARGETS, 5, me, false);
                        events.ScheduleEvent(EVENT_SPELL_CRUSHING_SHADOWS, 15000);
                        break;
                    case EVENT_SPELL_SHADOW_OF_DEATH:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, ShadowOfDeathSelector()))
                            me->CastSpell(target, SPELL_SHADOW_OF_DEATH, false);
                        events.ScheduleEvent(EVENT_SPELL_SHADOW_OF_DEATH, 30000);
                        break;
                }

                DoMeleeAttackIfReady();
                EnterEvadeIfOutOfCombatArea();
            }
                    
            bool CheckEvadeIfOutOfCombatArea() const
            {
                return me->GetDistance(me->GetHomePosition()) > 100.0f;
            }
        };
};

class spell_teron_gorefiend_shadow_of_death : public SpellScriptLoader
{
    public:
        spell_teron_gorefiend_shadow_of_death() : SpellScriptLoader("spell_teron_gorefiend_shadow_of_death") { }

        class spell_teron_gorefiend_shadow_of_death_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_teron_gorefiend_shadow_of_death_AuraScript)

            void Absorb(AuraEffect* /*aurEff*/, DamageInfo &  /*dmgInfo*/, uint32 &  /*absorbAmount*/)
            {
                PreventDefaultAction();
            }

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                InstanceScript* instance = GetTarget()->GetInstanceScript();
                if (!GetCaster() || !instance || !instance->IsEncounterInProgress())
                    return;

                GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_SPIRIT, true);
                GetTarget()->CastSpell(GetTarget(), SPELL_POSSESS_SPIRIT_IMMUNE, true);
                GetTarget()->CastSpell(GetTarget(), SPELL_SPIRITUAL_VENGEANCE, true);
                GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_SKELETON1, true);
                GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_SKELETON2, true);
                GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_SKELETON3, true);
                GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_SKELETON4, true);
            }

            void Register()
            {
                OnEffectAbsorb += AuraEffectAbsorbFn(spell_teron_gorefiend_shadow_of_death_AuraScript::Absorb, EFFECT_0);
                AfterEffectRemove += AuraEffectRemoveFn(spell_teron_gorefiend_shadow_of_death_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_teron_gorefiend_shadow_of_death_AuraScript();
        }
};

class spell_teron_gorefiend_spirit_lance : public SpellScriptLoader
{
    public:
        spell_teron_gorefiend_spirit_lance() : SpellScriptLoader("spell_teron_gorefiend_spirit_lance") { }

        class spell_teron_gorefiend_spirit_lance_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_teron_gorefiend_spirit_lance_AuraScript);

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                if (AuraEffect* effect = GetAura()->GetEffect(EFFECT_2))
                    amount -= (amount / effect->GetTotalTicks()) * effect->GetTickNumber();
            }

            void Update(AuraEffect const*  /*effect*/)
            {                
                PreventDefaultAction();
                if (AuraEffect* effect = GetAura()->GetEffect(EFFECT_1))
                    effect->RecalculateAmount();
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_teron_gorefiend_spirit_lance_AuraScript::CalculateAmount, EFFECT_1, SPELL_AURA_MOD_DECREASE_SPEED);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_teron_gorefiend_spirit_lance_AuraScript::Update, EFFECT_2, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_teron_gorefiend_spirit_lance_AuraScript();
        }
};

class spell_teron_gorefiend_spiritual_vengeance : public SpellScriptLoader
{
    public:
        spell_teron_gorefiend_spiritual_vengeance() : SpellScriptLoader("spell_teron_gorefiend_spiritual_vengeance") { }

        class spell_teron_gorefiend_spiritual_vengeance_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_teron_gorefiend_spiritual_vengeance_AuraScript)

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit::Kill(nullptr, GetTarget());
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_teron_gorefiend_spiritual_vengeance_AuraScript::HandleEffectRemove, EFFECT_2, SPELL_AURA_MOD_PACIFY_SILENCE, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_teron_gorefiend_spiritual_vengeance_AuraScript();
        }
};

class spell_teron_gorefiend_shadowy_construct : public SpellScriptLoader
{
    public:
        spell_teron_gorefiend_shadowy_construct() : SpellScriptLoader("spell_teron_gorefiend_shadowy_construct") { }

        class spell_teron_gorefiend_shadowy_construct_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_teron_gorefiend_shadowy_construct_AuraScript)

            bool Load()
            {
                return GetUnitOwner()->GetTypeId() == TYPEID_UNIT;
            }

            void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NORMAL, true);
                GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_ALLOW_ID, SPELL_SPIRIT_LANCE, true);
                GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_ALLOW_ID, SPELL_SPIRIT_CHAINS, true);
                GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_ALLOW_ID, SPELL_SPIRIT_VOLLEY, true);

                GetUnitOwner()->ToCreature()->SetInCombatWithZone();
                Map::PlayerList const& playerList = GetUnitOwner()->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator i = playerList.begin(); i != playerList.end(); ++i)
                    if (Player* player = i->GetSource())
                    {
                        if (GetUnitOwner()->IsValidAttackTarget(player))
                            GetUnitOwner()->AddThreat(player, 1000000.0f);
                    }

                GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_BRIEF_STUN, true);
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_teron_gorefiend_shadowy_construct_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_teron_gorefiend_shadowy_construct_AuraScript();
        }
};

void AddSC_boss_teron_gorefiend()
{
    new boss_teron_gorefiend();
    new spell_teron_gorefiend_shadow_of_death();
    new spell_teron_gorefiend_spirit_lance();
    new spell_teron_gorefiend_spiritual_vengeance();
    new spell_teron_gorefiend_shadowy_construct();
}
