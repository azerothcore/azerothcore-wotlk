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
Name: gobject_commandscript
%Complete: 100
Comment: All gobject related commands
Category: commandscripts
EndScriptData */

#include "Chat.h"
#include "GameEventMgr.h"
#include "GameObject.h"
#include "Language.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "PoolMgr.h"
#include "ScriptMgr.h"
#include "Transport.h"

using namespace Acore::ChatCommands;

using GameObjectSpawnId = Variant<Hyperlink<gameobject>, ObjectGuid::LowType>;
using GameObjectEntry = Variant<Hyperlink<gameobject_entry>, uint32>;

class gobject_commandscript : public CommandScript
{
public:
    gobject_commandscript() : CommandScript("gobject_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable gobjectCommandTable =
        {
            { "activate",  HandleGameObjectActivateCommand, SEC_GAMEMASTER,    Console::No },
            { "delete",    HandleGameObjectDeleteCommand,   SEC_ADMINISTRATOR, Console::No },
            { "info",      HandleGameObjectInfoCommand,     SEC_MODERATOR,     Console::No },
            { "move",      HandleGameObjectMoveCommand,     SEC_ADMINISTRATOR, Console::No },
            { "near",      HandleGameObjectNearCommand,     SEC_MODERATOR,     Console::No },
            { "target",    HandleGameObjectTargetCommand,   SEC_MODERATOR,     Console::No },
            { "turn",      HandleGameObjectTurnCommand,     SEC_ADMINISTRATOR, Console::No },
            { "add temp",  HandleGameObjectAddTempCommand,  SEC_GAMEMASTER,    Console::No },
            { "add",       HandleGameObjectAddCommand,      SEC_ADMINISTRATOR, Console::No },
            { "set phase", HandleGameObjectSetPhaseCommand, SEC_ADMINISTRATOR, Console::No },
            { "set state", HandleGameObjectSetStateCommand, SEC_ADMINISTRATOR, Console::No }
        };
        static ChatCommandTable commandTable =
        {
            { "gobject", gobjectCommandTable }
        };
        return commandTable;
    }

