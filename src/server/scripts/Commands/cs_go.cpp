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
Name: go_commandscript
%Complete: 100
Comment: All go related commands
Category: commandscripts
EndScriptData */

#include "Chat.h"
#include "CommandScript.h"
#include "GameGraveyard.h"
#include "Language.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "TicketMgr.h"

#include "boost/algorithm/string.hpp"
#include <regex>

using namespace Acore::ChatCommands;

class go_commandscript : public CommandScript
{
public:
    go_commandscript() : CommandScript("go_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable goCommandTable =
        {
            { "creature",      HandleGoCreatureSpawnIdCommand,   SEC_MODERATOR,  Console::No },
            { "creature id",   HandleGoCreatureCIdCommand,       SEC_MODERATOR,  Console::No },
            { "creature name", HandleGoCreatureNameCommand,      SEC_MODERATOR,  Console::No },
            { "gameobject",    HandleGoGameObjectSpawnIdCommand, SEC_MODERATOR,  Console::No },
            { "gameobject id", HandleGoGameObjectGOIdCommand,    SEC_MODERATOR,  Console::No },
            { "graveyard",     HandleGoGraveyardCommand,         SEC_MODERATOR,  Console::No },
            { "grid",          HandleGoGridCommand,              SEC_MODERATOR,  Console::No },
            { "taxinode",      HandleGoTaxinodeCommand,          SEC_MODERATOR,  Console::No },
            { "trigger",       HandleGoTriggerCommand,           SEC_MODERATOR,  Console::No },
            { "zonexy",        HandleGoZoneXYCommand,            SEC_MODERATOR,  Console::No },
            { "xyz",           HandleGoXYZCommand,               SEC_MODERATOR,  Console::No },
            { "ticket",        HandleGoTicketCommand,            SEC_GAMEMASTER, Console::No },
            { "quest",         HandleGoQuestCommand,             SEC_MODERATOR,  Console::No },
        };

        static ChatCommandTable commandTable =
        {
            { "go", goCommandTable }
        };
        return commandTable;
    }

    static bool DoTeleport(ChatHandler* handler, Position pos, uint32 mapId = MAPID_INVALID)
    {
        Player* player = handler->GetSession()->GetPlayer();

        if (mapId == MAPID_INVALID)
            mapId = player->GetMapId();
        if (!MapMgr::IsValidMapCoord(mapId, pos) || sObjectMgr->IsTransportMap(mapId))
        {
            handler->SendErrorMessage(LANG_INVALID_TARGET_COORD, pos.GetPositionX(), pos.GetPositionY(), mapId);
            return false;
        }

        // stop flight if need
        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        // save only in non-flight case
        else
            player->SaveRecallPosition();

        player->TeleportTo({ mapId, pos });
        return true;
    }

    static bool HandleGoCreatureCIdCommand(ChatHandler* handler, Variant<Hyperlink<creature_entry>, uint32> cId)
    {
        CreatureData const* spawnpoint = GetCreatureData(handler, *cId);

        if (!spawnpoint)
        {
            handler->SendErrorMessage(LANG_COMMAND_GOCREATNOTFOUND);
            return false;
        }

        return DoTeleport(handler, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, spawnpoint->mapid);
    }

    static bool HandleGoCreatureSpawnIdCommand(ChatHandler* handler, Variant<Hyperlink<creature>, ObjectGuid::LowType> spawnId)
    {
        CreatureData const* spawnpoint = sObjectMgr->GetCreatureData(spawnId);
        if (!spawnpoint)
        {
            handler->SendErrorMessage(LANG_COMMAND_GOCREATNOTFOUND);
            return false;
        }

        return DoTeleport(handler, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, spawnpoint->mapid);
    }

    static bool HandleGoCreatureNameCommand(ChatHandler* handler, Tail name)
    {
        if (!name.data())
            return false;

        QueryResult result = WorldDatabase.Query("SELECT entry FROM creature_template WHERE name = \"{}\" LIMIT 1" , name.data());
        if (!result)
        {
            handler->SendErrorMessage(LANG_COMMAND_GOCREATNOTFOUND);
            return false;
        }

        uint32 entry = result->Fetch()[0].Get<uint32>();
        CreatureData const* spawnpoint = GetCreatureData(handler, entry);
        if (!spawnpoint)
        {
            handler->SendErrorMessage(LANG_COMMAND_GOCREATNOTFOUND);
            return false;
        }

        return DoTeleport(handler, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, spawnpoint->mapid);
    }

