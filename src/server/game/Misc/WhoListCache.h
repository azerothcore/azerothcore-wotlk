/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef __WHOLISTCACHE_H
#define __WHOLISTCACHE_H

#include "Common.h"
#include "SharedDefines.h"

struct WhoListPlayerInfo
{
    TeamId teamId;
    AccountTypes security;
    uint8 level;
    uint8 clas;
    uint8 race;
    uint32 zoneid;
    uint8 gender;
    std::wstring wpname;
    std::wstring wgname;
    std::string aname;
    std::string pname;
    std::string gname;

    WhoListPlayerInfo(TeamId teamId, AccountTypes security, uint8 level, uint8 clas, uint8 race, uint32 zoneid, uint8 gender, std::wstring wpname, std::wstring wgname, std::string aname, std::string pname, std::string gname) :
        teamId(teamId), security(security), level(level), clas(clas), race(race), zoneid(zoneid), gender(gender), wpname(wpname), wgname(wgname), aname(aname), pname(pname), gname(gname) {}
};

class WhoListCacheMgr
{
public:
    static void Update();
    static std::vector<WhoListPlayerInfo>* GetWhoList() { return &m_whoOpcodeList; }

protected:
    static std::vector<WhoListPlayerInfo> m_whoOpcodeList;
};

#endif
