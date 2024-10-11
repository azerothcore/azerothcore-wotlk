/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CombatAI.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "MoveSplineInit.h"
#include "Opcodes.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "eye_of_eternity.h"

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

enum Texts
{
    SAY_INTRO = 0,
    SAY_PHASE_1,
    SAY_DEEP_BREATH,
    SAY_SLAY_P1,
    SAY_END_P1,
    SAY_PHASE_2,
    SAY_ANTIMAGIC_SHELL,
    SAY_MAGIC_BLAST,
    SAY_SLAY_P2,
    SAY_END_P2,
    SAY_INTRO_PHASE_3,
    SAY_PHASE_3,
    EMOTE_SURGE_OF_POWER_WARNING_P2,
    SAY_SURGE_OF_POWER,
    SAY_BUFFED_BY_SPARK,
    SAY_SLAY_P3,
    SAY_SPELL_CASTING_P3,
    SAY_DEATH,
    EMOTE_SURGE_OF_POWER_WARNING_P3,
    EMOTE_BERSERK,

    EMOTE_POWER_SPARK     = 0,

    SAY_ALEXSTRASZA_ONE   = 0,
    SAY_ALEXSTRASZA_TWO   = 1,
    SAY_ALEXSTRASZA_THREE = 2,
    SAY_ALEXSTRASZA_FOUR  = 3,
};