    static bool HandleGoGameObjectSpawnIdCommand(ChatHandler* handler, uint32 spawnId)
    {
        GameObjectData const* spawnpoint = sObjectMgr->GetGameObjectData(spawnId);
        if (!spawnpoint)
        {
            handler->SendErrorMessage(LANG_COMMAND_GOOBJNOTFOUND);
            return false;
        }

        return DoTeleport(handler, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, spawnpoint->mapid);
    }

    static bool HandleGoGameObjectGOIdCommand(ChatHandler* handler, uint32 goId)
    {
        GameObjectData const* spawnpoint = GetGameObjectData(handler, goId);

        if (!spawnpoint)
        {
            handler->SendErrorMessage(LANG_COMMAND_GOOBJNOTFOUND);
            return false;
        }

        return DoTeleport(handler, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, spawnpoint->mapid);
    }

    static bool HandleGoGraveyardCommand(ChatHandler* handler, uint32 gyId)
    {
        GraveyardStruct const* gy = sGraveyard->GetGraveyard(gyId);
        if (!gy)
        {
            handler->SendErrorMessage(LANG_COMMAND_GRAVEYARDNOEXIST, gyId);
            return false;
        }

        if (!MapMgr::IsValidMapCoord(gy->Map, gy->x, gy->y, gy->z))
        {
            handler->SendErrorMessage(LANG_INVALID_TARGET_COORD, gy->x, gy->y, gy->Map);
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();
        // stop flight if need
        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        // save only in non-flight case
        else
            player->SaveRecallPosition();

        player->TeleportTo(gy->Map, gy->x, gy->y, gy->z, player->GetOrientation());
        return true;
    }

    //teleport to grid
    static bool HandleGoGridCommand(ChatHandler* handler, float gridX, float gridY, Optional<uint32> oMapId)
    {
        Player* player = handler->GetSession()->GetPlayer();
        uint32 mapId = oMapId.value_or(player->GetMapId());

        // center of grid
        float x = (gridX - CENTER_GRID_ID + 0.5f) * SIZE_OF_GRIDS;
        float y = (gridY - CENTER_GRID_ID + 0.5f) * SIZE_OF_GRIDS;

        if (!MapMgr::IsValidMapCoord(mapId, x, y))
        {
            handler->SendErrorMessage(LANG_INVALID_TARGET_COORD, x, y, mapId);
            return false;
        }

        // stop flight if need
        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        // save only in non-flight case
        else
            player->SaveRecallPosition();

        Map const* map = sMapMgr->CreateBaseMap(mapId);
        float z = std::max(map->GetHeight(x, y, MAX_HEIGHT), map->GetWaterLevel(x, y));

        player->TeleportTo(mapId, x, y, z, player->GetOrientation());
        return true;
    }

    static bool HandleGoTaxinodeCommand(ChatHandler* handler, Variant<Hyperlink<taxinode>, uint32> nodeId)
    {
        TaxiNodesEntry const* node = sTaxiNodesStore.LookupEntry(nodeId);
        if (!node)
        {
            handler->SendErrorMessage(LANG_COMMAND_GOTAXINODENOTFOUND, uint32(nodeId));
            return false;
        }
        return DoTeleport(handler, { node->x, node->y, node->z }, node->map_id);
    }

    static bool HandleGoTriggerCommand(ChatHandler* handler, Variant<Hyperlink<areatrigger>, uint32> areaTriggerId)
    {
        AreaTrigger const* at = sObjectMgr->GetAreaTrigger(areaTriggerId);
        if (!at)
        {
            handler->SendErrorMessage(LANG_COMMAND_GOAREATRNOTFOUND, uint32(areaTriggerId));
            return false;
        }
        return DoTeleport(handler, { at->x, at->y, at->z }, at->map);
    }

    //teleport at coordinates
    static bool HandleGoZoneXYCommand(ChatHandler* handler, float x, float y, Optional<Variant<Hyperlink<area>, uint32>> areaIdArg)
    {
        Player* player = handler->GetSession()->GetPlayer();

        uint32 areaId = areaIdArg ? *areaIdArg : player->GetZoneId();

        AreaTableEntry const* areaEntry = sAreaTableStore.LookupEntry(areaId);

        if (x < 0 || x > 100 || y < 0 || y > 100 || !areaEntry)
        {
            handler->SendErrorMessage(LANG_INVALID_ZONE_COORD, x, y, areaId);
            return false;
        }

        // update to parent zone if exist (client map show only zones without parents)
        AreaTableEntry const* zoneEntry = areaEntry->zone ? sAreaTableStore.LookupEntry(areaEntry->zone) : areaEntry;
                ASSERT(zoneEntry);

        Map const* map = sMapMgr->CreateBaseMap(zoneEntry->mapid);

        if (map->Instanceable())
        {
            handler->SendErrorMessage(LANG_INVALID_ZONE_MAP, areaEntry->ID, areaEntry->area_name[handler->GetSessionDbcLocale()], map->GetId(), map->GetMapName());
            return false;
        }

        Zone2MapCoordinates(x, y, zoneEntry->ID);

        if (!MapMgr::IsValidMapCoord(zoneEntry->mapid, x, y))
        {
            handler->SendErrorMessage(LANG_INVALID_TARGET_COORD, x, y, zoneEntry->mapid);
            return false;
        }

        // stop flight if need
        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        // save only in non-flight case
        else
            player->SaveRecallPosition();

        float z = std::max(map->GetHeight(x, y, MAX_HEIGHT), map->GetWaterLevel(x, y));

        player->TeleportTo(zoneEntry->mapid, x, y, z, player->GetOrientation());
        return true;
    }

    /**
     * @brief Teleports the GM to the specified world coordinates, optionally specifying map ID and orientation.
     *
     * @param handler The ChatHandler that is handling the command.
     * @param args The coordinates to teleport to in format "x y z [mapId [orientation]]".
     * @return true The command was successful.
     * @return false The command was unsuccessful (show error or syntax)
     */
    static bool HandleGoXYZCommand(ChatHandler* handler, Tail args)
    {
        std::wstring wInputCoords;
        if (!Utf8toWStr(args, wInputCoords))
        {
            return false;
        }

        // extract float and integer values from the input
        std::vector<float> locationValues;
        std::wregex floatRegex(L"(-?\\d+(?:\\.\\d+)?)");
        std::wsregex_iterator floatRegexIterator(wInputCoords.begin(), wInputCoords.end(), floatRegex);
        std::wsregex_iterator end;
        while (floatRegexIterator != end)
        {
            std::wsmatch match = *floatRegexIterator;
            std::wstring matchStr = match.str();

            // try to convert the match to a float
            try
            {
                locationValues.push_back(std::stof(matchStr));
            }
            // if the match is not a float, do not add it to the vector
            catch (std::invalid_argument const&){}

            ++floatRegexIterator;
        }

        // X and Y are required
        if (locationValues.size() < 2)
        {
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();

        uint32 mapId = locationValues.size() >= 4 ? uint32(locationValues[3]) : player->GetMapId();

        float x = locationValues[0];
        float y = locationValues[1];

        if (!sMapStore.LookupEntry(mapId) || !MapMgr::IsValidMapCoord(mapId, x, y))
        {
            handler->SendErrorMessage(LANG_INVALID_TARGET_COORD, x, y, mapId);
            return false;
        }

        Map const* map = sMapMgr->CreateBaseMap(mapId);

        float z = locationValues.size() >= 3 ? locationValues[2] : std::max(map->GetHeight(x, y, MAX_HEIGHT), map->GetWaterLevel(x, y));
        // map ID (locationValues[3]) already handled above
        float o = locationValues.size() >= 5 ? locationValues[4] : player->GetOrientation();

        if (!MapMgr::IsValidMapCoord(mapId, x, y, z, o))
        {
            handler->SendErrorMessage(LANG_INVALID_TARGET_COORD, x, y, mapId);
            return false;
        }

        return DoTeleport(handler, { x, y, z, o }, mapId);
    }

    static bool HandleGoTicketCommand(ChatHandler* handler, uint32 ticketId)
    {
        GmTicket* ticket = sTicketMgr->GetTicket(ticketId);
        if (!ticket)
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETNOTEXIST);
            return true;
        }

        Player* player = handler->GetSession()->GetPlayer();

        // stop flight if need
        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        // save only in non-flight case
        else
            player->SaveRecallPosition();

        ticket->TeleportTo(player);
        return true;
    }

