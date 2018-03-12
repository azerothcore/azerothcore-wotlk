/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "halls_of_lightning.h"
#include "SpellInfo.h"

enum VolkahnSpells
{
    // Volkhan
    SPELL_HEAT_N                        = 52387,
    SPELL_HEAT_H                        = 59528,
    SPELL_SHATTERING_STOMP_N            = 52237,
    SPELL_SHATTERING_STOMP_H            = 59529,
    SPELL_TEMPER                        = 52238,
    SPELL_SUMMON_MOLTEN_GOLEM           = 52405,

    //Molten Golem
    SPELL_BLAST_WAVE                    = 23113,
    SPELL_IMMOLATION_STRIKE_N           = 52433,
    SPELL_IMMOLATION_STRIKE_H           = 59530,
    SPELL_SHATTER_N                     = 52429,
    SPELL_SHATTER_H                     = 59527,
};

enum VolkhanOther
{
    // NPCs
    NPC_VOLKHAN_ANVIL                   = 28823,
    NPC_MOLTEN_GOLEM                    = 28695,
    NPC_BRITTLE_GOLEM                   = 28681,

    // Misc
    ACTION_SHATTER                      = 1,
    ACTION_DESTROYED                    = 2,

    // Point
    POINT_ANVIL                         = 1,
};

enum VolkhanEvents
{
    // Volkhan
    EVENT_HEAT                          = 1,
    EVENT_CHECK_HEALTH                  = 2,
    EVENT_SHATTER                       = 3,
    EVENT_POSITION                      = 4,
    EVENT_MOVE_TO_ANVIL                 = 5,

    // Molten Golem
    EVENT_BLAST                         = 11,
    EVENT_IMMOLATION                    = 12,
};

enum Yells
{
    SAY_AGGRO                               = 0,
    SAY_FORGE                               = 1,
    SAY_STOMP                               = 2,
    SAY_SLAY                                = 3,
    SAY_DEATH                               = 4,
    EMOTE_TO_ANVIL                          = 5,
    EMOTE_SHATTER                           = 6,
};

