/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef Realm_h__
#define Realm_h__

#include "Common.h"
// #include "AsioHacksFwd.h"
#include <ace/INET_Addr.h>

enum RealmFlags
{
    REALM_FLAG_NONE             = 0x00,
    REALM_FLAG_VERSION_MISMATCH = 0x01,
    REALM_FLAG_OFFLINE          = 0x02,
    REALM_FLAG_SPECIFYBUILD     = 0x04,
    REALM_FLAG_UNK1             = 0x08,
    REALM_FLAG_UNK2             = 0x10,
    REALM_FLAG_RECOMMENDED      = 0x20,
    REALM_FLAG_NEW              = 0x40,
    REALM_FLAG_FULL             = 0x80
};

struct AC_SHARED_API RealmHandle
{
    RealmHandle() : Realm(0) { }
    RealmHandle(uint32 index) : Realm(index) { }

    uint32 Realm;   // primary key in `realmlist` table

    bool operator<(RealmHandle const& r) const
    {
        return Realm < r.Realm;
    }
};

/// Type of server, this is values from second column of Cfg_Configs.dbc
enum RealmType
{
    REALM_TYPE_NORMAL       = 0,
    REALM_TYPE_PVP          = 1,
    REALM_TYPE_NORMAL2      = 4,
    REALM_TYPE_RP           = 6,
    REALM_TYPE_RPPVP        = 8,

    MAX_CLIENT_REALM_TYPE   = 14,

    REALM_TYPE_FFA_PVP      = 16 // custom, free for all pvp mode like arena PvP in all zones except rest activated places and sanctuaries
                                 // replaced by REALM_PVP in realm list
};

// Storage object for a realm
struct AC_SHARED_API Realm
{
    RealmHandle Id;
    uint32 Build;
    std::unique_ptr<ACE_INET_Addr> ExternalAddress;
    std::unique_ptr<ACE_INET_Addr> LocalAddress;
    std::unique_ptr<ACE_INET_Addr> LocalSubnetMask;
    uint16 Port;
    std::string Name;
    uint8 Type;
    RealmFlags Flags;
    uint8 Timezone;
    AccountTypes AllowedSecurityLevel;
    float PopulationLevel;

    // boost::asio::ip::tcp_endpoint GetAddressForClient(boost::asio::ip::address const& clientAddr) const;
};

#endif // Realm_h__