enum Phases
{
    PHASE_NONE = 0,
    PHASE_ONE,
    PHASE_TWO,
    PHASE_THREE
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetEyeOfEternityAI<boss_malygosAI>(pCreature);
    }

    struct boss_malygosAI : public ScriptedAI
    {
        boss_malygosAI(Creature* c) : ScriptedAI(c), summons(me)
        {
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;

        uint32 timer1, timer2;
        uint8 IntroCounter;
        bool bLockHealthCheck;

        void InitializeAI() override
        {
            me->SetDisableGravity(true);
            Reset();
        }

        void Reset() override
        {
            events.Reset();
            events.SetPhase(PHASE_NONE);
            summons.DespawnAll();

            timer1 = MalygosIntroIntervals[4];
            timer2 = INTRO_MOVEMENT_INTERVAL;
            IntroCounter = 0;
            bLockHealthCheck = false;

            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_PACIFIED);
            me->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE);

            if (pInstance)
            {
                pInstance->SetData(DATA_ENCOUNTER_STATUS, NOT_STARTED);
                pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_YOU_DONT_HAVE_AN_ENTERNITY_EVENT);
            }
        }

        void MovementInform(uint32 type, uint32 id) override
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
                            if (Creature* c = me->SummonCreature(NPC_PORTAL, me->GetPositionX() + cos(angle) * dist, me->GetPositionY() + std::sin(angle) * dist, me->GetPositionZ(), FourSidesPos[id].GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 13000))
                                me->CastSpell(c, SPELL_PORTAL_BEAM, false);
                            timer2 = INTRO_MOVEMENT_INTERVAL - 10000;
                        }
                        break;

                    case MI_POINT_INTRO_CENTER_AIR:
                        events.RescheduleEvent(EVENT_INTRO_LAND, 0ms, 1);
                        break;
                    case MI_POINT_VORTEX_CENTER:
                        if (Creature* c = me->SummonCreature(NPC_WORLD_TRIGGER_LAOI, CenterPos, TEMPSUMMON_TIMED_DESPAWN, 15000))
                            c->CastSpell(c, SPELL_VORTEX_VISUAL, true);
                        events.RescheduleEvent(EVENT_START_VORTEX_REAL, 1s, 1);
                        break;
                    case MI_POINT_CENTER_GROUND_PH_2:
                        events.RescheduleEvent(EVENT_START_PHASE_2_FLY_UP, 0ms, 1);
                        break;
                    case MI_POINT_CIRCLE_OUTSIDE_PH_2:
                        events.RescheduleEvent(EVENT_RESUME_FLYING_CIRCLES_PH_2, 0ms, 1);
                        break;
                    case MI_POINT_SURGE_OF_POWER_CENTER:
                        events.RescheduleEvent(EVENT_SURGE_OF_POWER_WARNING, 0ms, 1);
                        break;
                }
            }
            else if (type == EFFECT_MOTION_TYPE)
            {
                switch (id)
                {
                    case MI_POINT_INTRO_LAND:
                        me->SetDisableGravity(false);
                        events.RescheduleEvent(EVENT_START_FIGHT, 0ms, 1);
                        break;
                    case MI_POINT_VORTEX_TAKEOFF:
                        events.RescheduleEvent(EVENT_VORTEX_FLY_TO_CENTER, 0ms, 1);
                        break;
                    case MI_POINT_VORTEX_LAND:
                        me->SetDisableGravity(false);
                        events.RescheduleEvent(EVENT_VORTEX_LAND_1, 0ms, 1);
                        break;
                    case MI_POINT_CENTER_AIR_PH_2:
                        me->GetMap()->SetZoneOverrideLight(AREA_EYE_OF_ETERNITY, LIGHT_ARCANE_RUNES, 5s);
                        break;
                    case MI_POINT_PH_3_FIGHT_POSITION:
                        events.RescheduleEvent(EVENT_START_PHASE_3, 6s, 1);
                        break;
                }
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_POWER_SPARK_MALYGOS_BUFF)
            {
                if (!bLockHealthCheck)
                {
                    Talk(SAY_BUFFED_BY_SPARK);
                }
                else
                    me->RemoveAura(SPELL_POWER_SPARK_MALYGOS_BUFF);
            }
        }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            events.Reset();
            DoZoneInCombat();

            Talk(SAY_PHASE_1);

            events.RescheduleEvent(EVENT_INTRO_MOVE_CENTER, 0ms, 1);
            if (pInstance)
                pInstance->SetData(DATA_ENCOUNTER_STATUS, IN_PROGRESS);
        }

        void AttackStart(Unit* victim) override
        {
            if (!victim)
                return;

            if (me->GetVictim() && me->GetVictim()->GetGUID() == victim->GetGUID() && !me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_PACIFIED))
            {
                if (!me->GetGuidValue(UNIT_FIELD_TARGET))
                    me->SetTarget(victim->GetGUID());
            }
            else if (me->Attack(victim, true))
            {
                if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_PACIFIED))
                    me->GetMotionMaster()->MoveChase(victim);
                else
                    me->SetTarget();
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth() && !me->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE)) // allow dying only in phase 3!
            {
                damage = 0;
                return;
            }

            if (!bLockHealthCheck && me->HealthBelowPctDamaged(50, damage))
            {
                bLockHealthCheck = true;
                events.RescheduleEvent(EVENT_START_PHASE_2, 0ms, 1);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            HandleIntroSpeech(diff);

            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_BERSERK:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    Talk(EMOTE_BERSERK);

                    break;
                case EVENT_INTRO_MOVE_CENTER:
                    {
                        if (pInstance)
                            pInstance->SetData(DATA_SET_IRIS_INACTIVE, 0);
                        summons.DespawnAll();
                        me->InterruptNonMeleeSpells(true);
                        me->RemoveAllAuras();
                        float angle = CenterPos.GetAngle(me);
                        float x = CenterPos.GetPositionX() + cos(angle) * 35.0f;
                        float y = CenterPos.GetPositionY() + std::sin(angle) * 35.0f;
                        float z = FourSidesPos[0].GetPositionZ();
                        me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        me->GetMotionMaster()->MovePoint(MI_POINT_INTRO_CENTER_AIR, x, y, z);
                        break;
                    }
                case EVENT_INTRO_LAND:
                    {
                        me->GetMotionMaster()->MoveLand(MI_POINT_INTRO_LAND, me->GetPositionX(), me->GetPositionY(), CenterPos.GetPositionZ(), 7.0f);
                        break;
                    }
                case EVENT_START_FIGHT:
                    {
                        if (pInstance)
                        {
                            pInstance->SetData(DATA_HIDE_IRIS_AND_PORTAL, 0);
                            pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_YOU_DONT_HAVE_AN_ENTERNITY_EVENT);
                        }
                        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_PACIFIED);
                        if (Unit* target = me->SelectNearestTarget(250.0f))
                        {
                            AttackStart(target);
                            me->GetMotionMaster()->MoveChase(target);
                        }

                        events.SetPhase(PHASE_ONE);
                        events.RescheduleEvent(EVENT_BERSERK, 10min, 0);
                        events.RescheduleEvent(EVENT_SPELL_ARCANE_BREATH, 9s, 12s, 1);
                        events.RescheduleEvent(EVENT_SPELL_ARCANE_STORM, 2s, 5s, 1);
                        events.RescheduleEvent(EVENT_SUMMON_POWER_SPARK, 10s, 15s, 1);
                        events.RescheduleEvent(EVENT_START_VORTEX_0, 30s, 1);
                        break;
                    }
                case EVENT_SPELL_ARCANE_BREATH:
                    me->CastSpell(me->GetVictim(), SPELL_ARCANE_BREATH, false);
                    events.Repeat(12s, 15s);
                    break;
                case EVENT_SPELL_ARCANE_STORM:
                    me->CastCustomSpell(SPELL_ARCANE_STORM, SPELLVALUE_MAX_TARGETS, DUNGEON_MODE(5, 12), me, true);
                    events.Repeat(10s, 15s);
                    break;
                case EVENT_SUMMON_POWER_SPARK:
                    {
                        uint8 random = urand(0, 3);
                        if (Creature* c = me->SummonCreature(NPC_PORTAL, FourSidesPos[random], TEMPSUMMON_TIMED_DESPAWN, 6000))
                            c->CastSpell(c, SPELL_PORTAL_BEAM, false);
                        if (Creature* c = me->SummonCreature(NPC_POWER_SPARK, FourSidesPos[random], TEMPSUMMON_MANUAL_DESPAWN, 0))
                        {
                            c->AI()->DoAction(1);
                            c->AI()->Talk(EMOTE_POWER_SPARK);
                        }

                        events.Repeat(20s, 30s);
                    }
                    break;
                case EVENT_START_VORTEX_0:
                    {
                        bLockHealthCheck = true;
                        Talk(SAY_MAGIC_BLAST);
                        EntryCheckPredicate pred(NPC_POWER_SPARK);
                        summons.DoAction(2, pred); // stop following
                        me->SetUnitFlag(UNIT_FLAG_PACIFIED);

                        me->SendMeleeAttackStop(me->GetVictim());
                        me->SetTarget();

                        me->GetMotionMaster()->MoveIdle();
                        me->StopMoving();
                        me->SetDisableGravity(true);
                        me->GetMotionMaster()->MoveTakeoff(MI_POINT_VORTEX_TAKEOFF, me->GetPositionX(), me->GetPositionY(), CenterPos.GetPositionZ() + 20.0f, 7.0f);

                        events.DelayEvents(25000, 1); // don't delay berserk (group 0)
                    }
                    break;
                case EVENT_VORTEX_FLY_TO_CENTER:
                    me->GetMotionMaster()->MovePoint(MI_POINT_VORTEX_CENTER, CenterPos.GetPositionX(), CenterPos.GetPositionY(), CenterPos.GetPositionZ() + 20.0f);
                    break;
                case EVENT_START_VORTEX_REAL:
                    {
                        me->SendMeleeAttackStop(me->GetVictim());
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_CUSTOM_SPELL_01);
                        me->HandleEmoteCommand(EMOTE_STATE_CUSTOM_SPELL_01);

                        Position pos;
                        float angle = (me->GetOrientation() >= M_PI / 4 ? me->GetOrientation() - M_PI / 4 : 7 * M_PI / 4 + me->GetOrientation());
                        pos.m_positionX = CenterPos.GetPositionX() + cos(angle) * 40.0f;
                        pos.m_positionY = CenterPos.GetPositionY() + std::sin(angle) * 40.0f;
                        pos.m_positionZ = CenterPos.GetPositionZ() + 20.0f;
                        pos.SetOrientation(pos.GetAngle(&CenterPos));

                        if (Creature* vp = me->SummonCreature(NPC_WORLD_TRIGGER_LAOI, pos, TEMPSUMMON_TIMED_DESPAWN, 14000))
                        {
                            vp->SetDisableGravity(true);

                            Map::PlayerList const& PlayerList = me->GetMap()->GetPlayers();
                            if (!PlayerList.IsEmpty())
                                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                    if (Player* pPlayer = i->GetSource())
                                    {
                                        if (!pPlayer->IsAlive() || pPlayer->IsGameMaster())
                                            continue;

                                        Position plrpos;
                                        float playerAngle = CenterPos.GetAngle(pPlayer);
                                        plrpos.m_positionX = CenterPos.GetPositionX() + cos(playerAngle) * 5.0f;
                                        plrpos.m_positionY = CenterPos.GetPositionY() + std::sin(playerAngle) * 5.0f;
                                        plrpos.m_positionZ = CenterPos.GetPositionZ() + 18.0f;
                                        plrpos.SetOrientation(plrpos.GetAngle(&CenterPos));

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

                                            sScriptMgr->AnticheatSetCanFlybyServer(pPlayer, true);

                                            WorldPacket data(SMSG_SPLINE_MOVE_UNROOT, 8);
                                            data << pPlayer->GetPackGUID();
                                            pPlayer->SendMessageToSet(&data, true);

                                            sScriptMgr->AnticheatSetUnderACKmount(pPlayer);

                                            pPlayer->SetGuidValue(PLAYER_FARSIGHT, vp->GetGUID());
                                            c->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                                        }
                                    }
                        }

                        events.RescheduleEvent(EVENT_VORTEX_LAND_0, 11s, 1);
                        break;
                    }
                case EVENT_VORTEX_LAND_0:
                    me->GetMotionMaster()->MoveLand(MI_POINT_VORTEX_LAND, CenterPos, 7.0f);

                    break;
                case EVENT_VORTEX_LAND_1:
                    {
                        bLockHealthCheck = false;
                        EntryCheckPredicate pred(NPC_POWER_SPARK);
                        summons.DoAction(1, pred); // resume following
                        me->RemoveUnitFlag(UNIT_FLAG_PACIFIED);
                        if (Unit* target = me->GetVictim())
                        {
                            AttackStart(target);
                            me->GetMotionMaster()->MoveChase(target);
                        }
                        events.RescheduleEvent(EVENT_START_VORTEX_0, 60s, 1);
                        break;
                    }
                case EVENT_START_PHASE_2:
                    events.SetPhase(PHASE_TWO);
                    Talk(SAY_END_P1);
                    me->SetUnitFlag(UNIT_FLAG_PACIFIED);
                    me->SendMeleeAttackStop();
                    me->SetTarget();
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
                        me->SetDisableGravity(true);
                        me->GetMotionMaster()->MoveTakeoff(MI_POINT_CENTER_AIR_PH_2, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 32.0f, 7.0f);
                        events.RescheduleEvent(EVENT_START_PHASE_2_MOVE_TO_SIDE, 22s + 500ms, 1);
                        break;
                    }
                case EVENT_START_PHASE_2_MOVE_TO_SIDE:
                    Talk(SAY_PHASE_2);
                    me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_PACIFIED);
                    me->GetMotionMaster()->MovePoint(MI_POINT_CIRCLE_OUTSIDE_PH_2, Phase2NorthPos);
                    events.RescheduleEvent(EVENT_SPELL_ARCANE_STORM, 12s, 15s, 1);
                    events.RescheduleEvent(EVENT_SPELL_ARCANE_OVERLOAD, 8s, 1);
                    events.RescheduleEvent(EVENT_MOVE_TO_SURGE_OF_POWER, 55s, 1);
                    events.RescheduleEvent(EVENT_CHECK_TRASH_DEAD, 3s, 1);

                    for (int i = 0; i < MAX_NEXUS_LORDS; i++)
                    {
                        float dist = 22.0f;
                        float angle = M_PI / 2 + ((float)i / MAX_NEXUS_LORDS) * 2 * M_PI;
                        if (Creature* disk = me->SummonCreature(NPC_HOVER_DISK, CenterPos.GetPositionX() + cos(angle) * dist, CenterPos.GetPositionY() + std::sin(angle) * dist, CenterPos.GetPositionZ() + 30.0f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN, 0))
                            if (Creature* c = me->SummonCreature(NPC_NEXUS_LORD, *disk, TEMPSUMMON_MANUAL_DESPAWN, 0))
                            {
                                c->EnterVehicle(disk, 0);
                                disk->AI()->DoAction(1); // start moving
                            }
                    }
                    for (int i = 0; i < MAX_SCIONS_OF_ETERNITY; i++)
                    {
                        float dist = 30.0f;
                        float angle = 0.0f + ((float)i / MAX_SCIONS_OF_ETERNITY) * 2 * M_PI;
                        if (Creature* disk = me->SummonCreature(NPC_HOVER_DISK, CenterPos.GetPositionX() + cos(angle) * dist, CenterPos.GetPositionY() + std::sin(angle) * dist, CenterPos.GetPositionZ() + 30.0f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN, 0))
                            if (Creature* c = me->SummonCreature(NPC_SCION_OF_ETERNITY, *disk, TEMPSUMMON_MANUAL_DESPAWN, 0))
                            {
                                c->EnterVehicle(disk, 0);
                                disk->AI()->DoAction(1); // start moving
                            }
                    }

                    break;
                case EVENT_SPELL_ARCANE_OVERLOAD:
                    {
                        me->GetMotionMaster()->MoveIdle();
                        me->StopMoving();
                        float dist = urand(5, 30);
                        float angle = rand_norm() * 2 * M_PI;
                        float posx = CenterPos.GetPositionX() + cos(angle) * dist;
                        float posy = CenterPos.GetPositionY() + std::sin(angle) * dist;
                        me->SetFacingTo(me->GetAngle(posx, posy));
                        me->CastSpell(posx, posy, CenterPos.GetPositionZ() + 1.5f, SPELL_ARCANE_OVERLOAD, true);
                        events.Repeat(15s);
                        events.RescheduleEvent(EVENT_RESUME_FLYING_CIRCLES_PH_2, 3s, 1);
                    }
                    break;
                case EVENT_RESUME_FLYING_CIRCLES_PH_2:
                    {
                        float angle = CenterPos.GetAngle(me);
                        float dist = Phase2NorthPos.GetExactDist2d(&CenterPos);
                        float newangle = angle + 0.5f;
                        if (newangle >= 2 * M_PI) newangle -= 2 * M_PI;
                        me->GetMotionMaster()->MovePoint(MI_POINT_CIRCLE_OUTSIDE_PH_2, CenterPos.GetPositionX() + cos(newangle)*dist, CenterPos.GetPositionY() + std::sin(newangle)*dist, Phase2NorthPos.GetPositionZ());
                    }
                    break;
                case EVENT_MOVE_TO_SURGE_OF_POWER:
                    {
                        Talk(SAY_DEEP_BREATH);
                        float angle = CenterPos.GetAngle(me);
                        me->GetMotionMaster()->MoveIdle();
                        me->StopMoving();
                        me->GetMotionMaster()->MovePoint(MI_POINT_SURGE_OF_POWER_CENTER, CenterPos.GetPositionX() + cos(angle) * 10.0f, CenterPos.GetPositionY() + std::sin(angle) * 10.0f, Phase2NorthPos.GetPositionZ());
                        events.CancelEventGroup(1); // everything beside berserk
                    }
                    break;
                case EVENT_SURGE_OF_POWER_WARNING:
                    Talk(EMOTE_SURGE_OF_POWER_WARNING_P2);
                    events.RescheduleEvent(EVENT_SPELL_SURGE_OF_POWER, 1500ms, 1);
                    break;
                case EVENT_SPELL_SURGE_OF_POWER:
                    if (Creature* c = me->SummonCreature(NPC_SURGE_OF_POWER, CenterPos, TEMPSUMMON_TIMED_DESPAWN, 10000))
                        me->CastSpell(c, SPELL_SURGE_OF_POWER, false);
                    Talk(SAY_SURGE_OF_POWER);
                    events.RescheduleEvent(EVENT_CLEAR_TARGET, 10s, 1);
                    events.RescheduleEvent(EVENT_RESUME_FLYING_CIRCLES_PH_2, 10s, 1);
                    events.RescheduleEvent(EVENT_SPELL_ARCANE_STORM, 17s, 25s, 1);
                    events.RescheduleEvent(EVENT_SPELL_ARCANE_OVERLOAD, 16s, 1);
                    events.RescheduleEvent(EVENT_MOVE_TO_SURGE_OF_POWER, 65s, 1);
                    events.RescheduleEvent(EVENT_CHECK_TRASH_DEAD, 3s, 1);
                    break;
                case EVENT_CLEAR_TARGET:
                    me->SendMeleeAttackStop();
                    me->SetTarget();
                    break;
                case EVENT_CHECK_TRASH_DEAD:
                    {
                        if (me->FindNearestCreature(NPC_SCION_OF_ETERNITY, 250.0f, true) || me->FindNearestCreature(NPC_NEXUS_LORD, 250.0f, true))
                            events.RepeatEvent(3000);
                        else
                        {
                            me->SendMeleeAttackStop();
                            me->SetTarget();
                            events.CancelEventGroup(1);
                            summons.DespawnAll();
                            // start phase 3
                            Talk(SAY_END_P2);
                            me->GetMotionMaster()->Clear();
                            me->GetMotionMaster()->MoveIdle();
                            me->StopMoving();
                            me->GetMotionMaster()->MovePoint(MI_POINT_START_PH_3, CenterPos.GetPositionX(), CenterPos.GetPositionY(), CenterPos.GetPositionZ() + 70.0f);
                            events.RescheduleEvent(EVENT_LIGHT_DIMENSION_CHANGE, 1s, 1);
                            events.RescheduleEvent(EVENT_DESTROY_PLATFORM_0, 10s, 1);
                        }
                    }
                    break;
                case EVENT_LIGHT_DIMENSION_CHANGE:
                    me->GetMap()->SetZoneOverrideLight(AREA_EYE_OF_ETERNITY, LIGHT_CHANGE_DIMENSIONS, 2s);
                    break;
                case EVENT_DESTROY_PLATFORM_0:
                    if (Creature* c = me->SummonCreature(NPC_WORLD_TRIGGER_LAOI, CenterPos, TEMPSUMMON_TIMED_DESPAWN, 3000))
                    {
                        c->SetFaction(me->GetFaction());
                        c->CastSpell(c, SPELL_DESTROY_PLATFORM_VISUAL, true);
                        c->CastSpell(c, SPELL_DESTROY_PLATFORM_EFFECT, false);
                    }
                    me->GetMap()->SetZoneOverrideLight(AREA_EYE_OF_ETERNITY, LIGHT_OBSCURE_SPACE, 1s);
                    events.RescheduleEvent(EVENT_MOVE_TO_PHASE_3_POSITION, 2s, 1);
                    break;
                case EVENT_MOVE_TO_PHASE_3_POSITION:
                    {
                        me->SendMeleeAttackStop(me->GetVictim());
                        me->GetMotionMaster()->MoveTakeoff(MI_POINT_PH_3_FIGHT_POSITION, CenterPos.GetPositionX(), CenterPos.GetPositionY(), CenterPos.GetPositionZ() - 5.0f, me->GetSpeed(MOVE_RUN));

                        me->GetThreatMgr().ClearAllThreat(); // players on vehicle are unattackable -> leads to EnterEvadeMode() because target is not acceptable!

                        // mount players:
                        Map::PlayerList const& PlayerList = me->GetMap()->GetPlayers();
                        if (!PlayerList.IsEmpty())
                            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                if (Player* pPlayer = i->GetSource())
                                {
                                    sScriptMgr->AnticheatSetUnderACKmount(pPlayer);

                                    if (!pPlayer->IsAlive() || pPlayer->IsGameMaster())
                                        continue;

                                    if (Creature* c = me->SummonCreature(NPC_WYRMREST_SKYTALON, pPlayer->GetPositionX(), pPlayer->GetPositionY(), pPlayer->GetPositionZ() - 20.0f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN, 0))
                                    {
                                        c->SetFaction(pPlayer->GetFaction());
                                        //pPlayer->CastCustomSpell(60683, SPELLVALUE_BASE_POINT0, 1, c, true);
                                        c->m_Events.AddEvent(new EoEDrakeEnterVehicleEvent(*c, pPlayer->GetGUID()), c->m_Events.CalculateTime(500));
                                        AttackStart(c);
                                    }
                                }

                        events.RescheduleEvent(EVENT_SAY_PHASE_3_INTRO, 3s, 1);
                    }
                    break;
                case EVENT_SAY_PHASE_3_INTRO:
                    Talk(SAY_INTRO_PHASE_3);
                    break;
                case EVENT_START_PHASE_3:
                    events.SetPhase(PHASE_THREE);
                    me->GetMap()->SetZoneOverrideLight(AREA_EYE_OF_ETERNITY, LIGHT_OBSCURE_ARCANE_RUNES, 1s);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->SetUnitFlag(UNIT_FLAG_PACIFIED | UNIT_FLAG_DISABLE_MOVE);
                    if (Unit* target = me->GetVictim())
                        AttackStart(target);
                    events.RescheduleEvent(EVENT_SPELL_ARCANE_PULSE, 0ms, 1);
                    events.RescheduleEvent(EVENT_SPELL_STATIC_FIELD, 1s, 4s, 1);
                    events.RescheduleEvent(EVENT_SPELL_PH3_SURGE_OF_POWER, 4s, 7s, 1);
                    events.RescheduleEvent(EVENT_SPELL_ARCANE_STORM, 12s, 15s, 1);
                    break;
                case EVENT_SPELL_ARCANE_PULSE:
                    me->CastSpell(me, SPELL_ARCANE_PULSE, true);
                    events.Repeat(3s);
                    break;
                case EVENT_SPELL_STATIC_FIELD:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 200.0f, false))
                    {
                        me->SetFacingToObject(target);
                        me->CastSpell(target, SPELL_STATIC_FIELD_MAIN, true);
                    }
                    events.Repeat(12s);
                    break;
                case EVENT_SPELL_PH3_SURGE_OF_POWER:
                    me->CastSpell((Unit*)nullptr, SPELL_PH3_SURGE_OF_POWER, false);
                    events.Repeat(7s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (pInstance)
            {
                pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, NPC_MALYGOS, 1);
                pInstance->SetData(DATA_ENCOUNTER_STATUS, DONE);
            }
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim && victim->GetGUID() == me->GetGUID())
                return;

            if (events.IsInPhase(PHASE_ONE))
                Talk(SAY_SLAY_P1);
            else if (events.IsInPhase(PHASE_TWO))
                Talk(SAY_SLAY_P2);
            else
                Talk(SAY_SLAY_P3);
        }

        void JustSummoned(Creature* summon) override
        {
            if (!summon)
                return;
            summons.Summon(summon);
            switch (summon->GetEntry())
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

        void MoveInLineOfSight(Unit*  /*who*/) override {}

        void EnterEvadeMode(EvadeReason why) override
        {
            me->SetDisableGravity(true);
            me->GetMap()->SetZoneOverrideLight(AREA_EYE_OF_ETERNITY, LIGHT_GET_DEFAULT_FOR_MAP, 1s);

            me->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE);
            ScriptedAI::EnterEvadeMode(why);
        }

        void HandleIntroSpeech(const uint32 diff)
        {
            if (me->IsInCombat() || me->isDead())
                return;

            // speech timer
            if (timer1 <= diff)
            {
                Talk(SAY_INTRO);
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
                    uint32 tmp = urand(0, 3);
                    me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                    me->GetMotionMaster()->MovePoint(MI_POINT_INTRO_SIDE_0 + tmp, FourSidesPos[tmp]);
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetEyeOfEternityAI<npc_vortex_rideAI> (pCreature);
    }

    struct npc_vortex_rideAI : public VehicleAI
    {
        npc_vortex_rideAI(Creature* pCreature) : VehicleAI(pCreature)
        {
            VORTEX_RADIUS = urand(22, 28);
            float h = urand(15, 30);
            float angle = CenterPos.GetAngle(me);
            Position pos;
            pos.m_positionX = CenterPos.GetPositionX() + VORTEX_RADIUS * cos(angle);
            pos.m_positionY = CenterPos.GetPositionY() + VORTEX_RADIUS * std::sin(angle);
            pos.m_positionZ = CenterPos.GetPositionZ() + h;
            pos.SetOrientation(pos.GetAngle(&CenterPos));
            me->SetPosition(pos);
            timer = 0;
            despawnTimer = 9500;
            bUpdatedFlying = false;
        }

        uint32 timer;
        uint32 despawnTimer;
        bool bUpdatedFlying;
        float VORTEX_RADIUS;

        void PassengerBoarded(Unit* pass, int8  /*seat*/, bool apply) override
        {
            if (pass && !apply && pass->IsPlayer())
            {
                Player* plr = pass->ToPlayer();
                float speed = plr->GetDistance(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()) / (1.0f * 0.001f);
                plr->MonsterMoveWithSpeed(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), speed);
                plr->RemoveAura(SPELL_FREEZE_ANIM);
                plr->SetDisableGravity(false, true);
                plr->SetGuidValue(PLAYER_FARSIGHT, ObjectGuid::Empty);

                sScriptMgr->AnticheatSetCanFlybyServer(plr, false);
                sScriptMgr->AnticheatSetUnderACKmount(plr);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            /*      here: if player has some aura that should make him exit vehicle (eg. ice block) -> exit
                    or make it another way (dunno how)                                                          */

            if (despawnTimer <= diff)
            {
                despawnTimer = 0;
                me->UpdatePosition(CenterPos.GetPositionX(), CenterPos.GetPositionY(), CenterPos.GetPositionZ() + 18.0f, 0.0f, true);
                me->StopMovingOnCurrentPos();
                if (Vehicle* vehicle = me->GetVehicleKit())
                    vehicle->RemoveAllPassengers();
                me->DespawnOrUnsummon();
                return;
            }
            else
                despawnTimer -= diff;

            if (timer <= diff)
            {
                float angle = CenterPos.GetAngle(me);
                float newangle = angle + 2 * M_PI / ((float)VORTEX_TRAVEL_TIME / VORTEX_DEFAULT_DIFF);
                if (newangle >= 2 * M_PI)
                    newangle -= 2 * M_PI;
                float newx = CenterPos.GetPositionX() + VORTEX_RADIUS * cos(newangle);
                float newy = CenterPos.GetPositionY() + VORTEX_RADIUS * std::sin(newangle);
                float arcangle = me->GetAngle(newx, newy);
                float dist = 2 * me->GetDistance2d(newx, newy);
                if (me->GetVehicleKit()) if (Unit* pass = me->GetVehicleKit()->GetPassenger(0)) if (Player* plr = pass->ToPlayer())
                        {
                            if (!bUpdatedFlying && timer)
                            {
                                bUpdatedFlying = true;
                                plr->SetDisableGravity(true, true);

                                sScriptMgr->AnticheatSetCanFlybyServer(plr, true);
                                sScriptMgr->AnticheatSetUnderACKmount(plr);
                            }

                            plr->SendMonsterMove(me->GetPositionX() + dist * cos(arcangle), me->GetPositionY() + dist * std::sin(arcangle), me->GetPositionZ(), VORTEX_DEFAULT_DIFF * 2, SPLINEFLAG_FLYING);
                            me->Relocate(newx, newy);
                        }

                timer = (diff - timer <= VORTEX_DEFAULT_DIFF) ? VORTEX_DEFAULT_DIFF - (diff - timer) : 0;
            }
            else
                timer -= diff;
        }

        void AttackStart(Unit*  /*who*/) override {}
        void MoveInLineOfSight(Unit*  /*who*/) override {}
        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override { damage = 0; }
    };
};

