/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "onyxias_lair.h"
#include "Player.h"
#include "SpellInfo.h"

enum // Spells
{
    SPELL_WINGBUFFET                = 18500,
    SPELL_FLAMEBREATH               = 18435,
    SPELL_CLEAVE                    = 68868,
    SPELL_TAILSWEEP                 = 68867,
    SPELL_FIREBALL                  = 18392,
    SPELL_BELLOWINGROAR             = 18431,

    SPELL_SUMMON_WHELP              = 17646,
    SPELL_SUMMON_LAIR_GUARD         = 68968,
    SPELL_ERUPTION                  = 17731,

    SPELL_OLG_BLASTNOVA             = 68958,
    SPELL_OLG_IGNITEWEAPON          = 68959,

    SPELL_BREATH_N_TO_S             = 17086,
    SPELL_BREATH_S_TO_N             = 18351,
    SPELL_BREATH_E_TO_W             = 18576,
    SPELL_BREATH_W_TO_E             = 18609,
    SPELL_BREATH_SE_TO_NW           = 18564,
    SPELL_BREATH_NW_TO_SE           = 18584,
    SPELL_BREATH_SW_TO_NE           = 18596,
    SPELL_BREATH_NE_TO_SW           = 18617,
};

enum // Events
{
    EVENT_SPELL_WINGBUFFET          = 1,
    EVENT_SPELL_FLAMEBREATH         = 2,
    EVENT_SPELL_TAILSWEEP           = 3,
    EVENT_SPELL_CLEAVE              = 4,
    EVENT_START_PHASE_2             = 5,
    EVENT_SPELL_FIREBALL_FIRST      = 6,
    EVENT_SPELL_FIREBALL_SECOND     = 7,
    EVENT_PHASE_2_STEP_CW           = 8,
    EVENT_PHASE_2_STEP_ACW          = 9,
    EVENT_PHASE_2_STEP_ACROSS       = 10,
    EVENT_SPELL_BREATH              = 11,
    EVENT_START_PHASE_3             = 12,
    EVENT_PHASE_3_ATTACK            = 13,
    EVENT_SPELL_BELLOWINGROAR       = 14,
    EVENT_WHELP_SPAM                = 15,
    EVENT_SUMMON_LAIR_GUARD         = 16,
    EVENT_SUMMON_WHELP              = 17,
    EVENT_OLG_SPELL_BLASTNOVA       = 18,
    EVENT_OLG_SPELL_IGNITEWEAPON    = 19,
    EVENT_ERUPTION                  = 20,

    EVENT_LIFTOFF                   = 31,
    EVENT_FLY_S_TO_N                = 32,
    EVENT_LAND                      = 33,
    EVENT_END_MANY_WHELPS_TIME,
};

struct sOnyxMove
{
    uint8 CurrId, DestId;
    uint32 spellId;
    float x, y, z, o;
};

static sOnyxMove OnyxiaMoveData[] =
{
    {0, 0, 0, -64.496f, -214.906f, -84.4f, 0.0f}, // south ground
    {1, 5, SPELL_BREATH_S_TO_N, -64.496f, -214.906f, -60.0f, 0.0f}, // south
    {2, 6, SPELL_BREATH_SW_TO_NE, -59.809f, -190.758f, -60.0f, 7*M_PI/4}, // south-west
    {3, 7, SPELL_BREATH_W_TO_E, -29.450f, -180.600f, -60.0f, M_PI+M_PI/2}, // west
    {4, 8, SPELL_BREATH_NW_TO_SE, 6.895f, -180.246f, -60.0f, M_PI+M_PI/4}, // north-west
    {5, 1, SPELL_BREATH_N_TO_S,  22.876f, -217.152f, -60.0f, M_PI}, // north
    {6, 2, SPELL_BREATH_NE_TO_SW, 10.2191f, -247.912f, -60.0f, 3*M_PI/4}, // north-east
    {7, 3, SPELL_BREATH_E_TO_W, -31.496f, -250.123f, -60.0f, M_PI/2}, // east
    {8, 4, SPELL_BREATH_SE_TO_NW, -63.5156f, -240.096f, -60.0f, M_PI/4}, // south-east
};

