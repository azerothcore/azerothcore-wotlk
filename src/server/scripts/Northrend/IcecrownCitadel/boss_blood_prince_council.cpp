/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "icecrown_citadel.h"
#include "Player.h"

enum Texts
{
    // Blood Queen Lana'Thel
    SAY_INTRO_1                 = 0,
    SAY_INTRO_2                 = 1,

    // Prince Keleseth
    SAY_KELESETH_INVOCATION     = 0,
    EMOTE_KELESETH_INVOCATION   = 1,
    SAY_KELESETH_SPECIAL        = 2,
    SAY_KELESETH_KILL           = 3,
    EMOTE_KELESETH_BERSERK      = 4,
    SAY_KELESETH_DEATH          = 5,

    // Prince Taldaram
    SAY_TALDARAM_INVOCATION     = 0,
    EMOTE_TALDARAM_INVOCATION   = 1,
    SAY_TALDARAM_SPECIAL        = 2,
    EMOTE_TALDARAM_FLAME        = 3,
    SAY_TALDARAM_KILL           = 4,
    EMOTE_TALDARAM_BERSERK      = 5,
    EMOTE_TALDARAM_DEATH        = 6,

    // Prince Valanar
    SAY_VALANAR_INVOCATION      = 0,
    EMOTE_VALANAR_INVOCATION    = 1,
    SAY_VALANAR_SPECIAL         = 2,
    EMOTE_VALANAR_SHOCK_VORTEX  = 3,
    SAY_VALANAR_KILL            = 4,
    SAY_VALANAR_BERSERK         = 5,
    SAY_VALANAR_DEATH           = 6,
};

enum Spells
{
    SPELL_FEIGN_DEATH                   = 71598,
    SPELL_OOC_INVOCATION_VISUAL         = 70934,
    SPELL_INVOCATION_VISUAL_ACTIVE      = 71596,
    SPELL_INVOCATION_OF_BLOOD_KELESETH  = 70981,
    SPELL_INVOCATION_OF_BLOOD_TALDARAM  = 70982,
    SPELL_INVOCATION_OF_BLOOD_VALANAR   = 70952,

    // Heroic mode
    SPELL_SHADOW_PRISON                 = 72998,
    SPELL_SHADOW_PRISON_DAMAGE          = 72999,
    SPELL_SHADOW_PRISON_DUMMY           = 73001,

    // Prince Keleseth
    SPELL_SHADOW_RESONANCE              = 71943,
    SPELL_SHADOW_LANCE                  = 71405,
    SPELL_EMPOWERED_SHADOW_LANCE        = 71815,

    // Dark Nucleus
    SPELL_SHADOW_RESONANCE_AURA         = 72980,
    SPELL_SHADOW_RESONANCE_RESIST       = 71822,

    // Prince Taldaram
    SPELL_GLITTERING_SPARKS             = 71806,
    SPELL_CONJURE_FLAME                 = 71718,
    SPELL_CONJURE_EMPOWERED_FLAME       = 72040,

    // Ball of Flame
    SPELL_FLAME_SPHERE_SPAWN_EFFECT     = 55891, // cast from creature_template_addon (needed cast before entering world)
    SPELL_BALL_OF_FLAMES_VISUAL         = 71706,
    SPELL_BALL_OF_FLAMES                = 71714,
    SPELL_FLAMES                        = 71393,
    SPELL_FLAME_SPHERE_DEATH_EFFECT     = 55947,

    // Ball of Inferno Flame
    SPELL_BALL_OF_FLAMES_PROC           = 71756,
    SPELL_BALL_OF_FLAMES_PERIODIC       = 71709,

    // Prince Valanar
    SPELL_KINETIC_BOMB_TARGET           = 72053,
    SPELL_KINETIC_BOMB                  = 72080,
    SPELL_SHOCK_VORTEX                  = 72037,
    SPELL_EMPOWERED_SHOCK_VORTEX        = 72039,

    // Kinetic Bomb
    SPELL_UNSTABLE                      = 72059,
    SPELL_KINETIC_BOMB_VISUAL           = 72054,
    SPELL_KINETIC_BOMB_EXPLOSION        = 72052,
    SPELL_KINETIC_BOMB_KNOCKBACK        = 72087,

    // Shock Vortex
    SPELL_SHOCK_VORTEX_PERIODIC         = 71945,
    SPELL_SHOCK_VORTEX_DUMMY            = 72633,
};

enum Events
{
    EVENT_NONE,
    EVENT_INTRO_1,
    EVENT_INTRO_2,

    EVENT_INVOCATION_OF_BLOOD,
    EVENT_BERSERK,

    // Keleseth
    EVENT_SHADOW_RESONANCE,

    // Taldaram
    EVENT_GLITTERING_SPARKS,
    EVENT_CONJURE_FLAME,

    // Valanar
    EVENT_KINETIC_BOMB,
    EVENT_SHOCK_VORTEX,
    EVENT_BOMB_DESPAWN,
    EVENT_CONTINUE_FALLING,
};

enum Actions
{
    ACTION_STAND_UP             = 1,
    ACTION_CAST_INVOCATION      = 2,
    ACTION_REMOVE_INVOCATION    = 3,
    ACTION_FLAME_BALL_CHASE     = 4,
    ACTION_KINETIC_BOMB_JUMP    = 5,
};

enum Points
{
    POINT_INTRO_DESPAWN         = 380040,
};

class StandUpEvent : public BasicEvent
{
    public:
        StandUpEvent(Creature& owner) : BasicEvent(), _owner(owner) { }

        bool Execute(uint64 /*eventTime*/, uint32 /*diff*/)
        {
            _owner.HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
            return true;
        }

    private:
        Creature& _owner;
};

class ShockVortexExplodeEvent : public BasicEvent
{
    public:
        ShockVortexExplodeEvent(Creature& owner) : BasicEvent(), _owner(owner) { }

        bool Execute(uint64 /*eventTime*/, uint32 /*diff*/)
        {
            _owner.CastSpell(&_owner, SPELL_SHOCK_VORTEX_PERIODIC, true);
            return true;
        }

    private:
        Creature& _owner;
};

Position const introFinalPos = {4660.490f, 2769.200f, 430.0000f, 0.000000f};
Position const triggerPos    = {4680.231f, 2769.134f, 379.9256f, 3.121708f};
Position const triggerEndPos = {4680.180f, 2769.150f, 365.5000f, 3.121708f};

class boss_prince_keleseth_icc : public CreatureScript
{
    public:
        boss_prince_keleseth_icc() : CreatureScript("boss_prince_keleseth_icc") { }

        struct boss_prince_kelesethAI : public ScriptedAI
        {
            boss_prince_kelesethAI(Creature* creature) : ScriptedAI(creature), summons(creature), instance(creature->GetInstanceScript())
            {
                if (!instance)
                {
                    me->IsAIEnabled = false;
                    me->AddUnitState(UNIT_STATE_EVADE);
                }
                _canDie = true;
            }

