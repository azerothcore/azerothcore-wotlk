/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Cell.h"
#include "CellImpl.h"
#include "sunwell_plateau.h"

enum Yells
{
    YELL_BIRTH                                  = 0, // Glory to Kil'jaeden! Death to all who oppose!
    YELL_KILL                                   = 1, // I kill for the master! OR The end has come!
    YELL_BREATH                                 = 2, // Choke on your final breath
    YELL_TAKEOFF                                = 3, // I am stronger than ever before!
    YELL_BERSERK                                = 4, // No more hesitation! Your fates are written!
    YELL_DEATH                                  = 5, // Kil'jaeden will... prevail!  AND Kalecgos line
    EMOTE_BREATH                                = 6  // Felmyst takes a deep breath...
};

enum Spells
{
    //Aura
    SPELL_NOXIOUS_FUMES                         = 47002,

    //Land phase
    SPELL_BERSERK                               = 45078,
    SPELL_CLEAVE                                = 19983,
    SPELL_CORROSION                             = 45866,
    SPELL_GAS_NOVA                              = 45855,
    SPELL_ENCAPSULATE_CHANNEL                   = 45661,

    //Flight phase
    SPELL_SUMMON_DEMONIC_VAPOR                  = 45391,
    SPELL_DEMONIC_VAPOR_SPAWN_TRIGGER           = 45388, // Triggers visual beam
    SPELL_DEMONIC_VAPOR_PERIODIC                = 45411, // Spawns cloud and deals damage
    SPELL_DEMONIC_VAPOR_TRAIL_PERIODIC          = 45399, // periodic of cloud
    SPELL_DEMONIC_VAPOR                         = 45402, // cloud dot
    SPELL_SUMMON_BLAZING_DEAD                   = 45400, // spawns skeletons
    SPELL_FELMYST_SPEED_BURST                   = 45495, // speed burst and breath animation
    SPELL_FOG_OF_CORRUPTION                     = 45582, // trigger cast
    SPELL_FOG_OF_CORRUPTION_CHARM               = 45717, // charm 1
    SPELL_FOG_OF_CORRUPTION_CHARM2              = 45726, // charm 2
};

enum Misc
{
    // Land
    EVENT_SPELL_BERSERK         = 1,
    EVENT_SPELL_CLEAVE          = 2,
    EVENT_SPELL_CORROSION       = 3,
    EVENT_SPELL_GAS_NOVA        = 4,
    EVENT_SPELL_ENCAPSULATE     = 5,
    EVENT_FLIGHT                = 6,
    EVENT_LAND                  = 7,
    EVENT_RESTORE_COMBAT        = 8,
    EVENT_RESTORE_COMBAT2       = 9,

    // Air
    EVENT_FLIGHT_SEQ            = 100,
    EVENT_FLIGHT_VAPOR          = 101,
    EVENT_FLIGHT_MOVE_UP        = 102,
    EVENT_LAND_FIGHT            = 103,
    EVENT_FLIGHT_EMOTE          = 104,
    EVENT_FLIGHT_BREATH1        = 105,
    EVENT_FLIGHT_BREATH2        = 106,
    EVENT_FLIGHT_FLYOVER1       = 107,
    EVENT_FLIGHT_FLYOVER2       = 108,
    EVENT_CORRUPT_TRIGGERS      = 109,

    // Intro
    EVENT_INTRO_1               = 20,
    EVENT_INTRO_2               = 21,
    EVENT_INTRO_3               = 22,
    EVENT_INTRO_4               = 23,

    // Misc
    ACTION_START_EVENT          = 1,
    POINT_GROUND                = 1,
    POINT_AIR                   = 2,
    POINT_AIR_BREATH_START1     = 3,
    POINT_AIR_BREATH_END1       = 4,
    POINT_AIR_BREATH_START2     = 5,
    POINT_AIR_BREATH_END2       = 6,
    POINT_MISC                  = 7,

    NPC_FOG_TRIGGER             = 23472
};

class CorruptTriggers : public BasicEvent
{
    public:
        CorruptTriggers(Unit* caster) : _caster(caster)
        {
        }

