/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
Name: npc_commandscript
%Complete: 100
Comment: All npc related commands
Category: commandscripts
EndScriptData */

#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "Chat.h"
#include "Transport.h"
#include "CreatureGroups.h"
#include "Language.h"
#include "TargetedMovementGenerator.h"                      // for HandleNpcUnFollowCommand
#include "CreatureAI.h"
#include "Player.h"
#include "Pet.h"

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

#define MAX_MECHANIC    32

MechanicImmune const mechanicImmunes[MAX_MECHANIC] =
{
    { MECHANIC_NONE             , "MECHANIC_NONE"               },
    { MECHANIC_CHARM            , "MECHANIC_CHARM"              },
    { MECHANIC_DISORIENTED      , "MECHANIC_DISORIENTED"        },
    { MECHANIC_DISARM           , "MECHANIC_DISARM"             },
    { MECHANIC_DISTRACT         , "MECHANIC_DISTRACT"           },
    { MECHANIC_FEAR             , "MECHANIC_FEAR"               },
    { MECHANIC_GRIP             , "MECHANIC_GRIP"               },
    { MECHANIC_ROOT             , "MECHANIC_ROOT"               },
    { MECHANIC_SLOW_ATTACK      , "MECHANIC_SLOW_ATTACK"        },
    { MECHANIC_SILENCE          , "MECHANIC_SILENCE"            },
    { MECHANIC_SLEEP            , "MECHANIC_SLEEP"              },
    { MECHANIC_SNARE            , "MECHANIC_SNARE"              },
    { MECHANIC_STUN             , "MECHANIC_STUN"               },
    { MECHANIC_FREEZE           , "MECHANIC_FREEZE"             },
    { MECHANIC_KNOCKOUT         , "MECHANIC_KNOCKOUT"           },
    { MECHANIC_BLEED            , "MECHANIC_BLEED"              },
    { MECHANIC_BANDAGE          , "MECHANIC_BANDAGE"            },
    { MECHANIC_POLYMORPH        , "MECHANIC_POLYMORPH"          },
    { MECHANIC_BANISH           , "MECHANIC_BANISH"             },
    { MECHANIC_SHIELD           , "MECHANIC_SHIELD"             },
    { MECHANIC_SHACKLE          , "MECHANIC_SHACKLE"            },
    { MECHANIC_MOUNT            , "MECHANIC_MOUNT"              },
    { MECHANIC_INFECTED         , "MECHANIC_INFECTED"           },
    { MECHANIC_TURN             , "MECHANIC_TURN"               },
    { MECHANIC_HORROR           , "MECHANIC_HORROR"             },
    { MECHANIC_INVULNERABILITY  , "MECHANIC_INVULNERABILITY"    },
    { MECHANIC_INTERRUPT        , "MECHANIC_INTERRUPT"          },
    { MECHANIC_DAZE             , "MECHANIC_DAZE"               },
    { MECHANIC_DISCOVERY        , "MECHANIC_DISCOVERY"          },
    { MECHANIC_IMMUNE_SHIELD    , "MECHANIC_IMMUNE_SHIELD"      },
    { MECHANIC_SAPPED           , "MECHANIC_SAPPED"             },
    { MECHANIC_ENRAGED          , "MECHANIC_ENRAGED"            },
};

