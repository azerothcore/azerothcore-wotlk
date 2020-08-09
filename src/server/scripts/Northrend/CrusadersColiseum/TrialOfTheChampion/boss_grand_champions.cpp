/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "Vehicle.h"
#include "trial_of_the_champion.h"
#include "PassiveAI.h"
#include "Player.h"
#include "SpellInfo.h"

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

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc5_player_vehicleAI(pCreature);
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

        void Reset()
        {
            me->SetReactState(REACT_PASSIVE);
            me->getHostileRefManager().setOnlineOfflineState(false);
        }

        void OnCharmed(bool apply)
        {
            if (me->IsDuringRemoveFromWorld())
                return;

            if( apply )
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->SetSpeed(MOVE_RUN, 2.0f, false);
                me->CastSpell(me, SPELL_TRAMPLE_AURA, true);
            }
            else
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->StopMoving();
                me->RemoveAura(SPELL_TRAMPLE_AURA);
            }
        }

        // just in case, should be done in spell_gen_defend
        void PassengerBoarded(Unit* who, int8  /*seat*/, bool apply)
        {
            if (me->IsDuringRemoveFromWorld())
                return;

            if( !apply )
            {
                me->RemoveAura(SPELL_PLAYER_VEHICLE_DEFEND);
                who->RemoveAura(SPELL_PLAYER_VEHICLE_DEFEND);
                for (uint8 i=0; i<3; ++i)
                    who->RemoveAura(SPELL_SHIELD_LEVEL_1_VISUAL + i);
            }
        }

        //void EnterEvadeMode() { CreatureAI::EnterEvadeMode(); }
        void MoveInLineOfSight(Unit*  /*who*/) {}
        void UpdateAI(uint32 diff)
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
        void AttackStart(Unit*  /*who*/) {}
        void EnterCombat(Unit*  /*who*/) {}
    };
};

class npc_toc5_grand_champion_minion : public CreatureScript
{
public:
    npc_toc5_grand_champion_minion() : CreatureScript("npc_toc5_grand_champion_minion") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc5_grand_champion_minionAI(pCreature);
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

        void Reset()
        {
            ShieldTimer = 0;
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.Reset();
            events.ScheduleEvent(EVENT_MOUNT_CHARGE, urand(2500,4000));
            events.ScheduleEvent(EVENT_SHIELD_BREAKER, urand(5000,8000));
            events.ScheduleEvent(EVENT_THRUST, urand(3000,5000));
            me->CastSpell(me, SPELL_TRAMPLE_AURA, true);
        }

