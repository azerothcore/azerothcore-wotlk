/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#include "ArenaTeam.h"
#include "Define.h"
#include "SmartEnum.h"
#include <stdexcept>

namespace Acore::Impl::EnumUtilsImpl
{

/******************************************************************\
|* data for enum 'ArenaTeamTypes' in 'ArenaTeam.h' auto-generated *|
\******************************************************************/
template <>
AC_API_EXPORT EnumText EnumUtils<ArenaTeamTypes>::ToString(ArenaTeamTypes value)
{
    switch (value)
    {
        case ARENA_TEAM_2v2: return { "ARENA_TEAM_2v2", "ARENA_TEAM_2v2", "" };
        case ARENA_TEAM_3v3: return { "ARENA_TEAM_3v3", "ARENA_TEAM_3v3", "" };
        case ARENA_TEAM_5v5: return { "ARENA_TEAM_5v5", "ARENA_TEAM_5v5", "" };
        default: throw std::out_of_range("value");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<ArenaTeamTypes>::Count() { return 3; }

template <>
AC_API_EXPORT ArenaTeamTypes EnumUtils<ArenaTeamTypes>::FromIndex(size_t index)
{
    switch (index)
    {
        case 0: return ARENA_TEAM_2v2;
        case 1: return ARENA_TEAM_3v3;
        case 2: return ARENA_TEAM_5v5;
        default: throw std::out_of_range("index");
    }
}

template <>
AC_API_EXPORT size_t EnumUtils<ArenaTeamTypes>::ToIndex(ArenaTeamTypes value)
{
    switch (value)
    {
        case ARENA_TEAM_2v2: return 0;
        case ARENA_TEAM_3v3: return 1;
        case ARENA_TEAM_5v5: return 2;
        default: throw std::out_of_range("value");
    }
}
}
