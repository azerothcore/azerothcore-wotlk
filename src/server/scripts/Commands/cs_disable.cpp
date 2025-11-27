/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Chat.h"
#include "CommandScript.h"
#include "DisableMgr.h"
#include "Language.h"
#include "ObjectMgr.h"
#include "OutdoorPvP.h"
#include "Player.h"
#include "SpellMgr.h"

using namespace Acore::ChatCommands;

class disable_commandscript : public CommandScript
{
public:
    disable_commandscript() : CommandScript("disable_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable removeDisableCommandTable =
        {
            { "spell",        HandleRemoveDisableSpellCommand,        SEC_ADMINISTRATOR, Console::Yes },
            { "quest",        HandleRemoveDisableQuestCommand,        SEC_ADMINISTRATOR, Console::Yes },
            { "map",          HandleRemoveDisableMapCommand,          SEC_ADMINISTRATOR, Console::Yes },
            { "battleground", HandleRemoveDisableBattlegroundCommand, SEC_ADMINISTRATOR, Console::Yes },
            { "outdoorpvp",   HandleRemoveDisableOutdoorPvPCommand,   SEC_ADMINISTRATOR, Console::Yes },
            { "vmap",         HandleRemoveDisableVmapCommand,         SEC_ADMINISTRATOR, Console::Yes }
        };
        static ChatCommandTable addDisableCommandTable =
        {
            { "spell",        HandleAddDisableSpellCommand,           SEC_ADMINISTRATOR, Console::Yes },
            { "quest",        HandleAddDisableQuestCommand,           SEC_ADMINISTRATOR, Console::Yes },
            { "map",          HandleAddDisableMapCommand,             SEC_ADMINISTRATOR, Console::Yes },
            { "battleground", HandleAddDisableBattlegroundCommand,    SEC_ADMINISTRATOR, Console::Yes },
            { "outdoorpvp",   HandleAddDisableOutdoorPvPCommand,      SEC_ADMINISTRATOR, Console::Yes },
            { "vmap",         HandleAddDisableVmapCommand,            SEC_ADMINISTRATOR, Console::Yes }
        };
        static ChatCommandTable disableCommandTable =
        {
            { "add",    addDisableCommandTable },
            { "remove", removeDisableCommandTable }
        };
        static ChatCommandTable commandTable =
        {
            { "disable", disableCommandTable }
        };
        return commandTable;
    }

    static bool HandleAddDisables(ChatHandler* handler, uint32 entry, uint8 flags, std::string disableComment, uint8 disableType)
    {
        std::string disableTypeStr = "";

        switch (disableType)
        {
            case DISABLE_TYPE_SPELL:
                {
                    if (!sSpellMgr->GetSpellInfo(entry))
                    {
                        handler->SendErrorMessage(LANG_COMMAND_NOSPELLFOUND);
                        return false;
                    }
                    disableTypeStr = "spell";
                    break;
                }
            case DISABLE_TYPE_QUEST:
                {
                    if (!sObjectMgr->GetQuestTemplate(entry))
                    {
                        handler->SendErrorMessage(LANG_COMMAND_QUEST_NOTFOUND, entry);
                        return false;
                    }
                    disableTypeStr = "quest";
                    break;
                }
            case DISABLE_TYPE_MAP:
                {
                    if (!sMapStore.LookupEntry(entry))
                    {
                        handler->SendErrorMessage(LANG_COMMAND_NOMAPFOUND);
                        return false;
                    }
                    disableTypeStr = "map";
                    break;
                }
            case DISABLE_TYPE_BATTLEGROUND:
                {
                    if (!sBattlemasterListStore.LookupEntry(entry))
                    {
                        handler->SendErrorMessage(LANG_COMMAND_NO_BATTLEGROUND_FOUND);
                        return false;
                    }
                    disableTypeStr = "battleground";
                    break;
                }
            case DISABLE_TYPE_OUTDOORPVP:
                {
                    if (entry > MAX_OUTDOORPVP_TYPES)
                    {
                        handler->SendErrorMessage(LANG_COMMAND_NO_OUTDOOR_PVP_FORUND);
                        return false;
                    }
                    disableTypeStr = "outdoorpvp";
                    break;
                }
            case DISABLE_TYPE_VMAP:
                {
                    if (!sMapStore.LookupEntry(entry))
                    {
                        handler->SendErrorMessage(LANG_COMMAND_NOMAPFOUND);
                        return false;
                    }
                    disableTypeStr = "vmap";
                    break;
                }
            default:
                break;
        }

        WorldDatabasePreparedStatement* stmt = nullptr;
        stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_DISABLES);
        stmt->SetData(0, entry);
        stmt->SetData(1, disableType);
        PreparedQueryResult result = WorldDatabase.Query(stmt);
        if (result)
        {
            handler->SendErrorMessage("This {} (Id: {}) is already disabled.", disableTypeStr, entry);
            return false;
        }

        stmt = WorldDatabase.GetPreparedStatement(WORLD_INS_DISABLES);
        stmt->SetData(0, entry);
        stmt->SetData(1, disableType);
        stmt->SetData(2, flags);
        stmt->SetData(3, disableComment);
        WorldDatabase.Execute(stmt);

