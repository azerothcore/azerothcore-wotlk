/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-AGPL
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "eye_of_eternity.h"
#include "Vehicle.h"
#include "MoveSpline.h"
#include "MoveSplineInit.h"
#include "SpellScript.h"
#include "PassiveAI.h"
#include "CombatAI.h"
#include "Player.h"
#include "WorldSession.h"
#include "Opcodes.h"

enum MovementInformPoints
{
    MI_POINT_INTRO_SIDE_0 = 0,
    MI_POINT_INTRO_SIDE_1 = 1,
    MI_POINT_INTRO_SIDE_2 = 2,
    MI_POINT_INTRO_SIDE_3 = 3,

    MI_POINT_INTRO_CENTER_AIR,
    MI_POINT_INTRO_LAND,
    MI_POINT_VORTEX_TAKEOFF,
    MI_POINT_VORTEX_CENTER,
    MI_POINT_VORTEX_LAND,

    MI_POINT_CENTER_GROUND_PH_2,
    MI_POINT_CENTER_AIR_PH_2,
    MI_POINT_CIRCLE_OUTSIDE_PH_2,
    MI_POINT_SURGE_OF_POWER_CENTER,

    MI_POINT_START_PH_3,
    MI_POINT_PH_3_FIGHT_POSITION,

    MI_POINT_SCION,
    MI_POINT_NEXUS_LORD,
};

enum MalygosSpells
{
    SPELL_BERSERK                       = 64238,
    SPELL_ARCANE_BREATH_N               = 56272,
    SPELL_ARCANE_BREATH_H               = 60072,
    SPELL_ARCANE_STORM_N                = 61693,
    SPELL_ARCANE_STORM_H                = 61694,

    SPELL_VORTEX_VISUAL                 = 55873,
    SPELL_VORTEX_CONTROL_VEHICLE        = 56263,
    SPELL_FREEZE_ANIM                   = 55883,

    SPELL_ARCANE_OVERLOAD               = 56430,
    SPELL_ARCANE_OVERLOAD_SUMMON        = 56429,
    SPELL_ARCANE_OVERLOAD_AURA          = 56432,
    SPELL_ARCANE_OVERLOAD_DMG           = 56431,
    SPELL_ARCANE_OVERLOAD_SIZE          = 56435,
    SPELL_ARCANE_OVERLOAD_PROTECTION    = 56438,

    SPELL_SURGE_OF_POWER                = 56505, // no heroic version?
    SPELL_SURGE_OF_POWER_DMG            = 56548,

    SPELL_DESTROY_PLATFORM_EFFECT       = 59099,
    SPELL_DESTROY_PLATFORM_VISUAL       = 59084,

    SPELL_ARCANE_PULSE                  = 57432,
    SPELL_PH3_SURGE_OF_POWER_N          = 57407,
    SPELL_PH3_SURGE_OF_POWER_H          = 60936,

    SPELL_STATIC_FIELD_MAIN             = 57430,
    SPELL_STATIC_FIELD_SUMMON           = 57431,
    SPELL_STATIC_FIELD_AURA             = 57428,
    SPELL_STATIC_FIELD_DAMAGE           = 57429,
};

#define SPELL_ARCANE_BREATH             DUNGEON_MODE(SPELL_ARCANE_BREATH_N, SPELL_ARCANE_BREATH_H)
#define SPELL_ARCANE_STORM              DUNGEON_MODE(SPELL_ARCANE_STORM_N, SPELL_ARCANE_STORM_H)
#define SPELL_PH3_SURGE_OF_POWER        DUNGEON_MODE(SPELL_PH3_SURGE_OF_POWER_N, SPELL_PH3_SURGE_OF_POWER_H)

enum MalygosEvents
{
    EVENT_INTRO_MOVE_CENTER = 1,
    EVENT_INTRO_LAND,
    EVENT_START_FIGHT,
    EVENT_BERSERK,

    // Phase 1:
    EVENT_SPELL_ARCANE_BREATH,
    EVENT_SPELL_ARCANE_STORM,
    EVENT_SUMMON_POWER_SPARK,
    EVENT_START_VORTEX_0,
    EVENT_VORTEX_FLY_TO_CENTER,
    EVENT_START_VORTEX_REAL,
    EVENT_VORTEX_LAND_0,
    EVENT_VORTEX_LAND_1,

    // Phase 2:
    EVENT_START_PHASE_2,
    EVENT_START_PHASE_2_FLY_UP,
    EVENT_START_PHASE_2_FLY_UP_2,
    EVENT_START_PHASE_2_MOVE_TO_SIDE,
    EVENT_CHECK_TRASH_DEAD,
    EVENT_CLEAR_TARGET,

    EVENT_SPELL_ARCANE_OVERLOAD,
    //EVENT_SPELL_ARCANE_STORM,
    EVENT_RESUME_FLYING_CIRCLES_PH_2,
    EVENT_MOVE_TO_SURGE_OF_POWER,
    EVENT_SURGE_OF_POWER_WARNING,
    EVENT_SPELL_SURGE_OF_POWER,

    // Phase 3:
    EVENT_LIGHT_DIMENSION_CHANGE,
    EVENT_DESTROY_PLATFORM_0,
    EVENT_MOVE_TO_PHASE_3_POSITION,
    EVENT_START_PHASE_3,
    EVENT_SAY_PHASE_3_INTRO,
    EVENT_SPELL_ARCANE_PULSE,
    EVENT_SPELL_STATIC_FIELD,
    EVENT_SPELL_PH3_SURGE_OF_POWER,

    // Trash:
    EVENT_TELEPORT_VISUAL,
    EVENT_SCION_OF_ETERNITY_ARCANE_BARRAGE,
    EVENT_NEXUS_LORD_ARCANE_SHOCK,
    EVENT_NEXUS_LORD_HASTE,
    EVENT_DISK_MOVE_NEXT_POINT,
};

#define MAX_NEXUS_LORDS                 DUNGEON_MODE(2, 4)
#define MAX_SCIONS_OF_ETERNITY          DUNGEON_MODE(4, 8)
#define AREA_EYE_OF_ETERNITY            4500

enum MalygosLightOverrides
{
    LIGHT_GET_DEFAULT_FOR_MAP        = 0,
    LIGHT_OBSCURE_SPACE              = 1822,
    LIGHT_CHANGE_DIMENSIONS          = 1823,
    LIGHT_ARCANE_RUNES               = 1824,
    LIGHT_OBSCURE_ARCANE_RUNES       = 1825,
};


