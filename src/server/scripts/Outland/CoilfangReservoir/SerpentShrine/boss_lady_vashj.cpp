/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "serpent_shrine.h"
#include "Spell.h"
#include "Player.h"
#include "WorldSession.h"

enum Says
{
    SAY_INTRO                       = 0,
    SAY_AGGRO                       = 1,
    SAY_PHASE1                      = 2,
    SAY_PHASE2                      = 3,
    SAY_PHASE3                      = 4,
    SAY_BOWSHOT                     = 5,
    SAY_SLAY                        = 6,
    SAY_DEATH                       = 7
};

enum Spells
{
    SPELL_SHOOT                     = 37770,
    SPELL_MULTI_SHOT                = 38310,
    SPELL_SHOCK_BLAST               = 38509,
    SPELL_STATIC_CHARGE             = 38280,
    SPELL_ENTANGLE                  = 38316,
    SPELL_MAGIC_BARRIER             = 38112,
    SPELL_FORKED_LIGHTNING          = 38145,

    SPELL_SUMMON_ENCHANTED_ELEMENTAL= 38017,
    SPELL_SUMMON_COILFANG_ELITE     = 38248,
    SPELL_SUMMON_COILFANG_STRIDER   = 38241,
    SPELL_SUMMON_TAINTED_ELEMENTAL  = 38140,
    SPELL_SURGE                     = 38044,

    SPELL_REMOVE_TAINTED_CORES      = 39495,
    SPELL_SUMMON_TOXIC_SPOREBAT     = 38494,
    SPELL_SUMMON_SPOREBAT1          = 38489,
    SPELL_SUMMON_SPOREBAT2          = 38490,
    SPELL_SUMMON_SPOREBAT3          = 38492,
    SPELL_SUMMON_SPOREBAT4          = 38493,
    SPELL_TOXIC_SPORES              = 38574
};

enum Misc
{
    ITEM_TAINTED_CORE               = 31088,

    POINT_HOME                      = 1,

    EVENT_SPELL_SHOCK_BLAST         = 1,
    EVENT_SPELL_STATIC_CHARGE       = 2,
    EVENT_SPELL_ENTANGLE            = 3,
    EVENT_CHECK_HEALTH              = 4,
    EVENT_SPELL_FORKED_LIGHTNING    = 5,
    EVENT_SUMMON_A                  = 6,
    EVENT_SUMMON_B                  = 7,
    EVENT_SUMMON_C                  = 8,
    EVENT_SUMMON_D                  = 9,
    EVENT_CHECK_HEALTH2             = 10,
    EVENT_SUMMON_SPOREBAT           = 11,

    EVENT_KILL_TALK                 = 20
};

class startFollow : public BasicEvent
{
    public:
        startFollow(Unit* owner) : _owner(owner)  { }

        bool Execute(uint64 /*execTime*/, uint32 /*diff*/)
        {
            if (InstanceScript* instance = _owner->GetInstanceScript())
                if (Creature* vashj = ObjectAccessor::GetCreature(*_owner, instance->GetData64(NPC_LADY_VASHJ)))
                    _owner->GetMotionMaster()->MoveFollow(vashj, 3.0f, vashj->GetAngle(_owner), MOTION_SLOT_CONTROLLED);
            return true;
        }

    private:
        Unit* _owner;
};

