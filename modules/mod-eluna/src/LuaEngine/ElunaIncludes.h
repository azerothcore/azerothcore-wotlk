/*
* Copyright (C) 2010 - 2016 Eluna Lua Engine <http://emudevs.com/>
* This program is free software licensed under GPL version 3
* Please see the included DOCS/LICENSE.md for more information
*/

#ifndef _ELUNA_INCLUDES_H
#define _ELUNA_INCLUDES_H

// Required
#include "AccountMgr.h"
#include "AuctionHouseMgr.h"
#include "Cell.h"
#include "CellImpl.h"
#include "Chat.h"
#include "Channel.h"
#include "DBCStores.h"
#include "GameEventMgr.h"
#include "GossipDef.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Group.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "Language.h"
#include "Mail.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "Pet.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "TemporarySummon.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "MapMgr.h"
#include "Config.h"
#include "GameEventMgr.h"
#include "GitRevision.h"
#include "GroupMgr.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "WeatherMgr.h"
#include "Battleground.h"
#include "MotionMaster.h"
#include "DatabaseEnv.h"
#include "Bag.h"
#include "Vehicle.h"
#include "ArenaTeam.h"
#include "WorldSessionMgr.h"

typedef Opcodes                 OpcodesList;

/*
 * Note: if you add or change a CORE_NAME or CORE_VERSION #define,
 *   please update LuaGlobalFunctions::GetCoreName or LuaGlobalFunctions::GetCoreVersion documentation example string.
 */
#define CORE_NAME               "AzerothCore"

#define CORE_VERSION            (GitRevision::GetFullVersion())
#define eWorldSessionMgr        (sWorldSessionMgr)
#define eWorld                  (sWorld)
#define eMapMgr                 (sMapMgr)
#define eConfigMgr              (sConfigMgr)
#define eGuildMgr               (sGuildMgr)
#define eObjectMgr              (sObjectMgr)
#define eAccountMgr             (sAccountMgr)
#define eAuctionMgr             (sAuctionMgr)
#define eGameEventMgr           (sGameEventMgr)
#define eObjectAccessor()       ObjectAccessor::

#endif // _ELUNA_INCLUDES_H
