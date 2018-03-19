/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "gundrak.h"

enum Spells
{
    SPELL_MOJO_PUDDLE                   = 55627,
    SPELL_MOJO_WAVE                     = 55626,
    SPELL_FREEZE_ANIM                   = 52656,
    SPELL_MIGHTY_BLOW                   = 54719,

    SPELL_ELEMENTAL_SPAWN_EFFECT        = 54888,
    SPELL_EMERGE                        = 54850,
    SPELL_EMERGE_SUMMON                 = 54851,
    SPELL_MOJO_VOLLEY                   = 54849,

    SPELL_SURGE_VISUAL                  = 54827,
    SPELL_SURGE                         = 54801,
    SPELL_SURGE_DAMAGE                  = 54819,

    SPELL_FACE_ME                       = 54991,
    SPELL_MERGE                         = 54878,
};

enum Misc
{
    NPC_LIVING_MOJO                     = 29830,
    NPC_DRAKKARI_ELEMENTAL              = 29573,

    ACTION_MERGE                        = 1,
    ACTION_INFORM                       = 2,

    POINT_MERGE                         = 1,
    SAY_SURGE                           = 0,
    EMOTE_ALTAR                         = 1,

    EVENT_COLOSSUS_MIGHTY_BLOW          = 1,
    EVENT_COLOSSUS_HEALTH_1             = 2,
    EVENT_COLOSSUS_HEALTH_2             = 3,
    EVENT_COLOSSUS_START_FIGHT          = 4,

    EVENT_ELEMENTAL_HEALTH              = 10,
    EVENT_ELEMENTAL_SURGE               = 11,
    EVENT_ELEMENTAL_VOLLEY              = 12,

    EVENT_MOJO_MOJO_WAVE                = 20,
    EVENT_MOJO_MOJO_PUDDLE              = 21,
};

