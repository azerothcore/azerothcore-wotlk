/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
Name: reload_commandscript
%Complete: 100
Comment: All reload related commands
Category: commandscripts
EndScriptData */

#include "AchievementMgr.h"
#include "AuctionHouseMgr.h"
#include "BattlegroundMgr.h"
#include "Chat.h"
#include "CreatureTextMgr.h"
#include "DisableMgr.h"
#include "GameGraveyard.h"
#include "Language.h"
#include "LFGMgr.h"
#include "MapManager.h"
#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "SkillDiscovery.h"
#include "SkillExtraItems.h"
#include "SmartAI.h"
#include "SpellMgr.h"
#include "TicketMgr.h"
#include "WardenCheckMgr.h"
#include "WaypointManager.h"
#include "StringConvert.h"
#include "Tokenize.h"

class reload_commandscript : public CommandScript
{
public:
    reload_commandscript() : CommandScript("reload_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> reloadAllCommandTable =
        {
            { "achievement", SEC_ADMINISTRATOR,  true,  &HandleReloadAllAchievementCommand, "" },
            { "area",        SEC_ADMINISTRATOR,  true,  &HandleReloadAllAreaCommand,       "" },
            { "gossips",     SEC_ADMINISTRATOR,  true,  &HandleReloadAllGossipsCommand,    "" },
            { "item",        SEC_ADMINISTRATOR,  true,  &HandleReloadAllItemCommand,       "" },
            { "locales",     SEC_ADMINISTRATOR,  true,  &HandleReloadAllLocalesCommand,    "" },
            { "loot",        SEC_ADMINISTRATOR,  true,  &HandleReloadAllLootCommand,       "" },
            { "npc",         SEC_ADMINISTRATOR,  true,  &HandleReloadAllNpcCommand,        "" },
            { "quest",       SEC_ADMINISTRATOR,  true,  &HandleReloadAllQuestCommand,      "" },
            { "scripts",     SEC_ADMINISTRATOR,  true,  &HandleReloadAllScriptsCommand,    "" },
            { "spell",       SEC_ADMINISTRATOR,  true,  &HandleReloadAllSpellCommand,      "" },
            { "",            SEC_ADMINISTRATOR,  true,  &HandleReloadAllCommand,           "" }
        };
        static std::vector<ChatCommand> reloadCommandTable =
        {
            { "auctions",                     SEC_ADMINISTRATOR, true,  &HandleReloadAuctionsCommand,                   "" },
            { "dungeon_access_template",      SEC_ADMINISTRATOR, true,  &HandleReloadDungeonAccessCommand,              "" },
            { "dungeon_access_requirements",  SEC_ADMINISTRATOR, true,  &HandleReloadDungeonAccessCommand,              "" },
            { "achievement_criteria_data",    SEC_ADMINISTRATOR, true,  &HandleReloadAchievementCriteriaDataCommand,    "" },
            { "achievement_reward",           SEC_ADMINISTRATOR, true,  &HandleReloadAchievementRewardCommand,          "" },
            { "all",                          SEC_ADMINISTRATOR, true,  nullptr,                                        "", reloadAllCommandTable },
            { "areatrigger",                  SEC_ADMINISTRATOR, true,  &HandleReloadAreaTriggerCommand,                "" },
            { "areatrigger_involvedrelation", SEC_ADMINISTRATOR, true,  &HandleReloadQuestAreaTriggersCommand,          "" },
            { "areatrigger_tavern",           SEC_ADMINISTRATOR, true,  &HandleReloadAreaTriggerTavernCommand,          "" },
            { "areatrigger_teleport",         SEC_ADMINISTRATOR, true,  &HandleReloadAreaTriggerTeleportCommand,        "" },
            { "autobroadcast",                SEC_ADMINISTRATOR, true,  &HandleReloadAutobroadcastCommand,              "" },
            { "broadcast_text",               SEC_ADMINISTRATOR, true,  &HandleReloadBroadcastTextCommand,              "" },
            { "battleground_template",        SEC_ADMINISTRATOR, true,  &HandleReloadBattlegroundTemplate,              "" },
            { "command",                      SEC_ADMINISTRATOR, true,  &HandleReloadCommandCommand,                    "" },
            { "conditions",                   SEC_ADMINISTRATOR, true,  &HandleReloadConditions,                        "" },
            { "config",                       SEC_ADMINISTRATOR, true,  &HandleReloadConfigCommand,                     "" },
            { "creature_text",                SEC_ADMINISTRATOR, true,  &HandleReloadCreatureText,                      "" },
            { "creature_questender",          SEC_ADMINISTRATOR, true,  &HandleReloadCreatureQuestEnderCommand,         "" },
            { "creature_linked_respawn",      SEC_GAMEMASTER,    true,  &HandleReloadLinkedRespawnCommand,              "" },
            { "creature_loot_template",       SEC_ADMINISTRATOR, true,  &HandleReloadLootTemplatesCreatureCommand,      "" },
            { "creature_onkill_reputation",   SEC_ADMINISTRATOR, true,  &HandleReloadOnKillReputationCommand,           "" },
            { "creature_queststarter",        SEC_ADMINISTRATOR, true,  &HandleReloadCreatureQuestStarterCommand,       "" },
            { "creature_template",            SEC_ADMINISTRATOR, true,  &HandleReloadCreatureTemplateCommand,           "" },
            { "disables",                     SEC_ADMINISTRATOR, true,  &HandleReloadDisablesCommand,                   "" },
            { "disenchant_loot_template",     SEC_ADMINISTRATOR, true,  &HandleReloadLootTemplatesDisenchantCommand,    "" },
            { "event_scripts",                SEC_ADMINISTRATOR, true,  &HandleReloadEventScriptsCommand,               "" },
            { "fishing_loot_template",        SEC_ADMINISTRATOR, true,  &HandleReloadLootTemplatesFishingCommand,       "" },
            { "game_graveyard",               SEC_ADMINISTRATOR, true,  &HandleReloadGameGraveyardCommand,              "" },
            { "graveyard_zone",               SEC_ADMINISTRATOR, true,  &HandleReloadGameGraveyardZoneCommand,          "" },
            { "game_tele",                    SEC_ADMINISTRATOR, true,  &HandleReloadGameTeleCommand,                   "" },
            { "gameobject_questender",        SEC_ADMINISTRATOR, true,  &HandleReloadGOQuestEnderCommand,               "" },
            { "gameobject_loot_template",     SEC_ADMINISTRATOR, true,  &HandleReloadLootTemplatesGameobjectCommand,    "" },
            { "gameobject_queststarter",      SEC_ADMINISTRATOR, true,  &HandleReloadGOQuestStarterCommand,             "" },
            { "gm_tickets",                   SEC_ADMINISTRATOR, true,  &HandleReloadGMTicketsCommand,                  "" },
            { "gossip_menu",                  SEC_ADMINISTRATOR, true,  &HandleReloadGossipMenuCommand,                 "" },
            { "gossip_menu_option",           SEC_ADMINISTRATOR, true,  &HandleReloadGossipMenuOptionCommand,           "" },
            { "item_enchantment_template",    SEC_ADMINISTRATOR, true,  &HandleReloadItemEnchantementsCommand,          "" },
            { "item_loot_template",           SEC_ADMINISTRATOR, true,  &HandleReloadLootTemplatesItemCommand,          "" },
            { "item_set_names",               SEC_ADMINISTRATOR, true,  &HandleReloadItemSetNamesCommand,               "" },
            { "lfg_dungeon_rewards",          SEC_ADMINISTRATOR, true,  &HandleReloadLfgRewardsCommand,                 "" },
            { "achievement_reward_locale",    SEC_ADMINISTRATOR, true,  &HandleReloadLocalesAchievementRewardCommand,   "" },
            { "creature_template_locale",     SEC_ADMINISTRATOR, true,  &HandleReloadLocalesCreatureCommand,            "" },
            { "creature_text_locale",         SEC_ADMINISTRATOR, true,  &HandleReloadLocalesCreatureTextCommand,        "" },
            { "gameobject_template_locale",   SEC_ADMINISTRATOR, true,  &HandleReloadLocalesGameobjectCommand,          "" },
            { "gossip_menu_option_locale",    SEC_ADMINISTRATOR, true,  &HandleReloadLocalesGossipMenuOptionCommand,    "" },
            { "item_template_locale",         SEC_ADMINISTRATOR, true,  &HandleReloadLocalesItemCommand,                "" },
            { "item_set_name_locale",         SEC_ADMINISTRATOR, true,  &HandleReloadLocalesItemSetNameCommand,         "" },
            { "npc_text_locale",              SEC_ADMINISTRATOR, true,  &HandleReloadLocalesNpcTextCommand,             "" },
            { "page_text_locale",             SEC_ADMINISTRATOR, true,  &HandleReloadLocalesPageTextCommand,            "" },
            { "points_of_interest_locale",    SEC_ADMINISTRATOR, true,  &HandleReloadLocalesPointsOfInterestCommand,    "" },
            { "quest_template_locale",        SEC_ADMINISTRATOR, true,  &HandleReloadLocalesQuestCommand,               "" },
            { "quest_offer_reward_locale",    SEC_ADMINISTRATOR, true,  &HandleReloadLocalesQuestOfferRewardCommand,    "" },
            { "quest_request_item_locale",    SEC_ADMINISTRATOR, true,  &HandleReloadLocalesQuestRequestItemsCommand,   "" },
            { "mail_level_reward",            SEC_ADMINISTRATOR, true,  &HandleReloadMailLevelRewardCommand,            "" },
            { "mail_loot_template",           SEC_ADMINISTRATOR, true,  &HandleReloadLootTemplatesMailCommand,          "" },
            { "milling_loot_template",        SEC_ADMINISTRATOR, true,  &HandleReloadLootTemplatesMillingCommand,       "" },
            { "npc_spellclick_spells",        SEC_ADMINISTRATOR, true,  &HandleReloadSpellClickSpellsCommand,           "" },
            { "npc_trainer",                  SEC_ADMINISTRATOR, true,  &HandleReloadNpcTrainerCommand,                 "" },
            { "npc_vendor",                   SEC_ADMINISTRATOR, true,  &HandleReloadNpcVendorCommand,                  "" },
            { "page_text",                    SEC_ADMINISTRATOR, true,  &HandleReloadPageTextsCommand,                  "" },
            { "pickpocketing_loot_template",  SEC_ADMINISTRATOR, true,  &HandleReloadLootTemplatesPickpocketingCommand, "" },
            { "points_of_interest",           SEC_ADMINISTRATOR, true,  &HandleReloadPointsOfInterestCommand,           "" },
            { "prospecting_loot_template",    SEC_ADMINISTRATOR, true,  &HandleReloadLootTemplatesProspectingCommand,   "" },
            { "quest_poi",                    SEC_ADMINISTRATOR, true,  &HandleReloadQuestPOICommand,                   "" },
            { "quest_template",               SEC_ADMINISTRATOR, true,  &HandleReloadQuestTemplateCommand,              "" },
            { "reference_loot_template",      SEC_ADMINISTRATOR, true,  &HandleReloadLootTemplatesReferenceCommand,     "" },
            { "reserved_name",                SEC_ADMINISTRATOR, true,  &HandleReloadReservedNameCommand,               "" },
            { "reputation_reward_rate",       SEC_ADMINISTRATOR, true,  &HandleReloadReputationRewardRateCommand,       "" },
            { "reputation_spillover_template", SEC_ADMINISTRATOR, true,  &HandleReloadReputationRewardRateCommand,      "" },
            { "skill_discovery_template",     SEC_ADMINISTRATOR, true,  &HandleReloadSkillDiscoveryTemplateCommand,     "" },
            { "skill_extra_item_template",    SEC_ADMINISTRATOR, true,  &HandleReloadSkillExtraItemTemplateCommand,     "" },
            { "skill_fishing_base_level",     SEC_ADMINISTRATOR, true,  &HandleReloadSkillFishingBaseLevelCommand,      "" },
            { "skinning_loot_template",       SEC_ADMINISTRATOR, true,  &HandleReloadLootTemplatesSkinningCommand,      "" },
            { "smart_scripts",                SEC_ADMINISTRATOR, true,  &HandleReloadSmartScripts,                      "" },
            { "spell_required",               SEC_ADMINISTRATOR, true,  &HandleReloadSpellRequiredCommand,              "" },
            { "spell_area",                   SEC_ADMINISTRATOR, true,  &HandleReloadSpellAreaCommand,                  "" },
            { "spell_bonus_data",             SEC_ADMINISTRATOR, true,  &HandleReloadSpellBonusesCommand,               "" },
            { "spell_group",                  SEC_ADMINISTRATOR, true,  &HandleReloadSpellGroupsCommand,                "" },
            { "spell_loot_template",          SEC_ADMINISTRATOR, true,  &HandleReloadLootTemplatesSpellCommand,         "" },
            { "spell_linked_spell",           SEC_ADMINISTRATOR, true,  &HandleReloadSpellLinkedSpellCommand,           "" },
            { "spell_pet_auras",              SEC_ADMINISTRATOR, true,  &HandleReloadSpellPetAurasCommand,              "" },
            { "spell_proc_event",             SEC_ADMINISTRATOR, true,  &HandleReloadSpellProcEventCommand,             "" },
            { "spell_proc",                   SEC_ADMINISTRATOR, true,  &HandleReloadSpellProcsCommand,                 "" },
            { "spell_scripts",                SEC_ADMINISTRATOR, true,  &HandleReloadSpellScriptsCommand,               "" },
            { "spell_target_position",        SEC_ADMINISTRATOR, true,  &HandleReloadSpellTargetPositionCommand,        "" },
            { "spell_threats",                SEC_ADMINISTRATOR, true,  &HandleReloadSpellThreatsCommand,               "" },
            { "spell_group_stack_rules",      SEC_ADMINISTRATOR, true,  &HandleReloadSpellGroupStackRulesCommand,       "" },
            { "acore_string",                 SEC_ADMINISTRATOR, true,  &HandleReloadAcoreStringCommand,              "" },
            { "warden_action",                SEC_ADMINISTRATOR, true,  &HandleReloadWardenactionCommand,               "" },
            { "waypoint_scripts",             SEC_ADMINISTRATOR, true,  &HandleReloadWpScriptsCommand,                  "" },
            { "waypoint_data",                SEC_ADMINISTRATOR, true,  &HandleReloadWpCommand,                         "" },
            { "vehicle_accessory",            SEC_ADMINISTRATOR, true,  &HandleReloadVehicleAccessoryCommand,           "" },
            { "vehicle_template_accessory",   SEC_ADMINISTRATOR, true,  &HandleReloadVehicleTemplateAccessoryCommand,   "" }
        };
        static std::vector<ChatCommand> commandTable =
        {
            { "reload",         SEC_ADMINISTRATOR,  true,  nullptr,                                                     "", reloadCommandTable }
        };
        return commandTable;
    }

