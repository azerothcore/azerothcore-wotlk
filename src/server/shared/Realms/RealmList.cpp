/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "RealmList.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Optional.h"
#include "Util.h"

RealmList::RealmList() :
    _updateInterval(0) { }

RealmList* RealmList::instance()
{
    static RealmList instance;
    return &instance;
}

// Load the realm list from the database
void RealmList::Initialize(uint32 updateInterval)
{
    _updateInterval = updateInterval;

    LoadBuildInfo();

    // Get the content of the realmlist table in the database
    UpdateRealms();
}

void RealmList::LoadBuildInfo()
{
    //                                                              0             1              2              3      4                5                6
    if (QueryResult result = LoginDatabase.Query("SELECT majorVersion, minorVersion, bugfixVersion, hotfixVersion, build, winChecksumSeed, macChecksumSeed FROM build_info ORDER BY build ASC"))
    {
        do
        {
            Field* fields = result->Fetch();
            RealmBuildInfo& build = _builds.emplace_back();
            build.MajorVersion = fields[0].GetUInt32();
            build.MinorVersion = fields[1].GetUInt32();
            build.BugfixVersion = fields[2].GetUInt32();
            std::string hotfixVersion = fields[3].GetString();

            if (hotfixVersion.length() < build.HotfixVersion.size())
            {
                std::copy(hotfixVersion.begin(), hotfixVersion.end(), build.HotfixVersion.begin());
            }
            else
            {
                std::fill(hotfixVersion.begin(), hotfixVersion.end(), '\0');
            }

            build.Build = fields[4].GetUInt32();
            std::string windowsHash = fields[5].GetString();

            if (windowsHash.length() == build.WindowsHash.size() * 2)
            {
                HexStrToByteArray(windowsHash, build.WindowsHash);
            }

            std::string macHash = fields[6].GetString();

            if (macHash.length() == build.MacHash.size() * 2)
            {
                HexStrToByteArray(macHash, build.MacHash);
            }
        } while (result->NextRow());
    }
}

void RealmList::UpdateRealm(RealmHandle const& id, uint32 build, std::string const& name,
    ACE_INET_Addr&& address, ACE_INET_Addr&& localAddr, ACE_INET_Addr&& localSubmask,
    uint16 port, uint8 icon, RealmFlags flag, uint8 timezone, AccountTypes allowedSecurityLevel, float population)
{
    // Create new if not exist or update existed
    Realm& realm = _realms[id];

    realm.Id = id;
    realm.Build = build;
    realm.Name = name;
    realm.Type = icon;
    realm.Flags = flag;
    realm.Timezone = timezone;
    realm.AllowedSecurityLevel = allowedSecurityLevel;
    realm.PopulationLevel = population;

    if (!realm.ExternalAddress || *realm.ExternalAddress != address)
    {
        realm.ExternalAddress = std::make_unique<ACE_INET_Addr>(std::move(address));
    }

    if (!realm.LocalAddress || *realm.LocalAddress != localAddr)
    {
        realm.LocalAddress = std::make_unique<ACE_INET_Addr>(std::move(localAddr));
    }

    if (!realm.LocalSubnetMask || *realm.LocalSubnetMask != localSubmask)
    {
        realm.LocalSubnetMask = std::make_unique<ACE_INET_Addr>(std::move(localSubmask));
    }

    realm.Port = port;
}

void RealmList::UpdateIfNeed()
{
    // maybe disabled or updated recently
    if (!_updateInterval || _nextUpdateTime > time(nullptr))
    {
        return;
    }

    _nextUpdateTime = time(nullptr) + _updateInterval;

    // Get the content of the realmlist table in the database
    UpdateRealms();
}

void RealmList::UpdateRealms()
{
    LOG_DEBUG("server.authserver", "Updating Realm List...");

    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_REALMLIST);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    std::map<RealmHandle, std::string> existingRealms;
    for (auto const& [handle, realm] : _realms)
    {
        existingRealms[handle] = realm.Name;
    }

    _realms.clear();

    // Circle through results and add them to the realm map
    if (result)
    {
        do
        {
            Field* fields                       = result->Fetch();
            uint32 realmId                      = fields[0].GetUInt32();
            std::string name                    = fields[1].GetString();
            std::string externalAddressString   = fields[2].GetString();
            std::string localAddressString      = fields[3].GetString();
            std::string localSubmaskString      = fields[4].GetString();
            uint16 port                         = fields[5].GetUInt16();

            Optional<ACE_INET_Addr> externalAddress = ACE_INET_Addr(port, externalAddressString.c_str(), AF_INET);
            if (!externalAddress)
            {
                LOG_ERROR("server.authserver", "Could not resolve address %s for realm \"%s\" id %u", externalAddressString.c_str(), name.c_str(), realmId);
                continue;
            }

            Optional<ACE_INET_Addr> localAddress = ACE_INET_Addr(port, localAddressString.c_str(), AF_INET);
            if (!localAddress)
            {
                LOG_ERROR("server.authserver", "Could not resolve localAddress %s for realm \"%s\" id %u", localAddressString.c_str(), name.c_str(), realmId);
                continue;
            }

            Optional<ACE_INET_Addr> localSubmask = ACE_INET_Addr(0, localSubmaskString.c_str(), AF_INET);
            if (!localSubmask)
            {
                LOG_ERROR("server.authserver", "Could not resolve localSubnetMask %s for realm \"%s\" id %u", localSubmaskString.c_str(), name.c_str(), realmId);
                continue;
            }

            uint8 icon = fields[6].GetUInt8();

            if (icon == REALM_TYPE_FFA_PVP)
            {
                icon = REALM_TYPE_PVP;
            }

            if (icon >= MAX_CLIENT_REALM_TYPE)
            {
                icon = REALM_TYPE_NORMAL;
            }

            RealmFlags flag             = RealmFlags(fields[7].GetUInt8());
            uint8 timezone              = fields[8].GetUInt8();
            uint8 allowedSecurityLevel  = fields[9].GetUInt8();
            float pop                   = fields[10].GetFloat();
            uint32 build                = fields[11].GetUInt32();

            RealmHandle id{ realmId };

            UpdateRealm(id, build, name, std::move(externalAddress.value()), std::move(localAddress.value()), std::move(localSubmask.value()), port, icon, flag,
                timezone, (allowedSecurityLevel <= SEC_ADMINISTRATOR ? AccountTypes(allowedSecurityLevel) : SEC_ADMINISTRATOR), pop);

            if (!existingRealms.count(id))
            {
                LOG_INFO("server.authserver", "Added realm \"%s\" at %s:%u.", name.c_str(), externalAddressString.c_str(), port);
            }
            else
            {
                LOG_DEBUG("server.authserver", "Updating realm \"%s\" at %s:%u.", name.c_str(), externalAddressString.c_str(), port);
            }

            existingRealms.erase(id);
        } while (result->NextRow());
    }
}

Realm const* RealmList::GetRealm(RealmHandle const& id) const
{
    auto itr = _realms.find(id);
    if (itr != _realms.end())
    {
        return &itr->second;
    }

    return nullptr;
}

RealmBuildInfo const* RealmList::GetBuildInfo(uint32 build) const
{
    for (RealmBuildInfo const& clientBuild : _builds)
    {
        if (clientBuild.Build == build)
        {
            return &clientBuild;
        }
    }

    return nullptr;
}
