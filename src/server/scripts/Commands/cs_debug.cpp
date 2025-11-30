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

#include "Bag.h"
#include "BattlegroundMgr.h"
#include "CellImpl.h"
#include "Channel.h"
#include "Chat.h"
#include "CommandScript.h"
#include "GridNotifiersImpl.h"
#include "LFGMgr.h"
#include "Language.h"
#include "Log.h"
#include "M2Stores.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "PoolMgr.h"
#include "ScriptMgr.h"
#include "Transport.h"
#include "Warden.h"
#include <fstream>
#include <set>

using namespace Acore::ChatCommands;

class debug_commandscript : public CommandScript
{
public:
    debug_commandscript() : CommandScript("debug_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable debugPlayCommandTable =
        {
            { "cinematic",      HandleDebugPlayCinematicCommand,       SEC_ADMINISTRATOR, Console::No },
            { "movie",          HandleDebugPlayMovieCommand,           SEC_ADMINISTRATOR, Console::No },
            { "sound",          HandleDebugPlaySoundCommand,           SEC_ADMINISTRATOR, Console::No },
            { "music",          HandleDebugPlayMusicCommand,           SEC_ADMINISTRATOR, Console::No },
            { "visual",         HandleDebugVisualCommand,              SEC_ADMINISTRATOR, Console::No }
        };
        static ChatCommandTable debugSendCommandTable =
        {
            { "buyerror",       HandleDebugSendBuyErrorCommand,        SEC_ADMINISTRATOR, Console::No },
            { "channelnotify",  HandleDebugSendChannelNotifyCommand,   SEC_ADMINISTRATOR, Console::No },
            { "chatmessage",    HandleDebugSendChatMsgCommand,         SEC_ADMINISTRATOR, Console::No },
            { "equiperror",     HandleDebugSendEquipErrorCommand,      SEC_ADMINISTRATOR, Console::No },
            { "largepacket",    HandleDebugSendLargePacketCommand,     SEC_ADMINISTRATOR, Console::No },
            { "opcode",         HandleDebugSendOpcodeCommand,          SEC_ADMINISTRATOR, Console::No },
            { "qpartymsg",      HandleDebugSendQuestPartyMsgCommand,   SEC_ADMINISTRATOR, Console::No },
            { "qinvalidmsg",    HandleDebugSendQuestInvalidMsgCommand, SEC_ADMINISTRATOR, Console::No },
            { "sellerror",      HandleDebugSendSellErrorCommand,       SEC_ADMINISTRATOR, Console::No },
            { "setphaseshift",  HandleDebugSendSetPhaseShiftCommand,   SEC_ADMINISTRATOR, Console::No },
            { "spellfail",      HandleDebugSendSpellFailCommand,       SEC_ADMINISTRATOR, Console::No }
        };
        static ChatCommandTable debugCommandTable =
        {
            { "setbit",         HandleDebugSet32BitCommand,            SEC_ADMINISTRATOR, Console::No },
            { "threat",         HandleDebugThreatListCommand,          SEC_ADMINISTRATOR, Console::No },
            { "hostile",        HandleDebugHostileRefListCommand,      SEC_ADMINISTRATOR, Console::No },
            { "anim",           HandleDebugAnimCommand,                SEC_ADMINISTRATOR, Console::No },
            { "arena",          HandleDebugArenaCommand,               SEC_ADMINISTRATOR, Console::No },
            { "bg",             HandleDebugBattlegroundCommand,        SEC_ADMINISTRATOR, Console::Yes},
            { "cooldown",       HandleDebugCooldownCommand,            SEC_ADMINISTRATOR, Console::No },
            { "getitemstate",   HandleDebugGetItemStateCommand,        SEC_ADMINISTRATOR, Console::No },
            { "lootrecipient",  HandleDebugGetLootRecipientCommand,    SEC_ADMINISTRATOR, Console::No },
            { "getvalue",       HandleDebugGetValueCommand,            SEC_ADMINISTRATOR, Console::No },
            { "getitemvalue",   HandleDebugGetItemValueCommand,        SEC_ADMINISTRATOR, Console::No },
            { "Mod32Value",     HandleDebugMod32ValueCommand,          SEC_ADMINISTRATOR, Console::No },
            { "play",           debugPlayCommandTable },
            { "send",           debugSendCommandTable },
            { "setaurastate",   HandleDebugSetAuraStateCommand,        SEC_ADMINISTRATOR, Console::No },
            { "setitemvalue",   HandleDebugSetItemValueCommand,        SEC_ADMINISTRATOR, Console::No },
            { "setvalue",       HandleDebugSetValueCommand,            SEC_ADMINISTRATOR, Console::No },
            { "spawnvehicle",   HandleDebugSpawnVehicleCommand,        SEC_ADMINISTRATOR, Console::No },
            { "setvid",         HandleDebugSetVehicleIdCommand,        SEC_ADMINISTRATOR, Console::No },
            { "entervehicle",   HandleDebugEnterVehicleCommand,        SEC_ADMINISTRATOR, Console::No },
            { "uws",            HandleDebugUpdateWorldStateCommand,    SEC_ADMINISTRATOR, Console::No },
            { "update",         HandleDebugUpdateCommand,              SEC_ADMINISTRATOR, Console::No },
            { "itemexpire",     HandleDebugItemExpireCommand,          SEC_ADMINISTRATOR, Console::No },
            { "areatriggers",   HandleDebugAreaTriggersCommand,        SEC_ADMINISTRATOR, Console::No },
            { "lfg",            HandleDebugDungeonFinderCommand,       SEC_ADMINISTRATOR, Console::Yes},
            { "los",            HandleDebugLoSCommand,                 SEC_ADMINISTRATOR, Console::No },
            { "moveflags",      HandleDebugMoveflagsCommand,           SEC_ADMINISTRATOR, Console::No },
            { "unitstate",      HandleDebugUnitStateCommand,           SEC_ADMINISTRATOR, Console::No },
            { "objectcount",    HandleDebugObjectCountCommand,         SEC_ADMINISTRATOR, Console::Yes},
            { "dummy",          HandleDebugDummyCommand,               SEC_ADMINISTRATOR, Console::No },
            { "mapdata",        HandleDebugMapDataCommand,             SEC_ADMINISTRATOR, Console::No },
            { "boundary",       HandleDebugBoundaryCommand,            SEC_ADMINISTRATOR, Console::No },
            { "visibilitydata", HandleDebugVisibilityDataCommand,      SEC_ADMINISTRATOR, Console::No },
            { "zonestats",      HandleDebugZoneStatsCommand,           SEC_MODERATOR,     Console::Yes}
        };
        static ChatCommandTable commandTable =
        {
            { "debug", debugCommandTable },
            { "wpgps", HandleWPGPSCommand, SEC_ADMINISTRATOR, Console::No }
        };
        return commandTable;
    }

