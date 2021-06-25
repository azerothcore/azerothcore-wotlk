/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "IPLocation.h"
#include "Common.h"
#include "Config.h"
#include "Errors.h"
#include "IpAddress.h"
#include "Log.h"
#include "StringConvert.h"
#include <fstream>
#include <iostream>

IpLocationStore::IpLocationStore()
{
}

IpLocationStore::~IpLocationStore()
{
}

void IpLocationStore::Load()
{
    _ipLocationStore.clear();
    LOG_INFO("server.loading", "Loading IP Location Database...");

    std::string databaseFilePath = sConfigMgr->GetOption<std::string>("IPLocationFile", "");
    if (databaseFilePath.empty())
    {
        LOG_INFO("server.loading", " ");
        return;
    }

    // Check if file exists
    std::ifstream databaseFile(databaseFilePath);
    if (!databaseFile)
    {
        LOG_ERROR("server.loading", "IPLocation: No ip database file exists (%s).", databaseFilePath.c_str());
        return;
    }

    if (!databaseFile.is_open())
    {
        LOG_ERROR("server.loading", "IPLocation: Ip database file (%s) can not be opened.", databaseFilePath.c_str());
        return;
    }

    std::string ipFrom;
    std::string ipTo;
    std::string countryCode;
    std::string countryName;

    while (databaseFile.good())
    {
        // Read lines
        if (!std::getline(databaseFile, ipFrom, ','))
            break;
        if (!std::getline(databaseFile, ipTo, ','))
            break;
        if (!std::getline(databaseFile, countryCode, ','))
            break;
        if (!std::getline(databaseFile, countryName, '\n'))
            break;

        // Remove new lines and return
        countryName.erase(std::remove(countryName.begin(), countryName.end(), '\r'), countryName.end());
        countryName.erase(std::remove(countryName.begin(), countryName.end(), '\n'), countryName.end());

        // Remove quotation marks
        ipFrom.erase(std::remove(ipFrom.begin(), ipFrom.end(), '"'), ipFrom.end());
        ipTo.erase(std::remove(ipTo.begin(), ipTo.end(), '"'), ipTo.end());
        countryCode.erase(std::remove(countryCode.begin(), countryCode.end(), '"'), countryCode.end());
        countryName.erase(std::remove(countryName.begin(), countryName.end(), '"'), countryName.end());

        // Convert country code to lowercase
        std::transform(countryCode.begin(), countryCode.end(), countryCode.begin(), ::tolower);

        auto IpFrom = Acore::StringTo<uint32>(ipFrom);
        auto IpTo = Acore::StringTo<uint32>(ipTo);

        if (!IpFrom || !IpTo)
            continue;

        _ipLocationStore.emplace_back(*IpFrom, *IpTo, std::move(countryCode), std::move(countryName));
    }

    std::sort(_ipLocationStore.begin(), _ipLocationStore.end(), [](IpLocationRecord const& a, IpLocationRecord const& b) { return a.IpFrom < b.IpFrom; });
    ASSERT(std::is_sorted(_ipLocationStore.begin(), _ipLocationStore.end(), [](IpLocationRecord const& a, IpLocationRecord const& b) { return a.IpFrom < b.IpTo; }),
        "Overlapping IP ranges detected in database file");

    databaseFile.close();

    LOG_INFO("server.loading", ">> Loaded %u ip location entries.", static_cast<uint32>(_ipLocationStore.size()));
    LOG_INFO("server.loading", " ");
}

IpLocationRecord const* IpLocationStore::GetLocationRecord(std::string const& ipAddress) const
{
    uint32 ip = Acore::Net::address_to_uint(Acore::Net::make_address_v4(ipAddress));
    auto itr = std::upper_bound(_ipLocationStore.begin(), _ipLocationStore.end(), ip, [](uint32 ip, IpLocationRecord const& loc) { return ip < loc.IpTo; });
    if (itr == _ipLocationStore.end())
    {
        return nullptr;
    }

    if (ip < itr->IpFrom)
    {
        return nullptr;
    }

    return &(*itr);
}

IpLocationStore* IpLocationStore::instance()
{
    static IpLocationStore instance;
    return &instance;
}
