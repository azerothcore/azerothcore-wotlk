/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _REALMLIST_H
#define _REALMLIST_H

#include "Define.h"
#include "Realm.h"
#include <array>
#include <map>
#include <unordered_set>
#include <vector>

struct RealmBuildInfo
{
    uint32 Build;
    uint32 MajorVersion;
    uint32 MinorVersion;
    uint32 BugfixVersion;
    std::array<char, 4> HotfixVersion;
    std::array<uint8, 20> WindowsHash;
    std::array<uint8, 20> MacHash;
};

namespace boost::system
{
    class error_code;
}

/// Storage object for the list of realms on the server
class AC_SHARED_API RealmList
{
public:
    typedef std::map<RealmHandle, Realm> RealmMap;

    static RealmList* Instance();

    void Initialize(Acore::Asio::IoContext& ioContext, uint32 updateInterval);
    void Close();

    RealmMap const& GetRealms() const { return _realms; }
    Realm const* GetRealm(RealmHandle const& id) const;

    RealmBuildInfo const* GetBuildInfo(uint32 build) const;

private:
    RealmList();
    ~RealmList() = default;

    void LoadBuildInfo();
    void UpdateRealms(boost::system::error_code const& error);
    void UpdateRealm(RealmHandle const& id, uint32 build, std::string const& name,
        boost::asio::ip::address&& address, boost::asio::ip::address&& localAddr, boost::asio::ip::address&& localSubmask,
        uint16 port, uint8 icon, RealmFlags flag, uint8 timezone, AccountTypes allowedSecurityLevel, float population);

    std::vector<RealmBuildInfo> _builds;
    RealmMap _realms;
    uint32 _updateInterval;
    std::unique_ptr<Acore::Asio::DeadlineTimer> _updateTimer;
    std::unique_ptr<Acore::Asio::Resolver> _resolver;
};

#define sRealmList RealmList::Instance()

#endif
