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

#include "GuildMgr.h"
#include "Common.h"

GuildMgr::GuildMgr() : NextGuildId(1)
{ }

GuildMgr::~GuildMgr()
{
    for (GuildContainer::iterator itr = GuildStore.begin(); itr != GuildStore.end(); ++itr)
        delete itr->second;
}

GuildMgr* GuildMgr::instance()
{
    static GuildMgr instance;
    return &instance;
}

void GuildMgr::AddGuild(Guild* guild)
{
    GuildStore[guild->GetId()] = guild;
}

void GuildMgr::RemoveGuild(uint32 guildId)
{
    GuildStore.erase(guildId);
}

uint32 GuildMgr::GenerateGuildId()
{
    if (NextGuildId >= 0xFFFFFFFE)
    {
        LOG_ERROR("server.worldserver", "Guild ids overflow!! Can't continue, shutting down server.");
        World::StopNow(ERROR_EXIT_CODE);
    }
    return NextGuildId++;
}

// Guild collection
Guild* GuildMgr::GetGuildById(uint32 guildId) const
{
    GuildContainer::const_iterator itr = GuildStore.find(guildId);
    if (itr != GuildStore.end())
        return itr->second;

    return nullptr;
}

Guild* GuildMgr::GetGuildByName(std::string_view guildName) const
{
    for (auto const& [id, guild] : GuildStore)
        if (StringEqualI(guild->GetName(), guildName))
            return guild;

    return nullptr;
}

std::string GuildMgr::GetGuildNameById(uint32 guildId) const
{
    if (Guild* guild = GetGuildById(guildId))
        return guild->GetName();

    return "";
}

Guild* GuildMgr::GetGuildByLeader(ObjectGuid guid) const
{
    for (GuildContainer::const_iterator itr = GuildStore.begin(); itr != GuildStore.end(); ++itr)
        if (itr->second->GetLeaderGUID() == guid)
            return itr->second;

    return nullptr;
}

