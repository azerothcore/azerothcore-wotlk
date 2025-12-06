/*
* Copyright (C) 2018 AzerothCore <http://www.azerothcore.org>
* Copyright (C) 2012 CVMagic <http://www.trinitycore.org/f/topic/6551-vas-autobalance/>
* Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
* Copyright (C) 1985-2010 KalCorp  <http://vasserver.dyndns.org/>
*
* This program is free software; you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by the
* Free Software Foundation; either version 2 of the License, or (at your
* option) any later version.
*
* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
* more details.
*
* You should have received a copy of the GNU General Public License along
* with this program. If not, see <http://www.gnu.org/licenses/>.
*/

/*
* Script Name: AutoBalance
* Original Authors: KalCorp and Vaughner
* Maintainer(s): AzerothCore
* Original Script Name: AutoBalance
* Description: This script is intended to scale based on number of players,
* instance mobs & world bosses' level, health, mana, and damage.
*/

#include "AutoBalance.h"

#include "ABAllCreatureScript.h"
#include "ABAllMapScript.h"
#include "ABCommandScript.h"
#include "ABConfig.h"
#include "ABCreatureInfo.h"
#include "ABGameObjectScript.h"
#include "ABGlobalScript.h"
#include "ABInflectionPointSettings.h"
#include "ABLevelScalingDynamicLevelSettings.h"
#include "ABMapInfo.h"
#include "ABModuleScript.h"
#include "ABPlayerScript.h"
#include "ABScriptMgr.h"
#include "ABStatModifiers.h"
#include "ABUnitScript.h"
#include "ABUtils.h"
#include "ABWorldScript.h"

#include "Configuration/Config.h"
#include "Chat.h"
#include "Creature.h"
#include "Group.h"
#include "Language.h"
#include "Log.h"
#include "Map.h"
#include "MapMgr.h"
#include "Message.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"
#include "SharedDefines.h"
#include "Unit.h"
#include "World.h"

#include <chrono>
#include <vector>

#if AC_COMPILER == AC_COMPILER_GNU
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif

void AddAutoBalanceScripts()
{
    new AutoBalance_WorldScript();
    new AutoBalance_PlayerScript();
    new AutoBalance_UnitScript();
    new AutoBalance_GameObjectScript();
    new AutoBalance_AllCreatureScript();
    new AutoBalance_AllMapScript();
    new AutoBalance_CommandScript();
    new AutoBalance_GlobalScript();
}
