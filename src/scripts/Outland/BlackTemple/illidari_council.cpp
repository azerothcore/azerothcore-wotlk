/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-AGPL
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "black_temple.h"

enum Says
{
    SAY_COUNCIL_AGGRO                   = 0,
    SAY_COUNCIL_ENRAGE                  = 1,
    SAY_COUNCIL_SPECIAL                 = 2,
    SAY_COUNCIL_SLAY                    = 3,
    SAY_COUNCIL_DEATH                   = 4
};

enum Spells
{
    SPELL_EMPYREAL_BALANCE              = 41499,
    SPELL_BERSERK                       = 41924,

    // Gathios the Shatterer
    SPELL_BLESSING_OF_PROTECTION        = 41450,
    SPELL_BLESSING_OF_SPELL_WARDING     = 41451,
    SPELL_CONSECRATION                  = 41541,
    SPELL_HAMMER_OF_JUSTICE             = 41468,
    SPELL_SEAL_OF_COMMAND               = 41469,
    SPELL_SEAL_OF_BLOOD                 = 41459,
    SPELL_CHROMATIC_RESISTANCE_AURA     = 41453,
    SPELL_DEVOTION_AURA                 = 41452,
    SPELL_JUDGEMENT                     = 41467,

    // High Nethermancer Zerevor
    SPELL_FLAMESTRIKE                   = 41481,
    SPELL_BLIZZARD                      = 41482,
    SPELL_ARCANE_BOLT                   = 41483,
    SPELL_ARCANE_EXPLOSION              = 41524,
    SPELL_DAMPEN_MAGIC                  = 41478,

    // Lady Malande
    SPELL_EMPOWERED_SMITE               = 41471,
    SPELL_CIRCLE_OF_HEALING             = 41455,
    SPELL_REFLECTIVE_SHIELD             = 41475,
    SPELL_REFLECTIVE_SHIELD_T           = 33619,
    SPELL_DIVINE_WRATH                  = 41472,
    SPELL_HEAL_VISUAL                   = 24171,

    // Veras Darkshadow
    SPELL_DEADLY_STRIKE                 = 41480,
    SPELL_DEADLY_POISON                 = 41485,
    SPELL_ENVENOM                       = 41487,
    SPELL_VANISH                        = 41476,
    SPELL_VANISH_OUT                    = 41479,
    SPELL_VANISH_VISUAL                 = 24222
};

enum Misc
{
    ACTION_START_ENCOUNTER              = 1,
    ACTION_END_ENCOUNTER                = 2,
    ACTION_ENRAGE                       = 3,

    EVENT_SPELL_BLESSING                = 1,
    EVENT_SPELL_AURA                    = 2,
    EVENT_SPELL_SEAL                    = 3,
    EVENT_SPELL_HAMMER_OF_JUSTICE       = 4,
    EVENT_SPELL_JUDGEMENT               = 5,
    EVENT_SPELL_CONSECRATION            = 6,

    EVENT_SPELL_FLAMESTRIKE             = 10,
    EVENT_SPELL_BLIZZARD                = 11,
    EVENT_SPELL_ARCANE_BOLT             = 12,
    EVENT_SPELL_DAMPEN_MAGIC            = 13,
    EVENT_SPELL_ARCANE_EXPLOSION        = 14,

    EVENT_SPELL_REFLECTIVE_SHIELD       = 20,
    EVENT_SPELL_CIRCLE_OF_HEALING       = 21,
    EVENT_SPELL_DIVINE_WRATH            = 22,
    EVENT_SPELL_EMPOWERED_SMITE         = 23,

    EVENT_SPELL_VANISH                  = 30,
    EVENT_SPELL_VANISH_OUT              = 31,
    EVENT_SPELL_ENRAGE                  = 32,

    EVENT_KILL_TALK                     = 100
};

struct HammerOfJusticeSelector : public std::unary_function<Unit*, bool>
{
    Unit const* _me;
    HammerOfJusticeSelector(Unit* me) : _me(me) { }

    bool operator()(Unit const* target) const
    {
        return target && target->GetTypeId() == TYPEID_PLAYER && _me->IsInRange(target, 10.0f, 40.0f, true);
    }
};

