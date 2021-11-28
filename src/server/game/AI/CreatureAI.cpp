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

#include "CreatureAI.h"
#include "Creature.h"
#include "CreatureAIImpl.h"
#include "CreatureGroups.h"
#include "CreatureTextMgr.h"
#include "Log.h"
#include "MapReference.h"
#include "Player.h"
#include "SpellMgr.h"
#include "Vehicle.h"

class PhasedRespawn : public BasicEvent
{
public:
    PhasedRespawn(Creature& owner) : BasicEvent(), _owner(owner) {}

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        _owner.RespawnOnEvade();
        return true;
    }

private:
    Creature& _owner;
};

//Disable CreatureAI when charmed
void CreatureAI::OnCharmed(bool /*apply*/)
{
    //me->IsAIEnabled = !apply;*/
    me->NeedChangeAI = true;
    me->IsAIEnabled = false;
}

AISpellInfoType* UnitAI::AISpellInfo;
AISpellInfoType* GetAISpellInfo(uint32 i) { return &CreatureAI::AISpellInfo[i]; }

void CreatureAI::Talk(uint8 id, WorldObject const* whisperTarget /*= nullptr*/)
{
    sCreatureTextMgr->SendChat(me, id, whisperTarget);
}

inline bool IsValidCombatTarget(Creature* source, Player* target)
{
    if (target->IsGameMaster())
    {
        return false;
    }

    if (!source->IsInWorld() || !target->IsInWorld())
    {
        return false;
    }

    if (!source->IsAlive() || !target->IsAlive())
    {
        return false;
    }

    if (!source->InSamePhase(target))
    {
        return false;
    }

    if (source->HasUnitState(UNIT_STATE_IN_FLIGHT) || target->HasUnitState(UNIT_STATE_IN_FLIGHT))
    {
        return false;
    }

    return true;
}

void CreatureAI::DoZoneInCombat(Creature* creature /*= nullptr*/, float maxRangeToNearestTarget /*= 250.0f*/)
{
    if (!creature)
    {
        creature = me;
    }

    if (creature->IsInEvadeMode())
    {
        return;
    }

    Map* map = creature->GetMap();
    if (!map->IsDungeon())                                  //use IsDungeon instead of Instanceable, in case battlegrounds will be instantiated
    {
        LOG_ERROR("entities.unit.ai", "DoZoneInCombat call for map that isn't an instance (creature entry = %d)", creature->GetTypeId() == TYPEID_UNIT ? creature->ToCreature()->GetEntry() : 0);
        return;
    }

    Map::PlayerList const& playerList = map->GetPlayers();
    if (playerList.isEmpty())
    {
        return;
    }

    for (Map::PlayerList::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr)
    {
        if (Player* player = itr->GetSource())
        {
            if (!IsValidCombatTarget(creature, player))
            {
                continue;
            }

            if (!creature->IsWithinDistInMap(player, maxRangeToNearestTarget))
            {
                continue;
            }

            creature->SetInCombatWith(player);
            player->SetInCombatWith(creature);

            if (creature->CanHaveThreatList())
            {
                creature->AddThreat(player, 0.0f);
            }

            /* Causes certain things to never leave the threat list (Priest Lightwell, etc):
            for (Unit::ControlSet::const_iterator itr = player->m_Controlled.begin(); itr != player->m_Controlled.end(); ++itr)
            {
                creature->SetInCombatWith(*itr);
                (*itr)->SetInCombatWith(creature);
                creature->AddThreat(*itr, 0.0f);
            }*/
        }
    }
}

// scripts does not take care about MoveInLineOfSight loops
// MoveInLineOfSight can be called inside another MoveInLineOfSight and cause stack overflow
void CreatureAI::MoveInLineOfSight_Safe(Unit* who)
{
    if (m_MoveInLineOfSight_locked)
    {
        return;
    }
    m_MoveInLineOfSight_locked = true;
    MoveInLineOfSight(who);
    m_MoveInLineOfSight_locked = false;
}

