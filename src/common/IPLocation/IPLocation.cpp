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

#include "IPLocation.h"
#include "Config.h"
#include "Errors.h"
#include "IpAddress.h"
#include "Log.h"
#include "StringConvert.h"
#include <fstream>
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
        LOG_ERROR("server.loading", "IPLocation: No ip database file exists ({}).", databaseFilePath);
        return;
    }

    if (!databaseFile.is_open())
    {
        LOG_ERROR("server.loading", "IPLocation: Ip database file ({}) can not be opened.", databaseFilePath);
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

    LOG_INFO("server.loading", ">> Loaded {} ip location entries.", static_cast<uint32>(_ipLocationStore.size()));
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
