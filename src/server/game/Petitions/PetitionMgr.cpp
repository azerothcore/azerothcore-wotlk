/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
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
        AddPetition(ObjectGuid::Create<HighGuid::Item>(fields[1].GetUInt32()), ObjectGuid::Create<HighGuid::Player>(fields[0].GetUInt32()), fields[2].GetString(), fields[3].GetUInt8());
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
        AddSignature(ObjectGuid::Create<HighGuid::Item>(fields[0].GetUInt32()), fields[2].GetUInt32(), ObjectGuid::Create<HighGuid::Player>(fields[1].GetUInt32()));
        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %d Petition signs in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void PetitionMgr::AddPetition(ObjectGuid petitionGUID, ObjectGuid ownerGuid, std::string const& name, uint8 type)
{
    Petition& p = PetitionStore[petitionGUID];
    p.petitionGuid = petitionGUID;
    p.ownerGuid = ownerGuid;
    p.petitionName = name;
    p.petitionType = type;

    Signatures& s = SignatureStore[petitionGUID];
    s.petitionGuid = petitionGUID;
    s.signatureMap.clear();
}

void PetitionMgr::RemovePetition(ObjectGuid petitionGUID)
{
    PetitionStore.erase(petitionGUID);

    // remove signatures
    SignatureStore.erase(petitionGUID);
}

void PetitionMgr::RemovePetitionByOwnerAndType(ObjectGuid ownerGuid, uint8 type)
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

Petition const* PetitionMgr::GetPetition(ObjectGuid petitionGUID) const
{
    PetitionContainer::const_iterator itr = PetitionStore.find(petitionGUID);
    if (itr != PetitionStore.end())
        return &itr->second;
    return nullptr;
}

Petition const* PetitionMgr::GetPetitionByOwnerWithType(ObjectGuid ownerGuid, uint8 type) const
{
    for (PetitionContainer::const_iterator itr = PetitionStore.begin(); itr != PetitionStore.end(); ++itr)
        if (itr->second.ownerGuid == ownerGuid && itr->second.petitionType == type)
            return &itr->second;

    return nullptr;
}

void PetitionMgr::AddSignature(ObjectGuid petitionGUID, uint32 accountId, ObjectGuid playerGuid)
{
    Signatures& s = SignatureStore[petitionGUID];
    s.signatureMap[playerGuid] = accountId;
}

Signatures const* PetitionMgr::GetSignature(ObjectGuid petitionGUID) const
{
    SignatureContainer::const_iterator itr = SignatureStore.find(petitionGUID);
    if (itr != SignatureStore.end())
        return &itr->second;
    return nullptr;
}

void PetitionMgr::RemoveSignaturesByPlayer(ObjectGuid playerGuid)
{
    for (SignatureContainer::iterator itr = SignatureStore.begin(); itr != SignatureStore.end(); ++itr)
    {
        SignatureMap::iterator signItr = itr->second.signatureMap.find(playerGuid);
        if (signItr != itr->second.signatureMap.end())
            itr->second.signatureMap.erase(signItr);
    }
}

void PetitionMgr::RemoveSignaturesByPlayerAndType(ObjectGuid playerGuid, uint8 type)
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
