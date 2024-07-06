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

/* ScriptData
Name: lookup_commandscript
%Complete: 100
Comment: All lookup related commands
Category: commandscripts
EndScriptData */

#include "AccountMgr.h"
#include "CharacterCache.h"
#include "Chat.h"
#include "CommandScript.h"
#include "GameEventMgr.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "SharedDefines.h"
#include "SpellInfo.h"
#include "SpellMgr.h"

using namespace Acore::ChatCommands;

class lookup_commandscript : public CommandScript
{
public:
    lookup_commandscript() : CommandScript("lookup_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable lookupPlayerCommandTable =
        {
            { "ip",      HandleLookupPlayerIpCommand,      SEC_GAMEMASTER, Console::Yes  },
            { "account", HandleLookupPlayerAccountCommand, SEC_GAMEMASTER, Console::Yes  },
            { "email",   HandleLookupPlayerEmailCommand,   SEC_GAMEMASTER, Console::Yes  }
        };

        static ChatCommandTable lookupCommandTable =
        {
            { "area",     HandleLookupAreaCommand,         SEC_MODERATOR, Console::Yes  },
            { "creature", HandleLookupCreatureCommand,     SEC_MODERATOR, Console::Yes  },
            { "event",    HandleLookupEventCommand,        SEC_MODERATOR, Console::Yes  },
            { "faction",  HandleLookupFactionCommand,      SEC_MODERATOR, Console::Yes  },
            { "item",     HandleLookupItemCommand,         SEC_MODERATOR, Console::Yes  },
            { "item set", HandleLookupItemSetCommand,      SEC_MODERATOR, Console::Yes  },
            { "map",      HandleLookupMapCommand,          SEC_MODERATOR, Console::Yes  },
            { "object",   HandleLookupObjectCommand,       SEC_MODERATOR, Console::Yes  },
            { "gobject",  HandleLookupObjectCommand,       SEC_MODERATOR, Console::Yes  },
            { "quest",    HandleLookupQuestCommand,        SEC_MODERATOR, Console::Yes  },
            { "skill",    HandleLookupSkillCommand,        SEC_MODERATOR, Console::Yes  },
            { "taxinode", HandleLookupTaxiNodeCommand,     SEC_MODERATOR, Console::Yes  },
            { "teleport", HandleLookupTeleCommand,         SEC_MODERATOR, Console::Yes  },
            { "title",    HandleLookupTitleCommand,        SEC_MODERATOR, Console::Yes  },
            { "spell",    HandleLookupSpellCommand,        SEC_MODERATOR, Console::Yes  },
            { "spell id", HandleLookupSpellIdCommand,      SEC_MODERATOR, Console::Yes  },
            { "player",   lookupPlayerCommandTable },
        };

        static ChatCommandTable commandTable =
        {
            { "lookup", lookupCommandTable }
        };

        return commandTable;
    }

    static bool HandleLookupAreaCommand(ChatHandler* handler, Tail namePart)
    {
        if (namePart.empty())
        {
            return false;
        }

        std::wstring wNamePart;

        if (!Utf8toWStr(namePart, wNamePart))
        {
            return false;
        }

        bool found = false;
        uint32 count = 0;
        uint32 maxResults = sWorld->getIntConfig(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS);

        // converting string that we try to find to lower case
        wstrToLower(wNamePart);

        // Search in AreaTable.dbc
        for (auto areaEntry : sAreaTableStore)
        {
            int locale = handler->GetSessionDbcLocale();
            std::string name = areaEntry->area_name[locale];

            if (name.empty())
            {
                continue;
            }

            if (!Utf8FitTo(name, wNamePart))
            {
                locale = 0;
                for (; locale < TOTAL_LOCALES; ++locale)
                {
                    if (locale == handler->GetSessionDbcLocale())
                    {
                        continue;
                    }

                    name = areaEntry->area_name[locale];
                    if (name.empty())
                    {
                        continue;
                    }

                    if (Utf8FitTo(name, wNamePart))
                    {
                        break;
                    }
                }
            }

            if (locale < TOTAL_LOCALES)
            {
                if (maxResults && count++ == maxResults)
                {
                    handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                    return true;
                }

                // send area in "id - [name]" format
                std::ostringstream ss;
                if (handler->GetSession())
                {
                    ss << areaEntry->ID << " - |cffffffff|Harea:" << areaEntry->ID << "|h[" << name << ' ' << localeNames[locale] << "]|h|r";
                }
                else
                {
                    ss << areaEntry->ID << " - " << name << ' ' << localeNames[locale];
                }

                handler->SendSysMessage(ss.str().c_str());

                if (!found)
                {
                    found = true;
                }
            }
        }

        if (!found)
        {
            handler->SendSysMessage(LANG_COMMAND_NOAREAFOUND);
        }

        return true;
    }