        bool Execute(uint64 /*execTime*/, uint32 /*diff*/)
        {
            std::list<Creature*> cList;
            _caster->GetCreaturesWithEntryInRange(cList, 70.0f, NPC_FOG_TRIGGER);
            for (std::list<Creature*>::const_iterator itr = cList.begin(); itr != cList.end(); ++itr)
                if (_caster->GetExactDist2d(*itr) <= 11.0f)
                    (*itr)->CastSpell(*itr, SPELL_FOG_OF_CORRUPTION, true);
            return true;
        }

    private:
        Unit* _caster;
};

class boss_felmyst : public CreatureScript
{
public:
    boss_felmyst() : CreatureScript("boss_felmyst") { }

    struct boss_felmystAI : public BossAI
    {
        boss_felmystAI(Creature* creature) : BossAI(creature, DATA_FELMYST)
        {
            bool appear = instance->GetBossState(DATA_BRUTALLUS) == DONE;
            creature->SetVisible(appear);
            creature->SetStandState(UNIT_STAND_STATE_SLEEP);
            creature->SetReactState(REACT_PASSIVE);
        }

        EventMap events2;

        void DoAction(int32 param)
        {
            if (param == ACTION_START_EVENT)
            {
                me->SetVisible(true);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                events2.ScheduleEvent(EVENT_INTRO_1, 3000);
            }
        }

        void Reset()
        {
            BossAI::Reset();
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetReactState(REACT_PASSIVE);
            me->SetDisableGravity(false);
            events2.Reset();
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_FOG_OF_CORRUPTION_CHARM);
        }