class boss_malygos : public CreatureScript
{
public:
    boss_malygos() : CreatureScript("boss_malygos") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_malygosAI (pCreature);
    }

    struct boss_malygosAI : public ScriptedAI
    {
        boss_malygosAI(Creature *c) : ScriptedAI(c), summons(me)
        {
            pInstance = me->GetInstanceScript();
        }
        
        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;

        uint32 timer1, timer2;
        uint8 IntroCounter;
        bool bLockHealthCheck;

        void Reset()
        {
            events.Reset();
            summons.DespawnAll();

            timer1 = MalygosIntroIntervals[4];
            timer2 = INTRO_MOVEMENT_INTERVAL;
            IntroCounter = 0;
            bLockHealthCheck = false;

            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_PACIFIED);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
            me->SetCanFly(true);
            me->SetDisableGravity(true);
            //me->SetHover(true);
            me->SendMovementFlagUpdate();

            if (pInstance)
            {
                pInstance->SetData(DATA_ENCOUNTER_STATUS, NOT_STARTED);
                pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_YOU_DONT_HAVE_AN_ENTERNITY_EVENT);
            }
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type == POINT_MOTION_TYPE)
            {
                switch (id)
                {
                    case MI_POINT_INTRO_SIDE_0:
                    case MI_POINT_INTRO_SIDE_1:
                    case MI_POINT_INTRO_SIDE_2:
                    case MI_POINT_INTRO_SIDE_3:
                        {
                            float angle = me->GetOrientation();
                            float dist = 75.0f;
                            if (Creature *c = me->SummonCreature(NPC_PORTAL, me->GetPositionX()+cos(angle)*dist, me->GetPositionY()+sin(angle)*dist, me->GetPositionZ(), FourSidesPos[id].GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 13000))
                                me->CastSpell(c, SPELL_PORTAL_BEAM, false);
                            timer2 = INTRO_MOVEMENT_INTERVAL-10000;
                        }
                        break;

                    case MI_POINT_INTRO_CENTER_AIR:
                        events.RescheduleEvent(EVENT_INTRO_LAND, 0, 1);
                        break;
                    case MI_POINT_VORTEX_CENTER:
                        if (Creature* c = me->SummonCreature(NPC_WORLD_TRIGGER_LAOI, CenterPos, TEMPSUMMON_TIMED_DESPAWN, 15000))
                            c->CastSpell(c, SPELL_VORTEX_VISUAL, true);
                        events.RescheduleEvent(EVENT_START_VORTEX_REAL, 1000, 1);
                        break;
                    case MI_POINT_CENTER_GROUND_PH_2:
                        events.RescheduleEvent(EVENT_START_PHASE_2_FLY_UP, 0, 1);
                        break;
                    case MI_POINT_CIRCLE_OUTSIDE_PH_2:
                        events.RescheduleEvent(EVENT_RESUME_FLYING_CIRCLES_PH_2, 0, 1);
                        break;
                    case MI_POINT_SURGE_OF_POWER_CENTER:
                        events.RescheduleEvent(EVENT_SURGE_OF_POWER_WARNING, 0, 1);
                        break;
                }
            }
            else if (type == EFFECT_MOTION_TYPE)
            {
                switch (id)
                {
                    case MI_POINT_INTRO_LAND:
                        me->SetCanFly(false);
                        me->SetDisableGravity(false);
                        //me->SetHover(false);
                        events.RescheduleEvent(EVENT_START_FIGHT, 0, 1);
                        break;
                    case MI_POINT_VORTEX_TAKEOFF:
                        events.RescheduleEvent(EVENT_VORTEX_FLY_TO_CENTER, 0, 1);
                        break;
                    case MI_POINT_VORTEX_LAND:
                        me->SetCanFly(false);
                        me->SetDisableGravity(false);
                        //me->SetHover(false);
                        events.RescheduleEvent(EVENT_VORTEX_LAND_1, 0, 1);
                        break;
                    case MI_POINT_CENTER_AIR_PH_2:
                        me->GetMap()->SetZoneOverrideLight(AREA_EYE_OF_ETERNITY, LIGHT_ARCANE_RUNES, 5 * IN_MILLISECONDS);
                        break;
                    case MI_POINT_PH_3_FIGHT_POSITION:
                        events.RescheduleEvent(EVENT_START_PHASE_3, 6000, 1);
                        break;
                }
            }
        }

        void SpellHit(Unit * /*caster*/, const SpellInfo *spell)
        {
            if (spell->Id == SPELL_POWER_SPARK_MALYGOS_BUFF) 
            {
                if (!bLockHealthCheck)
                {
                    me->MonsterYell("I AM UNSTOPPABLE!", LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(SOUND_SPARK_BUFF);
                }
                else
                    me->RemoveAura(SPELL_POWER_SPARK_MALYGOS_BUFF);
            }
        }

        void EnterCombat(Unit*  /*who*/)
        {
            events.Reset();
            DoZoneInCombat();

            me->MonsterYell("My patience has reached it's limit, I will be rid of you!", LANG_UNIVERSAL, 0);
            me->PlayDirectSound(SOUND_AGGRO_1);

            events.RescheduleEvent(EVENT_INTRO_MOVE_CENTER, 0, 1);
            if (pInstance)
                pInstance->SetData(DATA_ENCOUNTER_STATUS, IN_PROGRESS);
        }

        void AttackStart(Unit* victim)
        {
            if (!victim)
                return;

            if (me->GetVictim() && me->GetVictim()->GetGUID() == victim->GetGUID() && !me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_PACIFIED))
            {
                if (!me->GetUInt64Value(UNIT_FIELD_TARGET))
                    me->SetTarget(victim->GetGUID());
            }
            else if (me->Attack(victim, true))
            {
                if (!me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_PACIFIED))
                    me->GetMotionMaster()->MoveChase(victim);
                else
                    me->SetTarget(0);
            }
        }

        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask)
        {
            if (damage >= me->GetHealth() && !me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE)) // allow dying only in phase 3!
            {
                damage = 0;
                return;
            }

            if (!bLockHealthCheck && me->HealthBelowPctDamaged(50, damage))
            {
                bLockHealthCheck = true;
                events.RescheduleEvent(EVENT_START_PHASE_2, 0, 1);
            }
        }

        void UpdateAI(uint32 diff)
        {
            HandleIntroSpeech(diff);

            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_BERSERK:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    events.PopEvent();
                    break;
                case EVENT_INTRO_MOVE_CENTER:
                    {
                        if (pInstance)
                            pInstance->SetData(DATA_SET_IRIS_INACTIVE, 0);
                        summons.DespawnAll();
                        me->InterruptNonMeleeSpells(true);
                        me->RemoveAllAuras();
                        float angle = CenterPos.GetAngle(me);
                        float x = CenterPos.GetPositionX() + cos(angle)*35.0f;
                        float y = CenterPos.GetPositionY() + sin(angle)*35.0f;
                        float z = FourSidesPos[0].GetPositionZ();
                        me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        me->GetMotionMaster()->MovePoint(MI_POINT_INTRO_CENTER_AIR, x, y, z);
                        events.PopEvent();
                    }
                    break;
                case EVENT_INTRO_LAND:
                    {
                        me->GetMotionMaster()->MoveLand(MI_POINT_INTRO_LAND, me->GetPositionX(), me->GetPositionY(), CenterPos.GetPositionZ(), 7.0f);
                        events.PopEvent();
                    }
                    break;
                case EVENT_START_FIGHT:
                    {
                        if (pInstance)
                        {
                            pInstance->SetData(DATA_HIDE_IRIS_AND_PORTAL, 0);
                            pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_YOU_DONT_HAVE_AN_ENTERNITY_EVENT);
                        }
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_PACIFIED);
                        if (Unit* target = me->SelectNearestTarget(250.0f))
                        {
                            AttackStart(target);
                            me->GetMotionMaster()->MoveChase(target);
                        }
                        events.PopEvent();

                        events.RescheduleEvent(EVENT_BERSERK, 600000, 0);
                        events.RescheduleEvent(EVENT_SPELL_ARCANE_BREATH, urand(9000,12000), 1);
                        events.RescheduleEvent(EVENT_SPELL_ARCANE_STORM, urand(2000,5000), 1);
                        events.RescheduleEvent(EVENT_SUMMON_POWER_SPARK, urand(10000,15000), 1);
                        events.RescheduleEvent(EVENT_START_VORTEX_0, 30000, 1);
                    }
                    break;

                case EVENT_SPELL_ARCANE_BREATH:
                    me->CastSpell(me->GetVictim(), SPELL_ARCANE_BREATH, false);
                    events.RepeatEvent(urand(12000,15000));
                    break;
                case EVENT_SPELL_ARCANE_STORM:
                    me->CastCustomSpell(SPELL_ARCANE_STORM, SPELLVALUE_MAX_TARGETS, DUNGEON_MODE(5, 12), me, true);
                    events.RepeatEvent(urand(10000,15000));
                    break;
                case EVENT_SUMMON_POWER_SPARK:
                    {
                        uint8 random = urand(0, 3);
                        if (Creature *c = me->SummonCreature(NPC_PORTAL, FourSidesPos[random], TEMPSUMMON_TIMED_DESPAWN, 6000))
                            c->CastSpell(c, SPELL_PORTAL_BEAM, false);
                        if (Creature* c = me->SummonCreature(NPC_POWER_SPARK, FourSidesPos[random], TEMPSUMMON_MANUAL_DESPAWN, 0))
                            c->AI()->DoAction(1);
                        me->MonsterTextEmote("A Power Spark forms from a nearby rift!", 0, true);
                        events.RepeatEvent(urand(20000,30000));
                    }
                    break;
                case EVENT_START_VORTEX_0:
                    {
                        bLockHealthCheck = true;
                        me->MonsterYell("Watch helplessly as your hopes are swept away...", LANG_UNIVERSAL, 0);
                        me->PlayDirectSound(SOUND_VORTEX);
                        EntryCheckPredicate pred(NPC_POWER_SPARK);
                        summons.DoAction(2, pred); // stop following
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);

                        me->SendMeleeAttackStop(me->GetVictim());
                        me->SetTarget((uint64)0);

                        me->GetMotionMaster()->MoveIdle();
                        me->StopMoving();
                        me->SetCanFly(true);
                        me->SetDisableGravity(true);
                        //me->SetHover(true);
                        me->SendMovementFlagUpdate();
                        me->GetMotionMaster()->MoveTakeoff(MI_POINT_VORTEX_TAKEOFF, me->GetPositionX(), me->GetPositionY(), CenterPos.GetPositionZ()+20.0f, 7.0f);

                        events.PopEvent();
                        events.DelayEvents(25000, 1); // don't delay berserk (group 0)
                    }
                    break;
                case EVENT_VORTEX_FLY_TO_CENTER:
                    me->GetMotionMaster()->MovePoint(MI_POINT_VORTEX_CENTER, CenterPos.GetPositionX(), CenterPos.GetPositionY(), CenterPos.GetPositionZ()+20.0f);
                    events.PopEvent();
                    break;
                case EVENT_START_VORTEX_REAL:
                    me->SendMeleeAttackStop(me->GetVictim());
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_CUSTOM_SPELL_01);
                    me->HandleEmoteCommand(EMOTE_STATE_CUSTOM_SPELL_01);

                    {
                        Position pos;
                        float angle = (me->GetOrientation() >= M_PI/4 ? me->GetOrientation()-M_PI/4 : 7*M_PI/4+me->GetOrientation());
                        pos.m_positionX = CenterPos.GetPositionX()+cos(angle)*40.0f;
                        pos.m_positionY = CenterPos.GetPositionY()+sin(angle)*40.0f;
                        pos.m_positionZ = CenterPos.GetPositionZ()+20.0f;
                        pos.m_orientation = pos.GetAngle(&CenterPos);

                        if (Creature* vp = me->SummonCreature(NPC_WORLD_TRIGGER_LAOI, pos, TEMPSUMMON_TIMED_DESPAWN, 14000))
                        {
                            vp->SetCanFly(true);
                            vp->SetDisableGravity(true);

                            Map::PlayerList const &PlayerList = me->GetMap()->GetPlayers();
                            if (!PlayerList.isEmpty())
                                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                    if (Player *pPlayer = i->GetSource())
                                    {
                                        if (!pPlayer->IsAlive() || pPlayer->IsGameMaster())
                                            continue;

                                        Position plrpos;
                                        float angle = CenterPos.GetAngle(pPlayer);
                                        plrpos.m_positionX = CenterPos.GetPositionX()+cos(angle)*5.0f;
                                        plrpos.m_positionY = CenterPos.GetPositionY()+sin(angle)*5.0f;
                                        plrpos.m_positionZ = CenterPos.GetPositionZ()+18.0f;
                                        plrpos.m_orientation = plrpos.GetAngle(&CenterPos);

                                        if (Creature* c = me->SummonCreature(NPC_VORTEX, plrpos, TEMPSUMMON_TIMED_DESPAWN, 15000))
                                        {
                                            pPlayer->CastSpell(pPlayer, SPELL_FREEZE_ANIM, true);
                                            pPlayer->CastSpell(c, SPELL_VORTEX_CONTROL_VEHICLE, true);
                                            if (!pPlayer->GetVehicle()) // didn't work somehow, try again with a different way, if fails - break
                                            {
                                                pPlayer->EnterVehicle(c, 0);
                                                if (!pPlayer->GetVehicle())
                                                    continue;
                                            }
                                            //pPlayer->ClearUnitState(UNIT_STATE_ONVEHICLE);

                                            Movement::MoveSplineInit init(pPlayer);
                                            init.MoveTo(CenterPos.GetPositionX(), CenterPos.GetPositionY(), CenterPos.GetPositionZ());
                                            init.SetFacing(pPlayer->GetOrientation());
                                            init.SetTransportExit();
                                            init.Launch();

                                            pPlayer->SetUnitMovementFlags(MOVEMENTFLAG_NONE);
                                            pPlayer->SetDisableGravity(true, true);
                                            WorldPacket data(SMSG_SPLINE_MOVE_UNROOT, 8);
                                            data.append(pPlayer->GetPackGUID());
                                            pPlayer->SendMessageToSet(&data, true);

                                            pPlayer->SetUInt64Value(PLAYER_FARSIGHT, vp->GetGUID());
                                            c->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                                        }
                                    }
                        }
                    }
                    events.PopEvent();
                    events.RescheduleEvent(EVENT_VORTEX_LAND_0, 11000, 1);
                    break;
                case EVENT_VORTEX_LAND_0:
                    me->GetMotionMaster()->MoveLand(MI_POINT_VORTEX_LAND, CenterPos, 7.0f);
                    events.PopEvent();
                    break;
                case EVENT_VORTEX_LAND_1:
                {
                    bLockHealthCheck = false;
                    EntryCheckPredicate pred(NPC_POWER_SPARK);
                    summons.DoAction(1, pred); // resume following
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);
                    if (Unit* target = me->GetVictim())
                    {
                        AttackStart(target);
                        me->GetMotionMaster()->MoveChase(target);
                    }
                    events.PopEvent();
                    events.RescheduleEvent(EVENT_START_VORTEX_0, 60000, 1);
                    break;
                }
                case EVENT_START_PHASE_2:
                    me->MonsterYell("I had hoped to end your lives quickly, but you have proven more...resilient then I had anticipated. Nonetheless, your efforts are in vain, it is you reckless, careless mortals who are to blame for this war! I do what I must...And if it means your...extinction...THEN SO BE IT!", LANG_UNIVERSAL,0);
                    me->PlayDirectSound(SOUND_PHASE_1_END);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);
                    me->SendMeleeAttackStop();
                    me->SetTarget((uint64)0);
                    me->GetMotionMaster()->MoveIdle();
                    me->DisableSpline();
                    me->GetMotionMaster()->MovePoint(MI_POINT_CENTER_GROUND_PH_2, CenterPos);
                    events.CancelEventGroup(1); // don't cancel berserk (group 0)
                    break;
                case EVENT_START_PHASE_2_FLY_UP:
                {
                    me->SendMeleeAttackStop(me->GetVictim());
                    me->GetMotionMaster()->MoveIdle();
                    me->DisableSpline();
                    me->SetCanFly(true);
                    me->SetDisableGravity(true);
                    //me->SetHover(true);
                    me->SendMovementFlagUpdate();
                    me->GetMotionMaster()->MoveTakeoff(MI_POINT_CENTER_AIR_PH_2, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+32.0f, 7.0f);
                    events.PopEvent();
                    events.RescheduleEvent(EVENT_START_PHASE_2_MOVE_TO_SIDE, 22500, 1);
                    break;
                }
                case EVENT_START_PHASE_2_MOVE_TO_SIDE:
                    me->MonsterYell("Few have experienced the pain I will now inflict upon you!", LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(SOUND_AGGRO_2);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_PACIFIED);
                    me->GetMotionMaster()->MovePoint(MI_POINT_CIRCLE_OUTSIDE_PH_2, Phase2NorthPos);
                    events.RescheduleEvent(EVENT_SPELL_ARCANE_STORM, urand(12000,15000), 1);
                    events.RescheduleEvent(EVENT_SPELL_ARCANE_OVERLOAD, 8000, 1);
                    events.RescheduleEvent(EVENT_MOVE_TO_SURGE_OF_POWER, 55000, 1);
                    events.RescheduleEvent(EVENT_CHECK_TRASH_DEAD, 3000, 1);
                    
                    for (int i=0; i<MAX_NEXUS_LORDS; i++)
                    {
                        float dist = 22.0f;
                        float angle = M_PI/2 + ((float)i/MAX_NEXUS_LORDS)*2*M_PI;
                        if (Creature* disk = me->SummonCreature(NPC_HOVER_DISK, CenterPos.GetPositionX()+cos(angle)*dist, CenterPos.GetPositionY()+sin(angle)*dist, CenterPos.GetPositionZ()+30.0f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN, 0))
                            if (Creature* c = me->SummonCreature(NPC_NEXUS_LORD, *disk, TEMPSUMMON_MANUAL_DESPAWN, 0))
                            {
                                c->EnterVehicle(disk, 0);
                                disk->AI()->DoAction(1); // start moving
                            }
                    }
                    for (int i=0; i<MAX_SCIONS_OF_ETERNITY; i++)
                    {
                        float dist = 30.0f;
                        float angle = 0.0f + ((float)i/MAX_SCIONS_OF_ETERNITY)*2*M_PI;
                        if (Creature* disk = me->SummonCreature(NPC_HOVER_DISK, CenterPos.GetPositionX()+cos(angle)*dist, CenterPos.GetPositionY()+sin(angle)*dist, CenterPos.GetPositionZ()+30.0f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN, 0))
                            if (Creature* c = me->SummonCreature(NPC_SCION_OF_ETERNITY, *disk, TEMPSUMMON_MANUAL_DESPAWN, 0))
                            {
                                c->EnterVehicle(disk, 0);
                                disk->AI()->DoAction(1); // start moving
                            }
                    }

                    events.PopEvent();
                    break;
                case EVENT_SPELL_ARCANE_OVERLOAD:
                    {
                        me->GetMotionMaster()->MoveIdle();
                        me->StopMoving();
                        float dist = urand(5, 30);
                        float angle = rand_norm()*2*M_PI;
                        float posx = CenterPos.GetPositionX()+cos(angle)*dist;
                        float posy = CenterPos.GetPositionY()+sin(angle)*dist;
                        me->SetFacingTo(me->GetAngle(posx, posy));
                        me->CastSpell(posx, posy, CenterPos.GetPositionZ()+1.5f, SPELL_ARCANE_OVERLOAD, true);
                        events.RepeatEvent(15000);
                        events.RescheduleEvent(EVENT_RESUME_FLYING_CIRCLES_PH_2, 3000, 1);
                    }
                    break;
                case EVENT_RESUME_FLYING_CIRCLES_PH_2:
                    {
                        float angle = CenterPos.GetAngle(me);
                        float dist = Phase2NorthPos.GetExactDist2d(&CenterPos);
                        float newangle = angle+0.5f;
                        if (newangle >= 2*M_PI) newangle -= 2*M_PI;
                        me->GetMotionMaster()->MovePoint(MI_POINT_CIRCLE_OUTSIDE_PH_2, CenterPos.GetPositionX()+cos(newangle)*dist, CenterPos.GetPositionY()+sin(newangle)*dist, Phase2NorthPos.GetPositionZ());
                        events.PopEvent();
                    }
                    break;
                case EVENT_MOVE_TO_SURGE_OF_POWER:
                    {
                        me->MonsterYell("You will not succeed while i draw breath!", LANG_UNIVERSAL, 0);
                        me->PlayDirectSound(SOUND_DEEP_BREATH);
                        float angle = CenterPos.GetAngle(me);
                        me->GetMotionMaster()->MoveIdle();
                        me->StopMoving();
                        me->GetMotionMaster()->MovePoint(MI_POINT_SURGE_OF_POWER_CENTER, CenterPos.GetPositionX()+cos(angle)*10.0f, CenterPos.GetPositionY()+sin(angle)*10.0f, Phase2NorthPos.GetPositionZ());
                        events.CancelEventGroup(1); // everything beside berserk
                    }
                    break;
                case EVENT_SURGE_OF_POWER_WARNING:
                    me->MonsterTextEmote("Malygos takes a deep breath.", 0, true);
                    events.PopEvent();
                    events.RescheduleEvent(EVENT_SPELL_SURGE_OF_POWER, 1500, 1);
                    break;
                case EVENT_SPELL_SURGE_OF_POWER:
                    if (Creature* c = me->SummonCreature(NPC_SURGE_OF_POWER, CenterPos, TEMPSUMMON_TIMED_DESPAWN, 10000))
                        me->CastSpell(c, SPELL_SURGE_OF_POWER, false);
                    events.PopEvent();
                    events.RescheduleEvent(EVENT_CLEAR_TARGET, 10000, 1);
                    events.RescheduleEvent(EVENT_RESUME_FLYING_CIRCLES_PH_2, 10000, 1);
                    events.RescheduleEvent(EVENT_SPELL_ARCANE_STORM, urand(17000,25000), 1);
                    events.RescheduleEvent(EVENT_SPELL_ARCANE_OVERLOAD, 16000, 1);
                    events.RescheduleEvent(EVENT_MOVE_TO_SURGE_OF_POWER, 55000+10000, 1);
                    events.RescheduleEvent(EVENT_CHECK_TRASH_DEAD, 3000, 1);
                    break;
                case EVENT_CLEAR_TARGET:
                    me->SendMeleeAttackStop();
                    me->SetTarget(0);
                    events.PopEvent();
                    break;
                case EVENT_CHECK_TRASH_DEAD:
                    {
                        if (me->FindNearestCreature(NPC_SCION_OF_ETERNITY, 250.0f, true) || me->FindNearestCreature(NPC_NEXUS_LORD, 250.0f, true))
                            events.RepeatEvent(3000);
                        else
                        {
                            me->SendMeleeAttackStop();
                            me->SetTarget(0);
                            events.CancelEventGroup(1);
                            summons.DespawnAll();
                            // start phase 3
                            me->MonsterYell("ENOUGH! If you intend to reclaim Azeroth\'s magic, then you shall have it...", LANG_UNIVERSAL,0);
                            me->PlayDirectSound(SOUND_PHASE_2_END);
                            me->GetMotionMaster()->Clear();
                            me->GetMotionMaster()->MoveIdle();
                            me->StopMoving();
                            me->GetMotionMaster()->MovePoint(MI_POINT_START_PH_3, CenterPos.GetPositionX(), CenterPos.GetPositionY(), CenterPos.GetPositionZ()+70.0f);
                            events.RescheduleEvent(EVENT_LIGHT_DIMENSION_CHANGE, 1000, 1);
                            events.RescheduleEvent(EVENT_DESTROY_PLATFORM_0, 10000, 1);
                        }
                    }
                    break;
                case EVENT_LIGHT_DIMENSION_CHANGE:
                    me->GetMap()->SetZoneOverrideLight(AREA_EYE_OF_ETERNITY, LIGHT_CHANGE_DIMENSIONS, 2 * IN_MILLISECONDS);
                    events.PopEvent();
                    break;
                case EVENT_DESTROY_PLATFORM_0:
                    if (Creature* c = me->SummonCreature(NPC_WORLD_TRIGGER_LAOI, CenterPos, TEMPSUMMON_TIMED_DESPAWN, 3000))
                    {
                        c->setFaction(me->getFaction());
                        c->CastSpell(c, SPELL_DESTROY_PLATFORM_VISUAL, true);
                        c->CastSpell(c, SPELL_DESTROY_PLATFORM_EFFECT, false);
                    }
                    me->GetMap()->SetZoneOverrideLight(AREA_EYE_OF_ETERNITY, LIGHT_OBSCURE_SPACE, 1 * IN_MILLISECONDS);
                    events.PopEvent();
                    events.RescheduleEvent(EVENT_MOVE_TO_PHASE_3_POSITION, 2000, 1);
                    break;
                case EVENT_MOVE_TO_PHASE_3_POSITION:
                    {
                        me->SendMeleeAttackStop(me->GetVictim());
                        me->GetMotionMaster()->MoveTakeoff(MI_POINT_PH_3_FIGHT_POSITION, CenterPos.GetPositionX(), CenterPos.GetPositionY(), CenterPos.GetPositionZ()-5.0f, me->GetSpeed(MOVE_RUN));

                        me->DeleteThreatList(); // players on vehicle are unattackable -> leads to EnterEvadeMode() because target is not acceptable!

                        // mount players:
                        Map::PlayerList const &PlayerList = me->GetMap()->GetPlayers();
                        if (!PlayerList.isEmpty())
                            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                if (Player *pPlayer = i->GetSource())
                                {
                                    if (!pPlayer->IsAlive() || pPlayer->IsGameMaster())
                                        continue;

                                    if (Creature* c = me->SummonCreature(NPC_WYRMREST_SKYTALON, pPlayer->GetPositionX(), pPlayer->GetPositionY(), pPlayer->GetPositionZ()-20.0f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN, 0))
                                    {
                                        c->setFaction(pPlayer->getFaction());
                                        //pPlayer->CastCustomSpell(60683, SPELLVALUE_BASE_POINT0, 1, c, true);
                                        c->m_Events.AddEvent(new EoEDrakeEnterVehicleEvent(*c, pPlayer->GetGUID()), c->m_Events.CalculateTime(500));
                                        AttackStart(c);
                                    }
                                }

                        events.PopEvent();
                        events.RescheduleEvent(EVENT_SAY_PHASE_3_INTRO, 3000, 1);
                    }
                    break;
                case EVENT_SAY_PHASE_3_INTRO:
                    me->MonsterYell("Now your benefactors make their appearance...But they are too late. The powers contained here are sufficient to destroy the world ten times over! What do you think they will do to you?", LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(SOUND_PHASE_3_START);
                    events.PopEvent();
                    break;
                case EVENT_START_PHASE_3:
                    events.PopEvent();
                    me->GetMap()->SetZoneOverrideLight(AREA_EYE_OF_ETERNITY, LIGHT_OBSCURE_ARCANE_RUNES, 1 * IN_MILLISECONDS);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED | UNIT_FLAG_DISABLE_MOVE);
                    if (Unit* target = me->GetVictim())
                        AttackStart(target);
                    events.RescheduleEvent(EVENT_SPELL_ARCANE_PULSE, 0, 1);
                    events.RescheduleEvent(EVENT_SPELL_STATIC_FIELD, urand(1000,4000), 1);
                    events.RescheduleEvent(EVENT_SPELL_PH3_SURGE_OF_POWER, urand(4000,7000), 1);
                    events.RescheduleEvent(EVENT_SPELL_ARCANE_STORM, urand(12000,15000), 1);
                    break;
                case EVENT_SPELL_ARCANE_PULSE:
                    me->CastSpell(me, SPELL_ARCANE_PULSE, true);
                    events.RepeatEvent(3000);
                    break;
                case EVENT_SPELL_STATIC_FIELD:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 200.0f, false))
                    {
                        me->SetFacingToObject(target);
                        me->CastSpell(target, SPELL_STATIC_FIELD_MAIN, true);
                    }
                    events.RepeatEvent(12000);
                    break;
                case EVENT_SPELL_PH3_SURGE_OF_POWER:
                    me->CastSpell((Unit*)NULL, SPELL_PH3_SURGE_OF_POWER, false);
                    events.RepeatEvent(7000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*killer*/)
        {
            me->MonsterYell("UNTHINKABLE! The mortals will destroy... e-everything... my sister... what have you-", LANG_UNIVERSAL, 0);
            me->PlayDirectSound(SOUND_DEATH);
            if (pInstance)
            {
                pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, NPC_MALYGOS, 1);
                pInstance->SetData(DATA_ENCOUNTER_STATUS, DONE);
            }
        }

        void KilledUnit(Unit *victim)
        {
            if (victim && victim->GetGUID() == me->GetGUID())
                return;
        }

        void JustSummoned(Creature* summon)
        {
            if (!summon)
                return;
            summons.Summon(summon);
            switch(summon->GetEntry())
            {
                case NPC_ARCANE_OVERLOAD:
                    summon->CastSpell(summon, SPELL_ARCANE_OVERLOAD_DMG, true);
                    summon->DespawnOrUnsummon(45000);
                    break;
                case NPC_STATIC_FIELD:
                    summon->DespawnOrUnsummon(20000);
                    break;
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) {}

        void EnterEvadeMode()
        {
            me->GetMap()->SetZoneOverrideLight(AREA_EYE_OF_ETERNITY, LIGHT_GET_DEFAULT_FOR_MAP, 1*IN_MILLISECONDS);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
            ScriptedAI::EnterEvadeMode();
        }

        void HandleIntroSpeech(const uint32 diff)
        {
            if (me->IsInCombat() || me->isDead())
                return;

            // speech timer
            if (timer1 <= diff)
            {
                me->PlayDirectSound(MalygosIntroTexts[IntroCounter].sound);
                me->MonsterYell(MalygosIntroTexts[IntroCounter].text, LANG_UNIVERSAL, 0);
                timer1 = MalygosIntroIntervals[IntroCounter];
                if (++IntroCounter >= 5)
                    IntroCounter = 0;
            }
            else
                timer1 -= diff;

            // movement timer
            if (timer2)
            {
                if (timer2 <= diff)
                {
                    timer2 = 0;
                    uint32 tmp = urand(0,3);
                    me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                    me->GetMotionMaster()->MovePoint(MI_POINT_INTRO_SIDE_0+tmp, FourSidesPos[tmp]);
                }
                else
                    timer2 -= diff;
            }
        }
    };
};