    // cinematicId - ID from CinematicSequences.dbc
    static bool HandleDebugPlayCinematicCommand(ChatHandler* handler, uint32 cinematicId)
    {
        CinematicSequencesEntry const* cineSeq = sCinematicSequencesStore.LookupEntry(cinematicId);
        if (!cineSeq)
        {
            handler->SendErrorMessage(LANG_CINEMATIC_NOT_EXIST, cinematicId);
            return false;
        }

        // Dump camera locations
        if (std::vector<FlyByCamera> const* flyByCameras = GetFlyByCameras(cineSeq->cinematicCamera))
        {
            handler->PSendSysMessage("Waypoints for sequence {}, camera {}", cinematicId, cineSeq->cinematicCamera);
            uint32 count = 1;
            for (FlyByCamera const& cam : *flyByCameras)
            {
                handler->PSendSysMessage("{} - {}ms [{} ({} degrees)]", count, cam.timeStamp, cam.locations.ToString(), cam.locations.GetOrientation() * (180 / M_PI));
                ++count;
            }
            handler->PSendSysMessage("{} waypoints dumped", flyByCameras->size());
        }

        handler->GetPlayer()->SendCinematicStart(cinematicId);
        return true;
    }

    // movieId - ID from Movie.dbc
    static bool HandleDebugPlayMovieCommand(ChatHandler* handler, uint32 movieId)
    {
        if (!sMovieStore.LookupEntry(movieId))
        {
            handler->SendErrorMessage(LANG_MOVIE_NOT_EXIST, movieId);
            return false;
        }

        handler->GetPlayer()->SendMovieStart(movieId);
        return true;
    }

    // soundId - ID from SoundEntries.dbc
    static bool HandleDebugPlaySoundCommand(ChatHandler* handler, uint32 soundId)
    {
        if (!sSoundEntriesStore.LookupEntry(soundId))
        {
            handler->SendErrorMessage(LANG_SOUND_NOT_EXIST, soundId);
            return false;
        }

        Player* player = handler->GetPlayer();

        Unit* unit = handler->getSelectedUnit();
        if (!unit)
        {
            handler->SendErrorMessage(LANG_SELECT_CHAR_OR_CREATURE);
            return false;
        }

        if (player->GetTarget())
            unit->PlayDistanceSound(soundId, player);
        else
            unit->PlayDirectSound(soundId, player);

        handler->PSendSysMessage(LANG_YOU_HEAR_SOUND, soundId);
        return true;
    }

    // musicId - ID from SoundEntries.dbc
    static bool HandleDebugPlayMusicCommand(ChatHandler* handler, uint32 musicId)
    {
        if (!sSoundEntriesStore.LookupEntry(musicId))
        {
            handler->SendErrorMessage(LANG_SOUND_NOT_EXIST, musicId);
            return false;
        }

        Player* player = handler->GetPlayer();

        player->PlayDirectMusic(musicId, player);

        handler->PSendSysMessage(LANG_YOU_HEAR_SOUND, musicId);
        return true;
    }

    static bool HandleDebugVisualCommand(ChatHandler* handler, uint32 visualId)
    {
        if (!visualId)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        Player* player = handler->GetPlayer();
        Unit* target = handler->getSelectedUnit();

        if (!target)
        {
            player->SendPlaySpellVisual(visualId);
            return true;
        }

        player->SendPlaySpellImpact(target->GetGUID(), visualId);
        return true;
    }

    static bool HandleDebugSendSpellFailCommand(ChatHandler* handler, SpellCastResult result, Optional<uint32> failArg1, Optional<uint32> failArg2)
    {
        WorldPacket data(SMSG_CAST_FAILED, 5);
        data << uint8(0);
        data << uint32(133); // Spell "Fireball"
        data << uint8(result);

        if (failArg1 || failArg2)
        {
            data << uint32(failArg1.value_or(0));
        }

        if (failArg2)
        {
            data << uint32(*failArg2);
        }

        handler->GetSession()->SendPacket(&data);
        return true;
    }

    static bool HandleDebugSendEquipErrorCommand(ChatHandler* handler, InventoryResult error)
    {
        handler->GetPlayer()->SendEquipError(InventoryResult(error), nullptr, nullptr);
        return true;
    }

    static bool HandleDebugSendSellErrorCommand(ChatHandler* handler, SellResult error)
    {
        handler->GetPlayer()->SendSellError(SellResult(error), nullptr, ObjectGuid::Empty, 0);
        return true;
    }

    static bool HandleDebugSendBuyErrorCommand(ChatHandler* handler, BuyResult error)
    {
        handler->GetPlayer()->SendBuyError(BuyResult(error), nullptr, 0, 0);
        return true;
    }

