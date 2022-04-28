/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifdef MOD_PLAYERBOTS

#ifndef _PlayerbotsDatabase_H
#define _PlayerbotsDatabase_H

#include "MySQLConnection.h"

enum PlayerbotsDatabaseStatements : uint32
{
    /*  Naming standard for defines:
        {DB}_{SEL/INS/UPD/DEL/REP}_{Summary of data changed}
        When updating more than one field, consider looking at the calling function
        name for a suiting suffix.
    */

    PLAYERBOTS_SEL_CUSTOM_STRATEGY_BY_OWNER,
    PLAYERBOTS_SEL_CUSTOM_STRATEGY_BY_OWNER_AND_NAME,
    PLAYERBOTS_SEL_CUSTOM_STRATEGY_BY_OWNER_AND_NAME_AND_IDX,
    PLAYERBOTS_DEL_CUSTOM_STRATEGY,
    PLAYERBOTS_UPD_CUSTOM_STRATEGY,
    PLAYERBOTS_INS_CUSTOM_STRATEGY,

    PLAYERBOTS_SEL_DB_STORE,
    PLAYERBOTS_DEL_DB_STORE,
    PLAYERBOTS_INS_DB_STORE,

    PLAYERBOTS_SEL_ENCHANTS,

    PLAYERBOTS_SEL_EQUIP_CACHE,
    PLAYERBOTS_INS_EQUIP_CACHE,

    PLAYERBOTS_SEL_GUILD_TASKS_BY_VALUE,
    PLAYERBOTS_SEL_GUILD_TASKS_BY_OWNER,
    PLAYERBOTS_SEL_GUILD_TASKS_BY_OWNER_AND_TYPE,
    PLAYERBOTS_SEL_GUILD_TASKS_BY_OWNER_DISTINCT,
    PLAYERBOTS_SEL_GUILD_TASKS_BY_OWNER_ORDERED,
    PLAYERBOTS_DEL_GUILD_TASKS,
    PLAYERBOTS_INS_GUILD_TASKS,

    PLAYERBOTS_SEL_RANDOM_BOTS_VALUE,
    PLAYERBOTS_SEL_RANDOM_BOTS_BOT,
    PLAYERBOTS_SEL_RANDOM_BOTS_BY_OWNER_AND_EVENT,
    PLAYERBOTS_SEL_RANDOM_BOTS_BY_OWNER_AND_BOT,
    PLAYERBOTS_SEL_RANDOM_BOTS_BY_EVENT_AND_VALUE,
    PLAYERBOTS_INS_RANDOM_BOTS,
    PLAYERBOTS_DEL_RANDOM_BOTS,
    PLAYERBOTS_DEL_RANDOM_BOTS_BY_OWNER,
    PLAYERBOTS_DEL_RANDOM_BOTS_BY_OWNER_AND_EVENT,
    PLAYERBOTS_UPD_RANDOM_BOTS,

    PLAYERBOTS_SEL_RARITY_CACHE,
    PLAYERBOTS_INS_RARITY_CACHE,

    PLAYERBOTS_SEL_RNDITEM_CACHE,
    PLAYERBOTS_INS_RNDITEM_CACHE,

    PLAYERBOTS_SEL_SPEECH,
    PLAYERBOTS_SEL_SPEECH_PROBABILITY,

    PLAYERBOTS_SEL_TELE_CACHE,
    PLAYERBOTS_INS_TELE_CACHE,

    PLAYERBOTS_SEL_TEXT,
    PLAYERBOTS_SEL_DUNGEON_SUGGESTION,

    PLAYERBOTS_SEL_TRAVELNODE,
    PLAYERBOTS_INS_TRAVELNODE,
    PLAYERBOTS_DEL_TRAVELNODE,

    PLAYERBOTS_SEL_TRAVELNODE_LINK,
    PLAYERBOTS_INS_TRAVELNODE_LINK,
    PLAYERBOTS_DEL_TRAVELNODE_LINK,

    PLAYERBOTS_SEL_TRAVELNODE_PATH,
    PLAYERBOTS_INS_TRAVELNODE_PATH,
    PLAYERBOTS_DEL_TRAVELNODE_PATH,

    PLAYERBOTS_SEL_WEIGHTSCALES,
    PLAYERBOTS_SEL_WEIGHTSCALE_DATA,

    PLAYERBOTS_INS_EQUIP_CACHE_NEW,
    PLAYERBOTS_DEL_EQUIP_CACHE_NEW,

    MAX_PLAYERBOTS_STATEMENTS
};

class AC_DATABASE_API PlayerbotsDatabaseConnection : public MySQLConnection
{
public:
    typedef PlayerbotsDatabaseStatements Statements;

    //- Constructors for sync and async connections
    PlayerbotsDatabaseConnection(MySQLConnectionInfo& connInfo);
    PlayerbotsDatabaseConnection(ProducerConsumerQueue<SQLOperation*>* q, MySQLConnectionInfo& connInfo);
    ~PlayerbotsDatabaseConnection();

    //- Loads database type specific prepared statements
    void DoPrepareStatements() override;
};

#endif

#endif