#define VORTEX_DEFAULT_DIFF 250
#define VORTEX_TRAVEL_TIME 3000
//#define VORTEX_RADIUS 25.0f

class npc_vortex_ride : public CreatureScript
{
public:
    npc_vortex_ride() : CreatureScript("npc_vortex_ride") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_vortex_rideAI (pCreature);
    }

    struct npc_vortex_rideAI : public VehicleAI
    {
        npc_vortex_rideAI(Creature* pCreature) : VehicleAI(pCreature)
        {
            VORTEX_RADIUS = urand(22,28);
            float h = urand(15, 30);
            float angle = CenterPos.GetAngle(me);
            Position pos;
            pos.m_positionX = CenterPos.GetPositionX()+VORTEX_RADIUS*cos(angle);
            pos.m_positionY = CenterPos.GetPositionY()+VORTEX_RADIUS*sin(angle);
            pos.m_positionZ = CenterPos.GetPositionZ()+h;
            pos.m_orientation = pos.GetAngle(&CenterPos);
            me->SetPosition(pos);
            timer = 0;
            despawnTimer = 9500;
            bUpdatedFlying = false;
        }

        uint32 timer;
        uint32 despawnTimer;
        bool bUpdatedFlying;
        float VORTEX_RADIUS;

        void PassengerBoarded(Unit* pass, int8  /*seat*/, bool apply)
        {
            if (pass && !apply && pass->GetTypeId() == TYPEID_PLAYER)
            {
                Player* plr = pass->ToPlayer();
                float speed = plr->GetDistance(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()) / (1.0f * 0.001f);
                plr->MonsterMoveWithSpeed(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), speed);
                plr->RemoveAura(SPELL_FREEZE_ANIM);
                plr->SetDisableGravity(false, true);
                plr->SetUInt64Value(PLAYER_FARSIGHT, 0);;
            }
        }

        void UpdateAI(uint32 diff)
        {
            /*      here: if player has some aura that should make him exit vehicle (eg. ice block) -> exit
                    or make it another way (dunno how)                                                          */

            if (despawnTimer <= diff)
            {
                despawnTimer = 0;
                me->UpdatePosition(CenterPos.GetPositionX(), CenterPos.GetPositionY(), CenterPos.GetPositionZ()+18.0f, 0.0f, true);
                me->StopMovingOnCurrentPos();
                me->GetVehicleKit()->RemoveAllPassengers();
                me->DespawnOrUnsummon();
                return;
            }
            else
                despawnTimer -= diff;

            if (timer <= diff)
            {
                float angle = CenterPos.GetAngle(me);
                float newangle = angle+2*M_PI/((float)VORTEX_TRAVEL_TIME/VORTEX_DEFAULT_DIFF);
                if (newangle >= 2*M_PI)
                    newangle -= 2*M_PI;
                float newx = CenterPos.GetPositionX()+VORTEX_RADIUS*cos(newangle);
                float newy = CenterPos.GetPositionY()+VORTEX_RADIUS*sin(newangle);
                float arcangle = me->GetAngle(newx, newy);
                float dist = 2*me->GetDistance2d(newx, newy);
                if (me->GetVehicleKit()) if (Unit* pass = me->GetVehicleKit()->GetPassenger(0)) if (Player* plr = pass->ToPlayer())
                {
                    if (!bUpdatedFlying && timer)
                    {
                        bUpdatedFlying = true;
                        plr->SetDisableGravity(true, true);
                    }

                    plr->SendMonsterMove(me->GetPositionX()+dist*cos(arcangle), me->GetPositionY()+dist*sin(arcangle), me->GetPositionZ(), VORTEX_DEFAULT_DIFF*2, SPLINEFLAG_FLYING);
                    me->Relocate(newx, newy);
                }

                timer = (diff-timer <= VORTEX_DEFAULT_DIFF) ? VORTEX_DEFAULT_DIFF - (diff-timer) : 0;
            }
            else
                timer -= diff;
        }

        void AttackStart(Unit*  /*who*/) {}
        void MoveInLineOfSight(Unit*  /*who*/) {}
        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask) { damage = 0; }
    };
};


