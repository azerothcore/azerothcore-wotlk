/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "sunwell_plateau.h"
#include "Player.h"
#include "WorldSession.h"

enum Yells
{
    SAY_SATH_AGGRO                              = 0,
    SAY_SATH_SLAY                               = 1,
    SAY_SATH_DEATH                              = 2,
    SAY_SATH_SPELL1                             = 3,
    SAY_SATH_SPELL2                             = 4,


    SAY_EVIL_AGGRO                              = 0,
    SAY_EVIL_SLAY                               = 1,
    SAY_GOOD_PLRWIN                             = 2,
    SAY_EVIL_ENRAGE                             = 3,
    SAY_SATH_ENRAGE_ME                          = 4,
    SAY_KALEC_ENRAGE_SATH                       = 5,

    SAY_GOOD_AGGRO                              = 0,
    SAY_GOOD_NEAR_DEATH                         = 1,
    SAY_GOOD_NEAR_DEATH2                        = 2,
    SAY_GOOD_MADRIGOSA                          = 3 // Madrigosa deserved a far better fate. You did what had to be done, but this battle is far from over!
};

enum Spells
{
    SPELL_SPECTRAL_EXHAUSTION           = 44867,
    SPELL_SPECTRAL_BLAST                = 44869,
    SPELL_SPECTRAL_BLAST_PORTAL         = 44866,
    SPELL_SPECTRAL_BLAST_AA             = 46648,
    SPELL_TELEPORT_SPECTRAL             = 46019,

    SPELL_TELEPORT_NORMAL_REALM         = 46020,
    SPELL_SPECTRAL_REALM                = 46021,
    SPELL_SPECTRAL_INVISIBILITY         = 44801,
    SPELL_DEMONIC_VISUAL                = 44800,

    SPELL_ARCANE_BUFFET                 = 45018,
    SPELL_FROST_BREATH                  = 44799,
    SPELL_TAIL_LASH                     = 45122,

    SPELL_BANISH                        = 44836,
    SPELL_TRANSFORM_KALEC               = 44670,
    SPELL_CRAZED_RAGE                   = 44807,

    SPELL_CORRUPTION_STRIKE             = 45029,
    SPELL_CURSE_OF_BOUNDLESS_AGONY      = 45032,
    SPELL_CURSE_OF_BOUNDLESS_AGONY_PLR  = 45034,
    SPELL_SHADOW_BOLT                   = 45031,

    SPELL_HEROIC_STRIKE                 = 45026,
    SPELL_REVITALIZE                    = 45027
};

enum SWPActions
{
    ACTION_ENRAGE                       = 1,
    ACTION_BANISH                       = 2,
    ACTION_SATH_BANISH                  = 3,
    ACTION_KALEC_DIED                   = 4,
    ACTION_ENRAGE_OTHER                 = 5,
};

enum kalEvents
{
    EVENT_ARCANE_BUFFET                 = 1,
    EVENT_FROST_BREATH                  = 2,
    EVENT_WILD_MAGIC                    = 3,
    EVENT_TAIL_LASH                     = 4,
    EVENT_SPECTRAL_BLAST                = 5,
    EVENT_CHECK_HEALTH                  = 6,
    EVENT_CHECK_HEALTH2                 = 7,
    EVENT_CHECK_POS                     = 8,
    EVENT_SPAWN_SPECTRALS               = 9,

    EVENT_SPELL_REVITALIZE              = 10,
    EVENT_SPELL_HEROIC_STRIKE           = 11,
    EVENT_SHADOW_BOLT                   = 12,
    EVENT_AGONY_CURSE                   = 13,
    EVENT_CORRUPTION_STRIKE             = 14,

    EVENT_TALK_GOOD_1                   = 20,
    EVENT_TALK_GOOD_2                   = 21,
    EVENT_TALK_GOOD_3                   = 22,
    EVENT_TALK_GOOD_4                   = 23,
    EVENT_TALK_GOOD_5                   = 24,
    EVENT_TALK_BAD_1                    = 25,
    EVENT_TALK_BAD_2                    = 26,
    EVENT_TALK_BAD_3                    = 27
};