    static bool HandleLookupCreatureCommand(ChatHandler* handler, Tail namePart)
    {
        if (namePart.empty())
        {
            return false;
        }

        std::wstring wNamePart;

        // converting string that we try to find to lower case
        if (!Utf8toWStr(namePart, wNamePart))
        {
            return false;
        }

        wstrToLower(wNamePart);

        bool found = false;
        uint32 count = 0;
        uint32 maxResults = sWorld->getIntConfig(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS);

        for (auto const& [entry, creatureTemplate] : *sObjectMgr->GetCreatureTemplates())
        {
            uint32 id = creatureTemplate.Entry;
            uint8 localeIndex = handler->GetSessionDbLocaleIndex();
            if (CreatureLocale const* creatureLocale = sObjectMgr->GetCreatureLocale(id))
            {
                if (creatureLocale->Name.size() > localeIndex && !creatureLocale->Name[localeIndex].empty())
                {
                    std::string name = creatureLocale->Name[localeIndex];

                    if (Utf8FitTo(name, wNamePart))
                    {
                        if (maxResults && count++ == maxResults)
                        {
                            handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                            return true;
                        }

                        if (handler->GetSession())
                        {
                            handler->PSendSysMessage(LANG_CREATURE_ENTRY_LIST_CHAT, id, id, name.c_str());
                        }
                        else
                        {
                            handler->PSendSysMessage(LANG_CREATURE_ENTRY_LIST_CONSOLE, id, name.c_str());
                        }

                        if (!found)
                        {
                            found = true;
                        }

                        continue;
                    }
                }
            }

            std::string name = creatureTemplate.Name;
            if (name.empty())
            {
                continue;
            }

            if (Utf8FitTo(name, wNamePart))
            {
                if (maxResults && count++ == maxResults)
                {
                    handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                    return true;
                }

                if (handler->GetSession())
                {
                    handler->PSendSysMessage(LANG_CREATURE_ENTRY_LIST_CHAT, id, id, name.c_str());
                }
                else
                {
                    handler->PSendSysMessage(LANG_CREATURE_ENTRY_LIST_CONSOLE, id, name.c_str());
                }

                if (!found)
                {
                    found = true;
                }
            }
        }

        if (!found)
        {
            handler->SendSysMessage(LANG_COMMAND_NOCREATUREFOUND);
        }

        return true;
    }

    static bool HandleLookupEventCommand(ChatHandler* handler, Tail namePart)
    {
        if (namePart.empty())
        {
            return false;
        }

        std::wstring wNamePart;

        // converting string that we try to find to lower case
        if (!Utf8toWStr(namePart, wNamePart))
        {
            return false;
        }

        wstrToLower(wNamePart);

        bool found = false;
        uint32 count = 0;
        uint32 maxResults = sWorld->getIntConfig(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS);

        GameEventMgr::GameEventDataMap const& events = sGameEventMgr->GetEventMap();
        GameEventMgr::ActiveEvents const& activeEvents = sGameEventMgr->GetActiveEventList();

        for (uint32 id = 0; id < events.size(); ++id)
        {
            GameEventData const& eventData = events[id];

            std::string descr = eventData.description;
            if (descr.empty())
            {
                continue;
            }

            if (Utf8FitTo(descr, wNamePart))
            {
                if (maxResults && count++ == maxResults)
                {
                    handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                    return true;
                }

                char const* active = activeEvents.find(id) != activeEvents.end() ? handler->GetAcoreString(LANG_ACTIVE) : "";

                if (handler->GetSession())
                {
                    handler->PSendSysMessage(LANG_EVENT_ENTRY_LIST_CHAT, id, id, eventData.description.c_str(), active);
                }
                else
                {
                    handler->PSendSysMessage(LANG_EVENT_ENTRY_LIST_CONSOLE, id, eventData.description.c_str(), active);
                }

                if (!found)
                {
                    found = true;
                }
            }
        }

        if (!found)
        {
            handler->SendSysMessage(LANG_NOEVENTFOUND);
        }

        return true;
    }

    static bool HandleLookupFactionCommand(ChatHandler* handler, Tail namePart)
    {
        if (namePart.empty())
        {
            return false;
        }

        // Can be nullptr at console call
        Player* target = handler->getSelectedPlayer();

        std::wstring wNamePart;

        if (!Utf8toWStr(namePart, wNamePart))
        {
            return false;
        }

        // converting string that we try to find to lower case
        wstrToLower(wNamePart);

        bool found = false;
        uint32 count = 0;
        uint32 maxResults = sWorld->getIntConfig(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS);

        for (auto factionEntry : sFactionStore)
        {
            FactionState const* factionState = target ? target->GetReputationMgr().GetState(factionEntry) : nullptr;

            int locale = handler->GetSessionDbcLocale();
            std::string name = factionEntry->name[locale];
            if (name.empty())
            {
                continue;
            }

            if (!Utf8FitTo(name, wNamePart))
            {
                locale = 0;

                for (; locale < TOTAL_LOCALES; ++locale)
                {
                    if (locale == handler->GetSessionDbcLocale())
                    {
                        continue;
                    }

                    name = factionEntry->name[locale];
                    if (name.empty())
                    {
                        continue;
                    }

                    if (Utf8FitTo(name, wNamePart))
                    {
                        break;
                    }
                }
            }

            if (locale < TOTAL_LOCALES)
            {
                if (maxResults && count++ == maxResults)
                {
                    handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                    return true;
                }

                // send faction in "id - [faction] rank reputation [visible] [at war] [own team] [unknown] [invisible] [inactive]" format
                // or              "id - [faction] [no reputation]" format
                std::ostringstream ss;
                if (handler->GetSession())
                {
                    ss << factionEntry->ID << " - |cffffffff|Hfaction:" << factionEntry->ID << "|h[" << name << ' ' << localeNames[locale] << "]|h|r";
                }
                else
                {
                    ss << factionEntry->ID << " - " << name << ' ' << localeNames[locale];
                }

                if (factionState) // and then target != nullptr also
                {
                    uint32 index = target->GetReputationMgr().GetReputationRankStrIndex(factionEntry);
                    std::string rankName = handler->GetAcoreString(index);

                    ss << ' ' << rankName << "|h|r (" << target->GetReputationMgr().GetReputation(factionEntry) << ')';

                    if (factionState->Flags & FACTION_FLAG_VISIBLE)
                    {
                        ss << handler->GetAcoreString(LANG_FACTION_VISIBLE);
                    }

                    if (factionState->Flags & FACTION_FLAG_AT_WAR)
                    {
                        ss << handler->GetAcoreString(LANG_FACTION_ATWAR);
                    }

                    if (factionState->Flags & FACTION_FLAG_PEACE_FORCED)
                    {
                        ss << handler->GetAcoreString(LANG_FACTION_PEACE_FORCED);
                    }

                    if (factionState->Flags & FACTION_FLAG_HIDDEN)
                    {
                        ss << handler->GetAcoreString(LANG_FACTION_HIDDEN);
                    }

                    if (factionState->Flags & FACTION_FLAG_INVISIBLE_FORCED)
                    {
                        ss << handler->GetAcoreString(LANG_FACTION_INVISIBLE_FORCED);
                    }

                    if (factionState->Flags & FACTION_FLAG_INACTIVE)
                    {
                        ss << handler->GetAcoreString(LANG_FACTION_INACTIVE);
                    }
                }
                else
                {
                    ss << handler->GetAcoreString(LANG_FACTION_NOREPUTATION);
                }

                handler->SendSysMessage(ss.str().c_str());

                if (!found)
                {
                    found = true;
                }
            }
        }

        if (!found)
        {
            handler->SendSysMessage(LANG_COMMAND_FACTION_NOTFOUND);
        }

        return true;
    }