static Position mojoPosition[] =
{
    {1663.1f, 743.6f, 143.1f, 0.0f},
    {1669.97f, 753.7f, 143.1f, 0.0f},
    {1680.7f, 750.7f, 143.1f, 0.0f},
    {1680.7f, 737.1f, 143.1f, 0.0f},
    {1670.4f, 733.5f, 143.1f, 0.0f}
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

class boss_drakkari_colossus : public CreatureScript
{
    public:
        boss_drakkari_colossus() : CreatureScript("boss_drakkari_colossus") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_drakkari_colossusAI (creature);
        }
        struct boss_drakkari_colossusAI : public BossAI
        {
            boss_drakkari_colossusAI(Creature* creature) : BossAI(creature, DATA_DRAKKARI_COLOSSUS)
            {
            }

            void MoveInLineOfSight(Unit*  /*who*/)
            {
            }

            void DoAction(int32 param)
            {
                if (param == ACTION_INFORM)
                {
                    me->SetInCombatWithZone();
                    summons.DoAction(ACTION_MERGE);
                    events.ScheduleEvent(EVENT_COLOSSUS_START_FIGHT, 3500);
                }
            }

            void Reset()
            {
                BossAI::Reset();
                for (uint8 i = 0; i < 5; i++)
                    me->SummonCreature(NPC_LIVING_MOJO, mojoPosition[i].GetPositionX(), mojoPosition[i].GetPositionY(), mojoPosition[i].GetPositionZ(), 0, TEMPSUMMON_MANUAL_DESPAWN, 0);

                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            }

            void InitializeAI()
            {
                BossAI::InitializeAI();
                me->CastSpell(me, SPELL_FREEZE_ANIM, true);
            }

            void JustReachedHome()
            {
                BossAI::JustReachedHome();
                me->CastSpell(me, SPELL_FREEZE_ANIM, true);
            }
            
            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
                events.ScheduleEvent(EVENT_COLOSSUS_MIGHTY_BLOW, 10000);
                events.ScheduleEvent(EVENT_COLOSSUS_HEALTH_1, 1000);
                events.ScheduleEvent(EVENT_COLOSSUS_HEALTH_2, 1000);
            }

            void JustSummoned(Creature* summon) 
            {
                if (summon->GetEntry() == NPC_DRAKKARI_ELEMENTAL)
                {
                    summon->SetRegeneratingHealth(false);
                    summon->SetReactState(REACT_PASSIVE);
                    summon->m_Events.AddEvent(new RestoreFight(summon), summon->m_Events.CalculateTime(3000));
                    if (events.GetNextEventTime(EVENT_COLOSSUS_HEALTH_2) == 0)
                    {
                        summon->SetHealth(summon->GetMaxHealth()/2);
                        summon->LowerPlayerDamageReq(summon->GetMaxHealth()/2);
                        summon->AI()->DoAction(ACTION_INFORM);
                    }
                }

                summons.Summon(summon);
            }

            void SummonedCreatureDies(Creature* summon, Unit*)
            {
                summons.Despawn(summon);
                if (summon->GetEntry() == NPC_DRAKKARI_ELEMENTAL)
                    Unit::Kill(me, me);
            }

            void SummonedCreatureDespawn(Creature* summon)
            {
                summons.Despawn(summon);
                if (summon->GetEntry() == NPC_DRAKKARI_ELEMENTAL)
                {
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    me->RemoveAurasDueToSpell(SPELL_FREEZE_ANIM);
                    if (me->GetVictim())
                        me->GetMotionMaster()->MoveChase(me->GetVictim());
                }
            }

            void DamageTaken(Unit*  /*attacker*/, uint32& damage, DamageEffectType, SpellSchoolMask)
            {
                if (damage >= me->GetHealth())
                    damage = 0;
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                    return;

                events.Update(diff);
                switch (events.ExecuteEvent())
                {
                    case EVENT_COLOSSUS_START_FIGHT:
                        me->RemoveAurasDueToSpell(SPELL_FREEZE_ANIM);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        break;
                    case EVENT_COLOSSUS_MIGHTY_BLOW:
                        me->CastSpell(me->GetVictim(), SPELL_MIGHTY_BLOW, false);
                        events.ScheduleEvent(EVENT_COLOSSUS_MIGHTY_BLOW, 10000);
                        break;
                    case EVENT_COLOSSUS_HEALTH_1:
                        if (me->HealthBelowPct(51))
                        {
                            me->CastSpell(me, SPELL_EMERGE, false);
                            me->CastSpell(me, SPELL_EMERGE_SUMMON, true);
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                            me->GetMotionMaster()->Clear();
                            break;
                        }
                        events.ScheduleEvent(EVENT_COLOSSUS_HEALTH_1, 1000);
                        break;
                    case EVENT_COLOSSUS_HEALTH_2:
                        if (me->HealthBelowPct(21))
                        {
                            me->CastSpell(me, SPELL_EMERGE, false);
                            me->CastSpell(me, SPELL_EMERGE_SUMMON, true);
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                            me->GetMotionMaster()->Clear();
                            break;
                        }
                        events.ScheduleEvent(EVENT_COLOSSUS_HEALTH_2, 1000);
                        break;
                }

                DoMeleeAttackIfReady(); 
            }
        };
};

class boss_drakkari_elemental : public CreatureScript
{
    public:
        boss_drakkari_elemental() : CreatureScript("boss_drakkari_elemental") { }

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new boss_drakkari_elementalAI (pCreature);
        }

        struct boss_drakkari_elementalAI : public ScriptedAI
        {
            boss_drakkari_elementalAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
                events.ScheduleEvent(EVENT_ELEMENTAL_HEALTH, 1000);
                events.ScheduleEvent(EVENT_ELEMENTAL_SURGE, 7000);
                events.ScheduleEvent(EVENT_ELEMENTAL_VOLLEY, 0);
            }

            EventMap events;

            void DoAction(int32 param)
            {
                if (param == ACTION_INFORM)
                    events.CancelEvent(EVENT_ELEMENTAL_HEALTH);
            }

            void Reset()
            {
                me->CastSpell(me, SPELL_ELEMENTAL_SPAWN_EFFECT, false);
            }

            void JustDied(Unit*)
            {
                Talk(EMOTE_ALTAR);
            }

            void EnterCombat(Unit*)
            {
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING) || me->HasUnitState(UNIT_STATE_CHARGING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_ELEMENTAL_HEALTH:
                        if (me->HealthBelowPct(51))
                        {
                            me->CastSpell(me, SPELL_FACE_ME, true);
                            me->CastSpell(me, SPELL_SURGE_VISUAL, true);
                            me->CastSpell(me, SPELL_MERGE, false);
                            me->DespawnOrUnsummon(2000);
                            events.Reset();
                            break;
                        }
                        events.ScheduleEvent(EVENT_ELEMENTAL_HEALTH, 1000);
                        break;
                    case EVENT_ELEMENTAL_SURGE:
                        Talk(SAY_SURGE);
                        me->CastSpell(me, SPELL_SURGE_VISUAL, true);
                        me->CastSpell(me->GetVictim(), SPELL_SURGE, false);
                        events.ScheduleEvent(EVENT_ELEMENTAL_SURGE, 15000);
                        break;
                    case EVENT_ELEMENTAL_VOLLEY:
                        me->CastSpell(me, SPELL_MOJO_VOLLEY, true);
                        break;
                }


                DoMeleeAttackIfReady();
            }
        };
};