            void InitializeAI()
            {
                ScriptedAI::InitializeAI();
                if (me->IsAlive())
                {
                    if (Creature* c = me->SummonCreature(WORLD_TRIGGER, me->GetHomePosition()))
                    {
                        c->SetObjectScale(1.75f);
                        c->CastSpell(c, SPELL_FEIGN_DEATH, true);
                    }

                    me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                    me->SetReactState(REACT_PASSIVE);
                }
            }

            EventMap events;
            SummonList summons;
            InstanceScript* instance;
            bool _isEmpowered;
            bool _evading;
            bool _canDie;

            void Reset()
            {
                events.Reset();
                summons.DespawnAll();
                _isEmpowered = false;
                _evading = false;
                me->SetHealth(me->GetMaxHealth());
                me->SetReactState(REACT_AGGRESSIVE);
            }

            void EnterCombat(Unit* who)
            {
                bool valid = true;
                if (Creature* keleseth = instance->instance->GetCreature(instance->GetData64(DATA_PRINCE_KELESETH_GUID)))
                    if (!keleseth->IsAlive() || keleseth->IsInEvadeMode())
                        valid = false;
                if (Creature* taldaram = instance->instance->GetCreature(instance->GetData64(DATA_PRINCE_TALDARAM_GUID)))
                    if (!taldaram->IsAlive() || taldaram->IsInEvadeMode())
                        valid = false;
                if (Creature* valanar = instance->instance->GetCreature(instance->GetData64(DATA_PRINCE_VALANAR_GUID)))
                    if (!valanar->IsAlive() || valanar->IsInEvadeMode())
                        valid = false;
                if (!valid)
                {
                    EnterEvadeMode();
                    return;
                }

                me->RemoveAurasDueToSpell(SPELL_FEIGN_DEATH); // just in case
                me->setActive(true);
                DoZoneInCombat();
                if (!me->hasLootRecipient())
                    me->SetLootRecipient(who);
                me->LowerPlayerDamageReq(me->GetMaxHealth());
                me->SetReactState(REACT_AGGRESSIVE);
                instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me);

                if (Creature* taldaram = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_TALDARAM_GUID)))
                    if (!taldaram->IsInEvadeMode())
                        taldaram->SetInCombatWithZone();
                if (Creature* valanar = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_VALANAR_GUID)))
                    if (!valanar->IsInEvadeMode())
                        valanar->SetInCombatWithZone();

                me->resetAttackTimer(BASE_ATTACK);
                DoAction(ACTION_REMOVE_INVOCATION);
                events.Reset();
                events.ScheduleEvent(EVENT_BERSERK, 600000);
                events.ScheduleEvent(EVENT_SHADOW_RESONANCE, urand(10000, 15000));
                if (IsHeroic())
                    me->AddAura(SPELL_SHADOW_PRISON, me);
            }

            void AttackStart(Unit* who)
            {
                ScriptedAI::AttackStartCaster(who, 10.0f);
            }

            void JustDied(Unit* /*killer*/)
            {
                events.Reset();
                summons.DespawnAll();
                instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);

                if (!_canDie)
                {
                    me->RemoveCorpse(false);
                    me->SetRespawnTime(10);
                    me->SaveRespawnTime();
                    Position homePos = me->GetHomePosition();
                    me->UpdatePosition(homePos);
                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MoveIdle();
                    me->StopMovingOnCurrentPos();
                    return;
                }

                Talk(SAY_KELESETH_DEATH);
                if (Creature* taldaram = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_TALDARAM_GUID)))
                    if (taldaram->IsAlive())
                        Unit::Kill(taldaram, taldaram);
                if (Creature* valanar = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_VALANAR_GUID)))
                    if (valanar->IsAlive())
                        Unit::Kill(valanar, valanar);
            }

            void JustRespawned()
            {
                ScriptedAI::JustRespawned();
                JustReachedHome();
            }

            void JustReachedHome()
            {
                _canDie = true;
                me->setActive(false);
                instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
                DoAction(ACTION_REMOVE_INVOCATION);
                me->SetHealth(1);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
            }

            void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask)
            {
                if (!_isEmpowered)
                {
                    if (attacker)
                        me->AddThreat(attacker, float(damage));
                    damage = 0;
                }
            }

            void DamageDealt(Unit* target, uint32& damage, DamageEffectType  /*damageType*/)
            {
                if (target->GetTypeId() != TYPEID_PLAYER)
                    return;

                if (damage > RAID_MODE<uint32>(23000, 25000, 23000, 25000))
                    instance->SetData(DATA_ORB_WHISPERER_ACHIEVEMENT, 0);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_KELESETH_KILL);
            }

            void SpellHit(Unit* /*caster*/, SpellInfo const* spell)
            {
                if (spell->Id == 71080 && me->IsInCombat() && !me->IsInEvadeMode())
                    DoAction(ACTION_CAST_INVOCATION);
            }

            void DoAction(int32 action)
            {
                switch (action)
                {
                    case ACTION_STAND_UP:
                        summons.DespawnEntry(WORLD_TRIGGER);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_29 | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                        me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->ForceValuesUpdateAtIndex(UNIT_NPC_FLAGS);   // was in sniff. don't ask why
                        me->m_Events.AddEvent(new StandUpEvent(*me), me->m_Events.CalculateTime(1000));
                        DoAction(ACTION_REMOVE_INVOCATION);
                        me->SetHealth(1);
                        break;
                    case ACTION_CAST_INVOCATION:
                        Talk(SAY_KELESETH_INVOCATION);
                        me->CastSpell(me, SPELL_INVOCATION_OF_BLOOD_KELESETH, true);
                        me->CastSpell(me, SPELL_INVOCATION_VISUAL_ACTIVE, true);
                        _isEmpowered = true;
                        break;
                    case ACTION_REMOVE_INVOCATION:
                        _isEmpowered = false;
                        me->RemoveAurasDueToSpell(SPELL_INVOCATION_VISUAL_ACTIVE);
                        me->RemoveAurasDueToSpell(SPELL_INVOCATION_OF_BLOOD_KELESETH);
                        break;
                    default:
                        break;
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
                    case EVENT_BERSERK:
                        me->CastSpell(me, SPELL_BERSERK, true);
                        Talk(EMOTE_KELESETH_BERSERK);
                        break;
                    case EVENT_SHADOW_RESONANCE:
                        Talk(SAY_KELESETH_SPECIAL);
                        me->CastSpell(me, SPELL_SHADOW_RESONANCE, false);
                        events.ScheduleEvent(EVENT_SHADOW_RESONANCE, urand(10000, 15000));
                        break;
                }

                DoSpellAttackIfReady(_isEmpowered ? SPELL_EMPOWERED_SHADOW_LANCE : SPELL_SHADOW_LANCE);
            }

            void EnterEvadeMode()
            {
                if (_evading)
                    return;
                _canDie = false;
                me->SetHealth(me->GetMaxHealth());
                DoAction(ACTION_REMOVE_INVOCATION);
                _evading = true;
                if (Creature* taldaram = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_TALDARAM_GUID)))
                    taldaram->AI()->EnterEvadeMode();
                if (Creature* valanar = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_VALANAR_GUID)))
                    valanar->AI()->EnterEvadeMode();
                ScriptedAI::EnterEvadeMode();
                _evading = false;
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<boss_prince_kelesethAI>(creature);
        }
};