enum Yells
{
    // Say
    SAY_AGGRO                   = 0,
    SAY_KILL                    = 1,
    SAY_PHASE_2_TRANS           = 2,
    SAY_PHASE_3_TRANS           = 3,

    // Emote
    EMOTE_BREATH                = 4
};

class boss_onyxia : public CreatureScript
{
public:
    boss_onyxia() : CreatureScript("boss_onyxia") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_onyxiaAI (pCreature);
    }

    struct boss_onyxiaAI : public ScriptedAI
    {
        boss_onyxiaAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = me->GetInstanceScript();
        }

        EventMap events;

        InstanceScript* m_pInstance;
        uint8 Phase;
        int8 CurrentWP;

        bool whelpSpam;
        uint8 whelpCount;
        int32 whelpSpamTimer;
        bool bManyWhelpsAvailable;

        void SetPhase(uint8 ph)
        {
            events.Reset();
            Phase = ph;
            switch( ph )
            {
                case 0:
                    break;
                case 1:
                    events.ScheduleEvent(EVENT_SPELL_WINGBUFFET, urand(10000, 20000));
                    events.ScheduleEvent(EVENT_SPELL_FLAMEBREATH, urand(10000, 20000));
                    events.ScheduleEvent(EVENT_SPELL_TAILSWEEP, urand(15000, 20000));
                    events.ScheduleEvent(EVENT_SPELL_CLEAVE, urand(2000, 5000));
                    break;
                case 2:
                    events.ScheduleEvent(EVENT_START_PHASE_2, 0);
                    break;
                case 3:
                    events.ScheduleEvent(EVENT_START_PHASE_3, 5000);
                    break;
            }
        }

        void Reset()
        {
            CurrentWP = 0;
            SetPhase(0);
            me->SetReactState(REACT_AGGRESSIVE);
            me->SetCanFly(false);
            me->SetDisableGravity(false);
            me->SetHover(false);
            me->SetSpeed(MOVE_RUN, me->GetCreatureTemplate()->speed_run, false);

            whelpSpam = false;
            whelpCount = 0;
            whelpSpamTimer = 0;
            bManyWhelpsAvailable = false;

            if( m_pInstance )
            {
                m_pInstance->SetData(DATA_ONYXIA, NOT_STARTED);
                m_pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);
            }
        }

        void MoveInLineOfSight(Unit *who)
        {
            if( me->GetVictim() || me->GetDistance(who) > 30.0f )
                return;

            if( who->GetTypeId() == TYPEID_PLAYER )
                AttackStart(who);
        }

        void DoAction(int32 param)
        {
            switch( param )
            {
                case -1:
                    if( bManyWhelpsAvailable && m_pInstance )
                        m_pInstance->SetData(DATA_WHELP_SUMMONED, 1);
                    break;
            }
        }

        void BindPlayers()
        {
            me->GetMap()->ToInstanceMap()->PermBindAllPlayers();
        }

        void EnterCombat(Unit*  /*who*/)
        {
            Talk(SAY_AGGRO);
            DoZoneInCombat();
            SetPhase(1);

            if( m_pInstance )
            {
                m_pInstance->SetData(DATA_ONYXIA, IN_PROGRESS);
                m_pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT); // just in case at reset some players already left the instance
                m_pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);
            }
            BindPlayers();
        }

        void JustDied(Unit*  /*killer*/)
        {
            if( m_pInstance )
                m_pInstance->SetData(DATA_ONYXIA, DONE);
        }

        void DamageTaken(Unit*, uint32 & /*damage*/, DamageEffectType, SpellSchoolMask)
        {
            switch( Phase )
            {
                case 1:
                    if( me->GetHealth()*100 / me->GetMaxHealth() <= 65 )
                        SetPhase(2);
                    break;
                case 2:
                    if( me->GetHealth()*100 / me->GetMaxHealth() <= 40 )
                    {
                        me->InterruptNonMeleeSpells(false);
                        SetPhase(3);
                    }
                    break;
            }
        }

        void JustSummoned(Creature *pSummoned)
        {
            if( !pSummoned )
                return;
            if( pSummoned->GetEntry() != NPC_ONYXIAN_WHELP && pSummoned->GetEntry() != NPC_ONYXIAN_LAIR_GUARD )
                return;
            if( Unit* target = pSummoned->SelectNearestTarget(300.0f) )
            {
                pSummoned->AI()->AttackStart(target);
                DoZoneInCombat(pSummoned);
            }
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if( type != POINT_MOTION_TYPE && type != EFFECT_MOTION_TYPE )
                return;

            if( id < 9 )
            {
                if( id > 0 && Phase == 2 )
                {
                    me->SetFacingTo(OnyxiaMoveData[id].o);
                    me->SetSpeed(MOVE_RUN, 1.6f, false);
                    CurrentWP = id;
                    events.ScheduleEvent(EVENT_SPELL_FIREBALL_FIRST, 1000);
                }
            }
            else switch( id )
            {
                case 10:
                    me->SetFacingTo(OnyxiaMoveData[0].o);
                    events.ScheduleEvent(EVENT_LIFTOFF, 0);
                    break;
                case 11:
                    me->SetFacingTo(OnyxiaMoveData[1].o);
                    events.ScheduleEvent(EVENT_FLY_S_TO_N, 0);
                    break;
                case 12:
                    me->SetFacingTo(OnyxiaMoveData[1].o);
                    events.ScheduleEvent(EVENT_LAND, 0);
                    break;
                case 13:
                    me->SetCanFly(false);
                    me->SetDisableGravity(false);
                    me->SetHover(false);
                    me->SetSpeed(MOVE_RUN, me->GetCreatureTemplate()->speed_run, false);
                    events.ScheduleEvent(EVENT_PHASE_3_ATTACK, 0);
                    break;
            }
        }

        void HandleWhelpSpam(const uint32 diff)
        {
            if( whelpSpam )
            {
                if( whelpCount < 40 )
                {
                    whelpSpamTimer -= diff;
                    if( whelpSpamTimer <= 0 )
                    {
                        float angle = rand_norm()*2*M_PI;
                        float dist = rand_norm()*4.0f;
                        me->CastSpell(-33.18f + cos(angle)*dist, -258.80f + sin(angle)*dist, -89.0f, 17646, true);
                        me->CastSpell(-32.535f + cos(angle)*dist, -170.190f + sin(angle)*dist, -89.0f, 17646, true);
                        whelpCount += 2;
                        whelpSpamTimer += 600;
                    }
                }
                else
                {
                    whelpSpam = false;
                    whelpCount = 0;
                    whelpSpamTimer = 0;
                }
            }
        }

        void UpdateAI(uint32 diff)
        {
            if( !UpdateVictim() )
                return;

            events.Update(diff);
            HandleWhelpSpam(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            DoMeleeAttackIfReady();

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_WINGBUFFET:
                    {
                        me->CastSpell(me, SPELL_WINGBUFFET, false);
                        events.RepeatEvent(urand(15000, 30000));
                    }
                    break;
                case EVENT_SPELL_FLAMEBREATH:
                    {
                        me->CastSpell(me, SPELL_FLAMEBREATH, false);
                        events.RepeatEvent(urand(10000, 20000));
                    }
                    break;
                case EVENT_SPELL_TAILSWEEP:
                    {
                        me->CastSpell(me, SPELL_TAILSWEEP, false);
                        events.RepeatEvent(urand(15000, 20000));
                    }
                    break;
                case EVENT_SPELL_CLEAVE:
                    {
                        me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                        events.RepeatEvent(urand(2000, 5000));
                    }
                    break;
                case EVENT_START_PHASE_2:
                    {
                        me->AttackStop();
                        me->SetReactState(REACT_PASSIVE);
                        me->StopMoving();
                        DoResetThreat();
                        me->GetMotionMaster()->MovePoint(10, OnyxiaMoveData[0].x, OnyxiaMoveData[0].y, OnyxiaMoveData[0].z);
                        events.PopEvent();
                    }
                    break;
                case EVENT_LIFTOFF:
                    {
                        Talk(SAY_PHASE_2_TRANS);
                        me->SendMeleeAttackStop(me->GetVictim());
                        me->GetMotionMaster()->MoveIdle();
                        me->DisableSpline();
                        me->SetCanFly(true);
                        me->SetDisableGravity(true);
                        me->SetHover(true);
                        me->SetOrientation(OnyxiaMoveData[0].o);
                        me->SendMovementFlagUpdate();
                        me->GetMotionMaster()->MoveTakeoff(11, OnyxiaMoveData[1].x+1.0f, OnyxiaMoveData[1].y, OnyxiaMoveData[1].z, 12.0f);
                        bManyWhelpsAvailable = true;
                        events.PopEvent();
                        events.RescheduleEvent(EVENT_END_MANY_WHELPS_TIME, 10000);
                    }
                    break;
                case EVENT_END_MANY_WHELPS_TIME:
                    bManyWhelpsAvailable = false;
                    events.PopEvent();
                    break;
                case EVENT_FLY_S_TO_N:
                    {
                        me->SetSpeed(MOVE_RUN, 2.95f, false);
                        me->GetMotionMaster()->MovePoint(5, OnyxiaMoveData[5].x, OnyxiaMoveData[5].y, OnyxiaMoveData[5].z);
                        events.PopEvent();
                        whelpSpam = true;
                        events.ScheduleEvent(EVENT_WHELP_SPAM, 90000);
                        events.ScheduleEvent(EVENT_SUMMON_LAIR_GUARD, 30000);
                    }
                    break;
                case EVENT_SUMMON_LAIR_GUARD:
                    {
                        me->CastSpell(-101.654f, -214.491f, -80.70f, SPELL_SUMMON_LAIR_GUARD, true);
                        events.RepeatEvent(30000);
                    }
                    break;
                case EVENT_WHELP_SPAM:
                    {
                        whelpSpam = true;
                        events.RepeatEvent(90000);
                    }
                    break;
                case EVENT_LAND:
                    {
                        Talk(SAY_PHASE_3_TRANS);
                        me->SendMeleeAttackStop(me->GetVictim());
                        me->GetMotionMaster()->MoveLand(13, OnyxiaMoveData[0].x+1.0f, OnyxiaMoveData[0].y, OnyxiaMoveData[0].z, 12.0f);
                        events.PopEvent();
                        DoResetThreat();
                    }
                    break;
                case EVENT_SPELL_FIREBALL_FIRST:
                    {
                        if( Unit* v = SelectTarget(SELECT_TARGET_RANDOM, 0, 200.0f, true) )
                        {
                            me->SetFacingToObject(v);
                            me->CastSpell(v, SPELL_FIREBALL, false);
                        }
                        events.PopEvent();
                        events.ScheduleEvent(EVENT_SPELL_FIREBALL_SECOND, 4000);
                    }
                    break;
                case EVENT_SPELL_FIREBALL_SECOND:
                    {
                        if( Unit* v = SelectTarget(SELECT_TARGET_RANDOM, 0, 200.0f, true) )
                        {
                            me->SetFacingToObject(v);
                            me->CastSpell(v, SPELL_FIREBALL, false);
                        }
                        events.PopEvent();

                        uint8 rand = urand(0, 99);
                        if( rand < 33 )
                            events.ScheduleEvent(EVENT_PHASE_2_STEP_CW, 4000);
                        else if( rand < 66 )
                            events.ScheduleEvent(EVENT_PHASE_2_STEP_ACW, 4000);
                        else
                            events.ScheduleEvent(EVENT_PHASE_2_STEP_ACROSS, 4000);
                    }
                    break;
                case EVENT_PHASE_2_STEP_CW:
                    {
                        uint8 newWP = CurrentWP + 1;
                        if( newWP > 8 )
                            newWP = 1;
                        me->GetMotionMaster()->MovePoint(newWP, OnyxiaMoveData[newWP].x, OnyxiaMoveData[newWP].y, OnyxiaMoveData[newWP].z);
                        events.PopEvent();
                    }
                    break;
                case EVENT_PHASE_2_STEP_ACW:
                    {
                        uint8 newWP = CurrentWP - 1;
                        if( newWP < 1 )
                            newWP = 8;
                        me->GetMotionMaster()->MovePoint(newWP, OnyxiaMoveData[newWP].x, OnyxiaMoveData[newWP].y, OnyxiaMoveData[newWP].z);
                        events.PopEvent();
                    }
                    break;
                case EVENT_PHASE_2_STEP_ACROSS:
                    {
                        me->SetFacingTo(OnyxiaMoveData[CurrentWP].o);
                        me->MonsterTextEmote("Onyxia takes in a deep breath...", 0, true);
                        me->CastSpell(me, OnyxiaMoveData[CurrentWP].spellId, false);
                        events.PopEvent();
                        events.ScheduleEvent(EVENT_SPELL_BREATH, 8250);
                    }
                    break;
                case EVENT_SPELL_BREATH:
                    {
                        uint8 newWP = OnyxiaMoveData[CurrentWP].DestId;
                        me->SetSpeed(MOVE_RUN, 2.95f, false);
                        me->GetMotionMaster()->MovePoint(newWP, OnyxiaMoveData[newWP].x, OnyxiaMoveData[newWP].y, OnyxiaMoveData[newWP].z);
                        events.PopEvent();
                    }
                    break;
                case EVENT_START_PHASE_3:
                    {
                        me->SetSpeed(MOVE_RUN, 2.95f, false);
                        me->GetMotionMaster()->MovePoint(12, OnyxiaMoveData[1].x, OnyxiaMoveData[1].y, OnyxiaMoveData[1].z);
                        events.PopEvent();
                    }
                    break;
                case EVENT_PHASE_3_ATTACK:
                    {
                        events.PopEvent();

                        me->SetReactState(REACT_AGGRESSIVE);
                        AttackStart(SelectTarget(SELECT_TARGET_TOPAGGRO, 0, 0, false));
                        me->CastSpell(me, SPELL_BELLOWINGROAR, false);

                        events.ScheduleEvent(EVENT_ERUPTION, 0);
                        events.ScheduleEvent(EVENT_SPELL_WINGBUFFET, urand(10000, 20000));
                        events.ScheduleEvent(EVENT_SPELL_FLAMEBREATH, urand(10000, 20000));
                        events.ScheduleEvent(EVENT_SPELL_TAILSWEEP, urand(15000, 20000));
                        events.ScheduleEvent(EVENT_SPELL_CLEAVE, urand(2000, 5000));
                        events.ScheduleEvent(EVENT_SPELL_BELLOWINGROAR, 15000);
                        events.ScheduleEvent(EVENT_SUMMON_WHELP, 10000);
                    }
                    break;
                case EVENT_SPELL_BELLOWINGROAR:
                    {
                        me->CastSpell(me, SPELL_BELLOWINGROAR, false);
                        events.RepeatEvent(22000);
                        events.ScheduleEvent(EVENT_ERUPTION, 0);
                    }
                    break;
                case EVENT_ERUPTION:
                    {
                        if( Creature* trigger = me->SummonCreature(12758, *me, TEMPSUMMON_TIMED_DESPAWN, 1000) )
                            trigger->CastSpell(trigger, 17731, false);

                        events.PopEvent();
                    }
                    break;
                case EVENT_SUMMON_WHELP:
                    {
                        float angle = rand_norm()*2*M_PI;
                        float dist = rand_norm()*4.0f;
                        me->CastSpell(-33.18f + cos(angle)*dist, -258.80f + sin(angle)*dist, -89.0f, 17646, true);
                        me->CastSpell(-32.535f + cos(angle)*dist, -170.190f + sin(angle)*dist, -89.0f, 17646, true);
                        events.RepeatEvent(30000);
                    }
                    break;
            }
        }

        void SpellHitTarget(Unit* target, const SpellInfo* spell)
        {
            if (target->GetTypeId() == TYPEID_PLAYER && spell->DurationEntry && spell->DurationEntry->ID == 328 && spell->Effects[EFFECT_1].TargetA.GetTarget() == 1 && (spell->Effects[EFFECT_1].Amplitude == 50 || spell->Effects[EFFECT_1].Amplitude == 215)) // Deep Breath
                if (m_pInstance)
                    m_pInstance->SetData(DATA_DEEP_BREATH_FAILED, 1);
        }
    };
};