    static bool HandleLookupItemCommand(ChatHandler* handler, Tail namePart)
    {
        if (namePart.empty())
        {
            return false;
        }

        std::wstring wNamePart;

        // converting string that we try to find to lower case
        if (!Utf8toWStr(namePart, wNamePart))
        {
            return false;
        }

        wstrToLower(wNamePart);

        bool found = false;
        uint32 count = 0;
        uint32 maxResults = sWorld->getIntConfig(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS);

        // Search in `item_template`
        for (auto const& [entry, itemTemplate] : *sObjectMgr->GetItemTemplateStore())
        {
            int localeIndex = handler->GetSessionDbLocaleIndex();
            if (localeIndex >= 0)
            {
                uint8 ulocaleIndex = uint8(localeIndex);
                if (ItemLocale const* il = sObjectMgr->GetItemLocale(itemTemplate.ItemId))
                {
                    if (il->Name.size() > ulocaleIndex && !il->Name[ulocaleIndex].empty())
                    {
                        std::string name = il->Name[ulocaleIndex];

                        if (Utf8FitTo(name, wNamePart))
                        {
                            if (maxResults && count++ == maxResults)
                            {
                                handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                                return true;
                            }

                            if (handler->GetSession())
                            {
                                handler->PSendSysMessage(LANG_ITEM_LIST_CHAT, itemTemplate.ItemId, ItemQualityColors[itemTemplate.Quality], itemTemplate.ItemId, name.c_str());
                            }
                            else
                            {
                                handler->PSendSysMessage(LANG_ITEM_LIST_CONSOLE, itemTemplate.ItemId, name.c_str());
                            }

                            if (!found)
                            {
                                found = true;
                            }

                            continue;
                        }
                    }
                }
            }

            std::string name = itemTemplate.Name1;
            if (name.empty())
            {
                continue;
            }

            if (Utf8FitTo(name, wNamePart))
            {
                if (maxResults && count++ == maxResults)
                {
                    handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                    return true;
                }

                if (handler->GetSession())
                {
                    handler->PSendSysMessage(LANG_ITEM_LIST_CHAT, itemTemplate.ItemId, ItemQualityColors[itemTemplate.Quality], itemTemplate.ItemId, name.c_str());
                }
                else
                {
                    handler->PSendSysMessage(LANG_ITEM_LIST_CONSOLE, itemTemplate.ItemId, name.c_str());
                }

                if (!found)
                {
                    found = true;
                }
            }
        }

        if (!found)
        {
            handler->SendSysMessage(LANG_COMMAND_NOITEMFOUND);
        }

        return true;
    }

    static bool HandleLookupItemSetCommand(ChatHandler* handler, Tail namePart)
    {
        if (namePart.empty())
        {
            return false;
        }

        std::wstring wNamePart;

        if (!Utf8toWStr(namePart, wNamePart))
        {
            return false;
        }

        // converting string that we try to find to lower case
        wstrToLower(wNamePart);

        bool found = false;
        uint32 count = 0;
        uint32 maxResults = sWorld->getIntConfig(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS);

        // Search in ItemSet.dbc
        for (uint32 id = 0; id < sItemSetStore.GetNumRows(); id++)
        {
            ItemSetEntry const* set = sItemSetStore.LookupEntry(id);
            if (set)
            {
                int locale = handler->GetSessionDbcLocale();
                std::string name = set->name[locale];
                if (name.empty())
                {
                    continue;
                }

                if (!Utf8FitTo(name, wNamePart))
                {
                    locale = 0;
                    for (; locale < TOTAL_LOCALES; ++locale)
                    {
                        if (locale == handler->GetSessionDbcLocale())
                        {
                            continue;
                        }

                        name = set->name[locale];
                        if (name.empty())
                        {
                            continue;
                        }

                        if (Utf8FitTo(name, wNamePart))
                        {
                            break;
                        }
                    }
                }

                if (locale < TOTAL_LOCALES)
                {
                    if (maxResults && count++ == maxResults)
                    {
                        handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                        return true;
                    }

                    // send item set in "id - [namedlink locale]" format
                    if (handler->GetSession())
                    {
                        handler->PSendSysMessage(LANG_ITEMSET_LIST_CHAT, id, id, name.c_str(), localeNames[locale]);
                    }
                    else
                    {
                        handler->PSendSysMessage(LANG_ITEMSET_LIST_CONSOLE, id, name.c_str(), localeNames[locale]);
                    }

                    if (!found)
                    {
                        found = true;
                    }
                }
            }
        }

        if (!found)
        {
            handler->SendSysMessage(LANG_COMMAND_NOITEMSETFOUND);
        }

        return true;
    }

