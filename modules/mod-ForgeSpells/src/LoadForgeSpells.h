#pragma once

#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include <unordered_map>
#include <list>

class LoadForgeSpells
{
public:
    LoadForgeSpells();

    virtual void Load();
};