class VerasEnvenom : public BasicEvent
{
    public:
        VerasEnvenom(Unit& owner, uint64 targetGUID) : _owner(owner), _targetGUID(targetGUID) { }

        bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/)
        {
            if (Player* target = ObjectAccessor::GetPlayer(_owner, _targetGUID))
            {
                target->m_clientGUIDs.insert(_owner.GetGUID());
                _owner.CastSpell(target, SPELL_ENVENOM, true);
                target->RemoveAurasDueToSpell(SPELL_DEADLY_POISON);
                target->m_clientGUIDs.erase(_owner.GetGUID());
            }
            return true;
        }

    private:
        Unit& _owner;
        uint64 _targetGUID;
};

class boss_illidari_council : public CreatureScript
{
public:
    boss_illidari_council() : CreatureScript("boss_illidari_council") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_illidari_councilAI>(creature);
    }

    struct boss_illidari_councilAI : public BossAI
    {
        boss_illidari_councilAI(Creature* creature) : BossAI(creature, DATA_ILLIDARI_COUNCIL)
        {
            memset(councilGUIDs, 0, sizeof(councilGUIDs));
        }

        uint64 councilGUIDs[4];

        void Reset()
        {
            BossAI::Reset();
            Creature* member = NULL;
            for (uint8 i = 0; i < 4; ++i)
                if ((member = ObjectAccessor::GetCreature(*me, councilGUIDs[i])))
                    member->AI()->EnterEvadeMode();
        }

        void AttackStart(Unit*) { }
        void MoveInLineOfSight(Unit*) { }

        void DoAction(int32 param)
        {
            if (!me->isActiveObject() && param == ACTION_START_ENCOUNTER)
            {
                me->setActive(true);
                councilGUIDs[0] = instance->GetData64(NPC_GATHIOS_THE_SHATTERER);
                councilGUIDs[1] = instance->GetData64(NPC_HIGH_NETHERMANCER_ZEREVOR);
                councilGUIDs[2] = instance->GetData64(NPC_LADY_MALANDE);
                councilGUIDs[3] = instance->GetData64(NPC_VERAS_DARKSHADOW);

                bool spoken = false;
                for (uint8 i = 0; i < 4; ++i)
                {
                    if (Creature* member = ObjectAccessor::GetCreature(*me, councilGUIDs[i]))
                    {
                        if (!spoken && (roll_chance_i(33) || i == 3))
                        {
                            spoken = true;
                            member->AI()->Talk(SAY_COUNCIL_AGGRO);
                        }
                        member->SetOwnerGUID(me->GetGUID());
                        member->SetInCombatWithZone();
                    }
                }
            }
            else if (param == ACTION_ENRAGE)
            {
                Creature* member = NULL;
                for (uint8 i = 0; i < 4; ++i)
                    if ((member = ObjectAccessor::GetCreature(*me, councilGUIDs[i])))
                        member->AI()->DoAction(ACTION_ENRAGE);
            }
            else if (param == ACTION_END_ENCOUNTER)
            {
                me->setActive(false);
                Creature* member = NULL;
                for (uint8 i = 0; i < 4; ++i)
                    if ((member = ObjectAccessor::GetCreature(*me, councilGUIDs[i])))
                        if (member->IsAlive())
                            Unit::Kill(me, member);
                Unit::Kill(me, me);
            }
        }

        void UpdateAI(uint32  /*diff*/)
        {
            if (!me->isActiveObject())
                return;

            if (!SelectTargetFromPlayerList(115.0f))
            {
                EnterEvadeMode();
                return;
            }

            me->CastSpell(me, SPELL_EMPYREAL_BALANCE, true);
        }
    };

};
struct boss_illidari_council_memberAI : public ScriptedAI
{
    boss_illidari_council_memberAI(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    InstanceScript* instance;
    EventMap events;

    void Reset()
    {
        events.Reset();
    }

    void EnterEvadeMode()
    {
        me->SetOwnerGUID(0);
        ScriptedAI::EnterEvadeMode();
    }

    void DoAction(int32 param)
    {
        if (param == ACTION_ENRAGE)
        {
            me->CastSpell(me, SPELL_BERSERK, true);
            Talk(SAY_COUNCIL_ENRAGE);
        }
    }

    void KilledUnit(Unit*)
    {
        if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
        {
            Talk(SAY_COUNCIL_SLAY);
            events.ScheduleEvent(EVENT_KILL_TALK, 6000);
        }
    }

    void JustDied(Unit*)
    {
        Talk(SAY_COUNCIL_DEATH);
        if (Creature* council = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_ILLIDARI_COUNCIL)))
            council->GetAI()->DoAction(ACTION_END_ENCOUNTER);
    }

    void EnterCombat(Unit*  /*who*/)
    {
        if (Creature* council = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_ILLIDARI_COUNCIL)))
            council->GetAI()->DoAction(ACTION_START_ENCOUNTER);
    }
};