    static bool HandleLookupObjectCommand(ChatHandler* handler, Tail namePart)
    {
        if (namePart.empty())
        {
            return false;
        }

        std::wstring wNamePart;

        // converting string that we try to find to lower case
        if (!Utf8toWStr(namePart, wNamePart))
        {
            return false;
        }

        wstrToLower(wNamePart);

        bool found = false;
        uint32 count = 0;
        uint32 maxResults = sWorld->getIntConfig(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS);

        for (auto const& [entry, gameObjectTemplate] : *sObjectMgr->GetGameObjectTemplates())
        {
            uint8 localeIndex = handler->GetSessionDbLocaleIndex();
            if (GameObjectLocale const* objectLocalte = sObjectMgr->GetGameObjectLocale(gameObjectTemplate.entry))
            {
                if (objectLocalte->Name.size() > localeIndex && !objectLocalte->Name[localeIndex].empty())
                {
                    std::string name = objectLocalte->Name[localeIndex];

                    if (Utf8FitTo(name, wNamePart))
                    {
                        if (maxResults && count++ == maxResults)
                        {
                            handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                            return true;
                        }

                        if (handler->GetSession())
                        {
                            handler->PSendSysMessage(LANG_GO_ENTRY_LIST_CHAT, gameObjectTemplate.entry, gameObjectTemplate.entry, name.c_str());
                        }
                        else
                        {
                            handler->PSendSysMessage(LANG_GO_ENTRY_LIST_CONSOLE, gameObjectTemplate.entry, name.c_str());
                        }

                        if (!found)
                        {
                            found = true;
                        }

                        continue;
                    }
                }
            }

            std::string name = gameObjectTemplate.name;
            if (name.empty())
            {
                continue;
            }

            if (Utf8FitTo(name, wNamePart))
            {
                if (maxResults && count++ == maxResults)
                {
                    handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                    return true;
                }

                if (handler->GetSession())
                {
                    handler->PSendSysMessage(LANG_GO_ENTRY_LIST_CHAT, gameObjectTemplate.entry, gameObjectTemplate.entry, name.c_str());
                }
                else
                {
                    handler->PSendSysMessage(LANG_GO_ENTRY_LIST_CONSOLE, gameObjectTemplate.entry, name.c_str());
                }

                if (!found)
                {
                    found = true;
                }
            }
        }

        if (!found)
        {
            handler->SendSysMessage(LANG_COMMAND_NOGAMEOBJECTFOUND);
        }

        return true;
    }

    static bool HandleLookupQuestCommand(ChatHandler* handler, Tail namePart)
    {
        if (namePart.empty())
        {
            return false;
        }

        // can be nullptr at console call
        Player* target = handler->getSelectedPlayer();

        std::wstring wNamePart;

        // converting string that we try to find to lower case
        if (!Utf8toWStr(namePart, wNamePart))
        {
            return false;
        }

        wstrToLower(wNamePart);

        bool found = false;
        uint32 count = 0;
        uint32 maxResults = sWorld->getIntConfig(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS);

        for (auto const& [entry, qInfo] : sObjectMgr->GetQuestTemplates())
        {
            int localeIndex = handler->GetSessionDbLocaleIndex();
            if (localeIndex >= 0)
            {
                uint8 ulocaleIndex = uint8(localeIndex);
                if (QuestLocale const* questLocale = sObjectMgr->GetQuestLocale(qInfo->GetQuestId()))
                {
                    if (questLocale->Title.size() > ulocaleIndex && !questLocale->Title[ulocaleIndex].empty())
                    {
                        std::string title = questLocale->Title[ulocaleIndex];

                        if (Utf8FitTo(title, wNamePart))
                        {
                            if (maxResults && count++ == maxResults)
                            {
                                handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                                return true;
                            }

                            char const* statusStr = "";

                            if (target)
                            {
                                QuestStatus status = target->GetQuestStatus(qInfo->GetQuestId());

                                switch (status)
                                {
                                    case QUEST_STATUS_COMPLETE:
                                        statusStr = handler->GetAcoreString(LANG_COMPLETE);
                                        break;
                                    case QUEST_STATUS_INCOMPLETE:
                                        statusStr = handler->GetAcoreString(LANG_ACTIVE);
                                        break;
                                    case QUEST_STATUS_REWARDED:
                                        statusStr = handler->GetAcoreString(LANG_REWARDED);
                                        break;
                                    default:
                                        break;
                                }
                            }

                            if (handler->GetSession())
                            {
                                handler->PSendSysMessage(LANG_QUEST_LIST_CHAT, qInfo->GetQuestId(), qInfo->GetQuestId(), qInfo->GetQuestLevel(), title.c_str(), statusStr);
                            }
                            else
                            {
                                handler->PSendSysMessage(LANG_QUEST_LIST_CONSOLE, qInfo->GetQuestId(), title.c_str(), statusStr);
                            }

                            if (!found)
                            {
                                found = true;
                            }

                            continue;
                        }
                    }
                }
            }

            std::string title = qInfo->GetTitle();
            if (title.empty())
            {
                continue;
            }

            if (Utf8FitTo(title, wNamePart))
            {
                if (maxResults && count++ == maxResults)
                {
                    handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                    return true;
                }

                char const* statusStr = "";

                if (target)
                {
                    QuestStatus status = target->GetQuestStatus(qInfo->GetQuestId());

                    switch (status)
                    {
                        case QUEST_STATUS_COMPLETE:
                            statusStr = handler->GetAcoreString(LANG_COMPLETE);
                            break;
                        case QUEST_STATUS_INCOMPLETE:
                            statusStr = handler->GetAcoreString(LANG_ACTIVE);
                            break;
                        case QUEST_STATUS_REWARDED:
                            statusStr = handler->GetAcoreString(LANG_REWARDED);
                            break;
                        default:
                            break;
                    }
                }

                if (handler->GetSession())
                {
                    handler->PSendSysMessage(LANG_QUEST_LIST_CHAT, qInfo->GetQuestId(), qInfo->GetQuestId(), qInfo->GetQuestLevel(), title.c_str(), statusStr);
                }
                else
                {
                    handler->PSendSysMessage(LANG_QUEST_LIST_CONSOLE, qInfo->GetQuestId(), title.c_str(), statusStr);
                }

                if (!found)
                {
                    found = true;
                }
            }
        }

        if (!found)
        {
            handler->SendSysMessage(LANG_COMMAND_NOQUESTFOUND);
        }

        return true;
    }

