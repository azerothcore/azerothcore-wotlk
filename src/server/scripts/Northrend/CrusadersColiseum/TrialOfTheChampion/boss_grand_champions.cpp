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

#include "CombatAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "Vehicle.h"
#include "trial_of_the_champion.h"

enum MountSpells
{
    SPELL_LANCE_EQUIPPED                    = 62853,
    SPELL_PLAYER_VEHICLE_DEFEND             = 66482,
    SPELL_MINIONS_DEFEND                    = 64100,
    SPELL_BOSS_DEFEND_PERIODIC              = 64553,
    SPELL_SHIELD_LEVEL_1_VISUAL             = 63130,
    SPELL_SHIELD_LEVEL_2_VISUAL             = 63131,
    SPELL_SHIELD_LEVEL_3_VISUAL             = 63132,

    SPELL_NPC_SHIELD_BREAKER                = 68504,

    SPELL_MINIONS_CHARGE                    = 63010,

    SPELL_PLAYER_VEHICLE_THRUST             = 68505,

    SPELL_TRAMPLE_STUN                      = 67867,
};

enum ChampionSpells
{
    // Mage (Ambrose Boltspark, Eressea Dawnsinger)
    SPELL_FIREBALL                          = 66042,
    SPELL_BLAST_WAVE                        = 66044,
    SPELL_HASTE                             = 66045,
    SPELL_POLYMORPH                         = 66043,

    // Shaman (Colosos, Runok Wildmane)
    SPELL_CHAIN_LIGHTNING                   = 67529,
    SPELL_EARTH_SHIELD                      = 67530,
    SPELL_HEALING_WAVE                      = 67528,
    SPELL_HEX_OF_MENDING                    = 67534,

    // Hunter (Jaelyne Evensong, Zul'tore)
    SPELL_LIGHTNING_ARROWS                  = 66083,
    SPELL_MULTI_SHOT                        = 66081,
    SPELL_SHOOT                             = 65868,

    // Rogue (Lana Stouthammer, Deathstalker Visceri)
    SPELL_EVISCERATE                        = 67709,
    SPELL_FAN_OF_KNIVES                     = 67706,
    SPELL_POISON_BOTTLE                     = 67701,

    // Warrior (Marshal Jacob Alerius, Mokra the Skullcrusher)
    SPELL_MORTAL_STRIKE                     = 68783,
    SPELL_BLADESTORM                        = 63784,
    SPELL_INTERCEPT                         = 67540,
};

enum Groups
{
    GROUP_DEFEND                            = 0, // keeps the minions' Defend aura refreshed
    GROUP_MOUNT                             = 1, // abilities used while riding a mount
    GROUP_UNMOUNTED                         = 2, // class abilities used once on foot
};

struct npc_toc5_player_vehicle : public VehicleAI
{
    npc_toc5_player_vehicle(Creature* creature) : VehicleAI(creature) { }

    void Reset() override
    {
        me->SetReactState(REACT_PASSIVE);
    }

    void OnCharmed(bool apply) override
    {
        if (me->IsDuringRemoveFromWorld())
            return;

        if (apply)
        {
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetSpeed(MOVE_RUN, 2.0f, false);
            DoCastSelf(SPELL_TRAMPLE_AURA, true);
        }
        else
        {
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->StopMoving();
            me->RemoveAura(SPELL_TRAMPLE_AURA);
        }
    }

    // just in case, should be done in spell_gen_defend
    void PassengerBoarded(Unit* who, int8 /*seat*/, bool apply) override
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

    bool BeforeSpellClick(Unit* clicker) override
    {
        if (!clicker->IsPlayer())
            return true;

        if (clicker->IsInDisallowedMountForm())
            clicker->RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);

        if (clicker->HasAura(SPELL_LANCE_EQUIPPED))
            return true;

        WorldPacket data(SMSG_CAST_FAILED, 1 + 4 + 1);
        data << uint8(0); // single cast or multi 2.3 (0/1)
        data << uint32(VEHICLE_SPELL_RIDE_HARDCODED);
        data << uint8(SPELL_FAILED_CUSTOM_ERROR);
        data << uint32(SPELL_CUSTOM_ERROR_MUST_HAVE_LANCE_EQUIPPED);
        clicker->ToPlayer()->SendDirectMessage(&data);
        return false;
    }
};