class npc_onyxian_lair_guard : public CreatureScript
{
public:
    npc_onyxian_lair_guard() : CreatureScript("npc_onyxian_lair_guard") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_onyxian_lair_guardAI (pCreature);
    }

    struct npc_onyxian_lair_guardAI : public ScriptedAI
    {
        npc_onyxian_lair_guardAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            events.Reset();
            events.ScheduleEvent(EVENT_OLG_SPELL_BLASTNOVA, 15000);
            events.ScheduleEvent(EVENT_OLG_SPELL_IGNITEWEAPON, 10000);
        }

        EventMap events;

        void MoveInLineOfSight(Unit *who)
        {
            if( me->GetVictim() || me->GetDistance(who) > 20.0f )
                return;

            if( who->GetTypeId() == TYPEID_PLAYER )
                AttackStart(who);
        }

        void UpdateAI(uint32 diff)
        {
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_OLG_SPELL_BLASTNOVA:
                    me->CastSpell(me, SPELL_OLG_BLASTNOVA, false);
                    events.RepeatEvent(15000);
                    break;
                case EVENT_OLG_SPELL_IGNITEWEAPON:
                    if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED))
                        events.RepeatEvent(5000);
                    else
                    {
                        me->CastSpell(me, SPELL_OLG_IGNITEWEAPON, false);
                        events.RepeatEvent(urand(18000, 21000));
                    }
                    break;
            }

            if (!me->HasUnitState(UNIT_STATE_CASTING) && me->isAttackReady())
                if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED))
                    if (me->HasAura(SPELL_OLG_IGNITEWEAPON))
                        me->RemoveAura(SPELL_OLG_IGNITEWEAPON);

            DoMeleeAttackIfReady();
        }
    };
};

