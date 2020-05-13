/*
Xinef
 */

#ifndef _PETITIONMGR_H
#define _PETITIONMGR_H

#include "Common.h"
#include <map>

typedef std::map<uint32, uint32> SignatureMap;

struct Petition
{
    uint32 petitionGuid;
    uint32 ownerGuid;
    uint8  petitionType;
    std::string petitionName;
};

struct Signatures
{
    uint32 petitionGuid;
    SignatureMap signatureMap;
};

typedef std::map<uint32, Signatures> SignatureContainer;
typedef std::map<uint32, Petition> PetitionContainer;

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
        void AddPetition(uint32 petitionId, uint32 ownerGuid, std::string const& name, uint8 type);
        void RemovePetition(uint32 petitionId);
        void RemovePetitionByOwnerAndType(uint32 ownerGuid, uint8 type);
        Petition const* GetPetition(uint32 petitionId) const;
        Petition const* GetPetitionByOwnerWithType(uint32 ownerGuid, uint8 type) const;
        PetitionContainer* GetPetitionStore() { return &PetitionStore; }

        // Signatures
        void AddSignature(uint32 petitionId, uint32 accountId, uint32 playerGuid);
        void RemoveSignaturesByPlayer(uint32 playerGuid);
        void RemoveSignaturesByPlayerAndType(uint32 playerGuid, uint8 type);
        Signatures const* GetSignature(uint32 petitionId) const;
        SignatureContainer* GetSignatureStore() { return &SignatureStore; }

    protected:
        PetitionContainer PetitionStore;
        SignatureContainer SignatureStore;
};

#define sPetitionMgr PetitionMgr::instance()

#endif