    static bool HandleLookupSkillCommand(ChatHandler* handler, Tail namePart)
    {
        if (namePart.empty())
        {
            return false;
        }

        // can be nullptr in console call
        Player* target = handler->getSelectedPlayer();

        std::wstring wNamePart;

        if (!Utf8toWStr(namePart, wNamePart))
        {
            return false;
        }

        // converting string that we try to find to lower case
        wstrToLower(wNamePart);

        bool found = false;
        uint32 count = 0;
        uint32 maxResults = sWorld->getIntConfig(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS);

        // Search in SkillLine.dbc
        for (auto skillInfo : sSkillLineStore)
        {
            int locale = handler->GetSessionDbcLocale();
            std::string name = skillInfo->name[locale];

            if (name.empty())
            {
                continue;
            }

            if (!Utf8FitTo(name, wNamePart))
            {
                locale = 0;
                for (; locale < TOTAL_LOCALES; ++locale)
                {
                    if (locale == handler->GetSessionDbcLocale())
                    {
                        continue;
                    }

                    name = skillInfo->name[locale];
                    if (name.empty())
                    {
                        continue;
                    }

                    if (Utf8FitTo(name, wNamePart))
                    {
                        break;
                    }
                }
            }

            if (locale < TOTAL_LOCALES)
            {
                if (maxResults && count++ == maxResults)
                {
                    handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                    return true;
                }

                std::string valStr;
                std::string knownStr;

                if (target && target->HasSkill(skillInfo->id))
                {
                    knownStr = handler->GetAcoreString(LANG_KNOWN);
                    uint32 curValue = target->GetPureSkillValue(skillInfo->id);
                    uint32 maxValue = target->GetPureMaxSkillValue(skillInfo->id);
                    uint32 permValue = target->GetSkillPermBonusValue(skillInfo->id);
                    uint32 tempValue = target->GetSkillTempBonusValue(skillInfo->id);

                    valStr = Acore::StringFormat(handler->GetAcoreString(LANG_SKILL_VALUES), curValue, maxValue, permValue, tempValue);
                }

                // send skill in "id - [namedlink locale]" format
                if (handler->GetSession())
                {
                    handler->PSendSysMessage(LANG_SKILL_LIST_CHAT, skillInfo->id, skillInfo->id, name.c_str(), localeNames[locale], knownStr.c_str(), valStr.c_str());
                }
                else
                {
                    handler->PSendSysMessage(LANG_SKILL_LIST_CONSOLE, skillInfo->id, name.c_str(), localeNames[locale], knownStr.c_str(), valStr.c_str());
                }

                if (!found)
                {
                    found = true;
                }
            }
        }

        if (!found)
        {
            handler->SendSysMessage(LANG_COMMAND_NOSKILLFOUND);
        }

        return true;
    }

    static bool HandleLookupSpellCommand(ChatHandler* handler, Tail namePart)
    {
        if (namePart.empty())
        {
            return false;
        }

        // can be nullptr at console call
        Player* target = handler->getSelectedPlayer();

        std::wstring wNamePart;

        if (!Utf8toWStr(namePart, wNamePart))
        {
            return false;
        }

        // converting string that we try to find to lower case
        wstrToLower(wNamePart);

        bool found = false;
        uint32 count = 0;
        uint32 maxResults = sWorld->getIntConfig(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS);

        // Search in Spell.dbc
        for (uint32 id = 0; id < sSpellMgr->GetSpellInfoStoreSize(); id++)
        {
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(id);
            if (spellInfo)
            {
                int locale = handler->GetSessionDbcLocale();
                std::string name = spellInfo->SpellName[locale];
                if (name.empty())
                {
                    continue;
                }

                if (!Utf8FitTo(name, wNamePart))
                {
                    locale = 0;
                    for (; locale < TOTAL_LOCALES; ++locale)
                    {
                        if (locale == handler->GetSessionDbcLocale())
                        {
                            continue;
                        }

                        name = spellInfo->SpellName[locale];
                        if (name.empty())
                        {
                            continue;
                        }

                        if (Utf8FitTo(name, wNamePart))
                        {
                            break;
                        }
                    }
                }

                if (locale < TOTAL_LOCALES)
                {
                    if (maxResults && count++ == maxResults)
                    {
                        handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                        return true;
                    }

                    bool known = target && target->HasSpell(id);
                    bool learn = (spellInfo->Effects[0].Effect == SPELL_EFFECT_LEARN_SPELL);

                    SpellInfo const* learnSpellInfo = sSpellMgr->GetSpellInfo(spellInfo->Effects[0].TriggerSpell);

                    uint32 talentCost = GetTalentSpellCost(id);

                    bool talent = (talentCost > 0);
                    bool passive = spellInfo->IsPassive();
                    bool active = target && target->HasAura(id);

                    // unit32 used to prevent interpreting uint8 as char at output
                    // find rank of learned spell for learning spell, or talent rank
                    uint32 rank = talentCost ? talentCost : learn && learnSpellInfo ? learnSpellInfo->GetRank() : spellInfo->GetRank();

                    // send spell in "id - [name, rank N] [talent] [passive] [learn] [known]" format
                    std::ostringstream ss;
                    if (handler->GetSession())
                    {
                        ss << id << " - |cffffffff|Hspell:" << id << "|h[" << name;
                    }
                    else
                    {
                        ss << id << " - " << name;
                    }

                    // include rank in link name
                    if (rank)
                    {
                        ss << handler->GetAcoreString(LANG_SPELL_RANK) << rank;
                    }

                    if (handler->GetSession())
                    {
                        ss << ' ' << localeNames[locale] << "]|h|r";
                    }
                    else
                    {
                        ss << ' ' << localeNames[locale];
                    }

                    if (talent)
                    {
                        ss << handler->GetAcoreString(LANG_TALENT);
                    }

                    if (passive)
                    {
                        ss << handler->GetAcoreString(LANG_PASSIVE);
                    }

                    if (learn)
                    {
                        ss << handler->GetAcoreString(LANG_LEARN);
                    }

                    if (known)
                    {
                        ss << handler->GetAcoreString(LANG_KNOWN);
                    }

                    if (active)
                    {
                        ss << handler->GetAcoreString(LANG_ACTIVE);
                    }

                    handler->SendSysMessage(ss.str().c_str());

                    if (!found)
                    {
                        found = true;
                    }
                }
            }
        }

        if (!found)
        {
            handler->SendSysMessage(LANG_COMMAND_NOSPELLFOUND);
        }

        return true;
    }

