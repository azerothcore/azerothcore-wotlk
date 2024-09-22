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
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "SpellInfo.h"
#include "Vehicle.h"
#include "trial_of_the_champion.h"

enum MountSpells
{
    SPELL_PLAYER_VEHICLE_DEFEND             = 66482,
    SPELL_MINIONS_DEFEND                    = 64100,
    SPELL_BOSS_DEFEND                       = 62719,
    SPELL_BOSS_DEFEND_PERIODIC              = 64553,
    SPELL_SHIELD_LEVEL_1_VISUAL             = 63130,
    SPELL_SHIELD_LEVEL_2_VISUAL             = 63131,
    SPELL_SHIELD_LEVEL_3_VISUAL             = 63132,

    SPELL_PLAYER_VEHICLE_SHIELD_BREAKER     = 62575,
    SPELL_PLAYER_SHIELD_BREAKER_DAMAGE      = 62626,
    SPELL_NPC_SHIELD_BREAKER                = 68504,

    SPELL_PLAYER_VEHICLE_CHARGE             = 68284,
    SPELL_CHARGE_DAMAGE_20000               = 68498,
    SPELL_MINIONS_CHARGE                    = 63010,
    SPELL_BOSS_CHARGE                       = 68301, // triggers SPELL_MINIONS_CHARGE (should be with custom damage?)

    SPELL_PLAYER_VEHICLE_THRUST             = 68505,

    SPELL_TRAMPLE_AURA                      = 67865,
    SPELL_TRAMPLE_TRIGGERED_DUMMY           = 67866,
    SPELL_TRAMPLE_STUN                      = 67867,
};

enum ChampionSpells
{
    // Mage (Ambrose Boltspark, Eressea Dawnsinger)
    SPELL_FIREBALL_N                        = 66042,
    SPELL_FIREBALL_H                        = 68310,
    SPELL_BLAST_WAVE_N                      = 66044,
    SPELL_BLAST_WAVE_H                      = 68312,
    SPELL_HASTE                             = 66045,
    SPELL_POLYMORPH_N                       = 66043,
    SPELL_POLYMORPH_H                       = 68311,

    // Shaman (Colosos, Runok Wildmane)
    SPELL_CHAIN_LIGHTNING_N                 = 67529,
    SPELL_CHAIN_LIGHTNING_H                 = 68319,
    SPELL_EARTH_SHIELD                      = 67530,
    SPELL_HEALING_WAVE_N                    = 67528,
    SPELL_HEALING_WAVE_H                    = 68318,
    SPELL_HEX_OF_MENDING                    = 67534,

    // Hunter (Jaelyne Evensong, Zul'tore)
    SPELL_DISENGAGE                         = 68339,
    SPELL_LIGHTNING_ARROWS                  = 66083,
    SPELL_MULTI_SHOT                        = 66081,
    SPELL_SHOOT_N                           = 65868,
    SPELL_SHOOT_H                           = 67988,

    // Rogue (Lana Stouthammer Evensong, Deathstalker Visceri)
    SPELL_EVISCERATE_N                      = 67709,
    SPELL_EVISCERATE_H                      = 68317,
    SPELL_FAN_OF_KNIVES                     = 67706,
    SPELL_POISON_BOTTLE                     = 67701,

    // Warrior (Marshal Jacob Alerius, Mokra the Skullcrusher)
    SPELL_MORTAL_STRIKE_N                   = 68783,
    SPELL_MORTAL_STRIKE_H                   = 68784,
    SPELL_BLADESTORM                        = 63784,
    SPELL_INTERCEPT                         = 67540,
    SPELL_ROLLING_THROW                     = 67546, // not implemented yet!
};

enum Texts
{
    SAY_TRAMPLED                            = 0,
};