void CreatureAI::MoveInLineOfSight(Unit* who)
{
    if (me->GetVictim())
        return;

    // pussywizard: civilian, non-combat pet or any other NOT HOSTILE TO ANYONE (!)
    if (me->IsMoveInLineOfSightDisabled())
        if (me->GetCreatureType() == CREATURE_TYPE_NON_COMBAT_PET ||      // nothing more to do, return
                !who->IsInCombat() ||                                         // if not in combat, nothing more to do
                !me->IsWithinDist(who, ATTACK_DISTANCE, true, false))                      // if in combat and in dist - neutral to all can actually assist other creatures
            return;

    if (me->HasReactState(REACT_AGGRESSIVE) && me->CanStartAttack(who))
        AttackStart(who);
}

// Distract creature, if player gets too close while stealthed/prowling
void CreatureAI::TriggerAlert(Unit const* who) const
{
    // If there's no target, or target isn't a player do nothing
    if (!who || who->GetTypeId() != TYPEID_PLAYER)
        return;
    // If this unit isn't an NPC, is already distracted, is in combat, is confused, stunned or fleeing, do nothing
    if (me->GetTypeId() != TYPEID_UNIT || me->IsInCombat() || me->HasUnitState(UNIT_STATE_CONFUSED | UNIT_STATE_STUNNED | UNIT_STATE_FLEEING | UNIT_STATE_DISTRACTED))
        return;
    // Only alert for hostiles!
    if (me->IsCivilian() || me->HasReactState(REACT_PASSIVE) || !me->IsHostileTo(who) || !me->_IsTargetAcceptable(who))
        return;
    // Only alert if target is within line of sight
    if (!me->IsWithinLOSInMap(who))
        return;
    // Send alert sound (if any) for this creature
    me->SendAIReaction(AI_REACTION_ALERT);
    // Face the unit (stealthed player) and set distracted state for 5 seconds
    me->SetFacingTo(me->GetAngle(who->GetPositionX(), who->GetPositionY()));
    me->StopMoving();
    me->GetMotionMaster()->MoveDistract(5 * IN_MILLISECONDS);
}

void CreatureAI::EnterEvadeMode()
{
    if (!_EnterEvadeMode())
        return;

    LOG_DEBUG("entities.unit", "Creature %u enters evade mode.", me->GetEntry());

    if (!me->GetVehicle()) // otherwise me will be in evade mode forever
    {
        if (Unit* owner = me->GetCharmerOrOwner())
        {
            me->GetMotionMaster()->Clear(false);
            me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, me->GetFollowAngle(), MOTION_SLOT_ACTIVE);
        }
        else
        {
            // Required to prevent attacking creatures that are evading and cause them to reenter combat
            // Does not apply to MoveFollow
            me->AddUnitState(UNIT_STATE_EVADE);
            me->GetMotionMaster()->MoveTargetedHome();
        }
    }

    // despawn bosses at reset - only verified tbc/woltk bosses with this reset type - add bosses in last line respectively (dungeon/raid) and increase array limit
    CreatureTemplate const* cInfo = sObjectMgr->GetCreatureTemplate(me->GetEntry());
    if (cInfo && cInfo->HasFlagsExtra(CREATURE_FLAG_EXTRA_HARD_RESET))
    {
        me->DespawnOnEvade();
        me->m_Events.AddEvent(new PhasedRespawn(*me), me->m_Events.CalculateTime(20000));
    }
    else // bosses will run back to the spawnpoint at reset
    {
        Reset();
        if (me->IsVehicle()) // use the same sequence of addtoworld, aireset may remove all summons!
        {
            me->GetVehicleKit()->Reset(true);
        }
    }
}

/*void CreatureAI::AttackedBy(Unit* attacker)
{
    if (!me->GetVictim())
        AttackStart(attacker);
}*/