#define DRAGON_REALM_Z  53.079f

class boss_kalecgos : public CreatureScript
{
public:
    boss_kalecgos() : CreatureScript("boss_kalecgos") { }

    struct boss_kalecgosAI : public BossAI
    {
        boss_kalecgosAI(Creature* creature) : BossAI(creature, DATA_KALECGOS)
        {
        }

        bool sathBanished;
        EventMap events2;

        bool CanAIAttack(Unit const* target) const
        {
            return target->GetPositionZ() > 50.0f;
        }

        void JustReachedHome()
        {
            BossAI::JustReachedHome();
            me->SetVisible(true);
        }

        void Reset()
        {
            BossAI::Reset();
            me->SetHealth(me->GetMaxHealth());
            me->SetStandState(UNIT_STAND_STATE_SLEEP);
            me->SetDisableGravity(false);
            me->SetReactState(REACT_AGGRESSIVE);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE + UNIT_FLAG_NOT_SELECTABLE);
            events2.Reset();

            sathBanished = false;
            ClearPlayerAuras();
        }

        void ClearPlayerAuras() const
        {
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_CURSE_OF_BOUNDLESS_AGONY);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_CURSE_OF_BOUNDLESS_AGONY_PLR);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_SPECTRAL_REALM);
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_ENRAGE || param == ACTION_ENRAGE_OTHER)
            {
                Talk(param == ACTION_ENRAGE ? SAY_KALEC_ENRAGE_SATH : SAY_SATH_ENRAGE_ME);
                me->CastSpell(me, SPELL_CRAZED_RAGE, true);
                events.CancelEvent(EVENT_CHECK_HEALTH);
                return;
            }
            else if (param == ACTION_BANISH)
            {
                me->CastSpell(me, SPELL_BANISH, true);
                events.Reset();
            }
            else if (param == ACTION_SATH_BANISH)
                sathBanished = true;
            else if (param == ACTION_KALEC_DIED)
            {
                events.Reset();
                events2.ScheduleEvent(EVENT_TALK_BAD_1, 0);
                ClearPlayerAuras();
                return;
            }

            if (me->HasAura(SPELL_BANISH) && sathBanished)
            {
                events.Reset();
                events2.ScheduleEvent(EVENT_TALK_GOOD_1, 1000);
                ClearPlayerAuras();
                if (Creature* Sath = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_SATHROVARR)))
                {
                    Sath->RemoveAllAuras();
                    Sath->GetMotionMaster()->MovementExpired();
                    Sath->SetReactState(REACT_PASSIVE);
                    Sath->NearTeleportTo(1696.20f, 915.0f, DRAGON_REALM_Z, Sath->GetOrientation());
                }
            }
        }

        void JustDied(Unit* who)
        {
            BossAI::JustDied(who);
        }

        void EnterCombat(Unit* who)
        {
            BossAI::EnterCombat(who);
            events.ScheduleEvent(EVENT_ARCANE_BUFFET, 6000);
            events.ScheduleEvent(EVENT_FROST_BREATH, 15000);
            events.ScheduleEvent(EVENT_WILD_MAGIC, 10000);
            events.ScheduleEvent(EVENT_TAIL_LASH, 25000);
            events.ScheduleEvent(EVENT_SPECTRAL_BLAST, 20000);
            events.ScheduleEvent(EVENT_CHECK_POS, 5000);
            events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
            events.ScheduleEvent(EVENT_CHECK_HEALTH2, 1000);
            events.ScheduleEvent(EVENT_SPAWN_SPECTRALS, 16000);

            me->SetStandState(UNIT_STAND_STATE_STAND);
            Talk(SAY_EVIL_AGGRO);
        }

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask)
        {
            if (damage >= me->GetHealth() && attacker != me)
                damage = 0;
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER && roll_chance_i(50))
                Talk(SAY_EVIL_SLAY);
        }

        void UpdateAI(uint32 diff)
        {
            events2.Update(diff);
            switch (events2.ExecuteEvent())
            {
                case EVENT_TALK_GOOD_1:
                    me->SetRegeneratingHealth(false);
                    me->RemoveAllAuras();
                    me->SetReactState(REACT_PASSIVE);
                    me->CombatStop();
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->setFaction(35);
                    events2.ScheduleEvent(EVENT_TALK_GOOD_2, 1000);
                    break;
                case EVENT_TALK_GOOD_2:
                    if (Creature* Sath = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_SATHROVARR)))
                    {
                        summons.Despawn(Sath);
                        Unit::Kill(me, Sath);
                    }
                    events2.ScheduleEvent(EVENT_TALK_GOOD_3, 8000);
                    break;
                case EVENT_TALK_GOOD_3:
                    Talk(SAY_GOOD_PLRWIN);
                    events2.ScheduleEvent(EVENT_TALK_GOOD_4, 10000);
                    break;
                case EVENT_TALK_GOOD_4:
                    me->SetDisableGravity(true);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
                    events2.ScheduleEvent(EVENT_TALK_GOOD_5, 10000);
                    break;
                case EVENT_TALK_GOOD_5:
                    me->SetVisible(false);
                    Unit::Kill(me, me);
                    break;
                case EVENT_TALK_BAD_1:
                    me->SetReactState(REACT_PASSIVE);
                    me->CombatStop();
                    me->RemoveAllAuras();
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    Talk(SAY_EVIL_ENRAGE);
                    events2.ScheduleEvent(EVENT_TALK_BAD_2, 3000);
                    break;
                case EVENT_TALK_BAD_2:
                    me->SetDisableGravity(true);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
                    events2.ScheduleEvent(EVENT_TALK_BAD_3, 15000);
                    break;
                case EVENT_TALK_BAD_3:
                    me->SetVisible(false);
                    EnterEvadeMode();
                    break;
            }

            if (!events2.Empty())
                return;

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPAWN_SPECTRALS:
                    me->SummonCreature(NPC_KALEC, 1702.21f, 931.7f, -74.56f, 5.07f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_SATHROVARR, 1704.62f, 927.78f, -73.9f, 2.0f, TEMPSUMMON_MANUAL_DESPAWN);
                    break;
                case EVENT_ARCANE_BUFFET:
                    me->CastSpell(me, SPELL_ARCANE_BUFFET, false);
                    events.ScheduleEvent(EVENT_ARCANE_BUFFET, 8000);
                    break;
                case EVENT_FROST_BREATH:
                    me->CastSpell(me->GetVictim(), SPELL_FROST_BREATH, false);
                    events.ScheduleEvent(EVENT_FROST_BREATH, 15000);
                    break;
                case EVENT_TAIL_LASH:
                    me->CastSpell(me->GetVictim(), SPELL_TAIL_LASH, false);
                    events.ScheduleEvent(EVENT_TAIL_LASH, 15000);
                    break;
                case EVENT_WILD_MAGIC:
                    me->CastCustomSpell(RAND(44978, 45001, 45002, 45004, 45006, 45010), SPELLVALUE_MAX_TARGETS, 1, me, false);
                    events.ScheduleEvent(EVENT_WILD_MAGIC, 20000);
                    break;
                case EVENT_SPECTRAL_BLAST:
                    me->CastSpell(me, SPELL_SPECTRAL_BLAST, false);
                    events.ScheduleEvent(EVENT_SPECTRAL_BLAST, urand(15000, 25000));
                    break;
                case EVENT_CHECK_POS:
                    if (me->GetDistance(me->GetHomePosition()) > 50.0f)
                    {
                        EnterEvadeMode();
                        return;
                    }
                    events.ScheduleEvent(EVENT_CHECK_POS, 5000);
                    break;
                case EVENT_CHECK_HEALTH:
                    if (me->HealthBelowPct(10))
                    {
                        if (Creature* Sath = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_SATHROVARR)))
                            Sath->AI()->DoAction(ACTION_ENRAGE_OTHER);
                        DoAction(ACTION_ENRAGE);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
                    break;
                case EVENT_CHECK_HEALTH2:
                    if (me->HealthBelowPct(1))
                    {
                        DoAction(ACTION_BANISH);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH2, 1000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_kalecgosAI>(creature);
    }
};