class npc_power_spark : public CreatureScript
{
public:
    npc_power_spark() : CreatureScript("npc_power_spark") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetEyeOfEternityAI<npc_power_sparkAI>(pCreature);
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

        void DoAction(int32 param) override
        {
            switch (param)
            {
                case 1:
                    MoveTimer = 1;
                    break;
                case 2:
                    MoveTimer = 0;
                    me->GetMotionMaster()->MoveIdle();
                    me->DisableSpline();
                    me->MonsterMoveWithSpeed(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 0.05f, 7.0f);
                    break;
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
            {
                damage = 0;
                if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
                {
                    MoveTimer = 0;
                    me->GetMotionMaster()->MoveIdle();
                    me->DisableSpline();
                    me->MonsterMoveWithSpeed(me->GetPositionX(), me->GetPositionY(), CenterPos.GetPositionZ(), 100.0f);
                    me->SetPosition(me->GetPositionX(), me->GetPositionY(), CenterPos.GetPositionZ(), me->GetOrientation());
                    me->ReplaceAllUnitFlags(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
                    me->RemoveAura(SPELL_POWER_SPARK_VISUAL);
                    me->CastSpell(me, SPELL_POWER_SPARK_GROUND_BUFF, true);
                    me->DespawnOrUnsummon(60000);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
                return;

            if (CheckTimer <= diff)
            {
                if (pInstance)
                    if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_MALYGOS_GUID)))
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
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_MALYGOS_GUID)))
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetEyeOfEternityAI<npc_nexus_lordAI>(pCreature);
    }

    struct npc_nexus_lordAI : public ScriptedAI
    {
        npc_nexus_lordAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->SetReactState(REACT_PASSIVE);
            pInstance = me->GetInstanceScript();
            timer = 0;
            events.Reset();
            events.RescheduleEvent(EVENT_TELEPORT_VISUAL, 0ms);
        }

        InstanceScript* pInstance;
        EventMap events;
        uint16 timer;

        void JustEngagedWith(Unit*  /*who*/) override
        {
            DoZoneInCombat();
            events.Reset();
            events.RescheduleEvent(EVENT_NEXUS_LORD_ARCANE_SHOCK, 3s, 10s);
            events.RescheduleEvent(EVENT_NEXUS_LORD_HASTE, 8s, 14s);
        }

        void AttackStart(Unit* victim) override
        {
            if (victim && me->Attack(victim, true))
                me->GetMotionMaster()->MoveIdle();
        }

        void UpdateAI(uint32 diff) override
        {
            if (UpdateVictim())
                if (Unit* victim = me->GetVictim())
                {
                    if (timer <= diff)
                    {
                        if (!victim->IsWithinMeleeRange(me))
                        {
                            float x, y, z;
                            victim->GetClosePoint(x, y, z, 0.0f, 1.5f, me->GetAngle(victim));
                            if (Unit* v = me->GetVehicleBase())
                                v->GetMotionMaster()->MovePoint(0, x, y, z);
                        }
                        timer = 1000;
                    }
                    else
                        timer -= diff;
                }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_TELEPORT_VISUAL:
                    me->CastSpell(me, SPELL_TELEPORT_VISUAL, true);
                    break;
                case EVENT_NEXUS_LORD_ARCANE_SHOCK:
                    if (Unit* victim = me->GetVictim())
                        me->CastSpell(victim, SPELL_ARCANE_SHOCK);
                    events.Repeat(10s, 15s);
                    break;
                case EVENT_NEXUS_LORD_HASTE:
                    me->CastSpell(me, SPELL_HASTE);
                    events.Repeat(20s, 30s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetEyeOfEternityAI<npc_scion_of_eternityAI>(pCreature);
    }

    struct npc_scion_of_eternityAI : public ScriptedAI
    {
        npc_scion_of_eternityAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->SetReactState(REACT_PASSIVE);
            pInstance = me->GetInstanceScript();
            events.Reset();
            events.RescheduleEvent(EVENT_TELEPORT_VISUAL, 0ms);
            events.RescheduleEvent(EVENT_SCION_OF_ETERNITY_ARCANE_BARRAGE, 20s, 25s);
        }

        InstanceScript* pInstance;
        EventMap events;

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_TELEPORT_VISUAL:
                    me->CastSpell(me, SPELL_TELEPORT_VISUAL, true);
                    break;
                case EVENT_SCION_OF_ETERNITY_ARCANE_BARRAGE:
                    {
                        GuidVector guids;
                        Map::PlayerList const& PlayerList = me->GetMap()->GetPlayers();
                        if (!PlayerList.IsEmpty())
                            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                if (Player* pPlayer = i->GetSource())
                                {
                                    if (pPlayer->IsAlive())
                                    {
                                        if (!pPlayer->GetVehicle())
                                        {
                                            guids.push_back(pPlayer->GetGUID());
                                        }
                                    }
                                }
                        if (!guids.empty())
                            if (Player* plr = ObjectAccessor::GetPlayer(*me, guids.at(urand(0, guids.size() - 1))))
                                me->CastSpell(plr, SPELL_SCION_ARCANE_BARRAGE);

                        events.Repeat(5s, 8s);
                    }
                    break;
            }
        }

        void JustDied(Unit* killer) override
        {
            if (Vehicle* v = me->GetVehicle())
                v->RemoveAllPassengers();

            if (Player* player = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
                player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GET_KILLING_BLOWS, 1, 0, me);
        }

        void MoveInLineOfSight(Unit*  /*who*/) override {}
        void AttackStart(Unit*  /*who*/) override {}
    };
};