        handler->PSendSysMessage("Add Disabled {} (Id: {}) for reason {}", disableTypeStr, entry, disableComment);
        return true;
    }

    static bool HandleAddDisableSpellCommand(ChatHandler* handler, uint32 entry, uint8 flags, std::string disableComment)
    {
        return HandleAddDisables(handler, entry, flags, disableComment, DISABLE_TYPE_SPELL);
    }

    static bool HandleAddDisableQuestCommand(ChatHandler* handler, uint32 entry, uint8 flags, std::string disableComment)
    {
        return HandleAddDisables(handler, entry, flags, disableComment, DISABLE_TYPE_QUEST);
    }

    static bool HandleAddDisableMapCommand(ChatHandler* handler, uint32 entry, uint8 flags, std::string disableComment)
    {
        return HandleAddDisables(handler, entry, flags, disableComment, DISABLE_TYPE_MAP);
    }

    static bool HandleAddDisableBattlegroundCommand(ChatHandler* handler, uint32 entry, uint8 flags, std::string disableComment)
    {
        return HandleAddDisables(handler, entry, flags, disableComment, DISABLE_TYPE_BATTLEGROUND);
    }

    static bool HandleAddDisableAchievementCriteriaCommand(ChatHandler* handler,  uint32 entry, uint8 flags, std::string disableComment)
    {
        return HandleAddDisables(handler, entry, flags, disableComment, DISABLE_TYPE_ACHIEVEMENT_CRITERIA);
    }

    static bool HandleAddDisableOutdoorPvPCommand(ChatHandler* handler,  uint32 entry, uint8 flags, std::string disableComment)
    {
        HandleAddDisables(handler, entry, flags, disableComment, DISABLE_TYPE_OUTDOORPVP);
        return true;
    }

    static bool HandleAddDisableVmapCommand(ChatHandler* handler,  uint32 entry, uint8 flags, std::string disableComment)
    {
        return HandleAddDisables(handler, entry, flags, disableComment, DISABLE_TYPE_VMAP);
    }

    static bool HandleRemoveDisables(ChatHandler* handler, uint32 entry, uint8 disableType)
    {
        std::string disableTypeStr = "";

        switch (disableType)
        {
            case DISABLE_TYPE_SPELL:
                disableTypeStr = "spell";
                break;
            case DISABLE_TYPE_QUEST:
                disableTypeStr = "quest";
                break;
            case DISABLE_TYPE_MAP:
                disableTypeStr = "map";
                break;
            case DISABLE_TYPE_BATTLEGROUND:
                disableTypeStr = "battleground";
                break;
            case DISABLE_TYPE_ACHIEVEMENT_CRITERIA:
                disableTypeStr = "achievement criteria";
                break;
            case DISABLE_TYPE_OUTDOORPVP:
                disableTypeStr = "outdoorpvp";
                break;
            case DISABLE_TYPE_VMAP:
                disableTypeStr = "vmap";
                break;
        }

        WorldDatabasePreparedStatement* stmt = nullptr;
        stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_DISABLES);
        stmt->SetData(0, entry);
        stmt->SetData(1, disableType);
        PreparedQueryResult result = WorldDatabase.Query(stmt);
        if (!result)
        {
            handler->SendErrorMessage("This {} (Id: {}) is not disabled.", disableTypeStr, entry);
            return false;
        }

        stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_DISABLES);
        stmt->SetData(0, entry);
        stmt->SetData(1, disableType);
        WorldDatabase.Execute(stmt);

        handler->PSendSysMessage("Remove Disabled {} (Id: {})", disableTypeStr, entry);
        return true;
    }

    static bool HandleRemoveDisableSpellCommand(ChatHandler* handler, uint32 entry)
    {
        return HandleRemoveDisables(handler, entry, DISABLE_TYPE_SPELL);
    }

    static bool HandleRemoveDisableQuestCommand(ChatHandler* handler, uint32 entry)
    {
        return HandleRemoveDisables(handler, entry, DISABLE_TYPE_QUEST);
    }

    static bool HandleRemoveDisableMapCommand(ChatHandler* handler, uint32 entry)
    {
        return HandleRemoveDisables(handler, entry, DISABLE_TYPE_MAP);
    }

    static bool HandleRemoveDisableBattlegroundCommand(ChatHandler* handler, uint32 entry)
    {
        return HandleRemoveDisables(handler, entry, DISABLE_TYPE_BATTLEGROUND);
    }

    static bool HandleRemoveDisableAchievementCriteriaCommand(ChatHandler* handler, uint32 entry)
    {
        return HandleRemoveDisables(handler, entry, DISABLE_TYPE_ACHIEVEMENT_CRITERIA);
    }

    static bool HandleRemoveDisableOutdoorPvPCommand(ChatHandler* handler, uint32 entry)
    {
        return HandleRemoveDisables(handler, entry, DISABLE_TYPE_OUTDOORPVP);
    }

    static bool HandleRemoveDisableVmapCommand(ChatHandler* handler, uint32 entry)
    {
        return HandleRemoveDisables(handler, entry, DISABLE_TYPE_VMAP);
    }
};

void AddSC_disable_commandscript()
{
    new disable_commandscript();
}
