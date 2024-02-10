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
#include "CommandScript.h"
#include "CreatureAI.h"
#include "CreatureGroups.h"
#include "GameTime.h"
#include "Language.h"
#include "ObjectMgr.h"
#include "Pet.h"
#include "Player.h"
#include "TargetedMovementGenerator.h"                      // for HandleNpcUnFollowCommand
#include "Transport.h"
#include <string>

using namespace Acore::ChatCommands;

using CreatureSpawnId = Variant<Hyperlink<creature>, ObjectGuid::LowType>;
using CreatureEntry = Variant<Hyperlink<creature_entry>, uint32>;

struct NpcFlagText
{
    uint32 flag;
    int32 text;
};

#define NPCFLAG_COUNT   24

NpcFlagText const npcFlagTexts[NPCFLAG_COUNT] =
{
    { UNIT_NPC_FLAG_AUCTIONEER,         LANG_NPCINFO_AUCTIONEER         },
    { UNIT_NPC_FLAG_BANKER,             LANG_NPCINFO_BANKER             },
    { UNIT_NPC_FLAG_BATTLEMASTER,       LANG_NPCINFO_BATTLEMASTER       },
    { UNIT_NPC_FLAG_FLIGHTMASTER,       LANG_NPCINFO_FLIGHTMASTER       },
    { UNIT_NPC_FLAG_GOSSIP,             LANG_NPCINFO_GOSSIP             },
    { UNIT_NPC_FLAG_GUILD_BANKER,       LANG_NPCINFO_GUILD_BANKER       },
    { UNIT_NPC_FLAG_INNKEEPER,          LANG_NPCINFO_INNKEEPER          },
    { UNIT_NPC_FLAG_PETITIONER,         LANG_NPCINFO_PETITIONER         },
    { UNIT_NPC_FLAG_PLAYER_VEHICLE,     LANG_NPCINFO_PLAYER_VEHICLE     },
    { UNIT_NPC_FLAG_QUESTGIVER,         LANG_NPCINFO_QUESTGIVER         },
    { UNIT_NPC_FLAG_REPAIR,             LANG_NPCINFO_REPAIR             },
    { UNIT_NPC_FLAG_SPELLCLICK,         LANG_NPCINFO_SPELLCLICK         },
    { UNIT_NPC_FLAG_SPIRITGUIDE,        LANG_NPCINFO_SPIRITGUIDE        },
    { UNIT_NPC_FLAG_SPIRITHEALER,       LANG_NPCINFO_SPIRITHEALER       },
    { UNIT_NPC_FLAG_STABLEMASTER,       LANG_NPCINFO_STABLEMASTER       },
    { UNIT_NPC_FLAG_TABARDDESIGNER,     LANG_NPCINFO_TABARDDESIGNER     },
    { UNIT_NPC_FLAG_TRAINER,            LANG_NPCINFO_TRAINER            },
    { UNIT_NPC_FLAG_TRAINER_CLASS,      LANG_NPCINFO_TRAINER_CLASS      },
    { UNIT_NPC_FLAG_TRAINER_PROFESSION, LANG_NPCINFO_TRAINER_PROFESSION },
    { UNIT_NPC_FLAG_VENDOR,             LANG_NPCINFO_VENDOR             },
    { UNIT_NPC_FLAG_VENDOR_AMMO,        LANG_NPCINFO_VENDOR_AMMO        },
    { UNIT_NPC_FLAG_VENDOR_FOOD,        LANG_NPCINFO_VENDOR_FOOD        },
    { UNIT_NPC_FLAG_VENDOR_POISON,      LANG_NPCINFO_VENDOR_POISON      },
    { UNIT_NPC_FLAG_VENDOR_REAGENT,     LANG_NPCINFO_VENDOR_REAGENT     }
};

struct MechanicImmune
{
    uint32 flag;
    char const* text;
};

MechanicImmune const mechanicImmunes[MAX_MECHANIC] =
{
    { MECHANIC_NONE,            "MECHANIC_NONE"               },
    { MECHANIC_CHARM,           "MECHANIC_CHARM"              },
    { MECHANIC_DISORIENTED,     "MECHANIC_DISORIENTED"        },
    { MECHANIC_DISARM,          "MECHANIC_DISARM"             },
    { MECHANIC_DISTRACT,        "MECHANIC_DISTRACT"           },
    { MECHANIC_FEAR,            "MECHANIC_FEAR"               },
    { MECHANIC_GRIP,            "MECHANIC_GRIP"               },
    { MECHANIC_ROOT,            "MECHANIC_ROOT"               },
    { MECHANIC_SLOW_ATTACK,     "MECHANIC_SLOW_ATTACK"        },
    { MECHANIC_SILENCE,         "MECHANIC_SILENCE"            },
    { MECHANIC_SLEEP,           "MECHANIC_SLEEP"              },
    { MECHANIC_SNARE,           "MECHANIC_SNARE"              },
    { MECHANIC_STUN,            "MECHANIC_STUN"               },
    { MECHANIC_FREEZE,          "MECHANIC_FREEZE"             },
    { MECHANIC_KNOCKOUT,        "MECHANIC_KNOCKOUT"           },
    { MECHANIC_BLEED,           "MECHANIC_BLEED"              },
    { MECHANIC_BANDAGE,         "MECHANIC_BANDAGE"            },
    { MECHANIC_POLYMORPH,       "MECHANIC_POLYMORPH"          },
    { MECHANIC_BANISH,          "MECHANIC_BANISH"             },
    { MECHANIC_SHIELD,          "MECHANIC_SHIELD"             },
    { MECHANIC_SHACKLE,         "MECHANIC_SHACKLE"            },
    { MECHANIC_MOUNT,           "MECHANIC_MOUNT"              },
    { MECHANIC_INFECTED,        "MECHANIC_INFECTED"           },
    { MECHANIC_TURN,            "MECHANIC_TURN"               },
    { MECHANIC_HORROR,          "MECHANIC_HORROR"             },
    { MECHANIC_INVULNERABILITY, "MECHANIC_INVULNERABILITY"    },
    { MECHANIC_INTERRUPT,       "MECHANIC_INTERRUPT"          },
    { MECHANIC_DAZE,            "MECHANIC_DAZE"               },
    { MECHANIC_DISCOVERY,       "MECHANIC_DISCOVERY"          },
    { MECHANIC_IMMUNE_SHIELD,   "MECHANIC_IMMUNE_SHIELD"      },
    { MECHANIC_SAPPED,          "MECHANIC_SAPPED"             },
    { MECHANIC_ENRAGED,         "MECHANIC_ENRAGED"            },
};