        void EnterCombat(Unit* who)
        {
            BossAI::EnterCombat(who);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            if (events.Empty() && events2.Empty())
                events2.ScheduleEvent(EVENT_INTRO_2, 3000);
        }


        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER && roll_chance_i(50))
                Talk(YELL_KILL);
        }

        void JustDied(Unit* killer)
        {
            BossAI::JustDied(killer);
            Talk(YELL_DEATH);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_FOG_OF_CORRUPTION_CHARM);

            // Summon Kalecgos (human form of kalecgos fight)
            me->SummonCreature(NPC_KALEC, 1526.28f, 700.10f, 60.0f, 4.33f);
        }

        void MovementInform(uint32 type, uint32 point)
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (point == POINT_GROUND)
            {
                me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                me->SetDisableGravity(false);
                me->SendMovementFlagUpdate();

                events.ScheduleEvent(EVENT_RESTORE_COMBAT, 0);
                events.ScheduleEvent(EVENT_RESTORE_COMBAT2, 1);
                events.ScheduleEvent(EVENT_SPELL_CLEAVE, 7500, 1);
                events.ScheduleEvent(EVENT_SPELL_CORROSION, 12000, 1);
                events.ScheduleEvent(EVENT_SPELL_GAS_NOVA, 18000, 1);
                events.ScheduleEvent(EVENT_SPELL_ENCAPSULATE, 25000, 1);
                events.ScheduleEvent(EVENT_FLIGHT, 60000, 1);
            }
            else if (point == POINT_AIR_BREATH_START1)
            {
                me->SetTarget(0);
                me->SetFacingTo(4.71f);
                events.ScheduleEvent(EVENT_FLIGHT_EMOTE, 2000);
                events.ScheduleEvent(EVENT_CORRUPT_TRIGGERS, 5000);
                events.ScheduleEvent(EVENT_FLIGHT_FLYOVER1, 5000);
            }
            else if (point == POINT_AIR_BREATH_END1)
            {
                me->RemoveAurasDueToSpell(SPELL_FELMYST_SPEED_BURST);
                me->SetFacingTo(1.57f);
                if (events.GetNextEventTime(EVENT_FLIGHT_BREATH1) != 0)
                    events.ScheduleEvent(EVENT_FLIGHT_BREATH2, 2000);
            }
            else if (point == POINT_AIR_BREATH_START2)
            {
                me->SetTarget(0);
                me->SetFacingTo(1.57f);
                events.ScheduleEvent(EVENT_FLIGHT_EMOTE, 2000);
                events.ScheduleEvent(EVENT_CORRUPT_TRIGGERS, 5000);
                events.ScheduleEvent(EVENT_FLIGHT_FLYOVER2, 5000);
            }
            else if (point == POINT_AIR_BREATH_END2)
            {
                me->RemoveAurasDueToSpell(SPELL_FELMYST_SPEED_BURST);
                me->SetFacingTo(4.71f);
            }
        }

        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);
        }

        void UpdateAI(uint32 diff)
        {
            events2.Update(diff);
            switch (events2.ExecuteEvent())
            {
                case EVENT_INTRO_1:
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    events2.ScheduleEvent(EVENT_INTRO_2, 4000);
                    break;
                case EVENT_INTRO_2:
                    Talk(YELL_BIRTH);
                    me->SetDisableGravity(true);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
                    me->SendMovementFlagUpdate();
                    events2.ScheduleEvent(EVENT_INTRO_3, 1500);
                    break;
                case EVENT_INTRO_3:
                    me->GetMotionMaster()->MovePoint(POINT_AIR, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+10.0f, false, true);
                    events2.ScheduleEvent(EVENT_INTRO_4, 2000);
                    break;
                case EVENT_INTRO_4:
                    events.ScheduleEvent(EVENT_LAND, 3000, 1);
                    events.ScheduleEvent(EVENT_SPELL_BERSERK, 600000);
                    me->SetInCombatWithZone();
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->CastSpell(me, SPELL_NOXIOUS_FUMES, true);
                    me->GetMotionMaster()->MovePoint(POINT_MISC, 1472.18f, 603.38f, 34.0f, false, true);
                    break;
            }

            if (!events2.Empty())
                return;

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.ExecuteEvent())
            {
                case EVENT_RESTORE_COMBAT:
                    me->SetReactState(REACT_AGGRESSIVE);
                    break;
                case EVENT_RESTORE_COMBAT2:
                    me->SetTarget(me->GetVictim()->GetGUID());
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                    break;
                case EVENT_LAND:
                    me->GetMotionMaster()->MovePoint(POINT_GROUND, me->GetPositionX(), me->GetPositionY(), me->GetMap()->GetHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()), false, true);
                    break;
                case EVENT_SPELL_BERSERK:
                    Talk(YELL_BERSERK);
                    me->CastSpell(me, SPELL_BERSERK, true);
                    break;
                case EVENT_SPELL_CLEAVE:
                    me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                    events.ScheduleEvent(EVENT_SPELL_CLEAVE, 7500, 1);
                    break;
                case EVENT_SPELL_CORROSION:
                    me->CastSpell(me->GetVictim(), SPELL_CORROSION, false);
                    events.ScheduleEvent(EVENT_SPELL_CORROSION, 20000, 1);
                    break;
                case EVENT_SPELL_GAS_NOVA:
                    DoCast(me, SPELL_GAS_NOVA, false);
                    events.ScheduleEvent(EVENT_SPELL_GAS_NOVA, 20000, 1);
                    break;
                case EVENT_SPELL_ENCAPSULATE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true))
                        me->CastSpell(target, SPELL_ENCAPSULATE_CHANNEL, false);
                    events.ScheduleEvent(EVENT_SPELL_ENCAPSULATE, 25000, 1);
                    break;
                case EVENT_FLIGHT:
                    events.CancelEventGroup(1);
                    events.ScheduleEvent(EVENT_FLIGHT_SEQ, 1000);
                    me->SetReactState(REACT_PASSIVE);
                    me->StopMoving();
                    me->GetMotionMaster()->Clear();
                    break;
                case EVENT_FLIGHT_SEQ:
                    Talk(YELL_TAKEOFF);
                    me->SetTarget(0);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
                    me->SetDisableGravity(true);
                    me->SendMovementFlagUpdate();

                    events.ScheduleEvent(EVENT_FLIGHT_MOVE_UP, 2000);
                    events.ScheduleEvent(EVENT_FLIGHT_VAPOR, 8000);
                    events.ScheduleEvent(EVENT_FLIGHT_VAPOR, 21000);
                    events.ScheduleEvent(EVENT_FLIGHT_BREATH1, 35000);
                    events.ScheduleEvent(EVENT_FLIGHT_BREATH1, 72000);
                    events.ScheduleEvent(EVENT_LAND_FIGHT, 86000);
                    break;
                case EVENT_FLIGHT_MOVE_UP:
                    me->GetMotionMaster()->MovePoint(POINT_AIR, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+15.0f, false, true);
                    break;
                case EVENT_FLIGHT_VAPOR:
                    me->CastSpell(me, SPELL_SUMMON_DEMONIC_VAPOR, true);
                    break;
                case EVENT_FLIGHT_BREATH1:
                {
                    Position pos = {1447.0f + urand(0, 2)*25.0f, 705.0f, 50.0f, 4.71f};
                    me->GetMotionMaster()->MovePoint(POINT_AIR_BREATH_START1, pos, false, true);
                    break;
                }
                case EVENT_FLIGHT_BREATH2:
                {
                    Position pos = {1447.0f + urand(0, 2)*25.0f, 515.0f, 50.0f, 1.57f};
                    me->GetMotionMaster()->MovePoint(POINT_AIR_BREATH_START2, pos, false, true);
                    break;
                }
                case EVENT_FLIGHT_EMOTE:
                    Talk(EMOTE_BREATH);
                    break;
                case EVENT_CORRUPT_TRIGGERS:
                    Talk(YELL_BREATH);
                    me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(0));
                    me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(500));
                    me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(1000));
                    me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(1500));
                    me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(2000));
                    me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(2500));
                    me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(3000));
                    me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(3500));
                    me->m_Events.AddEvent(new CorruptTriggers(me), me->m_Events.CalculateTime(4000));
                    break;
                case EVENT_FLIGHT_FLYOVER1:
                    me->CastSpell(me, SPELL_FELMYST_SPEED_BURST, true);
                    me->GetMotionMaster()->MovePoint(POINT_AIR_BREATH_END1, me->GetPositionX(), me->GetPositionY()-200.0f, me->GetPositionZ()+5.0f, false, true);
                    break;
                case EVENT_FLIGHT_FLYOVER2:
                    me->CastSpell(me, SPELL_FELMYST_SPEED_BURST, true);
                    me->GetMotionMaster()->MovePoint(POINT_AIR_BREATH_END2, me->GetPositionX(), me->GetPositionY()+200.0f, me->GetPositionZ()+5.0f, false, true);
                    break;
                case EVENT_LAND_FIGHT:
                    me->GetMotionMaster()->MovePoint(POINT_GROUND, 1500.0f, 552.8f, 26.52f, false, true);
                    break;

            }

            if (!me->HasUnitMovementFlag(MOVEMENTFLAG_DISABLE_GRAVITY))
                DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_felmystAI>(creature);
    }
};