class npc_onyxia_whelp : public CreatureScript
{
public:
    npc_onyxia_whelp() : CreatureScript("npc_onyxia_whelp") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_onyxia_whelpAI (pCreature);
    }

    struct npc_onyxia_whelpAI : public ScriptedAI
    {
        npc_onyxia_whelpAI(Creature* pCreature) : ScriptedAI(pCreature) {}

        void MoveInLineOfSight(Unit *who)
        {
            if( me->GetVictim() || me->GetDistance(who) > 20.0f )
                return;

            if( who->GetTypeId() == TYPEID_PLAYER )
                AttackStart(who);
        }
    };
};

class npc_onyxia_trigger : public CreatureScript
{
public:
    npc_onyxia_trigger() : CreatureScript("npc_onyxia_trigger") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_onyxia_triggerAI (pCreature);
    }

    struct npc_onyxia_triggerAI : public ScriptedAI
    {
        npc_onyxia_triggerAI(Creature* pCreature) : ScriptedAI(pCreature) {}

        void MoveInLineOfSight(Unit*  /*who*/) {}
        void UpdateAI(uint32  /*diff*/) {}
    };
};

void AddSC_boss_onyxia()
{
    new boss_onyxia();
    new npc_onyxian_lair_guard();
    new npc_onyxia_whelp();
    new npc_onyxia_trigger();
}