#define SPELL_FIREBALL                      DUNGEON_MODE(SPELL_FIREBALL_N, SPELL_FIREBALL_H)
#define SPELL_BLAST_WAVE                    DUNGEON_MODE(SPELL_BLAST_WAVE_N, SPELL_BLAST_WAVE_H)
#define SPELL_POLYMORPH                     DUNGEON_MODE(SPELL_POLYMORPH_N, SPELL_POLYMORPH_H)
#define SPELL_CHAIN_LIGHTNING               DUNGEON_MODE(SPELL_CHAIN_LIGHTNING_N, SPELL_CHAIN_LIGHTNING_H)
#define SPELL_HEALING_WAVE                  DUNGEON_MODE(SPELL_HEALING_WAVE_N, SPELL_HEALING_WAVE_H)
#define SPELL_SHOOT                         DUNGEON_MODE(SPELL_SHOOT_N, SPELL_SHOOT_H)
#define SPELL_EVISCERATE                    DUNGEON_MODE(SPELL_EVISCERATE_N, SPELL_EVISCERATE_H)
#define SPELL_MORTAL_STRIKE                 DUNGEON_MODE(SPELL_MORTAL_STRIKE_N, SPELL_MORTAL_STRIKE_H)

enum MountEvents
{
    EVENT_NONE = 0,
    EVENT_MOUNT_CHARGE,
    EVENT_SHIELD_BREAKER,
    EVENT_THRUST,
    EVENT_FIND_NEW_MOUNT,
};

enum ChampionEvents
{
    EVEMT_MAGE_SPELL_FIREBALL = 101,
    EVEMT_MAGE_SPELL_BLAST_WAVE,
    EVEMT_MAGE_SPELL_HASTE,
    EVEMT_MAGE_SPELL_POLYMORPH,

    EVENT_SHAMAN_SPELL_CHAIN_LIGHTNING,
    EVENT_SHAMAN_SPELL_EARTH_SHIELD,
    EVENT_SHAMAN_SPELL_HEALING_WAVE,
    EVENT_SHAMAN_SPELL_HEX_OF_MENDING,

    EVENT_HUNTER_SPELL_DISENGAGE,
    EVENT_HUNTER_SPELL_LIGHTNING_ARROWS,
    EVENT_HUNTER_SPELL_MULTI_SHOT,
    EVENT_HUNTER_SPELL_SHOOT,

    EVENT_ROGUE_SPELL_EVISCERATE,
    EVENT_ROGUE_SPELL_FAN_OF_KNIVES,
    EVENT_ROGUE_SPELL_POISON_BOTTLE,

    EVENT_WARRIOR_SPELL_MORTAL_STRIKE,
    EVENT_WARRIOR_SPELL_BLADESTORM,
    EVENT_WARRIOR_SPELL_INTERCEPT,
    EVENT_WARRIOR_SPELL_ROLLING_THROW,
};

class npc_toc5_player_vehicle : public CreatureScript
{
public:
    npc_toc5_player_vehicle() : CreatureScript("npc_toc5_player_vehicle") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheChampionAI<npc_toc5_player_vehicleAI>(pCreature);
    }

    struct npc_toc5_player_vehicleAI : public NullCreatureAI
    {
        npc_toc5_player_vehicleAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_CREATURE_TEMPLATE_VEHICLE, me->GetEntry());
            m_ConditionsTimer = 1000;
        }

        ConditionList conditions;
        uint16 m_ConditionsTimer;

        void Reset() override
        {
            me->SetReactState(REACT_PASSIVE);
            me->getHostileRefMgr().setOnlineOfflineState(false);
        }

        void OnCharmed(bool apply) override
        {
            if (me->IsDuringRemoveFromWorld())
                return;

            if (apply)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetSpeed(MOVE_RUN, 2.0f, false);
                me->CastSpell(me, SPELL_TRAMPLE_AURA, true);
            }
            else
            {
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->StopMoving();
                me->RemoveAura(SPELL_TRAMPLE_AURA);
            }
        }

        // just in case, should be done in spell_gen_defend
        void PassengerBoarded(Unit* who, int8  /*seat*/, bool apply) override
        {
            if (me->IsDuringRemoveFromWorld())
                return;

            if (!apply)
            {
                me->RemoveAura(SPELL_PLAYER_VEHICLE_DEFEND);
                who->RemoveAura(SPELL_PLAYER_VEHICLE_DEFEND);
                for (uint8 i = 0; i < 3; ++i)
                    who->RemoveAura(SPELL_SHIELD_LEVEL_1_VISUAL + i);
            }
        }

        //void EnterEvadeMode() { CreatureAI::EnterEvadeMode(); }
        void MoveInLineOfSight(Unit*  /*who*/) override {}
        void UpdateAI(uint32 diff) override
        {
            if (m_ConditionsTimer <= diff)
            {
                if (!conditions.empty())
                    if (Unit* passenger = me->GetVehicleKit()->GetPassenger(0))
                        if (!sConditionMgr->IsObjectMeetToConditions(passenger, me, conditions))
                            passenger->ExitVehicle();
                m_ConditionsTimer = VEHICLE_CONDITION_CHECK_TIME;
            }
            else
                m_ConditionsTimer -= diff;
        }
        void AttackStart(Unit*  /*who*/) override {}
        void JustEngagedWith(Unit*  /*who*/) override {}
    };
};

