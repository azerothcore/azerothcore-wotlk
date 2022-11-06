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
 Name: debug_commandscript
 %Complete: 100
 Comment: All debug related commands
 Category: commandscripts
 EndScriptData */

#include "Bag.h"
#include "BattlegroundMgr.h"
#include "CellImpl.h"
#include "Channel.h"
#include "Chat.h"
#include "GossipDef.h"
#include "GridNotifiersImpl.h"
#include "InstanceScript.h"
#include "Language.h"
#include "Log.h"
#include "MapMgr.h"
#include "M2Stores.h"
#include "ObjectMgr.h"
#include "PoolMgr.h"
#include "ScriptMgr.h"
#include "SpellMgr.h"
#include "Transport.h"
#include "Warden.h"
#include "World.h"
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
            { "chatmmessage",   HandleDebugSendChatMsgCommand,         SEC_ADMINISTRATOR, Console::No },
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
            { "bg",             HandleDebugBattlegroundCommand,        SEC_ADMINISTRATOR, Console::No },
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
            { "lfg",            HandleDebugDungeonFinderCommand,       SEC_ADMINISTRATOR, Console::No },
            { "los",            HandleDebugLoSCommand,                 SEC_ADMINISTRATOR, Console::No },
            { "moveflags",      HandleDebugMoveflagsCommand,           SEC_ADMINISTRATOR, Console::No },
            { "unitstate",      HandleDebugUnitStateCommand,           SEC_ADMINISTRATOR, Console::No },
            { "objectcount",    HandleDebugObjectCountCommand,         SEC_ADMINISTRATOR, Console::Yes},
            { "dummy",          HandleDebugDummyCommand,               SEC_ADMINISTRATOR, Console::No }
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
            handler->PSendSysMessage(LANG_CINEMATIC_NOT_EXIST, cinematicId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // Dump camera locations
        if (std::vector<FlyByCamera> const* flyByCameras = GetFlyByCameras(cineSeq->cinematicCamera))
        {
            handler->PSendSysMessage("Waypoints for sequence %u, camera %u", cinematicId, cineSeq->cinematicCamera);
            uint32 count = 1;
            for (FlyByCamera const& cam : *flyByCameras)
            {
                handler->PSendSysMessage("%02u - %7ums [%s (%f degrees)]", count, cam.timeStamp, cam.locations.ToString().c_str(), cam.locations.GetOrientation() * (180 / M_PI));
                ++count;
            }
            handler->PSendSysMessage("%u waypoints dumped", flyByCameras->size());
        }

        handler->GetPlayer()->SendCinematicStart(cinematicId);
        return true;
    }

    // movieId - ID from Movie.dbc
    static bool HandleDebugPlayMovieCommand(ChatHandler* handler, uint32 movieId)
    {
        if (!sMovieStore.LookupEntry(movieId))
        {
            handler->PSendSysMessage(LANG_MOVIE_NOT_EXIST, movieId);
            handler->SetSentErrorMessage(true);
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
            handler->PSendSysMessage(LANG_SOUND_NOT_EXIST, soundId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* player = handler->GetPlayer();

        Unit* unit = handler->getSelectedUnit();
        if (!unit)
        {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
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
            handler->PSendSysMessage(LANG_SOUND_NOT_EXIST, musicId);
            handler->SetSentErrorMessage(true);
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
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
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

        if (!unit || (unit->GetTypeId() != TYPEID_PLAYER))
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
            handler->SendSysMessage(LANG_DEBUG_OPCODE_FILE_MISSING);
            handler->SetSentErrorMessage(true);
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
                    handler->PSendSysMessage(LANG_COMMAND_OBJNOTFOUND, 0);
                    handler->SetSentErrorMessage(true);
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
                    handler->PSendSysMessage(LANG_COMMAND_OBJNOTFOUND, 0);
                    handler->SetSentErrorMessage(true);
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
        player->GetSession()->SendPacket(&data);
        handler->PSendSysMessage(LANG_COMMAND_OPCODESENT, data.GetOpcode(), unit->GetName().c_str());
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

        handler->PSendSysMessage("Loot recipient for creature %s (GUID %u, SpawnID %u) is %s",
            target->GetName().c_str(), target->GetGUID().GetCounter(), target->GetSpawnId(),
            target->hasLootRecipient() ? (target->GetLootRecipient() ? target->GetLootRecipient()->GetName().c_str() : "offline") : "no loot recipient");
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
                                    handler->PSendSysMessage("bag: 255 slot: %d %s owner: %s", item2->GetSlot(), item2->GetGUID().ToString().c_str(), item2->GetOwnerGUID().ToString().c_str());
                    }
                    else if (item->GetState() == state)
                        handler->PSendSysMessage("bag: 255 slot: %d %s owner: %s", item->GetSlot(), item->GetGUID().ToString().c_str(), item->GetOwnerGUID().ToString().c_str());
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

                handler->PSendSysMessage("bag: %d slot: %d guid: %d - state: %s", bagSlot, item->GetSlot(), item->GetGUID().GetCounter(), st.c_str());
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
                    handler->PSendSysMessage("Item with slot %d and guid %d has an incorrect slot value: %d", i, item->GetGUID().GetCounter(), item->GetSlot());
                    error = true;
                    continue;
                }

                if (item->GetOwnerGUID() != player->GetGUID())
                {
                    handler->PSendSysMessage("The item with slot %d %s does have non-matching owner guid %s and %s!", item->GetSlot(), item->GetGUID().ToString().c_str(), item->GetOwnerGUID().ToString().c_str(), player->GetGUID().ToString().c_str());
                    error = true;
                    continue;
                }

                if (Bag* container = item->GetContainer())
                {
                    handler->PSendSysMessage("The item with slot %d %s has a container (slot: %d, %s) but shouldn't!", item->GetSlot(), item->GetGUID().ToString().c_str(), container->GetSlot(), container->GetGUID().ToString().c_str());
                    error = true;
                    continue;
                }

                if (item->IsInUpdateQueue())
                {
                    uint16 qp = item->GetQueuePos();
                    if (qp > updateQueue.size())
                    {
                        handler->PSendSysMessage("The item with slot %d and guid %d has its queuepos (%d) larger than the update queue size! ", item->GetSlot(), item->GetGUID().GetCounter(), qp);
                        error = true;
                        continue;
                    }

                    if (!updateQueue[qp])
                    {
                        handler->PSendSysMessage("The item with slot %d and guid %d has its queuepos (%d) pointing to NULL in the queue!", item->GetSlot(), item->GetGUID().GetCounter(), qp);
                        error = true;
                        continue;
                    }

                    if (updateQueue[qp] != item)
                    {
                        handler->PSendSysMessage("The item with slot %d and guid %d has a queuepos (%d) that points to another item in the queue (bag: %d, slot: %d, guid: %d)", item->GetSlot(), item->GetGUID().GetCounter(), qp, updateQueue[qp]->GetBagSlot(), updateQueue[qp]->GetSlot(), updateQueue[qp]->GetGUID().GetCounter());
                        error = true;
                        continue;
                    }
                }
                else if (item->GetState() != ITEM_UNCHANGED)
                {
                    handler->PSendSysMessage("The item with slot %d and guid %d is not in queue but should be (state: %d)!", item->GetSlot(), item->GetGUID().GetCounter(), item->GetState());
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
                            handler->PSendSysMessage("The item in bag %d and slot %d (guid: %d) has an incorrect slot value: %d", bag->GetSlot(), j, item2->GetGUID().GetCounter(), item2->GetSlot());
                            error = true;
                            continue;
                        }

                        if (item2->GetOwnerGUID() != player->GetGUID())
                        {
                            handler->PSendSysMessage("The item in bag %d at slot %d and %s, the owner (%s) and the player (%s) don't match!", bag->GetSlot(), item2->GetSlot(), item2->GetGUID().ToString().c_str(), item2->GetOwnerGUID().ToString().c_str(), player->GetGUID().ToString().c_str());
                            error = true;
                            continue;
                        }

                        Bag* container = item2->GetContainer();
                        if (!container)
                        {
                            handler->PSendSysMessage("The item in bag %d at slot %d %s has no container!", bag->GetSlot(), item2->GetSlot(), item2->GetGUID().ToString().c_str());
                            error = true;
                            continue;
                        }

                        if (container != bag)
                        {
                            handler->PSendSysMessage("The item in bag %d at slot %d %s has a different container(slot %d %s)!", bag->GetSlot(), item2->GetSlot(), item2->GetGUID().ToString().c_str(), container->GetSlot(), container->GetGUID().ToString().c_str());
                            error = true;
                            continue;
                        }

                        if (item2->IsInUpdateQueue())
                        {
                            uint16 qp = item2->GetQueuePos();
                            if (qp > updateQueue.size())
                            {
                                handler->PSendSysMessage("The item in bag %d at slot %d having guid %d has a queuepos (%d) larger than the update queue size! ", bag->GetSlot(), item2->GetSlot(), item2->GetGUID().GetCounter(), qp);
                                error = true;
                                continue;
                            }

                            if (!updateQueue[qp])
                            {
                                handler->PSendSysMessage("The item in bag %d at slot %d having guid %d has a queuepos (%d) that points to NULL in the queue!", bag->GetSlot(), item2->GetSlot(), item2->GetGUID().GetCounter(), qp);
                                error = true;
                                continue;
                            }

                            if (updateQueue[qp] != item2)
                            {
                                handler->PSendSysMessage("The item in bag %d at slot %d having guid %d has a queuepos (%d) that points to another item in the queue (bag: %d, slot: %d, guid: %d)", bag->GetSlot(), item2->GetSlot(), item2->GetGUID().GetCounter(), qp, updateQueue[qp]->GetBagSlot(), updateQueue[qp]->GetSlot(), updateQueue[qp]->GetGUID().GetCounter());
                                error = true;
                                continue;
                            }
                        }
                        else if (item2->GetState() != ITEM_UNCHANGED)
                        {
                            handler->PSendSysMessage("The item in bag %d at slot %d having guid %d is not in queue but should be (state: %d)!", bag->GetSlot(), item2->GetSlot(), item2->GetGUID().GetCounter(), item2->GetState());
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
                    handler->SendSysMessage(Acore::StringFormatFmt("queue({}): For the item {}, the owner ({}) and the player ({}) don't match!", index, item->GetGUID().ToString(), item->GetOwnerGUID().ToString(), player->GetGUID().ToString()));
                    error = true;
                    continue;
                }

                if (item->GetQueuePos() != index)
                {
                    handler->SendSysMessage(Acore::StringFormatFmt("queue({}): For the item {}, the queuepos doesn't match it's position in the queue!", index, item->GetGUID().ToString()));
                    error = true;
                    continue;
                }

                if (item->GetState() == ITEM_REMOVED)
                    continue;

                Item* test = player->GetItemByPos(item->GetBagSlot(), item->GetSlot());

                if (!test)
                {
                    handler->SendSysMessage(Acore::StringFormatFmt("queue({}): The bag({}) and slot({}) values for {} are incorrect, the player doesn't have any item at that position!", index, item->GetBagSlot(), item->GetSlot(), item->GetGUID().ToString()));
                    error = true;
                    continue;
                }

                if (test != item)
                {
                    handler->SendSysMessage(Acore::StringFormatFmt("queue({}): The bag({}) and slot({}) values for the %s are incorrect, {} is there instead!", index, item->GetBagSlot(), item->GetSlot(), item->GetGUID().ToString(), test->GetGUID().ToString()));
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

        handler->PSendSysMessage("Threat list of %s (%s)", target->GetName().c_str(), target->GetGUID().ToString().c_str());

        for (itr = threatList.begin(); itr != threatList.end(); ++itr)
        {
            Unit* unit = (*itr)->getTarget();
            if (!unit)
            {
                handler->PSendSysMessage("   %u.   No Unit  - threat %f", ++count, (*itr)->GetThreat());
                continue;
            }

            handler->PSendSysMessage("   %u.   %s   (%s)  - threat %f", ++count, unit->GetName().c_str(), unit->GetGUID().ToString().c_str(), (*itr)->GetThreat());
        }

        auto const& threatList2 = target->GetThreatMgr().GetOfflineThreatList();
        for (itr = threatList2.begin(); itr != threatList2.end(); ++itr)
        {
            Unit* unit = (*itr)->getTarget();
            if (!unit)
            {
                handler->PSendSysMessage("   %u.   [offline] No Unit  - threat %f", ++count, (*itr)->GetThreat());
                continue;
            }

            handler->PSendSysMessage("   %u.   [offline] %s   (%s)  - threat %f", ++count, unit->GetName().c_str(), unit->GetGUID().ToString().c_str(), (*itr)->GetThreat());
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

        handler->PSendSysMessage("Hostile reference list of %s (%s)", target->GetName().c_str(), target->GetGUID().ToString().c_str());

        while (ref)
        {
            if (Unit* unit = ref->GetSource()->GetOwner())
            {
                handler->PSendSysMessage("   %u.   %s %s   (%s)  - threat %f", ++count, (ref->IsOnline() ? "" : "[offline]"),
                    unit->GetName().c_str(), unit->GetGUID().ToString().c_str(), ref->GetThreat());
            }
            else
            {
                handler->PSendSysMessage("   %u.   No Owner  - threat %f", ++count, ref->GetThreat());
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
        handler->PSendSysMessage("Vehicle id set to %u", id);
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
            Cell::VisitAllObjects(handler->GetPlayer(), searcher, 30.0f);

            if (!passenger || passenger == target)
                return false;

            passenger->EnterVehicle(target, *seatId);
        }

        handler->PSendSysMessage("Unit %u entered vehicle %hhd", entry, *seatId);
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

        handler->PSendSysMessage("Item %u: value at %u is %u", guid, index, value);

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

        handler->PSendSysMessage("Playing emote %s", EnumUtils::ToConstant(emote));

        return true;
    }

    static bool HandleDebugLoSCommand(ChatHandler* handler)
    {
        if (Unit* unit = handler->getSelectedUnit())
        {
            Player* player = handler->GetSession()->GetPlayer();
            handler->PSendSysMessage("Checking LoS %s -> %s:", player->GetName().c_str(), unit->GetName().c_str());
            handler->PSendSysMessage("    VMAP LoS: %s", player->IsWithinLOSInMap(unit, VMAP::ModelIgnoreFlags::Nothing, LINEOFSIGHT_CHECK_VMAP) ? "clear" : "obstructed");
            handler->PSendSysMessage("    GObj LoS: %s", player->IsWithinLOSInMap(unit, VMAP::ModelIgnoreFlags::Nothing, LINEOFSIGHT_CHECK_GOBJECT_ALL) ? "clear" : "obstructed");
            handler->PSendSysMessage("%s is %sin line of sight of %s.", unit->GetName().c_str(), (player->IsWithinLOSInMap(unit) ? "" : "not "), player->GetName().c_str());
            return true;
        }

        return false;
    }

    static bool HandleDebugSetAuraStateCommand(ChatHandler* handler, Optional<AuraStateType> state, bool apply)
    {
        Unit* unit = handler->getSelectedUnit();
        if (!unit)
        {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
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
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (index >= target->GetValuesCount())
        {
            handler->PSendSysMessage(LANG_TOO_BIG_INDEX, index, target->GetGUID().GetCounter(), target->GetValuesCount());
            return false;
        }

        if (value.holds_alternative<uint32>())
        {
            target->SetUInt32Value(index, value.get<uint32>());
            handler->PSendSysMessage(LANG_SET_UINT_FIELD, target->GetGUID().GetCounter(), uint32(index), uint32(value));
        }
        else if (value.holds_alternative<float>())
        {
            target->SetFloatValue(index, value.get<float>());
            handler->PSendSysMessage(LANG_SET_FLOAT_FIELD, target->GetGUID().GetCounter(), static_cast<float>(index), uint32(value));
        }

        return true;
    }

    static bool HandleDebugGetValueCommand(ChatHandler* handler, uint32 index, bool isInt)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target)
        {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        ObjectGuid guid = target->GetGUID();

        if (index >= target->GetValuesCount())
        {
            handler->PSendSysMessage(LANG_TOO_BIG_INDEX, index, guid.GetCounter(), target->GetValuesCount());
            return false;
        }

        if (isInt)
        {
            uint32 value = target->GetUInt32Value(index);
            handler->PSendSysMessage(LANG_GET_UINT_FIELD, guid.GetCounter(), index, value);
        }
        else
        {
            float value = target->GetFloatValue(index);
            handler->PSendSysMessage(LANG_GET_FLOAT_FIELD, guid.GetCounter(), index, value);
        }

        return true;
    }

    static bool HandleDebugMod32ValueCommand(ChatHandler* handler, uint32 index, uint32 value)
    {
        if (index >= handler->GetPlayer()->GetValuesCount())
        {
            handler->PSendSysMessage(LANG_TOO_BIG_INDEX, index, handler->GetPlayer()->GetGUID().GetCounter(), handler->GetPlayer()->GetValuesCount());
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
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!index)
            return true;

        // check index
        if (unit->GetTypeId() == TYPEID_PLAYER)
        {
            if (index >= PLAYER_END)
                return true;
        }
        else if (index >= UNIT_END)
            return true;

        if (!value)
        {
            value = unit->GetUInt32Value(index);

            handler->PSendSysMessage(LANG_UPDATE, unit->GetGUID().GetCounter(), index, *value);
            return true;
        }

        unit->SetUInt32Value(index, *value);

        handler->PSendSysMessage(LANG_UPDATE_CHANGE, unit->GetGUID().GetCounter(), index, *value);
        return true;
    }

    static bool HandleDebugSet32BitCommand(ChatHandler* handler, uint32 index, uint8 bit)
    {
        WorldObject* target = handler->getSelectedObject();
        if (!target)
        {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
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

    static bool HandleWPGPSCommand(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();

        LOG_INFO("sql.dev", "(@PATH, XX, {0:.3f}, {0:.3f}, {0:.5f}, 0,0, 0,100, 0),", player->GetPositionX(), player->GetPositionY(), player->GetPositionZ());

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
        handler->PSendSysMessage("Map Id: %u Name: '%s' Instance Id: %u Creatures: %u GameObjects: %u SetActive Objects: %u",
                map->GetId(), map->GetMapName(), map->GetInstanceId(),
                uint64(map->GetObjectsStore().Size<Creature>()),
                uint64(map->GetObjectsStore().Size<GameObject>()),
                uint64(map->GetActiveNonPlayersCount()));

        CreatureCountWorker worker;
        TypeContainerVisitor<CreatureCountWorker, MapStoredObjectTypesContainer> visitor(worker);
        visitor.Visit(map->GetObjectsStore());

        handler->PSendSysMessage("Top Creatures count:");

        for (auto&& p : worker.GetTopCreatureCount(5))
            handler->PSendSysMessage("Entry: %u Count: %u", p.first, p.second);
    }

    static bool HandleDebugDummyCommand(ChatHandler* handler)
    {
        handler->SendSysMessage("This command does nothing right now. Edit your local core (cs_debug.cpp) to make it do whatever you need for testing.");
        return true;
    }
};

void AddSC_debug_commandscript()
{
    new debug_commandscript();
}
