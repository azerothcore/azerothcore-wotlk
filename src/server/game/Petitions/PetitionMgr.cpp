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

#include "PetitionMgr.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
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
    PetitionIdToItemGuid.clear();

    QueryResult result = CharacterDatabase.Query("SELECT ownerguid, petitionguid, name, type, petition_id FROM petition");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Petitions!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    uint32 maxId = 0;
    do
    {
        Field* fields = result->Fetch();
        uint32 itemLow = fields[1].Get<uint32>();
        uint32 petitionId = fields[4].Get<uint32>();
        ObjectGuid itemGuid = ObjectGuid::Create<HighGuid::Item>(itemLow);
        ObjectGuid ownerGuid = ObjectGuid::Create<HighGuid::Player>(fields[0].Get<uint32>());
        AddPetition(itemGuid, ownerGuid, fields[2].Get<std::string>(), fields[3].Get<uint8>(), petitionId);
        PetitionIdToItemGuid[petitionId] = itemGuid;
        if (petitionId > maxId)
            maxId = petitionId;
        ++count;
    } while (result->NextRow());

    // initialize next id (keep within 31-bit safe range)
    _nextPetitionId = std::min<uint32>(std::max<uint32>(maxId + 1, 1), 0x7FFFFFFFu);

    LOG_INFO("server.loading", ">> Loaded {} Petitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void PetitionMgr::LoadSignatures()
{
    uint32 oldMSTime = getMSTime();
    SignatureStore.clear();

    QueryResult result = CharacterDatabase.Query("SELECT petition_id, playerguid, player_account FROM petition_sign");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Petition signs!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();
        uint32 petitionId = fields[0].Get<uint32>();
        auto it = PetitionIdToItemGuid.find(petitionId);
        if (it == PetitionIdToItemGuid.end())
            continue; // orphan signature, skip
        AddSignature(it->second, fields[2].Get<uint32>(), ObjectGuid::Create<HighGuid::Player>(fields[1].Get<uint32>()));
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Petition signs in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void PetitionMgr::AddPetition(ObjectGuid petitionGUID, ObjectGuid ownerGuid, std::string const& name, uint8 type, uint32 petitionId)
{
    Petition& p = PetitionStore[petitionGUID];
    p.petitionGuid = petitionGUID;
    p.petitionId = petitionId;
    p.ownerGuid = ownerGuid;
    p.petitionName = name;
    p.petitionType = type;

    Signatures& s = SignatureStore[petitionGUID];
    s.petitionGuid = petitionGUID;
    s.signatureMap.clear();
}

void PetitionMgr::RemovePetition(ObjectGuid petitionGUID)
{
    auto it = PetitionStore.find(petitionGUID);
    if (it != PetitionStore.end())
    {
        PetitionIdToItemGuid.erase(it->second.petitionId);
        PetitionStore.erase(it);
    }

    // remove signatures
    SignatureStore.erase(petitionGUID);
}

void PetitionMgr::RemovePetitionByOwnerAndType(ObjectGuid ownerGuid, uint8 type)
{
    for (PetitionContainer::iterator itr = PetitionStore.begin(); itr != PetitionStore.end();)
    {
        if (itr->second.ownerGuid == ownerGuid && (!type || type == itr->second.petitionType))
        {
            // Remove invalid charter item
            if (type == itr->second.petitionType)
            {
                if (Player* owner = ObjectAccessor::FindConnectedPlayer(ownerGuid))
                {
                    if (Item* item = owner->GetItemByGuid(itr->first))
                    {
                        owner->DestroyItem(item->GetBagSlot(), item->GetSlot(), true);
                    }
                }
            }

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

Petition const* PetitionMgr::GetPetitionById(uint32 petitionId) const
{
    auto it = PetitionIdToItemGuid.find(petitionId);
    if (it == PetitionIdToItemGuid.end())
        return nullptr;

    return GetPetition(it->second);
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

uint32 PetitionMgr::GeneratePetitionId()
{
    // ensure 31-bit range and avoid collisions with already loaded petitions
    if (_nextPetitionId == 0 || _nextPetitionId >= 0x7FFFFFFF)
        _nextPetitionId = 1;

    // find first free id
    while (PetitionIdToItemGuid.count(_nextPetitionId))
    {
        ++_nextPetitionId;
        if (_nextPetitionId >= 0x7FFFFFFF)
            _nextPetitionId = 1;
    }

    uint32 id = _nextPetitionId++;
    if (_nextPetitionId >= 0x7FFFFFFF)
        _nextPetitionId = 1;
    return id;
}

uint32 PetitionMgr::GetPetitionIdByItemGuid(ObjectGuid petitionItemGuid) const
{
    Petition const* p = GetPetition(petitionItemGuid);
    return p ? p->petitionId : 0;
}

ObjectGuid PetitionMgr::GetItemGuidByPetitionId(uint32 petitionId) const
{
    auto it = PetitionIdToItemGuid.find(petitionId);
    if (it == PetitionIdToItemGuid.end())
        return ObjectGuid::Empty;
    return it->second;
}
