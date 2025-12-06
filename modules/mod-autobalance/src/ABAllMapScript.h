/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef __AB_ALL_MAP_SCRIPT_H
#define __AB_ALL_MAP_SCRIPT_H

#include "ScriptMgr.h"

class AutoBalance_AllMapScript : public AllMapScript
{
public:
    AutoBalance_AllMapScript()
        : AllMapScript("AutoBalance_AllMapScript", {
            ALLMAPHOOK_ON_PLAYER_ENTER_ALL,
            ALLMAPHOOK_ON_PLAYER_LEAVE_ALL
        })
    {
    }

    // hook triggers after the player has already entered the world
    void OnPlayerEnterAll(Map* map, Player* player) override;
    // hook triggers just before the player left the world
    void OnPlayerLeaveAll(Map* map, Player* player) override;
};

#endif