    static bool HandleGameObjectActivateCommand(ChatHandler* handler, GameObjectSpawnId guidLow)
    {
        GameObject* object = handler->GetObjectFromPlayerMapByDbGuid(guidLow);
        if (!object)
        {
            handler->PSendSysMessage(LANG_COMMAND_OBJNOTFOUND, uint32(guidLow));
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32_t const autoCloseTime = object->GetGOInfo()->GetAutoCloseTime() ? 10000u : 0u;

        // Activate
        object->SetLootState(GO_READY);
        object->UseDoorOrButton(autoCloseTime, false, handler->GetSession()->GetPlayer());

        handler->PSendSysMessage("Object activated!");

        return true;
    }

    //spawn go
    static bool HandleGameObjectAddCommand(ChatHandler* handler, GameObjectEntry objectId, Optional<int32> spawnTimeSecs)
    {
        if (!objectId)
            return false;

        GameObjectTemplate const* objectInfo = sObjectMgr->GetGameObjectTemplate(objectId);
        if (!objectInfo)
        {
            handler->PSendSysMessage(LANG_GAMEOBJECT_NOT_EXIST, uint32(objectId));
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (objectInfo->displayId && !sGameObjectDisplayInfoStore.LookupEntry(objectInfo->displayId))
        {
            // report to DB errors log as in loading case
            LOG_ERROR("sql.sql", "Gameobject (Entry %u GoType: %u) have invalid displayId (%u), not spawned.", *objectId, objectInfo->type, objectInfo->displayId);
            handler->PSendSysMessage(LANG_GAMEOBJECT_HAVE_INVALID_DATA, uint32(objectId));
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();
        float x = float(player->GetPositionX());
        float y = float(player->GetPositionY());
        float z = float(player->GetPositionZ());
        float o = float(player->GetOrientation());
        Map* map = player->GetMap();

        GameObject* object = sObjectMgr->IsGameObjectStaticTransport(objectInfo->entry) ? new StaticTransport() : new GameObject();
        ObjectGuid::LowType guidLow = map->GenerateLowGuid<HighGuid::GameObject>();

        if (!object->Create(guidLow, objectInfo->entry, map, player->GetPhaseMaskForSpawn(), x, y, z, o, G3D::Quat(), 0, GO_STATE_READY))
        {
            delete object;
            return false;
        }

        if (spawnTimeSecs)
            object->SetRespawnTime(*spawnTimeSecs);

        // fill the gameobject data and save to the db
        object->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), player->GetPhaseMaskForSpawn());
        guidLow = object->GetSpawnId();

        // delete the old object and do a clean load from DB with a fresh new GameObject instance.
        // this is required to avoid weird behavior and memory leaks
        delete object;

        object = sObjectMgr->IsGameObjectStaticTransport(objectInfo->entry) ? new StaticTransport() : new GameObject();
        // this will generate a new guid if the object is in an instance
        if (!object->LoadGameObjectFromDB(guidLow, map, true))
        {
            delete object;
            return false;
        }

        /// @todo is it really necessary to add both the real and DB table guid here ?
        sObjectMgr->AddGameobjectToGrid(guidLow, sObjectMgr->GetGOData(guidLow));

        handler->PSendSysMessage(LANG_GAMEOBJECT_ADD, uint32(objectId), objectInfo->name.c_str(), guidLow, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ());
        return true;
    }

    // add go, temp only
    static bool HandleGameObjectAddTempCommand(ChatHandler* handler, GameObjectEntry objectId, Optional<uint64> spawntime)
    {
        Player* player = handler->GetSession()->GetPlayer();
        uint64 spawntm(spawntime.value_or(300));

        if (!sObjectMgr->GetGameObjectTemplate(objectId))
        {
            handler->PSendSysMessage(LANG_GAMEOBJECT_NOT_EXIST, uint32(objectId));
            handler->SetSentErrorMessage(true);
            return false;
        }

        float x = player->GetPositionX();
        float y = player->GetPositionY();
        float z = player->GetPositionZ();
        float ang = player->GetOrientation();

        float rot2 = sin(ang / 2);
        float rot3 = cos(ang / 2);

        player->SummonGameObject(objectId, x, y, z, ang, 0, 0, rot2, rot3, spawntm);

        return true;
    }

    static bool HandleGameObjectTargetCommand(ChatHandler* handler, Optional<Variant<GameObjectEntry, std::string_view>> objectId)
    {
        Player* player = handler->GetSession()->GetPlayer();
        QueryResult result;
        GameEventMgr::ActiveEvents const& activeEventsList = sGameEventMgr->GetActiveEventList();

        if (objectId)
        {
            if (objectId->holds_alternative<GameObjectEntry>())
            {
                result = WorldDatabase.PQuery("SELECT guid, id, position_x, position_y, position_z, orientation, map, phaseMask, (POW(position_x - '%f', 2) + POW(position_y - '%f', 2) + POW(position_z - '%f', 2)) AS order_ FROM gameobject WHERE map = '%i' AND id = '%u' ORDER BY order_ ASC LIMIT 1",
                                              player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetMapId(), static_cast<uint32>(objectId->get<GameObjectEntry>()));
            }
            else
            {
                std::string name = std::string(objectId->get<std::string_view>());
                WorldDatabase.EscapeString(name);
                result = WorldDatabase.PQuery(
                        "SELECT guid, id, position_x, position_y, position_z, orientation, map, phaseMask, (POW(position_x - %f, 2) + POW(position_y - %f, 2) + POW(position_z - %f, 2)) AS order_ "
                        "FROM gameobject LEFT JOIN gameobject_template ON gameobject_template.entry = gameobject.id WHERE map = %i AND name LIKE '%%%s%%' ORDER BY order_ ASC LIMIT 1",
                        player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetMapId(), name.c_str());
            }
        }
        else
        {
            std::ostringstream eventFilter;
            eventFilter << " AND (eventEntry IS NULL ";
            bool initString = true;

            for (GameEventMgr::ActiveEvents::const_iterator itr = activeEventsList.begin(); itr != activeEventsList.end(); ++itr)
            {
                if (initString)
                {
                    eventFilter  <<  "OR eventEntry IN (" << *itr;
                    initString = false;
                }
                else
                    eventFilter << ',' << *itr;
            }

            if (!initString)
                eventFilter << "))";
            else
                eventFilter << ')';

            result = WorldDatabase.PQuery("SELECT gameobject.guid, id, position_x, position_y, position_z, orientation, map, phaseMask, "
                                          "(POW(position_x - %f, 2) + POW(position_y - %f, 2) + POW(position_z - %f, 2)) AS order_ FROM gameobject "
                                          "LEFT OUTER JOIN game_event_gameobject on gameobject.guid = game_event_gameobject.guid WHERE map = '%i' %s ORDER BY order_ ASC LIMIT 10",
                                          handler->GetSession()->GetPlayer()->GetPositionX(), handler->GetSession()->GetPlayer()->GetPositionY(), handler->GetSession()->GetPlayer()->GetPositionZ(),
                                          handler->GetSession()->GetPlayer()->GetMapId(), eventFilter.str().c_str());
        }

        if (!result)
        {
            handler->SendSysMessage(LANG_COMMAND_TARGETOBJNOTFOUND);
            return true;
        }

        bool found = false;
        float x, y, z, o;
        ObjectGuid::LowType guidLow;
        uint32 id, phase;
        uint16 mapId;
        uint32 poolId;

        do
        {
            Field* fields = result->Fetch();
            guidLow = fields[0].GetUInt32();
            id =      fields[1].GetUInt32();
            x =       fields[2].GetFloat();
            y =       fields[3].GetFloat();
            z =       fields[4].GetFloat();
            o =       fields[5].GetFloat();
            mapId =   fields[6].GetUInt16();
            phase =   fields[7].GetUInt32();
            poolId =  sPoolMgr->IsPartOfAPool<GameObject>(guidLow);
            if (!poolId || sPoolMgr->IsSpawnedObject<GameObject>(guidLow))
                found = true;
        } while (result->NextRow() && !found);

        if (!found)
        {
            handler->PSendSysMessage(LANG_GAMEOBJECT_NOT_EXIST, id);
            return false;
        }

        GameObjectTemplate const* objectInfo = sObjectMgr->GetGameObjectTemplate(id);

        if (!objectInfo)
        {
            handler->PSendSysMessage(LANG_GAMEOBJECT_NOT_EXIST, id);
            return false;
        }

        GameObject* target = handler->GetObjectFromPlayerMapByDbGuid(guidLow);

        handler->PSendSysMessage(LANG_GAMEOBJECT_DETAIL, guidLow, objectInfo->name.c_str(), guidLow, id, x, y, z, mapId, o, phase);

        if (target)
        {
            int32 curRespawnDelay = int32(target->GetRespawnTimeEx() - time(nullptr));
            if (curRespawnDelay < 0)
                curRespawnDelay = 0;

            std::string curRespawnDelayStr = secsToTimeString(curRespawnDelay, true);
            std::string defRespawnDelayStr = secsToTimeString(target->GetRespawnDelay(), true);

            handler->PSendSysMessage(LANG_COMMAND_RAWPAWNTIMES, defRespawnDelayStr.c_str(), curRespawnDelayStr.c_str());
        }
        return true;
    }

    //delete object by selection or guid
    static bool HandleGameObjectDeleteCommand(ChatHandler* handler, GameObjectSpawnId spawnId)
    {
        GameObject* object = handler->GetObjectFromPlayerMapByDbGuid(spawnId);
        if (!object)
        {
            handler->PSendSysMessage(LANG_COMMAND_OBJNOTFOUND, uint32(spawnId));
            handler->SetSentErrorMessage(true);
            return false;
        }

        ObjectGuid ownerGuid = object->GetOwnerGUID();
        if (ownerGuid)
        {
            Unit* owner = ObjectAccessor::GetUnit(*handler->GetSession()->GetPlayer(), ownerGuid);
            if (!owner || !ownerGuid.IsPlayer())
            {
                handler->PSendSysMessage(LANG_COMMAND_DELOBJREFERCREATURE, ownerGuid.GetCounter(), object->GetSpawnId());
                handler->SetSentErrorMessage(true);
                return false;
            }

            owner->RemoveGameObject(object, false);
        }

        object->SetRespawnTime(0);                                 // not save respawn time
        object->Delete();
        object->DeleteFromDB();

        handler->PSendSysMessage(LANG_COMMAND_DELOBJMESSAGE, object->GetSpawnId());

        return true;
    }

    //turn selected object
    static bool HandleGameObjectTurnCommand(ChatHandler* handler, GameObjectSpawnId guidLow, Optional<float> oz, Optional<float> oy, Optional<float> ox)
    {
        if (!guidLow)
            return false;

        GameObject* object = handler->GetObjectFromPlayerMapByDbGuid(guidLow);
        if (!object)
        {
            handler->PSendSysMessage(LANG_COMMAND_OBJNOTFOUND, uint32(guidLow));
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!oz)
            oz = handler->GetSession()->GetPlayer()->GetOrientation();

        Map* map = object->GetMap();
        object->Relocate(object->GetPositionX(), object->GetPositionY(), object->GetPositionZ(), *oz);
        object->SetLocalRotationAngles(*oz, oy.value_or(0.0f), ox.value_or(0.0f));
        object->SaveToDB();

        // Generate a completely new spawn with new guid
        // 3.3.5a client caches recently deleted objects and brings them back to life
        // when CreateObject block for this guid is received again
        // however it entirely skips parsing that block and only uses already known location
        object->Delete();

        object = new GameObject();
        if (!object->LoadGameObjectFromDB(guidLow, map, true))
        {
            delete object;
            return false;
        }

        handler->PSendSysMessage(LANG_COMMAND_TURNOBJMESSAGE, object->GetSpawnId(), object->GetGOInfo()->name.c_str(), object->GetSpawnId());
        return true;
    }

    //move selected object
    static bool HandleGameObjectMoveCommand(ChatHandler* handler, GameObjectSpawnId guidLow, Optional<std::array<float,3>> xyz)
    {
        if (!guidLow)
            return false;

        GameObject* object = handler->GetObjectFromPlayerMapByDbGuid(guidLow);
        if (!object)
        {
            handler->PSendSysMessage(LANG_COMMAND_OBJNOTFOUND, uint32(guidLow));
            handler->SetSentErrorMessage(true);
            return false;
        }

        Position pos;
        if (xyz)
        {
            pos = { (*xyz)[0], (*xyz)[1], (*xyz)[2] };
            if (!MapMgr::IsValidMapCoord(object->GetMapId(), pos))
            {
                handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, pos.GetPositionX(), pos.GetPositionY(), object->GetMapId());
                handler->SetSentErrorMessage(true);
                return false;
            }
        }
        else
        {
            pos = handler->GetSession()->GetPlayer()->GetPosition();
        }

        Map* map = object->GetMap();

        pos.SetOrientation(object->GetOrientation());
        object->Relocate(pos);

        // update which cell has this gameobject registered for loading
        sObjectMgr->RemoveGameobjectFromGrid(guidLow, object->GetGOData());
        object->SaveToDB();
        sObjectMgr->AddGameobjectToGrid(guidLow, object->GetGOData());

        // Generate a completely new spawn with new guid
        // 3.3.5a client caches recently deleted objects and brings them back to life
        // when CreateObject block for this guid is received again
        // however it entirely skips parsing that block and only uses already known location
        object->Delete();

        object = new GameObject();
        if (!object->LoadGameObjectFromDB(guidLow, map, true))
        {
            delete object;
            return false;
        }

        handler->PSendSysMessage(LANG_COMMAND_MOVEOBJMESSAGE, object->GetSpawnId(), object->GetGOInfo()->name.c_str(), object->GetSpawnId());
        return true;
    }

