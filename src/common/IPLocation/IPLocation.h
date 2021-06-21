/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "Define.h"
#include <string>
#include <vector>

struct IpLocationRecord
{
    IpLocationRecord() :
        IpFrom(0), IpTo(0) { }
    IpLocationRecord(uint32 ipFrom, uint32 ipTo, std::string countryCode, std::string countryName) :
        IpFrom(ipFrom), IpTo(ipTo), CountryCode(std::move(countryCode)), CountryName(std::move(countryName)) { }

    uint32 IpFrom;
    uint32 IpTo;
    std::string CountryCode;
    std::string CountryName;
};

class AC_COMMON_API IpLocationStore
{
public:
    IpLocationStore();
    ~IpLocationStore();
    static IpLocationStore* instance();

    void Load();
    IpLocationRecord const* GetLocationRecord(std::string const& ipAddress) const;

private:
    std::vector<IpLocationRecord> _ipLocationStore;
};

#define sIPLocation IpLocationStore::instance()
