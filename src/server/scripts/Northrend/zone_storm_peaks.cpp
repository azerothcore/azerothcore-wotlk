/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "AreaDefines.h"
#include "CombatAI.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "WaypointMgr.h"

enum qSniffingOutThePerpetrator
{
    NPC_FROSTHOUND                          = 29677,
    NPC_FROSTBITE                           = 29903,
    SPELL_SUMMON_PURSUERS_PERIODIC          = 54993,
    SPELL_SNIFFING_CREDIT                   = 55477,
    TALK_EMOTE_FROSTHOUND_SNIFF             = 0,
    TALK_SEEN                               = 1,
    TALK_CONFRONT                           = 2,
    TALK_EMOTE_TRACKED_COMPLETE             = 3,
};

struct npc_frosthound : public npc_escortAI
{
    explicit npc_frosthound(Creature* creature) : npc_escortAI(creature), _summons(creature), _completionWaypoint((creature->GetEntry() == NPC_FROSTBITE) ? 19 : 34) { }

    void AttackStart(Unit* /*who*/) override {}
    void JustEngagedWith(Unit* /*who*/) override {}
    void EnterEvadeMode(EvadeReason /* why */) override {}
    void JustDied(Unit* /*killer*/) override { }
    void OnCharmed(bool /*apply*/) override { }