    //set phasemask for selected object
    static bool HandleGameObjectSetPhaseCommand(ChatHandler* handler, GameObjectSpawnId guidLow, uint32 phaseMask)
    {
        if (!guidLow)
            return false;

        GameObject* object = handler->GetObjectFromPlayerMapByDbGuid(guidLow);
        if (!object)
        {
            handler->PSendSysMessage(LANG_COMMAND_OBJNOTFOUND, uint32(guidLow));
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!phaseMask)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        object->SetPhaseMask(phaseMask, true);
        object->SaveToDB();
        return true;
    }

    static bool HandleGameObjectNearCommand(ChatHandler* handler, Optional<float> dist)
    {
        float distance = dist.value_or(10.0f);
        uint32 count = 0;

        Player* player = handler->GetSession()->GetPlayer();

        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_GAMEOBJECT_NEAREST);
        stmt->setFloat(0, player->GetPositionX());
        stmt->setFloat(1, player->GetPositionY());
        stmt->setFloat(2, player->GetPositionZ());
        stmt->setUInt32(3, player->GetMapId());
        stmt->setFloat(4, player->GetPositionX());
        stmt->setFloat(5, player->GetPositionY());
        stmt->setFloat(6, player->GetPositionZ());
        stmt->setFloat(7, distance * distance);
        stmt->setUInt32(8, player->GetPhaseMask());
        PreparedQueryResult result = WorldDatabase.Query(stmt);