class boss_prince_taldaram_icc : public CreatureScript
{
    public:
        boss_prince_taldaram_icc() : CreatureScript("boss_prince_taldaram_icc") { }

        struct boss_prince_taldaramAI : public ScriptedAI
        {
            boss_prince_taldaramAI(Creature* creature) : ScriptedAI(creature), summons(creature), instance(creature->GetInstanceScript())
            {
                if (!instance)
                {
                    me->IsAIEnabled = false;
                    me->AddUnitState(UNIT_STATE_EVADE);
                }
                _canDie = true;
            }

            void InitializeAI()
            {
                ScriptedAI::InitializeAI();
                if (me->IsAlive())
                {
                    if (Creature* c = me->SummonCreature(WORLD_TRIGGER, me->GetHomePosition()))
                    {
                        c->SetObjectScale(1.75f);
                        c->CastSpell(c, SPELL_FEIGN_DEATH, true);
                    }

                    me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                    me->SetReactState(REACT_PASSIVE);
                }
            }

            EventMap events;
            SummonList summons;
            InstanceScript* instance;
            bool _isEmpowered;
            bool _evading;
            bool _canDie;

            void Reset()
            {
                events.Reset();
                summons.DespawnAll();
                _isEmpowered = false;
                _evading = false;
                me->SetHealth(me->GetMaxHealth());
                me->SetReactState(REACT_AGGRESSIVE);
            }

            void EnterCombat(Unit* who)
            {
                bool valid = true;
                if (Creature* keleseth = instance->instance->GetCreature(instance->GetData64(DATA_PRINCE_KELESETH_GUID)))
                    if (!keleseth->IsAlive() || keleseth->IsInEvadeMode())
                        valid = false;
                if (Creature* taldaram = instance->instance->GetCreature(instance->GetData64(DATA_PRINCE_TALDARAM_GUID)))
                    if (!taldaram->IsAlive() || taldaram->IsInEvadeMode())
                        valid = false;
                if (Creature* valanar = instance->instance->GetCreature(instance->GetData64(DATA_PRINCE_VALANAR_GUID)))
                    if (!valanar->IsAlive() || valanar->IsInEvadeMode())
                        valid = false;
                if (!valid)
                {
                    EnterEvadeMode();
                    return;
                }

                me->RemoveAurasDueToSpell(SPELL_FEIGN_DEATH); // just in case
                me->setActive(true);
                DoZoneInCombat();
                if (!me->hasLootRecipient())
                    me->SetLootRecipient(who);
                me->LowerPlayerDamageReq(me->GetMaxHealth());
                me->SetReactState(REACT_AGGRESSIVE);
                instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me);

                if (Creature* keleseth = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_KELESETH_GUID)))
                    if (!keleseth->IsInEvadeMode())
                        keleseth->SetInCombatWithZone();
                if (Creature* valanar = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_VALANAR_GUID)))
                    if (!valanar->IsInEvadeMode())
                        valanar->SetInCombatWithZone();

                DoAction(ACTION_REMOVE_INVOCATION);
                events.Reset();
                events.ScheduleEvent(EVENT_BERSERK, 600000);
                events.ScheduleEvent(EVENT_GLITTERING_SPARKS, urand(12000, 15000));
                events.ScheduleEvent(EVENT_CONJURE_FLAME, 20000);
                if (IsHeroic())
                    me->AddAura(SPELL_SHADOW_PRISON, me);
            }

            void JustDied(Unit* /*killer*/)
            {
                events.Reset();
                summons.DespawnAll();
                instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);

                if (!_canDie)
                {
                    me->RemoveCorpse(false);
                    me->SetRespawnTime(10);
                    me->SaveRespawnTime();
                    Position homePos = me->GetHomePosition();
                    me->UpdatePosition(homePos);
                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MoveIdle();
                    me->StopMovingOnCurrentPos();
                    return;
                }

                Talk(EMOTE_TALDARAM_DEATH);
                if (Creature* keleseth = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_KELESETH_GUID)))
                    if (keleseth->IsAlive())
                        Unit::Kill(keleseth, keleseth);
                if (Creature* valanar = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_VALANAR_GUID)))
                    if (valanar->IsAlive())
                        Unit::Kill(valanar, valanar);
            }

            void JustRespawned()
            {
                ScriptedAI::JustRespawned();
                JustReachedHome();
            }

            void JustReachedHome()
            {
                _canDie = true;
                me->setActive(false);
                instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
                DoAction(ACTION_REMOVE_INVOCATION);
                me->SetHealth(1);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);

                Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, -10.0f, true);
                if (!target)
                    target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true);
                if (target)
                {
                    if (summon->GetEntry() == NPC_BALL_OF_INFERNO_FLAME)
                        Talk(EMOTE_TALDARAM_FLAME, target);
                    summon->AI()->SetGUID(target->GetGUID());
                }
            }

            void SummonedCreatureDespawn(Creature* s)
            {
                summons.Despawn(s);
            }

            void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask)
            {
                if (!_isEmpowered)
                {
                    if (attacker)
                        me->AddThreat(attacker, float(damage));
                    damage = 0;
                }
            }

            void DamageDealt(Unit* target, uint32& damage, DamageEffectType  /*damageType*/)
            {
                if (target->GetTypeId() != TYPEID_PLAYER)
                    return;

                if (damage > RAID_MODE<uint32>(23000, 25000, 23000, 25000))
                    instance->SetData(DATA_ORB_WHISPERER_ACHIEVEMENT, 0);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_TALDARAM_KILL);
            }

            void SpellHit(Unit* /*caster*/, SpellInfo const* spell)
            {
                if (spell->Id == 71081 && me->IsInCombat() && !me->IsInEvadeMode())
                    DoAction(ACTION_CAST_INVOCATION);
            }

            void DoAction(int32 action)
            {
                switch (action)
                {
                    case ACTION_STAND_UP:
                        summons.DespawnEntry(WORLD_TRIGGER);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_29 | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                        me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->ForceValuesUpdateAtIndex(UNIT_NPC_FLAGS);   // was in sniff. don't ask why
                        me->m_Events.AddEvent(new StandUpEvent(*me), me->m_Events.CalculateTime(1000));
                        DoAction(ACTION_REMOVE_INVOCATION);
                        me->SetHealth(1);
                        break;
                    case ACTION_CAST_INVOCATION:
                        Talk(SAY_TALDARAM_INVOCATION);
                        me->CastSpell(me, SPELL_INVOCATION_OF_BLOOD_TALDARAM, true);
                        me->CastSpell(me, SPELL_INVOCATION_VISUAL_ACTIVE, true);
                        _isEmpowered = true;
                        break;
                    case ACTION_REMOVE_INVOCATION:
                        _isEmpowered = false;
                        me->RemoveAurasDueToSpell(SPELL_INVOCATION_VISUAL_ACTIVE);
                        me->RemoveAurasDueToSpell(SPELL_INVOCATION_OF_BLOOD_TALDARAM);
                        break;
                    case ACTION_FLAME_BALL_CHASE:
                        summons.DoAction(ACTION_FLAME_BALL_CHASE, 1);
                        break;
                    default:
                        break;
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
                    case EVENT_BERSERK:
                        me->CastSpell(me, SPELL_BERSERK, true);
                        Talk(EMOTE_TALDARAM_BERSERK);
                        break;
                    case EVENT_GLITTERING_SPARKS:
                        me->CastSpell(me->GetVictim(), SPELL_GLITTERING_SPARKS, false);
                        events.ScheduleEvent(EVENT_GLITTERING_SPARKS, urand(15000, 25000));
                        break;
                    case EVENT_CONJURE_FLAME:
                        if (_isEmpowered)
                        {
                            me->CastSpell(me, SPELL_CONJURE_EMPOWERED_FLAME, false);
                            events.ScheduleEvent(EVENT_CONJURE_FLAME, 15000);
                        }
                        else
                        {
                            me->CastSpell(me, SPELL_CONJURE_FLAME, false);
                            events.ScheduleEvent(EVENT_CONJURE_FLAME, urand(20000, 25000));
                        }
                        Talk(SAY_TALDARAM_SPECIAL);
                        break;
                }

                DoMeleeAttackIfReady();
            }

            void EnterEvadeMode()
            {
                if (_evading)
                    return;
                _canDie = false;
                me->SetHealth(me->GetMaxHealth());
                DoAction(ACTION_REMOVE_INVOCATION);
                _evading = true;
                if (Creature* keleseth = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_KELESETH_GUID)))
                    keleseth->AI()->EnterEvadeMode();
                if (Creature* valanar = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_VALANAR_GUID)))
                    valanar->AI()->EnterEvadeMode();
                ScriptedAI::EnterEvadeMode();
                _evading = false;
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<boss_prince_taldaramAI>(creature);
        }
};

