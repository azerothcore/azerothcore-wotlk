/*
 * Copyright (C) 2008-2018 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CombatMgr.h"
#include "Creature.h"
#include "Unit.h"
#include "CreatureAI.h"
#include "Player.h"

/*static*/ bool CombatMgr::CanBeginCombat(Unit const* a, Unit const* b)
{
    // Checks combat validity before initial reference creation.
    // For the combat to be valid...
    // ...the two units need to be different
    if (a == b)
        return false;
    // ...the two units need to be in the world
    if (!a->IsInWorld() || !b->IsInWorld())
        return false;
    // ...the two units need to both be alive
    if (!a->IsAlive() || !b->IsAlive())
        return false;
    // ...the two units need to be on the same map
    if (a->GetMap() != b->GetMap())
        return false;
    // ...the two units need to be in the same phase
    if (!WorldObject::InSamePhase(a, b))
        return false;
    if (a->HasUnitState(UNIT_STATE_EVADE) || b->HasUnitState(UNIT_STATE_EVADE))
        return false;
    if (a->HasUnitState(UNIT_STATE_IN_FLIGHT) || b->HasUnitState(UNIT_STATE_IN_FLIGHT))
        return false;
    if (a->IsFriendlyTo(b) || b->IsFriendlyTo(a))
        return false;

    Player const* playerA = a->GetCharmerOrOwnerPlayerOrPlayerItself();
    Player const* playerB = b->GetCharmerOrOwnerPlayerOrPlayerItself();
    // ...neither of the two units must be (owned by) a player with .gm on
    if ((playerA && playerA->IsGameMaster()) || (playerB && playerB->IsGameMaster()))
        return false;
    return true;
}

void CombatReference::EndCombat()
{
    // sequencing matters here - AI might do nasty stuff, so make sure refs are in a consistent state before you hand off!

    // first, get rid of any threat that still exists...
    first->GetThreatMgr().ClearThreat(second);
    second->GetThreatMgr().ClearThreat(first);

    // ...then, remove the references from both managers...
    first->GetCombatMgr().PurgeReference(second->GetGUID(), _isPvP);
    second->GetCombatMgr().PurgeReference(first->GetGUID(), _isPvP);

    // ...update the combat state, which will potentially remove IN_COMBAT...
    bool const needFirstAI = first->GetCombatMgr().UpdateOwnerCombatState();
    bool const needSecondAI = second->GetCombatMgr().UpdateOwnerCombatState();

    // ...and if that happened, also notify the AI of it...
    if (needFirstAI && first->IsAIEnabled)
        first->GetAI()->JustExitedCombat();
    if (needSecondAI && second->IsAIEnabled)
        second->GetAI()->JustExitedCombat();

    // ...and finally clean up the reference object
    delete this;
}

CombatMgr::~CombatMgr()
{
    ASSERT(_pveRefs.empty(), "CombatManager::~CombatManager - %s: we still have %zu PvE combat references, one of them is with %s", _owner->GetGUID().ToString().c_str(), _pveRefs.size(), _pveRefs.begin()->first.ToString().c_str());
    ASSERT(_pvpRefs.empty(), "CombatManager::~CombatManager - %s: we still have %zu PvP combat references, one of them is with %s", _owner->GetGUID().ToString().c_str(), _pvpRefs.size(), _pvpRefs.begin()->first.ToString().c_str());
}

bool PvPCombatReference::Update(uint32 tdiff)
{
    if (_combatTimer <= tdiff)
        return false;
    _combatTimer -= tdiff;
    return true;
}

void PvPCombatReference::Refresh()
{
    _combatTimer = PVP_COMBAT_TIMEOUT;

    bool needFirstAI = false, needSecondAI = false;
    if (_suppressFirst)
    {
        _suppressFirst = false;
        needFirstAI = first->GetCombatMgr().UpdateOwnerCombatState();
    }
    if (_suppressSecond)
    {
        _suppressSecond = false;
        needSecondAI = second->GetCombatMgr().UpdateOwnerCombatState();
    }

    if (needFirstAI)
        CombatMgr::NotifyAICombat(first, second);
    if (needSecondAI)
        CombatMgr::NotifyAICombat(second, first);
}