class npc_commandscript : public CommandScript
{
public:
    npc_commandscript() : CommandScript("npc_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> npcAddCommandTable =
        {
            { "formation",      SEC_ADMINISTRATOR,  false, &HandleNpcAddFormationCommand,      "" },
            { "item",           SEC_ADMINISTRATOR,  false, &HandleNpcAddVendorItemCommand,     "" },
            { "move",           SEC_ADMINISTRATOR,  false, &HandleNpcAddMoveCommand,           "" },
            { "temp",           SEC_ADMINISTRATOR,  false, &HandleNpcAddTempSpawnCommand,      "" },
            //{ TODO: fix or remove this command
            { "weapon",         SEC_ADMINISTRATOR,  false, &HandleNpcAddWeaponCommand,         "" },
            //}
            { "",               SEC_ADMINISTRATOR,  false, &HandleNpcAddCommand,               "" }
        };
        static std::vector<ChatCommand> npcDeleteCommandTable =
        {
            { "item",           SEC_ADMINISTRATOR,  false, &HandleNpcDeleteVendorItemCommand,  "" },
            { "",               SEC_ADMINISTRATOR,  false, &HandleNpcDeleteCommand,            "" }
        };
        static std::vector<ChatCommand> npcFollowCommandTable =
        {
            { "stop",           SEC_GAMEMASTER,     false, &HandleNpcUnFollowCommand,          "" },
            { "",               SEC_GAMEMASTER,     false, &HandleNpcFollowCommand,            "" }
        };

        static std::vector<ChatCommand> npcFactionCommandTable =
        {
            { "permanent",      SEC_ADMINISTRATOR,  false, &HandleNpcSetFactionIdCommand,      "" },
            { "temp",           SEC_ADMINISTRATOR,  false, &HandleNpcSetFactionTempIdCommand,  "" },
            { "original",       SEC_ADMINISTRATOR,  false, &HandleNpcSetOriginalFaction,       "" }
        };

        static std::vector<ChatCommand> npcSetCommandTable =
        {
            { "allowmove",      SEC_ADMINISTRATOR,  false, &HandleNpcSetAllowMovementCommand,  "" },
            { "entry",          SEC_ADMINISTRATOR,  false, &HandleNpcSetEntryCommand,          "" },
            { "faction",        SEC_ADMINISTRATOR,  false, nullptr,                            "", npcFactionCommandTable},
            { "flag",           SEC_ADMINISTRATOR,  false, &HandleNpcSetFlagCommand,           "" },
            { "level",          SEC_ADMINISTRATOR,  false, &HandleNpcSetLevelCommand,          "" },
            { "link",           SEC_ADMINISTRATOR,  false, &HandleNpcSetLinkCommand,           "" },
            { "model",          SEC_ADMINISTRATOR,  false, &HandleNpcSetModelCommand,          "" },
            { "movetype",       SEC_ADMINISTRATOR,  false, &HandleNpcSetMoveTypeCommand,       "" },
            { "phase",          SEC_ADMINISTRATOR,  false, &HandleNpcSetPhaseCommand,          "" },
            { "spawndist",      SEC_ADMINISTRATOR,  false, &HandleNpcSetSpawnDistCommand,      "" },
            { "spawntime",      SEC_ADMINISTRATOR,  false, &HandleNpcSetSpawnTimeCommand,      "" },
            { "data",           SEC_ADMINISTRATOR,  false, &HandleNpcSetDataCommand,           "" },
            //{ TODO: fix or remove these commands
            { "name",           SEC_ADMINISTRATOR,  false, &HandleNpcSetNameCommand,           "" },
            { "subname",        SEC_ADMINISTRATOR,  false, &HandleNpcSetSubNameCommand,        "" }
            //}
        };
        static std::vector<ChatCommand> npcCommandTable =
        {
            { "info",           SEC_MODERATOR,      false, &HandleNpcInfoCommand,              "" },
            { "near",           SEC_GAMEMASTER,     false, &HandleNpcNearCommand,              "" },
            { "move",           SEC_ADMINISTRATOR,  false, &HandleNpcMoveCommand,              "" },
            { "playemote",      SEC_ADMINISTRATOR,  false, &HandleNpcPlayEmoteCommand,         "" },
            { "say",            SEC_GAMEMASTER,     false, &HandleNpcSayCommand,               "" },
            { "textemote",      SEC_GAMEMASTER,     false, &HandleNpcTextEmoteCommand,         "" },
            { "whisper",        SEC_GAMEMASTER,     false, &HandleNpcWhisperCommand,           "" },
            { "yell",           SEC_GAMEMASTER,     false, &HandleNpcYellCommand,              "" },
            { "tame",           SEC_GAMEMASTER,     false, &HandleNpcTameCommand,              "" },
            { "add",            SEC_GAMEMASTER,     false, nullptr,                            "", npcAddCommandTable },
            { "delete",         SEC_GAMEMASTER,     false, nullptr,                            "", npcDeleteCommandTable },
            { "follow",         SEC_GAMEMASTER,     false, nullptr,                            "", npcFollowCommandTable },
            { "set",            SEC_ADMINISTRATOR,  false, nullptr,                            "", npcSetCommandTable }
        };
        static std::vector<ChatCommand> commandTable =
        {
            { "npc",            SEC_MODERATOR,      false, nullptr,                            "", npcCommandTable }
        };
        return commandTable;
    }

    //add spawn of creature
    static bool HandleNpcAddCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* charID = handler->extractKeyFromLink((char*)args, "Hcreature_entry");
        if (!charID)
            return false;

        char* team = strtok(nullptr, " ");
        int32 teamval = 0;
        if (team)
            teamval = atoi(team);

        if (teamval < 0)
            teamval = 0;

        uint32 id  = atoi(charID);
        if (!sObjectMgr->GetCreatureTemplate(id))
            return false;

        Player* chr = handler->GetSession()->GetPlayer();
        float x = chr->GetPositionX();
        float y = chr->GetPositionY();
        float z = chr->GetPositionZ();
        float o = chr->GetOrientation();
        Map* map = chr->GetMap();

