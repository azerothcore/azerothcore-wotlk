/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef _PETITIONMGR_H
#define _PETITIONMGR_H

#include "Common.h"
#include "ObjectGuid.h"

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
    ObjectGuid petitionGuid;
    ObjectGuid ownerGuid;
    uint8  petitionType;
    std::string petitionName;
};

struct Signatures
{
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
    void AddPetition(ObjectGuid petitionGUID, ObjectGuid ownerGuid, std::string const& name, uint8 type);
    void RemovePetition(ObjectGuid petitionGUID);
    void RemovePetitionByOwnerAndType(ObjectGuid ownerGuid, uint8 type);
    Petition const* GetPetition(ObjectGuid petitionGUID) const;
    Petition const* GetPetitionByOwnerWithType(ObjectGuid ownerGuid, uint8 type) const;
    PetitionContainer* GetPetitionStore() { return &PetitionStore; }

    // Signatures
    void AddSignature(ObjectGuid petitionGUID, uint32 accountId, ObjectGuid playerGuid);
    void RemoveSignaturesByPlayer(ObjectGuid playerGuid);
    void RemoveSignaturesByPlayerAndType(ObjectGuid playerGuid, uint8 type);
    Signatures const* GetSignature(ObjectGuid petitionGUID) const;
    SignatureContainer* GetSignatureStore() { return &SignatureStore; }

protected:
    PetitionContainer PetitionStore;
    SignatureContainer SignatureStore;
};

#define sPetitionMgr PetitionMgr::instance()

#endif