    void PassengerBoarded(Unit* who, int8 /*seatId*/, bool apply) override
    {
        if (who->IsPlayer())
        {
            if (apply)
            {
                me->SetFaction(who->GetFaction());
                me->CastSpell(me, SPELL_SUMMON_PURSUERS_PERIODIC, true);
                Start(false, who->GetGUID());
                Talk(TALK_EMOTE_FROSTHOUND_SNIFF, me);
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        npc_escortAI::UpdateAI(diff);

        if (!UpdateVictim())
            return;
    }

    void WaypointReached(uint32 waypointId) override
    {
        Player* player = GetPlayerForEscort();
        if (!player)
            return;

        if (waypointId == 0)
            Talk(TALK_SEEN, player);
        else if (waypointId == _completionWaypoint)
        {
            Talk(TALK_EMOTE_TRACKED_COMPLETE, me);
            Talk(TALK_CONFRONT, player);
            if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                summoner->ToPlayer()->KilledMonsterCredit(NPC_FROSTHOUND); // same credit for Alliance and Horde
            _summons.DespawnAll();
        }
    }

    void JustSummoned(Creature* cr) override
    {
        _summons.Summon(cr);
        cr->ToTempSummon()->SetTempSummonType(TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT);
        cr->ToTempSummon()->InitStats(20000);
        if (urand(0, 1))
            cr->GetMotionMaster()->MoveFollow(me, 0.0f, 0.0f);
        else if (cr->AI())
            cr->AI()->AttackStart(me);
    }

    void Reset() override
    {
        _summons.DespawnAll();
    }

private:
    SummonList _summons;
    uint32 _completionWaypoint;
};

enum eIronWatcher
{
    SPELL_THUNDERING_STOMP          = 60925,
    SPELL_STORM_HAMMER              = 56448,
    SPELL_SHATTERED_EYES            = 57290,
    SPELL_STORM_HAMMER_DUMMY        = 60930,
};

class npc_iron_watcher : public CreatureScript
{
public:
    npc_iron_watcher() : CreatureScript("npc_iron_watcher") { }

    struct npc_iron_watcherAI : public ScriptedAI
    {
        npc_iron_watcherAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 spellTimer;
        uint32 hpTimer;
        bool charging;

        void Reset() override
        {
            spellTimer = 0;
            hpTimer = 0;
            charging = false;
            me->SetControlled(false, UNIT_STATE_STUNNED);
        }

        void MovementInform(uint32 type, uint32  /*pointId*/) override
        {
            if (type == POINT_MOTION_TYPE)
                me->SetControlled(true, UNIT_STATE_STUNNED);
        }

        void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_STORM_HAMMER)
            {
                me->CastSpell(caster, SPELL_STORM_HAMMER_DUMMY, true);
                if (charging)
                {
                    me->RemoveAllAurasExceptType(SPELL_AURA_MECHANIC_IMMUNITY);
                    Talk(1);
                    caster->ToPlayer()->KilledMonsterCredit(me->GetEntry());
                    me->DespawnOrUnsummon(8s);
                    me->GetMotionMaster()->MoveJump(8721.94f, -1955, 963, 70.0f, 30.0f);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (charging)
                return;

            if (!UpdateVictim())
                return;

            spellTimer += diff;
            hpTimer += diff;
            if (spellTimer >= 10000)
            {
                me->CastSpell(me, SPELL_THUNDERING_STOMP, false);
                spellTimer = 0;
            }
            if (hpTimer >= 1000)
            {
                if (me->HealthBelowPct(40))
                {
                    Talk(0);
                    me->RemoveAllAuras();
                    me->CastSpell(me, SPELL_SHATTERED_EYES, true);
                    me->ApplySpellImmune(SPELL_SHATTERED_EYES, IMMUNITY_MECHANIC, MECHANIC_STUN, false);
                    me->GetMotionMaster()->MoveCharge(8548, -1956, 1467.8f);
                    charging = true;
                }
                hpTimer = 0;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_iron_watcherAI(creature);
    }
};

enum eTimeLost
{
    NPC_TIME_LOST_PROTO_DRAKE   = 32491,
    NPC_VYRAGOSA                = 32630,

    SPELL_TIME_SHIFT            = 61084,
    SPELL_TIME_LAPSE            = 51020,
    SPELL_FROST_BREATH          = 47425,
    SPELL_FROST_CLEAVE          = 51857,
};

class npc_time_lost_proto_drake : public CreatureScript
{
public:
    npc_time_lost_proto_drake() : CreatureScript("npc_time_lost_proto_drake") { }

    struct npc_time_lost_proto_drakeAI : public npc_escortAI
    {
        npc_time_lost_proto_drakeAI(Creature* creature) : npc_escortAI(creature)
        {
            rollPath = false;
            setVisible = false;
            me->setActive(true);
            me->SetVisible(false);
        }

        EventMap events;
        bool rollPath;
        bool setVisible;

        void Reset() override
        {
            npc_escortAI::Reset();
            if (me->HasUnitState(UNIT_STATE_EVADE))
                return;
            me->SetVisible(false); // pussywizard: zeby nie dostawali info o npc w miejscu spawna (kampienie z addonem npc scan)
            rollPath = true;
        }

        void RollPath()
        {
            me->SetEntry(NPC_TIME_LOST_PROTO_DRAKE);
            Start(true, ObjectGuid::Empty, 0, false, true, true);
            SetNextWaypoint(urand(0, 250), true);
            me->UpdateEntry(roll_chance_i(25) ? NPC_TIME_LOST_PROTO_DRAKE : NPC_VYRAGOSA, 0, false);
        }

        void WaypointReached(uint32  /*pointId*/) override { }

        void JustEngagedWith(Unit*) override
        {
            events.Reset();
            if (me->GetEntry() == NPC_TIME_LOST_PROTO_DRAKE)
            {
                events.ScheduleEvent(SPELL_TIME_SHIFT, 10s);
                events.ScheduleEvent(SPELL_TIME_LAPSE, 5s);
            }
            else
            {
                events.ScheduleEvent(SPELL_FROST_BREATH, 8s);
                events.ScheduleEvent(SPELL_FROST_CLEAVE, 5s);
            }
        }

        void UpdateEscortAI(uint32 diff) override
        {
            if (rollPath)
            {
                RollPath();
                rollPath = false;
                setVisible = true;
                return;
            }

            if (setVisible)
            {
                me->SetVisible(true);
                setVisible = false;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case SPELL_TIME_SHIFT:
                    me->CastSpell(me, SPELL_TIME_SHIFT, false);
                    events.Repeat(18s);
                    break;
                case SPELL_TIME_LAPSE:
                    me->CastSpell(me->GetVictim(), SPELL_TIME_LAPSE, false);
                    events.Repeat(12s);
                    break;
                case SPELL_FROST_BREATH:
                    me->CastSpell(me->GetVictim(), SPELL_FROST_BREATH, false);
                    events.Repeat(12s);
                    break;
                case SPELL_FROST_CLEAVE:
                    me->CastSpell(me->GetVictim(), SPELL_FROST_CLEAVE, false);
                    events.Repeat(8s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_time_lost_proto_drakeAI(creature);
    }
};

enum q13007IronColossus
{
    SPELL_JORMUNGAR_SUBMERGE        = 56504,
    SPELL_JORMUNGAR_EMERGE          = 56508,
    SPELL_JORMUNGAR_SUBMERGE_VISUAL = 56512,
    SPELL_COLOSSUS_GROUND_SLAM      = 61673
};

class spell_q13007_iron_colossus : public SpellScript
{
    PrepareSpellScript(spell_q13007_iron_colossus);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_JORMUNGAR_SUBMERGE_VISUAL, SPELL_COLOSSUS_GROUND_SLAM });
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Creature* caster = GetCaster()->ToCreature();
        if (!caster)
            return;

        if (GetSpellInfo()->Id == SPELL_JORMUNGAR_SUBMERGE)
        {
            caster->CastSpell(caster, SPELL_JORMUNGAR_SUBMERGE_VISUAL, true);
            caster->ApplySpellImmune(SPELL_COLOSSUS_GROUND_SLAM, IMMUNITY_ID, SPELL_COLOSSUS_GROUND_SLAM, true);
            caster->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE);
            caster->SetControlled(false, UNIT_STATE_ROOT);
            for (uint8 i = 0; i < MAX_CREATURE_SPELLS; ++i)
                caster->m_spells[i] = 0;

            caster->m_spells[0] = SPELL_JORMUNGAR_EMERGE;
        }
        else
        {
            caster->RemoveAurasDueToSpell(SPELL_JORMUNGAR_SUBMERGE_VISUAL);
            caster->ApplySpellImmune(SPELL_COLOSSUS_GROUND_SLAM, IMMUNITY_ID, SPELL_COLOSSUS_GROUND_SLAM, false);
            caster->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE);
            caster->SetControlled(true, UNIT_STATE_ROOT);

            if (CreatureTemplate const* ct = sObjectMgr->GetCreatureTemplate(caster->GetEntry()))
                for (uint8 i = 0; i < MAX_CREATURE_SPELLS; ++i)
                    caster->m_spells[i] = ct->spells[i];
        }

        if (Player* player = caster->GetCharmerOrOwnerPlayerOrPlayerItself())
            player->VehicleSpellInitialize();
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q13007_iron_colossus::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

/*######
## npc_roxi_ramrocket
######*/

enum RoxiRamrocket
{
    SPELL_MECHANO_HOG               = 60866,
    SPELL_MEKGINEERS_CHOPPER        = 60867
};

class npc_roxi_ramrocket : public CreatureScript
{
public:
    npc_roxi_ramrocket() : CreatureScript("npc_roxi_ramrocket") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        //Quest Menu
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        //Trainer Menu
        if (creature->IsTrainer())
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, GOSSIP_TEXT_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRAIN);

        //Vendor Menu
        if (creature->IsVendor())
            if (player->HasSpell(SPELL_MECHANO_HOG) || player->HasSpell(SPELL_MEKGINEERS_CHOPPER))
                AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_TRAIN:
                player->GetSession()->SendTrainerList(creature);
                break;
            case GOSSIP_ACTION_TRADE:
                player->GetSession()->SendListInventory(creature->GetGUID());
                break;
        }
        return true;
    }
};

/*######
## npc_brunnhildar_prisoner
######*/

enum BrunnhildarPrisoner
{
    SPELL_ICE_PRISON           = 54894,
    SPELL_ICE_LANCE            = 55046,
    SPELL_FREE_PRISONER        = 55048,
    SPELL_RIDE_DRAKE           = 55074,
    SPELL_SHARD_IMPACT         = 55047
};

class npc_brunnhildar_prisoner : public CreatureScript
{
public:
    npc_brunnhildar_prisoner() : CreatureScript("npc_brunnhildar_prisoner") { }