class boss_lady_vashj : public CreatureScript
{
    public:
        boss_lady_vashj() : CreatureScript("boss_lady_vashj") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_lady_vashjAI>(creature);
        }

        struct boss_lady_vashjAI : public BossAI
        {
            boss_lady_vashjAI(Creature* creature) : BossAI(creature, DATA_LADY_VASHJ)
            {
                intro = false;
            }

            bool intro;
            int32 count;

            void Reset()
            {
                count = 0;
                BossAI::Reset();
            }

            void KilledUnit(Unit* /*victim*/)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_SLAY);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void JustDied(Unit* killer)
            {
                Talk(SAY_DEATH);
                BossAI::JustDied(killer);
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
                Talk(SAY_AGGRO);

                me->CastSpell(me, SPELL_REMOVE_TAINTED_CORES, true);
                events.ScheduleEvent(EVENT_SPELL_SHOCK_BLAST, 10000);
                events.ScheduleEvent(EVENT_SPELL_STATIC_CHARGE, 15000);
                events.ScheduleEvent(EVENT_SPELL_ENTANGLE, 20000);
                events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                if (summon->GetEntry() == WORLD_TRIGGER)
                    summon->CastSpell(summon, SPELL_MAGIC_BARRIER, false);
                else if (summon->GetEntry() == NPC_ENCHANTED_ELEMENTAL)
                {
                    summon->SetWalk(true);
                    summon->m_Events.AddEvent(new startFollow(summon), summon->m_Events.CalculateTime(0));
                }
                else if (summon->GetEntry() == NPC_TOXIC_SPOREBAT)
                    summon->GetMotionMaster()->MoveRandom(30.0f);
                else if (summon->GetEntry() != NPC_TAINTED_ELEMENTAL)
                    summon->GetMotionMaster()->MovePoint(POINT_HOME, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), true, true);
            }

            void MoveInLineOfSight(Unit* who)
            {
                if (!intro && who->GetTypeId() == TYPEID_PLAYER)
                {
                    intro = true;
                    Talk(SAY_INTRO);
                }

                BossAI::MoveInLineOfSight(who);
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type != POINT_MOTION_TYPE || id != POINT_HOME)
                    return;

                me->SetFacingTo(me->GetHomePosition().GetOrientation());
                instance->SetData(DATA_ACTIVATE_SHIELD, 0);
                events.Reset();
                events.ScheduleEvent(EVENT_SPELL_FORKED_LIGHTNING, 3000);
                events.ScheduleEvent(EVENT_SUMMON_A, 0);
                events.ScheduleEvent(EVENT_SUMMON_B, 45000);
                events.ScheduleEvent(EVENT_SUMMON_C, 60000);
                events.ScheduleEvent(EVENT_SUMMON_D, 50000);
                events.ScheduleEvent(EVENT_CHECK_HEALTH2, 1000);
            }

            void UpdateAI(uint32 diff)
            {
                EnterEvadeIfOutOfCombatArea();
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_SPELL_SHOCK_BLAST:
                        me->CastSpell(me->GetVictim(), SPELL_SHOCK_BLAST, false);
                        events.ScheduleEvent(EVENT_SPELL_SHOCK_BLAST, urand(10000, 20000));
                        break;
                    case EVENT_SPELL_STATIC_CHARGE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 40.0f))
                            me->CastSpell(target, SPELL_STATIC_CHARGE, false);
                        events.ScheduleEvent(EVENT_SPELL_STATIC_CHARGE, 20000);
                        break;
                    case EVENT_SPELL_ENTANGLE:
                        me->CastSpell(me, SPELL_ENTANGLE, false);
                        events.ScheduleEvent(EVENT_SPELL_ENTANGLE, 30000);
                        break;
                    case EVENT_CHECK_HEALTH:
                        if (me->HealthBelowPct(71))
                        {
                            Talk(SAY_PHASE2);
                            me->SetReactState(REACT_PASSIVE);
                            me->GetMotionMaster()->MovePoint(POINT_HOME, me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY(), me->GetHomePosition().GetPositionZ(), true, true);
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
                        break;
                    case EVENT_SPELL_FORKED_LIGHTNING:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 60.0f))
                            me->CastSpell(target, SPELL_FORKED_LIGHTNING, false);
                        events.ScheduleEvent(EVENT_SPELL_FORKED_LIGHTNING, urand(2500, 5000));
                        break;
                    case EVENT_SUMMON_A:
                        me->CastSpell(me, SPELL_SUMMON_ENCHANTED_ELEMENTAL, true);
                        events.ScheduleEvent(EVENT_SUMMON_A, 2500);
                        break;
                    case EVENT_SUMMON_B:
                        me->CastSpell(me, SPELL_SUMMON_COILFANG_ELITE, true);
                        events.ScheduleEvent(EVENT_SUMMON_B, 45000);
                        break;
                    case EVENT_SUMMON_C:
                        me->CastSpell(me, SPELL_SUMMON_COILFANG_STRIDER, true);
                        events.ScheduleEvent(EVENT_SUMMON_C, 60000);
                        break;
                    case EVENT_SUMMON_D:
                        me->CastSpell(me, SPELL_SUMMON_TAINTED_ELEMENTAL, true);
                        events.ScheduleEvent(EVENT_SUMMON_D, 50000);
                        break;
                    case EVENT_CHECK_HEALTH2:
                        if (!me->HasAura(SPELL_MAGIC_BARRIER))
                        {
                            Talk(SAY_PHASE3);
                            me->SetReactState(REACT_AGGRESSIVE);
                            me->GetMotionMaster()->MoveChase(me->GetVictim());
                            events.Reset();
                            events.ScheduleEvent(EVENT_SPELL_SHOCK_BLAST, 10000);
                            events.ScheduleEvent(EVENT_SPELL_STATIC_CHARGE, 15000);
                            events.ScheduleEvent(EVENT_SPELL_ENTANGLE, 20000);
                            events.ScheduleEvent(EVENT_SUMMON_SPOREBAT, 5000);
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH2, 1000);
                        break;
                    case EVENT_SUMMON_SPOREBAT:
                        me->CastSpell(me, SPELL_SUMMON_TOXIC_SPOREBAT, true);
                        events.ScheduleEvent(EVENT_SUMMON_SPOREBAT, 20000 - 1000*std::min(count++, 16));
                        break;
                }

                if (me->GetReactState() != REACT_AGGRESSIVE || !me->isAttackReady())
                    return;

                if (!me->IsWithinMeleeRange(me->GetVictim()))
                {
                    me->resetAttackTimer();
                    me->SetSheath(SHEATH_STATE_RANGED);
                    me->CastSpell(me->GetVictim(), roll_chance_i(33) ? SPELL_MULTI_SHOT : SPELL_SHOOT, false);
                    if (roll_chance_i(15))
                        Talk(SAY_BOWSHOT);
                }
                else
                {
                    me->SetSheath(SHEATH_STATE_MELEE);
                    DoMeleeAttackIfReady();
                }
            }
                    
            bool CheckEvadeIfOutOfCombatArea() const
            {
                return me->GetHomePosition().GetExactDist2d(me) > 80.0f || !SelectTargetFromPlayerList(100.0f);
            }
        };
};
/*

//Toxic Sporebat
//Toxic Spores: Used in Phase 3 by the Spore Bats, it creates a contaminated green patch of ground, dealing about 2775-3225 nature damage every second to anyone who stands in it.
class npc_toxic_sporebat : public CreatureScript
{
public:
    npc_toxic_sporebat() : CreatureScript("npc_toxic_sporebat") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<npc_toxic_sporebatAI>(creature);
    }

    struct npc_toxic_sporebatAI : public ScriptedAI
    {
        npc_toxic_sporebatAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
            EnterEvadeMode();
        }

        InstanceScript* instance;

        uint32 MovementTimer;
        uint32 ToxicSporeTimer;
        uint32 BoltTimer;
        uint32 CheckTimer;

        void Reset()
        {
            me->SetDisableGravity(true);
            me->setFaction(14);
            MovementTimer = 0;
            ToxicSporeTimer = 5000;
            BoltTimer = 5500;
            CheckTimer = 1000;
        }

        void MoveInLineOfSight(Unit* who)

        {
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id == 1)
                MovementTimer = 0;
        }

        void UpdateAI(uint32 diff)
        {
            // Random movement
            if (MovementTimer <= diff)
            {
                uint32 rndpos = rand()%8;
                me->GetMotionMaster()->MovePoint(1, SporebatWPPos[rndpos][0], SporebatWPPos[rndpos][1], SporebatWPPos[rndpos][2]);
                MovementTimer = 6000;
            } else MovementTimer -= diff;

            // toxic spores
            if (BoltTimer <= diff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                {
                    if (Creature* trig = me->SummonCreature(TOXIC_SPORES_TRIGGER, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 30000))
                    {
                        trig->setFaction(14);
                        trig->CastSpell(trig, SPELL_TOXIC_SPORES, true);
                    }
                }
                BoltTimer = 10000+rand()%5000;
            }
            else BoltTimer -= diff;

            // CheckTimer
            if (CheckTimer <= diff)
            {
                // check if vashj is death
                Unit* Vashj = ObjectAccessor::GetUnit(*me, instance->GetData64(DATA_LADYVASHJ));
                if (!Vashj || !Vashj->IsAlive() || CAST_AI(boss_lady_vashj::boss_lady_vashjAI, Vashj->ToCreature()->AI())->Phase != 3)
                {
                    // remove
                    me->setDeathState(DEAD);
                    me->RemoveCorpse();
                    me->setFaction(35);
                }

                CheckTimer = 1000;
            }
            else
                CheckTimer -= diff;
        }
    };

};
*/