class boss_gathios_the_shatterer : public CreatureScript
{
    public:
        boss_gathios_the_shatterer() : CreatureScript("boss_gathios_the_shatterer") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_gathios_the_shattererAI>(creature);
        }

        struct boss_gathios_the_shattererAI : public boss_illidari_council_memberAI
        {
            boss_gathios_the_shattererAI(Creature* creature) : boss_illidari_council_memberAI(creature) { }

            Creature* SelectCouncilMember()
            {
                if (roll_chance_i(50))
                    return ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_LADY_MALANDE));

                if (roll_chance_i(20))
                    if (Creature* veras = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_VERAS_DARKSHADOW)))
                        if (!veras->HasAura(SPELL_VANISH))
                            return veras;

                return ObjectAccessor::GetCreature(*me, instance->GetData64(RAND(NPC_GATHIOS_THE_SHATTERER, NPC_HIGH_NETHERMANCER_ZEREVOR)));
            }

            void EnterCombat(Unit* who)
            {
                boss_illidari_council_memberAI::EnterCombat(who);
                events.ScheduleEvent(EVENT_SPELL_BLESSING, 10000);
                events.ScheduleEvent(EVENT_SPELL_AURA, 0);
                events.ScheduleEvent(EVENT_SPELL_SEAL, 2000);
                events.ScheduleEvent(EVENT_SPELL_HAMMER_OF_JUSTICE, 6000);
                events.ScheduleEvent(EVENT_SPELL_JUDGEMENT, 8000);
                events.ScheduleEvent(EVENT_SPELL_CONSECRATION, 4000);
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
                    case EVENT_SPELL_BLESSING:
                        if (Unit* member = SelectCouncilMember())
                            me->CastSpell(member, RAND(SPELL_BLESSING_OF_SPELL_WARDING, SPELL_BLESSING_OF_PROTECTION), false);
                        events.ScheduleEvent(EVENT_SPELL_BLESSING, 15000);
                        break;
                    case EVENT_SPELL_AURA:
                        me->CastSpell(me, RAND(SPELL_DEVOTION_AURA, SPELL_CHROMATIC_RESISTANCE_AURA), false);
                        events.ScheduleEvent(EVENT_SPELL_AURA, 60000);
                        break;
                    case EVENT_SPELL_CONSECRATION:
                        if (roll_chance_i(50))
                            Talk(SAY_COUNCIL_SPECIAL);
                        me->CastSpell(me, SPELL_CONSECRATION, false);
                        events.ScheduleEvent(EVENT_SPELL_AURA, 30000);
                        break;
                    case EVENT_SPELL_HAMMER_OF_JUSTICE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, HammerOfJusticeSelector(me)))
                        {
                            me->CastSpell(target, SPELL_HAMMER_OF_JUSTICE, false);
                            events.ScheduleEvent(EVENT_SPELL_HAMMER_OF_JUSTICE, 20000);
                            break;
                        }
                        events.ScheduleEvent(EVENT_SPELL_HAMMER_OF_JUSTICE, 0);
                        break;
                    case EVENT_SPELL_SEAL:
                        me->CastSpell(me, RAND(SPELL_SEAL_OF_COMMAND, SPELL_SEAL_OF_BLOOD), false);
                        events.ScheduleEvent(EVENT_SPELL_SEAL, 20000);
                        break;
                    case EVENT_SPELL_JUDGEMENT:
                        me->CastSpell(me->GetVictim(), SPELL_JUDGEMENT, false);
                        events.ScheduleEvent(EVENT_SPELL_JUDGEMENT, 20000);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };
};

