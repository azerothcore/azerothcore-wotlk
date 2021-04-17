/*
Xinef
 */

#include "DatabaseEnv.h"
#include "Log.h"
#include "PetitionMgr.h"
#include "QueryResult.h"
#include "Timer.h"

PetitionMgr::PetitionMgr()
{
}

PetitionMgr::~PetitionMgr()
{
}

PetitionMgr* PetitionMgr::instance()
{
    static PetitionMgr instance;
    return &instance;
}

void PetitionMgr::LoadPetitions()
{
    uint32 oldMSTime = getMSTime();
    PetitionStore.clear();

    QueryResult result = CharacterDatabase.Query("SELECT ownerguid, petitionguid, name, type FROM petition");
    if (!result)
    {
        LOG_INFO("server", ">>  Loaded 0 Petitions!");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();
        AddPetition(fields[1].GetUInt32(), fields[0].GetUInt32(), fields[2].GetString(), fields[3].GetUInt8());
        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %d Petitions in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void PetitionMgr::LoadSignatures()
{
    uint32 oldMSTime = getMSTime();
    SignatureStore.clear();

    QueryResult result = CharacterDatabase.Query("SELECT petitionguid, playerguid, player_account FROM petition_sign");
    if (!result)
    {
        LOG_INFO("server", ">>  Loaded 0 Petition signs!");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();
        AddSignature(fields[0].GetUInt32(), fields[2].GetUInt32(), fields[1].GetUInt32());
        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %d Petition signs in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void PetitionMgr::AddPetition(uint32 petitionId, uint32 ownerGuid, std::string const& name, uint8 type)
{
    Petition& p = PetitionStore[petitionId];
    p.petitionGuid = petitionId;
    p.ownerGuid = ownerGuid;
    p.petitionName = name;
    p.petitionType = type;

    Signatures& s = SignatureStore[petitionId];
    s.petitionGuid = petitionId;
    s.signatureMap.clear();
}

void PetitionMgr::RemovePetition(uint32 petitionId)
{
    PetitionStore.erase(petitionId);

    // remove signatures
    SignatureStore.erase(petitionId);
}

void PetitionMgr::RemovePetitionByOwnerAndType(uint32 ownerGuid, uint8 type)
{
    for (PetitionContainer::iterator itr = PetitionStore.begin(); itr != PetitionStore.end();)
    {
        if (itr->second.ownerGuid == ownerGuid && (!type || type == itr->second.petitionType))
        {
            // remove signatures
            SignatureStore.erase(itr->first);
            PetitionStore.erase(itr++);
        }
        else
            ++itr;
    }
}

Petition const* PetitionMgr::GetPetition(uint32 petitionId) const
{
    PetitionContainer::const_iterator itr = PetitionStore.find(petitionId);
    if (itr != PetitionStore.end())
        return &itr->second;
    return nullptr;
}

Petition const* PetitionMgr::GetPetitionByOwnerWithType(uint32 ownerGuid, uint8 type) const
{
    for (PetitionContainer::const_iterator itr = PetitionStore.begin(); itr != PetitionStore.end(); ++itr)
        if (itr->second.ownerGuid == ownerGuid && itr->second.petitionType == type)
            return &itr->second;

    return nullptr;
}

void PetitionMgr::AddSignature(uint32 petitionId, uint32 accountId, uint32 playerGuid)
{
    Signatures& s = SignatureStore[petitionId];
    s.signatureMap[playerGuid] = accountId;
}

Signatures const* PetitionMgr::GetSignature(uint32 petitionId) const
{
    SignatureContainer::const_iterator itr = SignatureStore.find(petitionId);
    if (itr != SignatureStore.end())
        return &itr->second;
    return nullptr;
}

void PetitionMgr::RemoveSignaturesByPlayer(uint32 playerGuid)
{
    for (SignatureContainer::iterator itr = SignatureStore.begin(); itr != SignatureStore.end(); ++itr)
    {
        SignatureMap::iterator signItr = itr->second.signatureMap.find(playerGuid);
        if (signItr != itr->second.signatureMap.end())
            itr->second.signatureMap.erase(signItr);
    }
}

void PetitionMgr::RemoveSignaturesByPlayerAndType(uint32 playerGuid, uint8 type)
{
    for (SignatureContainer::iterator itr = SignatureStore.begin(); itr != SignatureStore.end(); ++itr)
    {
        Petition const* petition = sPetitionMgr->GetPetition(itr->first);
        if (!petition || petition->petitionType != type)
            continue;

        SignatureMap::iterator signItr = itr->second.signatureMap.find(playerGuid);
        if (signItr != itr->second.signatureMap.end())
            itr->second.signatureMap.erase(signItr);
    }
}