class npc_hover_disk : public CreatureScript
{
public:
    npc_hover_disk() : CreatureScript("npc_hover_disk") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetEyeOfEternityAI<npc_hover_diskAI>(pCreature);
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

        void PassengerBoarded(Unit* who, int8  /*seat*/, bool apply) override
        {
            events.Reset();
            if (!who)
                return;
            if (apply)
            {
                if (who->IsPlayer())
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

                if (who->IsPlayer())
                {
                    who->ApplySpellImmune(0, IMMUNITY_ID, SPELL_ARCANE_OVERLOAD_DMG, false);
                    who->ApplySpellImmune(0, IMMUNITY_ID, SPELL_SURGE_OF_POWER_DMG, false);
                }
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            switch (id)
            {
                case MI_POINT_SCION:
                    events.RescheduleEvent(EVENT_DISK_MOVE_NEXT_POINT, 0ms);
                    break;
                case MI_POINT_NEXUS_LORD:
                    if (me->GetPositionZ() > CenterPos.GetPositionZ() + 2.0f)
                        events.RescheduleEvent(EVENT_DISK_MOVE_NEXT_POINT, 0ms);
                    else if (Vehicle* v = me->GetVehicleKit())
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

        void DoAction(int32 param) override
        {
            switch (param)
            {
                case 1: // move to next point
                    if (Vehicle* v = me->GetVehicleKit())
                        if (Unit* pass = v->GetPassenger(0))
                            switch (pass->GetEntry())
                            {
                                case NPC_NEXUS_LORD:
                                    {
                                        float angle = CenterPos.GetAngle(me);
                                        float newangle = angle - 0.5f;
                                        if (newangle < 0.0f) newangle += 2 * M_PI;
                                        float newz = me->GetPositionZ() - 4.0f;
                                        if (newz < CenterPos.GetPositionZ()) newz = CenterPos.GetPositionZ();
                                        me->GetMotionMaster()->MovePoint(MI_POINT_NEXUS_LORD, CenterPos.GetPositionX() + cos(newangle) * 22.0f, CenterPos.GetPositionY() + std::sin(newangle) * 22.0f, newz);
                                    }
                                    break;
                                case NPC_SCION_OF_ETERNITY:
                                    {
                                        float angle = CenterPos.GetAngle(me);
                                        float newangle = angle - 0.3f;
                                        if (newangle < 0.0f) newangle += 2 * M_PI;
                                        float newz = me->GetPositionZ() - 2.0f;
                                        if (newz < CenterPos.GetPositionZ() + 20.0f) newz = CenterPos.GetPositionZ() + 20.0f;
                                        me->GetMotionMaster()->MovePoint(MI_POINT_SCION, CenterPos.GetPositionX() + cos(newangle) * 30.0f, CenterPos.GetPositionY() + std::sin(newangle) * 30.0f, newz);
                                    }
                                    break;
                            }
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_DISK_MOVE_NEXT_POINT:
                    DoAction(1);
                    break;
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) override {}
        void AttackStart(Unit*  /*who*/) override {}
    };
};

class npc_alexstrasza : public CreatureScript
{
public:
    npc_alexstrasza() : CreatureScript("npc_alexstrasza") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetEyeOfEternityAI<npc_alexstraszaAI>(pCreature);
    }

    struct npc_alexstraszaAI : public ScriptedAI
    {
        npc_alexstraszaAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            events.Reset();
            events.ScheduleEvent(1, 9s);
            me->SetCanFly(true);
            me->SetDisableGravity(true);
        }

        EventMap events;

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case 1:
                    me->CastSpell(773.98f, 1285.97f, 266.254f, SPELL_ALEXSTRASZA_GIFT, true);
                    if (GameObject* chest = me->SummonGameObject(ALEXSTRASZA_GIFT, 773.98f, 1285.97f, 266.254f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0))
                    {
                        chest->SetLootRecipient(me->GetMap());
                    }

                    if (GameObject* heart = me->SummonGameObject(HEART_OF_MAGIC, 773.98f, 1275.97f, 266.254f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0))
                    {
                        heart->SetLootRecipient(me->GetMap());
                    }

                    Talk(SAY_ALEXSTRASZA_ONE);
                    events.RescheduleEvent(2, 6s);
                    break;
                case 2:
                    Talk(SAY_ALEXSTRASZA_TWO);
                    events.RescheduleEvent(3, 5s);
                    break;
                case 3:
                    Talk(SAY_ALEXSTRASZA_THREE);
                    events.RescheduleEvent(4, 22s);
                    break;
                case 4:
                    Talk(SAY_ALEXSTRASZA_FOUR);
                    break;
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) override {}
        void AttackStart(Unit*  /*who*/) override {}
    };
};

