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

#ifndef _PETITIONMGR_H
#define _PETITIONMGR_H

#include "Common.h"
#include "GUID.h"

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

typedef std::map<WOWGUID, uint32> SignatureMap;

struct Petition
{
    WOWGUID petitionGuid;
    WOWGUID ownerGuid;
    uint8  petitionType;
    std::string petitionName;
};

struct Signatures
{
    WOWGUID petitionGuid;
    SignatureMap signatureMap;
};

typedef std::map<WOWGUID, Signatures> SignatureContainer;
typedef std::map<WOWGUID, Petition> PetitionContainer;

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
    void AddPetition(WOWGUID petitionGUID, WOWGUID ownerGuid, std::string const& name, uint8 type);
    void RemovePetition(WOWGUID petitionGUID);
    void RemovePetitionByOwnerAndType(WOWGUID ownerGuid, uint8 type);
    Petition const* GetPetition(WOWGUID petitionGUID) const;
    Petition const* GetPetitionByOwnerWithType(WOWGUID ownerGuid, uint8 type) const;
    PetitionContainer* GetPetitionStore() { return &PetitionStore; }

    // Signatures
    void AddSignature(WOWGUID petitionGUID, uint32 accountId, WOWGUID playerGuid);
    void RemoveSignaturesByPlayer(WOWGUID playerGuid);
    void RemoveSignaturesByPlayerAndType(WOWGUID playerGuid, uint8 type);
    Signatures const* GetSignature(WOWGUID petitionGUID) const;
    SignatureContainer* GetSignatureStore() { return &SignatureStore; }

protected:
    PetitionContainer PetitionStore;
    SignatureContainer SignatureStore;
};

#define sPetitionMgr PetitionMgr::instance()

#endif
