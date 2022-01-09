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

#ifndef _HOSTILEREFMANAGER
#define _HOSTILEREFMANAGER

#include "Common.h"
#include "RefMgr.h"

class Unit;
class ThreatMgr;
class HostileReference;
class SpellInfo;

//=================================================

class HostileRefMgr : public RefMgr<Unit, ThreatMgr>
{
private:
    Unit* iOwner;
public:
    explicit HostileRefMgr(Unit* owner) { iOwner = owner; }
    ~HostileRefMgr() override;

    Unit* GetOwner() { return iOwner; }

    // send threat to all my hateres for the victim
    // The victim is hated than by them as well
    // use for buffs and healing threat functionality
    void threatAssist(Unit* victim, float baseThreat, SpellInfo const* threatSpell = nullptr);

    void addTempThreat(float threat, bool apply);

    void addThreatPercent(int32 percent);

    // The references are not needed anymore
    // tell the source to remove them from the list and free the mem
    void deleteReferences(bool removeFromMap = false);

    // Remove specific faction references
    void deleteReferencesForFaction(uint32 faction);

    // pussywizard: for combat bugs
    void deleteReferencesOutOfRange(float range);

    HostileReference* getFirst() { return ((HostileReference*) RefMgr<Unit, ThreatMgr>::getFirst()); }

    void updateThreatTables();

    void setOnlineOfflineState(bool isOnline);

    // set state for one reference, defined by Unit
    void setOnlineOfflineState(Unit* creature, bool isOnline);

    // delete one reference, defined by Unit
    void deleteReference(Unit* creature);

    void UpdateVisibility(bool checkThreat);
};
//=================================================
#endif