class boss_high_nethermancer_zerevor : public CreatureScript
{
    public:
        boss_high_nethermancer_zerevor() : CreatureScript("boss_high_nethermancer_zerevor") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_high_nethermancer_zerevorAI>(creature);
        }

        struct boss_high_nethermancer_zerevorAI : public boss_illidari_council_memberAI
        {
            boss_high_nethermancer_zerevorAI(Creature* creature) : boss_illidari_council_memberAI(creature) { }

            void AttackStart(Unit* who)
            {
                if (who && me->Attack(who, true))
                    me->GetMotionMaster()->MoveChase(who, 20.0f);
            }

            void EnterCombat(Unit* who)
            {
                boss_illidari_council_memberAI::EnterCombat(who);
                events.ScheduleEvent(EVENT_SPELL_FLAMESTRIKE, 25000);
                events.ScheduleEvent(EVENT_SPELL_BLIZZARD, 5000);
                events.ScheduleEvent(EVENT_SPELL_ARCANE_BOLT, 15000);
                events.ScheduleEvent(EVENT_SPELL_DAMPEN_MAGIC, 0);
                events.ScheduleEvent(EVENT_SPELL_ARCANE_EXPLOSION, 10000);
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
                    case EVENT_SPELL_DAMPEN_MAGIC:
                        me->CastSpell(me, SPELL_DAMPEN_MAGIC, false);
                        events.ScheduleEvent(EVENT_SPELL_DAMPEN_MAGIC, 120000);
                        break;
                    case EVENT_SPELL_ARCANE_BOLT:
                        me->CastSpell(me->GetVictim(), SPELL_ARCANE_BOLT, false);
                        events.ScheduleEvent(EVENT_SPELL_ARCANE_BOLT, 3000);
                        break;
                    case EVENT_SPELL_FLAMESTRIKE:
                        if (roll_chance_i(50))
                            Talk(SAY_COUNCIL_SPECIAL);
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f))
                            me->CastSpell(target, SPELL_FLAMESTRIKE, false);
                        events.ScheduleEvent(EVENT_SPELL_FLAMESTRIKE, 40000);
                        break;
                    case EVENT_SPELL_BLIZZARD:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f))
                            me->CastSpell(target, SPELL_BLIZZARD, false);
                        events.ScheduleEvent(EVENT_SPELL_BLIZZARD, 40000);
                        break;
                    case EVENT_SPELL_ARCANE_EXPLOSION:
                        if (SelectTarget(SELECT_TARGET_RANDOM, 0, 10.0f))
                            me->CastSpell(me, SPELL_ARCANE_EXPLOSION, false);
                        events.ScheduleEvent(EVENT_SPELL_ARCANE_EXPLOSION, 10000);
                        break;                      
                }

                DoMeleeAttackIfReady();
            }
        };
};

class boss_lady_malande : public CreatureScript
{
    public:
        boss_lady_malande() : CreatureScript("boss_lady_malande") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_lady_malandeAI>(creature);
        }

        struct boss_lady_malandeAI : public boss_illidari_council_memberAI
        {
            boss_lady_malandeAI(Creature* creature) : boss_illidari_council_memberAI(creature) { }

            void AttackStart(Unit* who)
            {
                if (who && me->Attack(who, true))
                    me->GetMotionMaster()->MoveChase(who, 20.0f);
            }

            void EnterCombat(Unit* who)
            {
                boss_illidari_council_memberAI::EnterCombat(who);
                events.ScheduleEvent(EVENT_SPELL_REFLECTIVE_SHIELD, 10000);
                events.ScheduleEvent(EVENT_SPELL_CIRCLE_OF_HEALING, 20000);
                events.ScheduleEvent(EVENT_SPELL_DIVINE_WRATH, 5000);
                events.ScheduleEvent(EVENT_SPELL_EMPOWERED_SMITE, 15000);
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
                    case EVENT_SPELL_CIRCLE_OF_HEALING:
                        me->CastSpell(me, SPELL_CIRCLE_OF_HEALING, false);
                        events.ScheduleEvent(EVENT_SPELL_CIRCLE_OF_HEALING, 20000);
                        break;
                    case EVENT_SPELL_REFLECTIVE_SHIELD:
                        if (roll_chance_i(50))
                            Talk(SAY_COUNCIL_SPECIAL);
                        me->CastSpell(me, SPELL_REFLECTIVE_SHIELD, false);
                        events.ScheduleEvent(EVENT_SPELL_REFLECTIVE_SHIELD, 40000);
                        break;
                    case EVENT_SPELL_DIVINE_WRATH:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f))
                            me->CastSpell(target, SPELL_DIVINE_WRATH, false);
                        events.ScheduleEvent(EVENT_SPELL_DIVINE_WRATH, 20000);
                        break;
                    case EVENT_SPELL_EMPOWERED_SMITE:
                        me->CastSpell(me->GetVictim(), SPELL_EMPOWERED_SMITE, false);
                        events.ScheduleEvent(EVENT_SPELL_EMPOWERED_SMITE, 3000);
                        break;                  
                }
            }
        };
};