class npc_power_spark : public CreatureScript
{
public:
    npc_power_spark() : CreatureScript("npc_power_spark") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_power_sparkAI (pCreature);
    }

    struct npc_power_sparkAI : public NullCreatureAI
    {
        npc_power_sparkAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
            me->CastSpell(me, SPELL_POWER_SPARK_VISUAL, false);
            CheckTimer = 1000;
            MoveTimer = 0;
        }
     
        InstanceScript* pInstance;
        uint16 CheckTimer;
        uint16 MoveTimer;

        void DoAction(int32 param)
        {
            switch(param)
            {
                case 1:
                    MoveTimer = 1;
                    break;
                case 2:
                    MoveTimer = 0;
                    me->GetMotionMaster()->MoveIdle();
                    me->DisableSpline();
                    me->MonsterMoveWithSpeed(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+0.05f, 7.0f);
                    break;
            }
        }

        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask)
        {
            if (damage >= me->GetHealth())
            {
                damage = 0;
                if (!me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                {
                    MoveTimer = 0;
                    me->GetMotionMaster()->MoveIdle();
                    me->DisableSpline();
                    me->MonsterMoveWithSpeed(me->GetPositionX(), me->GetPositionY(), CenterPos.GetPositionZ(), 100.0f);
                    me->SetPosition(me->GetPositionX(), me->GetPositionY(), CenterPos.GetPositionZ(), me->GetOrientation());
                    me->SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
                    me->RemoveAura(SPELL_POWER_SPARK_VISUAL);
                    me->CastSpell(me, SPELL_POWER_SPARK_GROUND_BUFF, true);
                    me->DespawnOrUnsummon(60000);
                }
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                return;

            if (CheckTimer <= diff)
            {
                if (pInstance)
                    if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(DATA_MALYGOS_GUID)))
                        if (me->IsWithinDist3d(c, 12.0f))
                        {
                            me->CastSpell(c, SPELL_POWER_SPARK_MALYGOS_BUFF, true);
                            me->DespawnOrUnsummon();
                            return;
                        }
                CheckTimer = 1000;
            }
            else
                CheckTimer -= diff;

            if (MoveTimer)
            {
                if (MoveTimer <= diff)
                {
                    if (pInstance)
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(DATA_MALYGOS_GUID)))
                            me->GetMotionMaster()->MovePoint(0, *c);
                    MoveTimer = 2000;
                }
                else
                    MoveTimer -= diff;
            }
        }
    };
};