    static bool HandleLookupSpellIdCommand(ChatHandler* handler, SpellInfo const* spell)
    {
        // can be nullptr at console call
        Player* target = handler->getSelectedPlayer();

        bool found = false;
        uint32 count = 0;
        uint32 maxResults = 1;

        if (!SpellMgr::IsSpellValid(spell))
        {
            handler->SendErrorMessage(LANG_COMMAND_SPELL_BROKEN, spell->Id);
            return false;
        }

        int locale = handler->GetSessionDbcLocale();
        std::string name = spell->SpellName[locale];
        if (name.empty())
        {
            handler->SendSysMessage(LANG_COMMAND_NOSPELLFOUND);
            return true;
        }

        if (locale < TOTAL_LOCALES)
        {
            if (maxResults && count++ == maxResults)
            {
                handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                return true;
            }

            bool known = target && target->HasSpell(spell->Id);
            bool learn = (spell->Effects[0].Effect == SPELL_EFFECT_LEARN_SPELL);

            SpellInfo const* learnSpellInfo = sSpellMgr->GetSpellInfo(spell->Effects[0].TriggerSpell);

            uint32 talentCost = GetTalentSpellCost(spell->Id);

            bool talent = (talentCost > 0);
            bool passive = spell->IsPassive();
            bool active = target && target->HasAura(spell->Id);

            // unit32 used to prevent interpreting uint8 as char at output
            // find rank of learned spell for learning spell, or talent rank
            uint32 rank = talentCost ? talentCost : learn && learnSpellInfo ? learnSpellInfo->GetRank() : spell->GetRank();

            // send spell in "id - [name, rank N] [talent] [passive] [learn] [known]" format
            std::ostringstream ss;
            if (handler->GetSession())
            {
                ss << spell->Id << " - |cffffffff|Hspell:" << spell->Id << "|h[" << name;
            }
            else
            {
                ss << spell->Id << " - " << name;
            }

            // include rank in link name
            if (rank)
            {
                ss << handler->GetAcoreString(LANG_SPELL_RANK) << rank;
            }

            if (handler->GetSession())
            {
                ss << ' ' << localeNames[locale] << "]|h|r";
            }
            else
            {
                ss << ' ' << localeNames[locale];
            }

            if (talent)
            {
                ss << handler->GetAcoreString(LANG_TALENT);
            }

            if (passive)
            {
                ss << handler->GetAcoreString(LANG_PASSIVE);
            }

            if (learn)
            {
                ss << handler->GetAcoreString(LANG_LEARN);
            }

            if (known)
            {
                ss << handler->GetAcoreString(LANG_KNOWN);
            }

            if (active)
            {
                ss << handler->GetAcoreString(LANG_ACTIVE);
            }

            handler->SendSysMessage(ss.str().c_str());

            if (!found)
            {
                found = true;
            }
        }

        if (!found)
        {
            handler->SendSysMessage(LANG_COMMAND_NOSPELLFOUND);
        }

        return true;
    }