class boss_veras_darkshadow : public CreatureScript
{
    public:
        boss_veras_darkshadow() : CreatureScript("boss_veras_darkshadow") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_veras_darkshadowAI>(creature);
        }

        struct boss_veras_darkshadowAI : public boss_illidari_council_memberAI
        {
            boss_veras_darkshadowAI(Creature* creature) : boss_illidari_council_memberAI(creature) { }

            void EnterCombat(Unit* who)
            {
                me->SetCanDualWield(true);
                boss_illidari_council_memberAI::EnterCombat(who);
                events.ScheduleEvent(EVENT_SPELL_VANISH, 10000);
                events.ScheduleEvent(EVENT_SPELL_ENRAGE, 900000);
            }

            void JustSummoned(Creature* summon)
            {
                summon->CastSpell(summon, SPELL_VANISH_VISUAL, true);
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
                    case EVENT_SPELL_VANISH:
                        if (roll_chance_i(50))
                            Talk(SAY_COUNCIL_SPECIAL);
                        me->CastSpell(me, SPELL_DEADLY_STRIKE, false);
                        me->CastSpell(me, SPELL_VANISH, false);
                        events.ScheduleEvent(EVENT_SPELL_VANISH, 60000);
                        events.ScheduleEvent(EVENT_SPELL_VANISH_OUT, 29000);
                        break;
                    case EVENT_SPELL_VANISH_OUT:
                        me->CastSpell(me, SPELL_VANISH_OUT, false);
                        break;
                    case EVENT_SPELL_ENRAGE:
                        DoResetThreat();
                        if (Creature* council = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_ILLIDARI_COUNCIL)))
                            council->GetAI()->DoAction(ACTION_ENRAGE);
                        break;
                }

                if (events.GetNextEventTime(EVENT_SPELL_VANISH_OUT) == 0)
                    DoMeleeAttackIfReady();
            }
        };
};

class spell_illidari_council_balance_of_power : public SpellScriptLoader
{
    public:
        spell_illidari_council_balance_of_power() : SpellScriptLoader("spell_illidari_council_balance_of_power") { }

        class spell_illidari_council_balance_of_power_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_illidari_council_balance_of_power_AuraScript);

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
            {
                // Set absorbtion amount to unlimited (no absorb)
                amount = -1;
            }

            void Register()
            {
                 DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_illidari_council_balance_of_power_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_illidari_council_balance_of_power_AuraScript();
        }
};

class spell_illidari_council_empyreal_balance : public SpellScriptLoader
{
    public:
        spell_illidari_council_empyreal_balance() : SpellScriptLoader("spell_illidari_council_empyreal_balance") { }