        void UpdateAI(uint32 diff)
        {
            if( ShieldTimer <= (int32)diff )
            {
                me->CastSpell(me, SPELL_MINIONS_DEFEND, true);
                ShieldTimer = 5000;
            }
            else
                ShieldTimer -= diff;

            if ( !UpdateVictim() )
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_MOUNT_CHARGE:
                    {
                        std::vector<uint64> LIST;
                        Map::PlayerList const &pl = me->GetMap()->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                            if( Player* plr = itr->GetSource() )
                            {
                                if( me->GetExactDist(plr) < 8.0f || me->GetExactDist(plr) > 25.0f || plr->isDead() )
                                    continue;
                                if( !plr->GetVehicle() )
                                    LIST.push_back(plr->GetGUID());
                                else if( Vehicle* v = plr->GetVehicle() )
                                {
                                    if( Unit* mount = v->GetBase() )
                                        LIST.push_back(mount->GetGUID());
                                }
                            }
                        if( !LIST.empty() )
                        {                       
                            uint8 rnd = LIST.size()>1 ? urand(0,LIST.size()-1) : 0;
                            if( Unit* target = ObjectAccessor::GetUnit(*me, LIST.at(rnd)) )
                            {
                                me->getThreatManager().resetAllAggro();
                                me->AddThreat(target, 10000.0f);
                                AttackStart(target);
                                me->CastSpell(target, SPELL_MINIONS_CHARGE, false);
                            }
                        }
                        events.RepeatEvent(urand(4500,6000));
                    }
                    break;
                case EVENT_SHIELD_BREAKER:
                    {
                        std::vector<uint64> LIST;
                        Map::PlayerList const &pl = me->GetMap()->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                            if( Player* plr = itr->GetSource() )
                            {
                                if( me->GetExactDist(plr) < 10.0f || me->GetExactDist(plr) > 30.0f )
                                    continue;
                                if( Vehicle* v = plr->GetVehicle() )
                                    if( Unit* mount = v->GetBase() )
                                        LIST.push_back(mount->GetGUID());
                            }
                        if( !LIST.empty() )
                        {                       
                            uint8 rnd = LIST.size()>1 ? urand(0,LIST.size()-1) : 0;
                            if( Unit* target = ObjectAccessor::GetCreature(*me, LIST.at(rnd)) )
                                me->CastSpell(target, SPELL_NPC_SHIELD_BREAKER, false);
                        }
                        events.RepeatEvent(urand(6000,8000));
                    }
                    break;
                case EVENT_THRUST:
                    if( me->GetVictim() && me->GetExactDist(me->GetVictim()) <= 5.5f )
                        me->CastSpell(me->GetVictim(), SPELL_PLAYER_VEHICLE_THRUST, false);
                    events.RepeatEvent(urand(3000,5000));
                    break;
            }
        }

        void JustDied(Unit* /*pKiller*/)
        {
            me->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0);
            me->DespawnOrUnsummon(10000);
            if( pInstance )
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
            NewMountGUID = 0;
            me->CastSpell(me, SPELL_BOSS_DEFEND_PERIODIC, true);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);

            events.Reset();
            events.ScheduleEvent(EVENT_MOUNT_CHARGE, urand(2500,4000));
            events.ScheduleEvent(EVENT_SHIELD_BREAKER, urand(5000,8000));
            events.ScheduleEvent(EVENT_THRUST, urand(3000,5000));

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
        uint64 NewMountGUID;
        uint64 UnitTargetGUID;

        void Reset()
        {
            if( pInstance && pInstance->GetData(DATA_INSTANCE_PROGRESS) == INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED )
            {
                DoAction(1);
                DoAction(2);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0);
                me->SetReactState(REACT_AGGRESSIVE);
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            if( pInstance && pInstance->GetData(DATA_INSTANCE_PROGRESS) == INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED )
                me->CallForHelp(100.0f);
        }

        void ScheduleAbilitiesEvents()
        {
            me->m_spellImmune[IMMUNITY_MECHANIC].clear();
            events.Reset();
            switch( me->GetEntry() )
            {
                case NPC_AMBROSE: // Ambrose Boltspark
                case NPC_ERESSEA: // Eressea Dawnsinger
                    events.RescheduleEvent(EVEMT_MAGE_SPELL_FIREBALL, 5000);
                    events.RescheduleEvent(EVEMT_MAGE_SPELL_BLAST_WAVE, 12000);
                    events.RescheduleEvent(EVEMT_MAGE_SPELL_HASTE, 22000);
                    events.RescheduleEvent(EVEMT_MAGE_SPELL_POLYMORPH, 8000);
                    break;
                case NPC_COLOSOS: // Colosos
                case NPC_RUNOK: // Runok Wildmane
                    events.RescheduleEvent(EVENT_SHAMAN_SPELL_CHAIN_LIGHTNING, 16000);
                    events.RescheduleEvent(EVENT_SHAMAN_SPELL_EARTH_SHIELD, urand(30000,35000));
                    events.RescheduleEvent(EVENT_SHAMAN_SPELL_HEALING_WAVE, 12000);
                    events.RescheduleEvent(EVENT_SHAMAN_SPELL_HEX_OF_MENDING, urand(20000,25000));
                    break;
                case NPC_JAELYNE: // Jaelyne Evensong
                case NPC_ZULTORE: // Zul'tore
                    //events.RescheduleEvent(EVENT_HUNTER_SPELL_DISENGAGE, x);
                    events.RescheduleEvent(EVENT_HUNTER_SPELL_LIGHTNING_ARROWS, 7000);
                    events.RescheduleEvent(EVENT_HUNTER_SPELL_MULTI_SHOT, 12000);
                    break;
                case NPC_LANA: // Lana Stouthammer
                case NPC_VISCERI: // Deathstalker Visceri
                    events.RescheduleEvent(EVENT_ROGUE_SPELL_EVISCERATE, 8000);
                    events.RescheduleEvent(EVENT_ROGUE_SPELL_FAN_OF_KNIVES, 14000);
                    events.RescheduleEvent(EVENT_ROGUE_SPELL_POISON_BOTTLE, 19000);
                    break;
                case NPC_JACOB: // Marshal Jacob Alerius
                case NPC_MOKRA: // Mokra the Skullcrusher
                    events.RescheduleEvent(EVENT_WARRIOR_SPELL_MORTAL_STRIKE, urand(8000,12000));
                    events.RescheduleEvent(EVENT_WARRIOR_SPELL_BLADESTORM, urand(15000,20000));
                    events.RescheduleEvent(EVENT_WARRIOR_SPELL_INTERCEPT, 7000);
                    //events.RescheduleEvent(EVENT_WARRIOR_SPELL_ROLLING_THROW, x);
                    break;
                default:
                    break;
            }
        }

        void AddCreatureAddonAuras()
        {
            CreatureAddon const *cainfo = me->GetCreatureAddon();
            if (!cainfo)
                return;

            if (!cainfo->auras.empty())
            {
                for (std::vector<uint32>::const_iterator itr = cainfo->auras.begin(); itr != cainfo->auras.end(); ++itr)
                {
                    SpellInfo const *AdditionalSpellInfo = sSpellMgr->GetSpellInfo(*itr);
                    if (!AdditionalSpellInfo)
                        continue;

                    if (me->HasAura(AdditionalSpellInfo->Id))
                        continue;

                    me->AddAura(AdditionalSpellInfo->Id, me);
                }
            }
        }

        void DoAction(int32 param)
        {
            if( param == 1 )
            {
                MountPhase = false;
                NewMountGUID = 0;
                me->SetHealth(me->GetMaxHealth());
                me->SetRegeneratingHealth(true);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);
                me->SetSpeed(MOVE_RUN, 1.0f, false);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                me->RemoveAllAuras();
                AddCreatureAddonAuras();
                events.Reset();
            }
            else if( param == 2 )
                ScheduleAbilitiesEvents();
        }

        void SetData(uint32 uiType, uint32 uiData)
        {
            BossOrder = uiType;
            if( uiData > 1 )
                return;
            switch( BossOrder )
            {
                case 0:
                    if (uiData == 0) // 1 == short version
                    {
                        AddWaypoint(0,747.36f,634.07f,411.572f);
                        AddWaypoint(1,780.43f,607.15f,411.82f);
                    }
                    AddWaypoint(2,785.99f,599.41f,411.92f);
                    AddWaypoint(3,778.44f,601.64f,411.79f);
                    break;
                case 1:
                    if (uiData == 0) // 1 == short version
                    {
                        AddWaypoint(0,747.35f,634.07f,411.57f); 
                        AddWaypoint(1,768.72f,581.01f,411.92f);
                    }
                    AddWaypoint(2,763.55f,590.52f,411.71f);
                    break;
                case 2:
                    if (uiData == 0) // 1 == short version
                    {
                        AddWaypoint(0,747.35f,634.07f,411.57f);
                        AddWaypoint(1,784.02f,645.33f,412.39f);
                    }
                    AddWaypoint(2,775.67f,641.91f,411.91f);
                    break;
                default:
                    return;
            }

            Start(false, true, 0, nullptr);
        }

        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask)
        {
            if( MountPhase )
            {
                if( me->GetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID) == 0 )
                    damage = 0;
                else if( damage >= me->GetHealth() )
                {
                    events.Reset();
                    damage = me->GetHealth()-1;
                    me->SetReactState(REACT_PASSIVE);
                    me->RemoveAllAuras();
                    AddCreatureAddonAuras();
                    me->DeleteThreatList();
                    me->CombatStop(true);
                    me->GetMotionMaster()->Clear();
                    me->StopMoving();
                    me->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0);
                    me->SetRegeneratingHealth(false);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                    if( pInstance )
                    {
                        pInstance->SetData(DATA_MOUNT_DIED, BossOrder);
                        if( Creature* mount = me->FindNearestCreature( pInstance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? VEHICLE_ARGENT_WARHORSE : VEHICLE_ARGENT_BATTLEWORG, 100.0f, true ) )
                        {
                            NewMountGUID = mount->GetGUID();
                            me->GetMotionMaster()->MovePoint(7, *mount);
                            events.RescheduleEvent(EVENT_FIND_NEW_MOUNT, 1000);
                        }
                    }
                }
            }
            else
            {
                if( damage >= me->GetHealth() )
                {
                    events.Reset();
                    damage = me->GetHealth()-1;
                    me->SetReactState(REACT_PASSIVE);
                    me->RemoveAllAuras();
                    AddCreatureAddonAuras();
                    me->DeleteThreatList();
                    me->CombatStop(true);
                    me->GetMotionMaster()->Clear();
                    me->SetRegeneratingHealth(false);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    if( pInstance )
                        pInstance->SetData(DATA_GRAND_CHAMPION_DIED, BossOrder);
                }
            }
        }

        void EnterEvadeMode() {}

        void WaypointReached(uint32 i)
        {
            if( !pInstance )
                return;

            if( (i==2 && (BossOrder==1 || BossOrder==2)) || (i==3 && BossOrder==0) )
                pInstance->SetData(DATA_GRAND_CHAMPION_REACHED_DEST, BossOrder);
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if( id < 4 )
                npc_escortAI::MovementInform(type, id);

            if( type == POINT_MOTION_TYPE )
            {
                if( id == 5 )
                    me->SetFacingTo(3*M_PI/2);
                else if( id == 7 ) // reached new mount!
                {
                    if( NewMountGUID )
                        if( Creature* mount = ObjectAccessor::GetCreature(*me, NewMountGUID) )
                        {
                            mount->DespawnOrUnsummon();
                            me->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, mount->GetDisplayId());
                            me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            me->SetHealth(50000);
                            me->CastSpell(me, SPELL_BOSS_DEFEND_PERIODIC, true);
                            me->SetRegeneratingHealth(true);
                            events.Reset();
                            events.ScheduleEvent(EVENT_MOUNT_CHARGE, urand(2500,4000));
                            events.ScheduleEvent(EVENT_SHIELD_BREAKER, urand(5000,8000));
                            events.ScheduleEvent(EVENT_THRUST, urand(3000,5000));
                            me->SetReactState(REACT_AGGRESSIVE);
                            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            if( Unit* target = me->SelectNearestTarget(200.0f) )
                                AttackStart(target);
                            DoZoneInCombat();
                            me->CastSpell(me, SPELL_TRAMPLE_AURA, true);
                            if( pInstance )
                                pInstance->SetData(DATA_REACHED_NEW_MOUNT, 0);
                            NewMountGUID = 0;
                        }
                }
                else if( id == 9 )
                    me->DespawnOrUnsummon();
            }
        }

        void SpellHit(Unit*  /*caster*/, const SpellInfo* spell)
        {
            switch( spell->Id )
            {
                case SPELL_TRAMPLE_STUN:
                    {
                        char buffer[50];
                        sprintf(buffer, "%s is trampled!", me->GetName().c_str());
                        me->MonsterTextEmote(buffer, 0);
                    }
                    break;
            }
        }

        void UpdateAI(uint32 diff)
        {
            npc_escortAI::UpdateAI(diff);

            if ( !UpdateVictim() && !NewMountGUID )
                return;
            
            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) || ((me->GetEntry()==NPC_JACOB || me->GetEntry()==NPC_MOKRA) && me->HasAura(SPELL_BLADESTORM)) )
                return;

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_FIND_NEW_MOUNT:
                    {
                        if( me->HasAura(SPELL_TRAMPLE_STUN) )
                        {
                            events.RepeatEvent(200);
                            break;
                        }
                        
                        // hackfix, trample won't hit grand champions because of UNIT_FLAG_NON_ATTACKABLE
                        if( pInstance )
                        {
                            bool trample = false;
                            Map::PlayerList const &pl = me->GetMap()->GetPlayers();
                            for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                                if( Player* plr = itr->GetSource() )
                                    if( me->GetExactDist(plr) <= 5.0f )
                                        if( Vehicle* v = plr->GetVehicle() )
                                            if( Unit* c = v->GetBase() )
                                                if( c->GetTypeId() == TYPEID_UNIT && c->ToCreature()->GetEntry() == (pInstance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? VEHICLE_ARGENT_BATTLEWORG : VEHICLE_ARGENT_WARHORSE) )
                                                {
                                                    me->GetMotionMaster()->MovementExpired();;
                                                    me->GetMotionMaster()->MoveIdle();
                                                    me->StopMoving();
                                                    me->CastSpell(me, SPELL_TRAMPLE_STUN, false);
                                                    trample = true;
                                                    break;
                                                }

                            if( trample )
                            {
                                events.RepeatEvent(15100);
                                break;
                            }
                        }

                        if( Creature* mount = ObjectAccessor::GetCreature(*me, NewMountGUID) )
                            if( mount->IsAlive() )
                            {
                                if( me->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE )
                                    me->GetMotionMaster()->MovePoint(7, *mount);
                                events.RepeatEvent(200);
                                break;
                            }

                        if( Creature* mount = me->FindNearestCreature( pInstance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? VEHICLE_ARGENT_WARHORSE : VEHICLE_ARGENT_BATTLEWORG, 100.0f, true ) )
                        {
                            me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            NewMountGUID = mount->GetGUID();
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            me->GetMotionMaster()->MovePoint(7, *mount);
                            events.RepeatEvent(200);
                            break;
                        }

                        events.PopEvent();
                    }
                    break;
                case EVENT_MOUNT_CHARGE:
                    {
                        std::vector<uint64> LIST;
                        Map::PlayerList const &pl = me->GetMap()->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                            if( Player* plr = itr->GetSource() )
                            {
                                if( me->GetExactDist(plr) < 8.0f || me->GetExactDist(plr) > 25.0f || plr->isDead() )
                                    continue;
                                if( !plr->GetVehicle() )
                                    LIST.push_back(plr->GetGUID());
                                else if( Vehicle* v = plr->GetVehicle() )
                                {
                                    if( Unit* mount = v->GetBase() )
                                        LIST.push_back(mount->GetGUID());
                                }
                            }
                        if( !LIST.empty() )
                        {
                            uint8 rnd = LIST.size()>1 ? urand(0,LIST.size()-1) : 0;
                            if( Unit* target = ObjectAccessor::GetUnit(*me, LIST.at(rnd)) )
                            {
                                me->getThreatManager().resetAllAggro();
                                me->AddThreat(target, 10000.0f);
                                AttackStart(target);
                                me->CastSpell(target, SPELL_MINIONS_CHARGE, false);
                            }
                        }
                        events.RepeatEvent(urand(4500,6000));
                    }
                    break;
                case EVENT_SHIELD_BREAKER:
                    {
                        std::vector<uint64> LIST;
                        Map::PlayerList const &pl = me->GetMap()->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                            if( Player* plr = itr->GetSource() )
                            {
                                if( me->GetExactDist(plr) < 10.0f || me->GetExactDist(plr) > 30.0f )
                                    continue;
                                if( Vehicle* v = plr->GetVehicle() )
                                    if( Unit* mount = v->GetBase() )
                                        LIST.push_back(mount->GetGUID());
                            }
                        if( !LIST.empty() )
                        {
                            uint8 rnd = LIST.size()>1 ? urand(0,LIST.size()-1) : 0;
                            if( Unit* target = ObjectAccessor::GetCreature(*me, LIST.at(rnd)) )
                                me->CastSpell(target, SPELL_NPC_SHIELD_BREAKER, false);
                        }
                        events.RepeatEvent(urand(6000,8000));
                    }
                    break;
                case EVENT_THRUST:
                    if( Unit* victim = me->GetVictim() )
                        if( me->GetExactDist(victim) <= 6.0f )
                            me->CastSpell(victim, SPELL_PLAYER_VEHICLE_THRUST, false);
                    events.RepeatEvent(urand(3000,5000));
                    break;

                /******************* MAGE *******************/
                case EVEMT_MAGE_SPELL_FIREBALL:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_FIREBALL, false);
                    events.RepeatEvent(5000);
                    break;
                case EVEMT_MAGE_SPELL_BLAST_WAVE:
                    me->CastSpell((Unit*)NULL, SPELL_BLAST_WAVE, false);
                    events.RepeatEvent(13000);
                    break;
                case EVEMT_MAGE_SPELL_HASTE:
                    me->CastSpell(me, SPELL_HASTE, false);
                    events.RepeatEvent(22000);
                    break;
                case EVEMT_MAGE_SPELL_POLYMORPH:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 30.0f, true) )
                        me->CastSpell(target, SPELL_POLYMORPH, false);
                    events.RepeatEvent(8000);
                    break;
                /***************** MAGE END *****************/

                /****************** SHAMAN ******************/
                case EVENT_SHAMAN_SPELL_CHAIN_LIGHTNING:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 30.0f, true) )
                        me->CastSpell(target, SPELL_CHAIN_LIGHTNING, false);
                    events.RepeatEvent(16000);
                    break;
                case EVENT_SHAMAN_SPELL_EARTH_SHIELD:
                    me->CastSpell(me, SPELL_EARTH_SHIELD, false);
                    events.RepeatEvent(urand(30000,35000));
                    break;
                case EVENT_SHAMAN_SPELL_HEALING_WAVE:
                    {
                        Unit* target = nullptr;
                        if( urand(0,1) )
                        {
                            target = DoSelectLowestHpFriendly(40.0f);
                            if( !target )
                                target = me;
                        }
                        else
                            target = me;
                        me->CastSpell(target, SPELL_HEALING_WAVE, false);
                        events.RepeatEvent(22000);
                    }
                    break;
                case EVENT_SHAMAN_SPELL_HEX_OF_MENDING:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_HEX_OF_MENDING, false);
                    events.RepeatEvent(urand(20000,25000));
                    break;
                /**************** SHAMAN END ****************/

                /****************** HUNTER ******************/
                case EVENT_HUNTER_SPELL_DISENGAGE:
                    events.PopEvent();
                    break;
                case EVENT_HUNTER_SPELL_LIGHTNING_ARROWS:
                    me->CastSpell((Unit*)NULL, SPELL_LIGHTNING_ARROWS, false);
                    events.RepeatEvent(urand(20000,25000));
                    break;
                case EVENT_HUNTER_SPELL_MULTI_SHOT:
                    {
                        if( !UnitTargetGUID )
                        {
                            if( Unit* target = SelectTarget(SELECT_TARGET_FARTHEST, 0, 30.0f, true) )
                            {
                                me->CastSpell(target, SPELL_SHOOT, false);
                                UnitTargetGUID = target->GetGUID();
                            }
                            events.RepeatEvent(2000);
                            break;
                        }
                        else
                        {
                            Unit* target = ObjectAccessor::GetUnit(*me, UnitTargetGUID);
                            if( target && me->IsInRange(target, 5.0f, 30.0f, false) )
                                me->CastSpell(target, SPELL_MULTI_SHOT, false);
                            else
                            {
                                Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                                for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                                {
                                    Player* player = itr->GetSource();
                                    if( player && me->IsInRange(player, 5.0f, 30.0f, false) )
                                    {
                                        me->CastSpell(player, SPELL_MULTI_SHOT, false);
                                        break;
                                    }
                                }
                            }
                            UnitTargetGUID = 0;
                        }
                        events.RepeatEvent(urand(15000,20000));
                    }
                    break;
                /**************** HUNTER END ****************/

                /****************** ROGUE *******************/
                case EVENT_ROGUE_SPELL_EVISCERATE:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_EVISCERATE, false);
                    events.RepeatEvent(8000);
                    break;
                case EVENT_ROGUE_SPELL_FAN_OF_KNIVES:
                    me->CastSpell((Unit*)NULL, SPELL_FAN_OF_KNIVES, false);
                    events.RepeatEvent(14000);
                    break;
                case EVENT_ROGUE_SPELL_POISON_BOTTLE:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 30.0f, true) )
                        me->CastSpell(target, SPELL_POISON_BOTTLE, false);
                    events.RepeatEvent(19000);
                    break;
                /**************** ROGUE END *****************/

                /***************** WARRIOR ******************/
                case EVENT_WARRIOR_SPELL_MORTAL_STRIKE:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_MORTAL_STRIKE, false);
                    events.RepeatEvent(urand(8000,12000));
                    break;
                case EVENT_WARRIOR_SPELL_BLADESTORM:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_BLADESTORM, false);
                    events.RepeatEvent(urand(15000,20000));
                    break;
                case EVENT_WARRIOR_SPELL_INTERCEPT:
                    {
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                        {
                            Player* player = itr->GetSource();
                            if( player && me->IsInRange(player, 8.0f, 25.0f, false) )
                            {
                                DoResetThreat();
                                me->AddThreat(player,5.0f);
                                me->CastSpell(player, SPELL_INTERCEPT, false);
                                break;
                            }
                        }
                        events.RepeatEvent(7000);
                    }
                    break;
                case EVENT_WARRIOR_SPELL_ROLLING_THROW:
                    events.PopEvent();
                    break;
                /*************** WARRIOR END ****************/
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_grand_championAI(pCreature);
    }
};

void AddSC_boss_grand_champions()
{
    new boss_grand_champion();
    new npc_toc5_grand_champion_minion();
    new npc_toc5_player_vehicle();
}