class npc_demonic_vapor : public CreatureScript
{
public:
    npc_demonic_vapor() : CreatureScript("npc_demonic_vapor") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_demonic_vaporAI(creature);
    }

    struct npc_demonic_vaporAI : public NullCreatureAI
    {
        npc_demonic_vaporAI(Creature* creature) : NullCreatureAI(creature) { }

        void Reset()
        {
            me->CastSpell(me, SPELL_DEMONIC_VAPOR_SPAWN_TRIGGER, true);
            me->CastSpell(me, SPELL_DEMONIC_VAPOR_PERIODIC, true);
        }

        void UpdateAI(uint32  /*diff*/)
        {
            if (me->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_CONTROLLED) == NULL_MOTION_TYPE)
            {
                Map::PlayerList const& players = me->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    if (me->GetDistance2d(itr->GetSource()) < 20.0f && itr->GetSource()->IsAlive())
                    {
                        me->GetMotionMaster()->MoveFollow(itr->GetSource(), 0.0f, 0.0f, MOTION_SLOT_CONTROLLED);
                        break;
                    }
            }
        }
    };
};

class npc_demonic_vapor_trail : public CreatureScript
{
public:
    npc_demonic_vapor_trail() : CreatureScript("npc_demonic_vapor_trail") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_demonic_vapor_trailAI(creature);
    }

    struct npc_demonic_vapor_trailAI : public NullCreatureAI
    {
        npc_demonic_vapor_trailAI(Creature* creature) : NullCreatureAI(creature)
        {
            timer = 1;
        }

        uint32 timer;
        void Reset()
        {
            me->CastSpell(me, SPELL_DEMONIC_VAPOR_TRAIL_PERIODIC, true);
        }

        void SpellHitTarget(Unit* , const SpellInfo* spellInfo)
        {
            if (spellInfo->Id == SPELL_DEMONIC_VAPOR)
                me->CastSpell(me, SPELL_SUMMON_BLAZING_DEAD, true);
        }

        void UpdateAI(uint32 diff)
        {
            if (timer)
            {
                timer += diff;
                if (timer >= 6000)
                {
                    timer = 0;
                    me->CastSpell(me, SPELL_SUMMON_BLAZING_DEAD, true);
                }
            }
        }

        void JustSummoned(Creature* summon)
        {
            summon->SetInCombatWithZone();
            summon->AI()->AttackStart(summon->AI()->SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f));
        }
    };
};

