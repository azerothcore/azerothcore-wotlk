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

#include "GridNotifiers.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "Transport.h"
#include "UpdateData.h"
#include "WorldPacket.h"

using namespace Acore;

void VisibleNotifier::Visit(GameObjectMapType& m)
{
    for (GameObjectMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
    {
        GameObject* go = iter->GetSource();
        i_player.UpdateVisibilityOf(go, i_data, i_visibleNow);
    }
}

void VisibleNotifier::SendToSelf()
{
    // Update far visible objects
    ZoneWideVisibleWorldObjectsSet const* zoneWideVisibleObjects = i_player.GetMap()->GetZoneWideVisibleWorldObjectsForZone(i_player.GetZoneId());
    if (zoneWideVisibleObjects)
    {
        for (WorldObject* obj : *zoneWideVisibleObjects)
        {
            switch (obj->GetTypeId())
            {
                case TYPEID_GAMEOBJECT:
                    i_player.UpdateVisibilityOf(obj->ToGameObject(), i_data, i_visibleNow);
                    break;
                case TYPEID_UNIT:
                    i_player.UpdateVisibilityOf(obj->ToCreature(), i_data, i_visibleNow);
                    break;
                case TYPEID_DYNAMICOBJECT:
                    i_player.UpdateVisibilityOf(obj->ToDynObject(), i_data, i_visibleNow);
                    break;
                default:
                    break;
            }
        }
    }

    VisibleWorldObjectsMap* visibleWorldObjects = i_player.GetObjectVisibilityContainer().GetVisibleWorldObjectsMap();
    for (VisibleWorldObjectsMap::iterator itr = visibleWorldObjects->begin(); itr != visibleWorldObjects->end();)
    {
        WorldObject* obj = itr->second;
        if (!i_player.IsWorldObjectOutOfSightRange(obj)
            || i_player.CanSeeOrDetect(obj, false, true))
        {
            ++itr;
            continue;
        }

        i_data.AddOutOfRangeGUID(obj->GetGUID());

        if (Player* objPlayer = obj->ToPlayer())
            objPlayer->UpdateVisibilityOf(&i_player);

        // Clean up references
        itr = i_player.GetObjectVisibilityContainer().UnlinkVisibilityFromPlayer(obj, itr);
    }

    if (!i_data.HasData())
        return;

    WorldPacket packet;
    i_data.BuildPacket(packet);
    i_player.SendDirectMessage(&packet);

    for (std::vector<Unit*>::const_iterator it = i_visibleNow.begin(); it != i_visibleNow.end(); ++it)
        i_player.GetInitialVisiblePackets(*it);
}

void VisibleChangesNotifier::Visit(PlayerMapType& m)
{
    for (PlayerMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
    {
        if (iter->GetSource() == &i_object)
            continue;

        iter->GetSource()->UpdateVisibilityOf(&i_object);

        if (iter->GetSource()->HasSharedVision())
            for (SharedVisionList::const_iterator i = iter->GetSource()->GetSharedVisionList().begin(); i != iter->GetSource()->GetSharedVisionList().end(); ++i)
                if ((*i)->m_seer == iter->GetSource())
                    (*i)->UpdateVisibilityOf(&i_object);
    }
}

void VisibleChangesNotifier::Visit(CreatureMapType& m)
{
    for (CreatureMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
        if (iter->GetSource()->HasSharedVision())
            for (SharedVisionList::const_iterator i = iter->GetSource()->GetSharedVisionList().begin(); i != iter->GetSource()->GetSharedVisionList().end(); ++i)
                if ((*i)->m_seer == iter->GetSource())
                    (*i)->UpdateVisibilityOf(&i_object);
}

void VisibleChangesNotifier::Visit(DynamicObjectMapType& m)
{
    for (DynamicObjectMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
        if (iter->GetSource()->GetCasterGUID().IsPlayer())
            if (Unit* caster = iter->GetSource()->GetCaster())
                if (Player* player = caster->ToPlayer())
                    if (player->m_seer == iter->GetSource())
                        player->UpdateVisibilityOf(&i_object);
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
        else if (u->IsPlayer() && u->HasStealthAura() && c->IsAIEnabled && c->CanSeeOrDetect(u, false, true, true))
        {
            c->AI()->TriggerAlert(u);
        }
    }
}

void PlayerRelocationNotifier::Visit(PlayerMapType& m)
{
    for (PlayerMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
    {
        Player* player = iter->GetSource();
        i_player.UpdateVisibilityOf(player, i_data, i_visibleNow);
        player->UpdateVisibilityOf(&i_player); // this notifier with different Visit(PlayerMapType&) than VisibleNotifier is needed to update visibility of self for other players when we move (eg. stealth detection changes)
    }
}

void CreatureRelocationNotifier::Visit(PlayerMapType& m)
{
    for (PlayerMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
    {
        Player* player = iter->GetSource();

        // NOTIFY_VISIBILITY_CHANGED does not guarantee that player will do it himself (because distance is also checked), but screw it, it's not that important
        if (!player->m_seer->isNeedNotify(NOTIFY_VISIBILITY_CHANGED))
            player->UpdateVisibilityOf(&i_creature);

        // NOTIFY_AI_RELOCATION does not guarantee that player will do it himself (because distance is also checked), but screw it, it's not that important
        if (!player->m_seer->isNeedNotify(NOTIFY_AI_RELOCATION) && !i_creature.IsMoveInLineOfSightStrictlyDisabled())
            CreatureUnitRelocationWorker(&i_creature, player);
    }
}

void AIRelocationNotifier::Visit(CreatureMapType& m)
{
    bool self = isCreature && !((Creature*)(&i_unit))->IsMoveInLineOfSightStrictlyDisabled();
    for (CreatureMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
    {
        Creature* c = iter->GetSource();

        // NOTIFY_VISIBILITY_CHANGED | NOTIFY_AI_RELOCATION does not guarantee that unit will do it itself (because distance is also checked), but screw it, it's not that important
        if (!c->isNeedNotify(NOTIFY_VISIBILITY_CHANGED | NOTIFY_AI_RELOCATION) && !c->IsMoveInLineOfSightStrictlyDisabled())
            CreatureUnitRelocationWorker(c, &i_unit);

        if (self)
            CreatureUnitRelocationWorker((Creature*)&i_unit, c);
    }
}

// Uses visibility map
void MessageDistDeliverer::Visit(VisiblePlayersMap const& m)
{
    for (auto const& kvPair : m)
    {
        Player const* target = kvPair.second;
        if (i_distSq != 0.0f && target->m_seer->GetExactDist2dSq(i_source) > i_distSq)
            continue;

        // @todo: Might not need this check anymore
        if (skipped_receiver == target)
            continue;

        target->SendDirectMessage(i_message);
    }
}

void MessageDistDeliverer::Visit(PlayerMapType& m)
{
    for (PlayerMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
    {
        Player* target = iter->GetSource();
        if (!target->InSamePhase(i_phaseMask))
            continue;

        if (required3dDist)
        {
            if (target->GetExactDistSq(i_source) > i_distSq)
                continue;
        }
        else
            if (target->GetExactDist2dSq(i_source) > i_distSq)
                continue;

        // Send packet to all who are sharing the player's vision
        if (target->HasSharedVision())
        {
            SharedVisionList::const_iterator i = target->GetSharedVisionList().begin();
            for (; i != target->GetSharedVisionList().end(); ++i)
                if ((*i)->m_seer == target)
                    SendPacket(*i);
        }

        if (target->m_seer == target || target->GetVehicle())
            SendPacket(target);
    }
}

void MessageDistDeliverer::Visit(CreatureMapType& m)
{
    for (CreatureMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
    {
        Creature* target = iter->GetSource();
        if (!target->HasSharedVision() || !target->InSamePhase(i_phaseMask))
            continue;

        if (required3dDist)
        {
            if (target->GetExactDistSq(i_source) > i_distSq)
                continue;
        }
        else
            if (target->GetExactDist2dSq(i_source) > i_distSq)
                continue;

        // Send packet to all who are sharing the creature's vision
        SharedVisionList::const_iterator i = target->GetSharedVisionList().begin();
        for (; i != target->GetSharedVisionList().end(); ++i)
            if ((*i)->m_seer == target)
                SendPacket(*i);
    }
}

void MessageDistDeliverer::Visit(DynamicObjectMapType& m)
{
    for (DynamicObjectMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
    {
        DynamicObject* target = iter->GetSource();
        if (!target->GetCasterGUID().IsPlayer() || !target->InSamePhase(i_phaseMask))
            continue;

        // Xinef: Check whether the dynobject allows to see through it
        if (!target->IsViewpoint())
            continue;

        if (required3dDist)
        {
            if (target->GetExactDistSq(i_source) > i_distSq)
                continue;
        }
        else
            if (target->GetExactDist2dSq(i_source) > i_distSq)
                continue;

        // Send packet back to the caster if the caster has vision of dynamic object
        Player* caster = (Player*)target->GetCaster();
        if (caster && caster->m_seer == target)
            SendPacket(caster);
    }
}

void MessageDistDelivererToHostile::Visit(PlayerMapType& m)
{
    for (PlayerMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
    {
        Player* target = iter->GetSource();
        if (!target->InSamePhase(i_phaseMask))
            continue;

        if (target->GetExactDist2dSq(i_source) > i_distSq)
            continue;

        // Send packet to all who are sharing the player's vision
        if (target->HasSharedVision())
        {
            SharedVisionList::const_iterator i = target->GetSharedVisionList().begin();
            for (; i != target->GetSharedVisionList().end(); ++i)
                if ((*i)->m_seer == target)
                    SendPacket(*i);
        }

        if (target->m_seer == target || target->GetVehicle())
            SendPacket(target);
    }
}

void MessageDistDelivererToHostile::Visit(CreatureMapType& m)
{
    for (CreatureMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
    {
        Creature* target = iter->GetSource();
        if (!target->HasSharedVision() || !target->InSamePhase(i_phaseMask))
            continue;

        if (target->GetExactDist2dSq(i_source) > i_distSq)
            continue;

        // Send packet to all who are sharing the creature's vision
        SharedVisionList::const_iterator i = target->GetSharedVisionList().begin();
        for (; i != target->GetSharedVisionList().end(); ++i)
            if ((*i)->m_seer == target)
                SendPacket(*i);
    }
}

void MessageDistDelivererToHostile::Visit(DynamicObjectMapType& m)
{
    for (DynamicObjectMapType::iterator iter = m.begin(); iter != m.end(); ++iter)
    {
        DynamicObject* target = iter->GetSource();
        if (!target->GetCasterGUID().IsPlayer() || !target->InSamePhase(i_phaseMask))
            continue;

        if (target->GetExactDist2dSq(i_source) > i_distSq)
            continue;

        // Send packet back to the caster if the caster has vision of dynamic object
        Player* caster = (Player*)target->GetCaster();
        if (caster && caster->m_seer == target)
            SendPacket(caster);
    }
}

bool AnyDeadUnitObjectInRangeCheck::operator()(Player* u)
{
    return !u->IsAlive() && !u->HasGhostAura() && i_searchObj->IsWithinDistInMap(u, i_range);
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