void PvPCombatReference::SuppressFor(Unit* who)
{
    Suppress(who);
    if (who->GetCombatMgr().UpdateOwnerCombatState())
        if (who->IsAIEnabled)
            who->GetAI()->JustExitedCombat();
}

void CombatMgr::Update(uint32 tdiff)
{
    auto it = _pvpRefs.begin(), end = _pvpRefs.end();
    while (it != end)
    {
        PvPCombatReference* const ref = it->second;
        if (ref->first == _owner && !ref->Update(tdiff)) // only update if we're the first unit involved (otherwise double decrement)
        {
            it = _pvpRefs.erase(it), end = _pvpRefs.end(); // remove it from our refs first to prevent invalidation
            ref->EndCombat(); // this will remove it from the other side
        }
        else
            ++it;
    }
}

bool CombatMgr::HasPvPCombat() const
{
    for (auto const& pair : _pvpRefs)
        if (!pair.second->IsSuppressedFor(_owner))
            return true;
    return false;
}

Unit* CombatMgr::GetAnyTarget() const
{
    if (!_pveRefs.empty())
        return _pveRefs.begin()->second->GetOther(_owner);
    for (auto const& pair : _pvpRefs)
        if (!pair.second->IsSuppressedFor(_owner))
            return pair.second->GetOther(_owner);
    return nullptr;
}

bool CombatMgr::SetInCombatWith(Unit* who)
{
    // Are we already in combat? If yes, refresh pvp combat
    auto it = _pvpRefs.find(who->GetGUID());
    if (it != _pvpRefs.end())
    {
        it->second->Refresh();
        return true;
    }
    else if (_pveRefs.find(who->GetGUID()) != _pveRefs.end())
        return true;

    // Otherwise, check validity...
    if (!CombatMgr::CanBeginCombat(_owner, who))
        return false;

    // ...then create new reference
    CombatReference* ref;
    if (_owner->IsControlledByPlayer() && who->IsControlledByPlayer())
        ref = new PvPCombatReference(_owner, who);
    else
        ref = new CombatReference(_owner, who);

    // ...and insert it into both managers
    PutReference(who->GetGUID(), ref);
    who->GetCombatMgr().PutReference(_owner->GetGUID(), ref);

    // now, sequencing is important - first we update the combat state, which will set both units in combat and do non-AI combat start stuff
    bool const needSelfAI = UpdateOwnerCombatState();
    bool const needOtherAI = who->GetCombatMgr().UpdateOwnerCombatState();

    // then, we finally notify the AI (if necessary) and let it safely do whatever it feels like
    if (needSelfAI)
        NotifyAICombat(_owner, who);
    if (needOtherAI)
        NotifyAICombat(who, _owner);
    return  IsInCombatWith(who);
}

bool CombatMgr::IsInCombatWith(ObjectGuid const& guid) const
{
    return (_pveRefs.find(guid) != _pveRefs.end()) || (_pvpRefs.find(guid) != _pvpRefs.end());
}

bool CombatMgr::IsInCombatWith(Unit const* who) const
{
    return IsInCombatWith(who->GetGUID());
}

void CombatMgr::InheritCombatStatesFrom(Unit const* who)
{
    CombatMgr const& mgr = who->GetCombatMgr();
    for (auto& ref : mgr._pveRefs)
    {
        if (!IsInCombatWith(ref.first))
        {
            Unit* target = ref.second->GetOther(who);
            if ((_owner->IsImmuneToPC() && target->HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED)) ||
                (_owner->IsImmuneToNPC() && !target->HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED)))
                continue;
            SetInCombatWith(target);
        }
    }
    for (auto& ref : mgr._pvpRefs)
    {
        Unit* target = ref.second->GetOther(who);
        if ((_owner->IsImmuneToPC() && target->HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED)) ||
            (_owner->IsImmuneToNPC() && !target->HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED)))
                continue;
        SetInCombatWith(target);
    }
}