    struct npc_brunnhildar_prisonerAI : public ScriptedAI
    {
        npc_brunnhildar_prisonerAI(Creature* creature) : ScriptedAI(creature) { }

        bool freed;

        void Reset() override
        {
            freed = false;
            me->CastSpell(me, SPELL_ICE_PRISON, true);
        }

        void JustRespawned() override
        {
            Reset();
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (!freed)
                return;

            if (!me->GetVehicle())
                me->DespawnOrUnsummon();
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (spell->Id != SPELL_ICE_LANCE)
                return;

            if (caster->GetVehicleKit()->GetAvailableSeatCount() != 0)
            {
                me->CastSpell(me, SPELL_FREE_PRISONER, true);
                me->CastSpell(caster, SPELL_RIDE_DRAKE, true);
                me->CastSpell(me, SPELL_SHARD_IMPACT, true);
                freed = true;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_brunnhildar_prisonerAI(creature);
    }
};

/*######
## npc_freed_protodrake
######*/

enum FreedProtoDrake
{
    NPC_DRAKE                           = 29709,

    TEXT_EMOTE                          = 0,

    SPELL_KILL_CREDIT_PRISONER          = 55144,
    SPELL_SUMMON_LIBERATED              = 55073,
    SPELL_KILL_CREDIT_DRAKE             = 55143,

    EVENT_CHECK_AREA                    = 1,
    EVENT_REACHED_HOME                  = 2,
};

class npc_freed_protodrake : public CreatureScript
{
public:
    npc_freed_protodrake() : CreatureScript("npc_freed_protodrake") { }

    struct npc_freed_protodrakeAI : public VehicleAI
    {
        npc_freed_protodrakeAI(Creature* creature) : VehicleAI(creature) { }

        EventMap events;

        void Reset() override
        {
            events.ScheduleEvent(EVENT_CHECK_AREA, 5s);
            me->SetSpeed(MOVE_RUN, 2.0f);
        }