    static bool HandleLookupTaxiNodeCommand(ChatHandler* handler, Tail namePart)
    {
        if (namePart.empty())
        {
            return false;
        }

        std::wstring wNamePart;

        if (!Utf8toWStr(namePart, wNamePart))
        {
            return false;
        }

        // converting string that we try to find to lower case
        wstrToLower(wNamePart);

        bool found = false;
        uint32 count = 0;
        uint32 maxResults = sWorld->getIntConfig(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS);

        // Search in TaxiNodes.dbc
        for (auto nodeEntry : sTaxiNodesStore)
        {
            int locale = handler->GetSessionDbcLocale();
            std::string name = nodeEntry->name[locale];

            if (name.empty())
            {
                continue;
            }

            if (!Utf8FitTo(name, wNamePart))
            {
                locale = 0;

                for (; locale < TOTAL_LOCALES; ++locale)
                {
                    if (locale == handler->GetSessionDbcLocale())
                    {
                        continue;
                    }

                    name = nodeEntry->name[locale];
                    if (name.empty())
                    {
                        continue;
                    }

                    if (Utf8FitTo(name, wNamePart))
                    {
                        break;
                    }
                }
            }

            if (locale < TOTAL_LOCALES)
            {
                if (maxResults && count++ == maxResults)
                {
                    handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                    return true;
                }

                // send taxinode in "id - [name] (Map:m X:x Y:y Z:z)" format
                if (handler->GetSession())
                {
                    handler->PSendSysMessage(LANG_TAXINODE_ENTRY_LIST_CHAT, nodeEntry->ID, nodeEntry->ID, name.c_str(), localeNames[locale],
                                             nodeEntry->map_id, nodeEntry->x, nodeEntry->y, nodeEntry->z);
                }
                else
                {
                    handler->PSendSysMessage(LANG_TAXINODE_ENTRY_LIST_CONSOLE, nodeEntry->ID, name.c_str(), localeNames[locale],
                                             nodeEntry->map_id, nodeEntry->x, nodeEntry->y, nodeEntry->z);
                }

                if (!found)
                {
                    found = true;
                }
            }
        }
        if (!found)
        {
            handler->SendSysMessage(LANG_COMMAND_NOTAXINODEFOUND);
        }

        return true;
    }

    // Find teleport in game_tele order by name
    static bool HandleLookupTeleCommand(ChatHandler* handler, Tail namePart)
    {
        if (namePart.empty())
        {
            return false;
        }

        std::wstring wNamePart;

        if (!Utf8toWStr(namePart, wNamePart))
        {
            return false;
        }

        // converting string that we try to find to lower case
        wstrToLower(wNamePart);

        std::ostringstream reply;
        uint32 count = 0;
        uint32 maxResults = sWorld->getIntConfig(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS);
        bool limitReached = false;

        for (auto const& [id, tele] : sObjectMgr->GetGameTeleMap())
        {
            if (tele.wnameLow.find(wNamePart) == std::wstring::npos)
            {
                continue;
            }

            if (maxResults && count++ == maxResults)
            {
                limitReached = true;
                break;
            }

            if (handler->GetSession())
            {
                reply << "  |cffffffff|Htele:" << id << "|h[" << tele.name << "]|h|r\n";
            }
            else
            {
                reply << "  " << id << ' ' << tele.name << "\n";
            }
        }

        if (reply.str().empty())
        {
            handler->SendSysMessage(LANG_COMMAND_TELE_NOLOCATION);
        }
        else
        {
            handler->PSendSysMessage(LANG_COMMAND_TELE_LOCATION, reply.str().c_str());
        }

        if (limitReached)
        {
            handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
        }

        return true;
    }

    static bool HandleLookupTitleCommand(ChatHandler* handler, Tail namePart)
    {
        if (namePart.empty())
        {
            return false;
        }

        // can be nullptr in console call
        Player* target = handler->getSelectedPlayer();

        // title name have single string arg for player name
        char const* targetName = target ? target->GetName().c_str() : "NAME";

        std::wstring wNamePart;

        if (!Utf8toWStr(namePart, wNamePart))
        {
            return false;
        }

        // converting string that we try to find to lower case
        wstrToLower(wNamePart);

        uint32 counter = 0;                                     // Counter for figure out that we found smth.
        uint32 maxResults = sWorld->getIntConfig(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS);

        // Search in CharTitles.dbc
        for (auto titleInfo : sCharTitlesStore)
        {
            int locale = handler->GetSessionDbcLocale();
            std::string name = titleInfo->nameMale[locale];
            if (name.empty())
            {
                continue;
            }

            if (!Utf8FitTo(name, wNamePart))
            {
                locale = 0;
                for (; locale < TOTAL_LOCALES; ++locale)
                {
                    if (locale == handler->GetSessionDbcLocale())
                    {
                        continue;
                    }

                    name = titleInfo->nameMale[locale];
                    if (name.empty())
                    {
                        continue;
                    }

                    if (Utf8FitTo(name, wNamePart))
                    {
                        break;
                    }
                }
            }

            if (locale < TOTAL_LOCALES)
            {
                if (maxResults && counter == maxResults)
                {
                    handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                    return true;
                }

                char const* knownStr = target && target->HasTitle(titleInfo) ? handler->GetAcoreString(LANG_KNOWN) : "";
                char const* activeStr = target && target->GetUInt32Value(PLAYER_CHOSEN_TITLE) == titleInfo->bit_index ? handler->GetAcoreString(LANG_ACTIVE) : "";

                std::string titleNameStr = Acore::StringFormat(name, targetName);

                // send title in "id (idx:idx) - [namedlink locale]" format
                if (handler->GetSession())
                {
                    handler->PSendSysMessage(LANG_TITLE_LIST_CHAT, titleInfo->ID, titleInfo->bit_index, titleInfo->ID, titleNameStr, localeNames[locale], knownStr, activeStr);
                }
                else
                {
                    handler->PSendSysMessage(LANG_TITLE_LIST_CONSOLE, titleInfo->ID, titleInfo->bit_index, titleNameStr, localeNames[locale], knownStr, activeStr);
                }

                ++counter;
            }
        }

        if (!counter)  // if counter == 0 then we found nth
        {
            handler->SendSysMessage(LANG_COMMAND_NOTITLEFOUND);
        }

        return true;
    }