class boss_prince_valanar_icc : public CreatureScript
{
    public:
        boss_prince_valanar_icc() : CreatureScript("boss_prince_valanar_icc") { }

        struct boss_prince_valanarAI : public BossAI
        {
            boss_prince_valanarAI(Creature* creature) : BossAI(creature, DATA_BLOOD_PRINCE_COUNCIL)
            {
                if (!instance)
                {
                    me->IsAIEnabled = false;
                    me->AddUnitState(UNIT_STATE_EVADE);
                }
                _canDie = true;
            }

            void InitializeAI()
            {
                ScriptedAI::InitializeAI();
                if (me->IsAlive())
                {
                    if (Creature* c = me->SummonCreature(WORLD_TRIGGER, me->GetHomePosition()))
                    {
                        c->SetObjectScale(1.75f);
                        c->CastSpell(c, SPELL_FEIGN_DEATH, true);
                    }

                    me->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                    me->SetReactState(REACT_PASSIVE);
                }
            }

            bool _isEmpowered;
            bool _evading;
            bool _canDie;
            uint32 invocationOrder[3];
            uint8 currentInvocationIndex;

            void Reset()
            {
                events.Reset();
                summons.DespawnAll();
                _isEmpowered = false;
                _evading = false;
                me->SetHealth(me->GetMaxHealth());
                me->SetReactState(REACT_AGGRESSIVE);
                instance->SetBossState(DATA_BLOOD_PRINCE_COUNCIL, NOT_STARTED);
            }

            void EnterCombat(Unit* who)
            {
                bool valid = true;
                if (Creature* keleseth = instance->instance->GetCreature(instance->GetData64(DATA_PRINCE_KELESETH_GUID)))
                    if (!keleseth->IsAlive() || keleseth->IsInEvadeMode())
                        valid = false;
                if (Creature* taldaram = instance->instance->GetCreature(instance->GetData64(DATA_PRINCE_TALDARAM_GUID)))
                    if (!taldaram->IsAlive() || taldaram->IsInEvadeMode())
                        valid = false;
                if (Creature* valanar = instance->instance->GetCreature(instance->GetData64(DATA_PRINCE_VALANAR_GUID)))
                    if (!valanar->IsAlive() || valanar->IsInEvadeMode())
                        valid = false;
                if (!valid)
                {
                    EnterEvadeMode();
                    return;
                }

                instance->SetBossState(DATA_BLOOD_PRINCE_COUNCIL, IN_PROGRESS);
                instance->SetData(DATA_ORB_WHISPERER_ACHIEVEMENT, 1);
                me->RemoveAurasDueToSpell(SPELL_FEIGN_DEATH); // just in case
                me->setActive(true);
                DoZoneInCombat();
                if (!me->hasLootRecipient())
                    me->SetLootRecipient(who);
                me->LowerPlayerDamageReq(me->GetMaxHealth());
                me->SetReactState(REACT_AGGRESSIVE);
                instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me);

