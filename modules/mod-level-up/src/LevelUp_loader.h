/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef _LEVELUP_MODULE_LOADER_H_
#define _LEVELUP_MODULE_LOADER_H_

// From SC
void AddLevelUpPlayerScripts();

// Add all
void AddLevelUpModuleScripts()
{
    AddLevelUpPlayerScripts();
}

#endif // _LEVELUP_MODULE_LOADER_H_