class npc_nexus_lord : public CreatureScript
{
public:
    npc_nexus_lord() : CreatureScript("npc_nexus_lord") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_nexus_lordAI (pCreature);
    }

    struct npc_nexus_lordAI : public ScriptedAI
    {
        npc_nexus_lordAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->SetReactState(REACT_PASSIVE);
            pInstance = me->GetInstanceScript();
            timer = 0;
            events.Reset();
            events.RescheduleEvent(EVENT_TELEPORT_VISUAL, 0);
        }

        InstanceScript* pInstance;
        EventMap events;
        uint16 timer;

        void EnterCombat(Unit*  /*who*/)
        {
            DoZoneInCombat();
            events.Reset();
            events.RescheduleEvent(EVENT_NEXUS_LORD_ARCANE_SHOCK, urand(3000,10000));
            events.RescheduleEvent(EVENT_NEXUS_LORD_HASTE, urand(8000,14000));
        }

        void AttackStart(Unit* victim)
        {
            if (victim && me->Attack(victim, true))
                me->GetMotionMaster()->MoveIdle();
        }

        void UpdateAI(uint32 diff)
        {
            if (UpdateVictim())
                if (Unit* victim = me->GetVictim())
                {
                    if (timer <= diff)
                    {
                        if (!victim->IsWithinMeleeRange(me))
                        {
                            float x,y,z;
                            victim->GetClosePoint(x, y, z, 0.0f, 1.5f, me->GetAngle(victim));
                            if (Unit* v = me->GetVehicleBase())
                                v->GetMotionMaster()->MovePoint(0, x, y ,z);
                        }
                        timer = 1000;
                    }
                    else
                        timer -= diff;
                }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_TELEPORT_VISUAL:
                    me->CastSpell(me, SPELL_TELEPORT_VISUAL, true);
                    events.PopEvent();
                    break;
                case EVENT_NEXUS_LORD_ARCANE_SHOCK:
                    if (Unit* victim = me->GetVictim())
                        me->CastSpell(victim, SPELL_ARCANE_SHOCK);
                    events.RepeatEvent(urand(10000,15000));
                    break;
                case EVENT_NEXUS_LORD_HASTE:
                    me->CastSpell(me, SPELL_HASTE);
                    events.RepeatEvent(urand(20000,30000));
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            if (Vehicle* v = me->GetVehicle())
                v->RemoveAllPassengers();
        }
    };
};