    static bool HandleDebugSendOpcodeCommand(ChatHandler* handler)
    {
        Unit* unit = handler->getSelectedUnit();
        Player* player = nullptr;

        if (!unit || (!unit->IsPlayer()))
        {
            player = handler->GetSession()->GetPlayer();
        }
        else
        {
            player = unit->ToPlayer();
        }

        if (!unit)
        {
            unit = player;
        }

        std::ifstream ifs("opcode.txt");
        if (!ifs.is_open())
        {
            handler->SendErrorMessage(LANG_DEBUG_OPCODE_FILE_MISSING);
            return false;
        }

        // remove comments from file
        std::stringstream parsedStream;
        while (!ifs.eof())
        {
            char commentToken[2];
            ifs.get(commentToken[0]);
            if (commentToken[0] == '/' && !ifs.eof())
            {
                ifs.get(commentToken[1]);
                // /* comment
                if (commentToken[1] == '*')
                {
                    while (!ifs.eof())
                    {
                        ifs.get(commentToken[0]);
                        if (commentToken[0] == '*' && !ifs.eof())
                        {
                            ifs.get(commentToken[1]);
                            if (commentToken[1] == '/')
                                break;
                            else
                                ifs.putback(commentToken[1]);
                        }
                    }
                    continue;
                }
                // line comment
                else if (commentToken[1] == '/')
                {
                    std::string str;
                    getline(ifs, str);
                    continue;
                }
                // regular data
                else
                {
                    ifs.putback(commentToken[1]);
                }
            }

            parsedStream.put(commentToken[0]);
        }

        ifs.close();

        uint32 opcode;
        parsedStream >> opcode;

        WorldPacket data(opcode, 0);

        while (!parsedStream.eof())
        {
            std::string type;
            parsedStream >> type;

            if (type.empty())
                break;

            if (type == "uint8")
            {
                uint16 val1;
                parsedStream >> val1;
                data << uint8(val1);
            }
            else if (type == "uint16")
            {
                uint16 val2;
                parsedStream >> val2;
                data << val2;
            }
            else if (type == "uint32")
            {
                uint32 val3;
                parsedStream >> val3;
                data << val3;
            }
            else if (type == "uint64")
            {
                uint64 val4;
                parsedStream >> val4;
                data << val4;
            }
            else if (type == "float")
            {
                float val5;
                parsedStream >> val5;
                data << val5;
            }
            else if (type == "string")
            {
                std::string val6;
                parsedStream >> val6;
                data << val6;
            }
            else if (type == "appitsguid")
            {
                data << unit->GetPackGUID();
            }
            else if (type == "appmyguid")
            {
                data << player->GetPackGUID();
            }
            else if (type == "appgoguid")
            {
                GameObject* obj = handler->GetNearbyGameObject();
                if (!obj)
                {
                    handler->SendErrorMessage(LANG_COMMAND_OBJNOTFOUND, 0);
                    ifs.close();
                    return false;
                }
                data << obj->GetPackGUID();
            }
            else if (type == "goguid")
            {
                GameObject* obj = handler->GetNearbyGameObject();
                if (!obj)
                {
                    handler->SendErrorMessage(LANG_COMMAND_OBJNOTFOUND, 0);
                    ifs.close();
                    return false;
                }
                data << obj->GetGUID();
            }
            else if (type == "myguid")
            {
                data << player->GetGUID();
            }
            else if (type == "itsguid")
            {
                data << unit->GetGUID();
            }
            else if (type == "itspos")
            {
                data << unit->GetPositionX();
                data << unit->GetPositionY();
                data << unit->GetPositionZ();
            }
            else if (type == "mypos")
            {
                data << player->GetPositionX();
                data << player->GetPositionY();
                data << player->GetPositionZ();
            }
            else
            {
                LOG_ERROR("network.opcode", "Sending opcode that has unknown type '{}'", type);
                break;
            }
        }

        data.hexlike();
        player->SendDirectMessage(&data);
        handler->PSendSysMessage(LANG_COMMAND_OPCODESENT, data.GetOpcode(), unit->GetName());
        return true;
    }

    static bool HandleDebugUpdateWorldStateCommand(ChatHandler* handler, uint32 variable, uint32 value)
    {
        handler->GetPlayer()->SendUpdateWorldState(variable, value);
        return true;
    }

    static bool HandleDebugAreaTriggersCommand(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();
        if (!player->isDebugAreaTriggers)
        {
            handler->PSendSysMessage(LANG_DEBUG_AREATRIGGER_ON);
            player->isDebugAreaTriggers = true;
        }
        else
        {
            handler->PSendSysMessage(LANG_DEBUG_AREATRIGGER_OFF);
            player->isDebugAreaTriggers = false;
        }

        return true;
    }

    static bool HandleDebugSendChannelNotifyCommand(ChatHandler* handler, ChatNotify type)
    {
        WorldPacket data(SMSG_CHANNEL_NOTIFY, (1 + 10));
        data << type;
        data << "test";
        data << uint32(0);
        data << uint32(0);
        handler->GetSession()->SendPacket(&data);
        return true;
    }

    static bool HandleDebugSendChatMsgCommand(ChatHandler* handler, ChatMsg type)
    {
        WorldPacket data;
        ChatHandler::BuildChatPacket(data, type, LANG_UNIVERSAL, handler->GetPlayer(), handler->GetPlayer(), "testtest", 0, "chan");
        handler->GetSession()->SendPacket(&data);
        return true;
    }

    static bool HandleDebugSendQuestPartyMsgCommand(ChatHandler* handler, QuestShareMessages msg)
    {
        handler->GetPlayer()->SendPushToPartyResponse(handler->GetPlayer(), msg);
        return true;
    }

    static bool HandleDebugGetLootRecipientCommand(ChatHandler* handler)
    {
        Creature* target = handler->getSelectedCreature();
        if (!target)
            return false;

        handler->PSendSysMessage("Loot recipient for creature {} (GUID {}, SpawnID {}) is {}",
            target->GetName(), target->GetGUID().ToString(), target->GetSpawnId(),
            target->hasLootRecipient() ? (target->GetLootRecipient() ? target->GetLootRecipient()->GetName() : "offline") : "no loot recipient");
        return true;
    }

    static bool HandleDebugSendQuestInvalidMsgCommand(ChatHandler* handler, QuestFailedReason msg)
    {
        handler->GetPlayer()->SendCanTakeQuestResponse(msg);
        return true;
    }