        void MovementInform(uint32 type, uint32  /*id*/) override
        {
            if (type == ESCORT_MOTION_TYPE && me->movespline->Finalized())
                events.ScheduleEvent(EVENT_REACHED_HOME, 2s);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            switch (events.ExecuteEvent())
            {
                case EVENT_CHECK_AREA:
                    if (me->GetAreaId() == AREA_VALLEY_OF_ANCIENT_WINTERS)
                    {
                        if (Vehicle* vehicle = me->GetVehicleKit())
                            if (Unit* passenger = vehicle->GetPassenger(0))
                            {
                                Talk(TEXT_EMOTE, passenger);

                                me->GetMotionMaster()->MovePath(NPC_DRAKE, FORCED_MOVEMENT_NONE, PathSource::WAYPOINT_MGR);
                            }
                    }
                    else
                        events.ScheduleEvent(EVENT_CHECK_AREA, 5s);
                    break;
                case EVENT_REACHED_HOME:
                    if (Vehicle* vehicle = me->GetVehicleKit())
                        if (Unit* player = vehicle->GetPassenger(0))
                            if (player->IsPlayer())
                            {
                                // for each prisoner on drake, give credit
                                for (uint8 i = 1; i < 4; ++i)
                                    if (Unit* prisoner = me->GetVehicleKit()->GetPassenger(i))
                                    {
                                        if (!prisoner->IsCreature())
                                            return;
                                        prisoner->CastSpell(player, SPELL_KILL_CREDIT_PRISONER, true);
                                        prisoner->CastSpell(prisoner, SPELL_SUMMON_LIBERATED, true);
                                        prisoner->ExitVehicle();
                                    }
                                me->CastSpell(me, SPELL_KILL_CREDIT_DRAKE, true);
                                player->ExitVehicle();
                            }
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_freed_protodrakeAI(creature);
    }
};

class npc_icefang : public CreatureScript
{
public:
    npc_icefang() : CreatureScript("npc_icefang") { }

    struct npc_icefangAI : public npc_escortAI
    {
        npc_icefangAI(Creature* creature) : npc_escortAI(creature) { }

        void AttackStart(Unit* /*who*/) override { }
        void JustEngagedWith(Unit* /*who*/) override { }
        void EnterEvadeMode(EvadeReason /*why*/) override { }

        void PassengerBoarded(Unit* who, int8 /*seatId*/, bool apply) override
        {
            if (who->IsPlayer())
            {
                if (apply)
                {
                    me->SetWalk(false);
                    Start(false, who->GetGUID());
                }
            }
        }

        void WaypointReached(uint32 /*waypointId*/) override { }
        void JustDied(Unit* /*killer*/) override { }
        void OnCharmed(bool /*apply*/) override { }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_icefangAI(creature);
    }
};

enum HyldsmeetProtoDrake
{
    NPC_HYLDSMEET_DRAKERIDER = 29694
};

struct npc_hyldsmeet_protodrake : public CreatureAI
{
    explicit npc_hyldsmeet_protodrake(Creature* creature) : CreatureAI(creature), _accessoryRespawnTimer(0) { }

    void PassengerBoarded(Unit* who, int8 /*seat*/, bool apply) override
    {
        if (apply)
            return;

        if (who->GetEntry() == NPC_HYLDSMEET_DRAKERIDER)
            _accessoryRespawnTimer = 5 * MINUTE * IN_MILLISECONDS;
    }

    void UpdateAI(uint32 diff) override
    {
        //! We need to manually reinstall accessories because the vehicle itself is friendly to players,
        //! so EnterEvadeMode is never triggered. The accessory on the other hand is hostile and killable.
        Vehicle* vehicleKit = me->GetVehicleKit();
        if (_accessoryRespawnTimer && _accessoryRespawnTimer <= diff && vehicleKit)
        {
            vehicleKit->InstallAllAccessories(true);
            _accessoryRespawnTimer = 0;
        }
        else
            _accessoryRespawnTimer -= diff;
    }

private:
    uint32 _accessoryRespawnTimer;
};

enum CloseRift
{
    SPELL_DESPAWN_RIFT          = 61665
};

class spell_close_rift_aura : public AuraScript
{
    PrepareAuraScript(spell_close_rift_aura);

    bool Load() override
    {
        _counter = 0;
        return true;
    }

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_DESPAWN_RIFT });
    }

    void HandlePeriodic(AuraEffect const* /* aurEff */)
    {
        if (++_counter == 5)
            GetTarget()->CastSpell((Unit*)nullptr, SPELL_DESPAWN_RIFT, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_close_rift_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }

private:
    uint8 _counter;
};

enum CollapsingCave
{
    SPELL_COLLAPSING_CAVE = 55486
};

// 55693 - Remove Collapsing Cave Aura
class spell_q12823_remove_collapsing_cave_aura : public SpellScript
{
    PrepareSpellScript(spell_q12823_remove_collapsing_cave_aura);