struct npc_toc5_grand_champion_minion : public CreatureAI
{
    npc_toc5_grand_champion_minion(Creature* creature) : CreatureAI(creature), _instance(creature->GetInstanceScript())
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        scheduler.CancelAll();

        // the minions are defended from the moment they spawn, not only from the engage
        scheduler.Schedule(0ms, GROUP_DEFEND, [this](TaskContext context)
        {
            DoCastSelf(SPELL_MINIONS_DEFEND, true);
            context.Repeat(5s);
        });
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (_instance && _instance->GetData(DATA_INSTANCE_PROGRESS) >= INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST)
            CreatureAI::MoveInLineOfSight(who);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        ScheduleMountAbilities();
        DoCastSelf(SPELL_TRAMPLE_AURA, true);
    }

    void ScheduleMountAbilities()
    {
        scheduler.CancelGroup(GROUP_MOUNT);

        scheduler.Schedule(2500ms, 4s, GROUP_MOUNT, [this](TaskContext context)
        {
            GuidVector targetList;
            Map::PlayerList const& players = me->GetMap()->GetPlayers();
            for (auto const& ref : players)
                if (Player* player = ref.GetSource())
                {
                    if (me->GetExactDist(player) < 8.0f || me->GetExactDist(player) > 25.0f || player->isDead())
                        continue;
                    if (!player->GetVehicle())
                        targetList.push_back(player->GetGUID());
                    else if (Vehicle* vehicle = player->GetVehicle())
                    {
                        if (Unit* mount = vehicle->GetBase())
                            targetList.push_back(mount->GetGUID());
                    }
                }
            if (!targetList.empty())
            {
                uint8 randomIndex = targetList.size() > 1 ? urand(0, targetList.size() - 1) : 0;
                if (Unit* target = ObjectAccessor::GetUnit(*me, targetList.at(randomIndex)))
                {
                    me->GetThreatMgr().ResetAllThreat();
                    me->AddThreat(target, 10000.0f);
                    AttackStart(target);
                    DoCast(target, SPELL_MINIONS_CHARGE);
                }
            }
            context.Repeat(4500ms, 6s);
        });

        scheduler.Schedule(5s, 8s, GROUP_MOUNT, [this](TaskContext context)
        {
            GuidVector targetList;
            Map::PlayerList const& players = me->GetMap()->GetPlayers();
            for (auto const& ref : players)
                if (Player* player = ref.GetSource())
                {
                    if (me->GetExactDist(player) < 10.0f || me->GetExactDist(player) > 30.0f)
                        continue;
                    if (Vehicle* vehicle = player->GetVehicle())
                        if (Unit* mount = vehicle->GetBase())
                            targetList.push_back(mount->GetGUID());
                }
            if (!targetList.empty())
            {
                uint8 randomIndex = targetList.size() > 1 ? urand(0, targetList.size() - 1) : 0;
                if (Unit* target = ObjectAccessor::GetCreature(*me, targetList.at(randomIndex)))
                    DoCast(target, SPELL_NPC_SHIELD_BREAKER);
            }
            context.Repeat(6s, 8s);
        });

        scheduler.Schedule(3s, 5s, GROUP_MOUNT, [this](TaskContext context)
        {
            if (Unit* victim = me->GetVictim())
                if (me->GetExactDist(victim) <= 5.5f)
                    DoCast(victim, SPELL_PLAYER_VEHICLE_THRUST);
            context.Repeat(3s, 5s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        UpdateVictim();

        scheduler.Update(diff);
    }

    void JustDied(Unit* /*killer*/) override
    {
        me->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0);
        me->DespawnOrUnsummon(10s);
        if (_instance)
            _instance->SetData(DATA_MOUNT_DIED, 0);
    }

private:
    InstanceScript* _instance;
};

struct boss_grand_champion : public npc_escortAI
{
    boss_grand_champion(Creature* creature) : npc_escortAI(creature), _instance(creature->GetInstanceScript()),
        _isWarrior(creature->GetEntry() == NPC_JACOB || creature->GetEntry() == NPC_MOKRA)
    {
        SetDespawnAtEnd(false);
        me->SetReactState(REACT_PASSIVE);
        DoCastSelf(SPELL_BOSS_DEFEND_PERIODIC, true);

        scheduler.SetValidator([this]
        {
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return false;

            // the warrior's Bladestorm holds its other abilities
            return !_isWarrior || !me->HasAura(SPELL_BLADESTORM);
        });

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

    void Reset() override
    {
        if (_instance && _instance->GetData(DATA_INSTANCE_PROGRESS) == INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED)
        {
            DoAction(ACTION_DISMOUNT);
            DoAction(ACTION_ENABLE_CHAMPION_ABILITIES);
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetImmuneToAll(false);
            me->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0);
            me->SetReactState(REACT_AGGRESSIVE);
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (_instance && _instance->GetData(DATA_INSTANCE_PROGRESS) >= INSTANCE_PROGRESS_GRAND_CHAMPIONS_REACHED_DEST)
            ScriptedAI::MoveInLineOfSight(who);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        // the mount abilities are scheduled at the engage, their timers were frozen while the champion walked in
        if (_mountPhase && me->GetMountID())
        {
            ScheduleMountAbilities();
            return;
        }

        if (_instance && _instance->GetData(DATA_INSTANCE_PROGRESS) == INSTANCE_PROGRESS_CHAMPIONS_UNMOUNTED)
            me->CallForHelp(100.0f);
    }

    void ScheduleMountAbilities()
    {
        scheduler.CancelGroup(GROUP_MOUNT);

        scheduler.Schedule(2500ms, 4s, GROUP_MOUNT, [this](TaskContext context)
        {
            GuidVector targetList;
            Map::PlayerList const& players = me->GetMap()->GetPlayers();
            for (auto const& ref : players)
                if (Player* player = ref.GetSource())
                {
                    if (me->GetExactDist(player) < 8.0f || me->GetExactDist(player) > 25.0f || player->isDead())
                        continue;
                    if (!player->GetVehicle())
                        targetList.push_back(player->GetGUID());
                    else if (Vehicle* vehicle = player->GetVehicle())
                    {
                        if (Unit* mount = vehicle->GetBase())
                            targetList.push_back(mount->GetGUID());
                    }
                }
            if (!targetList.empty())
            {
                uint8 randomIndex = targetList.size() > 1 ? urand(0, targetList.size() - 1) : 0;
                if (Unit* target = ObjectAccessor::GetUnit(*me, targetList.at(randomIndex)))
                {
                    me->GetThreatMgr().ResetAllThreat();
                    me->AddThreat(target, 10000.0f);
                    AttackStart(target);
                    DoCast(target, SPELL_MINIONS_CHARGE);
                }
            }
            context.Repeat(4500ms, 6s);
        });

        scheduler.Schedule(5s, 8s, GROUP_MOUNT, [this](TaskContext context)
        {
            GuidVector targetList;
            Map::PlayerList const& players = me->GetMap()->GetPlayers();
            for (auto const& ref : players)
                if (Player* player = ref.GetSource())
                {
                    if (me->GetExactDist(player) < 10.0f || me->GetExactDist(player) > 30.0f)
                        continue;
                    if (Vehicle* vehicle = player->GetVehicle())
                        if (Unit* mount = vehicle->GetBase())
                            targetList.push_back(mount->GetGUID());
                }
            if (!targetList.empty())
            {
                uint8 randomIndex = targetList.size() > 1 ? urand(0, targetList.size() - 1) : 0;
                if (Unit* target = ObjectAccessor::GetCreature(*me, targetList.at(randomIndex)))
                    DoCast(target, SPELL_NPC_SHIELD_BREAKER);
            }
            context.Repeat(6s, 8s);
        });

        scheduler.Schedule(3s, 5s, GROUP_MOUNT, [this](TaskContext context)
        {
            if (Unit* victim = me->GetVictim())
                if (me->GetExactDist(victim) <= 6.0f)
                    DoCast(victim, SPELL_PLAYER_VEHICLE_THRUST);
            context.Repeat(3s, 5s);
        });
    }

    void ScheduleChampionAbilities()
    {
        me->m_spellImmune[IMMUNITY_MECHANIC].clear();
        scheduler.CancelGroup(GROUP_UNMOUNTED);

        switch (me->GetEntry())
        {
            case NPC_AMBROSE:
            case NPC_ERESSEA:
                scheduler.Schedule(5s, GROUP_UNMOUNTED, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_FIREBALL);
                    context.Repeat(5s);
                });
                scheduler.Schedule(12s, GROUP_UNMOUNTED, [this](TaskContext context)
                {
                    DoCastAOE(SPELL_BLAST_WAVE);
                    context.Repeat(13s);
                });
                scheduler.Schedule(22s, GROUP_UNMOUNTED, [this](TaskContext context)
                {
                    DoCastSelf(SPELL_HASTE);
                    context.Repeat(22s);
                });
                scheduler.Schedule(8s, GROUP_UNMOUNTED, [this](TaskContext context)
                {
                    DoCastRandomTarget(SPELL_POLYMORPH, 0, 30.0f, true);
                    context.Repeat(8s);
                });
                break;
            case NPC_COLOSOS:
            case NPC_RUNOK:
                scheduler.Schedule(16s, GROUP_UNMOUNTED, [this](TaskContext context)
                {
                    DoCastRandomTarget(SPELL_CHAIN_LIGHTNING, 0, 30.0f, true);
                    context.Repeat(16s);
                });
                scheduler.Schedule(30s, 35s, GROUP_UNMOUNTED, [this](TaskContext context)
                {
                    DoCastSelf(SPELL_EARTH_SHIELD);
                    context.Repeat(30s, 35s);
                });
                scheduler.Schedule(12s, GROUP_UNMOUNTED, [this](TaskContext context)
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
                    DoCast(target, SPELL_HEALING_WAVE);
                    context.Repeat(22s);
                });
                scheduler.Schedule(20s, 25s, GROUP_UNMOUNTED, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_HEX_OF_MENDING);
                    context.Repeat(20s, 25s);
                });
                break;
            case NPC_JAELYNE:
            case NPC_ZULTORE:
                scheduler.Schedule(7s, GROUP_UNMOUNTED, [this](TaskContext context)
                {
                    DoCastAOE(SPELL_LIGHTNING_ARROWS);
                    context.Repeat(20s, 25s);
                });
                scheduler.Schedule(12s, GROUP_UNMOUNTED, [this](TaskContext context)
                {
                    if (!_unitTargetGUID)
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::MinDistance, 0, 30.0f, true))
                        {
                            DoCast(target, SPELL_SHOOT);
                            _unitTargetGUID = target->GetGUID();
                        }
                        context.Repeat(2s);
                        return;
                    }

                    Unit* target = ObjectAccessor::GetUnit(*me, _unitTargetGUID);
                    if (target && me->IsInRange(target, 5.0f, 30.0f, false))
                        DoCast(target, SPELL_MULTI_SHOT);
                    else
                        for (auto const& ref : me->GetMap()->GetPlayers())
                            if (Player* player = ref.GetSource())
                                if (me->IsInRange(player, 5.0f, 30.0f, false))
                                {
                                    DoCast(player, SPELL_MULTI_SHOT);
                                    break;
                                }

                    _unitTargetGUID.Clear();
                    context.Repeat(15s, 20s);
                });
                break;
            case NPC_LANA:
            case NPC_VISCERI:
                scheduler.Schedule(8s, GROUP_UNMOUNTED, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_EVISCERATE);
                    context.Repeat(8s);
                });
                scheduler.Schedule(14s, GROUP_UNMOUNTED, [this](TaskContext context)
                {
                    DoCastAOE(SPELL_FAN_OF_KNIVES);
                    context.Repeat(14s);
                });
                scheduler.Schedule(19s, GROUP_UNMOUNTED, [this](TaskContext context)
                {
                    DoCastRandomTarget(SPELL_POISON_BOTTLE, 0, 30.0f, true);
                    context.Repeat(19s);
                });
                break;
            case NPC_JACOB:
            case NPC_MOKRA:
                scheduler.Schedule(8s, 12s, GROUP_UNMOUNTED, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_MORTAL_STRIKE);
                    context.Repeat(8s, 12s);
                });
                scheduler.Schedule(15s, 20s, GROUP_UNMOUNTED, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_BLADESTORM);
                    context.Repeat(15s, 20s);
                });
                scheduler.Schedule(7s, GROUP_UNMOUNTED, [this](TaskContext context)
                {
                    for (auto const& ref : me->GetMap()->GetPlayers())
                    {
                        Player* player = ref.GetSource();
                        if (player && me->IsInRange(player, 8.0f, 25.0f, false))
                        {
                            DoResetThreatList();
                            me->AddThreat(player, 5.0f);
                            DoCast(player, SPELL_INTERCEPT);
                            break;
                        }
                    }
                    context.Repeat(7s);
                });
                break;
            default:
                break;
        }
    }

    void AddCreatureAddonAuras()
    {
        CreatureAddon const* addon = me->GetCreatureAddon();
        if (!addon)
            return;

        for (uint32 auraId : addon->auras)
        {
            if (!sSpellMgr->GetSpellInfo(auraId) || me->HasAura(auraId))
                continue;

            me->AddAura(auraId, me);
        }
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_DISMOUNT)
        {
            _mountPhase = false;
            _newMountGUID.Clear();
            me->SetHealth(me->GetMaxHealth());
            me->SetRegeneratingHealth(true);
            me->RemoveUnitFlag(UNIT_FLAG_PACIFIED);
            me->SetSpeed(MOVE_RUN, 1.0f, false);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetImmuneToAll(true);
            me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
            me->RemoveAllAuras();
            AddCreatureAddonAuras();
            scheduler.CancelGroupsOf({ GROUP_MOUNT, GROUP_UNMOUNTED });
        }
        else if (action == ACTION_ENABLE_CHAMPION_ABILITIES)
            ScheduleChampionAbilities();
    }

    void SetData(uint32 type, uint32 data) override
    {
        _bossOrder = type;
        if (data > 1)
            return;

        switch (_bossOrder)
        {
            case 0:
                if (data == 0) // 1 == short version
                {
                    AddWaypoint(0, 747.36f, 634.07f, 411.572f);
                    AddWaypoint(1, 780.43f, 607.15f, 411.82f);
                }
                AddWaypoint(2, 785.99f, 599.41f, 411.92f);
                AddWaypoint(3, 778.44f, 601.64f, 411.79f);
                break;
            case 1:
                if (data == 0) // 1 == short version
                {
                    AddWaypoint(0, 747.35f, 634.07f, 411.57f);
                    AddWaypoint(1, 768.72f, 581.01f, 411.92f);
                }
                AddWaypoint(2, 763.55f, 590.52f, 411.71f);
                break;
            case 2:
                if (data == 0) // 1 == short version
                {
                    AddWaypoint(0, 747.35f, 634.07f, 411.57f);
                    AddWaypoint(1, 784.02f, 645.33f, 412.39f);
                }
                AddWaypoint(2, 775.67f, 641.91f, 411.91f);
                break;
            default:
                return;
        }

        Start(false);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/,
        SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (_mountPhase)
        {
            if (me->GetMountID() == 0)
                damage = 0;
            else if (damage >= me->GetHealth())
            {
                scheduler.CancelGroupsOf({ GROUP_MOUNT, GROUP_UNMOUNTED });
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
                if (_instance)
                {
                    _instance->SetData(DATA_MOUNT_DIED, _bossOrder);
                    uint32 const mountEntry = _instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE
                        ? VEHICLE_ARGENT_WARHORSE : VEHICLE_ARGENT_BATTLEWORG;
                    if (Creature* mount = me->FindNearestCreature(mountEntry, 100.0f, true))
                    {
                        _newMountGUID = mount->GetGUID();
                        me->GetMotionMaster()->MovePoint(POINT_CHAMPION_NEW_MOUNT, *mount);
                        ScheduleFindNewMount();
                    }
                }
            }
        }
        else if (damage >= me->GetHealth())
        {
            _mountPhase = true;
            scheduler.CancelGroupsOf({ GROUP_MOUNT, GROUP_UNMOUNTED });
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
            if (_instance)
                _instance->SetData(DATA_GRAND_CHAMPION_DIED, _bossOrder);
        }
    }

    void ScheduleFindNewMount()
    {
        scheduler.Schedule(1s, GROUP_MOUNT, [this](TaskContext context)
        {
            if (!_instance)
                return;

            if (me->HasAura(SPELL_TRAMPLE_STUN))
            {
                context.Repeat(200ms);
                return;
            }

            // hackfix, trample won't hit grand champions because of UNIT_FLAG_NON_ATTACKABLE
            uint32 const playerMountEntry = _instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE
                ? VEHICLE_ARGENT_BATTLEWORG : VEHICLE_ARGENT_WARHORSE;
            bool trampled = false;
            for (auto const& ref : me->GetMap()->GetPlayers())
                if (Player* player = ref.GetSource())
                    if (me->GetExactDist(player) <= 5.0f)
                        if (Vehicle* vehicle = player->GetVehicle())
                            if (Unit* mount = vehicle->GetBase())
                                if (mount->IsCreature() && mount->ToCreature()->GetEntry() == playerMountEntry)
                                {
                                    me->GetMotionMaster()->MovementExpired();
                                    me->GetMotionMaster()->MoveIdle();
                                    me->StopMoving();
                                    DoCastSelf(SPELL_TRAMPLE_STUN);
                                    trampled = true;
                                    break;
                                }

            if (trampled)
            {
                context.Repeat(15s);
                return;
            }

            if (Creature* mount = ObjectAccessor::GetCreature(*me, _newMountGUID))
                if (mount->IsAlive())
                {
                    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE)
                        me->GetMotionMaster()->MovePoint(POINT_CHAMPION_NEW_MOUNT, *mount);
                    context.Repeat(200ms);
                    return;
                }

            uint32 const mountEntry = _instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE
                ? VEHICLE_ARGENT_WARHORSE : VEHICLE_ARGENT_BATTLEWORG;
            if (Creature* mount = me->FindNearestCreature(mountEntry, 100.0f, true))
            {
                me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                _newMountGUID = mount->GetGUID();
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetImmuneToAll(true);
                me->GetMotionMaster()->MovePoint(POINT_CHAMPION_NEW_MOUNT, *mount);
                context.Repeat(200ms);
            }
        });
    }

    // the champions stay where they are when their target dies, the instance drives the fight
    void EnterEvadeMode(EvadeReason /*why*/) override {}

    using CreatureAI::WaypointReached;
    void WaypointReached(uint32 point) override
    {
        if (!_instance)
            return;

        // the last waypoint of the path walked in on is where the instance sends the next group
        if ((point == 2 && (_bossOrder == 1 || _bossOrder == 2)) || (point == 3 && _bossOrder == 0))
            _instance->SetData(DATA_GRAND_CHAMPION_REACHED_DEST, _bossOrder);
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (id < 4)
            npc_escortAI::MovementInform(type, id);

        if (type != POINT_MOTION_TYPE)
            return;

        switch (id)
        {
            case POINT_CHAMPION_MOVE_SIDE:
                me->SetFacingTo(3 * M_PI / 2);
                break;
            case POINT_CHAMPION_NEW_MOUNT:
                if (_newMountGUID)
                    if (Creature* mount = ObjectAccessor::GetCreature(*me, _newMountGUID))
                    {
                        mount->DespawnOrUnsummon();
                        me->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, mount->GetDisplayId());
                        me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        me->SetHealth(50000);
                        DoCastSelf(SPELL_BOSS_DEFEND_PERIODIC, true);
                        me->SetRegeneratingHealth(true);
                        ScheduleMountAbilities();
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        me->SetImmuneToAll(false);
                        if (Unit* target = me->SelectNearestTarget(200.0f))
                            AttackStart(target);
                        DoZoneInCombat();
                        DoCastSelf(SPELL_TRAMPLE_AURA, true);
                        if (_instance)
                            _instance->SetData(DATA_REACHED_NEW_MOUNT, 0);
                        _newMountGUID.Clear();
                    }
                break;
            case POINT_CHAMPION_LEAVE_ARENA:
                me->DespawnOrUnsummon();
                break;
            default:
                break;
        }
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_TRAMPLE_STUN)
            Talk(SAY_TRAMPLED, me);
    }

    void UpdateAI(uint32 diff) override
    {
        npc_escortAI::UpdateAI(diff);

        if (!UpdateVictim() && !_newMountGUID)
            return;

        scheduler.Update(diff);

        // the abilities are held by the scheduler validator, Bladestorm also holds the melee swing
        if (_isWarrior && me->HasAura(SPELL_BLADESTORM))
            return;

        DoMeleeAttackIfReady();
    }

private:
    InstanceScript* _instance;
    bool _isWarrior = false;
    uint32 _bossOrder = 0;
    bool _mountPhase = true;
    ObjectGuid _newMountGUID;
    ObjectGuid _unitTargetGUID;
};

void AddSC_boss_grand_champions()
{
    RegisterTrialOfTheChampionCreatureAI(boss_grand_champion);
    RegisterTrialOfTheChampionCreatureAI(npc_toc5_grand_champion_minion);
    RegisterTrialOfTheChampionCreatureAI(npc_toc5_player_vehicle);
}
