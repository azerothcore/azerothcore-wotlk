/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef _AUTOBROADCAST_MANAGER_H_
#define _AUTOBROADCAST_MANAGER_H_

#include "Common.h"

enum class AnnounceType : uint8
{
    WORLD = 0,
    NOTIFICATION,
    BOTH
};

class AC_GAME_API AutobroadcastMgr
{
public:
    static AutobroadcastMgr* instance();

    void Load();
    void Send();

private:
    typedef std::map<LocaleConstant, std::string> AutobroadcastTextLocale;
    AutobroadcastTextLocale m_AutobroadcastTextLocale;

    typedef std::map<uint8, AutobroadcastTextLocale> AutobroadcastsLocaleMap;
    AutobroadcastsLocaleMap m_Autobroadcasts;

    typedef std::map<uint8, uint8> AutobroadcastsWeightMap;
    AutobroadcastsWeightMap m_AutobroadcastsWeights;
};

#define sAutobroadcastMgr AutobroadcastMgr::instance()

#endif // _AUTOBROADCAST_MANAGER_H_