class boss_volkhan : public CreatureScript
{
public:
    boss_volkhan() : CreatureScript("boss_volkhan") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_volkhanAI (creature);
    }

    struct boss_volkhanAI : public ScriptedAI
    {
        boss_volkhanAI(Creature* creature) : ScriptedAI(creature), summons(creature)
        {
            m_pInstance = creature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        EventMap events;
        SummonList summons;
        uint8 HealthCheck;
        float x, y, z;
        uint8 PointID;
        uint8 ShatteredCount;

        void Reset()
        {
            x = y = z = PointID = ShatteredCount = 0;
            HealthCheck = 100;
            events.Reset();
            summons.DespawnAll();
            me->SetSpeed(MOVE_RUN, 1.2f,true);
            me->SetReactState(REACT_AGGRESSIVE);

            if (m_pInstance)
            {
                m_pInstance->SetData(TYPE_VOLKHAN, NOT_STARTED);
                m_pInstance->SetData(DATA_VOLKHAN_ACHIEVEMENT, true);
            }
        }

        void EnterCombat(Unit*)
        {
            me->SetInCombatWithZone();
            Talk(SAY_AGGRO);

            if (m_pInstance)
                m_pInstance->SetData(TYPE_VOLKHAN, IN_PROGRESS);

            ScheduleEvents(false);
        }

        void JustDied(Unit*)
        {
            Talk(SAY_DEATH);

            summons.DespawnAll();

            if (m_pInstance)
                m_pInstance->SetData(TYPE_VOLKHAN, DONE);
        }

        void GetNextPos()
        {
            if (me->GetPositionY() < -180)
            {
                if (me->GetPositionX() > 1330)
                    x = 1355;
                else 
                    x = 1308;

                y = -178;
                z = 52.5f;
            }
            else if (me->GetPositionY() < -145)
            {
                if (me->GetPositionX() > 1330)
                    x = 1355;
                else 
                    x = 1308;

                y = -137;
                z = 52.5f;
            }
            else if (me->GetPositionY() < -130)
            {
                if (me->GetPositionX() > 1330)
                    x = 1343;
                else 
                    x = 1320;

                y = -123;
                z = 56.7f;
            }
            else
            {
                PointID = POINT_ANVIL;
                x = 1327;
                y = -96;
                z = 56.7f;
            }
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(SAY_SLAY);
        }

        void ScheduleEvents(bool anvil)
        {
            events.SetPhase(1);
            events.RescheduleEvent(EVENT_HEAT, 8000, 0, 1);
            events.RescheduleEvent(EVENT_SHATTER, 10000, 0, 1);
            events.RescheduleEvent(EVENT_CHECK_HEALTH, anvil ? 1000 : 6000, 0, 1);
            events.RescheduleEvent(EVENT_POSITION, 4000, 0, 1);
        }

        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);
            if (summon->GetEntry() == NPC_MOLTEN_GOLEM)
            {
                summon->setFaction(me->getFaction());

                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                    summon->AI()->AttackStart(target);
            }
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_DESTROYED)
            {
                ShatteredCount++;
                if (ShatteredCount > 4)
                    m_pInstance->SetData(DATA_VOLKHAN_ACHIEVEMENT, false);
            }
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id == POINT_ANVIL)
            {
                me->SetSpeed(MOVE_RUN, 1.2f,true);
                me->SetReactState(REACT_AGGRESSIVE);
                me->CastSpell(me, SPELL_TEMPER, false);
                PointID = 0;
                ScheduleEvents(true);

                // update orientation at server
                me->SetOrientation(2.19f);

                // and client
                WorldPacket data;
                me->BuildHeartBeatMsg(&data);
                me->SendMessageToSet(&data, false);
                me->SetControlled(true, UNIT_STATE_ROOT);
            }
            else
                events.ScheduleEvent(EVENT_MOVE_TO_ANVIL, 0, 0, 2);
        }

        void SpellHitTarget(Unit* /*who*/, const SpellInfo *spellInfo)
        {
            if (spellInfo->Id == SPELL_TEMPER)
            {
                me->CastSpell(me, SPELL_SUMMON_MOLTEN_GOLEM, true);
                me->CastSpell(me, SPELL_SUMMON_MOLTEN_GOLEM, true);
                me->GetMotionMaster()->MoveChase(me->GetVictim());
                me->SetControlled(false, UNIT_STATE_ROOT);
            }
        }

        void GoToAnvil()
        {
            events.SetPhase(2);
            HealthCheck -= 20;
            me->SetSpeed(MOVE_RUN, 4.0f,true);
            me->SetReactState(REACT_PASSIVE);

            Talk(SAY_FORGE);

            if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
                me->GetMotionMaster()->MovementExpired();

            events.ScheduleEvent(EVENT_MOVE_TO_ANVIL, 0, 0, 2);
        }

        void UpdateAI(uint32 diff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_HEAT:
                    me->CastSpell(me, me->GetMap()->IsHeroic() ? SPELL_HEAT_H : SPELL_HEAT_N, true);
                    events.RepeatEvent(8000);
                    break;
                case EVENT_CHECK_HEALTH:
                    if (HealthBelowPct(HealthCheck))
                        GoToAnvil();

                    events.RepeatEvent(1000);
                    return;
                case EVENT_SHATTER:
                {
                    events.RepeatEvent(10000);
                    summons.DoAction(ACTION_SHATTER);
                    break;
                }
                case EVENT_MOVE_TO_ANVIL:
                    GetNextPos();
                    me->GetMotionMaster()->MovePoint(PointID, x, y, z);
                    events.PopEvent();
                    return;
                case EVENT_POSITION:
                    if (me->GetDistance(1331.9f, -106, 56) > 95)
                        EnterEvadeMode();
                    else
                        events.RepeatEvent(4000);
                
                    return;
            }
            
            DoMeleeAttackIfReady();
        }
    };
};