    void HandleScriptEffect(SpellEffIndex /* effIndex */)
    {
        GetHitUnit()->RemoveAurasDueToSpell(SPELL_COLLAPSING_CAVE);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12823_remove_collapsing_cave_aura::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

//Generic Fix for Quest WhenAllElseFails ID: 12862
enum WhenAllElseFailsAlliance
{
    // Creature
    NPC_PROPELLED_DEVICE_1      = 30477,
    NPC_PROPELLED_DEVICE_2      = 30487,

    // Spell
    SPELL_EJECT_PLAYER          = 68576,
    SPELL_KNOCKBACK_PLAYER      = 42895
};

class npc_vehicle_d16_propelled_delivery : public CreatureScript
{
public:
    npc_vehicle_d16_propelled_delivery() : CreatureScript("npc_vehicle_d16_propelled_delivery") { }

    struct npc_vehicle_d16_propelled_deliveryAI : public VehicleAI
    {
        npc_vehicle_d16_propelled_deliveryAI(Creature* creature) : VehicleAI(creature) { }

        void PassengerBoarded(Unit* /*who*/, int8 /*seatId*/, bool apply) override
        {
            if (apply)
            {
                me->GetMotionMaster()->MovePath(me->GetEntry() * 100, FORCED_MOVEMENT_NONE, PathSource::WAYPOINT_MGR);
                me->SetCanFly(true);
                me->SetDisableGravity(true);
                me->SetSpeed(MOVE_RUN, 6.0f);
                me->SetSpeedRate(MOVE_FLIGHT, 8.0f);
                me->setActive(true);
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != ESCORT_MOTION_TYPE)
                return;

            switch (id)
            {
                case 12:
                    if (me->GetEntry() == NPC_PROPELLED_DEVICE_2)
                    {
                        if (Vehicle* vehicle = me->GetVehicleKit())
                        {
                            if (Unit* player = vehicle->GetPassenger(0))
                            {
                                if (player->IsPlayer())
                                {
                                    player->m_Events.AddEventAtOffset([player]()
                                    {
                                        player->CastSpell(player, SPELL_KNOCKBACK_PLAYER, true);
                                    }, 1s);
                                }
                            }
                        }

                        DoCastSelf(SPELL_EJECT_PLAYER);
                    }
                    break;
                case 17:
                    if (me->GetEntry() == NPC_PROPELLED_DEVICE_1)
                    {
                        if (Vehicle* vehicle = me->GetVehicleKit())
                        {
                            if (Unit* player = vehicle->GetPassenger(0))
                            {
                                if (player->IsPlayer())
                                {
                                    player->m_Events.AddEventAtOffset([player]()
                                    {
                                        player->CastSpell(player, SPELL_KNOCKBACK_PLAYER, true);
                                    }, 1s);
                                }
                            }
                        }

                        DoCastSelf(SPELL_EJECT_PLAYER);
                    }
                    else
                    {
                        me->DespawnOrUnsummon(100ms);
                    }
                    break;
                case 24:
                    if (me->GetEntry() == NPC_PROPELLED_DEVICE_1)
                    {
                        me->DespawnOrUnsummon(100ms);
                    }
                    break;
                default:
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_vehicle_d16_propelled_deliveryAI(creature);
    }
};

enum StormcrestEagle
{
    NPC_STORMCREST_EAGLE = 29854
};

// 56393 - Feed Stormcrest Eagle
class spell_feed_stormcrest_eagle : public SpellScript
{
    PrepareSpellScript(spell_feed_stormcrest_eagle);

    SpellCastResult CheckCast()
    {
        if (GetCaster()->FindNearestCreature(NPC_STORMCREST_EAGLE, 15.0f, true))
            return SPELL_CAST_OK;

        return SPELL_FAILED_BAD_TARGETS;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_feed_stormcrest_eagle::CheckCast);
    }
};

enum MammothExplosion
{
    SPELL_MAMMOTH_EXPL_1    = 54627,
    SPELL_MAMMOTH_EXPL_2    = 54628,
    SPELL_MAMMOTH_EXPL_3    = 54623,
    SPELL_MAIN_MAMMOTH_MEAT = 57444
};

// 54581 - Mammoth Explosion Spell Spawner
class spell_mammoth_explosion : public SpellScript
{
    PrepareSpellScript(spell_mammoth_explosion);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_MAMMOTH_EXPL_1, SPELL_MAMMOTH_EXPL_2,  SPELL_MAMMOTH_EXPL_3, SPELL_MAIN_MAMMOTH_MEAT });
    }