void CombatMgr::EndCombatBeyondRange(float range, bool includingPvP)
{
    auto it = _pveRefs.begin(), end = _pveRefs.end();
    while (it != end)
    {
        CombatReference* const ref = it->second;
        if (!ref->first->IsWithinDistInMap(ref->second, range))
        {
            it = _pveRefs.erase(it), end = _pveRefs.end(); // erase manually here to avoid iterator invalidation
            ref->EndCombat();
        }
        else
            ++it;
    }

    if (!includingPvP)
        return;

    auto it2 = _pvpRefs.begin(), end2 = _pvpRefs.end();
    while (it2 != end2)
    {
        CombatReference* const ref = it2->second;
        if (!ref->first->IsWithinDistInMap(ref->second, range))
        {
            it2 = _pvpRefs.erase(it2), end2 = _pvpRefs.end(); // erase manually here to avoid iterator invalidation
            ref->EndCombat();
        }
        else
            ++it2;
    }
}

void CombatMgr::SuppressPvPCombat()
{
    for (auto const& pair : _pvpRefs)
        pair.second->Suppress(_owner);
    if (UpdateOwnerCombatState())
        if (_owner->IsAIEnabled)
            _owner->GetAI()->JustExitedCombat();
}

void CombatMgr::EndAllPvECombat()
{
    // cannot have threat without combat
    _owner->GetThreatMgr().RemoveMeFromThreatLists();
    _owner->GetThreatMgr().ClearAllThreat();
    while (!_pveRefs.empty())
        _pveRefs.begin()->second->EndCombat();
}

void CombatMgr::RevalidateCombat()
{
    auto it = _pveRefs.begin(), end = _pveRefs.end();
    while (it != end)
    {
        CombatReference* const ref = it->second;
        if (!CanBeginCombat(_owner, ref->GetOther(_owner)))
        {
            it = _pveRefs.erase(it), end = _pveRefs.end(); // erase manually here to avoid iterator invalidation
            ref->EndCombat();
        }
        else
            ++it;
    }

    auto it2 = _pvpRefs.begin(), end2 = _pvpRefs.end();
    while (it2 != end2)
    {
        CombatReference* const ref = it2->second;
        if (!CanBeginCombat(_owner, ref->GetOther(_owner)))
        {
            it2 = _pvpRefs.erase(it2), end2 = _pvpRefs.end(); // erase manually here to avoid iterator invalidation
            ref->EndCombat();
        }
        else
            ++it2;
    }
}

void CombatMgr::EndAllPvPCombat()
{
    while (!_pvpRefs.empty())
        _pvpRefs.begin()->second->EndCombat();
}

/*static*/ void CombatMgr::NotifyAICombat(Unit* me, Unit* other)
{
    if (UnitAI* ai = me->GetAI())
        ai->JustEnteredCombat(other);
}

void CombatMgr::PutReference(ObjectGuid const& guid, CombatReference* ref)
{
    if (ref->_isPvP)
    {
        auto& inMap = _pvpRefs[guid];
        ASSERT(!inMap && "Duplicate combat state detected - memory leak!");
        inMap = static_cast<PvPCombatReference*>(ref);
    }
    else
    {
        auto& inMap = _pveRefs[guid];
        ASSERT(!inMap && "Duplicate combat state detected - memory leak!");
        inMap = ref;
    }
}

void CombatMgr::PurgeReference(ObjectGuid const& guid, bool pvp)
{
    if (pvp)
        _pvpRefs.erase(guid);
    else
        _pveRefs.erase(guid);
}

bool CombatMgr::UpdateOwnerCombatState() const
{
    bool const combatState = HasCombat();
    if (combatState == _owner->IsInCombat())
        return false;

    if (combatState)
    {
        _owner->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
        _owner->AtEnterCombat();
        if (_owner->GetTypeId() != TYPEID_UNIT)
            _owner->AtEngage(GetAnyTarget());
    }
    else
    {
        _owner->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
        _owner->AtExitCombat();
        if (_owner->GetTypeId() != TYPEID_UNIT)
            _owner->AtDisengage();
    }

    if (Unit* master = _owner->GetCharmerOrOwner())
        master->UpdatePetCombatState();

    return true;
}