    static bool HandleDebugGetItemStateCommand(ChatHandler* handler, std::string itemState)
    {
        ItemUpdateState state = ITEM_UNCHANGED;
        bool listQueue = false;
        bool checkAll = false;

        if (itemState == "unchanged")
            state = ITEM_UNCHANGED;
        else if (itemState == "changed")
            state = ITEM_CHANGED;
        else if (itemState == "new")
            state = ITEM_NEW;
        else if (itemState == "removed")
            state = ITEM_REMOVED;
        else if (itemState == "queue")
            listQueue = true;
        else if (itemState == "check_all")
            checkAll = true;
        else
            return false;

        Player* player = handler->getSelectedPlayer();
        if (!player)
            player = handler->GetPlayer();

        if (!listQueue && !checkAll)
        {
            itemState = "The player has the following " + itemState + " items: ";
            handler->SendSysMessage(itemState.c_str());
            for (uint8 i = PLAYER_SLOT_START; i < PLAYER_SLOT_END; ++i)
            {
                if (i >= BUYBACK_SLOT_START && i < BUYBACK_SLOT_END)
                    continue;

                if (Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                {
                    if (Bag* bag = item->ToBag())
                    {
                        for (uint8 j = 0; j < bag->GetBagSize(); ++j)
                            if (Item* item2 = bag->GetItemByPos(j))
                                if (item2->GetState() == state)
                                    handler->PSendSysMessage("bag: 255 slot: {} {} owner: {}", item2->GetSlot(), item2->GetGUID().ToString(), item2->GetOwnerGUID().ToString());
                    }
                    else if (item->GetState() == state)
                        handler->PSendSysMessage("bag: 255 slot: {} {} owner: {}", item->GetSlot(), item->GetGUID().ToString(), item->GetOwnerGUID().ToString());
                }
            }
        }

        if (listQueue)
        {
            auto const& updateQueue = player->GetItemUpdateQueue();

            for (auto const& item : updateQueue)
            {
                Bag* container = item->GetContainer();
                uint8 bagSlot = container ? container->GetSlot() : uint8(INVENTORY_SLOT_BAG_0);

                std::string st;
                switch (item->GetState())
                {
                case ITEM_UNCHANGED:
                    st = "unchanged";
                    break;
                case ITEM_CHANGED:
                    st = "changed";
                    break;
                case ITEM_NEW:
                    st = "new";
                    break;
                case ITEM_REMOVED:
                    st = "removed";
                    break;
                }

                handler->PSendSysMessage("bag: {} slot: {} guid: {} - state: {}", bagSlot, item->GetSlot(), item->GetGUID().ToString(), st);
            }

            if (updateQueue.empty())
                handler->PSendSysMessage("The player's updatequeue is empty");
        }

        if (checkAll)
        {
            bool error = false;
            auto const& updateQueue = player->GetItemUpdateQueue();
            for (uint8 i = PLAYER_SLOT_START; i < PLAYER_SLOT_END; ++i)
            {
                if (i >= BUYBACK_SLOT_START && i < BUYBACK_SLOT_END)
                    continue;

                Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
                if (!item)
                    continue;

                if (item->GetSlot() != i)
                {
                    handler->PSendSysMessage("Item with slot {} and guid {} has an incorrect slot value: {}", i, item->GetGUID().ToString(), item->GetSlot());
                    error = true;
                    continue;
                }

                if (item->GetOwnerGUID() != player->GetGUID())
                {
                    handler->PSendSysMessage("The item with slot {} {} does have non-matching owner guid {} and {}!", item->GetSlot(), item->GetGUID().ToString(), item->GetOwnerGUID().ToString(), player->GetGUID().ToString());
                    error = true;
                    continue;
                }

                if (Bag* container = item->GetContainer())
                {
                    handler->PSendSysMessage("The item with slot {} {} has a container (slot: {}, {}) but shouldn't!", item->GetSlot(), item->GetGUID().ToString(), container->GetSlot(), container->GetGUID().ToString());
                    error = true;
                    continue;
                }

                if (item->IsInUpdateQueue())
                {
                    uint16 qp = item->GetQueuePos();
                    if (qp > updateQueue.size())
                    {
                        handler->PSendSysMessage("The item with slot {} and guid {} has its queuepos ({}) larger than the update queue size! ", item->GetSlot(), item->GetGUID().ToString(), qp);
                        error = true;
                        continue;
                    }

                    if (!updateQueue[qp])
                    {
                        handler->PSendSysMessage("The item with slot {} and guid {} has its queuepos ({}) pointing to NULL in the queue!", item->GetSlot(), item->GetGUID().ToString(), qp);
                        error = true;
                        continue;
                    }

                    if (updateQueue[qp] != item)
                    {
                        handler->PSendSysMessage("The item with slot {} and guid {} has a queuepos ({}) that points to another item in the queue (bag: {}, slot: {}, guid: {})", item->GetSlot(), item->GetGUID().ToString(), qp, updateQueue[qp]->GetBagSlot(), updateQueue[qp]->GetSlot(), updateQueue[qp]->GetGUID().ToString());
                        error = true;
                        continue;
                    }
                }
                else if (item->GetState() != ITEM_UNCHANGED)
                {
                    handler->PSendSysMessage("The item with slot {} and guid {} is not in queue but should be (state: {})!", item->GetSlot(), item->GetGUID().ToString(), item->GetState());
                    error = true;
                    continue;
                }

                if (Bag* bag = item->ToBag())
                {
                    for (uint8 j = 0; j < bag->GetBagSize(); ++j)
                    {
                        Item* item2 = bag->GetItemByPos(j);
                        if (!item2)
                            continue;

                        if (item2->GetSlot() != j)
                        {
                            handler->PSendSysMessage("The item in bag {} and slot {} (guid: {}) has an incorrect slot value: {}", bag->GetSlot(), j, item2->GetGUID().ToString(), item2->GetSlot());
                            error = true;
                            continue;
                        }

                        if (item2->GetOwnerGUID() != player->GetGUID())
                        {
                            handler->PSendSysMessage("The item in bag {} at slot {} and {}, the owner ({}) and the player ({}) don't match!", bag->GetSlot(), item2->GetSlot(), item2->GetGUID().ToString(), item2->GetOwnerGUID().ToString(), player->GetGUID().ToString());
                            error = true;
                            continue;
                        }

                        Bag* container = item2->GetContainer();
                        if (!container)
                        {
                            handler->PSendSysMessage("The item in bag {} at slot {} {} has no container!", bag->GetSlot(), item2->GetSlot(), item2->GetGUID().ToString());
                            error = true;
                            continue;
                        }

                        if (container != bag)
                        {
                            handler->PSendSysMessage("The item in bag {} at slot {} {} has a different container(slot {} {})!", bag->GetSlot(), item2->GetSlot(), item2->GetGUID().ToString(), container->GetSlot(), container->GetGUID().ToString());
                            error = true;
                            continue;
                        }

                        if (item2->IsInUpdateQueue())
                        {
                            uint16 qp = item2->GetQueuePos();
                            if (qp > updateQueue.size())
                            {
                                handler->PSendSysMessage("The item in bag {} at slot {} having guid {} has a queuepos ({}) larger than the update queue size! ", bag->GetSlot(), item2->GetSlot(), item2->GetGUID().ToString(), qp);
                                error = true;
                                continue;
                            }

                            if (!updateQueue[qp])
                            {
                                handler->PSendSysMessage("The item in bag {} at slot {} having guid {} has a queuepos ({}) that points to NULL in the queue!", bag->GetSlot(), item2->GetSlot(), item2->GetGUID().ToString(), qp);
                                error = true;
                                continue;
                            }

                            if (updateQueue[qp] != item2)
                            {
                                handler->PSendSysMessage("The item in bag {} at slot {} having guid {} has a queuepos ({}) that points to another item in the queue (bag: {}, slot: {}, guid: {})", bag->GetSlot(), item2->GetSlot(), item2->GetGUID().ToString(), qp, updateQueue[qp]->GetBagSlot(), updateQueue[qp]->GetSlot(), updateQueue[qp]->GetGUID().ToString());
                                error = true;
                                continue;
                            }
                        }
                        else if (item2->GetState() != ITEM_UNCHANGED)
                        {
                            handler->PSendSysMessage("The item in bag {} at slot {} having guid {} is not in queue but should be (state: {})!", bag->GetSlot(), item2->GetSlot(), item2->GetGUID().ToString(), item2->GetState());
                            error = true;
                            continue;
                        }
                    }
                }
            }

            uint32 index = 0;

            for (auto const& item : updateQueue)
            {
                index++;

                if (item->GetOwnerGUID() != player->GetGUID())
                {
                    handler->SendSysMessage(Acore::StringFormat("queue({}): For the item {}, the owner ({}) and the player ({}) don't match!", index, item->GetGUID().ToString(), item->GetOwnerGUID().ToString(), player->GetGUID().ToString()));
                    error = true;
                    continue;
                }

                if (item->GetQueuePos() != index)
                {
                    handler->SendSysMessage(Acore::StringFormat("queue({}): For the item {}, the queuepos doesn't match it's position in the queue!", index, item->GetGUID().ToString()));
                    error = true;
                    continue;
                }

                if (item->GetState() == ITEM_REMOVED)
                    continue;

                Item* test = player->GetItemByPos(item->GetBagSlot(), item->GetSlot());

                if (!test)
                {
                    handler->SendSysMessage(Acore::StringFormat("queue({}): The bag({}) and slot({}) values for {} are incorrect, the player doesn't have any item at that position!", index, item->GetBagSlot(), item->GetSlot(), item->GetGUID().ToString()));
                    error = true;
                    continue;
                }

                if (test != item)
                {
                    handler->SendSysMessage(Acore::StringFormat("queue({}): The bag({}) and slot({}) values for the {} are incorrect, {} is there instead!", index, item->GetBagSlot(), item->GetSlot(), item->GetGUID().ToString(), test->GetGUID().ToString()));
                    error = true;
                    continue;
                }
            }

            if (!error)
                handler->SendSysMessage("All OK!");
        }

        return true;
    }

    static bool HandleDebugDungeonFinderCommand(ChatHandler* /*handler*/)
    {
        sLFGMgr->ToggleTesting();
        return true;
    }

    static bool HandleDebugBattlegroundCommand(ChatHandler* /*handler*/)
    {
        sBattlegroundMgr->ToggleTesting();
        return true;
    }

    static bool HandleDebugCooldownCommand(ChatHandler* handler, uint32 spell_id, uint32 end_time, Optional<uint32> item_id)
    {
        Player* player = handler->GetPlayer();

        if (!player || !spell_id || !end_time)
            return false;

        if (!sSpellMgr->GetSpellInfo(spell_id))
            return false;

        if (!item_id)
            item_id = 0;
        else if (!sItemStore.LookupEntry(*item_id))
            return false;

        if (end_time < player->GetSpellCooldownDelay(spell_id))
            player->RemoveSpellCooldown(spell_id, true);

        player->AddSpellCooldown(spell_id, *item_id, end_time, true, false);

        WorldPacket data;
        player->BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_NONE, spell_id, end_time);
        player->SendDirectMessage(&data);

        return true;
    }