class npc_eoe_wyrmrest_skytalon : public CreatureScript
{
public:
    npc_eoe_wyrmrest_skytalon() : CreatureScript("npc_eoe_wyrmrest_skytalon") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetEyeOfEternityAI<npc_eoe_wyrmrest_skytalonAI>(pCreature);
    }

    struct npc_eoe_wyrmrest_skytalonAI : public VehicleAI
    {
        npc_eoe_wyrmrest_skytalonAI(Creature* pCreature) : VehicleAI(pCreature) { }

        void PassengerBoarded(Unit* pass, int8  /*seat*/, bool apply) override
        {
            if (apply)
            {
                me->SetDisableGravity(false);
                me->SendMovementFlagUpdate();
            }
            else if (pass && pass->IsPlayer() && me->IsAlive())
            {
                me->SetDisplayId(11686); // prevents nasty falling animation at despawn
                me->DespawnOrUnsummon(1);
            }
        }

        void JustDied(Unit* /*killer*/) override
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

    bool OnGossipHello(Player* user, GameObject* go) override
    {
        if (!user || !go)
            return true;

        if (InstanceScript* pInstance = go->GetInstanceScript())
            pInstance->SetData(DATA_IRIS_ACTIVATED, 0);

        return true;
    }
};

class spell_eoe_ph3_surge_of_power : public SpellScript
{
    PrepareSpellScript(spell_eoe_ph3_surge_of_power);