    static bool HandleGoQuestCommand(ChatHandler* handler, std::string_view type, Quest const* quest)
    {
        uint32 entry = quest->GetQuestId();

        if (type == "starter")
        {
            QuestRelations* qr = sObjectMgr->GetCreatureQuestRelationMap();

            for (auto itr = qr->begin(); itr != qr->end(); ++itr)
            {
                if (itr->second == entry)
                {
                    CreatureData const* spawnpoint = GetCreatureData(handler, itr->first);
                    if (!spawnpoint)
                    {
                        handler->SendErrorMessage(LANG_COMMAND_GOCREATNOTFOUND);
                        return false;
                    }

                    // We've found a creature, teleport to it.
                    return DoTeleport(handler, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, spawnpoint->mapid);
                }
            }

            qr = sObjectMgr->GetGOQuestRelationMap();

            for (auto itr = qr->begin(); itr != qr->end(); ++itr)
            {
                if (itr->second == entry)
                {
                    GameObjectData const* spawnpoint = GetGameObjectData(handler, itr->first);
                    if (!spawnpoint)
                    {
                        handler->SendErrorMessage(LANG_COMMAND_GOOBJNOTFOUND);
                        return false;
                    }

                    return DoTeleport(handler, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, spawnpoint->mapid);
                }
            }
        }
        else if (type == "ender")
        {
            QuestRelations* qr = sObjectMgr->GetCreatureQuestInvolvedRelationMap();

            for (auto itr = qr->begin(); itr != qr->end(); ++itr)
            {
                if (itr->second == entry)
                {
                    CreatureData const* spawnpoint = GetCreatureData(handler, itr->first);
                    if (!spawnpoint)
                    {
                        handler->SendErrorMessage(LANG_COMMAND_GOCREATNOTFOUND);
                        return false;
                    }

                    // We've found a creature, teleport to it.
                    return DoTeleport(handler, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, spawnpoint->mapid);
                }
            }

            qr = sObjectMgr->GetGOQuestInvolvedRelationMap();

            for (auto itr = qr->begin(); itr != qr->end(); ++itr)
            {
                if (itr->second == entry)
                {
                    GameObjectData const* spawnpoint = GetGameObjectData(handler, itr->first);
                    if (!spawnpoint)
                    {
                        handler->SendErrorMessage(LANG_COMMAND_GOOBJNOTFOUND);
                        return false;
                    }

                    return DoTeleport(handler, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, spawnpoint->mapid);
                }
            }
        }
        else
        {
            handler->SendErrorMessage(LANG_CMD_GOQUEST_INVALID_SYNTAX);
            return false;
        }

        return false;
    }

    static CreatureData const* GetCreatureData(ChatHandler* handler, uint32 entry)
    {
        CreatureData const* spawnpoint = nullptr;
        for (auto const& pair : sObjectMgr->GetAllCreatureData())
        {
            if (pair.second.id1 != entry)
            {
                continue;
            }

            if (!spawnpoint)
            {
                spawnpoint = &pair.second;
            }
            else
            {
                handler->SendSysMessage(LANG_COMMAND_GOCREATMULTIPLE);
                break;
            }
        }

        return spawnpoint;
    }

    static GameObjectData const* GetGameObjectData(ChatHandler* handler, uint32 entry)
    {
        GameObjectData const* spawnpoint = nullptr;
        for (auto const& pair : sObjectMgr->GetAllGOData())
        {
            if (pair.second.id != entry)
            {
                continue;
            }

            if (!spawnpoint)
            {
                spawnpoint = &pair.second;
            }
            else
            {
                handler->SendSysMessage(LANG_COMMAND_GOCREATMULTIPLE);
                break;
            }
        }

        return spawnpoint;
    }
};

void AddSC_go_commandscript()
{
    new go_commandscript();
}