        if (Transport* tt = chr->GetTransport())
            if (MotionTransport* trans = tt->ToMotionTransport())
            {
                uint32 guid = sObjectMgr->GenerateLowGuid(HIGHGUID_UNIT);
                CreatureData& data = sObjectMgr->NewOrExistCreatureData(guid);
                data.id = id;
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
        if (!creature->Create(sObjectMgr->GenerateLowGuid(HIGHGUID_UNIT), map, chr->GetPhaseMaskForSpawn(), id, 0, x, y, z, o))
        {
            delete creature;
            return false;
        }

        creature->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), chr->GetPhaseMaskForSpawn());

        uint32 db_guid = creature->GetDBTableGUIDLow();

        // To call _LoadGoods(); _LoadQuests(); CreateTrainerSpells()
        // current "creature" variable is deleted and created fresh new, otherwise old values might trigger asserts or cause undefined behavior
        creature->CleanupsBeforeDelete();
        delete creature;
        creature = new Creature();
        if (!creature->LoadCreatureFromDB(db_guid, map))
        {
            delete creature;
            return false;
        }

        sObjectMgr->AddCreatureToGrid(db_guid, sObjectMgr->GetCreatureData(db_guid));
        return true;
    }

    //add item in vendorlist
    static bool HandleNpcAddVendorItemCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* pitem  = handler->extractKeyFromLink((char*)args, "Hitem");
        if (!pitem)
        {
            handler->SendSysMessage(LANG_COMMAND_NEEDITEMSEND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        int32 item_int = atol(pitem);
        if (item_int <= 0)
            return false;

        uint32 itemId = item_int;

        char* fmaxcount = strtok(nullptr, " ");                    //add maxcount, default: 0
        uint32 maxcount = 0;
        if (fmaxcount)
            maxcount = atol(fmaxcount);

        char* fincrtime = strtok(nullptr, " ");                    //add incrtime, default: 0
        uint32 incrtime = 0;
        if (fincrtime)
            incrtime = atol(fincrtime);

        char* fextendedcost = strtok(nullptr, " ");                //add ExtendedCost, default: 0
        uint32 extendedcost = fextendedcost ? atol(fextendedcost) : 0;
        Creature* vendor = handler->getSelectedCreature();
        if (!vendor)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 vendor_entry = vendor ? vendor->GetEntry() : 0;

        if (!sObjectMgr->IsVendorItemValid(vendor_entry, itemId, maxcount, incrtime, extendedcost, handler->GetSession()->GetPlayer()))
        {
            handler->SetSentErrorMessage(true);
            return false;
        }

        sObjectMgr->AddVendorItem(vendor_entry, itemId, maxcount, incrtime, extendedcost);

        ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemId);

        handler->PSendSysMessage(LANG_ITEM_ADDED_TO_LIST, itemId, itemTemplate->Name1.c_str(), maxcount, incrtime, extendedcost);
        return true;
    }

    //add move for creature
    static bool HandleNpcAddMoveCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        char* guidStr = strtok((char*)args, " ");
        char* waitStr = strtok((char*)nullptr, " ");

        uint32 lowGuid = atoi((char*)guidStr);

        Creature* creature = nullptr;

        /* FIXME: impossible without entry
        if (lowguid)
            creature = ObjectAccessor::GetCreature(*handler->GetSession()->GetPlayer(), MAKE_GUID(lowguid, HIGHGUID_UNIT));
        */

        // attempt check creature existence by DB data
        if (!creature)
        {
            CreatureData const* data = sObjectMgr->GetCreatureData(lowGuid);
            if (!data)
            {
                handler->PSendSysMessage(LANG_COMMAND_CREATGUIDNOTFOUND, lowGuid);
                handler->SetSentErrorMessage(true);
                return false;
            }
        }
        else
        {
            // obtain real GUID for DB operations
            lowGuid = creature->GetDBTableGUIDLow();
        }

        int wait = waitStr ? atoi(waitStr) : 0;

        if (wait < 0)
            wait = 0;

        // Update movement type
        PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_UPD_CREATURE_MOVEMENT_TYPE);

        stmt->setUInt8(0, uint8(WAYPOINT_MOTION_TYPE));
        stmt->setUInt32(1, lowGuid);

        WorldDatabase.Execute(stmt);

        if (creature && creature->GetWaypointPath())
        {
            creature->SetDefaultMovementType(WAYPOINT_MOTION_TYPE);
            creature->GetMotionMaster()->Initialize();
            if (creature->IsAlive())                            // dead creature will reset movement generator at respawn
            {
                creature->setDeathState(JUST_DIED);
                creature->Respawn(true);
            }
            creature->SaveToDB();
        }

        handler->SendSysMessage(LANG_WAYPOINT_ADDED);

        return true;
    }

    static bool HandleNpcSetAllowMovementCommand(ChatHandler* handler, const char* /*args*/)
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

    static bool HandleNpcSetEntryCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        uint32 newEntryNum = atoi(args);
        if (!newEntryNum)
            return false;

        Unit* unit = handler->getSelectedUnit();
        if (!unit || unit->GetTypeId() != TYPEID_UNIT)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
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
    static bool HandleNpcSetLevelCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        uint8 lvl = (uint8) atoi((char*)args);
        if (lvl < 1 || lvl > sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL) + 3)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* creature = handler->getSelectedCreature();
        if (!creature)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (creature->IsPet())
        {
            if (((Pet*)creature)->getPetType() == HUNTER_PET)
            {
                creature->SetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP, sObjectMgr->GetXPForLevel(lvl)/4);
                creature->SetUInt32Value(UNIT_FIELD_PETEXPERIENCE, 0);
            }
            ((Pet*)creature)->GivePetLevel(lvl);
        }
        else
        {
            creature->SetMaxHealth(100 + 30*lvl);
            creature->SetHealth(100 + 30*lvl);
            creature->SetLevel(lvl);
            creature->SaveToDB();
        }

        return true;
    }

    static bool HandleNpcDeleteCommand(ChatHandler* handler, const char* args)
    {
        Creature* unit = nullptr;

        if (*args)
        {
            // number or [name] Shift-click form |color|Hcreature:creature_guid|h[name]|h|r
            char* cId = handler->extractKeyFromLink((char*)args, "Hcreature");
            if (!cId)
                return false;

            uint32 lowguid = atoi(cId);
            if (!lowguid)
                return false;

            if (CreatureData const* cr_data = sObjectMgr->GetCreatureData(lowguid))
                unit = handler->GetSession()->GetPlayer()->GetMap()->GetCreature(MAKE_NEW_GUID(lowguid, cr_data->id, HIGHGUID_UNIT));
        }
        else
            unit = handler->getSelectedCreature();

        if (!unit || unit->IsPet() || unit->IsTotem())
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // Delete the creature
        unit->CombatStop();
        unit->DeleteFromDB();
        unit->AddObjectToRemoveList();

        handler->SendSysMessage(LANG_COMMAND_DELCREATMESSAGE);

        return true;
    }

    //del item from vendor list
    static bool HandleNpcDeleteVendorItemCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        Creature* vendor = handler->getSelectedCreature();
        if (!vendor || !vendor->IsVendor())
        {
            handler->SendSysMessage(LANG_COMMAND_VENDORSELECTION);
            handler->SetSentErrorMessage(true);
            return false;
        }

        char* pitem  = handler->extractKeyFromLink((char*)args, "Hitem");
        if (!pitem)
        {
            handler->SendSysMessage(LANG_COMMAND_NEEDITEMSEND);
            handler->SetSentErrorMessage(true);
            return false;
        }
        uint32 itemId = atol(pitem);

        if (!sObjectMgr->RemoveVendorItem(vendor->GetEntry(), itemId))
        {
            handler->PSendSysMessage(LANG_ITEM_NOT_IN_LIST, itemId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemId);

        handler->PSendSysMessage(LANG_ITEM_DELETED_FROM_LIST, itemId, itemTemplate->Name1.c_str());
        return true;
    }

    //set faction of creature
    static bool HandleNpcSetFactionIdCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        uint32 factionId = (uint32) atoi((char*)args);

        if (!sFactionTemplateStore.LookupEntry(factionId))
        {
            handler->PSendSysMessage(LANG_WRONG_FACTION, factionId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* creature = handler->getSelectedCreature();

        if (!creature)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        creature->setFaction(factionId);

        // Faction is set in creature_template - not inside creature

        // Update in memory..
        if (CreatureTemplate const* cinfo = creature->GetCreatureTemplate())
        {
            const_cast<CreatureTemplate*>(cinfo)->faction = factionId;
        }

        // ..and DB
        PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_UPD_CREATURE_FACTION);

        stmt->setUInt16(0, uint16(factionId));
        stmt->setUInt32(1, creature->GetEntry());

        WorldDatabase.Execute(stmt);

        return true;
    }

    //set tempfaction for creature
    static bool HandleNpcSetFactionTempIdCommand(ChatHandler* handler, const char* args)
    {
        Player* me = handler->GetSession()->GetPlayer();
        Unit* SelectedCreature = me->GetSelectedUnit();

        if (!SelectedCreature)
            return false;

        Creature* creature = SelectedCreature->ToCreature();

        if (!creature)
            return false;

        if (!*args)
            return false;

        uint32 tempfaction = (uint32)atoi((char*)args);

        creature->setFaction(tempfaction);
        return true;
    }

    //set orginal faction for npc
    static bool HandleNpcSetOriginalFaction(ChatHandler* handler, const char* /*args*/)
    {
        Player* me = handler->GetSession()->GetPlayer();
        Creature* creature = me->GetSelectedUnit()->ToCreature();

        if (!me)
            return false;

        if (!creature)
            return false;

        creature->RestoreFaction();

        return true;
    }

    //set npcflag of creature
    static bool HandleNpcSetFlagCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        uint32 npcFlags = (uint32) atoi((char*)args);

        Creature* creature = handler->getSelectedCreature();

        if (!creature)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        creature->SetUInt32Value(UNIT_NPC_FLAGS, npcFlags);

        PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_UPD_CREATURE_NPCFLAG);

        stmt->setUInt32(0, npcFlags);
        stmt->setUInt32(1, creature->GetEntry());

        WorldDatabase.Execute(stmt);

        handler->SendSysMessage(LANG_VALUE_SAVED_REJOIN);

        return true;
    }

    //set data of creature for testing scripting
    static bool HandleNpcSetDataCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        char* arg1 = strtok((char*)args, " ");
        char* arg2 = strtok((char*)nullptr, "");

        if (!arg1 || !arg2)
            return false;

        uint32 data_1 = (uint32)atoi(arg1);
        uint32 data_2 = (uint32)atoi(arg2);

        if (!data_1 || !data_2)
            return false;

        Creature* creature = handler->getSelectedCreature();

        if (!creature)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        creature->AI()->SetData(data_1, data_2);
        std::string AIorScript = creature->GetAIName() != "" ? "AI type: " + creature->GetAIName() : (creature->GetScriptName() != "" ? "Script Name: " + creature->GetScriptName() : "No AI or Script Name Set");
        handler->PSendSysMessage(LANG_NPC_SETDATA, creature->GetGUID(), creature->GetEntry(), creature->GetName().c_str(), data_1, data_2, AIorScript.c_str());
        return true;
    }

    //npc follow handling
    static bool HandleNpcFollowCommand(ChatHandler* handler, const char* /*args*/)
    {
        Player* player = handler->GetSession()->GetPlayer();
        Creature* creature = handler->getSelectedCreature();

        if (!creature)
        {
            handler->PSendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // Follow player - Using pet's default dist and angle
        creature->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, creature->GetFollowAngle());

        handler->PSendSysMessage(LANG_CREATURE_FOLLOW_YOU_NOW, creature->GetName().c_str());
        return true;
    }

    static bool HandleNpcInfoCommand(ChatHandler* handler, const char* /*args*/)
    {
        Creature* target = handler->getSelectedCreature();

        if (!target)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        CreatureTemplate const* cInfo = target->GetCreatureTemplate();
        uint32 faction = target->getFaction();
        uint32 npcflags = target->GetUInt32Value(UNIT_NPC_FLAGS);
        uint32 mechanicImmuneMask = cInfo->MechanicImmuneMask;
        uint32 displayid = target->GetDisplayId();
        uint32 nativeid = target->GetNativeDisplayId();
        uint32 Entry = target->GetEntry();

        int64 curRespawnDelay = target->GetRespawnTimeEx()-time(nullptr);
        if (curRespawnDelay < 0)
            curRespawnDelay = 0;
        std::string curRespawnDelayStr = secsToTimeString(uint64(curRespawnDelay), true);
        std::string defRespawnDelayStr = secsToTimeString(target->GetRespawnDelay(), true);

        handler->PSendSysMessage(LANG_NPCINFO_CHAR,  target->GetDBTableGUIDLow(), target->GetGUIDLow(), faction, npcflags, Entry, displayid, nativeid);
        handler->PSendSysMessage(LANG_NPCINFO_LEVEL, target->getLevel());
        handler->PSendSysMessage(LANG_NPCINFO_EQUIPMENT, target->GetCurrentEquipmentId(), target->GetOriginalEquipmentId());
        handler->PSendSysMessage(LANG_NPCINFO_HEALTH, target->GetCreateHealth(), target->GetMaxHealth(), target->GetHealth());
        handler->PSendSysMessage(LANG_NPCINFO_FLAGS, target->GetUInt32Value(UNIT_FIELD_FLAGS), target->GetUInt32Value(UNIT_FIELD_FLAGS_2), target->GetUInt32Value(UNIT_DYNAMIC_FLAGS), target->getFaction());
        handler->PSendSysMessage(LANG_COMMAND_RAWPAWNTIMES, defRespawnDelayStr.c_str(), curRespawnDelayStr.c_str());
        handler->PSendSysMessage(LANG_NPCINFO_LOOT,  cInfo->lootid, cInfo->pickpocketLootId, cInfo->SkinLootId);
        handler->PSendSysMessage(LANG_NPCINFO_DUNGEON_ID, target->GetInstanceId());
        handler->PSendSysMessage(LANG_NPCINFO_PHASEMASK, target->GetPhaseMask());
        handler->PSendSysMessage(LANG_NPCINFO_ARMOR, target->GetArmor());
        handler->PSendSysMessage(LANG_NPCINFO_POSITION, float(target->GetPositionX()), float(target->GetPositionY()), float(target->GetPositionZ()));
        handler->PSendSysMessage(LANG_NPCINFO_AIINFO, target->GetAIName().c_str(), target->GetScriptName().c_str());

        for (uint8 i = 0; i < NPCFLAG_COUNT; i++)
            if (npcflags & npcFlagTexts[i].flag)
                handler->PSendSysMessage(npcFlagTexts[i].text, npcFlagTexts[i].flag);
        
        handler->PSendSysMessage(LANG_NPCINFO_MECHANIC_IMMUNE, mechanicImmuneMask);
        for (uint8 i = 1; i < MAX_MECHANIC; ++i)
            if (mechanicImmuneMask & (1 << (mechanicImmunes[i].flag - 1)))
                handler->PSendSysMessage(mechanicImmunes[i].text, mechanicImmunes[i].flag);

        return true;
    }

    static bool HandleNpcNearCommand(ChatHandler* handler, char const* args)
    {
        float distance = (!*args) ? 10.0f : float((atof(args)));
        uint32 count = 0;

        Player* player = handler->GetSession()->GetPlayer();

        PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_CREATURE_NEAREST);
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
                uint32 guid = fields[0].GetUInt32();
                uint32 entry = fields[1].GetUInt32();
                float x = fields[2].GetFloat();
                float y = fields[3].GetFloat();
                float z = fields[4].GetFloat();
                uint16 mapId = fields[5].GetUInt16();

                CreatureTemplate const* creatureTemplate = sObjectMgr->GetCreatureTemplate(entry);
                if (!creatureTemplate)
                    continue;

                handler->PSendSysMessage(LANG_CREATURE_LIST_CHAT, guid, guid, creatureTemplate->Name.c_str(), x, y, z, mapId);

                ++count;
            }
            while (result->NextRow());
        }

        handler->PSendSysMessage(LANG_COMMAND_NEAR_NPC_MESSAGE, distance, count);

        return true;
    }

    //move selected creature
    static bool HandleNpcMoveCommand(ChatHandler* handler, const char* args)
    {
        uint32 lowguid = 0;

        Creature* creature = handler->getSelectedCreature();

        if (!creature)
        {
            // number or [name] Shift-click form |color|Hcreature:creature_guid|h[name]|h|r
            char* cId = handler->extractKeyFromLink((char*)args, "Hcreature");
            if (!cId)
                return false;

            lowguid = atoi(cId);

            /* FIXME: impossible without entry
            if (lowguid)
                creature = ObjectAccessor::GetCreature(*handler->GetSession()->GetPlayer(), MAKE_GUID(lowguid, HIGHGUID_UNIT));
            */

            // Attempting creature load from DB data
            if (!creature)
            {
                CreatureData const* data = sObjectMgr->GetCreatureData(lowguid);
                if (!data)
                {
                    handler->PSendSysMessage(LANG_COMMAND_CREATGUIDNOTFOUND, lowguid);
                    handler->SetSentErrorMessage(true);
                    return false;
                }

                uint32 map_id = data->mapid;

                if (handler->GetSession()->GetPlayer()->GetMapId() != map_id)
                {
                    handler->PSendSysMessage(LANG_COMMAND_CREATUREATSAMEMAP, lowguid);
                    handler->SetSentErrorMessage(true);
                    return false;
                }
            }
            else
            {
                lowguid = creature->GetDBTableGUIDLow();
            }
        }
        else
        {
            lowguid = creature->GetDBTableGUIDLow();
        }

        float x = handler->GetSession()->GetPlayer()->GetPositionX();
        float y = handler->GetSession()->GetPlayer()->GetPositionY();
        float z = handler->GetSession()->GetPlayer()->GetPositionZ();
        float o = handler->GetSession()->GetPlayer()->GetOrientation();

        if (creature)
        {
            if (CreatureData const* data = sObjectMgr->GetCreatureData(creature->GetDBTableGUIDLow()))
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
                creature->setDeathState(JUST_DIED);
                creature->Respawn();
            }
        }

        PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_UPD_CREATURE_POSITION);

        stmt->setFloat(0, x);
        stmt->setFloat(1, y);
        stmt->setFloat(2, z);
        stmt->setFloat(3, o);
        stmt->setUInt32(4, lowguid);

        WorldDatabase.Execute(stmt);

        handler->PSendSysMessage(LANG_COMMAND_CREATUREMOVED);
        return true;
    }

    //play npc emote
    static bool HandleNpcPlayEmoteCommand(ChatHandler* handler, const char* args)
    {
        uint32 emote = atoi((char*)args);

        Creature* target = handler->getSelectedCreature();
        if (!target)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        target->SetUInt32Value(UNIT_NPC_EMOTESTATE, emote);

        return true;
    }

    //set model of creature
    static bool HandleNpcSetModelCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        uint32 displayId = (uint32) atoi((char*)args);

        Creature* creature = handler->getSelectedCreature();

        if (!creature || creature->IsPet())
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
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
    * <li> random - NPC will move randomly according to the spawndist </li>
    * <li> way - NPC will move with given waypoints set </li>
    * </ul>
    * additional parameter: NODEL - so no waypoints are deleted, if you
    *                       change the movement type
    */
    static bool HandleNpcSetMoveTypeCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        // 3 arguments:
        // GUID (optional - you can also select the creature)
        // stay|random|way (determines the kind of movement)
        // NODEL (optional - tells the system NOT to delete any waypoints)
        //        this is very handy if you want to do waypoints, that are
        //        later switched on/off according to special events (like escort
        //        quests, etc)
        char* guid_str = strtok((char*)args, " ");
        char* type_str = strtok((char*)nullptr, " ");
        char* dontdel_str = strtok((char*)nullptr, " ");

        bool doNotDelete = false;

        if (!guid_str)
            return false;

        uint32 lowguid = 0;
        Creature* creature = nullptr;

        if (dontdel_str)
        {
            //sLog->outError("DEBUG: All 3 params are set");

            // All 3 params are set
            // GUID
            // type
            // doNotDEL
            if (stricmp(dontdel_str, "NODEL") == 0)
            {
                //sLog->outError("DEBUG: doNotDelete = true;");
                doNotDelete = true;
            }
        }
        else
        {
            // Only 2 params - but maybe NODEL is set
            if (type_str)
            {
                sLog->outError("DEBUG: Only 2 params ");
                if (stricmp(type_str, "NODEL") == 0)
                {
                    //sLog->outError("DEBUG: type_str, NODEL ");
                    doNotDelete = true;
                    type_str = nullptr;
                }
            }
        }

        if (!type_str)                                           // case .setmovetype $move_type (with selected creature)
        {
            type_str = guid_str;
            creature = handler->getSelectedCreature();
            if (!creature || creature->IsPet())
                return false;
            lowguid = creature->GetDBTableGUIDLow();
        }
        else                                                    // case .setmovetype #creature_guid $move_type (with selected creature)
        {
            lowguid = atoi((char*)guid_str);

            /* impossible without entry
            if (lowguid)
                creature = ObjectAccessor::GetCreature(*handler->GetSession()->GetPlayer(), MAKE_GUID(lowguid, HIGHGUID_UNIT));
            */

            // attempt check creature existence by DB data
            if (!creature)
            {
                CreatureData const* data = sObjectMgr->GetCreatureData(lowguid);
                if (!data)
                {
                    handler->PSendSysMessage(LANG_COMMAND_CREATGUIDNOTFOUND, lowguid);
                    handler->SetSentErrorMessage(true);
                    return false;
                }
            }
            else
            {
                lowguid = creature->GetDBTableGUIDLow();
            }
        }

        // now lowguid is low guid really existed creature
        // and creature point (maybe) to this creature or nullptr

        MovementGeneratorType move_type;

        std::string type = type_str;

        if (type == "stay")
            move_type = IDLE_MOTION_TYPE;
        else if (type == "random")
            move_type = RANDOM_MOTION_TYPE;
        else if (type == "way")
            move_type = WAYPOINT_MOTION_TYPE;
        else
            return false;

        // update movement type
        //if (doNotDelete == false)
        //    WaypointMgr.DeletePath(lowguid);

        if (creature)
        {
            // update movement type
            if (doNotDelete == false)
                creature->LoadPath(0);

            creature->SetDefaultMovementType(move_type);
            creature->GetMotionMaster()->Initialize();
            if (creature->IsAlive())                            // dead creature will reset movement generator at respawn
            {
                creature->setDeathState(JUST_DIED);
                creature->Respawn();
            }
            creature->SaveToDB();
        }
        if (doNotDelete == false)
        {
            handler->PSendSysMessage(LANG_MOVE_TYPE_SET, type_str);
        }
        else
        {
            handler->PSendSysMessage(LANG_MOVE_TYPE_SET_NODEL, type_str);
        }

        return true;
    }

    //npc phasemask handling
    //change phasemask of creature or pet
    static bool HandleNpcSetPhaseCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        uint32 phasemask = (uint32) atoi((char*)args);
        if (phasemask == 0)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* creature = handler->getSelectedCreature();
        if (!creature)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        creature->SetPhaseMask(phasemask, true);

        if (!creature->IsPet())
            creature->SaveToDB();

        return true;
    }

    //set spawn dist of creature
    static bool HandleNpcSetSpawnDistCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        float option = (float)(atof((char*)args));
        if (option < 0.0f)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            return false;
        }

        MovementGeneratorType mtype = IDLE_MOTION_TYPE;
        if (option >0.0f)
            mtype = RANDOM_MOTION_TYPE;

        Creature* creature = handler->getSelectedCreature();
        uint32 guidLow = 0;

        if (creature)
            guidLow = creature->GetDBTableGUIDLow();
        else
            return false;

        creature->SetRespawnRadius((float)option);
        creature->SetDefaultMovementType(mtype);
        creature->GetMotionMaster()->Initialize();
        if (creature->IsAlive())                                // dead creature will reset movement generator at respawn
        {
            creature->setDeathState(JUST_DIED);
            creature->Respawn();
        }

        PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_UPD_CREATURE_SPAWN_DISTANCE);

        stmt->setFloat(0, option);
        stmt->setUInt8(1, uint8(mtype));
        stmt->setUInt32(2, guidLow);

        WorldDatabase.Execute(stmt);

        handler->PSendSysMessage(LANG_COMMAND_SPAWNDIST, option);
        return true;
    }

    //spawn time handling
    static bool HandleNpcSetSpawnTimeCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        char* stime = strtok((char*)args, " ");

        if (!stime)
            return false;

        int spawnTime = atoi((char*)stime);

        if (spawnTime < 0)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Creature* creature = handler->getSelectedCreature();
        uint32 guidLow = 0;

        if (creature)
            guidLow = creature->GetDBTableGUIDLow();
        else
            return false;

        PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_UPD_CREATURE_SPAWN_TIME_SECS);

        stmt->setUInt32(0, uint32(spawnTime));
        stmt->setUInt32(1, guidLow);

        WorldDatabase.Execute(stmt);

        creature->SetRespawnDelay((uint32)spawnTime);
        handler->PSendSysMessage(LANG_COMMAND_SPAWNTIME, spawnTime);

        return true;
    }

    static bool HandleNpcSayCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        Creature* creature = handler->getSelectedCreature();
        if (!creature)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        creature->MonsterSay(args, LANG_UNIVERSAL, nullptr);

        // make some emotes
        char lastchar = args[strlen(args) - 1];
        switch (lastchar)
        {
        case '?':   creature->HandleEmoteCommand(EMOTE_ONESHOT_QUESTION);      break;
        case '!':   creature->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);   break;
        default:    creature->HandleEmoteCommand(EMOTE_ONESHOT_TALK);          break;
        }

        return true;
    }

    //show text emote by creature in chat
    static bool HandleNpcTextEmoteCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        Creature* creature = handler->getSelectedCreature();

        if (!creature)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        creature->MonsterTextEmote(args, 0);

        return true;
    }

    //npc unfollow handling
    static bool HandleNpcUnFollowCommand(ChatHandler* handler, const char* /*args*/)
    {
        Player* player = handler->GetSession()->GetPlayer();
        Creature* creature = handler->getSelectedCreature();

        if (!creature)
        {
            handler->PSendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (/*creature->GetMotionMaster()->empty() ||*/
            creature->GetMotionMaster()->GetCurrentMovementGeneratorType() != FOLLOW_MOTION_TYPE)
        {
            handler->PSendSysMessage(LANG_CREATURE_NOT_FOLLOW_YOU, creature->GetName().c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        FollowMovementGenerator<Creature> const* mgen = static_cast<FollowMovementGenerator<Creature> const*>((creature->GetMotionMaster()->top()));

        if (mgen->GetTarget() != player)
        {
            handler->PSendSysMessage(LANG_CREATURE_NOT_FOLLOW_YOU, creature->GetName().c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        // reset movement
        creature->GetMotionMaster()->MovementExpired(true);

        handler->PSendSysMessage(LANG_CREATURE_NOT_FOLLOW_YOU_NOW, creature->GetName().c_str());
        return true;
    }

    // make npc whisper to player
    static bool HandleNpcWhisperCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* receiver_str = strtok((char*)args, " ");
        char* text = strtok(nullptr, "");

        Creature* creature = handler->getSelectedCreature();
        if (!creature || !receiver_str || !text)
            return false;

        uint64 receiver_guid = atol(receiver_str);

        // check online security
        Player* receiver = ObjectAccessor::FindPlayer(receiver_guid);
        if (handler->HasLowerSecurity(receiver, 0))
            return false;

        creature->MonsterWhisper(text, receiver);
        return true;
    }

    static bool HandleNpcYellCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        Creature* creature = handler->getSelectedCreature();
        if (!creature)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        creature->MonsterYell(args, LANG_UNIVERSAL, nullptr);

        // make an emote
        creature->HandleEmoteCommand(EMOTE_ONESHOT_SHOUT);

        return true;
    }

    // add creature, temp only
    static bool HandleNpcAddTempSpawnCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        char* charID = handler->extractKeyFromLink((char*)args, "Hcreature_entry");
        if (!charID)
            return false;

        Player* chr = handler->GetSession()->GetPlayer();

        uint32 id = atoi(charID);
        if (!id)
            return false;

        chr->SummonCreature(id, *chr, TEMPSUMMON_CORPSE_DESPAWN, 120);

        return true;
    }

    //npc tame handling
    static bool HandleNpcTameCommand(ChatHandler* handler, const char* /*args*/)
    {
        Creature* creatureTarget = handler->getSelectedCreature();
        if (!creatureTarget || creatureTarget->IsPet())
        {
            handler->PSendSysMessage (LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage (true);
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();

        if (player->GetPetGUID())
        {
            handler->SendSysMessage (LANG_YOU_ALREADY_HAVE_PET);
            handler->SetSentErrorMessage (true);
            return false;
        }

        CreatureTemplate const* cInfo = creatureTarget->GetCreatureTemplate();

        if (!cInfo->IsTameable(player->CanTameExoticPets()))
        {
            handler->PSendSysMessage (LANG_CREATURE_NON_TAMEABLE, cInfo->Entry);
            handler->SetSentErrorMessage (true);
            return false;
        }

        // Everything looks OK, create new pet
        Pet* pet = player->CreateTamedPetFrom(creatureTarget);
        if (!pet)
        {
            handler->PSendSysMessage (LANG_CREATURE_NON_TAMEABLE, cInfo->Entry);
            handler->SetSentErrorMessage (true);
            return false;
        }

        // place pet before player
        float x, y, z;
        player->GetClosePoint (x, y, z, creatureTarget->GetCombatReach(), CONTACT_DISTANCE);
        pet->Relocate(x, y, z, M_PI-player->GetOrientation());

        // set pet to defensive mode by default (some classes can't control controlled pets in fact).
        pet->SetReactState(REACT_DEFENSIVE);

        // calculate proper level
        uint8 level = (creatureTarget->getLevel() < (player->getLevel() - 5)) ? (player->getLevel() - 5) : creatureTarget->getLevel();

        // prepare visual effect for levelup
        pet->SetUInt32Value(UNIT_FIELD_LEVEL, level - 1);

        // add to world
        pet->GetMap()->AddToMap(pet->ToCreature());

        // visual effect for levelup
        pet->SetUInt32Value(UNIT_FIELD_LEVEL, level);

        // caster have pet now
        player->SetMinion(pet, true);

        pet->SavePetToDB(PET_SAVE_AS_CURRENT, false);
        player->PetSpellInitialize();

        return true;
    }

    static bool HandleNpcAddFormationCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        uint32 leaderGUID = (uint32) atoi((char*)args);
        Creature* creature = handler->getSelectedCreature();

        if (!creature || !creature->GetDBTableGUIDLow())
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 lowguid = creature->GetDBTableGUIDLow();
        if (creature->GetFormation())
        {
            handler->PSendSysMessage("Selected creature is already member of group %u", creature->GetFormation()->GetId());
            return false;
        }

        if (!lowguid)
            return false;

        Player* chr = handler->GetSession()->GetPlayer();
        FormationInfo* group_member;

        group_member                 = new FormationInfo;
        group_member->follow_angle   = (creature->GetAngle(chr) - chr->GetOrientation()) * 180 / M_PI;
        group_member->follow_dist    = sqrtf(pow(chr->GetPositionX() - creature->GetPositionX(), int(2))+pow(chr->GetPositionY() - creature->GetPositionY(), int(2)));
        group_member->leaderGUID     = leaderGUID;
        group_member->groupAI        = 0;

        sFormationMgr->CreatureGroupMap[lowguid] = group_member;
        creature->SearchFormation();

        PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_INS_CREATURE_FORMATION);

        stmt->setUInt32(0, leaderGUID);
        stmt->setUInt32(1, lowguid);
        stmt->setFloat(2, group_member->follow_dist);
        stmt->setFloat(3, group_member->follow_angle);
        stmt->setUInt32(4, uint32(group_member->groupAI));

        WorldDatabase.Execute(stmt);

        handler->PSendSysMessage("Creature %u added to formation with leader %u", lowguid, leaderGUID);

        return true;
    }

    static bool HandleNpcSetLinkCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        uint32 linkguid = (uint32) atoi((char*)args);

        Creature* creature = handler->getSelectedCreature();

        if (!creature)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!creature->GetDBTableGUIDLow())
        {
            handler->PSendSysMessage("Selected creature %u isn't in creature table", creature->GetGUIDLow());
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!sObjectMgr->SetCreatureLinkedRespawn(creature->GetDBTableGUIDLow(), linkguid))
        {
            handler->PSendSysMessage("Selected creature can't link with guid '%u'", linkguid);
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage("LinkGUID '%u' added to creature with DBTableGUID: '%u'", linkguid, creature->GetDBTableGUIDLow());
        return true;
    }

    //TODO: NpcCommands that need to be fixed :
    static bool HandleNpcAddWeaponCommand(ChatHandler* /*handler*/, const char* /*args*/)
    {
        /*if (!*args)
            return false;

        uint64 guid = handler->GetSession()->GetPlayer()->GetSelection();
        if (guid == 0)
        {
            handler->SendSysMessage(LANG_NO_SELECTION);
            return true;
        }

        Creature* creature = ObjectAccessor::GetCreature(*handler->GetSession()->GetPlayer(), guid);

        if (!creature)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            return true;
        }

        char* pSlotID = strtok((char*)args, " ");
        if (!pSlotID)
            return false;

        char* pItemID = strtok(nullptr, " ");
        if (!pItemID)
            return false;

        uint32 ItemID = atoi(pItemID);
        uint32 SlotID = atoi(pSlotID);

        ItemTemplate* tmpItem = sObjectMgr->GetItemTemplate(ItemID);

        bool added = false;
        if (tmpItem)
        {
            switch (SlotID)
            {
                case 1:
                    creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY, ItemID);
                    added = true;
                    break;
                case 2:
                    creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY_01, ItemID);
                    added = true;
                    break;
                case 3:
                    creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_DISPLAY_02, ItemID);
                    added = true;
                    break;
                default:
                    handler->PSendSysMessage(LANG_ITEM_SLOT_NOT_EXIST, SlotID);
                    added = false;
                    break;
            }

            if (added)
                handler->PSendSysMessage(LANG_ITEM_ADDED_TO_SLOT, ItemID, tmpItem->Name1, SlotID);
        }
        else
        {
            handler->PSendSysMessage(LANG_ITEM_NOT_FOUND, ItemID);
            return true;
        }
        */
        return true;
    }

    static bool HandleNpcSetNameCommand(ChatHandler* /*handler*/, const char* /*args*/)
    {
        /* Temp. disabled
        if (!*args)
            return false;

        if (strlen((char*)args)>75)
        {
            handler->PSendSysMessage(LANG_TOO_LONG_NAME, strlen((char*)args)-75);
            return true;
        }

        for (uint8 i = 0; i < strlen(args); ++i)
        {
            if (!isalpha(args[i]) && args[i] != ' ')
            {
                handler->SendSysMessage(LANG_CHARS_ONLY);
                return false;
            }
        }

        uint64 guid;
        guid = handler->GetSession()->GetPlayer()->GetSelection();
        if (guid == 0)
        {
            handler->SendSysMessage(LANG_NO_SELECTION);
            return true;
        }

        Creature* creature = ObjectAccessor::GetCreature(*handler->GetSession()->GetPlayer(), guid);

        if (!creature)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            return true;
        }

        creature->SetName(args);
        uint32 idname = sObjectMgr->AddCreatureTemplate(creature->GetName());
        creature->SetUInt32Value(OBJECT_FIELD_ENTRY, idname);

        creature->SaveToDB();
        */

        return true;
    }

    static bool HandleNpcSetSubNameCommand(ChatHandler* /*handler*/, const char* /*args*/)
    {
        /* Temp. disabled

        if (!*args)
            args = "";

        if (strlen((char*)args)>75)
        {
            handler->PSendSysMessage(LANG_TOO_LONG_SUBNAME, strlen((char*)args)-75);
            return true;
        }

        for (uint8 i = 0; i < strlen(args); i++)
        {
            if (!isalpha(args[i]) && args[i] != ' ')
            {
                handler->SendSysMessage(LANG_CHARS_ONLY);
                return false;
            }
        }
        uint64 guid;
        guid = handler->GetSession()->GetPlayer()->GetSelection();
        if (guid == 0)
        {
            handler->SendSysMessage(LANG_NO_SELECTION);
            return true;
        }

        Creature* creature = ObjectAccessor::GetCreature(*handler->GetSession()->GetPlayer(), guid);

        if (!creature)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            return true;
        }

        uint32 idname = sObjectMgr->AddCreatureSubName(creature->GetName().c_str(), args, creature->GetUInt32Value(UNIT_FIELD_DISPLAYID));
        creature->SetUInt32Value(OBJECT_FIELD_ENTRY, idname);

        creature->SaveToDB();
        */
        return true;
    }
};

void AddSC_npc_commandscript()
{
    new npc_commandscript();
}