class npc_toc5_grand_champion_minion : public CreatureScript
{
public:
    npc_toc5_grand_champion_minion() : CreatureScript("npc_toc5_grand_champion_minion") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheChampionAI<npc_toc5_grand_champion_minionAI>(pCreature);
    }

    struct npc_toc5_grand_champion_minionAI : public ScriptedAI
    {
        npc_toc5_grand_champion_minionAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        int32 ShieldTimer;
        EventMap events;

        void Reset() override
        {
            ShieldTimer = 0;
            events.Reset();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            events.Reset();
            events.ScheduleEvent(EVENT_MOUNT_CHARGE, 2500ms, 4000ms);
            events.ScheduleEvent(EVENT_SHIELD_BREAKER, 5s, 8s);
            events.ScheduleEvent(EVENT_THRUST, 3s, 5s);
            me->CastSpell(me, SPELL_TRAMPLE_AURA, true);
        }

        void UpdateAI(uint32 diff) override
        {
            if (ShieldTimer <= (int32)diff )
            {
                me->CastSpell(me, SPELL_MINIONS_DEFEND, true);
                ShieldTimer = 5000;
            }
            else
                ShieldTimer -= diff;

            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_MOUNT_CHARGE:
                    {
                        GuidVector LIST;
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                            if (Player* plr = itr->GetSource())
                            {
                                if (me->GetExactDist(plr) < 8.0f || me->GetExactDist(plr) > 25.0f || plr->isDead())
                                    continue;
                                if (!plr->GetVehicle())
                                    LIST.push_back(plr->GetGUID());
                                else if (Vehicle* v = plr->GetVehicle())
                                {
                                    if (Unit* mount = v->GetBase())
                                        LIST.push_back(mount->GetGUID());
                                }
                            }
                        if (!LIST.empty())
                        {
                            uint8 rnd = LIST.size() > 1 ? urand(0, LIST.size() - 1) : 0;
                            if (Unit* target = ObjectAccessor::GetUnit(*me, LIST.at(rnd)))
                            {
                                me->GetThreatMgr().ResetAllThreat();
                                me->AddThreat(target, 10000.0f);
                                AttackStart(target);
                                me->CastSpell(target, SPELL_MINIONS_CHARGE, false);
                            }
                        }
                        events.Repeat(4500ms, 6000ms);
                    }
                    break;
                case EVENT_SHIELD_BREAKER:
                    {
                        GuidVector LIST;
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                            if (Player* plr = itr->GetSource())
                            {
                                if (me->GetExactDist(plr) < 10.0f || me->GetExactDist(plr) > 30.0f )
                                    continue;
                                if (Vehicle* v = plr->GetVehicle())
                                    if (Unit* mount = v->GetBase())
                                        LIST.push_back(mount->GetGUID());
                            }
                        if (!LIST.empty())
                        {
                            uint8 rnd = LIST.size() > 1 ? urand(0, LIST.size() - 1) : 0;
                            if (Unit* target = ObjectAccessor::GetCreature(*me, LIST.at(rnd)))
                                me->CastSpell(target, SPELL_NPC_SHIELD_BREAKER, false);
                        }
                        events.Repeat(6s, 8s);
                    }
                    break;
                case EVENT_THRUST:
                    if (me->GetVictim() && me->GetExactDist(me->GetVictim()) <= 5.5f )
                        me->CastSpell(me->GetVictim(), SPELL_PLAYER_VEHICLE_THRUST, false);
                    events.Repeat(3s, 5s);
                    break;
            }
        }

        void JustDied(Unit* /*pKiller*/) override
        {
            me->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0);
            me->DespawnOrUnsummon(10000);
            if (pInstance)
                pInstance->SetData(DATA_MOUNT_DIED, 0);
        }
    };
};