class npc_living_mojo : public CreatureScript
{
    public:
        npc_living_mojo() : CreatureScript("npc_living_mojo") { }

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new npc_living_mojoAI (pCreature);
        }

        struct npc_living_mojoAI : public ScriptedAI
        {
            npc_living_mojoAI(Creature* pCreature) : ScriptedAI(pCreature)
            {
            }

            EventMap events;

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_MOJO_MOJO_PUDDLE, 13000);
                events.ScheduleEvent(EVENT_MOJO_MOJO_WAVE, 15000);
            }

            void MoveInLineOfSight(Unit* who)
            {
                if (me->ToTempSummon())
                    return;

                ScriptedAI::MoveInLineOfSight(who);
            }

            void AttackStart(Unit* who)
            {
                if (me->ToTempSummon())
                {
                    if (who->GetTypeId() == TYPEID_PLAYER || IS_PLAYER_GUID(who->GetOwnerGUID()))
                        if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                            summoner->GetAI()->DoAction(ACTION_INFORM);
                    return;
                }

                ScriptedAI::AttackStart(who);
            }

            void DoAction(int32 param)
            {
                if (param == ACTION_MERGE)
                {
                    me->SetReactState(REACT_PASSIVE);
                    me->GetMotionMaster()->MoveCharge(1672.96f, 743.488f, 143.338f, 7.0f, POINT_MERGE);
                    me->DespawnOrUnsummon(1200);
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (me->ToTempSummon() || !UpdateVictim())
                    return;
                
                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_MOJO_MOJO_PUDDLE:
                    {
                        me->CastSpell(me, SPELL_MOJO_PUDDLE, false);
                        events.ScheduleEvent(EVENT_MOJO_MOJO_PUDDLE, 13000);
                        break;
                    }
                    case EVENT_MOJO_MOJO_WAVE:
                    {
                        me->CastSpell(me->GetVictim(), SPELL_MOJO_WAVE, false);
                        events.ScheduleEvent(EVENT_MOJO_MOJO_WAVE, 15000);
                        break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };
};

class spell_drakkari_colossus_emerge : public SpellScriptLoader
{
    public:
        spell_drakkari_colossus_emerge() : SpellScriptLoader("spell_drakkari_colossus_emerge") { }

        class spell_drakkari_colossus_emerge_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_drakkari_colossus_emerge_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                GetCaster()->CastSpell(GetCaster(), SPELL_FREEZE_ANIM, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_drakkari_colossus_emerge_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_drakkari_colossus_emerge_SpellScript();
        }
};

class spell_drakkari_colossus_surge : public SpellScriptLoader
{
    public:
        spell_drakkari_colossus_surge() : SpellScriptLoader("spell_drakkari_colossus_surge") { }

        class spell_drakkari_colossus_surge_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_drakkari_colossus_surge_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                    GetCaster()->CastSpell(target, SPELL_SURGE_DAMAGE, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_drakkari_colossus_surge_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_drakkari_colossus_surge_SpellScript();
        }
};

class spell_drakkari_colossus_face_me : public SpellScriptLoader
{
    public:
        spell_drakkari_colossus_face_me() : SpellScriptLoader("spell_drakkari_colossus_face_me") { }

        class spell_drakkari_colossus_face_me_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_drakkari_colossus_face_me_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                {
                    GetCaster()->SetInFront(target);
                    GetCaster()->SetFacingTo(GetCaster()->GetAngle(target));
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_drakkari_colossus_face_me_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_drakkari_colossus_face_me_SpellScript();
        }
};

void AddSC_boss_drakkari_colossus()
{
    new boss_drakkari_colossus();
    new boss_drakkari_elemental();
    new npc_living_mojo();
    new spell_drakkari_colossus_emerge();
    new spell_drakkari_colossus_surge();
    new spell_drakkari_colossus_face_me();
}
