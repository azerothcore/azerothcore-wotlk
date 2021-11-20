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

#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "Transport.h"
#include "UpdateData.h"
#include "WorldPacket.h"

using namespace Acore;

void VisibleNotifier::Visit(GameObjectMapType& m)
{
    for (auto const& iter : m)
    {
        GameObject* go = iter.GetSource();
        if (i_largeOnly != go->IsVisibilityOverridden())
        {
            continue;
        }

        vis_guids.erase(go->GetGUID());
        i_player.UpdateVisibilityOf(go, i_data, i_visibleNow);
    }
}

void VisibleNotifier::SendToSelf()
{
    // at this moment i_clientGUIDs have guids that not iterate at grid level checks
    // but exist one case when this possible and object not out of range: transports
    if (Transport* transport = i_player.GetTransport())
    {
        for (auto const& object : transport->GetPassengers())
        {
            if (i_largeOnly != object->IsVisibilityOverridden())
            {
                continue;
            }

            if (vis_guids.find(object->GetGUID()) != vis_guids.end())
            {
                vis_guids.erase(object->GetGUID());

                switch (object->GetTypeId())
                {
                case TYPEID_GAMEOBJECT:
                    i_player.UpdateVisibilityOf(object->ToGameObject(), i_data, i_visibleNow);
                    break;
                case TYPEID_PLAYER:
                    i_player.UpdateVisibilityOf(object->ToPlayer(), i_data, i_visibleNow);
                    object->ToPlayer()->UpdateVisibilityOf(&i_player);
                    break;
                case TYPEID_UNIT:
                    i_player.UpdateVisibilityOf(object->ToCreature(), i_data, i_visibleNow);
                    break;
                default:
                    break;
                }
            }
        }
    }

    for (auto const& guid : vis_guids)
    {
        if (WorldObject* obj = ObjectAccessor::GetWorldObject(i_player, guid))
        {
            if (i_largeOnly != obj->IsVisibilityOverridden())
            {
                continue;
            }
        }

        // pussywizard: static transports are removed only in RemovePlayerFromMap and here if can no longer detect (eg. phase changed)
        if (guid.IsTransport())
        {
            if (GameObject* staticTrans = i_player.GetMap()->GetGameObject(guid))
            {
                if (i_player.CanSeeOrDetect(staticTrans, false, true))
                {
                    continue;
                }
            }
        }

        i_player.m_clientGUIDs.erase(guid);
        i_data.AddOutOfRangeGUID(guid);

        if (guid.IsPlayer())
        {
            Player* player = ObjectAccessor::FindPlayer(guid);

            if (player && player->IsInMap(&i_player))
            {
                player->UpdateVisibilityOf(&i_player);
            }
        }
    }

    if (!i_data.HasData())
    {
        return;
    }

    WorldPacket packet;
    i_data.BuildPacket(&packet);
    i_player.GetSession()->SendPacket(&packet);

    for (auto const& unit : i_visibleNow)
    {
        if (i_largeOnly != unit->IsVisibilityOverridden())
        {
            continue;
        }

        i_player.GetInitialVisiblePackets(unit);
    }
}

void VisibleChangesNotifier::Visit(PlayerMapType& m)
{
    for (auto const& gridPlayer : m)
    {
        Player* player = gridPlayer.GetSource();

        if (player == &i_object)
        {
            continue;
        }

        player->UpdateVisibilityOf(&i_object);

        if (player->HasSharedVision())
        {
            for (auto const& _player : player->GetSharedVisionList())
            {
                if (_player->m_seer == player)
                {
                    _player->UpdateVisibilityOf(&i_object);
                }
            }
        }
    }
}

void VisibleChangesNotifier::Visit(CreatureMapType& m)
{
    for (auto const& gridPlayer : m)
    {
        if (gridPlayer.GetSource()->HasSharedVision())
        {
            for (auto const& _player : gridPlayer.GetSource()->GetSharedVisionList())
            {
                if (_player->m_seer == gridPlayer.GetSource())
                {
                    _player->UpdateVisibilityOf(&i_object);
                }
            }
        }
    }
}

void VisibleChangesNotifier::Visit(DynamicObjectMapType& m)
{
    for (auto const& gridDynamicObject : m)
    {
        if (gridDynamicObject.GetSource()->GetCasterGUID().IsPlayer())
        {
            if (Unit* caster = gridDynamicObject.GetSource()->GetCaster())
            {
                if (Player* player = caster->ToPlayer())
                {
                    if (player->m_seer == gridDynamicObject.GetSource())
                    {
                        player->UpdateVisibilityOf(&i_object);
                    }
                }
            }
        }
    }
}