class npc_scion_of_eternity : public CreatureScript
{
public:
    npc_scion_of_eternity() : CreatureScript("npc_scion_of_eternity") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_scion_of_eternityAI (pCreature);
    }

    struct npc_scion_of_eternityAI : public ScriptedAI
    {
        npc_scion_of_eternityAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->SetReactState(REACT_PASSIVE);
            pInstance = me->GetInstanceScript();
            events.Reset();
            events.RescheduleEvent(EVENT_TELEPORT_VISUAL, 0);
            events.RescheduleEvent(EVENT_SCION_OF_ETERNITY_ARCANE_BARRAGE, urand(20000,25000));
        }

        InstanceScript* pInstance;
        EventMap events;

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_TELEPORT_VISUAL:
                    me->CastSpell(me, SPELL_TELEPORT_VISUAL, true);
                    events.PopEvent();
                    break;
                case EVENT_SCION_OF_ETERNITY_ARCANE_BARRAGE:
                    {
                        std::vector<uint64> guids;
                        Map::PlayerList const &PlayerList = me->GetMap()->GetPlayers();
                        if (!PlayerList.isEmpty())
                            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                if (Player *pPlayer = i->GetSource())
                                {
                                    if (!pPlayer->IsAlive() || pPlayer->IsGameMaster())
                                        continue;
                                    guids.push_back(pPlayer->GetGUID());
                                }
                        if (!guids.empty())
                            if (Player* plr = ObjectAccessor::GetPlayer(*me, guids.at(urand(0, guids.size()-1))))
                                me->CastSpell(plr, SPELL_SCION_ARCANE_BARRAGE);

                        events.RepeatEvent(urand(5000,8000));
                    }
                    break;
            }
        }

        void JustDied(Unit* killer)
        {
            if (Vehicle* v = me->GetVehicle())
                v->RemoveAllPassengers();

            if (Player* player = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
                player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GET_KILLING_BLOWS, 1, 0, me);
        }

        void MoveInLineOfSight(Unit*  /*who*/) {}
        void AttackStart(Unit*  /*who*/) {}
    };
};