void CreatureAI::SetGazeOn(Unit* target)
{
    if (me->IsValidAttackTarget(target))
    {
        AttackStart(target);
        me->SetReactState(REACT_PASSIVE);
    }
}

bool CreatureAI::UpdateVictimWithGaze()
{
    if (!me->IsInCombat())
        return false;

    if (me->HasReactState(REACT_PASSIVE))
    {
        if (me->GetVictim())
            return true;
        else
            me->SetReactState(REACT_AGGRESSIVE);
    }

    if (Unit* victim = me->SelectVictim())
        AttackStart(victim);
    return me->GetVictim();
}

bool CreatureAI::UpdateVictim()
{
    if (!me->IsInCombat())
        return false;

    if (!me->HasReactState(REACT_PASSIVE))
    {
        if (Unit* victim = me->SelectVictim())
            AttackStart(victim);
        return me->GetVictim();
    }
    // xinef: if we have any victim, just return true
    else if (me->GetVictim() && me->GetExactDist(me->GetVictim()) < 30.0f)
        return true;
    else if (me->getThreatMgr().isThreatListEmpty())
    {
        EnterEvadeMode();
        return false;
    }

    return true;
}

bool CreatureAI::_EnterEvadeMode()
{
    if (!me->IsAlive())
    {
        return false;
    }

    // don't remove vehicle auras, passengers aren't supposed to drop off the vehicle
    // don't remove clone caster on evade (to be verified)
    me->RemoveEvadeAuras();

    me->ClearComboPointHolders(); // Remove all combo points targeting this unit
    // sometimes bosses stuck in combat?
    me->DeleteThreatList();
    me->CombatStop(true);
    me->LoadCreaturesAddon(true);
    me->SetLootRecipient(nullptr);
    me->ResetPlayerDamageReq();
    me->SetLastDamagedTime(0);
    me->SetCannotReachTarget(false);

    if (me->IsInEvadeMode())
    {
        return false;
    }
    else if (CreatureGroup* formation = me->GetFormation())
    {
        formation->MemberEvaded(me);
    }

    return true;
}

void CreatureAI::MoveCircleChecks()
{
    Unit *victim = me->GetVictim();

    if (
        !victim ||
        !me->IsFreeToMove() || me->HasUnitMovementFlag(MOVEMENTFLAG_ROOT) ||
        !me->IsWithinMeleeRange(victim) || me == victim->GetVictim() ||
        (victim->GetTypeId() != TYPEID_PLAYER && !victim->IsPet())  // only player & pets to save CPU
    )
    {
        return;
    }

    me->GetMotionMaster()->MoveCircleTarget(me->GetVictim());
}

void CreatureAI::MoveBackwardsChecks() {
    Unit *victim = me->GetVictim();

    if (
        !victim ||
        !me->IsFreeToMove() || me->HasUnitMovementFlag(MOVEMENTFLAG_ROOT) ||
        (victim->GetTypeId() != TYPEID_PLAYER && !victim->IsPet())
    )
    {
        return;
    }

    float moveDist = me->GetMeleeRange(victim) / 2;

    me->GetMotionMaster()->MoveBackwards(victim, moveDist);
}

Creature* CreatureAI::DoSummon(uint32 entry, const Position& pos, uint32 despawnTime, TempSummonType summonType)
{
    return me->SummonCreature(entry, pos, summonType, despawnTime);
}

Creature* CreatureAI::DoSummon(uint32 entry, WorldObject* obj, float radius, uint32 despawnTime, TempSummonType summonType)
{
    Position pos = obj->GetRandomNearPosition(radius);
    return me->SummonCreature(entry, pos, summonType, despawnTime);
}

Creature* CreatureAI::DoSummonFlyer(uint32 entry, WorldObject* obj, float flightZ, float radius, uint32 despawnTime, TempSummonType summonType)
{
    Position pos = obj->GetRandomNearPosition(radius);
    pos.m_positionZ += flightZ;
    return me->SummonCreature(entry, pos, summonType, despawnTime);
}