        if (result)
        {
            do
            {
                Field* fields = result->Fetch();
                ObjectGuid::LowType guid = fields[0].GetUInt32();
                uint32 entry = fields[1].GetUInt32();
                float x = fields[2].GetFloat();
                float y = fields[3].GetFloat();
                float z = fields[4].GetFloat();
                uint16 mapId = fields[5].GetUInt16();

                GameObjectTemplate const* gameObjectInfo = sObjectMgr->GetGameObjectTemplate(entry);

                if (!gameObjectInfo)
                    continue;

                handler->PSendSysMessage(LANG_GO_LIST_CHAT, guid, entry, guid, gameObjectInfo->name.c_str(), x, y, z, mapId, "", "");

                ++count;
            } while (result->NextRow());
        }

        handler->PSendSysMessage(LANG_COMMAND_NEAROBJMESSAGE, distance, count);
        return true;
    }

    //show info of gameobject
    static bool HandleGameObjectInfoCommand(ChatHandler* handler, Optional<Variant<GameObjectEntry, std::string_view>> objectId)
    {
        uint32 entry = 0;
        uint32 type = 0;
        uint32 displayId = 0;
        std::string name;
        uint32 lootId = 0;
        GameObject* gameObject = nullptr;

        if (!objectId)
        {
            if (WorldObject* object = handler->getSelectedObject())
            {
                entry = object->GetEntry();
                if (object->GetTypeId() == TYPEID_GAMEOBJECT)
                    gameObject = object->ToGameObject();
            }
        }
        else
            entry = static_cast<uint32>(objectId->get<GameObjectEntry>());

        GameObjectTemplate const* gameObjectInfo = sObjectMgr->GetGameObjectTemplate(entry);
        if (!gameObjectInfo)
        {
            handler->PSendSysMessage(LANG_GAMEOBJECT_NOT_EXIST, entry);
            handler->SetSentErrorMessage(true);
            return false;
        }

        type = gameObjectInfo->type;
        displayId = gameObjectInfo->displayId;
        name = gameObjectInfo->name;
        if (type == GAMEOBJECT_TYPE_CHEST)
            lootId = gameObjectInfo->chest.lootId;
        else if (type == GAMEOBJECT_TYPE_FISHINGHOLE)
            lootId = gameObjectInfo->fishinghole.lootId;

        handler->PSendSysMessage(LANG_GOINFO_ENTRY, entry);
        handler->PSendSysMessage(LANG_GOINFO_TYPE, type);
        handler->PSendSysMessage(LANG_GOINFO_LOOTID, lootId);
        handler->PSendSysMessage(LANG_GOINFO_DISPLAYID, displayId);
        if (gameObject)
        {
            handler->PSendSysMessage("LootMode: %u", gameObject->GetLootMode());
            handler->PSendSysMessage("LootState: %u", gameObject->getLootState());
            handler->PSendSysMessage("GOState: %u", gameObject->GetGoState());
            handler->PSendSysMessage("PhaseMask: %u", gameObject->GetPhaseMask());
            handler->PSendSysMessage("IsLootEmpty: %u", gameObject->loot.empty());
            handler->PSendSysMessage("IsLootLooted: %u", gameObject->loot.isLooted());
        }

        handler->PSendSysMessage(LANG_GOINFO_NAME, name.c_str());

        return true;
    }

    static bool HandleGameObjectSetStateCommand(ChatHandler* handler, GameObjectSpawnId guidLow, int32 objectType, Optional<uint32> objectState)
    {
        if (!guidLow)
            return false;

        GameObject* object = handler->GetObjectFromPlayerMapByDbGuid(guidLow);
        if (!object)
        {
            handler->PSendSysMessage(LANG_COMMAND_OBJNOTFOUND, uint32(guidLow));
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (objectType < 0)
        {
            if (objectType == -1)
                object->SendObjectDeSpawnAnim(object->GetGUID());
            else if (objectType == -2)
                return false;
            return true;
        }

        if (!objectState)
            return false;

        if (objectType < 4)
            object->SetByteValue(GAMEOBJECT_BYTES_1, objectType, *objectState);
        else if (objectType == 4)
        {
            WorldPacket data(SMSG_GAMEOBJECT_CUSTOM_ANIM, 8+4);
            data << object->GetGUID();
            data << static_cast<uint32>(*objectState);
            object->SendMessageToSet(&data, true);
        }
        handler->PSendSysMessage("Set gobject type %d state %u", objectType, *objectState);
        return true;
    }
};

void AddSC_gobject_commandscript()
{
    new gobject_commandscript();
}
