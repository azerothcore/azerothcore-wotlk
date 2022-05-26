/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
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

/* ScriptData
Name: go_commandscript
%Complete: 100
Comment: All go related commands
Category: commandscripts
EndScriptData */

#include "Chat.h"
#include "GameGraveyard.h"
#include "Language.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "TicketMgr.h"

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
            handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, pos.GetPositionX(), pos.GetPositionY(), mapId);
            handler->SetSentErrorMessage(true);
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
            handler->SendSysMessage(LANG_COMMAND_GOCREATNOTFOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        return DoTeleport(handler, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, spawnpoint->mapid);
    }

    static bool HandleGoCreatureSpawnIdCommand(ChatHandler* handler, Variant<Hyperlink<creature>, ObjectGuid::LowType> spawnId)
    {
        CreatureData const* spawnpoint = sObjectMgr->GetCreatureData(spawnId);
        if (!spawnpoint)
        {
            handler->SendSysMessage(LANG_COMMAND_GOCREATNOTFOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        return DoTeleport(handler, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, spawnpoint->mapid);
    }

    static bool HandleGoGameObjectSpawnIdCommand(ChatHandler* handler, uint32 spawnId)
    {
        GameObjectData const* spawnpoint = sObjectMgr->GetGOData(spawnId);
        if (!spawnpoint)
        {
            handler->SendSysMessage(LANG_COMMAND_GOOBJNOTFOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        return DoTeleport(handler, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, spawnpoint->mapid);
    }

    static bool HandleGoGameObjectGOIdCommand(ChatHandler* handler, uint32 goId)
    {
        GameObjectData const* spawnpoint = GetGameObjectData(handler, goId);

        if (!spawnpoint)
        {
            handler->SendSysMessage(LANG_COMMAND_GOOBJNOTFOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        return DoTeleport(handler, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, spawnpoint->mapid);
    }

    static bool HandleGoGraveyardCommand(ChatHandler* handler, uint32 gyId)
    {
        GraveyardStruct const* gy = sGraveyard->GetGraveyard(gyId);
        if (!gy)
        {
            handler->PSendSysMessage(LANG_COMMAND_GRAVEYARDNOEXIST, gyId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!MapMgr::IsValidMapCoord(gy->Map, gy->x, gy->y, gy->z))
        {
            handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, gy->x, gy->y, gy->Map);
            handler->SetSentErrorMessage(true);
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
            handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, x, y, mapId);
            handler->SetSentErrorMessage(true);
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
            handler->PSendSysMessage(LANG_COMMAND_GOTAXINODENOTFOUND, uint32(nodeId));
            handler->SetSentErrorMessage(true);
            return false;
        }
        return DoTeleport(handler, { node->x, node->y, node->z }, node->map_id);
    }

    static bool HandleGoTriggerCommand(ChatHandler* handler, Variant<Hyperlink<areatrigger>, uint32> areaTriggerId)
    {
        AreaTrigger const* at = sObjectMgr->GetAreaTrigger(areaTriggerId);
        if (!at)
        {
            handler->PSendSysMessage(LANG_COMMAND_GOAREATRNOTFOUND, uint32(areaTriggerId));
            handler->SetSentErrorMessage(true);
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
            handler->PSendSysMessage(LANG_INVALID_ZONE_COORD, x, y, areaId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // update to parent zone if exist (client map show only zones without parents)
        AreaTableEntry const* zoneEntry = areaEntry->zone ? sAreaTableStore.LookupEntry(areaEntry->zone) : areaEntry;
                ASSERT(zoneEntry);

        Map const* map = sMapMgr->CreateBaseMap(zoneEntry->mapid);

        if (map->Instanceable())
        {
            handler->PSendSysMessage(LANG_INVALID_ZONE_MAP, areaEntry->ID, areaEntry->area_name[handler->GetSessionDbcLocale()], map->GetId(), map->GetMapName());
            handler->SetSentErrorMessage(true);
            return false;
        }

        Zone2MapCoordinates(x, y, zoneEntry->ID);

        if (!MapMgr::IsValidMapCoord(zoneEntry->mapid, x, y))
        {
            handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, x, y, zoneEntry->mapid);
            handler->SetSentErrorMessage(true);
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

    //teleport at coordinates, including Z and orientation
    static bool HandleGoXYZCommand(ChatHandler* handler, float x, float y, Optional<float> z, Optional<uint32> id, Optional<float> o)
    {
        Player* player = handler->GetSession()->GetPlayer();
        uint32 mapId = id.value_or(player->GetMapId());

        if (z)
        {
            if (!MapMgr::IsValidMapCoord(mapId, x, y, *z))
            {
                handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, x, y, mapId);
                handler->SetSentErrorMessage(true);
                return false;
            }
        }
        else
        {
            if (!MapMgr::IsValidMapCoord(mapId, x, y))
            {
                handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, x, y, mapId);
                handler->SetSentErrorMessage(true);
                return false;
            }
            Map const* map = sMapMgr->CreateBaseMap(mapId);
            z = std::max(map->GetHeight(x, y, MAX_HEIGHT), map->GetWaterLevel(x, y));
        }

        return DoTeleport(handler, { x, y, *z, o.value_or(0.0f) }, mapId);
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
                        handler->SendSysMessage(LANG_COMMAND_GOCREATNOTFOUND);
                        handler->SetSentErrorMessage(true);
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
                        handler->SendSysMessage(LANG_COMMAND_GOOBJNOTFOUND);
                        handler->SetSentErrorMessage(true);
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
                        handler->SendSysMessage(LANG_COMMAND_GOCREATNOTFOUND);
                        handler->SetSentErrorMessage(true);
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
                        handler->SendSysMessage(LANG_COMMAND_GOOBJNOTFOUND);
                        handler->SetSentErrorMessage(true);
                        return false;
                    }

                    return DoTeleport(handler, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, spawnpoint->mapid);
                }
            }
        }
        else
        {
            handler->SendSysMessage(LANG_CMD_GOQUEST_INVALID_SYNTAX);
            handler->SetSentErrorMessage(true);
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