class boss_grand_champion : public CreatureScript
{
public:
    boss_grand_champion() : CreatureScript("boss_grand_champion") { }

    struct boss_grand_championAI : public npc_escortAI
    {
        boss_grand_championAI(Creature* pCreature) : npc_escortAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            MountPhase = true;
            SetDespawnAtEnd(false);
            me->SetReactState(REACT_PASSIVE);
            BossOrder = 0;
            NewMountGUID.Clear();
            me->CastSpell(me, SPELL_BOSS_DEFEND_PERIODIC, true);

            events.Reset();
            events.ScheduleEvent(EVENT_MOUNT_CHARGE, 2500ms, 4000ms);
            events.ScheduleEvent(EVENT_SHIELD_BREAKER, 5s, 8s);
            events.ScheduleEvent(EVENT_THRUST, 3s, 5s);

            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_CHARM, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_DISORIENTED, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_DISTRACT, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_FEAR, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_GRIP, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_ROOT, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SLEEP, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SNARE, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_FREEZE, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_KNOCKOUT, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_POLYMORPH, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_BANISH, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SHACKLE, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_TURN, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_HORROR, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_INTERRUPT, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_DAZE, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SAPPED, true);
        }

        InstanceScript* pInstance;
        EventMap events;
        uint32 BossOrder;
        bool MountPhase;
        ObjectGuid NewMountGUID;
        ObjectGuid UnitTargetGUID;

        void Reset() override
        {
            if (pInstance && pInstance->GetData(DATA_INSTANCE_PROGRESS) == INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED )
            {
                DoAction(1);
                DoAction(2);
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetImmuneToAll(false);
                me->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0);
                me->SetReactState(REACT_AGGRESSIVE);
            }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            if (pInstance && pInstance->GetData(DATA_INSTANCE_PROGRESS) == INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED )
                me->CallForHelp(100.0f);
        }

        void ScheduleAbilitiesEvents()
        {
            me->m_spellImmune[IMMUNITY_MECHANIC].clear();
            events.Reset();
            switch (me->GetEntry())
            {
                case NPC_AMBROSE: // Ambrose Boltspark
                case NPC_ERESSEA: // Eressea Dawnsinger
                    events.RescheduleEvent(EVEMT_MAGE_SPELL_FIREBALL, 5s);
                    events.RescheduleEvent(EVEMT_MAGE_SPELL_BLAST_WAVE, 12s);
                    events.RescheduleEvent(EVEMT_MAGE_SPELL_HASTE, 22s);
                    events.RescheduleEvent(EVEMT_MAGE_SPELL_POLYMORPH, 8s);
                    break;
                case NPC_COLOSOS: // Colosos
                case NPC_RUNOK: // Runok Wildmane
                    events.RescheduleEvent(EVENT_SHAMAN_SPELL_CHAIN_LIGHTNING, 16s);
                    events.RescheduleEvent(EVENT_SHAMAN_SPELL_EARTH_SHIELD, 30s, 35s);
                    events.RescheduleEvent(EVENT_SHAMAN_SPELL_HEALING_WAVE, 12s);
                    events.RescheduleEvent(EVENT_SHAMAN_SPELL_HEX_OF_MENDING, 20s, 25s);
                    break;
                case NPC_JAELYNE: // Jaelyne Evensong
                case NPC_ZULTORE: // Zul'tore
                    events.RescheduleEvent(EVENT_HUNTER_SPELL_LIGHTNING_ARROWS, 7s);
                    events.RescheduleEvent(EVENT_HUNTER_SPELL_MULTI_SHOT, 12s);
                    break;
                case NPC_LANA: // Lana Stouthammer
                case NPC_VISCERI: // Deathstalker Visceri
                    events.RescheduleEvent(EVENT_ROGUE_SPELL_EVISCERATE, 8s);
                    events.RescheduleEvent(EVENT_ROGUE_SPELL_FAN_OF_KNIVES, 14s);
                    events.RescheduleEvent(EVENT_ROGUE_SPELL_POISON_BOTTLE, 19s);
                    break;
                case NPC_JACOB: // Marshal Jacob Alerius
                case NPC_MOKRA: // Mokra the Skullcrusher
                    events.RescheduleEvent(EVENT_WARRIOR_SPELL_MORTAL_STRIKE, 8s, 12s);
                    events.RescheduleEvent(EVENT_WARRIOR_SPELL_BLADESTORM, 15s, 20s);
                    events.RescheduleEvent(EVENT_WARRIOR_SPELL_INTERCEPT, 7s);
                    break;
                default:
                    break;
            }
        }

        void AddCreatureAddonAuras()
        {
            CreatureAddon const* cainfo = me->GetCreatureAddon();
            if (!cainfo)
                return;

            if (!cainfo->auras.empty())
            {
                for (std::vector<uint32>::const_iterator itr = cainfo->auras.begin(); itr != cainfo->auras.end(); ++itr)
                {
                    SpellInfo const* AdditionalSpellInfo = sSpellMgr->GetSpellInfo(*itr);
                    if (!AdditionalSpellInfo)
                        continue;

                    if (me->HasAura(AdditionalSpellInfo->Id))
                        continue;

                    me->AddAura(AdditionalSpellInfo->Id, me);
                }
            }
        }

        void DoAction(int32 param) override
        {
            if (param == 1)
            {
                MountPhase = false;
                NewMountGUID.Clear();
                me->SetHealth(me->GetMaxHealth());
                me->SetRegeneratingHealth(true);
                me->RemoveUnitFlag(UNIT_FLAG_PACIFIED);
                me->SetSpeed(MOVE_RUN, 1.0f, false);
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetImmuneToAll(true);
                me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                me->RemoveAllAuras();
                AddCreatureAddonAuras();
                events.Reset();
            }
            else if (param == 2)
                ScheduleAbilitiesEvents();
        }

        void SetData(uint32 uiType, uint32 uiData) override
        {
            BossOrder = uiType;
            if (uiData > 1)
                return;
            switch (BossOrder)
            {
                case 0:
                    if (uiData == 0) // 1 == short version
                    {
                        AddWaypoint(0, 747.36f, 634.07f, 411.572f);
                        AddWaypoint(1, 780.43f, 607.15f, 411.82f);
                    }
                    AddWaypoint(2, 785.99f, 599.41f, 411.92f);
                    AddWaypoint(3, 778.44f, 601.64f, 411.79f);
                    break;
                case 1:
                    if (uiData == 0) // 1 == short version
                    {
                        AddWaypoint(0, 747.35f, 634.07f, 411.57f);
                        AddWaypoint(1, 768.72f, 581.01f, 411.92f);
                    }
                    AddWaypoint(2, 763.55f, 590.52f, 411.71f);
                    break;
                case 2:
                    if (uiData == 0) // 1 == short version
                    {
                        AddWaypoint(0, 747.35f, 634.07f, 411.57f);
                        AddWaypoint(1, 784.02f, 645.33f, 412.39f);
                    }
                    AddWaypoint(2, 775.67f, 641.91f, 411.91f);
                    break;
                default:
                    return;
            }

            Start(false, true);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (MountPhase)
            {
                if (me->GetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID) == 0 )
                    damage = 0;
                else if (damage >= me->GetHealth())
                {
                    events.Reset();
                    damage = me->GetHealth() - 1;
                    me->SetReactState(REACT_PASSIVE);
                    me->RemoveAllAuras();
                    AddCreatureAddonAuras();
                    me->GetThreatMgr().ClearAllThreat();
                    me->CombatStop(true);
                    me->GetMotionMaster()->Clear();
                    me->StopMoving();
                    me->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0);
                    me->SetRegeneratingHealth(false);
                    me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->SetImmuneToAll(true);
                    me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                    if (pInstance)
                    {
                        pInstance->SetData(DATA_MOUNT_DIED, BossOrder);
                        if (Creature* mount = me->FindNearestCreature( pInstance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? VEHICLE_ARGENT_WARHORSE : VEHICLE_ARGENT_BATTLEWORG, 100.0f, true ))
                        {
                            NewMountGUID = mount->GetGUID();
                            me->GetMotionMaster()->MovePoint(7, *mount);
                            events.RescheduleEvent(EVENT_FIND_NEW_MOUNT, 1s);
                        }
                    }
                }
            }
            else
            {
                if (damage >= me->GetHealth())
                {
                    MountPhase = true;
                    events.Reset();
                    damage = me->GetHealth() - 1;
                    me->SetReactState(REACT_PASSIVE);
                    me->RemoveAllAuras();
                    AddCreatureAddonAuras();
                    me->GetThreatMgr().ClearAllThreat();
                    me->CombatStop(true);
                    me->GetMotionMaster()->Clear();
                    me->SetRegeneratingHealth(false);
                    me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->SetImmuneToAll(true);
                    if (pInstance)
                        pInstance->SetData(DATA_GRAND_CHAMPION_DIED, BossOrder);
                }
            }
        }

        void EnterEvadeMode(EvadeReason /*why*/) override {}

        void WaypointReached(uint32 i) override
        {
            if (!pInstance)
                return;

            if ((i == 2 && (BossOrder == 1 || BossOrder == 2)) || (i == 3 && BossOrder == 0))
                pInstance->SetData(DATA_GRAND_CHAMPION_REACHED_DEST, BossOrder);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (id < 4)
                npc_escortAI::MovementInform(type, id);

            if (type == POINT_MOTION_TYPE)
            {
                if (id == 5)
                    me->SetFacingTo(3 * M_PI / 2);
                else if (id == 7) // reached new mount!
                {
                    if (NewMountGUID)
                        if (Creature* mount = ObjectAccessor::GetCreature(*me, NewMountGUID))
                        {
                            mount->DespawnOrUnsummon();
                            me->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, mount->GetDisplayId());
                            me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            me->SetHealth(50000);
                            me->CastSpell(me, SPELL_BOSS_DEFEND_PERIODIC, true);
                            me->SetRegeneratingHealth(true);
                            events.Reset();
                            events.ScheduleEvent(EVENT_MOUNT_CHARGE, 2500ms, 4000ms);
                            events.ScheduleEvent(EVENT_SHIELD_BREAKER, 5s, 8s);
                            events.ScheduleEvent(EVENT_THRUST, 3s, 5s);
                            me->SetReactState(REACT_AGGRESSIVE);
                            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            me->SetImmuneToAll(false);
                            if (Unit* target = me->SelectNearestTarget(200.0f))
                                AttackStart(target);
                            DoZoneInCombat();
                            me->CastSpell(me, SPELL_TRAMPLE_AURA, true);
                            if (pInstance)
                                pInstance->SetData(DATA_REACHED_NEW_MOUNT, 0);
                            NewMountGUID.Clear();
                        }
                }
                else if (id == 9)
                    me->DespawnOrUnsummon();
            }
        }

        void SpellHit(Unit*  /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_TRAMPLE_STUN)
                Talk(SAY_TRAMPLED, me);
        }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim() && !NewMountGUID )
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING) || ((me->GetEntry() == NPC_JACOB || me->GetEntry() == NPC_MOKRA) && me->HasAura(SPELL_BLADESTORM)))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_FIND_NEW_MOUNT:
                    {
                        if (me->HasAura(SPELL_TRAMPLE_STUN))
                        {
                            events.Repeat(200ms);
                            break;
                        }

                        // hackfix, trample won't hit grand champions because of UNIT_FLAG_NON_ATTACKABLE
                        if (pInstance)
                        {
                            bool trample = false;
                            Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                            for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                                if (Player* plr = itr->GetSource())
                                    if (me->GetExactDist(plr) <= 5.0f )
                                        if (Vehicle* v = plr->GetVehicle())
                                            if (Unit* c = v->GetBase())
                                                if (c->IsCreature() && c->ToCreature()->GetEntry() == (pInstance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? VEHICLE_ARGENT_BATTLEWORG : VEHICLE_ARGENT_WARHORSE))
                                                {
                                                    me->GetMotionMaster()->MovementExpired();
                                                    me->GetMotionMaster()->MoveIdle();
                                                    me->StopMoving();
                                                    me->CastSpell(me, SPELL_TRAMPLE_STUN, false);
                                                    trample = true;
                                                    break;
                                                }

                            if (trample)
                            {
                                events.Repeat(15s);
                                break;
                            }
                        }

                        if (Creature* mount = ObjectAccessor::GetCreature(*me, NewMountGUID))
                            if (mount->IsAlive())
                            {
                                if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE )
                                    me->GetMotionMaster()->MovePoint(7, *mount);
                                events.Repeat(200ms);
                                break;
                            }

                        if (Creature* mount = me->FindNearestCreature( pInstance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? VEHICLE_ARGENT_WARHORSE : VEHICLE_ARGENT_BATTLEWORG, 100.0f, true ))
                        {
                            me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            NewMountGUID = mount->GetGUID();
                            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            me->SetImmuneToAll(true);
                            me->GetMotionMaster()->MovePoint(7, *mount);
                            events.Repeat(200ms);
                            break;
                        }
                    }
                    break;
                case EVENT_MOUNT_CHARGE:
                    {
                        GuidVector LIST;
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                            if (Player* plr = itr->GetSource())
                            {
                                if (me->GetExactDist(plr) < 8.0f || me->GetExactDist(plr) > 25.0f || plr->isDead())
                                    continue;
                                if (!plr->GetVehicle())
                                    LIST.push_back(plr->GetGUID());
                                else if (Vehicle* v = plr->GetVehicle())
                                {
                                    if (Unit* mount = v->GetBase())
                                        LIST.push_back(mount->GetGUID());
                                }
                            }
                        if (!LIST.empty())
                        {
                            uint8 rnd = LIST.size() > 1 ? urand(0, LIST.size() - 1) : 0;
                            if (Unit* target = ObjectAccessor::GetUnit(*me, LIST.at(rnd)))
                            {
                                me->GetThreatMgr().ResetAllThreat();
                                me->AddThreat(target, 10000.0f);
                                AttackStart(target);
                                me->CastSpell(target, SPELL_MINIONS_CHARGE, false);
                            }
                        }
                        events.Repeat(4500ms, 6000ms);
                    }
                    break;
                case EVENT_SHIELD_BREAKER:
                    {
                        GuidVector LIST;
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                            if (Player* plr = itr->GetSource())
                            {
                                if (me->GetExactDist(plr) < 10.0f || me->GetExactDist(plr) > 30.0f )
                                    continue;
                                if (Vehicle* v = plr->GetVehicle())
                                    if (Unit* mount = v->GetBase())
                                        LIST.push_back(mount->GetGUID());
                            }
                        if (!LIST.empty())
                        {
                            uint8 rnd = LIST.size() > 1 ? urand(0, LIST.size() - 1) : 0;
                            if (Unit* target = ObjectAccessor::GetCreature(*me, LIST.at(rnd)))
                                me->CastSpell(target, SPELL_NPC_SHIELD_BREAKER, false);
                        }
                        events.Repeat(6s, 8s);
                    }
                    break;
                case EVENT_THRUST:
                    if (Unit* victim = me->GetVictim())
                        if (me->GetExactDist(victim) <= 6.0f )
                            me->CastSpell(victim, SPELL_PLAYER_VEHICLE_THRUST, false);
                    events.Repeat(3s, 5s);
                    break;

                /******************* MAGE *******************/
                case EVEMT_MAGE_SPELL_FIREBALL:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), SPELL_FIREBALL, false);
                    events.Repeat(5s);
                    break;
                case EVEMT_MAGE_SPELL_BLAST_WAVE:
                    me->CastSpell((Unit*)nullptr, SPELL_BLAST_WAVE, false);
                    events.Repeat(13s);
                    break;
                case EVEMT_MAGE_SPELL_HASTE:
                    me->CastSpell(me, SPELL_HASTE, false);
                    events.Repeat(22s);
                    break;
                case EVEMT_MAGE_SPELL_POLYMORPH:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true))
                        me->CastSpell(target, SPELL_POLYMORPH, false);
                    events.Repeat(8s);
                    break;
                /***************** MAGE END *****************/

                /****************** SHAMAN ******************/
                case EVENT_SHAMAN_SPELL_CHAIN_LIGHTNING:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true))
                        me->CastSpell(target, SPELL_CHAIN_LIGHTNING, false);
                    events.Repeat(16s);
                    break;
                case EVENT_SHAMAN_SPELL_EARTH_SHIELD:
                    me->CastSpell(me, SPELL_EARTH_SHIELD, false);
                    events.Repeat(30s, 35s);
                    break;
                case EVENT_SHAMAN_SPELL_HEALING_WAVE:
                    {
                        Unit* target = nullptr;
                        if (urand(0, 1))
                        {
                            target = DoSelectLowestHpFriendly(40.0f);
                            if (!target)
                                target = me;
                        }
                        else
                            target = me;
                        me->CastSpell(target, SPELL_HEALING_WAVE, false);
                        events.Repeat(22s);
                    }
                    break;
                case EVENT_SHAMAN_SPELL_HEX_OF_MENDING:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), SPELL_HEX_OF_MENDING, false);
                    events.Repeat(20s, 25s);
                    break;
                /**************** SHAMAN END ****************/

                /****************** HUNTER ******************/
                case EVENT_HUNTER_SPELL_DISENGAGE:

                    break;
                case EVENT_HUNTER_SPELL_LIGHTNING_ARROWS:
                    me->CastSpell((Unit*)nullptr, SPELL_LIGHTNING_ARROWS, false);
                    events.Repeat(20s, 25s);
                    break;
                case EVENT_HUNTER_SPELL_MULTI_SHOT:
                    {
                        if (!UnitTargetGUID)
                        {
                            if (Unit* target = SelectTarget(SelectTargetMethod::MinDistance, 0, 30.0f, true))
                            {
                                me->CastSpell(target, SPELL_SHOOT, false);
                                UnitTargetGUID = target->GetGUID();
                            }
                            events.Repeat(2s);
                            break;
                        }
                        else
                        {
                            Unit* target = ObjectAccessor::GetUnit(*me, UnitTargetGUID);
                            if (target && me->IsInRange(target, 5.0f, 30.0f, false))
                                me->CastSpell(target, SPELL_MULTI_SHOT, false);
                            else
                            {
                                Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                                for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                                {
                                    Player* player = itr->GetSource();
                                    if (player && me->IsInRange(player, 5.0f, 30.0f, false))
                                    {
                                        me->CastSpell(player, SPELL_MULTI_SHOT, false);
                                        break;
                                    }
                                }
                            }
                            UnitTargetGUID.Clear();
                        }
                        events.Repeat(15s, 20s);
                    }
                    break;
                /**************** HUNTER END ****************/

                /****************** ROGUE *******************/
                case EVENT_ROGUE_SPELL_EVISCERATE:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), SPELL_EVISCERATE, false);
                    events.Repeat(8s);
                    break;
                case EVENT_ROGUE_SPELL_FAN_OF_KNIVES:
                    me->CastSpell((Unit*)nullptr, SPELL_FAN_OF_KNIVES, false);
                    events.Repeat(14s);
                    break;
                case EVENT_ROGUE_SPELL_POISON_BOTTLE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true))
                        me->CastSpell(target, SPELL_POISON_BOTTLE, false);
                    events.Repeat(19s);
                    break;
                /**************** ROGUE END *****************/

                /***************** WARRIOR ******************/
                case EVENT_WARRIOR_SPELL_MORTAL_STRIKE:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), SPELL_MORTAL_STRIKE, false);
                    events.Repeat(8s, 12s);
                    break;
                case EVENT_WARRIOR_SPELL_BLADESTORM:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), SPELL_BLADESTORM, false);
                    events.Repeat(15s, 20s);
                    break;
                case EVENT_WARRIOR_SPELL_INTERCEPT:
                    {
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                        {
                            Player* player = itr->GetSource();
                            if (player && me->IsInRange(player, 8.0f, 25.0f, false))
                            {
                                DoResetThreatList();
                                me->AddThreat(player, 5.0f);
                                me->CastSpell(player, SPELL_INTERCEPT, false);
                                break;
                            }
                        }
                        events.Repeat(7s);
                    }
                    break;
                case EVENT_WARRIOR_SPELL_ROLLING_THROW:

                    break;
                    /*************** WARRIOR END ****************/
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheChampionAI<boss_grand_championAI>(pCreature);
    }
};

void AddSC_boss_grand_champions()
{
    new boss_grand_champion();
    new npc_toc5_grand_champion_minion();
    new npc_toc5_player_vehicle();
}