inline void CreatureUnitRelocationWorker(Creature* c, Unit* u)
{
    if (!u->IsAlive() || !c->IsAlive() || c == u || u->IsInFlight())
    {
        return;
    }

    if (!c->HasUnitState(UNIT_STATE_SIGHTLESS))
    {
        if (c->IsAIEnabled && c->CanSeeOrDetect(u, false, true))
        {
            c->AI()->MoveInLineOfSight_Safe(u);
        }
        else if (u->GetTypeId() == TYPEID_PLAYER && u->HasStealthAura() && c->IsAIEnabled && c->CanSeeOrDetect(u, false, true, true))
        {
            c->AI()->TriggerAlert(u);
        }
    }
}

void PlayerRelocationNotifier::Visit(PlayerMapType& m)
{
    for (auto const& gridReference : m)
    {
        Player* player = gridReference.GetSource();
        vis_guids.erase(player->GetGUID());
        i_player.UpdateVisibilityOf(player, i_data, i_visibleNow);
        player->UpdateVisibilityOf(&i_player); // this notifier with different Visit(PlayerMapType&) than VisibleNotifier is needed to update visibility of self for other players when we move (eg. stealth detection changes)
    }
}

void CreatureRelocationNotifier::Visit(PlayerMapType& m)
{
    for (auto const& gridPlayer : m)
    {
        Player* player = gridPlayer.GetSource();

        // NOTIFY_VISIBILITY_CHANGED does not guarantee that player will do it himself (because distance is also checked), but screw it, it's not that important
        if (!player->m_seer->isNeedNotify(NOTIFY_VISIBILITY_CHANGED))
        {
            player->UpdateVisibilityOf(&i_creature);
        }

        // NOTIFY_AI_RELOCATION does not guarantee that player will do it himself (because distance is also checked), but screw it, it's not that important
        if (!player->m_seer->isNeedNotify(NOTIFY_AI_RELOCATION) && !i_creature.IsMoveInLineOfSightStrictlyDisabled())
        {
            CreatureUnitRelocationWorker(&i_creature, player);
        }
    }
}

void AIRelocationNotifier::Visit(CreatureMapType& m)
{
    bool self = isCreature && !((Creature*)(&i_unit))->IsMoveInLineOfSightStrictlyDisabled();

    for (auto const& gridPlayer : m)
    {
        Creature* creature = gridPlayer.GetSource();

        // NOTIFY_VISIBILITY_CHANGED | NOTIFY_AI_RELOCATION does not guarantee that unit will do it itself (because distance is also checked), but screw it, it's not that important
        if (!creature->isNeedNotify(NOTIFY_VISIBILITY_CHANGED | NOTIFY_AI_RELOCATION) && !creature->IsMoveInLineOfSightStrictlyDisabled())
        {
            CreatureUnitRelocationWorker(creature, &i_unit);
        }

        if (self)
        {
            CreatureUnitRelocationWorker((Creature*)&i_unit, creature);
        }
    }
}