class spell_lady_vashj_magic_barrier : public SpellScriptLoader
{
    public:
        spell_lady_vashj_magic_barrier() : SpellScriptLoader("spell_lady_vashj_magic_barrier") { }

        class spell_lady_vashj_magic_barrier_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_lady_vashj_magic_barrier_AuraScript)

            void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit::DealDamage(GetTarget(), GetTarget(), GetTarget()->CountPctFromMaxHealth(5));
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_lady_vashj_magic_barrier_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_SCHOOL_IMMUNITY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_lady_vashj_magic_barrier_AuraScript();
        }
};

class spell_lady_vashj_remove_tainted_cores : public SpellScriptLoader
{
    public:
        spell_lady_vashj_remove_tainted_cores() : SpellScriptLoader("spell_lady_vashj_remove_tainted_cores") { }

        class spell_lady_vashj_remove_tainted_cores_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_lady_vashj_remove_tainted_cores_SpellScript);

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Player* target = GetHitPlayer())
                    target->DestroyItemCount(ITEM_TAINTED_CORE, -1, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_lady_vashj_remove_tainted_cores_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_lady_vashj_remove_tainted_cores_SpellScript();
        }
};

class spell_lady_vashj_summon_sporebat : public SpellScriptLoader
{
    public:
        spell_lady_vashj_summon_sporebat() : SpellScriptLoader("spell_lady_vashj_summon_sporebat") { }