                if (Creature* keleseth = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_KELESETH_GUID)))
                    if (!keleseth->IsInEvadeMode())
                        keleseth->SetInCombatWithZone();
                if (Creature* taldaram = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_TALDARAM_GUID)))
                    if (!taldaram->IsInEvadeMode())
                        taldaram->SetInCombatWithZone();

                DoAction(ACTION_CAST_INVOCATION);
                currentInvocationIndex = 0;
                invocationOrder[0] = DATA_PRINCE_VALANAR_GUID;
                invocationOrder[1] = RAND(DATA_PRINCE_KELESETH_GUID, DATA_PRINCE_TALDARAM_GUID);
                invocationOrder[2] = DATA_PRINCE_KELESETH_GUID + DATA_PRINCE_TALDARAM_GUID - invocationOrder[1];

                events.ScheduleEvent(EVENT_BERSERK, 600000);
                events.ScheduleEvent(EVENT_KINETIC_BOMB, urand(18000, 24000));
                events.ScheduleEvent(EVENT_SHOCK_VORTEX, urand(15000, 20000));
                events.ScheduleEvent(EVENT_INVOCATION_OF_BLOOD, 45000);
                if (IsHeroic())
                {
                    me->AddAura(SPELL_SHADOW_PRISON, me);
                    me->CastSpell(me, SPELL_SHADOW_PRISON_DUMMY, true);
                }
            }

            void JustDied(Unit* /*killer*/)
            {
                events.Reset();
                summons.DespawnAll();
                instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);

                if (!_canDie)
                {
                    me->RemoveCorpse(false);
                    me->SetRespawnTime(10);
                    me->SaveRespawnTime();
                    Position homePos = me->GetHomePosition();
                    me->UpdatePosition(homePos);
                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MoveIdle();
                    me->StopMovingOnCurrentPos();
                    return;
                }

                Talk(SAY_VALANAR_DEATH);
                instance->SetBossState(DATA_BLOOD_PRINCE_COUNCIL, DONE);
                if (Creature* keleseth = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_KELESETH_GUID)))
                    if (keleseth->IsAlive())
                        Unit::Kill(keleseth, keleseth);
                if (Creature* taldaram = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_TALDARAM_GUID)))
                    if (taldaram->IsAlive())
                        Unit::Kill(taldaram, taldaram);
            }

            void JustRespawned()
            {
                BossAI::JustRespawned();
                JustReachedHome();
            }

            void JustReachedHome()
            {
                _canDie = true;
                me->setActive(false);
                instance->SetBossState(DATA_BLOOD_PRINCE_COUNCIL, FAIL);
                instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
                me->SetHealth(me->GetMaxHealth());
                DoAction(ACTION_CAST_INVOCATION);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                switch (summon->GetEntry())
                {
                    case NPC_KINETIC_BOMB_TARGET:
                        summon->SetReactState(REACT_PASSIVE);
                        summon->CastSpell(summon, SPELL_KINETIC_BOMB, true, NULL, NULL, me->GetGUID());
                        break;
                    case NPC_SHOCK_VORTEX:
                        summon->m_Events.AddEvent(new ShockVortexExplodeEvent(*summon), summon->m_Events.CalculateTime(4500));
                        break;
                    default:
                        break;
                }
            }

            void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask)
            {
                if (!_isEmpowered)
                {
                    if (attacker)
                        me->AddThreat(attacker, float(damage));
                    damage = 0;
                }
            }

            void DamageDealt(Unit* target, uint32& damage, DamageEffectType  /*damageType*/)
            {
                if (target->GetTypeId() != TYPEID_PLAYER)
                    return;

                if (damage > RAID_MODE<uint32>(23000, 25000, 23000, 25000))
                    instance->SetData(DATA_ORB_WHISPERER_ACHIEVEMENT, 0);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_VALANAR_KILL);
            }

            void SpellHit(Unit* /*caster*/, SpellInfo const* spell)
            {
                if (spell->Id == 71070 && me->IsInCombat() && !me->IsInEvadeMode())
                    DoAction(ACTION_CAST_INVOCATION);
            }

            void DoAction(int32 action)
            {
                switch (action)
                {
                    case ACTION_STAND_UP:
                        summons.DespawnEntry(WORLD_TRIGGER);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_29 | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                        me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_DEAD);
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->ForceValuesUpdateAtIndex(UNIT_NPC_FLAGS);   // was in sniff. don't ask why
                        me->m_Events.AddEvent(new StandUpEvent(*me), me->m_Events.CalculateTime(1000));
                        me->SetHealth(me->GetMaxHealth());
                        DoAction(ACTION_CAST_INVOCATION);
                        break;
                    case ACTION_CAST_INVOCATION:
                        if (me->IsInCombat())
                            Talk(SAY_VALANAR_INVOCATION);
                        me->CastSpell(me, SPELL_INVOCATION_OF_BLOOD_VALANAR, true);
                        me->CastSpell(me, SPELL_INVOCATION_VISUAL_ACTIVE, true);
                        _isEmpowered = true;
                        break;
                    case ACTION_REMOVE_INVOCATION:
                        _isEmpowered = false;
                        me->RemoveAurasDueToSpell(SPELL_INVOCATION_VISUAL_ACTIVE);
                        me->RemoveAurasDueToSpell(SPELL_INVOCATION_OF_BLOOD_VALANAR);
                        break;
                    default:
                        break;
                }
            }

            bool CheckRoom()
            {
                Creature* keleseth = instance->instance->GetCreature(instance->GetData64(DATA_PRINCE_KELESETH_GUID));
                Creature* taldaram = instance->instance->GetCreature(instance->GetData64(DATA_PRINCE_TALDARAM_GUID));
                if (keleseth && taldaram && CheckBoundary(me) && CheckBoundary(keleseth) && CheckBoundary(taldaram))
                    return true;

                EnterEvadeMode();
                return false;
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim() || !CheckRoom())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_INVOCATION_OF_BLOOD:
                        {
                            uint32 visualSpellId = 0;
                            Creature* current = instance->instance->GetCreature(instance->GetData64(invocationOrder[currentInvocationIndex]));
                            if (++currentInvocationIndex >= 3)
                                currentInvocationIndex = 0;
                            Creature* next = instance->instance->GetCreature(instance->GetData64(invocationOrder[currentInvocationIndex]));
                            switch (invocationOrder[currentInvocationIndex])
                            {
                                case DATA_PRINCE_KELESETH_GUID:
                                    visualSpellId = 71080;
                                    break;
                                case DATA_PRINCE_TALDARAM_GUID:
                                    visualSpellId = 71081;
                                    break;
                                case DATA_PRINCE_VALANAR_GUID:
                                    visualSpellId = 71070;
                                    break;
                            }
                            if (!visualSpellId || !current || !next || !current->IsInCombat() || !next->IsInCombat())
                            {
                                EnterEvadeMode();
                                return;
                            }
                            next->SetHealth(current->GetHealth());
                            current->AI()->DoAction(ACTION_REMOVE_INVOCATION);
                            current->SetHealth(1);
                            current->CastSpell((Unit*)NULL, visualSpellId, true);
                            next->AI()->Talk(1);
                        }
                        events.ScheduleEvent(EVENT_INVOCATION_OF_BLOOD, 46000);
                        break;
                    case EVENT_BERSERK:
                        me->CastSpell(me, SPELL_BERSERK, true);
                        Talk(SAY_VALANAR_BERSERK);
                        break;
                    case EVENT_KINETIC_BOMB:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                        {
                            me->CastSpell(target, SPELL_KINETIC_BOMB_TARGET, false);
                            Talk(SAY_VALANAR_SPECIAL);
                        }
                        events.ScheduleEvent(EVENT_KINETIC_BOMB, me->GetMap()->Is25ManRaid() ? 20500 : 30500);
                        break;
                    case EVENT_SHOCK_VORTEX:
                        if (_isEmpowered)
                        {
                            me->CastSpell(me, SPELL_EMPOWERED_SHOCK_VORTEX, false);
                            Talk(EMOTE_VALANAR_SHOCK_VORTEX);
                            events.ScheduleEvent(EVENT_SHOCK_VORTEX, 30000);
                        }
                        else
                        {
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                                me->CastSpell(target, SPELL_SHOCK_VORTEX, false);
                            events.ScheduleEvent(EVENT_SHOCK_VORTEX, urand(18000, 23000));
                        }
                        break;
                }

                DoMeleeAttackIfReady();
            }

            void EnterEvadeMode()
            {
                if (_evading)
                    return;
                _canDie = false;
                me->SetHealth(me->GetMaxHealth());
                DoAction(ACTION_REMOVE_INVOCATION);
                _evading = true;
                if (Creature* keleseth = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_KELESETH_GUID)))
                    keleseth->AI()->EnterEvadeMode();
                if (Creature* taldaram = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_TALDARAM_GUID)))
                    taldaram->AI()->EnterEvadeMode();
                BossAI::EnterEvadeMode();
                _evading = false;
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<boss_prince_valanarAI>(creature);
        }
};

class npc_blood_queen_lana_thel : public CreatureScript
{
    public:
        npc_blood_queen_lana_thel() : CreatureScript("npc_blood_queen_lana_thel") { }

        struct npc_blood_queen_lana_thelAI : public ScriptedAI
        {
            npc_blood_queen_lana_thelAI(Creature* creature) : ScriptedAI(creature)
            {
                _introDone = false;
                _instance = creature->GetInstanceScript();
                me->m_SightDistance = 100.0f; // for MoveInLineOfSight distance
            }