    static bool HandleDebugArenaCommand(ChatHandler* /*handler*/)
    {
        sBattlegroundMgr->ToggleArenaTesting();
        return true;
    }

    static bool HandleDebugThreatListCommand(ChatHandler* handler)
    {
        Creature* target = handler->getSelectedCreature();
        if (!target || target->IsTotem() || target->IsPet())
            return false;

        auto const& threatList = target->GetThreatMgr().GetThreatList();
        ThreatContainer::StorageType::const_iterator itr;
        uint32 count = 0;

        handler->PSendSysMessage("Threat list of {} ({})", target->GetName(), target->GetGUID().ToString());

        for (itr = threatList.begin(); itr != threatList.end(); ++itr)
        {
            Unit* unit = (*itr)->getTarget();
            if (!unit)
            {
                handler->PSendSysMessage("   {}.   No Unit  - threat {}", ++count, (*itr)->GetThreat());
                continue;
            }

            handler->PSendSysMessage("   {}.   {}   ({})  - threat {}", ++count, unit->GetName(), unit->GetGUID().ToString(), (*itr)->GetThreat());
        }

        auto const& threatList2 = target->GetThreatMgr().GetOfflineThreatList();
        for (itr = threatList2.begin(); itr != threatList2.end(); ++itr)
        {
            Unit* unit = (*itr)->getTarget();
            if (!unit)
            {
                handler->PSendSysMessage("   {}.   [offline] No Unit  - threat {}", ++count, (*itr)->GetThreat());
                continue;
            }

            handler->PSendSysMessage("   {}.   [offline] {}   ({})  - threat {}", ++count, unit->GetName(), unit->GetGUID().ToString(), (*itr)->GetThreat());
        }

        handler->SendSysMessage("End of threat list.");

        return true;
    }