        class spell_lady_vashj_summon_sporebat_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_lady_vashj_summon_sporebat_SpellScript);

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                GetCaster()->CastSpell(GetCaster(), RAND(SPELL_SUMMON_SPOREBAT1, SPELL_SUMMON_SPOREBAT2, SPELL_SUMMON_SPOREBAT3, SPELL_SUMMON_SPOREBAT4), true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_lady_vashj_summon_sporebat_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_lady_vashj_summon_sporebat_SpellScript();
        }
};

class spell_lady_vashj_spore_drop_effect : public SpellScriptLoader
{
    public:
        spell_lady_vashj_spore_drop_effect() : SpellScriptLoader("spell_lady_vashj_spore_drop_effect") { }

        class spell_lady_vashj_spore_drop_effect_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_lady_vashj_spore_drop_effect_SpellScript);

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                    target->CastSpell(target, SPELL_TOXIC_SPORES, true, nullptr, nullptr, GetCaster()->GetGUID());
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_lady_vashj_spore_drop_effect_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_lady_vashj_spore_drop_effect_SpellScript();
        }
};

void AddSC_boss_lady_vashj()
{
    new boss_lady_vashj();
    new spell_lady_vashj_magic_barrier();
    new spell_lady_vashj_remove_tainted_cores();
    new spell_lady_vashj_summon_sporebat();
    new spell_lady_vashj_spore_drop_effect();
}