    void HandleOnEffectHit(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            for (uint32 spellId : { SPELL_MAMMOTH_EXPL_1, SPELL_MAMMOTH_EXPL_2, SPELL_MAMMOTH_EXPL_3 })
                target->CastSpell(GetHitUnit(), spellId, true);

            target->CastSpell(GetHitUnit(), SPELL_MAIN_MAMMOTH_MEAT, true);

            target->SetVisible(false);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_mammoth_explosion::HandleOnEffectHit, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/*#####
# Quest 13003 Thrusting Hodir's Spear
#####*/

enum WildWyrm
{
    // Phase 1
    SPELL_PLAYER_MOUNT_WYRM             = 56672,
    SPELL_FIGHT_WYRM                    = 56673,
    SPELL_SPEAR_OF_HODIR                = 56671,
    SPELL_GRIP                          = 56689,
    SPELL_GRAB_ON                       = 60533,
    SPELL_DODGE_CLAWS                   = 56704,
    SPELL_THRUST_SPEAR                  = 56690,
    SPELL_MIGHTY_SPEAR_THRUST           = 60586,
    SPELL_CLAW_SWIPE_PERIODIC           = 60689,
    SPELL_CLAW_SWIPE_DAMAGE             = 60776,
    SPELL_FULL_HEAL_MANA                = 32432,
    SPELL_LOW_HEALTH_TRIGGER            = 60596,

    // Phase 2
    SPELL_EJECT_PASSENGER_1             = 60603,
    SPELL_PRY_JAWS_OPEN                 = 56706,
    SPELL_FATAL_STRIKE                  = 60587,
    SPELL_FATAL_STRIKE_DAMAGE           = 60881,
    SPELL_JAWS_OF_DEATH_PERIODIC        = 56692,
    SPELL_FLY_STATE_VISUAL              = 60865,

    // Dead phase
    SPELL_WYRM_KILL_CREDIT              = 56703,
    SPELL_FALLING_DRAGON_FEIGN_DEATH    = 55795,
    SPELL_EJECT_ALL_PASSENGERS          = 50630,

    SAY_SWIPE                           = 0,
    SAY_DODGED                          = 1,
    SAY_PHASE_2                         = 2,
    SAY_GRIP_WARN                       = 3,
    SAY_STRIKE_MISS                     = 4,

    ACTION_CLAW_SWIPE_WARN              = 1,
    ACTION_CLAW_SWIPE_DODGE             = 2,
    ACTION_GRIP_FAILING                 = 3,
    ACTION_GRIP_LOST                    = 4,
    ACTION_FATAL_STRIKE_MISS            = 5,

    POINT_START_FIGHT                   = 1,
    POINT_FALL                          = 2,

    SEAT_INITIAL                        = 0,
    SEAT_MOUTH                          = 1,

    PHASE_INITIAL                       = 0,
    PHASE_MOUTH                         = 1,
    PHASE_DEAD                          = 2,
    PHASE_MAX                           = 3
};

constexpr uint8 ControllableSpellsCount = 4;
constexpr uint32 WyrmControlSpells[PHASE_MAX][ControllableSpellsCount] =
{
    { SPELL_GRAB_ON,       SPELL_DODGE_CLAWS, SPELL_THRUST_SPEAR, SPELL_MIGHTY_SPEAR_THRUST },
    { SPELL_PRY_JAWS_OPEN, 0,                 SPELL_FATAL_STRIKE, 0                         },
    { 0,                   0,                 0,                  0                         }
};

struct npc_wild_wyrm : public VehicleAI
{
    explicit npc_wild_wyrm(Creature* creature) : VehicleAI(creature) { }

    void InitSpellsForPhase()
    {
        ASSERT(_phase < PHASE_MAX);
        for (uint8 i = 0; i < ControllableSpellsCount; ++i)
            me->m_spells[i] = WyrmControlSpells[_phase][i];
    }

    void Reset() override
    {
        _phase = PHASE_INITIAL;

        _playerGuid.Clear();
        scheduler.CancelAll();

        InitSpellsForPhase();

        me->SetImmuneToPC(false);
    }

    void DoAction(int32 action) override
    {
        Player* player = ObjectAccessor::GetPlayer(*me, _playerGuid);
        if (!player)
            return;

        switch (action)
        {
            case ACTION_CLAW_SWIPE_WARN:
                Talk(SAY_SWIPE, player);
                break;
            case ACTION_CLAW_SWIPE_DODGE:
                Talk(SAY_DODGED, player);
                break;
            case ACTION_GRIP_FAILING:
                Talk(SAY_GRIP_WARN, player);
                break;
            case ACTION_GRIP_LOST:
                DoCastAOE(SPELL_EJECT_PASSENGER_1, true);
                break;
            case ACTION_FATAL_STRIKE_MISS:
                Talk(SAY_STRIKE_MISS, player);
                break;
            default:
                break;
        }
    }

    void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
    {
        if (!_playerGuid.IsEmpty() || spellInfo->Id != SPELL_SPEAR_OF_HODIR)
            return;

        _playerGuid = caster->GetGUID();
        DoCastAOE(SPELL_FULL_HEAL_MANA, true);
        me->SetImmuneToPC(true);

        me->GetMotionMaster()->MovePoint(POINT_START_FIGHT, *caster);
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE && type != EFFECT_MOTION_TYPE)
            return;

        switch (id)
        {
            case POINT_START_FIGHT:
            {
                Player* player = ObjectAccessor::GetPlayer(*me, _playerGuid);
                if (!player)
                    return;

                DoCast(player, SPELL_PLAYER_MOUNT_WYRM);
                me->GetMotionMaster()->Clear();
                break;
            }
            case POINT_FALL:
                DoCastAOE(SPELL_EJECT_ALL_PASSENGERS);
                me->KillSelf();
                break;
            default:
                break;
        }
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (damage >= me->GetHealth())
        {
            damage = me->GetHealth() - 1;

            if (_phase == PHASE_DEAD)
                return;

            _phase = PHASE_DEAD;
            scheduler.CancelAll().Async([this]
            {
                InitSpellsForPhase();

                if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGuid))
                    player->VehicleSpellInitialize();

                DoCastAOE(SPELL_WYRM_KILL_CREDIT);
                DoCastAOE(SPELL_FALLING_DRAGON_FEIGN_DEATH);

                me->RemoveAurasDueToSpell(SPELL_JAWS_OF_DEATH_PERIODIC);
                me->RemoveAurasDueToSpell(SPELL_PRY_JAWS_OPEN);

                me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);

                me->GetMotionMaster()->MoveFall(POINT_FALL, true);
            });
        }
    }