struct SpellSchoolImmune
{
    uint32 flag;
    char const* text;
};

SpellSchoolImmune const spellSchoolImmunes[MAX_SPELL_SCHOOL] =
{
    { SPELL_SCHOOL_NORMAL, "SPELL_SCHOOL_NORMAL" },
    { SPELL_SCHOOL_HOLY,   "SPELL_SCHOOL_HOLY"   },
    { SPELL_SCHOOL_FIRE,   "SPELL_SCHOOL_FIRE"   },
    { SPELL_SCHOOL_NATURE, "SPELL_SCHOOL_NATURE" },
    { SPELL_SCHOOL_FROST,  "SPELL_SCHOOL_FROST"  },
    { SPELL_SCHOOL_SHADOW, "SPELL_SCHOOL_SHADOW" },
    { SPELL_SCHOOL_ARCANE, "SPELL_SCHOOL_ARCANE" },
};

class npc_commandscript : public CommandScript
{
public:
    npc_commandscript() : CommandScript("npc_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable npcAddCommandTable =
        {
            { "formation",      HandleNpcAddFormationCommand,      SEC_ADMINISTRATOR, Console::No },
            { "item",           HandleNpcAddVendorItemCommand,     SEC_ADMINISTRATOR, Console::No },
            { "move",           HandleNpcAddMoveCommand,           SEC_ADMINISTRATOR, Console::No },
            { "temp",           HandleNpcAddTempSpawnCommand,      SEC_ADMINISTRATOR, Console::No },
            { "",               HandleNpcAddCommand,               SEC_ADMINISTRATOR, Console::No }
        };
        static ChatCommandTable npcDeleteCommandTable =
        {
            { "item",           HandleNpcDeleteVendorItemCommand,  SEC_ADMINISTRATOR, Console::No },
            { "",               HandleNpcDeleteCommand,            SEC_ADMINISTRATOR, Console::No }
        };
        static ChatCommandTable npcFollowCommandTable =
        {
            { "stop",           HandleNpcUnFollowCommand,          SEC_GAMEMASTER, Console::No },
            { "",               HandleNpcFollowCommand,            SEC_GAMEMASTER, Console::No }
        };

        static ChatCommandTable npcFactionCommandTable =
        {
            { "permanent",      HandleNpcSetFactionIdCommand,      SEC_ADMINISTRATOR, Console::No },
            { "temp",           HandleNpcSetFactionTempIdCommand,  SEC_ADMINISTRATOR, Console::No },
            { "original",       HandleNpcSetOriginalFaction,       SEC_ADMINISTRATOR, Console::No }
        };

        static ChatCommandTable npcSetCommandTable =
        {
            { "allowmove",      HandleNpcSetAllowMovementCommand,  SEC_ADMINISTRATOR, Console::No },
            { "entry",          HandleNpcSetEntryCommand,          SEC_ADMINISTRATOR, Console::No },
            { "faction",        npcFactionCommandTable},
            { "flag",           HandleNpcSetFlagCommand,           SEC_ADMINISTRATOR, Console::No },
            { "level",          HandleNpcSetLevelCommand,          SEC_ADMINISTRATOR, Console::No },
            { "link",           HandleNpcSetLinkCommand,           SEC_ADMINISTRATOR, Console::No },
            { "model",          HandleNpcSetModelCommand,          SEC_ADMINISTRATOR, Console::No },
            { "movetype",       HandleNpcSetMoveTypeCommand,       SEC_ADMINISTRATOR, Console::No },
            { "phase",          HandleNpcSetPhaseCommand,          SEC_ADMINISTRATOR, Console::No },
            { "wanderdistance", HandleNpcSetWanderDistanceCommand, SEC_ADMINISTRATOR, Console::No },
            { "spawntime",      HandleNpcSetSpawnTimeCommand,      SEC_ADMINISTRATOR, Console::No },
            { "data",           HandleNpcSetDataCommand,           SEC_ADMINISTRATOR, Console::No }
        };
        static ChatCommandTable npcCommandTable =
        {
            { "info",           HandleNpcInfoCommand,              SEC_GAMEMASTER, Console::No },
            { "guid",           HandleNpcGuidCommand,              SEC_GAMEMASTER, Console::No },
            { "near",           HandleNpcNearCommand,              SEC_GAMEMASTER, Console::No },
            { "move",           HandleNpcMoveCommand,              SEC_GAMEMASTER, Console::No },
            { "playemote",      HandleNpcPlayEmoteCommand,         SEC_GAMEMASTER, Console::No },
            { "say",            HandleNpcSayCommand,               SEC_GAMEMASTER, Console::No },
            { "textemote",      HandleNpcTextEmoteCommand,         SEC_GAMEMASTER, Console::No },
            { "whisper",        HandleNpcWhisperCommand,           SEC_GAMEMASTER, Console::No },
            { "yell",           HandleNpcYellCommand,              SEC_GAMEMASTER, Console::No },
            { "tame",           HandleNpcTameCommand,              SEC_GAMEMASTER, Console::No },
            { "add",            npcAddCommandTable },
            { "delete",         npcDeleteCommandTable },
            { "follow",         npcFollowCommandTable },
            { "set",            npcSetCommandTable }
        };
        static ChatCommandTable commandTable =
        {
            { "npc", npcCommandTable }
        };
        return commandTable;
    }

