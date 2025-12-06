/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef __AB_WORLD_SCRIPT_H
#define __AB_WORLD_SCRIPT_H

#include "WorldScript.h"

class AutoBalance_WorldScript : public WorldScript
{
public:
    AutoBalance_WorldScript()
        : WorldScript("AutoBalance_WorldScript", {
            WORLDHOOK_ON_BEFORE_CONFIG_LOAD
        })
    {
    }

    void OnBeforeConfigLoad(bool /*reload*/) override;

    void SetInitialWorldSettings();
};

#endif