    //reload commands
    static bool HandleReloadGMTicketsCommand(ChatHandler* /*handler*/, const char* /*args*/)
    {
        sTicketMgr->LoadTickets();
        return true;
    }

    static bool HandleReloadAllCommand(ChatHandler* handler, const char* /*args*/)
    {
        HandleReloadSkillFishingBaseLevelCommand(handler, "");

        HandleReloadAllAchievementCommand(handler, "");
        HandleReloadAllAreaCommand(handler, "");
        HandleReloadAllLootCommand(handler, "");
        HandleReloadAllNpcCommand(handler, "");
        HandleReloadAllQuestCommand(handler, "");
        HandleReloadAllSpellCommand(handler, "");
        HandleReloadAllItemCommand(handler, "");
        HandleReloadAllGossipsCommand(handler, "");
        HandleReloadAllLocalesCommand(handler, "");

        HandleReloadDungeonAccessCommand(handler, "");
        HandleReloadMailLevelRewardCommand(handler, "");
        HandleReloadCommandCommand(handler, "");
        HandleReloadReservedNameCommand(handler, "");
        HandleReloadAcoreStringCommand(handler, "");
        HandleReloadGameTeleCommand(handler, "");

        HandleReloadVehicleAccessoryCommand(handler, "");
        HandleReloadVehicleTemplateAccessoryCommand(handler, "");

        HandleReloadAutobroadcastCommand(handler, "");
        HandleReloadBroadcastTextCommand(handler, "");
        HandleReloadBattlegroundTemplate(handler, "");
        return true;
    }