    //add spawn of creature
    static bool HandleNpcAddCommand(ChatHandler* handler, CreatureEntry id)
    {
        if (!sObjectMgr->GetCreatureTemplate(id))
            return false;

        //npcbot
        CreatureTemplate const* cinfo = sObjectMgr->GetCreatureTemplate(id);
        if (cinfo && cinfo->IsNPCBotOrPet())
        {
            handler->PSendSysMessage("You tried to spawn creature %u, which is part of NPCBots mod. To spawn bots use '.npcbot spawn' instead.", uint32(id));
            handler->SetSentErrorMessage(true);
            return false;
        }
        //end npcbot

        Player* chr = handler->GetSession()->GetPlayer();
        float x = chr->GetPositionX();
        float y = chr->GetPositionY();
        float z = chr->GetPositionZ();
        float o = chr->GetOrientation();
        Map* map = chr->GetMap();

        if (Transport* tt = chr->GetTransport())
            if (MotionTransport* trans = tt->ToMotionTransport())
            {
                ObjectGuid::LowType guid = sObjectMgr->GenerateCreatureSpawnId();
                CreatureData& data = sObjectMgr->NewOrExistCreatureData(guid);
                data.id1 = id;
                data.phaseMask = chr->GetPhaseMaskForSpawn();
                data.posX = chr->GetTransOffsetX();
                data.posY = chr->GetTransOffsetY();
                data.posZ = chr->GetTransOffsetZ();
                data.orientation = chr->GetTransOffsetO();

                Creature* creature = trans->CreateNPCPassenger(guid, &data);

                creature->SaveToDB(trans->GetGOInfo()->moTransport.mapID, 1 << map->GetSpawnMode(), chr->GetPhaseMaskForSpawn());

                sObjectMgr->AddCreatureToGrid(guid, &data);
                return true;
            }

        Creature* creature = new Creature();
        if (!creature->Create(map->GenerateLowGuid<HighGuid::Unit>(), map, chr->GetPhaseMaskForSpawn(), id, 0, x, y, z, o))
        {
            delete creature;
            return false;
        }

        creature->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), chr->GetPhaseMaskForSpawn());

        ObjectGuid::LowType spawnId = creature->GetSpawnId();

        // To call _LoadGoods(); _LoadQuests(); CreateTrainerSpells()
        // current "creature" variable is deleted and created fresh new, otherwise old values might trigger asserts or cause undefined behavior
        creature->CleanupsBeforeDelete();
        delete creature;
        creature = new Creature();
        if (!creature->LoadCreatureFromDB(spawnId, map, true, true))
        {
            delete creature;
            return false;
        }

        sObjectMgr->AddCreatureToGrid(spawnId, sObjectMgr->GetCreatureData(spawnId));
        return true;
    }

    //add item in vendorlist
    static bool HandleNpcAddVendorItemCommand(ChatHandler* handler, ItemTemplate const* item, Optional<uint32> mc, Optional<uint32> it, Optional<uint32> ec, Optional<bool> addMulti)
    {
        if (!item)
        {
            handler->SendErrorMessage(LANG_COMMAND_NEEDITEMSEND);
            return false;
        }

        Creature* vendor = handler->getSelectedCreature();
        if (!vendor)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        uint32 itemId = item->ItemId;
        uint32 maxcount = mc.value_or(0);
        uint32 incrtime = it.value_or(0);
        uint32 extendedcost = ec.value_or(0);
        uint32 vendor_entry = addMulti.value_or(false) ? handler->GetSession()->GetCurrentVendor() : vendor->GetEntry();

        if (!sObjectMgr->IsVendorItemValid(vendor_entry, itemId, maxcount, incrtime, extendedcost, handler->GetSession()->GetPlayer()))
        {
            handler->SetSentErrorMessage(true);
            return false;
        }

        sObjectMgr->AddVendorItem(vendor_entry, itemId, maxcount, incrtime, extendedcost);

        handler->PSendSysMessage(LANG_ITEM_ADDED_TO_LIST, itemId, item->Name1.c_str(), maxcount, incrtime, extendedcost);
        return true;
    }

    //add move for creature
    static bool HandleNpcAddMoveCommand(ChatHandler* handler, CreatureSpawnId lowGuid)
    {
        // attempt check creature existence by DB data
        CreatureData const* data = sObjectMgr->GetCreatureData(lowGuid);
        if (!data)
        {
            handler->SendErrorMessage(LANG_COMMAND_CREATGUIDNOTFOUND, uint32(lowGuid));
            return false;
        }

        // Update movement type
        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_UPD_CREATURE_MOVEMENT_TYPE);
        stmt->SetData(0, uint8(WAYPOINT_MOTION_TYPE));
        stmt->SetData(1, uint32(lowGuid));
        WorldDatabase.Execute(stmt);

        handler->SendSysMessage(LANG_WAYPOINT_ADDED);

        return true;
    }

    static bool HandleNpcSetAllowMovementCommand(ChatHandler* handler)
    {
        if (sWorld->getAllowMovement())
        {
            sWorld->SetAllowMovement(false);
            handler->SendSysMessage(LANG_CREATURE_MOVE_DISABLED);
        }
        else
        {
            sWorld->SetAllowMovement(true);
            handler->SendSysMessage(LANG_CREATURE_MOVE_ENABLED);
        }
        return true;
    }

    static bool HandleNpcSetEntryCommand(ChatHandler* handler, CreatureEntry newEntryNum)
    {
        if (!newEntryNum)
            return false;

        Unit* unit = handler->getSelectedUnit();
        if (!unit || unit->GetTypeId() != TYPEID_UNIT)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }
        Creature* creature = unit->ToCreature();
        if (creature->UpdateEntry(newEntryNum))
            handler->SendSysMessage(LANG_DONE);
        else
            handler->SendSysMessage(LANG_ERROR);
        return true;
    }

    //change level of creature or pet
    static bool HandleNpcSetLevelCommand(ChatHandler* handler, uint8 lvl)
    {
        if (lvl < 1 || lvl > sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL) + 3)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        Creature* creature = handler->getSelectedCreature();
        if (!creature || creature->IsPet())
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        creature->SetMaxHealth(100 + 30*lvl);
        creature->SetHealth(100 + 30*lvl);
        creature->SetLevel(lvl);
        creature->SaveToDB();

        return true;
    }

    static bool HandleNpcDeleteCommand(ChatHandler* handler)
    {
        Creature* unit = handler->getSelectedCreature();

        if (!unit || unit->IsPet() || unit->IsTotem())
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        //npcbot
        if (unit->IsNPCBotOrPet())
        {
            handler->SendSysMessage("Selected creature has botAI assigned, use '.npcbot delete' instead");
            handler->SetSentErrorMessage(true);
            return false;
        }
        //end npcbot

        // Delete the creature
        unit->CombatStop();
        unit->DeleteFromDB();
        unit->AddObjectToRemoveList();

        handler->SendSysMessage(LANG_COMMAND_DELCREATMESSAGE);

        return true;
    }

    //del item from vendor list
    static bool HandleNpcDeleteVendorItemCommand(ChatHandler* handler, ItemTemplate const* item, Optional<bool> addMulti)
    {
        Creature* vendor = handler->getSelectedCreature();
        if (!vendor || !vendor->IsVendor())
        {
            handler->SendErrorMessage(LANG_COMMAND_VENDORSELECTION);
            return false;
        }

        if (!item)
        {
            handler->SendErrorMessage(LANG_COMMAND_NEEDITEMSEND);
            return false;
        }

        uint32 itemId = item->ItemId;
        if (!sObjectMgr->RemoveVendorItem(addMulti.value_or(false) ? handler->GetSession()->GetCurrentVendor() : vendor->GetEntry(), itemId))
        {
            handler->SendErrorMessage(LANG_ITEM_NOT_IN_LIST, itemId);
            return false;
        }

        handler->PSendSysMessage(LANG_ITEM_DELETED_FROM_LIST, itemId, item->Name1.c_str());
        return true;
    }

    //set faction of creature
    static bool HandleNpcSetFactionIdCommand(ChatHandler* handler, uint32 factionId)
    {
        if (!sFactionTemplateStore.LookupEntry(factionId))
        {
            handler->SendErrorMessage(LANG_WRONG_FACTION, factionId);
            return false;
        }

        Creature* creature = handler->getSelectedCreature();

        if (!creature)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        creature->SetFaction(factionId);

        // Faction is set in creature_template - not inside creature

        // Update in memory..
        if (CreatureTemplate const* cinfo = creature->GetCreatureTemplate())
            const_cast<CreatureTemplate*>(cinfo)->faction = factionId;

        // ..and DB
        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_UPD_CREATURE_FACTION);

        stmt->SetData(0, uint16(factionId));
        stmt->SetData(1, creature->GetEntry());

        WorldDatabase.Execute(stmt);

        return true;
    }

    //set tempfaction for creature
    static bool HandleNpcSetFactionTempIdCommand(ChatHandler* handler, uint32 tempfaction)
    {
        Player* player = handler->GetSession()->GetPlayer();
        Unit* unit = player->GetSelectedUnit();

        if (!unit)
            return false;

        Creature* creature = unit->ToCreature();

        if (!creature)
            return false;

        creature->SetFaction(tempfaction);

        return true;
    }

    //set orginal faction for npc
    static bool HandleNpcSetOriginalFaction(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();

        if (!player)
            return false;

        Creature* creature = player->GetSelectedUnit()->ToCreature();

        if (!creature)
            return false;

        creature->RestoreFaction();

        return true;
    }

    //set npcflag of creature
    static bool HandleNpcSetFlagCommand(ChatHandler* handler, uint32 npcFlags)
    {
        Creature* creature = handler->getSelectedCreature();

        if (!creature)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        creature->ReplaceAllNpcFlags(NPCFlags(npcFlags));

        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_UPD_CREATURE_NPCFLAG);

        stmt->SetData(0, NPCFlags(npcFlags));
        stmt->SetData(1, creature->GetEntry());

        WorldDatabase.Execute(stmt);

        handler->SendSysMessage(LANG_VALUE_SAVED_REJOIN);

        return true;
    }

    //set data of creature for testing scripting
    static bool HandleNpcSetDataCommand(ChatHandler* handler, uint32 data_1, uint32 data_2)
    {
        Creature* creature = handler->getSelectedCreature();

        if (!creature)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        creature->AI()->SetData(data_1, data_2);
        std::string AIorScript = !creature->GetAIName().empty() ? "AI type: " + creature->GetAIName() : (!creature->GetScriptName().empty() ? "Script Name: " + creature->GetScriptName() : "No AI or Script Name Set");
        handler->PSendSysMessage(LANG_NPC_SETDATA, creature->GetGUID().GetCounter(), creature->GetEntry(), creature->GetName().c_str(), data_1, data_2, AIorScript.c_str());
        return true;
    }

    //npc follow handling
    static bool HandleNpcFollowCommand(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();
        Creature* creature = handler->getSelectedCreature();

        if (!creature)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        // Follow player - Using pet's default dist and angle
        creature->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, creature->GetFollowAngle());

        handler->PSendSysMessage(LANG_CREATURE_FOLLOW_YOU_NOW, creature->GetName().c_str());
        return true;
    }

    static bool HandleNpcInfoCommand(ChatHandler* handler)
    {
        Creature* target = handler->getSelectedCreature();

        if (!target)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        CreatureTemplate const* cInfo = target->GetCreatureTemplate();
        uint32 faction = target->GetFaction();
        uint32 npcflags = target->GetNpcFlags();
        uint32 mechanicImmuneMask = cInfo->MechanicImmuneMask;
        uint32 spellSchoolImmuneMask = cInfo->SpellSchoolImmuneMask;
        uint32 displayid = target->GetDisplayId();
        uint32 nativeid = target->GetNativeDisplayId();
        uint32 entry = target->GetEntry();
        uint32 id1 = 0;
        uint32 id2 = 0;
        uint32 id3 = 0;
        if (CreatureData const* cData = target->GetCreatureData())
        {
            id1 = cData->id1;
            id2 = cData->id2;
            id3 = cData->id3;
        }

        int64 curRespawnDelay = target->GetRespawnTimeEx() - GameTime::GetGameTime().count();
        if (curRespawnDelay < 0)
            curRespawnDelay = 0;
        std::string curRespawnDelayStr = secsToTimeString(uint64(curRespawnDelay), true);
        std::string defRespawnDelayStr = secsToTimeString(target->GetRespawnDelay(), true);

        handler->PSendSysMessage(LANG_NPCINFO_CHAR,  target->GetSpawnId(), target->GetGUID().GetCounter(), entry, id1, id2, id3, displayid, nativeid, faction, npcflags);
        handler->PSendSysMessage(LANG_NPCINFO_LEVEL, target->GetLevel());
        handler->PSendSysMessage(LANG_NPCINFO_EQUIPMENT, target->GetCurrentEquipmentId(), target->GetOriginalEquipmentId());
        handler->PSendSysMessage(LANG_NPCINFO_HEALTH, target->GetCreateHealth(), target->GetMaxHealth(), target->GetHealth());
        handler->PSendSysMessage(LANG_NPCINFO_FLAGS, target->GetUnitFlags(), target->GetUnitFlags2(), target->GetDynamicFlags(), target->GetFaction());
        handler->PSendSysMessage(LANG_COMMAND_RAWPAWNTIMES, defRespawnDelayStr.c_str(), curRespawnDelayStr.c_str());
        handler->PSendSysMessage(LANG_NPCINFO_LOOT,  cInfo->lootid, cInfo->pickpocketLootId, cInfo->SkinLootId);
        handler->PSendSysMessage(LANG_NPCINFO_DUNGEON_ID, target->GetInstanceId());
        handler->PSendSysMessage(LANG_NPCINFO_PHASEMASK, target->GetPhaseMask());
        handler->PSendSysMessage(LANG_NPCINFO_ARMOR, target->GetArmor());
        handler->PSendSysMessage(LANG_NPCINFO_POSITION, float(target->GetPositionX()), float(target->GetPositionY()), float(target->GetPositionZ()));
        handler->PSendSysMessage(LANG_NPCINFO_AIINFO, target->GetAIName().c_str(), target->GetScriptName().c_str());

        for (uint8 i = 0; i < NPCFLAG_COUNT; i++)
        {
            if (npcflags & npcFlagTexts[i].flag)
            {
                handler->PSendSysMessage(npcFlagTexts[i].text, npcFlagTexts[i].flag);
            }
        }

        handler->PSendSysMessage(LANG_NPCINFO_MECHANIC_IMMUNE, mechanicImmuneMask);
        for (uint8 i = 1; i < MAX_MECHANIC; ++i)
        {
            if (mechanicImmuneMask & (1 << (mechanicImmunes[i].flag - 1)))
            {
                handler->PSendSysMessage(mechanicImmunes[i].text, mechanicImmunes[i].flag);
            }
        }

        handler->PSendSysMessage(LANG_NPCINFO_SPELL_SCHOOL_IMMUNE, spellSchoolImmuneMask);
        for (uint8 i = 0; i < MAX_SPELL_SCHOOL; ++i)
        {
            if (spellSchoolImmuneMask & (1 << spellSchoolImmunes[i].flag))
            {
                handler->PSendSysMessage(spellSchoolImmunes[i].text, spellSchoolImmunes[i].flag);
            }
        }

        return true;
    }
    static bool HandleNpcGuidCommand(ChatHandler* handler)
    {
        Creature* target = handler->getSelectedCreature();

        if (!target)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        uint32 faction = target->GetFaction();
        uint32 npcflags = target->GetNpcFlags();
        uint32 displayid = target->GetDisplayId();
        uint32 nativeid = target->GetNativeDisplayId();
        uint32 entry = target->GetEntry();
        uint32 id1 = 0;
        uint32 id2 = 0;
        uint32 id3 = 0;
        if (CreatureData const* cData = target->GetCreatureData())
        {
            id1 = cData->id1;
            id2 = cData->id2;
            id3 = cData->id3;
        }

        handler->PSendSysMessage(LANG_NPCINFO_CHAR, target->GetSpawnId(), target->GetGUID().GetCounter(), entry, id1, id2, id3, displayid, nativeid, faction, npcflags);

        return true;
    }

    static bool HandleNpcNearCommand(ChatHandler* handler, Optional<float> dist)
    {
        float distance = dist.value_or(10.0f);
        uint32 count = 0;

        Player* player = handler->GetSession()->GetPlayer();

        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_CREATURE_NEAREST);
        stmt->SetData(0, player->GetPositionX());
        stmt->SetData(1, player->GetPositionY());
        stmt->SetData(2, player->GetPositionZ());
        stmt->SetData(3, player->GetMapId());
        stmt->SetData(4, player->GetPositionX());
        stmt->SetData(5, player->GetPositionY());
        stmt->SetData(6, player->GetPositionZ());
        stmt->SetData(7, distance * distance);
        stmt->SetData(8, player->GetPhaseMask());
        PreparedQueryResult result = WorldDatabase.Query(stmt);

        if (result)
        {
            do
            {
                Field* fields = result->Fetch();
                ObjectGuid::LowType guid = fields[0].Get<uint32>();
                uint32 entry = fields[1].Get<uint32>();
                //uint32 entry2 = fields[2].Get<uint32>();
                float x = fields[3].Get<float>();
                float y = fields[4].Get<float>();
                float z = fields[5].Get<float>();
                uint16 mapId = fields[6].Get<uint16>();

                CreatureTemplate const* creatureTemplate = sObjectMgr->GetCreatureTemplate(entry);
                if (!creatureTemplate)
                    continue;

                handler->PSendSysMessage(LANG_CREATURE_LIST_CHAT, guid, entry, guid, creatureTemplate->Name.c_str(), x, y, z, mapId, "", "");

                ++count;
            } while (result->NextRow());
        }

        handler->PSendSysMessage(LANG_COMMAND_NEAR_NPC_MESSAGE, distance, count);

        return true;
    }

    //move selected creature
    static bool HandleNpcMoveCommand(ChatHandler* handler)
    {
        Creature* creature = handler->getSelectedCreature();

        if (!creature)
            return false;

        ObjectGuid::LowType lowguid = creature->GetSpawnId();

        CreatureData const* data = sObjectMgr->GetCreatureData(lowguid);
        if (!data)
        {
            handler->SendErrorMessage(LANG_COMMAND_CREATGUIDNOTFOUND, lowguid);
            return false;
        }

        if (handler->GetSession()->GetPlayer()->GetMapId() != data->mapid)
        {
            handler->SendErrorMessage(LANG_COMMAND_CREATUREATSAMEMAP, lowguid);
            return false;
        }

        //npcbot
        CreatureTemplate const* ct = sObjectMgr->GetCreatureTemplate(creature->GetEntry());
        ASSERT(ct);
        if (ct->IsNPCBotOrPet())
        {
            handler->PSendSysMessage("creature %u (id %u) is a part of NPCBots mod. Use '.npcbot move' instead", lowguid, creature->GetEntry());
            handler->SetSentErrorMessage(true);
            return false;
        }
        //end npcbot

        float x = handler->GetSession()->GetPlayer()->GetPositionX();
        float y = handler->GetSession()->GetPlayer()->GetPositionY();
        float z = handler->GetSession()->GetPlayer()->GetPositionZ();
        float o = handler->GetSession()->GetPlayer()->GetOrientation();

        if (creature)
        {
            if (CreatureData const* data = sObjectMgr->GetCreatureData(creature->GetSpawnId()))
            {
                const_cast<CreatureData*>(data)->posX = x;
                const_cast<CreatureData*>(data)->posY = y;
                const_cast<CreatureData*>(data)->posZ = z;
                const_cast<CreatureData*>(data)->orientation = o;
            }

            creature->SetPosition(x, y, z, o);
            creature->GetMotionMaster()->Initialize();

            if (creature->IsAlive())                            // dead creature will reset movement generator at respawn
            {
                creature->setDeathState(DeathState::JustDied);
                creature->Respawn();
            }
        }

        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_UPD_CREATURE_POSITION);
        stmt->SetData(0, x);
        stmt->SetData(1, y);
        stmt->SetData(2, z);
        stmt->SetData(3, o);
        stmt->SetData(4, lowguid);

        WorldDatabase.Execute(stmt);

        handler->PSendSysMessage(LANG_COMMAND_CREATUREMOVED);
        return true;
    }

    //play npc emote
    static bool HandleNpcPlayEmoteCommand(ChatHandler* handler, uint32 emote)
    {
        Creature* target = handler->getSelectedCreature();
        if (!target)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        target->SetUInt32Value(UNIT_NPC_EMOTESTATE, emote);

        return true;
    }

    //set model of creature
    static bool HandleNpcSetModelCommand(ChatHandler* handler, uint32 displayId)
    {
        Creature* creature = handler->getSelectedCreature();

        if (!creature || creature->IsPet())
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        if (!sCreatureDisplayInfoStore.LookupEntry(displayId))
        {
            handler->SendErrorMessage(LANG_COMMAND_FACTION_INVPARAM, Acore::ToString(displayId).c_str());
            return false;
        }

        creature->SetDisplayId(displayId);
        creature->SetNativeDisplayId(displayId);
        creature->SaveToDB();

        return true;
    }

    /**HandleNpcSetMoveTypeCommand
    * Set the movement type for an NPC.<br/>
    * <br/>
    * Valid movement types are:
    * <ul>
    * <li> stay - NPC wont move </li>
    * <li> random - NPC will move randomly according to the wander_distance </li>
    * <li> way - NPC will move with given waypoints set </li>
    * </ul>
    * additional parameter: NODEL - so no waypoints are deleted, if you
    *                       change the movement type
    */
    static bool HandleNpcSetMoveTypeCommand(ChatHandler* handler, Optional<CreatureSpawnId> lowGuid, Variant<EXACT_SEQUENCE("stay"), EXACT_SEQUENCE("random"), EXACT_SEQUENCE("way")> type, Optional<EXACT_SEQUENCE("nodel")> nodel)
    {
        // 3 arguments:
        // GUID (optional - you can also select the creature)
        // stay|random|way (determines the kind of movement)
        // NODEL (optional - tells the system NOT to delete any waypoints)
        //        this is very handy if you want to do waypoints, that are
        //        later switched on/off according to special events (like escort
        //        quests, etc)

        bool doNotDelete = nodel.has_value();

        ObjectGuid::LowType lowguid = 0;
        Creature* creature = nullptr;

        if (!lowGuid)                                           // case .setmovetype $move_type (with selected creature)
        {
            creature = handler->getSelectedCreature();
            if (!creature || creature->IsPet())
                return false;
            lowguid = creature->GetSpawnId();
        }
        else                                                    // case .setmovetype #creature_guid $move_type (with selected creature)
        {
            lowguid = *lowGuid;

            if (lowguid)
                creature = handler->GetCreatureFromPlayerMapByDbGuid(lowguid);

            // attempt check creature existence by DB data
            if (!creature)
            {
                CreatureData const* data = sObjectMgr->GetCreatureData(lowguid);
                if (!data)
                {
                    handler->SendErrorMessage(LANG_COMMAND_CREATGUIDNOTFOUND, lowguid);
                    return false;
                }
            }
            else
            {
                lowguid = creature->GetSpawnId();
            }
        }

        // now lowguid is low guid really existed creature
        // and creature point (maybe) to this creature or nullptr

        MovementGeneratorType move_type;
        switch (type.index())
        {
            case 0:
                move_type = IDLE_MOTION_TYPE;
                break;
            case 1:
                move_type = RANDOM_MOTION_TYPE;
                break;
            case 2:
                move_type = WAYPOINT_MOTION_TYPE;
                break;
            default:
                return false;
        }

        // update movement type
        //if (doNotDelete == false)
        //    WaypointMgr.DeletePath(lowguid);

        if (creature)
        {
            // update movement type
            if (!doNotDelete)
                creature->LoadPath(0);

            creature->SetDefaultMovementType(move_type);
            creature->GetMotionMaster()->Initialize();

            if (creature->IsAlive())                            // dead creature will reset movement generator at respawn
            {
                creature->setDeathState(DeathState::JustDied);
                creature->Respawn();
            }

            creature->SaveToDB();
        }

        if (!doNotDelete)
        {
            handler->PSendSysMessage(LANG_MOVE_TYPE_SET, move_type);
        }
        else
        {
            handler->PSendSysMessage(LANG_MOVE_TYPE_SET_NODEL, move_type);
        }

        return true;
    }

    //npc phasemask handling
    //change phasemask of creature or pet
    static bool HandleNpcSetPhaseCommand(ChatHandler* handler, uint32 phasemask)
    {
        if (phasemask == 0)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        Creature* creature = handler->getSelectedCreature();
        if (!creature)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        creature->SetPhaseMask(phasemask, true);

        if (!creature->IsPet())
            creature->SaveToDB();

        return true;
    }

    //set spawn dist of creature
    static bool HandleNpcSetWanderDistanceCommand(ChatHandler* handler, float option)
    {
        if (option < 0.0f)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            return false;
        }

        MovementGeneratorType mtype = IDLE_MOTION_TYPE;

        if (option > 0.0f)
            mtype = RANDOM_MOTION_TYPE;

        Creature* creature = handler->getSelectedCreature();
        ObjectGuid::LowType guidLow = 0;

        if (creature)
            guidLow = creature->GetSpawnId();
        else
            return false;

        creature->SetWanderDistance((float)option);
        creature->SetDefaultMovementType(mtype);
        creature->GetMotionMaster()->Initialize();

        if (creature->IsAlive())                                // dead creature will reset movement generator at respawn
        {
            creature->setDeathState(DeathState::JustDied);
            creature->Respawn();
        }

        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_UPD_CREATURE_WANDER_DISTANCE);

        stmt->SetData(0, option);
        stmt->SetData(1, uint8(mtype));
        stmt->SetData(2, guidLow);

        WorldDatabase.Execute(stmt);

        handler->PSendSysMessage(LANG_COMMAND_WANDER_DISTANCE, option);
        return true;
    }

    //spawn time handling
    static bool HandleNpcSetSpawnTimeCommand(ChatHandler* handler, std::string spawnTimeStr)
    {
        if (spawnTimeStr.empty())
        {
            return false;
        }

        if (Acore::StringTo<int32>(spawnTimeStr).value_or(0) < 0)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        Creature* creature = handler->getSelectedCreature();
        if (!creature)
            return false;

        int32 spawnTime = TimeStringToSecs(spawnTimeStr);
        if (spawnTime <= 0)
        {
            spawnTime = Acore::StringTo<int32>(spawnTimeStr).value_or(0);
        }

        if (spawnTime <= 0)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_UPD_CREATURE_SPAWN_TIME_SECS);
        stmt->SetData(0, spawnTime);
        stmt->SetData(1, creature->GetSpawnId());
        WorldDatabase.Execute(stmt);

        creature->SetRespawnDelay(spawnTime);
        handler->PSendSysMessage(LANG_COMMAND_SPAWNTIME, secsToTimeString(spawnTime, true).c_str());

        return true;
    }

    static bool HandleNpcSayCommand(ChatHandler* handler, Tail text)
    {
        if (text.empty())
            return false;

        Creature* creature = handler->getSelectedCreature();
        if (!creature)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        creature->Say(text, LANG_UNIVERSAL);

        // make some emotes
        switch (text.back())
        {
            case '?':   creature->HandleEmoteCommand(EMOTE_ONESHOT_QUESTION);      break;
            case '!':   creature->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);   break;
            default:    creature->HandleEmoteCommand(EMOTE_ONESHOT_TALK);          break;
        }

        return true;
    }

    //show text emote by creature in chat
    static bool HandleNpcTextEmoteCommand(ChatHandler* handler, Tail text)
    {
        if (text.empty())
            return false;

        Creature* creature = handler->getSelectedCreature();

        if (!creature)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        creature->TextEmote(text);

        return true;
    }

    //npc unfollow handling
    static bool HandleNpcUnFollowCommand(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();
        Creature* creature = handler->getSelectedCreature();

        if (!creature)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        if (/*creature->GetMotionMaster()->empty() ||*/
            creature->GetMotionMaster()->GetCurrentMovementGeneratorType() != FOLLOW_MOTION_TYPE)
        {
            handler->SendErrorMessage(LANG_CREATURE_NOT_FOLLOW_YOU, creature->GetName().c_str());
            return false;
        }

        FollowMovementGenerator<Creature> const* mgen = static_cast<FollowMovementGenerator<Creature> const*>((creature->GetMotionMaster()->top()));

        if (mgen->GetTarget() != player)
        {
            handler->SendErrorMessage(LANG_CREATURE_NOT_FOLLOW_YOU, creature->GetName().c_str());
            return false;
        }

        // reset movement
        creature->GetMotionMaster()->MovementExpired(true);

        handler->PSendSysMessage(LANG_CREATURE_NOT_FOLLOW_YOU_NOW, creature->GetName().c_str());
        return true;
    }

    // make npc whisper to player
    static bool HandleNpcWhisperCommand(ChatHandler* handler, std::string const& recv, Tail text)
    {
        if (text.empty())
            return false;

        Creature* creature = handler->getSelectedCreature();
        if (!creature)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        // check online security
        Player* receiver = ObjectAccessor::FindPlayerByName(recv);
        if (handler->HasLowerSecurity(receiver, ObjectGuid::Empty))
            return false;

        creature->Whisper(text, LANG_UNIVERSAL, receiver);
        return true;
    }

    static bool HandleNpcYellCommand(ChatHandler* handler, Tail text)
    {
        if (text.empty())
            return false;

        Creature* creature = handler->getSelectedCreature();
        if (!creature)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        creature->Yell(text, LANG_UNIVERSAL);

        // make an emote
        creature->HandleEmoteCommand(EMOTE_ONESHOT_SHOUT);

        return true;
    }

    // add creature, temp only
    static bool HandleNpcAddTempSpawnCommand(ChatHandler* handler, CreatureEntry id)
    {
        Player* chr = handler->GetSession()->GetPlayer();

        if (!id)
            return false;

        chr->SummonCreature(id, *chr, TEMPSUMMON_CORPSE_DESPAWN, 120);

        return true;
    }

    //npc tame handling
    static bool HandleNpcTameCommand(ChatHandler* handler)
    {
        Creature* creatureTarget = handler->getSelectedCreature();
        if (!creatureTarget || creatureTarget->IsPet())
        {
            handler->PSendSysMessage (LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage (true);
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();

        if (player->IsExistPet())
        {
            handler->SendErrorMessage(LANG_YOU_ALREADY_HAVE_PET);
            return false;
        }

        CreatureTemplate const* cInfo = creatureTarget->GetCreatureTemplate();

        if (!cInfo->IsTameable(player->CanTameExoticPets()))
        {
            handler->PSendSysMessage(LANG_CREATURE_NON_TAMEABLE, cInfo->Entry);
            handler->SetSentErrorMessage (true);
            return false;
        }

        if (!player->CreatePet(creatureTarget))
        {
            handler->SendErrorMessage(LANG_CREATURE_NON_TAMEABLE, cInfo->Entry);
            return false;
        }

        return true;
    }

    static bool HandleNpcAddFormationCommand(ChatHandler* handler, ObjectGuid::LowType leaderGUID)
    {
        Creature* creature = handler->getSelectedCreature();

        if (!creature || !creature->GetSpawnId())
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        ObjectGuid::LowType lowguid = creature->GetSpawnId();
        if (creature->GetFormation())
        {
            handler->PSendSysMessage("Selected creature is already member of group %u", creature->GetFormation()->GetId());
            return false;
        }

        if (!lowguid)
            return false;

        Player* chr = handler->GetSession()->GetPlayer();
        FormationInfo group_member;
        group_member.follow_angle   = (creature->GetAngle(chr) - chr->GetOrientation()) * 180 / M_PI;
        group_member.follow_dist    = sqrtf(pow(chr->GetPositionX() - creature->GetPositionX(), int(2)) + pow(chr->GetPositionY() - creature->GetPositionY(), int(2)));
        group_member.leaderGUID     = leaderGUID;
        group_member.groupAI        = 0;

        sFormationMgr->CreatureGroupMap[lowguid] = group_member;
        creature->SearchFormation();

        WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_INS_CREATURE_FORMATION);
        stmt->SetData(0, leaderGUID);
        stmt->SetData(1, lowguid);
        stmt->SetData(2, group_member.follow_dist);
        stmt->SetData(3, group_member.follow_angle);
        stmt->SetData(4, uint32(group_member.groupAI));

        WorldDatabase.Execute(stmt);

        handler->PSendSysMessage("Creature %u added to formation with leader %u", lowguid, leaderGUID);

        return true;
    }

    static bool HandleNpcSetLinkCommand(ChatHandler* handler, ObjectGuid::LowType linkguid)
    {
        Creature* creature = handler->getSelectedCreature();

        if (!creature)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        if (!creature->GetSpawnId())
        {
            handler->SendErrorMessage("Selected creature %u isn't in creature table", creature->GetGUID().GetCounter());
            return false;
        }

        if (!sObjectMgr->SetCreatureLinkedRespawn(creature->GetSpawnId(), linkguid))
        {
            handler->SendErrorMessage("Selected creature can't link with guid '%u'", linkguid);
            return false;
        }

        handler->PSendSysMessage("LinkGUID '%u' added to creature with DBTableGUID: '%u'", linkguid, creature->GetSpawnId());
        return true;
    }
};

void AddSC_npc_commandscript()
{
    new npc_commandscript();
}