    void PassengerBoarded(Unit* passenger, int8 seatId, bool apply) override
    {
        if (!apply)
        {
            // The player is automatically moved from SEAT_INITIAL to SEAT_MOUTH during phase transition.
            // Only evade if player exits during the respective active phase.
            bool initialPhaseExit = (seatId == SEAT_INITIAL && _phase == PHASE_INITIAL);
            bool mouthPhaseExit = (seatId == SEAT_MOUTH && _phase == PHASE_MOUTH);
            if (initialPhaseExit || mouthPhaseExit)
                EnterEvadeMode(EVADE_REASON_NO_HOSTILES);
            return;
        }

        if (passenger->GetGUID() != _playerGuid)
            return;

        if (seatId == SEAT_INITIAL)
        {
            me->CastCustomSpell(SPELL_GRIP, SPELLVALUE_AURA_STACK, 50);
            DoCastAOE(SPELL_CLAW_SWIPE_PERIODIC, true);

            scheduler.Async([this]
            {
                me->GetMotionMaster()->MoveWaypoint(me->GetWaypointPath(), true);
            }).Schedule(500ms, [this](TaskContext context)
            {
                if (_phase == PHASE_MOUTH)
                    return;

                if (me->HealthBelowPct(25))
                {
                    _phase = PHASE_MOUTH;
                    context.Async([this]
                    {
                        InitSpellsForPhase();
                        DoCastAOE(SPELL_LOW_HEALTH_TRIGGER, true);
                        me->RemoveAurasDueToSpell(SPELL_CLAW_SWIPE_PERIODIC);
                        me->RemoveAurasDueToSpell(SPELL_GRIP);

                        if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGuid))
                            Talk(SAY_PHASE_2, player);

                        DoCastAOE(SPELL_EJECT_PASSENGER_1, true);
                        DoCastAOE(SPELL_JAWS_OF_DEATH_PERIODIC);
                        DoCastAOE(SPELL_FLY_STATE_VISUAL);
                    });
                    return;
                }

                context.Repeat();
            });
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!_playerGuid)
        {
            if (UpdateVictim())
                DoMeleeAttackIfReady();
            return;
        }

        scheduler.Update(diff);
    }

private:
    uint8 _phase{PHASE_INITIAL};
    ObjectGuid _playerGuid;
};

// 56689 - Grip
class spell_grip : public AuraScript
{
    PrepareAuraScript(spell_grip);

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        ++_tickNumber;

        // each 15 ticks stack reduction increases by 2 (increases by 1 at each 7th and 15th tick)
        // except for the first 15 ticks that remove 1 stack each
        uint32 const period = ((_tickNumber - 1) % 15) + 1;
        uint32 const sequence = (_tickNumber - 1) / 15;

        uint32 stacksToRemove;
        if (sequence == 0)
            stacksToRemove = 1;
        else
        {
            stacksToRemove = sequence * 2;
            if (period > 7)
                ++stacksToRemove;
        }

        // while we could do ModStackAmount(-stacksToRemove), this is how it's done in sniffs :)
        for (uint32 i = 0; i < stacksToRemove; ++i)
            ModStackAmount(-1, AURA_REMOVE_BY_EXPIRE);

        if (GetStackAmount() < 15 && !_warning)
        {
            _warning = true;
            GetTarget()->GetAI()->DoAction(ACTION_GRIP_FAILING);
        }
        else if (GetStackAmount() > 30)
            _warning = false;
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE)
            return;

        GetTarget()->GetAI()->DoAction(ACTION_GRIP_LOST);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_grip::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);

        AfterEffectRemove += AuraEffectRemoveFn(spell_grip::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }

    // tick number in the AuraEffect gets reset each time we stack the aura, so keep track of it locally
    uint32 _tickNumber = 0;

    bool _warning = false;
};

// 60533 - Grab On
class spell_grab_on : public SpellScript
{
    PrepareSpellScript(spell_grab_on);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Aura* grip = GetCaster()->GetAura(SPELL_GRIP, GetCaster()->GetGUID()))
            grip->ModStackAmount(GetEffectValue(), AURA_REMOVE_BY_DEFAULT, false);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_grab_on::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 56690 - Thrust Spear