class spell_felmyst_fog_of_corruption : public SpellScriptLoader
{
    public:
        spell_felmyst_fog_of_corruption() : SpellScriptLoader("spell_felmyst_fog_of_corruption") { }

        class spell_felmyst_fog_of_corruption_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_felmyst_fog_of_corruption_SpellScript);

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                    target->CastSpell(GetCaster(), SPELL_FOG_OF_CORRUPTION_CHARM, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_felmyst_fog_of_corruption_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_felmyst_fog_of_corruption_SpellScript();
        }
};

class spell_felmyst_fog_of_corruption_charm : public SpellScriptLoader
{
    public:
        spell_felmyst_fog_of_corruption_charm() : SpellScriptLoader("spell_felmyst_fog_of_corruption_charm") { }

        class spell_felmyst_fog_of_corruption_charm_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_felmyst_fog_of_corruption_charm_AuraScript);

            void HandleApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetTarget()->CastSpell(GetTarget(), SPELL_FOG_OF_CORRUPTION_CHARM2, true);
            }

            void HandleRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetTarget()->RemoveAurasDueToSpell(SPELL_FOG_OF_CORRUPTION_CHARM);
                GetTarget()->RemoveAurasDueToSpell(SPELL_FOG_OF_CORRUPTION_CHARM2);
                Unit::Kill(GetCaster(), GetTarget(), false);
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_felmyst_fog_of_corruption_charm_AuraScript::HandleApply, EFFECT_0, SPELL_AURA_AOE_CHARM, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_felmyst_fog_of_corruption_charm_AuraScript::HandleRemove, EFFECT_0, SPELL_AURA_AOE_CHARM, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_felmyst_fog_of_corruption_charm_AuraScript();
        }
};

class DoorsGuidCheck
{
    public:
        bool operator()(WorldObject* object) const
        {
            if (object->GetTypeId() != TYPEID_UNIT)
                return true;

            Creature* cr = object->ToCreature();
            return cr->GetDBTableGUIDLow() != 54780 && cr->GetDBTableGUIDLow() != 54787 && cr->GetDBTableGUIDLow() != 54801;
        }
};

class spell_felmyst_open_brutallus_back_doors : public SpellScriptLoader
{
    public:
        spell_felmyst_open_brutallus_back_doors() : SpellScriptLoader("spell_felmyst_open_brutallus_back_doors") { }

        class spell_felmyst_open_brutallus_back_doors_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_felmyst_open_brutallus_back_doors_SpellScript);

            void FilterTargets(std::list<WorldObject*>& unitList)
            {
                unitList.remove_if(DoorsGuidCheck());
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_felmyst_open_brutallus_back_doors_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_felmyst_open_brutallus_back_doors_SpellScript();
        }
};

void AddSC_boss_felmyst()
{
    new boss_felmyst();
    new npc_demonic_vapor();
    new npc_demonic_vapor_trail();
    new spell_felmyst_fog_of_corruption();
    new spell_felmyst_fog_of_corruption_charm();
    new spell_felmyst_open_brutallus_back_doors();
}