            void Reset()
            {
                _events.Reset();
                me->SetDisableGravity(true);
                if (_instance->GetBossState(DATA_BLOOD_PRINCE_COUNCIL) == DONE)
                {
                    me->SetVisible(false);
                    _introDone = true;
                }
                else
                    me->SetVisible(true);
            }

            void MoveInLineOfSight(Unit* who)
            {
                if (_introDone)
                    return;

                if (who->GetTypeId() != TYPEID_PLAYER || me->GetExactDist2d(who) > 100.0f)
                    return;

                _introDone = true;
                Talk(SAY_INTRO_1);
                _events.SetPhase(1);
                _events.ScheduleEvent(EVENT_INTRO_1, 14000);
                // summon a visual trigger
                if (Creature* summon = DoSummon(NPC_FLOATING_TRIGGER, triggerPos, 15000, TEMPSUMMON_TIMED_DESPAWN))
                {
                    summon->SetDisplayId(11686); // it's a general npc, and the template has 2 models (first is an infernal)
                    summon->CastSpell(summon, SPELL_OOC_INVOCATION_VISUAL, true);
                    summon->SetSpeed(MOVE_RUN, 0.15f, true);
                    summon->GetMotionMaster()->MovePoint(0, triggerEndPos);
                }
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type == POINT_MOTION_TYPE && id == POINT_INTRO_DESPAWN)
                    me->SetVisible(false);
            }

            void UpdateAI(uint32 diff)
            {
                if (!_events.GetPhaseMask())
                    return;

                _events.Update(diff);

                if (_events.ExecuteEvent() == EVENT_INTRO_1)
                {
                    Talk(SAY_INTRO_2);
                    me->GetMotionMaster()->MovePoint(POINT_INTRO_DESPAWN, introFinalPos);
                    _events.Reset();

                    if (Creature* keleseth = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_PRINCE_KELESETH_GUID)))
                        keleseth->AI()->DoAction(ACTION_STAND_UP);
                    if (Creature* taldaram = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_PRINCE_TALDARAM_GUID)))
                        taldaram->AI()->DoAction(ACTION_STAND_UP);
                    if (Creature* valanar = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_PRINCE_VALANAR_GUID)))
                        valanar->AI()->DoAction(ACTION_STAND_UP);
                }
            }

        private:
            EventMap _events;
            InstanceScript* _instance;
            bool _introDone;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_blood_queen_lana_thelAI>(creature);
        }
};

class npc_dark_nucleus : public CreatureScript
{
    public:
        npc_dark_nucleus() : CreatureScript("npc_dark_nucleus") { }

        struct npc_dark_nucleusAI : public ScriptedAI
        {
            npc_dark_nucleusAI(Creature* creature) : ScriptedAI(creature) {}

            uint16 timer;

            void Reset()
            {
                timer = 0;
                me->SetReactState(REACT_DEFENSIVE);
                me->SetHover(true);
                me->CastSpell(me, SPELL_SHADOW_RESONANCE_AURA, true);
            }

            void AttackStart(Unit* who)
            {
                if (who != me->GetVictim())
                {
                    me->InterruptNonMeleeSpells(true, 0, true);
                    me->CastSpell(who, SPELL_SHADOW_RESONANCE_RESIST, false);
                    me->ClearUnitState(UNIT_STATE_CASTING);
                }
                ScriptedAI::AttackStart(who);
            }

            void DamageTaken(Unit* attacker, uint32& /*damage*/, DamageEffectType det, SpellSchoolMask)
            {
                if (!attacker || attacker == me || attacker == me->GetVictim() || (det != DIRECT_DAMAGE && det != SPELL_DIRECT_DAMAGE))
                    return;

                me->DeleteThreatList();
                me->AddThreat(attacker, 500000000.0f);
            }

            void JustDied(Unit* /*killer*/)
            {
                me->DespawnOrUnsummon(1);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                if (timer <= diff)
                {
                    timer = 1000;
                    if (Unit* victim = me->GetVictim())
                        if (me->GetDistance(victim) < 15.0f && !victim->HasAura(SPELL_SHADOW_RESONANCE_RESIST, me->GetGUID()))
                        {
                            me->InterruptNonMeleeSpells(true, 0, true);
                            me->CastSpell(victim, SPELL_SHADOW_RESONANCE_RESIST, false);
                            me->ClearUnitState(UNIT_STATE_CASTING);
                        }
                }
                else
                    timer -= diff;
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_dark_nucleusAI>(creature);
        }
};

class npc_ball_of_flame : public CreatureScript
{
    public:
        npc_ball_of_flame() : CreatureScript("npc_ball_of_flame") { }

        struct npc_ball_of_flameAI : public ScriptedAI
        {
            npc_ball_of_flameAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript())
            {
                _chaseGUID = 0;
                _exploded = false;
                _started = false;
                if (me->GetEntry() == NPC_BALL_OF_INFERNO_FLAME)
                    me->CastSpell(me, SPELL_BALL_OF_FLAMES_PROC, true);
                me->NearTeleportTo(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+5.0f, me->GetOrientation());
            }

            InstanceScript* _instance;
            uint64 _chaseGUID;
            bool _exploded;
            bool _started;

            void AttackStart(Unit* who)
            {
                if (_started)
                    ScriptedAI::AttackStart(who);
            }

            void MoveInLineOfSight(Unit* /*who*/) {}

            void MovementInform(uint32 type, uint32  /*id*/)
            {
                if (type == CHASE_MOTION_TYPE && !_exploded)
                {
                    me->RemoveAurasDueToSpell(SPELL_BALL_OF_FLAMES_PERIODIC);
                    me->SetReactState(REACT_PASSIVE);
                    me->SetControlled(true, UNIT_STATE_ROOT);
                    me->StopMoving();
                    me->CastSpell(me, SPELL_FLAMES, true);
                    me->DespawnOrUnsummon(999);
                    me->CastSpell(me, SPELL_FLAME_SPHERE_DEATH_EFFECT, true);
                    _exploded = true;
                }
            }

            void SetGUID(uint64 guid, int32 /*type*/)
            {
                _chaseGUID = guid;
            }

            void DoAction(int32 action)
            {
                if (action != ACTION_FLAME_BALL_CHASE || me->IsInCombat())
                    return;
                Player* target = NULL;
                if (_chaseGUID)
                    target = ObjectAccessor::GetPlayer(*me, _chaseGUID);
                if (!target)
                    target = ScriptedAI::SelectTargetFromPlayerList(150.0f, 0, true);
                if (target)
                {
                    // need to clear states now because this call is before AuraEffect is fully removed
                    _started = true;
                    if (me->GetEntry() == NPC_BALL_OF_INFERNO_FLAME)
                        me->CastSpell(me, SPELL_BALL_OF_FLAMES_PERIODIC, true);
                    me->ClearUnitState(UNIT_STATE_CASTING | UNIT_STATE_STUNNED);
                    me->AddThreat(target, 1000.0f);
                    me->SetCanFly(true);
                    me->SetDisableGravity(true);
                    me->SetHover(true);
                    me->SendMovementFlagUpdate();
                    AttackStart(target);
                    me->SetInCombatWithZone();
                    return;
                }
                me->DespawnOrUnsummon(1);
            }