enum Kalec
{
    SPELL_OPEN_BRUTALLUS_BACK_DOOR = 46650,
    MODEL_KALECGOS_DRAGON       = 23487,

    EVENT_KALEC_SCENE_1         = 101,
    EVENT_KALEC_SCENE_2         = 102,
    EVENT_KALEC_SCENE_3         = 103
};

class boss_kalec : public CreatureScript
{
public:
    boss_kalec() : CreatureScript("boss_kalec") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_kalecAI>(creature);
    }

    struct boss_kalecAI : public ScriptedAI
    {
        boss_kalecAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;
        EventMap events2;

        void Reset()
        {
            events.Reset();
            events2.Reset();
            if (me->GetPositionY() < 750.0f)
            {
                me->SetSpeed(MOVE_RUN, 2.4f);
                me->SetDisplayId(MODEL_KALECGOS_DRAGON);
                me->SetDisableGravity(true);
                me->GetMotionMaster()->MovePoint(0, 1483.30f, 657.99f, 28.0f, false, true);
                events2.ScheduleEvent(EVENT_KALEC_SCENE_1, 9000);
                events2.ScheduleEvent(EVENT_KALEC_SCENE_2, 16000);
                events2.ScheduleEvent(EVENT_KALEC_SCENE_3, 22000);
            }
            else
                me->CastSpell(me, SPELL_SPECTRAL_INVISIBILITY, true);
        }

        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask)
        {
            if (!who || who->GetEntry() != NPC_SATHROVARR)
                damage = 0;
        }

        void EnterCombat(Unit*)
        {
            events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
            events.ScheduleEvent(EVENT_CHECK_HEALTH2, 1000);
            events.ScheduleEvent(EVENT_SPELL_REVITALIZE, 5000);
            events.ScheduleEvent(EVENT_SPELL_HEROIC_STRIKE, 3000);
            Talk(SAY_GOOD_AGGRO);
        }

        void JustDied(Unit*)
        {
            if (InstanceScript* instance = me->GetInstanceScript())
                if (Creature* kalecgos = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_KALECGOS)))
                    kalecgos->AI()->DoAction(ACTION_KALEC_DIED);
        }

        void UpdateAI(uint32 diff)
        {
            events2.Update(diff);
            switch (events2.ExecuteEvent())
            {
                case EVENT_KALEC_SCENE_1:
                    Talk(SAY_GOOD_MADRIGOSA);
                    me->GetMotionMaster()->MovePoint(0, 1509.0f, 560.0f, 30.0f, false, true);
                    break;
                case EVENT_KALEC_SCENE_2:
                    me->CastSpell(me, SPELL_OPEN_BRUTALLUS_BACK_DOOR, true);
                    me->GetInstanceScript()->SetBossState(DATA_FELMYST_DOORS, NOT_STARTED);
                    me->GetInstanceScript()->SetBossState(DATA_FELMYST_DOORS, DONE);
                    break;
                case EVENT_KALEC_SCENE_3:
                    me->GetMotionMaster()->MovePoint(0, 1400.0f, 630.0f, 90.0f, false, true);
                    me->DespawnOrUnsummon(6000);
                    break;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_CHECK_HEALTH:
                    if (me->HealthBelowPct(50))
                    {
                        Talk(SAY_GOOD_NEAR_DEATH);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
                    break;
                case EVENT_CHECK_HEALTH2:
                    if (me->HealthBelowPct(10))
                    {
                        Talk(SAY_GOOD_NEAR_DEATH2);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH2, 1000);
                    break;
                case EVENT_SPELL_REVITALIZE:
                    me->CastSpell(me, SPELL_REVITALIZE, false);
                    events.ScheduleEvent(EVENT_SPELL_REVITALIZE, 10000);
                    break;
                case EVENT_SPELL_HEROIC_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_HEROIC_STRIKE, false);
                    events.ScheduleEvent(EVENT_SPELL_HEROIC_STRIKE, 5000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class boss_sathrovarr : public CreatureScript
{
public:
    boss_sathrovarr() : CreatureScript("boss_sathrovarr") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_sathrovarrAI>(creature);
    }

    struct boss_sathrovarrAI : public ScriptedAI
    {
        boss_sathrovarrAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;

        bool CanAIAttack(Unit const* target) const
        {
            return target->GetPositionZ() < 50.0f;
        }

        void Reset()
        {
            events.Reset();
            me->CastSpell(me, SPELL_DEMONIC_VISUAL, true);
            me->CastSpell(me, SPELL_SPECTRAL_INVISIBILITY, true);

            events.ScheduleEvent(EVENT_SHADOW_BOLT, 7000);
            events.ScheduleEvent(EVENT_AGONY_CURSE, 20000);
            events.ScheduleEvent(EVENT_CORRUPTION_STRIKE, 13000);
            events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
            events.ScheduleEvent(EVENT_CHECK_HEALTH2, 1000);
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_SATH_AGGRO);
        }

        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask)
        {
            if (damage >= me->GetHealth() && who != me)
                damage = 0;
        }

        void KilledUnit(Unit* target)
        {
            if (target->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SATH_SLAY);
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_SATH_DEATH);
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_ENRAGE || param == ACTION_ENRAGE_OTHER)
            {
                me->CastSpell(me, SPELL_CRAZED_RAGE, true);
                events.CancelEvent(EVENT_CHECK_HEALTH);
            }
            else if (param == ACTION_BANISH)
            {
                me->CastSpell(me, SPELL_BANISH, true);
                events.Reset();
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
                case EVENT_SHADOW_BOLT:
                    if (roll_chance_i(20))
                        Talk(SAY_SATH_SPELL1);
                    me->CastSpell(me->GetVictim(), SPELL_SHADOW_BOLT, false);
                    events.ScheduleEvent(EVENT_SHADOW_BOLT, 9000);
                    break;
                case EVENT_AGONY_CURSE:
                    me->CastCustomSpell(SPELL_CURSE_OF_BOUNDLESS_AGONY, SPELLVALUE_MAX_TARGETS, 1, me, false);
                    events.ScheduleEvent(EVENT_AGONY_CURSE, 30000);
                    break;
                case EVENT_CORRUPTION_STRIKE:
                    if (roll_chance_i(20))
                        Talk(SAY_SATH_SPELL2);
                    me->CastSpell(me->GetVictim(), SPELL_CORRUPTION_STRIKE, false);
                    events.ScheduleEvent(EVENT_CORRUPTION_STRIKE, 9000);
                    break;
                case EVENT_CHECK_HEALTH:
                    if (me->HealthBelowPct(10))
                    {
                        if (InstanceScript* instance = me->GetInstanceScript())
                            if (Creature* kalecgos = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_KALECGOS)))
                                kalecgos->AI()->DoAction(ACTION_ENRAGE_OTHER);
                        DoAction(ACTION_ENRAGE);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
                    break;
                case EVENT_CHECK_HEALTH2:
                    if (me->HealthBelowPct(1))
                    {
                        if (Creature* kalecgos = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_KALECGOS)))
                            kalecgos->AI()->DoAction(ACTION_SATH_BANISH);
                        DoAction(ACTION_BANISH);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH2, 1000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class SpectralBlastCheck
{
    public:
        SpectralBlastCheck(Unit* victim) : _victim(victim) { }

        bool operator()(WorldObject* unit)
        {
            return unit->GetPositionZ() < 50.0f || unit->ToUnit()->HasAura(SPELL_SPECTRAL_EXHAUSTION) || unit->GetGUID() == _victim->GetGUID();
        }
    private:
        Unit* _victim;
};

