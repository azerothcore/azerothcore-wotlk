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

#ifndef _PETITIONMGR_H
#define _PETITIONMGR_H

#include "ObjectGuid.h"

#include <unordered_map>
#include <map>

#define CHARTER_DISPLAY_ID 16161

// Charters ID in item_template
enum CharterItemIDs
{
    GUILD_CHARTER           = 5863,
    ARENA_TEAM_CHARTER_2v2  = 23560,
    ARENA_TEAM_CHARTER_3v3  = 23561,
    ARENA_TEAM_CHARTER_5v5  = 23562
};

typedef std::map<ObjectGuid, uint32> SignatureMap;

struct Petition
{
    // Item GUID of the charter item (used to find the item in inventory)
    ObjectGuid petitionGuid;
    // New 31-bit safe petition identifier used in packets/DB relations
    uint32 petitionId;
    // Owner character GUID
    ObjectGuid ownerGuid;
    // Petition type (guild / arena)
    uint8  petitionType;
    // Name associated with the petition (guild/arena name)
    std::string petitionName;
};

struct Signatures
{
    // Keep keying by item-guid for backward compatibility in code paths
    ObjectGuid petitionGuid;
    SignatureMap signatureMap;
};

typedef std::map<ObjectGuid, Signatures> SignatureContainer;
typedef std::map<ObjectGuid, Petition> PetitionContainer;

class PetitionMgr
{
private:
    PetitionMgr();
    ~PetitionMgr();

public:
    static PetitionMgr* instance();

    void LoadPetitions();
    void LoadSignatures();

    // Petitions
    void AddPetition(ObjectGuid petitionGUID, ObjectGuid ownerGuid, std::string const& name, uint8 type, uint32 petitionId);
    void RemovePetition(ObjectGuid petitionGUID);
    void RemovePetitionByOwnerAndType(ObjectGuid ownerGuid, uint8 type);
    Petition const* GetPetition(ObjectGuid petitionGUID) const;
    Petition const* GetPetitionById(uint32 petitionId) const;
    Petition const* GetPetitionByOwnerWithType(ObjectGuid ownerGuid, uint8 type) const;
    PetitionContainer* GetPetitionStore() { return &PetitionStore; }

    // Signatures
    void AddSignature(ObjectGuid petitionGUID, uint32 accountId, ObjectGuid playerGuid);
    void RemoveSignaturesByPlayer(ObjectGuid playerGuid);
    void RemoveSignaturesByPlayerAndType(ObjectGuid playerGuid, uint8 type);
    Signatures const* GetSignature(ObjectGuid petitionGUID) const;
    SignatureContainer* GetSignatureStore() { return &SignatureStore; }

    uint32 GeneratePetitionId();
    uint32 GetPetitionIdByItemGuid(ObjectGuid petitionItemGuid) const;
    ObjectGuid GetItemGuidByPetitionId(uint32 petitionId) const;

protected:
    PetitionContainer PetitionStore;
    SignatureContainer SignatureStore;
    // Mapping id -> item-guid to support DB-id lookups
    std::unordered_map<uint32, ObjectGuid> PetitionIdToItemGuid;
    // Next petition id (kept < 2^31)
    uint32 _nextPetitionId = 1;
};

#define sPetitionMgr PetitionMgr::instance()

#endif