void MessageDistDeliverer::Visit(PlayerMapType& m)
{
    for (auto const& gridPlayer : m)
    {
        Player* target = gridPlayer.GetSource();
        if (!target->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (target->GetExactDist2dSq(i_source) > i_distSq)
        {
            continue;
        }

        // Send packet to all who are sharing the player's vision
        if (target->HasSharedVision())
        {
            for (auto const& i : target->GetSharedVisionList())
            {
                if (i->m_seer == target)
                {
                    SendPacket(i);
                }
            }
        }

        if (target->m_seer == target || target->GetVehicle())
        {
            SendPacket(target);
        }
    }
}

void MessageDistDeliverer::Visit(CreatureMapType& m)
{
    for (auto const& gridCreature : m)
    {
        Creature* target = gridCreature.GetSource();
        if (!target->HasSharedVision() || !target->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (target->GetExactDist2dSq(i_source) > i_distSq)
        {
            continue;
        }

        // Send packet to all who are sharing the creature's vision
        for (auto const& _player : target->GetSharedVisionList())
        {
            if (_player->m_seer == target)
            {
                SendPacket(_player);
            }
        }
    }
}

void MessageDistDeliverer::Visit(DynamicObjectMapType& m)
{
    for (auto const& gridDynamicObject : m)
    {
        DynamicObject* target = gridDynamicObject.GetSource();
        if (!target->GetCasterGUID().IsPlayer() || !target->InSamePhase(i_phaseMask))
        {
            continue;
        }

        // Xinef: Check whether the dynobject allows to see through it
        if (!target->IsViewpoint())
        {
            continue;
        }

        if (target->GetExactDist2dSq(i_source) > i_distSq)
        {
            continue;
        }

        // Send packet back to the caster if the caster has vision of dynamic object
        Player* caster = (Player*)target->GetCaster();
        if (caster && caster->m_seer == target)
        {
            SendPacket(caster);
        }
    }
}

void MessageDistDelivererToHostile::Visit(PlayerMapType& m)
{
    for (auto const& gridPlayer : m)
    {
        Player* target = gridPlayer.GetSource();
        if (!target->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (target->GetExactDist2dSq(i_source) > i_distSq)
        {
            continue;
        }

        // Send packet to all who are sharing the player's vision
        if (target->HasSharedVision())
        {
            for (auto const& _player : target->GetSharedVisionList())
            {
                if (_player->m_seer == target)
                {
                    SendPacket(_player);
                }
            }
        }

        if (target->m_seer == target || target->GetVehicle())
        {
            SendPacket(target);
        }
    }
}

void MessageDistDelivererToHostile::Visit(CreatureMapType& m)
{
    for (auto const& gridCreature : m)
    {
        Creature* target = gridCreature.GetSource();
        if (!target->HasSharedVision() || !target->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (target->GetExactDist2dSq(i_source) > i_distSq)
        {
            continue;
        }

        // Send packet to all who are sharing the creature's vision
        for (auto const& _player : target->GetSharedVisionList())
        {
            if (_player->m_seer == target)
            {
                SendPacket(_player);
            }
        }
    }
}

void MessageDistDelivererToHostile::Visit(DynamicObjectMapType& m)
{
    for (auto const& gridDynamicObject : m)
    {
        DynamicObject* target = gridDynamicObject.GetSource();
        if (!target->GetCasterGUID().IsPlayer() || !target->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (target->GetExactDist2dSq(i_source) > i_distSq)
        {
            continue;
        }

        // Send packet back to the caster if the caster has vision of dynamic object
        Player* caster = (Player*)target->GetCaster();
        if (caster && caster->m_seer == target)
        {
            SendPacket(caster);
        }
    }
}

template<class T>
AC_GAME_API void ObjectUpdater::Visit(GridRefMgr<T>& m)
{
    T* obj;

    for (auto const& iter : m)
    {
        obj = iter.GetSource();

        if (obj->IsInWorld() && (i_largeOnly == obj->IsVisibilityOverridden()))
        {
            obj->Update(i_timeDiff);
        }
    }
}

bool AnyDeadUnitObjectInRangeCheck::operator()(Player* u)
{
    return !u->IsAlive() && !u->HasAuraType(SPELL_AURA_GHOST) && i_searchObj->IsWithinDistInMap(u, i_range);
}

bool AnyDeadUnitObjectInRangeCheck::operator()(Corpse* u)
{
    return u->GetType() != CORPSE_BONES && i_searchObj->IsWithinDistInMap(u, i_range);
}

bool AnyDeadUnitObjectInRangeCheck::operator()(Creature* u)
{
    return !u->IsAlive() && i_searchObj->IsWithinDistInMap(u, i_range);
}

bool AnyDeadUnitSpellTargetInRangeCheck::operator()(Player* u)
{
    return AnyDeadUnitObjectInRangeCheck::operator()(u) && i_check(u);
}

bool AnyDeadUnitSpellTargetInRangeCheck::operator()(Corpse* u)
{
    return AnyDeadUnitObjectInRangeCheck::operator()(u) && i_check(u);
}

bool AnyDeadUnitSpellTargetInRangeCheck::operator()(Creature* u)
{
    return AnyDeadUnitObjectInRangeCheck::operator()(u) && i_check(u);
}

template AC_GAME_API void ObjectUpdater::Visit<Creature>(CreatureMapType&);
template AC_GAME_API void ObjectUpdater::Visit<GameObject>(GameObjectMapType&);
template AC_GAME_API void ObjectUpdater::Visit<DynamicObject>(DynamicObjectMapType&);

void MessageDistDeliverer::SendPacket(Player* player)
{
    // never send packet to self
    if (player == i_source || (teamId != TEAM_NEUTRAL && player->GetTeamId() != teamId) || skipped_receiver == player)
    {
        return;
    }

    if (!player->HaveAtClient(i_source))
    {
        return;
    }

    player->GetSession()->SendPacket(i_message);
}

void MessageDistDelivererToHostile::SendPacket(Player* player)
{
    // never send packet to self
    if (player == i_source || !player->HaveAtClient(i_source) || player->IsFriendlyTo(i_source))
    {
        return;
    }

    player->GetSession()->SendPacket(i_message);
}

bool GameObjectFocusCheck::operator()(GameObject* go) const
{
    if (go->GetGOInfo()->type != GAMEOBJECT_TYPE_SPELL_FOCUS)
    {
        return false;
    }

    if (!go->isSpawned()) // xinef: dont allow to count deactivated objects
    {
        return false;
    }

    if (go->GetGOInfo()->spellFocus.focusId != i_focusId)
    {
        return false;
    }

    float dist = float((go->GetGOInfo()->spellFocus.dist) / 2);

    return go->IsWithinDistInMap(i_unit, dist);
}

bool NearestGameObjectFishingHole::operator()(GameObject* go)
{
    if (go->GetGOInfo()->type == GAMEOBJECT_TYPE_FISHINGHOLE && go->isSpawned() && i_obj.IsWithinDistInMap(go, i_range) && i_obj.IsWithinDistInMap(go, (float)go->GetGOInfo()->fishinghole.radius))
    {
        i_range = i_obj.GetDistance(go);
        return true;
    }

    return false;
}

bool NearestGameObjectCheck::operator()(GameObject* go)
{
    if (i_obj.IsWithinDistInMap(go, i_range))
    {
        i_range = i_obj.GetDistance(go); // use found GO range as new range limit for next check
        return true;
    }

    return false;
}

bool NearestGameObjectEntryInObjectRangeCheck::operator()(GameObject* go)
{
    if (go->GetEntry() == i_entry && i_obj.IsWithinDistInMap(go, i_range) && (!i_onlySpawned || go->isSpawned()))
    {
        i_range = i_obj.GetDistance(go); // use found GO range as new range limit for next check
        return true;
    }

    return false;
}

bool NearestGameObjectTypeInObjectRangeCheck::operator()(GameObject* go)
{
    if (go->GetGoType() == i_type && i_obj.IsWithinDistInMap(go, i_range))
    {
        i_range = i_obj.GetDistance(go);        // use found GO range as new range limit for next check
        return true;
    }

    return false;
}

bool MostHPMissingInRange::operator()(Unit* u)
{
    if (u->IsAlive() && u->IsInCombat() && !i_obj->IsHostileTo(u) && i_obj->IsWithinDistInMap(u, i_range) && u->GetMaxHealth() - u->GetHealth() > i_hp)
    {
        i_hp = u->GetMaxHealth() - u->GetHealth();
        return true;
    }

    return false;
}

bool FriendlyCCedInRange::operator()(Unit* u)
{
    if (u->IsAlive() && u->IsInCombat() && !i_obj->IsHostileTo(u) && i_obj->IsWithinDistInMap(u, i_range) &&
            (u->isFeared() || u->IsCharmed() || u->isFrozen() || u->HasUnitState(UNIT_STATE_STUNNED) || u->HasUnitState(UNIT_STATE_CONFUSED)))
    {
        return true;
    }

    return false;
}

FriendlyMissingBuffInRange::FriendlyMissingBuffInRange(Unit const* obj, float range, uint32 spellid) :
    i_obj(obj),
    i_range(range)
{
    i_spell = spellid;

    if (SpellInfo const* spell = sSpellMgr->GetSpellInfo(spellid))
    {
        if (SpellInfo const* newSpell = sSpellMgr->GetSpellForDifficultyFromSpell(spell, const_cast<Unit*>(obj)))
        {
            i_spell = newSpell->Id;
        }
    }
}

bool FriendlyMissingBuffInRange::operator()(Unit* u)
{
    if (u->IsAlive() && u->IsInCombat() && !i_obj->IsHostileTo(u) && i_obj->IsWithinDistInMap(u, i_range) &&
            !(u->HasAura(i_spell)))
    {
        return true;
    }

    return false;
}

bool AnyUnfriendlyUnitInObjectRangeCheck::operator()(Unit* u)
{
    if (u->IsAlive() && i_obj->IsWithinDistInMap(u, i_range) && !i_funit->IsFriendlyTo(u) &&
            (i_funit->GetTypeId() != TYPEID_UNIT || !i_funit->ToCreature()->IsAvoidingAOE())) // pussywizard
    {
        return true;
    }

    return false;
}

bool AnyUnfriendlyNoTotemUnitInObjectRangeCheck::operator()(Unit* u)
{
    if (!u->IsAlive())
    {
        return false;
    }

    if (u->GetCreatureType() == CREATURE_TYPE_NON_COMBAT_PET)
    {
        return false;
    }

    if (u->GetTypeId() == TYPEID_UNIT && (u->ToCreature()->IsTotem() || u->ToCreature()->IsTrigger() || u->ToCreature()->IsAvoidingAOE())) // pussywizard: added IsAvoidingAOE()
    {
        return false;
    }

    if (!u->isTargetableForAttack(false, i_funit))
    {
        return false;
    }

    return i_obj->IsWithinDistInMap(u, i_range) && !i_funit->IsFriendlyTo(u);
}

bool AnyUnfriendlyAttackableVisibleUnitInObjectRangeCheck::operator()(const Unit* u)
{
    return u->IsAlive()
           && i_funit->IsWithinDistInMap(u, i_range)
           && !i_funit->IsFriendlyTo(u)
           && i_funit->IsValidAttackTarget(u)
           && !u->IsCritter()
           && !u->IsTotem() //xinef: dont attack totems
           /*&& i_funit->CanSeeOrDetect(u)*/; // pussywizard: already checked in IsValidAttackTarget(u)
}

bool AnyFriendlyUnitInObjectRangeCheck::operator()(Unit* u)
{
    if (u->IsAlive() && i_obj->IsWithinDistInMap(u, i_range) && i_funit->IsFriendlyTo(u) && (!i_playerOnly || u->GetTypeId() == TYPEID_PLAYER))
    {
        return true;
    }

    return false;
}

bool AnyFriendlyNotSelfUnitInObjectRangeCheck::operator()(Unit* u)
{
    if (u != i_obj && u->IsAlive() && i_obj->IsWithinDistInMap(u, i_range) && i_funit->IsFriendlyTo(u) && (!i_playerOnly || u->GetTypeId() == TYPEID_PLAYER))
    {
        return true;
    }

    return false;
}

bool AnyGroupedUnitInObjectRangeCheck::operator()(Unit* u)
{
    if (_raid)
    {
        if (!_refUnit->IsInRaidWith(u))
        {
            return false;
        }
    }
    else if (!_refUnit->IsInPartyWith(u))
    {
        return false;
    }

    return !_refUnit->IsHostileTo(u) && u->IsAlive() && _source->IsWithinDistInMap(u, _range);
}

bool AnyUnitInObjectRangeCheck::operator()(Unit* u)
{
    if (u->IsAlive() && i_obj->IsWithinDistInMap(u, i_range))
    {
        return true;
    }

    return false;
}

bool NearestAttackableUnitInObjectRangeCheck::operator()(Unit* u)
{
    if (u->isTargetableForAttack(true, i_funit) && i_obj->IsWithinDistInMap(u, i_range) &&
            (i_funit->IsInCombatWith(u) || u->IsHostileTo(i_funit)) && i_obj->CanSeeOrDetect(u))
    {
        i_range = i_obj->GetDistance(u);        // use found unit range as new range limit for next check
        return true;
    }

    return false;
}

AnyAoETargetUnitInObjectRangeCheck::AnyAoETargetUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range)
    : i_obj(obj),
    i_funit(funit),
    _spellInfo(nullptr),
    i_range(range)
{
    Unit const* check = i_funit;
    Unit const* owner = i_funit->GetOwner();

    if (owner)
    {
        check = owner;
    }

    i_targetForPlayer = (check->GetTypeId() == TYPEID_PLAYER);

    if (i_obj->GetTypeId() == TYPEID_DYNAMICOBJECT)
    {
        _spellInfo = sSpellMgr->GetSpellInfo(((DynamicObject*)i_obj)->GetSpellId());
    }
}

bool AnyAoETargetUnitInObjectRangeCheck::operator()(Unit* u)
{
    // Check contains checks for: live, non-selectable, non-attackable flags, flight check and GM check, ignore totems
    if (u->GetTypeId() == TYPEID_UNIT && ((Creature*)u)->IsTotem())
    {
        return false;
    }

    if (i_funit->_IsValidAttackTarget(u, _spellInfo, i_obj->GetTypeId() == TYPEID_DYNAMICOBJECT ? i_obj : nullptr) && i_obj->IsWithinDistInMap(u, i_range))
    {
        return true;
    }

    return false;
}

bool AnyAttackableUnitExceptForOriginalCasterInObjectRangeCheck::operator()(Unit* u)
{
    if (!u->IsAlive() || u->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE) || (u->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC) && !u->IsInCombat()))
    {
        return false;
    }

    if (u->GetGUID() == i_funit->GetGUID())
    {
        return false;
    }

    if (i_obj->IsWithinDistInMap(u, i_range))
    {
        return true;
    }

    return false;
}

void CallOfHelpCreatureInRangeDo::operator()(Creature* u)
{
    if (u == i_funit)
    {
        return;
    }

    if (!u->CanAssistTo(i_funit, i_enemy, false))
    {
        return;
    }

    // too far
    if (!u->IsWithinDistInMap(i_funit, i_range))
    {
        return;
    }

    // only if see assisted creature's enemy
    if (!u->IsWithinLOSInMap(i_enemy))
    {
        return;
    }

    if (u->AI())
    {
        u->AI()->AttackStart(i_enemy);
    }
}

bool NearestHostileUnitCheck::operator()(Unit* u)
{
    if (!me->IsWithinDistInMap(u, m_range, true, false))
    {
        return false;
    }

    if (!me->IsValidAttackTarget(u))
    {
        return false;
    }

    if (i_playerOnly && u->GetTypeId() != TYPEID_PLAYER)
    {
        return false;
    }

    m_range = me->GetDistance(u);   // use found unit range as new range limit for next check
    return true;
}

bool NearestHostileUnitInAttackDistanceCheck::operator()(Unit* u)
{
    if (!me->IsWithinDistInMap(u, m_range, true, false))
    {
        return false;
    }

    if (!me->CanStartAttack(u))
    {
        return false;
    }

    m_range = me->GetDistance(u);   // use found unit range as new range limit for next check
    return true;
}

bool NearestVisibleDetectableContestedGuardUnitCheck::operator()(Unit* u)
{
    if (!u->CanSeeOrDetect(me, true, true, false))
    {
        return false;
    }

    if (!u->IsContestedGuard())
    {
        return false;
    }

    return true;
}

bool AnyAssistCreatureInRangeCheck::operator()(Creature* u)
{
    if (u == i_funit)
    {
        return false;
    }

    if (!u->CanAssistTo(i_funit, i_enemy))
    {
        return false;
    }

    // too far
    if (!i_funit->IsWithinDistInMap(u, i_range))
    {
        return false;
    }

    // only if see assisted creature
    if (!i_funit->IsWithinLOSInMap(u))
    {
        return false;
    }

    return true;
}

bool NearestAssistCreatureInCreatureRangeCheck::operator()(Creature* u)
{
    if (u == i_obj)
    {
        return false;
    }

    if (!u->CanAssistTo(i_obj, i_enemy))
    {
        return false;
    }

    if (!i_obj->IsWithinDistInMap(u, i_range))
    {
        return false;
    }

    if (!i_obj->IsWithinLOSInMap(u))
    {
        return false;
    }

    i_range = i_obj->GetDistance(u);            // use found unit range as new range limit for next check
    return true;
}

bool NearestCreatureEntryWithLiveStateInObjectRangeCheck::operator()(Creature* u)
{
    if (u->GetEntry() == i_entry && u->IsAlive() == i_alive && i_obj.IsWithinDistInMap(u, i_range))
    {
        i_range = i_obj.GetDistance(u);         // use found unit range as new range limit for next check
        return true;
    }

    return false;
}

bool AnyPlayerInObjectRangeCheck::operator()(Player* u)
{
    if (_reqAlive && !u->IsAlive())
    {
        return false;
    }

    if (_disallowGM && (u->IsGameMaster() || u->IsSpectator()))
    {
        return false;
    }

    if (!_obj->IsWithinDistInMap(u, _range))
    {
        return false;
    }

    return true;
}

bool AnyPlayerInObjectRangeCheck::operator()(Player* u, bool checkRange)
{
    if (checkRange && !_obj->IsWithinDistInMap(u, _range))
    {
        return false;
    }

    return true;
}

bool AnyPlayerExactPositionInGameObjectRangeCheck::operator()(Player* u)
{
    if (!_go->IsInRange(u->GetPositionX(), u->GetPositionY(), u->GetPositionZ(), _range))
    {
        return false;
    }

    return true;
}

bool NearestPlayerInObjectRangeCheck::operator()(Player* u)
{
    if (u->IsAlive() && i_obj->IsWithinDistInMap(u, i_range))
    {
        i_range = i_obj->GetDistance(u);
        return true;
    }

    return false;
}

bool AllFriendlyCreaturesInGrid::operator()(Unit* u)
{
    if (u->IsAlive() && u->IsVisible() && u->IsFriendlyTo(unit))
    {
        return true;
    }

    return false;
}

bool AllGameObjectsWithEntryInRange::operator()(GameObject* go)
{
    if (go->GetEntry() == m_uiEntry && m_pObject->IsWithinDist(go, m_fRange, false))
    {
        return true;
    }

    return false;
}

bool AllCreaturesOfEntryInRange::operator()(Unit* unit)
{
    if (unit->GetEntry() == m_uiEntry && m_pObject->IsWithinDist(unit, m_fRange, false))
    {
        return true;
    }

    return false;
}

bool MostHPMissingGroupInRange::operator()(Unit* u)
{
    if (i_obj == u)
    {
        return false;
    }

    Player* player = nullptr;
    if (u->GetTypeId() == TYPEID_PLAYER)
    {
        player = u->ToPlayer();
    }

    else if (u->IsPet() && u->GetOwner())
    {
        player = u->GetOwner()->ToPlayer();
    }

    if (!player)
    {
        return false;
    }

    Group* group = player->GetGroup();
    if (!group || !group->IsMember(i_obj->IsPet() ? i_obj->GetOwnerGUID() : i_obj->GetGUID()))
    {
        return false;
    }

    if (u->IsAlive() && !i_obj->IsHostileTo(u) && i_obj->IsWithinDistInMap(u, i_range) && u->GetMaxHealth() - u->GetHealth() > i_hp)
    {
        i_hp = u->GetMaxHealth() - u->GetHealth();
        return true;
    }

    return false;
}

bool AllDeadCreaturesInRange::operator()(Unit* unit) const
{
    if (_reqAlive && unit->IsAlive())
    {
        return false;
    }

    if (!_obj->IsWithinDistInMap(unit, _range))
    {
        return false;
    }

    return true;
}

bool PlayerAtMinimumRangeAway::operator()(Player* player)
{
    //No threat list check, must be done explicit if expected to be in combat with creature
    if (!player->IsGameMaster() && player->IsAlive() && !unit->IsWithinDist(player, fRange, false))
    {
        return true;
    }

    return false;
}

bool GameObjectInRangeCheck::operator()(GameObject* go)
{
    if (!entry || (go->GetGOInfo() && go->GetGOInfo()->entry == entry))
    {
        return go->IsInRange(x, y, z, range);
    }

    return false;
}

bool AllWorldObjectsInRange::operator()(WorldObject* go)
{
    return m_pObject->IsWithinDist(go, m_fRange, false) && m_pObject->InSamePhase(go);
}

bool ObjectTypeIdCheck::operator()(WorldObject const* object)
{
    return (object->GetTypeId() == _typeId) == _equals;
}

bool ObjectGUIDCheck::operator()(WorldObject const* object)
{
    return (object->GetGUID() == _GUID) == _equals;
}

bool UnitAuraCheck::operator()(Unit const* unit) const
{
    return unit->HasAura(_spellId, _casterGUID) == _present;
}

bool UnitAuraCheck::operator()(WorldObject const* object) const
{
    return object->ToUnit() && object->ToUnit()->HasAura(_spellId, _casterGUID) == _present;
}

bool AllWorldObjectsInExactRange::operator()(WorldObject const* object)
{
    return (_object->GetExactDist2d(object) > _range) == _equals;
}

bool RandomCheck::operator()(WorldObject const* /*object*/) const
{
    return roll_chance_i(_chance);
}

bool PowerCheck::operator()(WorldObject const* object) const
{
    return object->ToUnit() && (object->ToUnit()->getPowerType() == _power) == _equals;
}

bool RaidCheck::operator()(WorldObject const* object) const
{
    return object->ToUnit() && object->ToUnit()->IsInRaidWith(_compare) == _equals;
}