    static bool HandleDebugHostileRefListCommand(ChatHandler* handler)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target)
            target = handler->GetSession()->GetPlayer();

        HostileReference* ref = target->getHostileRefMgr().getFirst();
        uint32 count = 0;

        handler->PSendSysMessage("Hostile reference list of {} ({})", target->GetName(), target->GetGUID().ToString());

        while (ref)
        {
            if (Unit* unit = ref->GetSource()->GetOwner())
            {
                handler->PSendSysMessage("   {}.   {} {}   ({})  - threat {}", ++count, (ref->IsOnline() ? "" : "[offline]"),
                    unit->GetName(), unit->GetGUID().ToString(), ref->GetThreat());
            }
            else
            {
                handler->PSendSysMessage("   {}.   No Owner  - threat {}", ++count, ref->GetThreat());
            }

            ref = ref->next();
        }

        handler->SendSysMessage("End of hostile reference list.");
        return true;
    }

    static bool HandleDebugSetVehicleIdCommand(ChatHandler* handler, uint32 id)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target || target->IsVehicle())
            return false;

        //target->SetVehicleId(id);
        handler->PSendSysMessage("Vehicle id set to {}", id);
        return true;
    }

    static bool HandleDebugEnterVehicleCommand(ChatHandler* handler, uint32 entry, Optional<int8> seatId)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target || !target->IsVehicle())
            return false;

        if (!seatId)
            seatId = -1;

        if (!entry)
            handler->GetPlayer()->EnterVehicle(target, *seatId);
        else
        {
            Creature* passenger = nullptr;
            Acore::AllCreaturesOfEntryInRange check(handler->GetPlayer(), entry, 20.0f);
            Acore::CreatureSearcher<Acore::AllCreaturesOfEntryInRange> searcher(handler->GetPlayer(), passenger, check);
            Cell::VisitObjects(handler->GetPlayer(), searcher, 30.0f);

            if (!passenger || passenger == target)
                return false;

            passenger->EnterVehicle(target, *seatId);
        }

        handler->PSendSysMessage("Unit {} entered vehicle {:d}", entry, *seatId);
        return true;
    }

    static bool HandleDebugSpawnVehicleCommand(ChatHandler* handler, uint32 entry, Optional<uint32> id)
    {
        float x, y, z, o = handler->GetPlayer()->GetOrientation();
        handler->GetPlayer()->GetClosePoint(x, y, z, handler->GetPlayer()->GetCombatReach());

        if (!id)
            return handler->GetPlayer()->SummonCreature(entry, x, y, z, o) != nullptr;

        CreatureTemplate const* ci = sObjectMgr->GetCreatureTemplate(entry);

        if (!ci)
            return false;

        VehicleEntry const* ve = sVehicleStore.LookupEntry(*id);

        if (!ve)
            return false;

        Creature* v = new Creature();

        Map* map = handler->GetPlayer()->GetMap();

        if (!v->Create(map->GenerateLowGuid<HighGuid::Vehicle>(), map, handler->GetSession()->GetPlayer()->GetPhaseMask(), entry, *id, x, y, z, o))
        {
            delete v;
            return false;
        }

        map->AddToMap(v->ToCreature());

        return true;
    }

    static bool HandleDebugSendLargePacketCommand(ChatHandler* handler)
    {
        std::ostringstream ss;

        while (ss.str().size() < 128000)
            ss << "This is a dummy string to push the packet's size beyond 128000 bytes. ";

        handler->SendSysMessage(ss.str().c_str());
        return true;
    }

    static bool HandleDebugSendSetPhaseShiftCommand(ChatHandler* handler, uint32 phaseShift)
    {
        handler->GetSession()->SendSetPhaseShift(phaseShift);
        return true;
    }

    static bool HandleDebugGetItemValueCommand(ChatHandler* handler, ObjectGuid::LowType guid, uint32 index)
    {
        Item* i = handler->GetPlayer()->GetItemByGuid(ObjectGuid(HighGuid::Item, 0, guid));

        if (!i)
            return false;

        if (index >= i->GetValuesCount())
            return false;

        uint32 value = i->GetUInt32Value(index);

        handler->PSendSysMessage("Item {}: value at {} is {}", guid, index, value);

        return true;
    }

    static bool HandleDebugSetItemValueCommand(ChatHandler* handler, ObjectGuid::LowType guid, uint32 index, uint32 value)
    {
        Item* i = handler->GetPlayer()->GetItemByGuid(ObjectGuid(HighGuid::Item, 0, guid));

        if (!i)
            return false;

        if (index >= i->GetValuesCount())
            return false;

        i->SetUInt32Value(index, value);

        return true;
    }

    static bool HandleDebugItemExpireCommand(ChatHandler* handler, ObjectGuid::LowType guid)
    {
        Item* i = handler->GetPlayer()->GetItemByGuid(ObjectGuid(HighGuid::Item, guid));

        if (!i)
            return false;

        handler->GetPlayer()->DestroyItem(i->GetBagSlot(), i->GetSlot(), true);
        sScriptMgr->OnItemExpire(handler->GetPlayer(), i->GetTemplate());

        return true;
    }

    // Play emote animation
    static bool HandleDebugAnimCommand(ChatHandler* handler, Emote emote)
    {
        if (Unit* unit = handler->getSelectedUnit())
            unit->HandleEmoteCommand(emote);

        handler->PSendSysMessage("Playing emote {}", EnumUtils::ToConstant(emote));

        return true;
    }

    static bool HandleDebugLoSCommand(ChatHandler* handler)
    {
        if (Unit* unit = handler->getSelectedUnit())
        {
            Player* player = handler->GetSession()->GetPlayer();
            handler->PSendSysMessage("Checking LoS {} -> {}:", player->GetName(), unit->GetName());
            handler->PSendSysMessage("    VMAP LoS: {}", player->IsWithinLOSInMap(unit, VMAP::ModelIgnoreFlags::Nothing, LINEOFSIGHT_CHECK_VMAP) ? "clear" : "obstructed");
            handler->PSendSysMessage("    GObj LoS: {}", player->IsWithinLOSInMap(unit, VMAP::ModelIgnoreFlags::Nothing, LINEOFSIGHT_CHECK_GOBJECT_ALL) ? "clear" : "obstructed");
            handler->PSendSysMessage("{} is {}in line of sight of {}.", unit->GetName(), (player->IsWithinLOSInMap(unit) ? "" : "not "), player->GetName());
            return true;
        }

        return false;
    }

    static bool HandleDebugSetAuraStateCommand(ChatHandler* handler, Optional<AuraStateType> state, bool apply)
    {
        Unit* unit = handler->getSelectedUnit();
        if (!unit)
        {
            handler->SendErrorMessage(LANG_SELECT_CHAR_OR_CREATURE);
            return false;
        }

        if (!state)
        {
            // reset all states
            for (AuraStateType s : EnumUtils::Iterate<AuraStateType>())
                unit->ModifyAuraState(s, false);
            return true;
        }

        unit->ModifyAuraState(*state, apply);
        return true;
    }

    static bool HandleDebugSetValueCommand(ChatHandler* handler, uint32 index, Variant<uint32, float> value)
    {
        WorldObject* target = handler->getSelectedObject();
        if (!target)
        {
            handler->SendErrorMessage(LANG_SELECT_CHAR_OR_CREATURE);
            return false;
        }

        if (index >= target->GetValuesCount())
        {
            handler->PSendSysMessage(LANG_TOO_BIG_INDEX, index, target->GetGUID().ToString(), target->GetValuesCount());
            return false;
        }

        if (value.holds_alternative<uint32>())
        {
            target->SetUInt32Value(index, value.get<uint32>());
            handler->PSendSysMessage(LANG_SET_UINT_FIELD, target->GetGUID().ToString(), uint32(index), uint32(value));
        }
        else if (value.holds_alternative<float>())
        {
            target->SetFloatValue(index, value.get<float>());
            handler->PSendSysMessage(LANG_SET_FLOAT_FIELD, target->GetGUID().ToString(), static_cast<float>(index), uint32(value));
        }

        return true;
    }

    static bool HandleDebugGetValueCommand(ChatHandler* handler, uint32 index, bool isInt)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target)
        {
            handler->SendErrorMessage(LANG_SELECT_CHAR_OR_CREATURE);
            return false;
        }

        ObjectGuid guid = target->GetGUID();

        if (index >= target->GetValuesCount())
        {
            handler->PSendSysMessage(LANG_TOO_BIG_INDEX, index, guid.ToString(), target->GetValuesCount());
            return false;
        }

        if (isInt)
        {
            uint32 value = target->GetUInt32Value(index);
            handler->PSendSysMessage(LANG_GET_UINT_FIELD, guid.ToString(), index, value);
        }
        else
        {
            float value = target->GetFloatValue(index);
            handler->PSendSysMessage(LANG_GET_FLOAT_FIELD, guid.ToString(), index, value);
        }

        return true;
    }

    static bool HandleDebugMod32ValueCommand(ChatHandler* handler, uint32 index, uint32 value)
    {
        if (index >= handler->GetPlayer()->GetValuesCount())
        {
            handler->PSendSysMessage(LANG_TOO_BIG_INDEX, index, handler->GetPlayer()->GetGUID().ToString(), handler->GetPlayer()->GetValuesCount());
            return false;
        }

        uint32 currentValue = handler->GetPlayer()->GetUInt32Value(index);

        currentValue += value;
        handler->GetPlayer()->SetUInt32Value(index, currentValue);

        handler->PSendSysMessage(LANG_CHANGE_32BIT_FIELD, index, currentValue);

        return true;
    }

    static bool HandleDebugUpdateCommand(ChatHandler* handler, uint32 index, Optional<uint32> value)
    {
        Unit* unit = handler->getSelectedUnit();
        if (!unit)
        {
            handler->SendErrorMessage(LANG_SELECT_CHAR_OR_CREATURE);
            return false;
        }

        if (!index)
            return true;

        // check index
        if (unit->IsPlayer())
        {
            if (index >= PLAYER_END)
                return true;
        }
        else if (index >= UNIT_END)
            return true;

        if (!value)
        {
            value = unit->GetUInt32Value(index);

            handler->PSendSysMessage(LANG_UPDATE, unit->GetGUID().ToString(), index, *value);
            return true;
        }

        unit->SetUInt32Value(index, *value);

        handler->PSendSysMessage(LANG_UPDATE_CHANGE, unit->GetGUID().ToString(), index, *value);
        return true;
    }

    static bool HandleDebugSet32BitCommand(ChatHandler* handler, uint32 index, uint8 bit)
    {
        WorldObject* target = handler->getSelectedObject();
        if (!target)
        {
            handler->SendErrorMessage(LANG_SELECT_CHAR_OR_CREATURE);
            return false;
        }

        if (bit > 32) // uint32 = 32 bits
            return false;

        uint32 value = bit ? 1 << (bit - 1) : 0;
        target->SetUInt32Value(index, value);

        handler->PSendSysMessage(LANG_SET_32BIT_FIELD, index, value);
        return true;
    }

    static bool HandleDebugMoveflagsCommand(ChatHandler* handler, Optional<uint32> moveFlags, Optional<uint32> moveFlagsExtra)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target)
            target = handler->GetPlayer();

        if (!moveFlags)
        {
            //! Display case
            handler->PSendSysMessage(LANG_MOVEFLAGS_GET, target->GetUnitMovementFlags(), target->GetExtraUnitMovementFlags());
        }
        else
        {
            static uint32 const FlagsWithHandlers = MOVEMENTFLAG_MASK_HAS_PLAYER_STATUS_OPCODE |
                MOVEMENTFLAG_WALKING | MOVEMENTFLAG_SWIMMING |
                MOVEMENTFLAG_SPLINE_ENABLED;

            bool unhandledFlag = ((*moveFlags ^ target->GetUnitMovementFlags()) & ~FlagsWithHandlers) != 0;

            target->SetWalk((*moveFlags & MOVEMENTFLAG_WALKING) != 0);
            target->SetDisableGravity((*moveFlags & MOVEMENTFLAG_DISABLE_GRAVITY) != 0);
            target->SetSwim((*moveFlags & MOVEMENTFLAG_SWIMMING) != 0);
            target->SetCanFly((*moveFlags & MOVEMENTFLAG_CAN_FLY) != 0);
            target->SetWaterWalking((*moveFlags & MOVEMENTFLAG_WATERWALKING) != 0);
            target->SetFeatherFall((*moveFlags & MOVEMENTFLAG_FALLING_SLOW) != 0);
            target->SetHover((*moveFlags & MOVEMENTFLAG_HOVER) != 0);

            if (*moveFlags & (MOVEMENTFLAG_DISABLE_GRAVITY | MOVEMENTFLAG_CAN_FLY))
                *moveFlags &= ~MOVEMENTFLAG_FALLING;

            if (*moveFlags & MOVEMENTFLAG_ROOT)
            {
                target->SetControlled(true, UNIT_STATE_ROOT);
                *moveFlags &= ~MOVEMENTFLAG_MASK_MOVING;
            }

            if (target->HasUnitMovementFlag(MOVEMENTFLAG_SPLINE_ENABLED) && !(*moveFlags & MOVEMENTFLAG_SPLINE_ENABLED))
                target->StopMoving();

            if (unhandledFlag)
                target->SetUnitMovementFlags(*moveFlags);

            if (moveFlagsExtra)
            {
                target->SetExtraUnitMovementFlags(*moveFlagsExtra);
            }

            if (moveFlagsExtra || unhandledFlag)
                target->SendMovementFlagUpdate();

            handler->PSendSysMessage(LANG_MOVEFLAGS_SET, target->GetUnitMovementFlags(), target->GetExtraUnitMovementFlags());
        }

        return true;
    }

    static bool HandleDebugUnitStateCommand(ChatHandler* handler, uint32 unitState)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target)
            target = handler->GetSession()->GetPlayer();

        target->ClearUnitState(target->GetUnitState());
        target->AddUnitState(unitState);

        return true;
    }

    static bool HandleWPGPSCommand(ChatHandler* handler, Optional<std::string> type)
    {
        Player* player = handler->GetSession()->GetPlayer();

        if (!type)
        {
            // waypoint_data - id, point, X, Y, Z, O, delay, move_type, action, action_chance, wpguid
            LOG_INFO("sql.dev", "(@PATH, XX, {:.3f}, {:.3f}, {:.5f}, {:.5f}, 0, 0, 0, 100, 0),", player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetOrientation());
        }

        if (type == "sai")
        {
            // waypoint (SAI) - entry, pointid, X, Y, Z, O, delay
            LOG_INFO("sql.dev", "(@PATH, XX, {:.3f}, {:.3f}, {:.5f}, {:.5f}, 0),", player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetOrientation());
        }

        handler->PSendSysMessage("Waypoint SQL written to SQL Developer log");
        return true;
    }

    static bool HandleDebugObjectCountCommand(ChatHandler* handler, Optional<uint32> mapId)
    {
        if (mapId)
        {
            sMapMgr->DoForAllMapsWithMapId(mapId.value(),
               [handler](Map* map) -> void
                {
                   HandleDebugObjectCountMap(handler, map);
                }
            );
        }
        else
        {
            sMapMgr->DoForAllMaps(
                [handler](Map* map) -> void
                {
                    HandleDebugObjectCountMap(handler, map);
                }
            );
        }

        return true;
    }

    class CreatureCountWorker
    {
    public:
        CreatureCountWorker() { }

        void Visit(std::unordered_map<ObjectGuid, Creature*>& creatureMap)
        {
            for (auto const& p : creatureMap)
            {
                uint32& count = creatureIds[p.second->GetEntry()];
                ++count;
            }
        }

        template<class T>
        void Visit(std::unordered_map<ObjectGuid, T*>&) { }

        std::vector<std::pair<uint32, uint32>> GetTopCreatureCount(uint32 count)
        {
            auto comp = [](std::pair<uint32, uint32> const& a, std::pair<uint32, uint32> const& b)
            {
                return a.second > b.second;
            };
            std::set<std::pair<uint32, uint32>, decltype(comp)> set(creatureIds.begin(), creatureIds.end(), comp);

            count = std::min(count, uint32(set.size()));
            std::vector<std::pair<uint32, uint32>> result(count);
            std::copy_n(set.begin(), count, result.begin());

            return result;
        }

    private:
        std::unordered_map<uint32, uint32> creatureIds;
    };

    static void HandleDebugObjectCountMap(ChatHandler* handler, Map* map)
    {
        handler->PSendSysMessage("Map Id: {} Name: '{}' Instance Id: {} Creatures: {} GameObjects: {} Update Objects: {}",
                map->GetId(), map->GetMapName(), map->GetInstanceId(),
                uint64(map->GetObjectsStore().Size<Creature>()),
                uint64(map->GetObjectsStore().Size<GameObject>()),
                uint64(map->GetUpdatableObjectsCount()));

        CreatureCountWorker worker;
        TypeContainerVisitor<CreatureCountWorker, MapStoredObjectTypesContainer> visitor(worker);
        visitor.Visit(map->GetObjectsStore());

        handler->PSendSysMessage("Top Creatures count:");

        for (auto&& p : worker.GetTopCreatureCount(5))
            handler->PSendSysMessage("Entry: {} Count: {}", p.first, p.second);
    }

    static bool HandleDebugDummyCommand(ChatHandler* handler)
    {
        handler->SendSysMessage("This command does nothing right now. Edit your local core (cs_debug.cpp) to make it do whatever you need for testing.");
        return true;
    }

    static bool HandleDebugMapDataCommand(ChatHandler* handler)
    {
        Cell cell(handler->GetPlayer()->GetPositionX(), handler->GetPlayer()->GetPositionY());
        Map* map = handler->GetPlayer()->GetMap();

        handler->PSendSysMessage("GridX {} GridY {}", cell.GridX(), cell.GridY());
        handler->PSendSysMessage("CellX {} CellY {}", cell.CellX(), cell.CellY());
        handler->PSendSysMessage("Created Grids: {} / {}", map->GetCreatedGridsCount(), MAX_NUMBER_OF_GRIDS * MAX_NUMBER_OF_GRIDS);
        handler->PSendSysMessage("Loaded Grids: {} / {}", map->GetLoadedGridsCount(), MAX_NUMBER_OF_GRIDS * MAX_NUMBER_OF_GRIDS);
        handler->PSendSysMessage("Created Cells In Grid: {} / {}", map->GetCreatedCellsInGridCount(cell.GridX(), cell.GridY()), MAX_NUMBER_OF_CELLS * MAX_NUMBER_OF_CELLS);
        handler->PSendSysMessage("Created Cells In Map: {} / {}", map->GetCreatedCellsInMapCount(), TOTAL_NUMBER_OF_CELLS_PER_MAP * TOTAL_NUMBER_OF_CELLS_PER_MAP);
        return true;
    }

    static bool HandleDebugBoundaryCommand(ChatHandler* handler, Optional<uint32> durationArg, Optional<EXACT_SEQUENCE("fill")> fill, Optional<EXACT_SEQUENCE("z")> checkZ)
    {
        Player* player = handler->GetPlayer();
        if (!player)
            return false;

        Creature* target = handler->getSelectedCreature();
        if (!target || !target->IsAIEnabled)
            return false;

        uint32 duration = durationArg.value_or(5 * IN_MILLISECONDS);
        if (duration > 180 * IN_MILLISECONDS) // arbitrary upper limit
            duration = 180 * IN_MILLISECONDS;

        int32 errMsg = target->AI()->VisualizeBoundary(duration, player, fill.has_value(), checkZ.has_value());
        if (errMsg > 0)
            handler->PSendSysMessage(errMsg);

        return true;
    }

    static bool HandleDebugVisibilityDataCommand(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        if (!player)
            return false;

        std::array<uint32, NUM_CLIENT_OBJECT_TYPES> objectByTypeCount = {};

        ObjectVisibilityContainer const& objectVisibilityContainer = player->GetObjectVisibilityContainer();
        for (auto const& kvPair : *objectVisibilityContainer.GetVisibleWorldObjectsMap())
        {
            WorldObject const* obj = kvPair.second;
            ++objectByTypeCount[obj->GetTypeId()];
        }

        uint32 zoneWideVisibleObjectsInZone = 0;
        if (ZoneWideVisibleWorldObjectsSet const* farVisibleSet = player->GetMap()->GetZoneWideVisibleWorldObjectsForZone(player->GetZoneId()))
            zoneWideVisibleObjectsInZone = farVisibleSet->size();

        handler->PSendSysMessage("Visibility Range: {}", player->GetVisibilityRange());
        handler->PSendSysMessage("Visible Creatures: {}", objectByTypeCount[TYPEID_UNIT]);
        handler->PSendSysMessage("Visible Players: {}", objectByTypeCount[TYPEID_PLAYER]);
        handler->PSendSysMessage("Visible GameObjects: {}", objectByTypeCount[TYPEID_GAMEOBJECT]);
        handler->PSendSysMessage("Visible DynamicObjects: {}", objectByTypeCount[TYPEID_DYNAMICOBJECT]);
        handler->PSendSysMessage("Visible Corpses: {}", objectByTypeCount[TYPEID_CORPSE]);
        handler->PSendSysMessage("Players we are visible to: {}", objectVisibilityContainer.GetVisiblePlayersMap().size());
        handler->PSendSysMessage("Zone wide visible objects in zone: {}", zoneWideVisibleObjectsInZone);
        return true;
    }

    static bool HandleDebugZoneStatsCommand(ChatHandler* handler, Optional<PlayerIdentifier> playerTarget)
    {
        if (!playerTarget)
            playerTarget = PlayerIdentifier::FromTargetOrSelf(handler);

        if (!playerTarget)
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        Player* player = playerTarget->GetConnectedPlayer();

        if (!player)
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        uint32 zoneId = player->GetZoneId();
        AreaTableEntry const* zoneEntry = sAreaTableStore.LookupEntry(zoneId);
        handler->PSendSysMessage("Player count in zone {} ({}): {}.", zoneId, (zoneEntry ? zoneEntry->area_name[LOCALE_enUS] : "<unknown>"), player->GetMap()->GetPlayerCountInZone(zoneId));
        return true;
    }
};

void AddSC_debug_commandscript()
{
    new debug_commandscript();
}