    static bool HandleReloadBattlegroundTemplate(ChatHandler* handler, char const* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Battleground Templates...");
        sBattlegroundMgr->CreateInitialBattlegrounds();
        handler->SendGlobalGMSysMessage("DB table `battleground_template` reloaded.");
        return true;
    }

    static bool HandleReloadAllAchievementCommand(ChatHandler* handler, const char* /*args*/)
    {
        HandleReloadAchievementCriteriaDataCommand(handler, "");
        HandleReloadAchievementRewardCommand(handler, "");
        return true;
    }

    static bool HandleReloadAllAreaCommand(ChatHandler* handler, const char* /*args*/)
    {
        //HandleReloadQuestAreaTriggersCommand(handler, ""); -- reloaded in HandleReloadAllQuestCommand
        HandleReloadAreaTriggerTeleportCommand(handler, "");
        HandleReloadAreaTriggerTavernCommand(handler, "");
        HandleReloadGameGraveyardZoneCommand(handler, "");
        return true;
    }

    static bool HandleReloadAllLootCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Loot Tables...");
        LoadLootTables();
        handler->SendGlobalGMSysMessage("DB tables `*_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadAllNpcCommand(ChatHandler* handler, const char* args)
    {
        if (*args != 'a')                                          // will be reloaded from all_gossips
            HandleReloadNpcTrainerCommand(handler, "a");
        HandleReloadNpcVendorCommand(handler, "a");
        HandleReloadPointsOfInterestCommand(handler, "a");
        HandleReloadSpellClickSpellsCommand(handler, "a");
        return true;
    }

    static bool HandleReloadAllQuestCommand(ChatHandler* handler, const char* /*args*/)
    {
        HandleReloadQuestAreaTriggersCommand(handler, "a");
        HandleReloadQuestPOICommand(handler, "a");
        HandleReloadQuestTemplateCommand(handler, "a");

        LOG_INFO("server.loading", "Re-Loading Quests Relations...");
        sObjectMgr->LoadQuestStartersAndEnders();
        handler->SendGlobalGMSysMessage("DB tables `*_queststarter` and `*_questender` reloaded.");
        return true;
    }

    static bool HandleReloadAllScriptsCommand(ChatHandler* handler, const char* /*args*/)
    {
        if (sScriptMgr->IsScriptScheduled())
        {
            handler->PSendSysMessage("DB scripts used currently, please attempt reload later.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        LOG_INFO("server.loading", "Re-Loading Scripts...");
        HandleReloadEventScriptsCommand(handler, "a");
        HandleReloadSpellScriptsCommand(handler, "a");
        handler->SendGlobalGMSysMessage("DB tables `*_scripts` reloaded.");
        HandleReloadWpScriptsCommand(handler, "a");
        HandleReloadWpCommand(handler, "a");
        return true;
    }

    static bool HandleReloadAllSpellCommand(ChatHandler* handler, const char* /*args*/)
    {
        HandleReloadSkillDiscoveryTemplateCommand(handler, "a");
        HandleReloadSkillExtraItemTemplateCommand(handler, "a");
        HandleReloadSpellRequiredCommand(handler, "a");
        HandleReloadSpellAreaCommand(handler, "a");
        HandleReloadSpellGroupsCommand(handler, "a");
        HandleReloadSpellLinkedSpellCommand(handler, "a");
        HandleReloadSpellProcEventCommand(handler, "a");
        HandleReloadSpellProcsCommand(handler, "a");
        HandleReloadSpellBonusesCommand(handler, "a");
        HandleReloadSpellTargetPositionCommand(handler, "a");
        HandleReloadSpellThreatsCommand(handler, "a");
        HandleReloadSpellGroupStackRulesCommand(handler, "a");
        HandleReloadSpellPetAurasCommand(handler, "a");
        return true;
    }

    static bool HandleReloadAllGossipsCommand(ChatHandler* handler, const char* args)
    {
        HandleReloadGossipMenuCommand(handler, "a");
        HandleReloadGossipMenuOptionCommand(handler, "a");
        if (*args != 'a')                                          // already reload from all_scripts
            HandleReloadPointsOfInterestCommand(handler, "a");
        return true;
    }

    static bool HandleReloadAllItemCommand(ChatHandler* handler, const char* /*args*/)
    {
        HandleReloadPageTextsCommand(handler, "a");
        HandleReloadItemEnchantementsCommand(handler, "a");
        return true;
    }

    static bool HandleReloadAllLocalesCommand(ChatHandler* handler, const char* /*args*/)
    {
        HandleReloadLocalesAchievementRewardCommand(handler, "a");
        HandleReloadLocalesCreatureCommand(handler, "a");
        HandleReloadLocalesCreatureTextCommand(handler, "a");
        HandleReloadLocalesGameobjectCommand(handler, "a");
        HandleReloadLocalesGossipMenuOptionCommand(handler, "a");
        HandleReloadLocalesItemCommand(handler, "a");
        HandleReloadLocalesNpcTextCommand(handler, "a");
        HandleReloadLocalesPageTextCommand(handler, "a");
        HandleReloadLocalesPointsOfInterestCommand(handler, "a");
        HandleReloadLocalesQuestCommand(handler, "a");
        HandleReloadLocalesQuestOfferRewardCommand(handler, "a");
        HandleReloadLocalesQuestRequestItemsCommand(handler, "a");
        return true;
    }

    static bool HandleReloadConfigCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading config settings...");
        sWorld->LoadConfigSettings(true);
        sMapMgr->InitializeVisibilityDistanceInfo();
        handler->SendGlobalGMSysMessage("World config settings reloaded.");
        return true;
    }

    static bool HandleReloadDungeonAccessCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Dungeon Access Requirement definitions...");
        sObjectMgr->LoadAccessRequirements();
        handler->SendGlobalGMSysMessage("DB tables `dungeon_access_template` AND `dungeon_access_requirements` reloaded.");
        return true;
    }

    static bool HandleReloadAchievementCriteriaDataCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Additional Achievement Criteria Data...");
        sAchievementMgr->LoadAchievementCriteriaData();
        handler->SendGlobalGMSysMessage("DB table `achievement_criteria_data` reloaded.");
        return true;
    }

    static bool HandleReloadAchievementRewardCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Achievement Reward Data...");
        sAchievementMgr->LoadRewards();
        handler->SendGlobalGMSysMessage("DB table `achievement_reward` reloaded.");
        return true;
    }

    static bool HandleReloadAreaTriggerTavernCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Tavern Area Triggers...");
        sObjectMgr->LoadTavernAreaTriggers();
        handler->SendGlobalGMSysMessage("DB table `areatrigger_tavern` reloaded.");
        return true;
    }

    static bool HandleReloadAreaTriggerCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Area Trigger definitions...");
        sObjectMgr->LoadAreaTriggers();
        handler->SendGlobalGMSysMessage("DB table `areatrigger` reloaded.");
        return true;
    }

    static bool HandleReloadAreaTriggerTeleportCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Area Trigger teleport definitions...");
        sObjectMgr->LoadAreaTriggerTeleports();
        handler->SendGlobalGMSysMessage("DB table `areatrigger_teleport` reloaded.");
        return true;
    }

    static bool HandleReloadAutobroadcastCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Autobroadcasts...");
        sWorld->LoadAutobroadcasts();
        handler->SendGlobalGMSysMessage("DB table `autobroadcast` reloaded.");
        return true;
    }

    static bool HandleReloadBroadcastTextCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Broadcast texts...");
        sObjectMgr->LoadBroadcastTexts();
        sObjectMgr->LoadBroadcastTextLocales();
        handler->SendGlobalGMSysMessage("DB table `broadcast_text` reloaded.");
        return true;
    }

    static bool HandleReloadCommandCommand(ChatHandler* handler, const char* /*args*/)
    {
        handler->SetLoadCommandTable(true);
        handler->SendGlobalGMSysMessage("DB table `command` will be reloaded at next chat command use.");
        return true;
    }

    static bool HandleReloadOnKillReputationCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading creature award reputation definitions...");
        sObjectMgr->LoadReputationOnKill();
        handler->SendGlobalGMSysMessage("DB table `creature_onkill_reputation` reloaded.");
        return true;
    }

    static bool HandleReloadCreatureTemplateCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        for (std::string_view entryStr : Acore::Tokenize(args, ' ', false))
        {
            uint32 entry = Acore::StringTo<uint32>(entryStr).value_or(0);

            WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_CREATURE_TEMPLATE);
            stmt->setUInt32(0, entry);
            PreparedQueryResult result = WorldDatabase.Query(stmt);

            if (!result)
            {
                handler->PSendSysMessage(LANG_COMMAND_CREATURETEMPLATE_NOTFOUND, entry);
                continue;
            }

            CreatureTemplate* cInfo = const_cast<CreatureTemplate*>(sObjectMgr->GetCreatureTemplate(entry));
            if (!cInfo)
            {
                handler->PSendSysMessage(LANG_COMMAND_CREATURESTORAGE_NOTFOUND, entry);
                continue;
            }

            LOG_INFO("server.loading", "Reloading creature template entry %u", entry);

            Field* fields = result->Fetch();

            sObjectMgr->LoadCreatureTemplate(fields);
            sObjectMgr->CheckCreatureTemplate(cInfo);
        }

        handler->SendGlobalGMSysMessage("Creature template reloaded.");
        return true;
    }

    static bool HandleReloadCreatureQuestStarterCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Loading Quests Relations... (`creature_queststarter`)");
        sObjectMgr->LoadCreatureQuestStarters();
        handler->SendGlobalGMSysMessage("DB table `creature_queststarter` reloaded.");
        return true;
    }

    static bool HandleReloadLinkedRespawnCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Loading Linked Respawns... (`creature_linked_respawn`)");
        sObjectMgr->LoadLinkedRespawn();
        handler->SendGlobalGMSysMessage("DB table `creature_linked_respawn` (creature linked respawns) reloaded.");
        return true;
    }

    static bool HandleReloadCreatureQuestEnderCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Loading Quests Relations... (`creature_questender`)");
        sObjectMgr->LoadCreatureQuestEnders();
        handler->SendGlobalGMSysMessage("DB table `creature_questender` reloaded.");
        return true;
    }

    static bool HandleReloadGossipMenuCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading `gossip_menu` Table!");
        sObjectMgr->LoadGossipMenu();
        handler->SendGlobalGMSysMessage("DB table `gossip_menu` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadGossipMenuOptionCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading `gossip_menu_option` Table!");
        sObjectMgr->LoadGossipMenuItems();
        handler->SendGlobalGMSysMessage("DB table `gossip_menu_option` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadGOQuestStarterCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Loading Quests Relations... (`gameobject_queststarter`)");
        sObjectMgr->LoadGameobjectQuestStarters();
        handler->SendGlobalGMSysMessage("DB table `gameobject_queststarter` reloaded.");
        return true;
    }

    static bool HandleReloadGOQuestEnderCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Loading Quests Relations... (`gameobject_questender`)");
        sObjectMgr->LoadGameobjectQuestEnders();
        handler->SendGlobalGMSysMessage("DB table `gameobject_questender` reloaded.");
        return true;
    }

    static bool HandleReloadQuestAreaTriggersCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Quest Area Triggers...");
        sObjectMgr->LoadQuestAreaTriggers();
        handler->SendGlobalGMSysMessage("DB table `areatrigger_involvedrelation` (quest area triggers) reloaded.");
        return true;
    }

    static bool HandleReloadQuestTemplateCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Quest Templates...");
        sObjectMgr->LoadQuests();
        handler->SendGlobalGMSysMessage("DB table `quest_template` (quest definitions) reloaded.");

        /// dependent also from `gameobject` but this table not reloaded anyway
        LOG_INFO("server.loading", "Re-Loading GameObjects for quests...");
        sObjectMgr->LoadGameObjectForQuests();
        handler->SendGlobalGMSysMessage("Data GameObjects for quests reloaded.");
        return true;
    }

    static bool HandleReloadLootTemplatesCreatureCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Loot Tables... (`creature_loot_template`)");
        LoadLootTemplates_Creature();
        LootTemplates_Creature.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `creature_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesDisenchantCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Loot Tables... (`disenchant_loot_template`)");
        LoadLootTemplates_Disenchant();
        LootTemplates_Disenchant.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `disenchant_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesFishingCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Loot Tables... (`fishing_loot_template`)");
        LoadLootTemplates_Fishing();
        LootTemplates_Fishing.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `fishing_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesGameobjectCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Loot Tables... (`gameobject_loot_template`)");
        LoadLootTemplates_Gameobject();
        LootTemplates_Gameobject.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `gameobject_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesItemCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Loot Tables... (`item_loot_template`)");
        LoadLootTemplates_Item();
        LootTemplates_Item.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `item_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesMillingCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Loot Tables... (`milling_loot_template`)");
        LoadLootTemplates_Milling();
        LootTemplates_Milling.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `milling_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesPickpocketingCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Loot Tables... (`pickpocketing_loot_template`)");
        LoadLootTemplates_Pickpocketing();
        LootTemplates_Pickpocketing.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `pickpocketing_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesProspectingCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Loot Tables... (`prospecting_loot_template`)");
        LoadLootTemplates_Prospecting();
        LootTemplates_Prospecting.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `prospecting_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesMailCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Loot Tables... (`mail_loot_template`)");
        LoadLootTemplates_Mail();
        LootTemplates_Mail.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `mail_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesReferenceCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Loot Tables... (`reference_loot_template`)");
        LoadLootTemplates_Reference();
        handler->SendGlobalGMSysMessage("DB table `reference_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesSkinningCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Loot Tables... (`skinning_loot_template`)");
        LoadLootTemplates_Skinning();
        LootTemplates_Skinning.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `skinning_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesSpellCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Loot Tables... (`spell_loot_template`)");
        LoadLootTemplates_Spell();
        LootTemplates_Spell.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `spell_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadAcoreStringCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading acore_string Table!");
        sObjectMgr->LoadAcoreStrings();
        handler->SendGlobalGMSysMessage("DB table `acore_string` reloaded.");
        return true;
    }

    static bool HandleReloadWardenactionCommand(ChatHandler* handler, const char* /*args*/)
    {
        if (!sWorld->getBoolConfig(CONFIG_WARDEN_ENABLED))
        {
            handler->SendSysMessage("Warden system disabled by config - reloading warden_action skipped.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        LOG_INFO("server.loading", "Re-Loading warden_action Table!");
        sWardenCheckMgr->LoadWardenOverrides();
        handler->SendGlobalGMSysMessage("DB table `warden_action` reloaded.");
        return true;
    }

    static bool HandleReloadNpcTrainerCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading `npc_trainer` Table!");
        sObjectMgr->LoadTrainerSpell();
        handler->SendGlobalGMSysMessage("DB table `npc_trainer` reloaded.");
        return true;
    }

    static bool HandleReloadNpcVendorCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading `npc_vendor` Table!");
        sObjectMgr->LoadVendors();
        handler->SendGlobalGMSysMessage("DB table `npc_vendor` reloaded.");
        return true;
    }

    static bool HandleReloadPointsOfInterestCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading `points_of_interest` Table!");
        sObjectMgr->LoadPointsOfInterest();
        handler->SendGlobalGMSysMessage("DB table `points_of_interest` reloaded.");
        return true;
    }

    static bool HandleReloadQuestPOICommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Quest POI ..." );
        sObjectMgr->LoadQuestPOI();
        handler->SendGlobalGMSysMessage("DB Table `quest_poi` and `quest_poi_points` reloaded.");
        return true;
    }

    static bool HandleReloadSpellClickSpellsCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading `npc_spellclick_spells` Table!");
        sObjectMgr->LoadNPCSpellClickSpells();
        handler->SendGlobalGMSysMessage("DB table `npc_spellclick_spells` reloaded.");
        return true;
    }

    static bool HandleReloadReservedNameCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Loading ReservedNames... (`reserved_name`)");
        sObjectMgr->LoadReservedPlayersNames();
        handler->SendGlobalGMSysMessage("DB table `reserved_name` (player reserved names) reloaded.");
        return true;
    }

    static bool HandleReloadReputationRewardRateCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading `reputation_reward_rate` Table!" );
        sObjectMgr->LoadReputationRewardRate();
        handler->SendGlobalSysMessage("DB table `reputation_reward_rate` reloaded.");
        return true;
    }

    static bool HandleReloadReputationSpilloverTemplateCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading `reputation_spillover_template` Table!" );
        sObjectMgr->LoadReputationSpilloverTemplate();
        handler->SendGlobalSysMessage("DB table `reputation_spillover_template` reloaded.");
        return true;
    }

    static bool HandleReloadSkillDiscoveryTemplateCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Skill Discovery Table...");
        LoadSkillDiscoveryTable();
        handler->SendGlobalGMSysMessage("DB table `skill_discovery_template` (recipes discovered at crafting) reloaded.");
        return true;
    }

    static bool HandleReloadSkillPerfectItemTemplateCommand(ChatHandler* handler, const char* /*args*/)
    {
        // latched onto HandleReloadSkillExtraItemTemplateCommand as it's part of that table group (and i don't want to chance all the command IDs)
        LOG_INFO("server.loading", "Re-Loading Skill Perfection Data Table...");
        LoadSkillPerfectItemTable();
        handler->SendGlobalGMSysMessage("DB table `skill_perfect_item_template` (perfect item procs when crafting) reloaded.");
        return true;
    }

    static bool HandleReloadSkillExtraItemTemplateCommand(ChatHandler* handler, const char* args)
    {
        LOG_INFO("server.loading", "Re-Loading Skill Extra Item Table...");
        LoadSkillExtraItemTable();
        handler->SendGlobalGMSysMessage("DB table `skill_extra_item_template` (extra item creation when crafting) reloaded.");
        return HandleReloadSkillPerfectItemTemplateCommand(handler, args);
    }

    static bool HandleReloadSkillFishingBaseLevelCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Skill Fishing base level requirements...");
        sObjectMgr->LoadFishingBaseSkillLevel();
        handler->SendGlobalGMSysMessage("DB table `skill_fishing_base_level` (fishing base level for zone/subzone) reloaded.");
        return true;
    }

    static bool HandleReloadSpellAreaCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading SpellArea Data...");
        sSpellMgr->LoadSpellAreas();
        handler->SendGlobalGMSysMessage("DB table `spell_area` (spell dependences from area/quest/auras state) reloaded.");
        return true;
    }

    static bool HandleReloadSpellRequiredCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Spell Required Data... ");
        sSpellMgr->LoadSpellRequired();
        handler->SendGlobalGMSysMessage("DB table `spell_required` reloaded.");
        return true;
    }

    static bool HandleReloadSpellGroupsCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Spell Groups...");
        sSpellMgr->LoadSpellGroups();
        handler->SendGlobalGMSysMessage("DB table `spell_group` (spell groups) reloaded.");
        return true;
    }

    static bool HandleReloadSpellLinkedSpellCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Spell Linked Spells...");
        sSpellMgr->LoadSpellLinked();
        handler->SendGlobalGMSysMessage("DB table `spell_linked_spell` reloaded.");
        return true;
    }

    static bool HandleReloadSpellProcEventCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Spell Proc Event conditions...");
        sSpellMgr->LoadSpellProcEvents();
        handler->SendGlobalGMSysMessage("DB table `spell_proc_event` (spell proc trigger requirements) reloaded.");
        return true;
    }

    static bool HandleReloadSpellProcsCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Spell Proc conditions and data...");
        sSpellMgr->LoadSpellProcs();
        handler->SendGlobalGMSysMessage("DB table `spell_proc` (spell proc conditions and data) reloaded.");
        return true;
    }

    static bool HandleReloadSpellBonusesCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Spell Bonus Data...");
        sSpellMgr->LoadSpellBonusess();
        handler->SendGlobalGMSysMessage("DB table `spell_bonus_data` (spell damage/healing coefficients) reloaded.");
        return true;
    }

    static bool HandleReloadSpellTargetPositionCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Spell target coordinates...");
        sSpellMgr->LoadSpellTargetPositions();
        handler->SendGlobalGMSysMessage("DB table `spell_target_position` (destination coordinates for spell targets) reloaded.");
        return true;
    }

    static bool HandleReloadSpellThreatsCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Aggro Spells Definitions...");
        sSpellMgr->LoadSpellThreats();
        handler->SendGlobalGMSysMessage("DB table `spell_threat` (spell aggro definitions) reloaded.");
        return true;
    }

    static bool HandleReloadSpellGroupStackRulesCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Spell Group Stack Rules...");
        sSpellMgr->LoadSpellGroupStackRules();
        handler->SendGlobalGMSysMessage("DB table `spell_group_stack_rules` (spell stacking definitions) reloaded.");
        return true;
    }

    static bool HandleReloadSpellPetAurasCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Spell pet auras...");
        sSpellMgr->LoadSpellPetAuras();
        handler->SendGlobalGMSysMessage("DB table `spell_pet_auras` reloaded.");
        return true;
    }

    static bool HandleReloadPageTextsCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Page Texts...");
        sObjectMgr->LoadPageTexts();
        handler->SendGlobalGMSysMessage("DB table `page_texts` reloaded.");
        handler->GetSession()->SendNotification("You need to delete your client cache or change the cache number in config in order for your players see the changes.");
        return true;
    }

    static bool HandleReloadItemEnchantementsCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Item Random Enchantments Table...");
        LoadRandomEnchantmentsTable();
        handler->SendGlobalGMSysMessage("DB table `item_enchantment_template` reloaded.");
        return true;
    }

    static bool HandleReloadItemSetNamesCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Item set names...");
        sObjectMgr->LoadItemSetNames();
        handler->SendGlobalGMSysMessage("DB table `item_set_names` reloaded.");
        return true;
    }

    static bool HandleReloadEventScriptsCommand(ChatHandler* handler, const char* args)
    {
        if (sScriptMgr->IsScriptScheduled())
        {
            handler->SendSysMessage("DB scripts used currently, please attempt reload later.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (*args != 'a')
            LOG_INFO("server.loading", "Re-Loading Scripts from `event_scripts`...");

        sObjectMgr->LoadEventScripts();

        if (*args != 'a')
            handler->SendGlobalGMSysMessage("DB table `event_scripts` reloaded.");

        return true;
    }

    static bool HandleReloadWpScriptsCommand(ChatHandler* handler, const char* args)
    {
        if (sScriptMgr->IsScriptScheduled())
        {
            handler->SendSysMessage("DB scripts used currently, please attempt reload later.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (*args != 'a')
            LOG_INFO("server.loading", "Re-Loading Scripts from `waypoint_scripts`...");

        sObjectMgr->LoadWaypointScripts();

        if (*args != 'a')
            handler->SendGlobalGMSysMessage("DB table `waypoint_scripts` reloaded.");

        return true;
    }

    static bool HandleReloadWpCommand(ChatHandler* handler, const char* args)
    {
        if (*args != 'a')
            LOG_INFO("server.loading", "Re-Loading Waypoints data from 'waypoints_data'");

        sWaypointMgr->Load();

        if (*args != 'a')
            handler->SendGlobalGMSysMessage("DB Table 'waypoint_data' reloaded.");

        return true;
    }

    static bool HandleReloadSpellScriptsCommand(ChatHandler* handler, const char* args)
    {
        if (sScriptMgr->IsScriptScheduled())
        {
            handler->SendSysMessage("DB scripts used currently, please attempt reload later.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (*args != 'a')
            LOG_INFO("server.loading", "Re-Loading Scripts from `spell_scripts`...");

        sObjectMgr->LoadSpellScripts();

        if (*args != 'a')
            handler->SendGlobalGMSysMessage("DB table `spell_scripts` reloaded.");

        return true;
    }

    static bool HandleReloadGameGraveyardZoneCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Graveyard-zone links...");

        sGraveyard->LoadGraveyardZones();

        handler->SendGlobalGMSysMessage("DB table `graveyard_zone` reloaded.");

        return true;
    }

    static bool HandleReloadGameTeleCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Game Tele coordinates...");

        sObjectMgr->LoadGameTele();

        handler->SendGlobalGMSysMessage("DB table `game_tele` reloaded.");

        return true;
    }

    static bool HandleReloadDisablesCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading disables table...");
        DisableMgr::LoadDisables();
        LOG_INFO("server.loading", "Checking quest disables...");
        DisableMgr::CheckQuestDisables();
        handler->SendGlobalGMSysMessage("DB table `disables` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesAchievementRewardCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Achievement Reward Data Locale...");
        sAchievementMgr->LoadRewardLocales();
        handler->SendGlobalGMSysMessage("DB table `achievement_reward_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLfgRewardsCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading lfg dungeon rewards...");
        sLFGMgr->LoadRewards();
        handler->SendGlobalGMSysMessage("DB table `lfg_dungeon_rewards` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesCreatureCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Creature Template Locale...");
        sObjectMgr->LoadCreatureLocales();
        handler->SendGlobalGMSysMessage("DB table `creature_template_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesCreatureTextCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Creature Texts Locale...");
        sCreatureTextMgr->LoadCreatureTextLocales();
        handler->SendGlobalGMSysMessage("DB table `creature_text_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesGameobjectCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Gameobject Template Locale ... ");
        sObjectMgr->LoadGameObjectLocales();
        handler->SendGlobalGMSysMessage("DB table `gameobject_template_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesGossipMenuOptionCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Gossip Menu Option Locale ... ");
        sObjectMgr->LoadGossipMenuItemsLocales();
        handler->SendGlobalGMSysMessage("DB table `gossip_menu_option_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesItemCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Item Template Locale ... ");
        sObjectMgr->LoadItemLocales();
        handler->SendGlobalGMSysMessage("DB table `item_template_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesItemSetNameCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Item set name Locale... ");
        sObjectMgr->LoadItemSetNameLocales();
        handler->SendGlobalGMSysMessage("DB table `item_set_name_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesNpcTextCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading NPC Text Locale ... ");
        sObjectMgr->LoadNpcTextLocales();
        handler->SendGlobalGMSysMessage("DB table `npc_text_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesPageTextCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Page Text Locale ... ");
        sObjectMgr->LoadPageTextLocales();
        handler->SendGlobalGMSysMessage("DB table `page_text_locale` reloaded.");
        handler->GetSession()->SendNotification("You need to delete your client cache or change the cache number in config in order for your players see the changes.");
        return true;
    }

    static bool HandleReloadLocalesPointsOfInterestCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Points Of Interest Locale ... ");
        sObjectMgr->LoadPointOfInterestLocales();
        handler->SendGlobalGMSysMessage("DB table `points_of_interest_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesQuestCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Locales Quest ... ");
        sObjectMgr->LoadQuestLocales();
        handler->SendGlobalGMSysMessage("DB table `quest_template_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesQuestOfferRewardCommand(ChatHandler* handler, char const* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Quest Offer Reward Locale... ");
        sObjectMgr->LoadQuestOfferRewardLocale();
        handler->SendGlobalGMSysMessage("DB table `quest_offer_reward_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesQuestRequestItemsCommand(ChatHandler* handler, char const* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Quest Request Item Locale... ");
        sObjectMgr->LoadQuestRequestItemsLocale();
        handler->SendGlobalGMSysMessage("DB table `quest_request_item_locale` reloaded.");
        return true;
    }

    static bool HandleReloadMailLevelRewardCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Player level dependent mail rewards...");
        sObjectMgr->LoadMailLevelRewards();
        handler->SendGlobalGMSysMessage("DB table `mail_level_reward` reloaded.");
        return true;
    }

    static bool HandleReloadAuctionsCommand(ChatHandler* handler, const char* /*args*/)
    {
        ///- Reload dynamic data tables from the database
        LOG_INFO("server.loading", "Re-Loading Auctions...");
        sAuctionMgr->LoadAuctionItems();
        sAuctionMgr->LoadAuctions();
        handler->SendGlobalGMSysMessage("Auctions reloaded.");
        return true;
    }

    static bool HandleReloadConditions(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Conditions...");
        sConditionMgr->LoadConditions(true);
        handler->SendGlobalGMSysMessage("Conditions reloaded.");
        return true;
    }

    static bool HandleReloadCreatureText(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Creature Texts...");
        sCreatureTextMgr->LoadCreatureTexts();
        handler->SendGlobalGMSysMessage("Creature Texts reloaded.");
        return true;
    }

    static bool HandleReloadSmartScripts(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Re-Loading Smart Scripts...");
        sSmartScriptMgr->LoadSmartAIFromDB();
        handler->SendGlobalGMSysMessage("Smart Scripts reloaded.");
        return true;
    }

    static bool HandleReloadVehicleAccessoryCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Reloading vehicle_accessory table...");
        sObjectMgr->LoadVehicleAccessories();
        handler->SendGlobalGMSysMessage("Vehicle accessories reloaded.");
        return true;
    }

    static bool HandleReloadVehicleTemplateAccessoryCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Reloading vehicle_template_accessory table...");
        sObjectMgr->LoadVehicleTemplateAccessories();
        handler->SendGlobalGMSysMessage("Vehicle template accessories reloaded.");
        return true;
    }

    static bool HandleReloadGameGraveyardCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.loading", "Reloading game_graveyard table...");
        sGraveyard->LoadGraveyardFromDB();
        handler->SendGlobalGMSysMessage("DB table `game_graveyard` reloaded.");
        return true;
    }
};

void AddSC_reload_commandscript()
{
    new reload_commandscript();
}
