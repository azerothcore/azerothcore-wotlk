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

#include "Chat.h"
#include "DatabaseEnv.h"
#include "ScriptMgr.h"

using namespace Acore::ChatCommands;

class db_commandscript : public CommandScript
{
public:
    db_commandscript() : CommandScript("db_commandscript") { }

    [[nodiscard]] ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable dbCommandTable =
        {
            { "info",                   HandleDBInfoCommand,                SEC_ADMINISTRATOR, Console::Yes },
            { "add dynamic connects",   HandleDBAddDynamicConnectsCommand,  SEC_ADMINISTRATOR, Console::Yes },
        };

        static ChatCommandTable commandTable =
        {
            { "db",  dbCommandTable },
        };

        return commandTable;
    }

    static bool HandleDBInfoCommand(ChatHandler* handler)
    {
        LoginDatabase.GetPoolInfo([handler](std::string_view info)
        {
            handler->PSendSysMessage(Acore::StringFormatFmt("# {}", info).c_str());
        });

        handler->PSendSysMessage("# --");

        CharacterDatabase.GetPoolInfo([handler](std::string_view info)
        {
            handler->PSendSysMessage(Acore::StringFormatFmt("# {}", info).c_str());
        });

        handler->PSendSysMessage("# --");

        WorldDatabase.GetPoolInfo([handler](std::string_view info)
        {
            handler->PSendSysMessage(Acore::StringFormatFmt("# {}", info).c_str());
        });

        handler->PSendSysMessage("# --");
        return true;
    }

    static bool HandleDBAddDynamicConnectsCommand(ChatHandler* handler, uint8 dbType, bool isAsync)
    {
        switch (dbType)
        {
            case 1:
                isAsync ? LoginDatabase.OpenDynamicAsyncConnect() : LoginDatabase.OpenDynamicSyncConnect();
                handler->PSendSysMessage(Acore::StringFormatFmt("Added new {} dynamic connection for {} DB", isAsync ? "async" : "sync", LoginDatabase.GetPoolName()).c_str());
                break;
            case 2:
                isAsync ? CharacterDatabase.OpenDynamicAsyncConnect() : CharacterDatabase.OpenDynamicSyncConnect();
                handler->PSendSysMessage(Acore::StringFormatFmt("Added new {} dynamic connection for {} DB", isAsync ? "async" : "sync", CharacterDatabase.GetPoolName()).c_str());
                break;
            case 3:
                isAsync ? WorldDatabase.OpenDynamicAsyncConnect() : WorldDatabase.OpenDynamicSyncConnect();
                handler->PSendSysMessage(Acore::StringFormatFmt("Added new {} dynamic connection for {} DB", isAsync ? "async" : "sync", WorldDatabase.GetPoolName()).c_str());
                break;
            default:
                handler->PSendSysMessage(Acore::StringFormatFmt("Incorrect db type: {}", dbType).c_str());
                break;
        }

        return true;
    }
};

void AddSC_db_commandscript()
{
    new db_commandscript();
}