            void DamageDealt(Unit* target, uint32& damage, DamageEffectType  /*damageType*/)
            {
                if (target->GetTypeId() != TYPEID_PLAYER)
                    return;

                if (damage > RAID_MODE<uint32>(23000, 25000, 23000, 25000))
                    _instance->SetData(DATA_ORB_WHISPERER_ACHIEVEMENT, 0);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_ball_of_flameAI>(creature);
        }
};

class npc_kinetic_bomb : public CreatureScript
{
    public:
        npc_kinetic_bomb() : CreatureScript("npc_kinetic_bomb") { }

        struct npc_kinetic_bombAI : public NullCreatureAI
        {
            npc_kinetic_bombAI(Creature* creature) : NullCreatureAI(creature)
            {
            }

            EventMap _events;
            float _x;
            float _y;
            float _groundZ;
            bool exploded;

            void IsSummonedBy(Unit* /*summoner*/)
            {
                if (InstanceScript* instance = me->GetInstanceScript())
                    if (Creature* valanar = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PRINCE_VALANAR_GUID)))
                        valanar->AI()->JustSummoned(me);
            }

            void Reset()
            {
                _events.Reset();
                _events.RescheduleEvent(EVENT_BOMB_DESPAWN, 60000);
                me->SetWalk(true);
                exploded = false;

                float x, y, z;
                me->GetPosition(x, y, z);
                _x = x;
                _y = y;
                _groundZ = me->GetMap()->GetHeight(me->GetPhaseMask(), x, y, z, true, 500.0f);
                me->GetMotionMaster()->MoveCharge(_x, _y, _groundZ, me->GetSpeed(MOVE_WALK));
            }

            void DoAction(int32 action)
            {
                if (action == SPELL_KINETIC_BOMB_EXPLOSION)
                {
                    exploded = true;
                    _events.RescheduleEvent(EVENT_BOMB_DESPAWN, 1000);
                }
                else if (action == ACTION_KINETIC_BOMB_JUMP)
                {
                    if (!me->HasAura(SPELL_KINETIC_BOMB_KNOCKBACK))
                    {
                        me->GetMotionMaster()->MovementExpired(false);
                        me->StopMoving();
                        me->GetMotionMaster()->MoveCharge(_x, _y, me->GetPositionZ() + 60.0f, me->GetSpeed(MOVE_RUN));
                    }
                    _events.RescheduleEvent(EVENT_CONTINUE_FALLING, 3000);
                }
            }

            void UpdateAI(uint32 diff)
            {
                _events.Update(diff);
                switch (_events.ExecuteEvent())
                {
                    case EVENT_BOMB_DESPAWN:
                        me->RemoveAllAuras();
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        me->DespawnOrUnsummon(exploded ? 5000 : 0);
                        break;
                    case EVENT_CONTINUE_FALLING:
                        me->GetMotionMaster()->MovementExpired(false);
                        me->StopMoving();
                        me->GetMotionMaster()->MoveCharge(_x, _y, _groundZ, me->GetSpeed(MOVE_WALK));
                        break;
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_kinetic_bombAI>(creature);
        }
};

class spell_blood_council_shadow_prison : public SpellScriptLoader
{
    public:
        spell_blood_council_shadow_prison() : SpellScriptLoader("spell_blood_council_shadow_prison") { }

        class spell_blood_council_shadow_prison_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_blood_council_shadow_prison_AuraScript);

            void HandleDummyTick(AuraEffect const* aurEff)
            {
                if (GetTarget()->GetTypeId() == TYPEID_PLAYER && GetTarget()->isMoving())
                    GetTarget()->CastSpell(GetTarget(), SPELL_SHADOW_PRISON_DAMAGE, true, NULL, aurEff);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_blood_council_shadow_prison_AuraScript::HandleDummyTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_blood_council_shadow_prison_AuraScript();
        }
};

class spell_blood_council_shadow_prison_damage : public SpellScriptLoader
{
    public:
        spell_blood_council_shadow_prison_damage() : SpellScriptLoader("spell_blood_council_shadow_prison_damage") { }

        class spell_blood_council_shadow_prison_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_blood_council_shadow_prison_SpellScript);

            void AddExtraDamage()
            {
                if (Aura* aur = GetHitUnit()->GetAura(GetSpellInfo()->Id))
                    if (AuraEffect const* eff = aur->GetEffect(EFFECT_1))
                        SetHitDamage(GetHitDamage() + eff->GetAmount());
            }

            void Register()
            {
                OnHit += SpellHitFn(spell_blood_council_shadow_prison_SpellScript::AddExtraDamage);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_blood_council_shadow_prison_SpellScript();
        }
};

class spell_taldaram_glittering_sparks : public SpellScriptLoader
{
    public:
        spell_taldaram_glittering_sparks() : SpellScriptLoader("spell_taldaram_glittering_sparks") { }

        class spell_taldaram_glittering_sparks_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_taldaram_glittering_sparks_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                GetCaster()->CastSpell(GetCaster(), uint32(GetEffectValue()), true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_taldaram_glittering_sparks_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_taldaram_glittering_sparks_SpellScript();
        }
};

class spell_taldaram_summon_flame_ball : public SpellScriptLoader
{
    public:
        spell_taldaram_summon_flame_ball() : SpellScriptLoader("spell_taldaram_summon_flame_ball") { }

        class spell_taldaram_summon_flame_ball_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_taldaram_summon_flame_ball_SpellScript);

            bool Load()
            {
                if (GetCaster()->GetTypeId() != TYPEID_UNIT)
                    return false;
                GetCaster()->CastSpell(GetCaster(), uint32(GetSpellInfo()->Effects[0].CalcValue()), true);
                return true;
            }

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                GetCaster()->ToCreature()->AI()->DoAction(ACTION_FLAME_BALL_CHASE);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_taldaram_summon_flame_ball_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_taldaram_summon_flame_ball_SpellScript();
        }
};

class spell_taldaram_ball_of_inferno_flame : public SpellScriptLoader
{
    public:
        spell_taldaram_ball_of_inferno_flame() : SpellScriptLoader("spell_taldaram_ball_of_inferno_flame") { }

        class spell_taldaram_ball_of_inferno_flame_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_taldaram_ball_of_inferno_flame_SpellScript);

            void ModAuraStack()
            {
                if (Aura* aur = GetHitAura())
                    aur->SetStackAmount(uint8(GetSpellInfo()->StackAmount));
            }

            void Register()
            {
                AfterHit += SpellHitFn(spell_taldaram_ball_of_inferno_flame_SpellScript::ModAuraStack);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_taldaram_ball_of_inferno_flame_SpellScript();
        }
};

class spell_valanar_kinetic_bomb : public SpellScriptLoader
{
    public:
        spell_valanar_kinetic_bomb() : SpellScriptLoader("spell_valanar_kinetic_bomb") { }