class npc_hover_disk : public CreatureScript
{
public:
    npc_hover_disk() : CreatureScript("npc_hover_disk") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_hover_diskAI (pCreature);
    }

    struct npc_hover_diskAI : public VehicleAI
    {
        npc_hover_diskAI(Creature* pCreature) : VehicleAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
            events.Reset();
        }

        InstanceScript* pInstance;
        EventMap events;

        void PassengerBoarded(Unit *who, int8  /*seat*/, bool apply)
        {
            events.Reset();
            if (!who)
                return;
            if (apply)
            {
                if (who->GetTypeId() == TYPEID_PLAYER)
                {
                    who->ApplySpellImmune(0, IMMUNITY_ID, SPELL_ARCANE_OVERLOAD_DMG, true);
                    who->ApplySpellImmune(0, IMMUNITY_ID, SPELL_SURGE_OF_POWER_DMG, true);
                    me->SetSpeed(MOVE_RUN, 1.5f);
                    me->SetSpeed(MOVE_FLIGHT, 1.5f);
                }
                else if (who->GetEntry() == NPC_NEXUS_LORD)
                {
                    me->SetSpeed(MOVE_RUN, 1.5f);
                    me->SetSpeed(MOVE_FLIGHT, 1.5f);
                }
                else
                {
                    me->SetSpeed(MOVE_RUN, 0.6f);
                    me->SetSpeed(MOVE_FLIGHT, 0.6f);
                }

                who->SetFacingTo(me->GetOrientation());
                me->SetCanFly(true);
            }
            else
            {
                me->GetMotionMaster()->MoveIdle();
                me->DisableSpline();
                me->SetCanFly(false);
                me->GetMotionMaster()->MoveLand(0, me->GetPositionX(), me->GetPositionY(), 267.24f, 10.0f);

                if (who->GetTypeId() == TYPEID_PLAYER)
                {
                    who->ApplySpellImmune(0, IMMUNITY_ID, SPELL_ARCANE_OVERLOAD_DMG, false);
                    who->ApplySpellImmune(0, IMMUNITY_ID, SPELL_SURGE_OF_POWER_DMG, false);
                }
            }
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type != POINT_MOTION_TYPE)
                return;

            switch (id)
            {
                case MI_POINT_SCION:
                    events.RescheduleEvent(EVENT_DISK_MOVE_NEXT_POINT, 0);
                    break;
                case MI_POINT_NEXUS_LORD:
                    if (me->GetPositionZ() > CenterPos.GetPositionZ()+2.0f)
                        events.RescheduleEvent(EVENT_DISK_MOVE_NEXT_POINT, 0);
                    else
                        if (Vehicle* v = me->GetVehicleKit())
                            if (Unit* pass = v->GetPassenger(0))
                                if (Creature* c = pass->ToCreature())
                                {
                                    c->SetReactState(REACT_AGGRESSIVE);
                                    if (Player* plr = c->SelectNearestPlayer(100.0f))
                                        c->AI()->AttackStart(plr);
                                }
                    break;
            }
        }

        void DoAction(int32 param)
        {
            switch(param)
            {
                case 1: // move to next point
                    if (Vehicle* v = me->GetVehicleKit())
                        if (Unit* pass = v->GetPassenger(0))
                            switch(pass->GetEntry())
                            {
                                case NPC_NEXUS_LORD:
                                    {
                                        float angle = CenterPos.GetAngle(me);
                                        float newangle = angle - 0.5f;
                                        if (newangle < 0.0f) newangle += 2*M_PI;
                                        float newz = me->GetPositionZ()-4.0f;
                                        if (newz<CenterPos.GetPositionZ()) newz = CenterPos.GetPositionZ();
                                        me->GetMotionMaster()->MovePoint(MI_POINT_NEXUS_LORD, CenterPos.GetPositionX()+cos(newangle)*22.0f, CenterPos.GetPositionY()+sin(newangle)*22.0f, newz);
                                    }
                                    break;
                                case NPC_SCION_OF_ETERNITY:
                                    {
                                        float angle = CenterPos.GetAngle(me);
                                        float newangle = angle - 0.3f;
                                        if (newangle < 0.0f) newangle += 2*M_PI;
                                        float newz = me->GetPositionZ()-2.0f;
                                        if (newz<CenterPos.GetPositionZ()+20.0f) newz = CenterPos.GetPositionZ()+20.0f;
                                        me->GetMotionMaster()->MovePoint(MI_POINT_SCION, CenterPos.GetPositionX()+cos(newangle)*30.0f, CenterPos.GetPositionY()+sin(newangle)*30.0f, newz);
                                    }
                                    break;
                            }
                    break;
            }
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);

            switch(events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_DISK_MOVE_NEXT_POINT:
                    DoAction(1);
                    events.PopEvent();
                    break;
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) {}
        void AttackStart(Unit*  /*who*/) {}
    };
};