    ObjectGuid DrakeGUID[3];

    bool Load() override
    {
        if (Unit* caster = GetCaster())
            if (Creature* c = caster->ToCreature())
            {
                uint8 i = 0;
                std::list<Unit*> drakes;
                c->AI()->SelectTargetList(drakes, (c->GetMap()->GetSpawnMode() == 0 ? 1 : 3), SelectTargetMethod::Random, 0, 0.0f, false, true, 57403 /*only drakes have this aura*/);
                for (std::list<Unit*>::iterator itr = drakes.begin(); itr != drakes.end() && i < 3; ++itr)
                {
                    DrakeGUID[i++] = (*itr)->GetGUID();
                    if (Vehicle* v = (*itr)->GetVehicleKit())
                        if (Unit* p = v->GetPassenger(0))
                            if (Player* plr = p->ToPlayer())
                                c->AI()->Talk(EMOTE_SURGE_OF_POWER_WARNING_P3, plr);
                }
            }

        return true;
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (Unit* caster = GetCaster())
        {
            targets.clear();
            for (uint8 i = 0; i < 3; ++i)
                if (DrakeGUID[i])
                    if (Unit* u = ObjectAccessor::GetUnit(*caster, DrakeGUID[i]))
                        targets.push_back(u);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_eoe_ph3_surge_of_power::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
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

    RegisterSpellScript(spell_eoe_ph3_surge_of_power);
}