    static bool HandleLookupMapCommand(ChatHandler* handler, Tail namePart)
    {
        if (namePart.empty())
        {
            return false;
        }

        std::wstring wNamePart;

        if (!Utf8toWStr(namePart, wNamePart))
        {
            return false;
        }

        wstrToLower(wNamePart);

        uint32 counter = 0;
        uint32 maxResults = sWorld->getIntConfig(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS);
        uint8 locale = handler->GetSession() ? handler->GetSession()->GetSessionDbcLocale() : sWorld->GetDefaultDbcLocale();

        // search in Map.dbc
        for (auto mapInfo : sMapStore)
        {
            std::string name = mapInfo->name[locale];

            if (name.empty())
            {
                continue;
            }

            if (Utf8FitTo(name, wNamePart) && locale < TOTAL_LOCALES)
            {
                if (maxResults && counter == maxResults)
                {
                    handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                    return true;
                }

                std::ostringstream ss;
                ss << mapInfo->MapID << " - [" << name << ']';

                if (mapInfo->IsContinent())
                {
                    ss << handler->GetAcoreString(LANG_CONTINENT);
                }

                switch (mapInfo->map_type)
                {
                    case MAP_INSTANCE:
                        ss << handler->GetAcoreString(LANG_INSTANCE);
                        break;
                    case MAP_RAID:
                        ss << handler->GetAcoreString(LANG_RAID);
                        break;
                    case MAP_BATTLEGROUND:
                        ss << handler->GetAcoreString(LANG_BATTLEGROUND);
                        break;
                    case MAP_ARENA:
                        ss << handler->GetAcoreString(LANG_ARENA);
                        break;
                }

                handler->SendSysMessage(ss.str().c_str());

                ++counter;
            }
        }

        if (!counter)
        {
            handler->SendSysMessage(LANG_COMMAND_NOMAPFOUND);
        }

        return true;
    }

    static bool HandleLookupPlayerIpCommand(ChatHandler* handler, Optional<Tail> ip, Optional<int32> limit)
    {
        Player* target = handler->getSelectedPlayerOrSelf();
        if (!ip)
        {
            // nullptr only if used from console
            if (!target || target == handler->GetSession()->GetPlayer())
            {
                return false;
            }

            *ip = target->GetSession()->GetRemoteAddress();
        }
        else
        {
            ip = *ip;
        }

        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_BY_IP);
        stmt->SetData(0, *ip);
        PreparedQueryResult result = LoginDatabase.Query(stmt);

        return LookupPlayerSearchCommand(result, *limit ? *limit : -1, handler);
    }

    static bool HandleLookupPlayerAccountCommand(ChatHandler* handler, std::string account, Optional<int32> limit)
    {
        if (!Utf8ToUpperOnlyLatin(account))
        {
            return false;
        }

        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_LIST_BY_NAME);
        stmt->SetData(0, account);
        PreparedQueryResult result = LoginDatabase.Query(stmt);

        return LookupPlayerSearchCommand(result, *limit ? *limit : -1, handler);
    }

    static bool HandleLookupPlayerEmailCommand(ChatHandler* handler, std::string email, Optional<int32> limit)
    {
        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_LIST_BY_EMAIL);
        stmt->SetData(0, email);
        PreparedQueryResult result = LoginDatabase.Query(stmt);

        return LookupPlayerSearchCommand(result, *limit ? *limit : -1, handler);
    }

    static bool LookupPlayerSearchCommand(PreparedQueryResult result, int32 limit, ChatHandler* handler)
    {
        if (!result)
        {
            handler->SendErrorMessage(LANG_NO_PLAYERS_FOUND);
            return false;
        }

        int32 counter = 0;
        uint32 count = 0;
        uint32 maxResults = sWorld->getIntConfig(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS);

        do
        {
            if (maxResults && count++ == maxResults)
            {
                handler->PSendSysMessage(LANG_COMMAND_LOOKUP_MAX_RESULTS, maxResults);
                return true;
            }

            Field* fields           = result->Fetch();
            uint32 accountId        = fields[0].Get<uint32>();
            std::string accountName = fields[1].Get<std::string>();

            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_GUID_NAME_BY_ACC);
            stmt->SetData(0, accountId);
            PreparedQueryResult result2 = CharacterDatabase.Query(stmt);

            if (result2)
            {
                handler->PSendSysMessage(LANG_LOOKUP_PLAYER_ACCOUNT, accountName.c_str(), accountId);

                do
                {
                    Field* characterFields   = result2->Fetch();
                    ObjectGuid::LowType guid = characterFields[0].Get<uint32>();
                    std::string name         = characterFields[1].Get<std::string>();
                    uint8 plevel = 0, prace = 0, pclass = 0;
                    bool online = ObjectAccessor::FindPlayerByLowGUID(guid) != nullptr;

                    if (CharacterCacheEntry const* gpd = sCharacterCache->GetCharacterCacheByName(name))
                    {
                        plevel = gpd->Level;
                        prace = gpd->Race;
                        pclass = gpd->Class;
                    }

                    if (plevel > 0 && prace > 0 && prace <= RACE_DRAENEI && pclass > 0 && pclass <= CLASS_DRUID)
                    {
                        handler->PSendSysMessage("  %s (GUID %u) - %s - %s - %u%s", name.c_str(), guid, EnumUtils::ToTitle(Races(prace)), EnumUtils::ToTitle(Classes(pclass)), plevel, (online ? " - [ONLINE]" : ""));
                    }
                    else
                    {
                        handler->PSendSysMessage(LANG_LOOKUP_PLAYER_CHARACTER, name.c_str(), guid);
                    }

                    ++counter;
                } while (result2->NextRow() && (limit == -1 || counter < limit));
            }
        } while (result->NextRow());

        if (!counter) // empty accounts only
        {
            handler->SendErrorMessage(LANG_NO_PLAYERS_FOUND);
            return false;
        }

        return true;
    }
};

void AddSC_lookup_commandscript()
{
    new lookup_commandscript();
}