        class spell_valanar_kinetic_bomb_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_valanar_kinetic_bomb_SpellScript);

            void ChangeSummonPos(SpellEffIndex /*effIndex*/)
            {
                WorldLocation summonPos = *GetExplTargetDest();
                Position offset = {0.0f, 0.0f, 20.0f, 0.0f};
                summonPos.RelocateOffset(offset);
                SetExplTargetDest(summonPos);
                GetHitDest()->RelocateOffset(offset);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_valanar_kinetic_bomb_SpellScript::ChangeSummonPos, EFFECT_0, SPELL_EFFECT_SUMMON);
            }
        };

        class spell_valanar_kinetic_bomb_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_valanar_kinetic_bomb_AuraScript);

            void HandleDummyTick(AuraEffect const* /*aurEff*/)
            {
                Unit* target = GetTarget();
                if (target->GetTypeId() != TYPEID_UNIT)
                    return;

                if (Creature* bomb = target->FindNearestCreature(NPC_KINETIC_BOMB, 1.0f, true))
                {
                    bomb->CastSpell(bomb, SPELL_KINETIC_BOMB_EXPLOSION, true);
                    bomb->RemoveAurasDueToSpell(SPELL_KINETIC_BOMB_VISUAL);
                    target->RemoveAura(GetAura());
                    bomb->AI()->DoAction(SPELL_KINETIC_BOMB_EXPLOSION);
                }
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_valanar_kinetic_bomb_AuraScript::HandleDummyTick, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_valanar_kinetic_bomb_SpellScript();
        }

        AuraScript* GetAuraScript() const
        {
            return new spell_valanar_kinetic_bomb_AuraScript();
        }
};

class spell_valanar_kinetic_bomb_absorb : public SpellScriptLoader
{
    public:
        spell_valanar_kinetic_bomb_absorb() : SpellScriptLoader("spell_valanar_kinetic_bomb_absorb") { }

        class spell_valanar_kinetic_bomb_absorb_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_valanar_kinetic_bomb_absorb_AuraScript);

            void OnAbsorb(AuraEffect* aurEff, DamageInfo& dmgInfo, uint32& absorbAmount)
            {
                absorbAmount = CalculatePct(dmgInfo.GetDamage(), aurEff->GetAmount());
                RoundToInterval<uint32>(absorbAmount, 0, dmgInfo.GetDamage());
                dmgInfo.AbsorbDamage(absorbAmount);
            }

            void Register()
            {
                OnEffectAbsorb += AuraEffectAbsorbFn(spell_valanar_kinetic_bomb_absorb_AuraScript::OnAbsorb, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_valanar_kinetic_bomb_absorb_AuraScript();
        }
};

class spell_valanar_kinetic_bomb_knockback : public SpellScriptLoader
{
    public:
        spell_valanar_kinetic_bomb_knockback() : SpellScriptLoader("spell_valanar_kinetic_bomb_knockback") { }

        class spell_valanar_kinetic_bomb_knockback_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_valanar_kinetic_bomb_knockback_SpellScript);

            void KnockIntoAir()
            {
                if (Creature* target = GetHitCreature())
                    target->AI()->DoAction(ACTION_KINETIC_BOMB_JUMP);
            }

            void Register()
            {
                BeforeHit += SpellHitFn(spell_valanar_kinetic_bomb_knockback_SpellScript::KnockIntoAir);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_valanar_kinetic_bomb_knockback_SpellScript();
        }
};

class spell_valanar_kinetic_bomb_summon : public SpellScriptLoader
{
    public:
        spell_valanar_kinetic_bomb_summon() : SpellScriptLoader("spell_valanar_kinetic_bomb_summon") { }

        class spell_valanar_kinetic_bomb_summon_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_valanar_kinetic_bomb_summon_SpellScript);

            void SelectDest()
            {
                if (Position* dest = const_cast<WorldLocation*>(GetExplTargetDest()))
                {
                    float angle = dest->GetAngle(GetCaster());
                    Position offset = {6.0f*cos(angle), 6.0f*sin(angle), 10.0f, 0.0f};
                    dest->RelocateOffset(offset);
                    GetCaster()->UpdateAllowedPositionZ(dest->GetPositionX(), dest->GetPositionY(), dest->m_positionZ);
                }
            }

            void Register()
            {
                BeforeCast += SpellCastFn(spell_valanar_kinetic_bomb_summon_SpellScript::SelectDest);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_valanar_kinetic_bomb_summon_SpellScript();
        }
};

class spell_blood_council_summon_shadow_resonance : public SpellScriptLoader
{
    public:
        spell_blood_council_summon_shadow_resonance() : SpellScriptLoader("spell_blood_council_summon_shadow_resonance") { }

        class spell_blood_council_summon_shadow_resonance_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_blood_council_summon_shadow_resonance_SpellScript);

            void SetDest(SpellDestination& dest)
            {
                Unit* summoner = GetCaster();
                float x = dest._position.GetPositionX();
                float y = dest._position.GetPositionY();
                float angle = summoner->GetAngle(x, y);
                if (dest._position.GetExactDist2d(summoner) > 35.0f && x > 4585.0f && y > 2716.0f && y < 2822.0f)
                    return;

                for (uint8 a=0; a<2; ++a)
                    for (uint8 i=6; i>0; --i)
                    {
                        float destX = summoner->GetPositionX()+cos(angle + a*M_PI)*i*10.0f;
                        float destY = summoner->GetPositionY()+sin(angle + a*M_PI)*i*10.0f;
                        if (summoner->GetMap()->isInLineOfSight(summoner->GetPositionX(), summoner->GetPositionY(), summoner->GetPositionZ()+10.0f, destX, destY, summoner->GetPositionZ()+10.0f, summoner->GetPhaseMask(), LINEOFSIGHT_ALL_CHECKS) && destX > 4585.0f && destY > 2716.0f && destY < 2822.0f)
                        {
                            float destZ = summoner->GetMap()->GetHeight(summoner->GetPhaseMask(), destX, destY, summoner->GetPositionZ()+10.0f);
                            if (fabs(destZ-summoner->GetPositionZ()) < 10.0f) // valid z found
                            {
                                dest._position.Relocate(destX, destY, destZ);
                                return;
                            }
                        }
                    }

                dest._position.Relocate(summoner->GetPositionX(), summoner->GetPositionY(), summoner->GetPositionZ());
            }

            void Register()
            {
                OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_blood_council_summon_shadow_resonance_SpellScript::SetDest, EFFECT_0, TARGET_DEST_CASTER_RANDOM);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_blood_council_summon_shadow_resonance_SpellScript();
        }
};

void AddSC_boss_blood_prince_council()
{
    new boss_prince_keleseth_icc();
    new boss_prince_taldaram_icc();
    new boss_prince_valanar_icc();
    new npc_blood_queen_lana_thel();
    new npc_dark_nucleus();
    new npc_ball_of_flame();
    new npc_kinetic_bomb();
    new spell_blood_council_shadow_prison();
    new spell_blood_council_shadow_prison_damage();
    new spell_taldaram_glittering_sparks();
    new spell_taldaram_summon_flame_ball();
    new spell_taldaram_ball_of_inferno_flame();
    new spell_valanar_kinetic_bomb();
    new spell_valanar_kinetic_bomb_absorb();
    new spell_valanar_kinetic_bomb_knockback();
    new spell_valanar_kinetic_bomb_summon();
    new spell_blood_council_summon_shadow_resonance();
}