class spell_kalecgos_spectral_blast_dummy : public SpellScriptLoader
{
public:
    spell_kalecgos_spectral_blast_dummy() : SpellScriptLoader("spell_kalecgos_spectral_blast_dummy") { }

    class spell_kalecgos_spectral_blast_dummy_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_kalecgos_spectral_blast_dummy_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            targets.remove_if(SpectralBlastCheck(GetCaster()->GetVictim()));
            acore::Containers::RandomResizeList(targets, 1);
        }           
        
        void HandleDummy(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            if (Unit* target = GetHitUnit())
            {
                target->CastSpell(target, SPELL_SPECTRAL_BLAST_PORTAL, true);
                target->CastSpell(target, SPELL_SPECTRAL_BLAST_AA, true);
                target->CastSpell(target, SPELL_TELEPORT_SPECTRAL, true);
            }
        }

        void Register()
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_kalecgos_spectral_blast_dummy_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            OnEffectHitTarget += SpellEffectFn(spell_kalecgos_spectral_blast_dummy_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_kalecgos_spectral_blast_dummy_SpellScript();
    }
};

class spell_kalecgos_curse_of_boundless_agony : public SpellScriptLoader
{
    public:
        spell_kalecgos_curse_of_boundless_agony() : SpellScriptLoader("spell_kalecgos_curse_of_boundless_agony") { }