void GuildMgr::LoadGuilds()
{
    // 1. Load all guilds
    LOG_INFO("server.loading", "Loading Guilds Definitions...");
    {
        uint32 oldMSTime = getMSTime();

        CharacterDatabase.DirectExecute("DELETE g FROM guild g LEFT JOIN guild_member gm ON g.guildid = gm.guildid WHERE gm.guildid IS NULL");

        //          0          1       2             3              4              5              6
        QueryResult result = CharacterDatabase.Query("SELECT g.guildid, g.name, g.leaderguid, g.EmblemStyle, g.EmblemColor, g.BorderStyle, g.BorderColor, "
                             //   7                  8       9       10            11           12
                             "g.BackgroundColor, g.info, g.motd, g.createdate, g.BankMoney, COUNT(gbt.guildid) "
                             "FROM guild g LEFT JOIN guild_bank_tab gbt ON g.guildid = gbt.guildid GROUP BY g.guildid ORDER BY g.guildid ASC");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 guild definitions. DB table `guild` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();
                Guild* guild = new Guild();

                if (!guild->LoadFromDB(fields))
                {
                    delete guild;
                    continue;
                }

                AddGuild(guild);

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} guild definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    // 2. Load all guild ranks
    LOG_INFO("server.loading", "Loading Guild Ranks...");
    {
        uint32 oldMSTime = getMSTime();

        // Delete orphaned guild rank entries before loading the valid ones
        CharacterDatabase.DirectExecute("DELETE gr FROM guild_rank gr LEFT JOIN guild g ON gr.guildId = g.guildId WHERE g.guildId IS NULL");

        //                                                         0    1      2       3                4
        QueryResult result = CharacterDatabase.Query("SELECT guildid, rid, rname, rights, BankMoneyPerDay FROM guild_rank ORDER BY guildid ASC, rid ASC");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 guild ranks. DB table `guild_rank` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();
                uint32 guildId = fields[0].Get<uint32>();

                if (Guild* guild = GetGuildById(guildId))
                    guild->LoadRankFromDB(fields);

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} guild ranks in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    // 3. Load all guild members
    LOG_INFO("server.loading", "Loading Guild Members...");
    {
        uint32 oldMSTime = getMSTime();

        // Delete orphaned guild member entries before loading the valid ones
        CharacterDatabase.DirectExecute("DELETE gm FROM guild_member gm LEFT JOIN guild g ON gm.guildId = g.guildId WHERE g.guildId IS NULL");
        CharacterDatabase.DirectExecute("DELETE gm FROM guild_member_withdraw gm LEFT JOIN guild_member g ON gm.guid = g.guid WHERE g.guid IS NULL");

        //           0        1         2     3      4        5       6       7       8       9       10
        QueryResult result = CharacterDatabase.Query("SELECT guildid, gm.guid, `rank`, pnote, offnote, w.tab0, w.tab1, w.tab2, w.tab3, w.tab4, w.tab5, "
                          // 11        12      13       14       15        16      17         18
                             "w.money, c.name, c.level, c.class, c.gender, c.zone, c.account, c.logout_time "
                             "FROM guild_member gm "
                             "LEFT JOIN guild_member_withdraw w ON gm.guid = w.guid "
                             "LEFT JOIN characters c ON c.guid = gm.guid ORDER BY guildid ASC");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 guild members. DB table `guild_member` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;

            do
            {
                Field* fields = result->Fetch();
                uint32 guildId = fields[0].Get<uint32>();

                if (Guild* guild = GetGuildById(guildId))
                    guild->LoadMemberFromDB(fields);

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} guild members int {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    // 4. Load all guild bank tab rights
    LOG_INFO("server.loading", "Loading Bank Tab Rights...");
    {
        uint32 oldMSTime = getMSTime();

        // Delete orphaned guild bank right entries before loading the valid ones
        CharacterDatabase.DirectExecute("DELETE gbr FROM guild_bank_right gbr LEFT JOIN guild g ON gbr.guildId = g.guildId WHERE g.guildId IS NULL");

        //      0        1      2    3        4
        QueryResult result = CharacterDatabase.Query("SELECT guildid, TabId, rid, gbright, SlotPerDay FROM guild_bank_right ORDER BY guildid ASC, TabId ASC");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 guild bank tab rights. DB table `guild_bank_right` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();
                uint32 guildId = fields[0].Get<uint32>();

                if (Guild* guild = GetGuildById(guildId))
                    guild->LoadBankRightFromDB(fields);

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} bank tab rights in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    // 5. Load all event logs
    LOG_INFO("server.loading", "Loading Guild Event Logs...");
    {
        uint32 oldMSTime = getMSTime();

        CharacterDatabase.DirectExecute("DELETE FROM guild_eventlog WHERE LogGuid > {}", sWorld->getIntConfig(CONFIG_GUILD_EVENT_LOG_COUNT));

        //          0        1        2          3            4            5        6
        QueryResult result = CharacterDatabase.Query("SELECT guildid, LogGuid, EventType, PlayerGuid1, PlayerGuid2, NewRank, TimeStamp FROM guild_eventlog ORDER BY TimeStamp DESC, LogGuid DESC");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 guild event logs. DB table `guild_eventlog` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();
                uint32 guildId = fields[0].Get<uint32>();

                if (Guild* guild = GetGuildById(guildId))
                    guild->LoadEventLogFromDB(fields);

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} guild event logs in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    // 6. Load all bank event logs
    LOG_INFO("server.loading", "Loading Guild Bank Event Logs...");
    {
        uint32 oldMSTime = getMSTime();

        // Remove log entries that exceed the number of allowed entries per guild
        CharacterDatabase.DirectExecute("DELETE FROM guild_bank_eventlog WHERE LogGuid > {}", sWorld->getIntConfig(CONFIG_GUILD_BANK_EVENT_LOG_COUNT));

        //          0        1      2        3          4           5            6               7          8
        QueryResult result = CharacterDatabase.Query("SELECT guildid, TabId, LogGuid, EventType, PlayerGuid, ItemOrMoney, ItemStackCount, DestTabId, TimeStamp FROM guild_bank_eventlog ORDER BY TimeStamp DESC, LogGuid DESC");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 guild bank event logs. DB table `guild_bank_eventlog` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();
                uint32 guildId = fields[0].Get<uint32>();

                if (Guild* guild = GetGuildById(guildId))
                    guild->LoadBankEventLogFromDB(fields);

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} guild bank event logs in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    // 7. Load all guild bank tabs
    LOG_INFO("server.loading", "Loading Guild Bank Tabs...");
    {
        uint32 oldMSTime = getMSTime();

        // Delete orphaned guild bank tab entries before loading the valid ones
        CharacterDatabase.DirectExecute("DELETE gbt FROM guild_bank_tab gbt LEFT JOIN guild g ON gbt.guildId = g.guildId WHERE g.guildId IS NULL");

        //         0        1      2        3        4
        QueryResult result = CharacterDatabase.Query("SELECT guildid, TabId, TabName, TabIcon, TabText FROM guild_bank_tab ORDER BY guildid ASC, TabId ASC");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 guild bank tabs. DB table `guild_bank_tab` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();
                uint32 guildId = fields[0].Get<uint32>();

                if (Guild* guild = GetGuildById(guildId))
                    guild->LoadBankTabFromDB(fields);

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} guild bank tabs in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    // 8. Fill all guild bank tabs
    LOG_INFO("server.loading", "Filling bank tabs with items...");
    {
        uint32 oldMSTime = getMSTime();

        // Delete orphan guild bank items
        CharacterDatabase.DirectExecute("DELETE gbi FROM guild_bank_item gbi LEFT JOIN guild g ON gbi.guildId = g.guildId WHERE g.guildId IS NULL");

        //          0            1                2      3         4        5      6             7                 8           9           10
        QueryResult result = CharacterDatabase.Query("SELECT creatorGuid, giftCreatorGuid, count, duration, charges, flags, enchantments, randomPropertyId, durability, playedTime, text, "
                             //   11       12     13      14         15
                             "guildid, TabId, SlotId, item_guid, itemEntry FROM guild_bank_item gbi INNER JOIN item_instance ii ON gbi.item_guid = ii.guid");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 guild bank tab items. DB table `guild_bank_item` or `item_instance` is empty.");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();
                uint32 guildId = fields[11].Get<uint32>();

                if (Guild* guild = GetGuildById(guildId))
                    guild->LoadBankItemFromDB(fields);

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} guild bank tab items in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    // 9. Validate loaded guild data
    LOG_INFO("server.loading", "Validating data of loaded guilds...");
    {
        uint32 oldMSTime = getMSTime();

        for (GuildContainer::iterator itr = GuildStore.begin(); itr != GuildStore.end();)
        {
            Guild* guild = itr->second;
            ++itr;
            if (guild && !guild->Validate())
                delete guild;
        }

        LOG_INFO("server.loading", ">> Validated data of loaded guilds in {} ms", GetMSTimeDiffToNow(oldMSTime));
        LOG_INFO("server.loading", " ");
    }
}

void GuildMgr::ResetTimes()
{
    for (GuildContainer::const_iterator itr = GuildStore.begin(); itr != GuildStore.end(); ++itr)
        if (Guild* guild = itr->second)
            guild->ResetTimes();

    CharacterDatabase.DirectExecute("TRUNCATE guild_member_withdraw");
}
