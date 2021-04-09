/*
Xinef
 */

#ifndef _PETITIONMGR_H
#define _PETITIONMGR_H

#include "Common.h"
#include "ObjectGuid.h"

#include <map>

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