        class spell_illidari_council_empyreal_balance_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_illidari_council_empyreal_balance_SpellScript);

            bool Load()
            {
                _sharedHealth = 0;
                _sharedHealthMax = 0;
                _targetCount = 0;
                return GetCaster()->GetTypeId() == TYPEID_UNIT;
            }

            void HandleDummy(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                {
                    _targetCount++;
                    _sharedHealth += target->GetHealth();
                    _sharedHealthMax += target->GetMaxHealth();
                }
            }

            void HandleAfterCast()
            {
                if (_targetCount != 4)
                {
                    GetCaster()->ToCreature()->AI()->EnterEvadeMode();
                    return;
                }

                float pct = (_sharedHealth / _sharedHealthMax) * 100.0f;
                std::list<Spell::TargetInfo> const* targetsInfo = GetSpell()->GetUniqueTargetInfo();
                for (std::list<Spell::TargetInfo>::const_iterator ihit = targetsInfo->begin(); ihit != targetsInfo->end(); ++ihit)
                    if (Creature* target = ObjectAccessor::GetCreature(*GetCaster(), ihit->targetGUID))
                    {
                        target->LowerPlayerDamageReq(target->GetMaxHealth());
                        target->SetHealth(CalculatePct(target->GetMaxHealth(), pct));
                    }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_illidari_council_empyreal_balance_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
                AfterCast += SpellCastFn(spell_illidari_council_empyreal_balance_SpellScript::HandleAfterCast);
            }

        private:
            float _sharedHealth;
            float _sharedHealthMax;
            uint8 _targetCount;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_illidari_council_empyreal_balance_SpellScript();
        }
};

class spell_illidari_council_reflective_shield : public SpellScriptLoader
{
    public:
        spell_illidari_council_reflective_shield() : SpellScriptLoader("spell_illidari_council_reflective_shield") { }

        class spell_illidari_council_reflective_shield_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_illidari_council_reflective_shield_AuraScript);

            void ReflectDamage(AuraEffect* aurEff, DamageInfo& dmgInfo, uint32& absorbAmount)
            {
                Unit* target = GetTarget();
                if (dmgInfo.GetAttacker() == target)
                    return;

                int32 bp = absorbAmount / 2;
                target->CastCustomSpell(dmgInfo.GetAttacker(), SPELL_REFLECTIVE_SHIELD_T, &bp, NULL, NULL, true, NULL, aurEff);
            }

            void Register()
            {
                 AfterEffectAbsorb += AuraEffectAbsorbFn(spell_illidari_council_reflective_shield_AuraScript::ReflectDamage, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_illidari_council_reflective_shield_AuraScript();
        }
};

class spell_illidari_council_judgement : public SpellScriptLoader
{
    public:
        spell_illidari_council_judgement() : SpellScriptLoader("spell_illidari_council_judgement") { }

        class spell_illidari_council_judgement_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_illidari_council_judgement_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                Unit::AuraEffectList const& auras = GetCaster()->GetAuraEffectsByType(SPELL_AURA_DUMMY);
                for (Unit::AuraEffectList::const_iterator i = auras.begin(); i != auras.end(); ++i)
                {
                    if ((*i)->GetSpellInfo()->GetSpellSpecific() == SPELL_SPECIFIC_SEAL && (*i)->GetEffIndex() == EFFECT_2)
                        if (sSpellMgr->GetSpellInfo((*i)->GetAmount()))
                        {
                            GetCaster()->CastSpell(GetHitUnit(), (*i)->GetAmount(), true);
                            break;
                        }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_illidari_council_judgement_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_illidari_council_judgement_SpellScript();
        }
};

class spell_illidari_council_deadly_strike : public SpellScriptLoader
{
    public:
        spell_illidari_council_deadly_strike() : SpellScriptLoader("spell_illidari_council_deadly_strike") { }

        class spell_illidari_council_deadly_strike_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_illidari_council_deadly_strike_AuraScript);

            void Update(AuraEffect const* effect)
            {                
                PreventDefaultAction();
                if (Unit* target = GetUnitOwner()->GetAI()->SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                {
                    GetUnitOwner()->CastSpell(target, GetSpellInfo()->Effects[effect->GetEffIndex()].TriggerSpell, true);
                    GetUnitOwner()->m_Events.AddEvent(new VerasEnvenom(*GetUnitOwner(), target->GetGUID()), GetUnitOwner()->m_Events.CalculateTime(urand(1500, 3500)));
                }
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_illidari_council_deadly_strike_AuraScript::Update, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_illidari_council_deadly_strike_AuraScript();
        }
};

void AddSC_boss_illidari_council()
{
    new boss_illidari_council();
    new boss_gathios_the_shatterer();
    new boss_lady_malande();
    new boss_veras_darkshadow();
    new boss_high_nethermancer_zerevor();
    new spell_illidari_council_balance_of_power();
    new spell_illidari_council_empyreal_balance();
    new spell_illidari_council_reflective_shield();
    new spell_illidari_council_judgement();
    new spell_illidari_council_deadly_strike();
}