class npc_molten_golem : public CreatureScript
{
public:
    npc_molten_golem() : CreatureScript("npc_molten_golem") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_molten_golemAI (creature);
    }

    struct npc_molten_golemAI : public ScriptedAI
    {
        npc_molten_golemAI(Creature* creature) : ScriptedAI(creature)
        {
            m_pInstance = creature->GetInstanceScript();
        }

        EventMap events;
        InstanceScript* m_pInstance;

        void Reset()
        {
            events.Reset();
            events.ScheduleEvent(EVENT_BLAST, 7000);
            events.ScheduleEvent(EVENT_IMMOLATION, 3000);
        }

        void DamageTaken(Unit*, uint32 &uiDamage, DamageEffectType, SpellSchoolMask)
        {
            if (me->GetEntry() == NPC_BRITTLE_GOLEM)
            {
                uiDamage = 0;
                return;
            }

            if (uiDamage >= me->GetHealth())
            {
                me->UpdateEntry(NPC_BRITTLE_GOLEM, 0, false);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_DISABLE_MOVE);
                me->SetHealth(me->GetMaxHealth());
                me->RemoveAllAuras();
                me->AttackStop();
                uiDamage = 0;

                if (me->IsNonMeleeSpellCast(false))
                    me->InterruptNonMeleeSpells(false);

                me->SetControlled(true, UNIT_STATE_STUNNED);
            }
        }

        void DoAction(int32 param)
        {
            if (me->GetEntry() == NPC_BRITTLE_GOLEM && param == ACTION_SHATTER)
            {
                if (Creature* volkhan = ObjectAccessor::GetCreature(*me, m_pInstance->GetData64(TYPE_VOLKHAN)))
                    volkhan->AI()->DoAction(ACTION_DESTROYED);

                me->CastSpell(me, me->GetMap()->IsHeroic() ? SPELL_SHATTER_H : SPELL_SHATTER_N, true);
                me->DespawnOrUnsummon(500);
            }
        }

        void UpdateAI(uint32 diff)
        {
            //Return since we have no target or if we are frozen
            if (!UpdateVictim() || me->GetEntry() == NPC_BRITTLE_GOLEM)
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_BLAST:
                    me->CastSpell(me, SPELL_BLAST_WAVE, false);
                    events.RepeatEvent(14000);
                    break;
                case EVENT_IMMOLATION:
                    me->CastSpell(me->GetVictim(), me->GetMap()->IsHeroic() ? SPELL_IMMOLATION_STRIKE_H : SPELL_IMMOLATION_STRIKE_N, false);
                    events.RepeatEvent(5000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

enum monumentSpells
{
    SPELL_FREEZE_ANIM           = 16245,
    SPELL_AWAKEN                = 52875,

    SPELL_PIERCING_HOWL         = 23600,
    SPELL_PENETRATING_STRIKE    = 52890,
    SPELL_FRIGHTENING_SHOUT     = 19134,
    SPELL_BLADE_TURNING_N       = 52891,
    SPELL_BLADE_TURNING_H       = 59173,

    SPELL_DEADLY_THROW_N        = 52885,
    SPELL_DEADLY_THROW_H        = 59180,
    SPELL_DEFLECTION_N          = 52879,
    SPELL_DEFLECTION_H          = 59181,
    SPELL_THROW_N               = 52904,
    SPELL_THROW_H               = 59179,
};

enum monumentEvents
{
    EVENT_PIERCING_HOWL         = 1,
    EVENT_PENETRATING_STRIKE    = 2,
    EVENT_FRIGHTENING_SHOUT     = 3,
    EVENT_BLADE_TURNING         = 4,

    EVENT_DEADLY_THROW          = 11,
    EVENT_DEFLECTION            = 12,
    EVENT_THROW                 = 13,

    EVENT_UNFREEZE              = 20,
};

class npc_hol_monument : public CreatureScript
{
public:
    npc_hol_monument() : CreatureScript("npc_hol_monument") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_hol_monumentAI(creature);
    }

    struct npc_hol_monumentAI : public ScriptedAI
    {
        npc_hol_monumentAI(Creature* creature) : ScriptedAI(creature)
        {
            _attackGUID = 0;
            _isActive = urand(0,1);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->CastSpell(me, SPELL_FREEZE_ANIM, true);
        }

        EventMap events;
        bool _isActive;
        uint64 _attackGUID;

        void Reset()
        {
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (_attackGUID)
                ScriptedAI::MoveInLineOfSight(who);
            else if (_isActive && who->GetTypeId() == TYPEID_PLAYER)
            {
                if ((who->GetPositionX() < me->GetPositionX() || who->GetPositionY() < -220.0f) && me->GetDistance2d(who) < 40)
                {
                    _isActive = false;
                    _attackGUID = who->GetGUID();
                    events.Reset();
                    events.RescheduleEvent(EVENT_UNFREEZE, 5000);
                }
            }
        }

        void EnterCombat(Unit*)
        {
            events.Reset();
            if (me->GetEntry() == 28961) // NPC_TITANIUM_SIEGEBREAKER
            {
                events.ScheduleEvent(EVENT_PIERCING_HOWL, 10000+rand()%15000);
                events.ScheduleEvent(EVENT_PENETRATING_STRIKE, 5000+rand()%5000);
                events.ScheduleEvent(EVENT_FRIGHTENING_SHOUT, 20000+rand()%8000);
                events.ScheduleEvent(EVENT_BLADE_TURNING, 12000);
            }
            else
            {
                events.ScheduleEvent(EVENT_THROW, 10000+rand()%15000);
                events.ScheduleEvent(EVENT_DEADLY_THROW, 15000+rand()%15000);
                events.ScheduleEvent(EVENT_DEFLECTION, 15000);
            }
        }

        void AttackStart(Unit* who)
        {
            if (!_attackGUID || !_isActive)
                return;
            ScriptedAI::AttackStart(who);
        }

        void UpdateAI(uint32 diff)
        {
            if (!_isActive && !_attackGUID)
                return;

            events.Update(diff);
            uint32 eventId = events.GetEvent();

            if (eventId == EVENT_UNFREEZE)
            {
                events.PopEvent();
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->CastSpell(me, SPELL_AWAKEN, true);
                me->RemoveAllAuras();
                _isActive = true;
                if (Unit* target = ObjectAccessor::GetUnit(*me, _attackGUID))
                    AttackStart(target);
                return;
            }

            //Return since we have no target or if we are disabled from fight
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (eventId)
            {
                case EVENT_PIERCING_HOWL:
                    me->CastSpell(me->GetVictim(), SPELL_PIERCING_HOWL, false);
                    events.RepeatEvent(10000+rand()%1500);
                    break;
                case EVENT_PENETRATING_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_PENETRATING_STRIKE, false);
                    events.RepeatEvent(5000+rand()%5000);
                    break;
                case EVENT_FRIGHTENING_SHOUT:
                    me->CastSpell(me->GetVictim(), SPELL_FRIGHTENING_SHOUT, false);
                    events.RepeatEvent(20000+rand()%8000);
                    break;
                case EVENT_BLADE_TURNING:
                    me->CastSpell(me->GetVictim(), me->GetMap()->IsHeroic() ? SPELL_BLADE_TURNING_H : SPELL_BLADE_TURNING_N, false);
                    events.RepeatEvent(12000);
                    break;
                case EVENT_THROW:
                    me->CastSpell(SelectTarget(SELECT_TARGET_RANDOM,0,50.0f, true,0), me->GetMap()->IsHeroic() ? SPELL_THROW_H : SPELL_THROW_N, true);
                    events.RepeatEvent(10000+rand()%15000);
                    break;
                case EVENT_DEADLY_THROW:
                    me->CastSpell(SelectTarget(SELECT_TARGET_RANDOM,0,50.0f, true,0), me->GetMap()->IsHeroic() ? SPELL_DEADLY_THROW_H : SPELL_DEADLY_THROW_N, true);
                    events.RepeatEvent(15000+rand()%15000);
                    break;
                case EVENT_DEFLECTION:
                    me->CastSpell(me, me->GetMap()->IsHeroic() ? SPELL_DEFLECTION_H : SPELL_DEFLECTION_N, false);
                    events.RepeatEvent(15000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_volkhan()
{
    new boss_volkhan();
    new npc_molten_golem();
    new npc_hol_monument();
}