// 60586 - Mighty Spear Thrust
class spell_loosen_grip : public SpellScript
{
    PrepareSpellScript(spell_loosen_grip);

public:
    explicit spell_loosen_grip(int8 stacksToLose) : SpellScript(), _stacksToLose(stacksToLose) { }
private:
    int32 _stacksToLose;

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Aura* grip = GetCaster()->GetAura(SPELL_GRIP))
            grip->ModStackAmount(-_stacksToLose, AURA_REMOVE_BY_EXPIRE);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_loosen_grip::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 60596 - Low Health Trigger
class spell_low_health_trigger : public SpellScript
{
    PrepareSpellScript(spell_low_health_trigger);

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ static_cast<uint32>(spellInfo->GetEffect(EFFECT_0).CalcValue()) });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell(static_cast<Unit*>(nullptr), GetEffectValue(), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_low_health_trigger::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 60776 - Claw Swipe
// 60864 - Jaws of Death
class spell_jaws_of_death_claw_swipe_pct_damage : public SpellScript
{
    PrepareSpellScript(spell_jaws_of_death_claw_swipe_pct_damage);

    void HandleDamage(SpellEffIndex /*effIndex*/)
    {
        SetEffectValue(static_cast<int32>(GetHitUnit()->CountPctFromMaxHealth(GetEffectValue())));
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_jaws_of_death_claw_swipe_pct_damage::HandleDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

// 56705 - Claw Swipe
class spell_claw_swipe_check : public AuraScript
{
    PrepareAuraScript(spell_claw_swipe_check);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->GetAI()->DoAction(ACTION_CLAW_SWIPE_WARN);
    }

    void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        if (Vehicle* vehicle = GetTarget()->GetVehicleKit())
        {
            if (Unit* player = vehicle->GetPassenger(SEAT_INITIAL))
            {
                if (player->HasAura(SPELL_DODGE_CLAWS))
                {
                    GetTarget()->GetAI()->DoAction(ACTION_CLAW_SWIPE_DODGE);
                    return;
                }
            }
        }

        GetTarget()->CastSpell(nullptr, aurEff->GetAmount());
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_claw_swipe_check::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectApplyFn(spell_claw_swipe_check::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 60587 - Fatal Strike
class spell_fatal_strike : public SpellScript
{
    PrepareSpellScript(spell_fatal_strike);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FATAL_STRIKE_DAMAGE });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        int32 chance = 0;
        if (AuraEffect const* aurEff = GetCaster()->GetAuraEffect(SPELL_PRY_JAWS_OPEN, EFFECT_0))
            chance = aurEff->GetAmount();

        if (!roll_chance_i(chance))
        {
            GetCaster()->GetAI()->DoAction(ACTION_FATAL_STRIKE_MISS);
            return;
        }

        GetCaster()->CastSpell(static_cast<Unit*>(nullptr), SPELL_FATAL_STRIKE_DAMAGE, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_fatal_strike::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 56672 - Player Mount Wyrm
class spell_player_mount_wyrm : public AuraScript
{
    PrepareAuraScript(spell_player_mount_wyrm);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FIGHT_WYRM });
    }

    void HandleDummy(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->CastSpell(static_cast<Unit*>(nullptr), SPELL_FIGHT_WYRM, true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectApplyFn(spell_player_mount_wyrm::HandleDummy, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 60603 - Eject Passenger 1
class spell_eject_passenger_wild_wyrm : public SpellScript
{
    PrepareSpellScript(spell_eject_passenger_wild_wyrm);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FIGHT_WYRM });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->RemoveAurasDueToSpell(SPELL_FIGHT_WYRM);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_eject_passenger_wild_wyrm::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_storm_peaks()
{
    RegisterCreatureAI(npc_frosthound);
    new npc_iron_watcher();
    new npc_time_lost_proto_drake();
    RegisterSpellScript(spell_q13007_iron_colossus);
    new npc_roxi_ramrocket();
    new npc_brunnhildar_prisoner();
    new npc_freed_protodrake();
    new npc_icefang();
    RegisterCreatureAI(npc_hyldsmeet_protodrake);
    RegisterSpellScript(spell_close_rift_aura);
    new npc_vehicle_d16_propelled_delivery();
    RegisterSpellScript(spell_q12823_remove_collapsing_cave_aura);
    RegisterSpellScript(spell_feed_stormcrest_eagle);
    RegisterSpellScript(spell_mammoth_explosion);
    RegisterCreatureAI(npc_wild_wyrm);
    RegisterSpellScript(spell_grip);
    RegisterSpellScript(spell_grab_on);
    RegisterSpellScriptWithArgs(spell_loosen_grip, "spell_thrust_spear", 5);
    RegisterSpellScriptWithArgs(spell_loosen_grip, "spell_mighty_spear_thrust", 15);
    RegisterSpellScript(spell_low_health_trigger);
    RegisterSpellScript(spell_jaws_of_death_claw_swipe_pct_damage);
    RegisterSpellScript(spell_claw_swipe_check);
    RegisterSpellScript(spell_fatal_strike);
    RegisterSpellScript(spell_player_mount_wyrm);
    RegisterSpellScript(spell_eject_passenger_wild_wyrm);
}