        class spell_kalecgos_curse_of_boundless_agony_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_kalecgos_curse_of_boundless_agony_AuraScript);

            void OnRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (InstanceScript* instance = GetUnitOwner()->GetInstanceScript())
                    if (instance->IsEncounterInProgress())
                        GetUnitOwner()->CastCustomSpell(SPELL_CURSE_OF_BOUNDLESS_AGONY_PLR, SPELLVALUE_MAX_TARGETS, 1, GetUnitOwner(), true);
            }

            void OnPeriodic(AuraEffect const* aurEff)
            {
                if (aurEff->GetTickNumber() > 1 && aurEff->GetTickNumber()%5 == 1)
                    GetAura()->GetEffect(aurEff->GetEffIndex())->SetAmount(aurEff->GetAmount()*2);
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_kalecgos_curse_of_boundless_agony_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_kalecgos_curse_of_boundless_agony_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_kalecgos_curse_of_boundless_agony_AuraScript();
        }
};

class spell_kalecgos_spectral_realm_dummy : public SpellScriptLoader
{
    public:
        spell_kalecgos_spectral_realm_dummy() : SpellScriptLoader("spell_kalecgos_spectral_realm_dummy") { }

        class spell_kalecgos_spectral_realm_dummy_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kalecgos_spectral_realm_dummy_SpellScript);

            SpellCastResult CheckCast()
            {
                if (GetCaster()->HasAura(SPELL_SPECTRAL_EXHAUSTION))
                    return SPELL_FAILED_CASTER_AURASTATE;

                return SPELL_CAST_OK;
            }

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                GetCaster()->CastSpell(GetCaster(), SPELL_TELEPORT_SPECTRAL, true);
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_kalecgos_spectral_realm_dummy_SpellScript::CheckCast);
                OnEffectHitTarget += SpellEffectFn(spell_kalecgos_spectral_realm_dummy_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kalecgos_spectral_realm_dummy_SpellScript();
        }
};

class spell_kalecgos_spectral_realm : public SpellScriptLoader
{
    public:
        spell_kalecgos_spectral_realm() : SpellScriptLoader("spell_kalecgos_spectral_realm") { }

        class spell_kalecgos_spectral_realm_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_kalecgos_spectral_realm_AuraScript);

            void OnRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SPECTRAL_EXHAUSTION, true);
                GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_TELEPORT_NORMAL_REALM, true);
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_kalecgos_spectral_realm_AuraScript::OnRemove, EFFECT_1, SPELL_AURA_MOD_INVISIBILITY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_kalecgos_spectral_realm_AuraScript();
        }
};

void AddSC_boss_kalecgos()
{
    new boss_kalecgos();
    new boss_sathrovarr();
    new boss_kalec();
    new spell_kalecgos_spectral_blast_dummy();
    new spell_kalecgos_curse_of_boundless_agony();
    new spell_kalecgos_spectral_realm_dummy();
    new spell_kalecgos_spectral_realm();
}