class npc_alexstrasza : public CreatureScript
{
public:
    npc_alexstrasza() : CreatureScript("npc_alexstrasza") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_alexstraszaAI (pCreature);
    }

    struct npc_alexstraszaAI : public ScriptedAI
    {
        npc_alexstraszaAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            events.Reset();
            events.ScheduleEvent(1, 9000);
            me->SetCanFly(true);
            me->SetDisableGravity(true);
            me->SetHover(true);
        }

        EventMap events;

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);
            switch(events.GetEvent())
            {
                case 0:
                    break;
                case 1:
                    me->CastSpell(773.98f, 1285.97f, 266.254f, SPELL_ALEXSTRASZA_GIFT, true);
                    me->SummonGameObject(ALEXSTRASZA_GIFT, 773.98f, 1285.97f, 266.254f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0);
                    me->SummonGameObject(HEART_OF_MAGIC, 773.98f, 1275.97f, 266.254f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0);

                    me->PlayDirectSound(14406);
                    me->MonsterYell("I did what I had to, brother. You gave me no alternative.", LANG_UNIVERSAL, 0);
                    events.PopEvent();
                    events.RescheduleEvent(2, 6000);
                    break;
                case 2:
                    me->PlayDirectSound(14407);
                    me->MonsterYell("And so ends the Nexus War.", LANG_UNIVERSAL, 0);
                    events.PopEvent();
                    events.RescheduleEvent(3, 5000);
                    break;
                case 3:
                    me->PlayDirectSound(14408);
                    me->MonsterYell("This resolution pains me deeply, but the destruction, the monumental loss of life had to end. Regardless of Malygos\' recent transgressions, I will mourn his loss. He was once a guardian, a protector. This day, one of the world\'s mightiest has fallen.", LANG_UNIVERSAL, 0);
                    events.PopEvent();
                    events.RescheduleEvent(4, 22000);
                    break;
                case 4:
                    me->PlayDirectSound(14409);
                    me->MonsterYell("The red dragonflight will take on the burden of mending the devastation wrought on Azeroth. Return home to your people and rest. Tomorrow will bring you new challenges, and you must be ready to face them. Life... goes on.", LANG_UNIVERSAL, 0);
                    events.PopEvent();
                    break;
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) {}
        void AttackStart(Unit*  /*who*/) {}
    };
};


class npc_eoe_wyrmrest_skytalon : public CreatureScript
{
public:
    npc_eoe_wyrmrest_skytalon() : CreatureScript("npc_eoe_wyrmrest_skytalon") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_eoe_wyrmrest_skytalonAI (pCreature);
    }

    struct npc_eoe_wyrmrest_skytalonAI : public VehicleAI
    {
        npc_eoe_wyrmrest_skytalonAI(Creature* pCreature) : VehicleAI(pCreature) { }

        void PassengerBoarded(Unit* pass, int8  /*seat*/, bool apply)
        {
            if (apply)
            {
                me->SetDisableGravity(false);
                me->SendMovementFlagUpdate();
            }
            else if (pass && pass->GetTypeId() == TYPEID_PLAYER && me->IsAlive())
            {
                me->SetDisplayId(11686); // prevents nasty falling animation at despawn
                me->DespawnOrUnsummon(1);
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            me->SetDisplayId(11686); // prevents nasty falling animation at despawn
            me->DespawnOrUnsummon(1);
        }
    };
};


class go_the_focusing_iris : public GameObjectScript
{ 
public: 
    go_the_focusing_iris() : GameObjectScript("go_the_focusing_iris") { }

    bool OnGossipHello(Player* user, GameObject* go)
    {
        if (!user || !go)
            return true;
        
        if (InstanceScript* pInstance = go->GetInstanceScript())
            pInstance->SetData(DATA_IRIS_ACTIVATED, 0);

        return true;
    }
};


class spell_eoe_ph3_surge_of_power : public SpellScriptLoader
{
    public:
        spell_eoe_ph3_surge_of_power() : SpellScriptLoader("spell_eoe_ph3_surge_of_power") { }

        class spell_eoe_ph3_surge_of_power_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_eoe_ph3_surge_of_power_SpellScript);

            uint64 DrakeGUID[3];

            bool Load()
            {
                memset(&DrakeGUID, 0, sizeof(DrakeGUID));
                if (Unit* caster = GetCaster())
                    if (Creature* c = caster->ToCreature())
                    {
                        uint8 i=0;
                        std::list<Unit*> drakes;
                        c->AI()->SelectTargetList(drakes, (c->GetMap()->GetSpawnMode() == 0 ? 1 : 3), SELECT_TARGET_RANDOM, 0.0f, false, 57403 /*only drakes have this aura*/);
                        for (std::list<Unit*>::iterator itr = drakes.begin(); itr != drakes.end() && i < 3; ++itr)
                        {
                            DrakeGUID[i++] = (*itr)->GetGUID();
                            if (Vehicle* v = (*itr)->GetVehicleKit())
                                if (Unit* p = v->GetPassenger(0))
                                    if (Player* plr = p->ToPlayer())
                                    {
                                        WorldPacket data;
                                        ChatHandler::BuildChatPacket(data, CHAT_MSG_RAID_BOSS_EMOTE, LANG_UNIVERSAL, caster, p, "Malygos fixes his eyes on you!");
                                        plr->GetSession()->SendPacket(&data);
                                    }
                        }
                    }

                return true;
            }

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                if (Unit* caster = GetCaster())
                {
                    targets.clear();
                    for (uint8 i=0; i<3; ++i)
                        if (DrakeGUID[i])
                            if (Unit* u = ObjectAccessor::GetUnit(*caster, DrakeGUID[i]))
                                targets.push_back(u);
                }
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_eoe_ph3_surge_of_power_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_eoe_ph3_surge_of_power_SpellScript();
        }
};


void AddSC_boss_malygos()
{
    new boss_malygos();
    new npc_power_spark();
    new npc_vortex_ride();
    new npc_alexstrasza();
    new go_the_focusing_iris();
    new npc_nexus_lord();
    new npc_scion_of_eternity();
    new npc_hover_disk();
    new npc_eoe_wyrmrest_skytalon();

    new spell_eoe_ph3_surge_of_power();
}