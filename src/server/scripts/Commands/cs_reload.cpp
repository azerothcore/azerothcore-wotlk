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
Name: reload_commandscript
%Complete: 100
Comment: All reload related commands
Category: commandscripts
EndScriptData */

#include "AchievementMgr.h"
#include "AuctionHouseMgr.h"
#include "AutobroadcastMgr.h"
#include "BattlegroundMgr.h"
#include "Chat.h"
#include "CommandScript.h"
#include "CreatureTextMgr.h"
#include "DisableMgr.h"
#include "GameGraveyard.h"
#include "LFGMgr.h"
#include "Language.h"
#include "MapMgr.h"
#include "MotdMgr.h"
#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "SkillDiscovery.h"
#include "SkillExtraItems.h"
#include "SmartAI.h"
#include "SpellMgr.h"
#include "StringConvert.h"
#include "TicketMgr.h"
#include "Tokenize.h"
#include "WardenCheckMgr.h"
#include "WaypointMgr.h"

using namespace Acore::ChatCommands;

class reload_commandscript : public CommandScript
{
public:
    reload_commandscript() : CommandScript("reload_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable reloadAllCommandTable =
        {
            { "achievement",                   HandleReloadAllAchievementCommand,             SEC_ADMINISTRATOR, Console::Yes },
            { "area",                          HandleReloadAllAreaCommand,                    SEC_ADMINISTRATOR, Console::Yes },
            { "gossips",                       HandleReloadAllGossipsCommand,                 SEC_ADMINISTRATOR, Console::Yes },
            { "item",                          HandleReloadAllItemCommand,                    SEC_ADMINISTRATOR, Console::Yes },
            { "locales",                       HandleReloadAllLocalesCommand,                 SEC_ADMINISTRATOR, Console::Yes },
            { "loot",                          HandleReloadAllLootCommand,                    SEC_ADMINISTRATOR, Console::Yes },
            { "npc",                           HandleReloadAllNpcCommand,                     SEC_ADMINISTRATOR, Console::Yes },
            { "quest",                         HandleReloadAllQuestCommand,                   SEC_ADMINISTRATOR, Console::Yes },
            { "scripts",                       HandleReloadAllScriptsCommand,                 SEC_ADMINISTRATOR, Console::Yes },
            { "spell",                         HandleReloadAllSpellCommand,                   SEC_ADMINISTRATOR, Console::Yes },
            { "",                              HandleReloadAllCommand,                        SEC_ADMINISTRATOR, Console::Yes },
        };
        static ChatCommandTable reloadCommandTable =
        {
            { "auctions",                      HandleReloadAuctionsCommand,                   SEC_ADMINISTRATOR, Console::Yes },
            { "dungeon_access_template",       HandleReloadDungeonAccessCommand,              SEC_ADMINISTRATOR, Console::Yes },
            { "dungeon_access_requirements",   HandleReloadDungeonAccessCommand,              SEC_ADMINISTRATOR, Console::Yes },
            { "achievement_criteria_data",     HandleReloadAchievementCriteriaDataCommand,    SEC_ADMINISTRATOR, Console::Yes },
            { "achievement_reward",            HandleReloadAchievementRewardCommand,          SEC_ADMINISTRATOR, Console::Yes },
            { "all", reloadAllCommandTable },
            { "areatrigger",                   HandleReloadQuestAreaTriggersCommand,          SEC_ADMINISTRATOR, Console::Yes },
            { "areatrigger_involvedrelation",  HandleReloadQuestAreaTriggersCommand,          SEC_ADMINISTRATOR, Console::Yes },
            { "areatrigger_tavern",            HandleReloadAreaTriggerTavernCommand,          SEC_ADMINISTRATOR, Console::Yes },
            { "areatrigger_teleport",          HandleReloadAreaTriggerTeleportCommand,        SEC_ADMINISTRATOR, Console::Yes },
            { "autobroadcast",                 HandleReloadAutobroadcastCommand,              SEC_ADMINISTRATOR, Console::Yes },
            { "motd",                          HandleReloadMotdCommand,                       SEC_ADMINISTRATOR, Console::Yes },
            { "broadcast_text",                HandleReloadBroadcastTextCommand,              SEC_ADMINISTRATOR, Console::Yes },
            { "battleground_template",         HandleReloadBattlegroundTemplate,              SEC_ADMINISTRATOR, Console::Yes },
            { "command",                       HandleReloadCommandCommand,                    SEC_ADMINISTRATOR, Console::Yes },
            { "conditions",                    HandleReloadConditions,                        SEC_ADMINISTRATOR, Console::Yes },
            { "config",                        HandleReloadConfigCommand,                     SEC_ADMINISTRATOR, Console::Yes },
            { "creature_text",                 HandleReloadCreatureText,                      SEC_ADMINISTRATOR, Console::Yes },
            { "creature_questender",           HandleReloadCreatureQuestEnderCommand,         SEC_ADMINISTRATOR, Console::Yes },
            { "creature_linked_respawn",       HandleReloadLinkedRespawnCommand,              SEC_ADMINISTRATOR, Console::Yes },
            { "creature_loot_template",        HandleReloadLootTemplatesCreatureCommand,      SEC_ADMINISTRATOR, Console::Yes },
            { "creature_movement_override",     HandleReloadCreatureMovementOverrideCommand,    SEC_ADMINISTRATOR, Console::Yes},
            { "creature_onkill_reputation",     HandleReloadOnKillReputationCommand,           SEC_ADMINISTRATOR, Console::Yes },
            { "creature_queststarter",         HandleReloadCreatureQuestStarterCommand,       SEC_ADMINISTRATOR, Console::Yes },
            { "creature_template",             HandleReloadCreatureTemplateCommand,           SEC_ADMINISTRATOR, Console::Yes },
            { "disables",                      HandleReloadDisablesCommand,                   SEC_ADMINISTRATOR, Console::Yes },
            { "disenchant_loot_template",      HandleReloadLootTemplatesDisenchantCommand,    SEC_ADMINISTRATOR, Console::Yes },
            { "event_scripts",                 HandleReloadEventScriptsCommand,               SEC_ADMINISTRATOR, Console::Yes },
            { "fishing_loot_template",         HandleReloadLootTemplatesFishingCommand,       SEC_ADMINISTRATOR, Console::Yes },
            { "game_graveyard",                HandleReloadGameGraveyardCommand,              SEC_ADMINISTRATOR, Console::Yes },
            { "graveyard_zone",                HandleReloadGameGraveyardZoneCommand,          SEC_ADMINISTRATOR, Console::Yes },
            { "game_tele",                     HandleReloadGameTeleCommand,                   SEC_ADMINISTRATOR, Console::Yes },
            { "gameobject_questender",         HandleReloadGOQuestEnderCommand,               SEC_ADMINISTRATOR, Console::Yes },
            { "gameobject_loot_template",      HandleReloadLootTemplatesGameobjectCommand,    SEC_ADMINISTRATOR, Console::Yes },
            { "gameobject_queststarter",       HandleReloadGOQuestStarterCommand,             SEC_ADMINISTRATOR, Console::Yes },
            { "gm_tickets",                    HandleReloadGMTicketsCommand,                  SEC_ADMINISTRATOR, Console::Yes },
            { "gossip_menu",                   HandleReloadGossipMenuCommand,                 SEC_ADMINISTRATOR, Console::Yes },
            { "gossip_menu_option",            HandleReloadGossipMenuOptionCommand,           SEC_ADMINISTRATOR, Console::Yes },
            { "item_enchantment_template",     HandleReloadItemEnchantementsCommand,          SEC_ADMINISTRATOR, Console::Yes },
            { "item_loot_template",            HandleReloadLootTemplatesItemCommand,          SEC_ADMINISTRATOR, Console::Yes },
            { "item_set_names",                HandleReloadItemSetNamesCommand,               SEC_ADMINISTRATOR, Console::Yes },
            { "lfg_dungeon_rewards",           HandleReloadLfgRewardsCommand,                 SEC_ADMINISTRATOR, Console::Yes },
            { "achievement_reward_locale",     HandleReloadLocalesAchievementRewardCommand,   SEC_ADMINISTRATOR, Console::Yes },
            { "creature_template_locale",      HandleReloadLocalesCreatureCommand,            SEC_ADMINISTRATOR, Console::Yes },
            { "creature_text_locale",          HandleReloadLocalesCreatureTextCommand,        SEC_ADMINISTRATOR, Console::Yes },
            { "gameobject_template_locale",    HandleReloadLocalesGameobjectCommand,          SEC_ADMINISTRATOR, Console::Yes },
            { "gossip_menu_option_locale",     HandleReloadLocalesGossipMenuOptionCommand,    SEC_ADMINISTRATOR, Console::Yes },
            { "item_template_locale",          HandleReloadLocalesItemCommand,                SEC_ADMINISTRATOR, Console::Yes },
            { "item_set_name_locale",          HandleReloadLocalesItemSetNameCommand,         SEC_ADMINISTRATOR, Console::Yes },
            { "npc_text_locale",               HandleReloadLocalesNpcTextCommand,             SEC_ADMINISTRATOR, Console::Yes },
            { "page_text_locale",              HandleReloadLocalesPageTextCommand,            SEC_ADMINISTRATOR, Console::Yes },
            { "points_of_interest_locale",     HandleReloadLocalesPointsOfInterestCommand,    SEC_ADMINISTRATOR, Console::Yes },
            { "quest_template_locale",         HandleReloadLocalesQuestCommand,               SEC_ADMINISTRATOR, Console::Yes },
            { "quest_offer_reward_locale",     HandleReloadLocalesQuestOfferRewardCommand,    SEC_ADMINISTRATOR, Console::Yes },
            { "quest_request_item_locale",     HandleReloadLocalesQuestRequestItemsCommand,   SEC_ADMINISTRATOR, Console::Yes },
            { "mail_level_reward",             HandleReloadMailLevelRewardCommand,            SEC_ADMINISTRATOR, Console::Yes },
            { "mail_loot_template",            HandleReloadLootTemplatesMailCommand,          SEC_ADMINISTRATOR, Console::Yes },
            { "mail_server_template",          HandleReloadMailServerTemplateCommand,         SEC_ADMINISTRATOR, Console::Yes },
            { "milling_loot_template",         HandleReloadLootTemplatesMillingCommand,       SEC_ADMINISTRATOR, Console::Yes },
            { "npc_spellclick_spells",         HandleReloadSpellClickSpellsCommand,           SEC_ADMINISTRATOR, Console::Yes },
            { "npc_trainer",                   HandleReloadNpcTrainerCommand,                 SEC_ADMINISTRATOR, Console::Yes },
            { "npc_vendor",                    HandleReloadNpcVendorCommand,                  SEC_ADMINISTRATOR, Console::Yes },
            { "page_text",                     HandleReloadPageTextsCommand,                  SEC_ADMINISTRATOR, Console::Yes },
            { "pickpocketing_loot_template",   HandleReloadLootTemplatesPickpocketingCommand, SEC_ADMINISTRATOR, Console::Yes },
            { "points_of_interest",            HandleReloadPointsOfInterestCommand,           SEC_ADMINISTRATOR, Console::Yes },
            { "prospecting_loot_template",     HandleReloadLootTemplatesProspectingCommand,   SEC_ADMINISTRATOR, Console::Yes },
            { "quest_greeting",                HandleReloadQuestGreetingCommand,              SEC_ADMINISTRATOR, Console::Yes },
            { "quest_greeting_locale",         HandleReloadLocalesQuestGreetingCommand,       SEC_ADMINISTRATOR, Console::Yes },
            { "quest_poi",                     HandleReloadQuestPOICommand,                   SEC_ADMINISTRATOR, Console::Yes },
            { "quest_template",                HandleReloadQuestTemplateCommand,              SEC_ADMINISTRATOR, Console::Yes },
            { "reference_loot_template",       HandleReloadLootTemplatesReferenceCommand,     SEC_ADMINISTRATOR, Console::Yes },
            { "reserved_name",                 HandleReloadReservedNameCommand,               SEC_ADMINISTRATOR, Console::Yes },
            { "profanity_name",                HandleReloadProfanityNameCommand,              SEC_ADMINISTRATOR, Console::Yes },
            { "reputation_reward_rate",        HandleReloadReputationRewardRateCommand,       SEC_ADMINISTRATOR, Console::Yes },
            { "reputation_spillover_template", HandleReloadReputationRewardRateCommand,       SEC_ADMINISTRATOR, Console::Yes },
            { "skill_discovery_template",      HandleReloadSkillDiscoveryTemplateCommand,     SEC_ADMINISTRATOR, Console::Yes },
            { "skill_extra_item_template",     HandleReloadSkillExtraItemTemplateCommand,     SEC_ADMINISTRATOR, Console::Yes },
            { "skill_fishing_base_level",      HandleReloadSkillFishingBaseLevelCommand,      SEC_ADMINISTRATOR, Console::Yes },
            { "skinning_loot_template",        HandleReloadLootTemplatesSkinningCommand,      SEC_ADMINISTRATOR, Console::Yes },
            { "smart_scripts",                 HandleReloadSmartScripts,                      SEC_ADMINISTRATOR, Console::Yes },
            { "spell_required",                HandleReloadSpellRequiredCommand,              SEC_ADMINISTRATOR, Console::Yes },
            { "spell_area",                    HandleReloadSpellAreaCommand,                  SEC_ADMINISTRATOR, Console::Yes },
            { "spell_bonus_data",              HandleReloadSpellBonusesCommand,               SEC_ADMINISTRATOR, Console::Yes },
            { "spell_group",                   HandleReloadSpellGroupsCommand,                SEC_ADMINISTRATOR, Console::Yes },
            { "spell_loot_template",           HandleReloadLootTemplatesSpellCommand,         SEC_ADMINISTRATOR, Console::Yes },
            { "spell_linked_spell",            HandleReloadSpellLinkedSpellCommand,           SEC_ADMINISTRATOR, Console::Yes },
            { "spell_pet_auras",               HandleReloadSpellPetAurasCommand,              SEC_ADMINISTRATOR, Console::Yes },
            { "spell_proc_event",              HandleReloadSpellProcEventCommand,             SEC_ADMINISTRATOR, Console::Yes },
            { "spell_proc",                    HandleReloadSpellProcsCommand,                 SEC_ADMINISTRATOR, Console::Yes },
            { "spell_scripts",                 HandleReloadSpellScriptsCommand,               SEC_ADMINISTRATOR, Console::Yes },
            { "spell_target_position",         HandleReloadSpellTargetPositionCommand,        SEC_ADMINISTRATOR, Console::Yes },
            { "spell_threats",                 HandleReloadSpellThreatsCommand,               SEC_ADMINISTRATOR, Console::Yes },
            { "spell_group_stack_rules",       HandleReloadSpellGroupStackRulesCommand,       SEC_ADMINISTRATOR, Console::Yes },
            { "player_loot_template",          HandleReloadLootTemplatesPlayerCommand,        SEC_ADMINISTRATOR, Console::Yes },
            { "acore_string",                  HandleReloadAcoreStringCommand,                SEC_ADMINISTRATOR, Console::Yes },
            { "warden_action",                 HandleReloadWardenactionCommand,               SEC_ADMINISTRATOR, Console::Yes },
            { "waypoint_scripts",              HandleReloadWpScriptsCommand,                  SEC_ADMINISTRATOR, Console::Yes },
            { "waypoint_data",                 HandleReloadWpCommand,                         SEC_ADMINISTRATOR, Console::Yes },
            { "vehicle_accessory",             HandleReloadVehicleAccessoryCommand,           SEC_ADMINISTRATOR, Console::Yes },
            { "vehicle_template_accessory",    HandleReloadVehicleTemplateAccessoryCommand,   SEC_ADMINISTRATOR, Console::Yes },
        };
        static ChatCommandTable commandTable =
        {
            { "reload", reloadCommandTable }
        };
        return commandTable;
    }

    //reload commands
    static bool HandleReloadGMTicketsCommand(ChatHandler* /*handler*/)
    {
        sTicketMgr->LoadTickets();
        return true;
    }

    static bool HandleReloadAllCommand(ChatHandler* handler)
    {
        HandleReloadSkillFishingBaseLevelCommand(handler);

        HandleReloadAllAchievementCommand(handler);
        HandleReloadAllAreaCommand(handler);
        HandleReloadAllLootCommand(handler);
        HandleReloadAllNpcCommand(handler);
        HandleReloadAllQuestCommand(handler);
        HandleReloadAllSpellCommand(handler);
        HandleReloadAllItemCommand(handler);
        HandleReloadAllGossipsCommand(handler);
        HandleReloadAllLocalesCommand(handler);

        HandleReloadDungeonAccessCommand(handler);
        HandleReloadMailLevelRewardCommand(handler);
        HandleReloadMailServerTemplateCommand(handler);
        HandleReloadCommandCommand(handler);
        HandleReloadReservedNameCommand(handler);
        HandleReloadProfanityNameCommand(handler);
        HandleReloadAcoreStringCommand(handler);
        HandleReloadGameTeleCommand(handler);
        HandleReloadCreatureMovementOverrideCommand(handler);

        HandleReloadVehicleAccessoryCommand(handler);
        HandleReloadVehicleTemplateAccessoryCommand(handler);

        HandleReloadAutobroadcastCommand(handler);
        HandleReloadMotdCommand(handler);
        HandleReloadBroadcastTextCommand(handler);
        HandleReloadBattlegroundTemplate(handler);
        return true;
    }

    static bool HandleReloadBattlegroundTemplate(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Battleground Templates...");
        sBattlegroundMgr->LoadBattlegroundTemplates();
        handler->SendGlobalGMSysMessage("DB table `battleground_template` reloaded.");
        return true;
    }

    static bool HandleReloadAllAchievementCommand(ChatHandler* handler)
    {
        HandleReloadAchievementCriteriaDataCommand(handler);
        HandleReloadAchievementRewardCommand(handler);
        return true;
    }

    static bool HandleReloadAllAreaCommand(ChatHandler* handler)
    {
        //HandleReloadQuestAreaTriggersCommand(handler); -- reloaded in HandleReloadAllQuestCommand
        HandleReloadAreaTriggerTeleportCommand(handler);
        HandleReloadAreaTriggerTavernCommand(handler);
        HandleReloadGameGraveyardZoneCommand(handler);
        return true;
    }

    static bool HandleReloadAllLootCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Loot Tables...");
        LoadLootTables();
        handler->SendGlobalGMSysMessage("DB tables `*_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadAllNpcCommand(ChatHandler* handler)
    {
        HandleReloadNpcTrainerCommand(handler);
        HandleReloadNpcVendorCommand(handler);
        HandleReloadPointsOfInterestCommand(handler);
        HandleReloadSpellClickSpellsCommand(handler);
        return true;
    }

    static bool HandleReloadAllQuestCommand(ChatHandler* handler)
    {
        HandleReloadQuestGreetingCommand(handler);
        HandleReloadQuestAreaTriggersCommand(handler);
        HandleReloadQuestPOICommand(handler);
        HandleReloadQuestTemplateCommand(handler);
        HandleReloadLocalesQuestGreetingCommand(handler);

        LOG_INFO("server.loading", "Reloading Quests Relations...");
        sObjectMgr->LoadQuestStartersAndEnders();
        handler->SendGlobalGMSysMessage("DB tables `*_queststarter` and `*_questender` reloaded.");
        return true;
    }

    static bool HandleReloadAllScriptsCommand(ChatHandler* handler)
    {
        if (sScriptMgr->IsScriptScheduled())
        {
            handler->SendErrorMessage("DB scripts used currently, please attempt reload later.");
            return false;
        }

        LOG_INFO("server.loading", "Reloading Scripts...");
        HandleReloadEventScriptsCommand(handler);
        HandleReloadSpellScriptsCommand(handler);
        handler->SendGlobalGMSysMessage("DB tables `*_scripts` reloaded.");
        HandleReloadWpScriptsCommand(handler);
        HandleReloadWpCommand(handler);
        return true;
    }

    static bool HandleReloadAllSpellCommand(ChatHandler* handler)
    {
        HandleReloadSkillDiscoveryTemplateCommand(handler);
        HandleReloadSkillExtraItemTemplateCommand(handler);
        HandleReloadSpellRequiredCommand(handler);
        HandleReloadSpellAreaCommand(handler);
        HandleReloadSpellGroupsCommand(handler);
        HandleReloadSpellLinkedSpellCommand(handler);
        HandleReloadSpellProcEventCommand(handler);
        HandleReloadSpellProcsCommand(handler);
        HandleReloadSpellBonusesCommand(handler);
        HandleReloadSpellTargetPositionCommand(handler);
        HandleReloadSpellThreatsCommand(handler);
        HandleReloadSpellGroupStackRulesCommand(handler);
        HandleReloadSpellPetAurasCommand(handler);
        return true;
    }

    static bool HandleReloadAllGossipsCommand(ChatHandler* handler)
    {
        HandleReloadGossipMenuCommand(handler);
        HandleReloadGossipMenuOptionCommand(handler);
        HandleReloadPointsOfInterestCommand(handler);
        return true;
    }

    static bool HandleReloadAllItemCommand(ChatHandler* handler)
    {
        HandleReloadPageTextsCommand(handler);
        HandleReloadItemEnchantementsCommand(handler);
        return true;
    }

    static bool HandleReloadAllLocalesCommand(ChatHandler* handler)
    {
        HandleReloadLocalesAchievementRewardCommand(handler);
        HandleReloadLocalesCreatureCommand(handler);
        HandleReloadLocalesCreatureTextCommand(handler);
        HandleReloadLocalesGameobjectCommand(handler);
        HandleReloadLocalesGossipMenuOptionCommand(handler);
        HandleReloadLocalesItemCommand(handler);
        HandleReloadLocalesNpcTextCommand(handler);
        HandleReloadLocalesPageTextCommand(handler);
        HandleReloadLocalesPointsOfInterestCommand(handler);
        HandleReloadLocalesQuestCommand(handler);
        HandleReloadLocalesQuestOfferRewardCommand(handler);
        HandleReloadLocalesQuestRequestItemsCommand(handler);
        return true;
    }

    static bool HandleReloadConfigCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading config settings...");
        sWorld->LoadConfigSettings(true);
        sMapMgr->InitializeVisibilityDistanceInfo();
        handler->SendGlobalGMSysMessage("World config settings reloaded.");
        return true;
    }

    static bool HandleReloadDungeonAccessCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Dungeon Access Requirement definitions...");
        sObjectMgr->LoadAccessRequirements();
        handler->SendGlobalGMSysMessage("DB tables `dungeon_access_template` AND `dungeon_access_requirements` reloaded.");
        return true;
    }

    static bool HandleReloadAchievementCriteriaDataCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Additional Achievement Criteria Data...");
        sAchievementMgr->LoadAchievementCriteriaData();
        handler->SendGlobalGMSysMessage("DB table `achievement_criteria_data` reloaded.");
        return true;
    }

    static bool HandleReloadAchievementRewardCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Achievement Reward Data...");
        sAchievementMgr->LoadRewards();
        handler->SendGlobalGMSysMessage("DB table `achievement_reward` reloaded.");
        return true;
    }

    static bool HandleReloadAreaTriggerTavernCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Tavern Area Triggers...");
        sObjectMgr->LoadTavernAreaTriggers();
        handler->SendGlobalGMSysMessage("DB table `areatrigger_tavern` reloaded.");
        return true;
    }

    static bool HandleReloadAreaTriggerCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Area Trigger definitions...");
        sObjectMgr->LoadAreaTriggers();
        handler->SendGlobalGMSysMessage("DB table `areatrigger` reloaded.");
        return true;
    }

    static bool HandleReloadAreaTriggerTeleportCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Area Trigger teleport definitions...");
        sObjectMgr->LoadAreaTriggerTeleports();
        handler->SendGlobalGMSysMessage("DB table `areatrigger_teleport` reloaded.");
        return true;
    }

    static bool HandleReloadAutobroadcastCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Autobroadcasts...");
        sAutobroadcastMgr->LoadAutobroadcasts();
        handler->SendGlobalGMSysMessage("DB table `autobroadcast` reloaded.");
        return true;
    }

    static bool HandleReloadMotdCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Motd...");
        sMotdMgr->LoadMotd();
        handler->SendGlobalGMSysMessage("DB table `motd` reloaded.");
        handler->SendGlobalSysMessage(sMotdMgr->GetMotd());
        return true;
    }

    static bool HandleReloadBroadcastTextCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Broadcast texts...");
        sObjectMgr->LoadBroadcastTexts();
        sObjectMgr->LoadBroadcastTextLocales();
        handler->SendGlobalGMSysMessage("DB table `broadcast_text` reloaded.");
        return true;
    }

    static bool HandleReloadCommandCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading .command information...");
        Acore::ChatCommands::LoadCommandMap();
        handler->SendGlobalGMSysMessage("DB table `command` reloaded.");

        // do not log this invocation, otherwise we might crash (the command table we used to get here is no longer valid!)
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleReloadOnKillReputationCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading creature award reputation definitions...");
        sObjectMgr->LoadReputationOnKill();
        handler->SendGlobalGMSysMessage("DB table `creature_onkill_reputation` reloaded.");
        return true;
    }

    static bool HandleReloadCreatureTemplateCommand(ChatHandler* handler, std::string_view args)
    {
        if (args.empty())
            return false;

        for (std::string_view entryStr : Acore::Tokenize(args, ' ', false))
        {
            uint32 entry = Acore::StringTo<uint32>(entryStr).value_or(0);

            WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_CREATURE_TEMPLATE);
            stmt->SetData(0, entry);
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

            LOG_INFO("server.loading", "Reloading creature template entry {}", entry);

            Field* fields = result->Fetch();

            sObjectMgr->LoadCreatureTemplate(fields, true);
            sObjectMgr->CheckCreatureTemplate(cInfo);
        }

        handler->SendGlobalGMSysMessage("Creature template reloaded.");
        return true;
    }

    static bool HandleReloadCreatureQuestStarterCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Loading Quests Relations... (`creature_queststarter`)");
        sObjectMgr->LoadCreatureQuestStarters();
        handler->SendGlobalGMSysMessage("DB table `creature_queststarter` reloaded.");
        return true;
    }

    static bool HandleReloadLinkedRespawnCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Loading Linked Respawns... (`creature_linked_respawn`)");
        sObjectMgr->LoadLinkedRespawn();
        handler->SendGlobalGMSysMessage("DB table `creature_linked_respawn` (creature linked respawns) reloaded.");
        return true;
    }

    static bool HandleReloadCreatureQuestEnderCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Loading Quests Relations... (`creature_questender`)");
        sObjectMgr->LoadCreatureQuestEnders();
        handler->SendGlobalGMSysMessage("DB table `creature_questender` reloaded.");
        return true;
    }

    static bool HandleReloadGossipMenuCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading `gossip_menu` Table!");
        sObjectMgr->LoadGossipMenu();
        handler->SendGlobalGMSysMessage("DB table `gossip_menu` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadGossipMenuOptionCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading `gossip_menu_option` Table!");
        sObjectMgr->LoadGossipMenuItems();
        handler->SendGlobalGMSysMessage("DB table `gossip_menu_option` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadGOQuestStarterCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Loading Quests Relations... (`gameobject_queststarter`)");
        sObjectMgr->LoadGameobjectQuestStarters();
        handler->SendGlobalGMSysMessage("DB table `gameobject_queststarter` reloaded.");
        return true;
    }

    static bool HandleReloadGOQuestEnderCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Loading Quests Relations... (`gameobject_questender`)");
        sObjectMgr->LoadGameobjectQuestEnders();
        handler->SendGlobalGMSysMessage("DB table `gameobject_questender` reloaded.");
        return true;
    }

    static bool HandleReloadQuestAreaTriggersCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Quest Area Triggers...");
        sObjectMgr->LoadQuestAreaTriggers();
        handler->SendGlobalGMSysMessage("DB table `areatrigger_involvedrelation` (quest area triggers) reloaded.");
        return true;
    }

    static bool HandleReloadQuestGreetingCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Quest Greeting ...");
        sObjectMgr->LoadQuestGreetings();
        handler->SendGlobalGMSysMessage("DB table `quest_greeting` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesQuestGreetingCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Quest Greeting locales...");
        sObjectMgr->LoadQuestGreetingsLocales();
        handler->SendGlobalGMSysMessage("DB table `quest_greeting_locale` reloaded.");
        return true;
    }

    static bool HandleReloadQuestTemplateCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Quest Templates...");
        sObjectMgr->LoadQuests();
        handler->SendGlobalGMSysMessage("DB table `quest_template` (quest definitions) reloaded.");

        /// dependent also from `gameobject` but this table not reloaded anyway
        LOG_INFO("server.loading", "Reloading GameObjects for quests...");
        sObjectMgr->LoadGameObjectForQuests();
        handler->SendGlobalGMSysMessage("Data GameObjects for quests reloaded.");
        return true;
    }

    static bool HandleReloadLootTemplatesCreatureCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Loot Tables... (`creature_loot_template`)");
        LoadLootTemplates_Creature();
        LootTemplates_Creature.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `creature_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadCreatureMovementOverrideCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Creature movement overrides...");
        sObjectMgr->LoadCreatureMovementOverrides();
        handler->SendGlobalGMSysMessage("DB table `creature_movement_override` reloaded.");
        return true;
    }

    static bool HandleReloadLootTemplatesDisenchantCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Loot Tables... (`disenchant_loot_template`)");
        LoadLootTemplates_Disenchant();
        LootTemplates_Disenchant.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `disenchant_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesFishingCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Loot Tables... (`fishing_loot_template`)");
        LoadLootTemplates_Fishing();
        LootTemplates_Fishing.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `fishing_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesGameobjectCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Loot Tables... (`gameobject_loot_template`)");
        LoadLootTemplates_Gameobject();
        LootTemplates_Gameobject.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `gameobject_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesItemCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Loot Tables... (`item_loot_template`)");
        LoadLootTemplates_Item();
        LootTemplates_Item.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `item_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesMillingCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Loot Tables... (`milling_loot_template`)");
        LoadLootTemplates_Milling();
        LootTemplates_Milling.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `milling_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesPickpocketingCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Loot Tables... (`pickpocketing_loot_template`)");
        LoadLootTemplates_Pickpocketing();
        LootTemplates_Pickpocketing.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `pickpocketing_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesProspectingCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Loot Tables... (`prospecting_loot_template`)");
        LoadLootTemplates_Prospecting();
        LootTemplates_Prospecting.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `prospecting_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesMailCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Loot Tables... (`mail_loot_template`)");
        LoadLootTemplates_Mail();
        LootTemplates_Mail.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `mail_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesReferenceCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Loot Tables... (`reference_loot_template`)");
        LoadLootTemplates_Reference();
        handler->SendGlobalGMSysMessage("DB table `reference_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesSkinningCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Loot Tables... (`skinning_loot_template`)");
        LoadLootTemplates_Skinning();
        LootTemplates_Skinning.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `skinning_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesSpellCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Loot Tables... (`spell_loot_template`)");
        LoadLootTemplates_Spell();
        LootTemplates_Spell.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `spell_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadLootTemplatesPlayerCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Loot Tables... (`player_loot_template`)");
        LoadLootTemplates_Player();
        LootTemplates_Player.CheckLootRefs();
        handler->SendGlobalGMSysMessage("DB table `player_loot_template` reloaded.");
        sConditionMgr->LoadConditions(true);
        return true;
    }

    static bool HandleReloadAcoreStringCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading acore_string Table!");
        sObjectMgr->LoadAcoreStrings();
        handler->SendGlobalGMSysMessage("DB table `acore_string` reloaded.");
        return true;
    }

    static bool HandleReloadWardenactionCommand(ChatHandler* handler)
    {
        if (!sWorld->getBoolConfig(CONFIG_WARDEN_ENABLED))
        {
            handler->SendErrorMessage("Warden system disabled by config - reloading warden_action skipped.");
            return false;
        }

        LOG_INFO("server.loading", "Reloading warden_action Table!");
        sWardenCheckMgr->LoadWardenOverrides();
        handler->SendGlobalGMSysMessage("DB table `warden_action` reloaded.");
        return true;
    }

    static bool HandleReloadNpcTrainerCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading `npc_trainer` Table!");
        sObjectMgr->LoadTrainerSpell();
        handler->SendGlobalGMSysMessage("DB table `npc_trainer` reloaded.");
        return true;
    }

    static bool HandleReloadNpcVendorCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading `npc_vendor` Table!");
        sObjectMgr->LoadVendors();
        handler->SendGlobalGMSysMessage("DB table `npc_vendor` reloaded.");
        return true;
    }

    static bool HandleReloadPointsOfInterestCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading `points_of_interest` Table!");
        sObjectMgr->LoadPointsOfInterest();
        handler->SendGlobalGMSysMessage("DB table `points_of_interest` reloaded.");
        return true;
    }

    static bool HandleReloadQuestPOICommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Quest POI ..." );
        sObjectMgr->LoadQuestPOI();
        handler->SendGlobalGMSysMessage("DB Table `quest_poi` and `quest_poi_points` reloaded.");
        return true;
    }

    static bool HandleReloadSpellClickSpellsCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading `npc_spellclick_spells` Table!");
        sObjectMgr->LoadNPCSpellClickSpells();
        handler->SendGlobalGMSysMessage("DB table `npc_spellclick_spells` reloaded.");
        return true;
    }

    static bool HandleReloadReservedNameCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Reserved Names!");
        sObjectMgr->LoadReservedPlayerNamesDB();
        sObjectMgr->LoadReservedPlayerNamesDBC(); // Needed because we clear the store in LoadReservedPlayerNamesDB()
        handler->SendGlobalGMSysMessage("Reserved Names reloaded.");
        return true;
    }

    static bool HandleReloadProfanityNameCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Profanity Names!");
        sObjectMgr->LoadProfanityNamesFromDB();
        sObjectMgr->LoadProfanityNamesFromDBC(); // Needed because we clear the store in LoadProfanityNamesFromDB()
        handler->SendGlobalGMSysMessage("Profanity Names reloaded.");
        return true;
    }

    static bool HandleReloadReputationRewardRateCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading `reputation_reward_rate` Table!" );
        sObjectMgr->LoadReputationRewardRate();
        handler->SendGlobalGMSysMessage("DB table `reputation_reward_rate` reloaded.");
        return true;
    }

    static bool HandleReloadReputationSpilloverTemplateCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading `reputation_spillover_template` Table!" );
        sObjectMgr->LoadReputationSpilloverTemplate();
        handler->SendGlobalGMSysMessage("DB table `reputation_spillover_template` reloaded.");
        return true;
    }

    static bool HandleReloadSkillDiscoveryTemplateCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Skill Discovery Table...");
        LoadSkillDiscoveryTable();
        handler->SendGlobalGMSysMessage("DB table `skill_discovery_template` (recipes discovered at crafting) reloaded.");
        return true;
    }

    static bool HandleReloadSkillPerfectItemTemplateCommand(ChatHandler* handler)
    {
        // latched onto HandleReloadSkillExtraItemTemplateCommand as it's part of that table group (and i don't want to chance all the command IDs)
        LOG_INFO("server.loading", "Reloading Skill Perfection Data Table...");
        LoadSkillPerfectItemTable();
        handler->SendGlobalGMSysMessage("DB table `skill_perfect_item_template` (perfect item procs when crafting) reloaded.");
        return true;
    }

    static bool HandleReloadSkillExtraItemTemplateCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Skill Extra Item Table...");
        LoadSkillExtraItemTable();
        handler->SendGlobalGMSysMessage("DB table `skill_extra_item_template` (extra item creation when crafting) reloaded.");
        return HandleReloadSkillPerfectItemTemplateCommand(handler);
    }

    static bool HandleReloadSkillFishingBaseLevelCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Skill Fishing base level requirements...");
        sObjectMgr->LoadFishingBaseSkillLevel();
        handler->SendGlobalGMSysMessage("DB table `skill_fishing_base_level` (fishing base level for zone/subzone) reloaded.");
        return true;
    }

    static bool HandleReloadSpellAreaCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading SpellArea Data...");
        sSpellMgr->LoadSpellAreas();
        handler->SendGlobalGMSysMessage("DB table `spell_area` (spell dependences from area/quest/auras state) reloaded.");
        return true;
    }

    static bool HandleReloadSpellRequiredCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Spell Required Data... ");
        sSpellMgr->LoadSpellRequired();
        handler->SendGlobalGMSysMessage("DB table `spell_required` reloaded.");
        return true;
    }

    static bool HandleReloadSpellGroupsCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Spell Groups...");
        sSpellMgr->LoadSpellGroups();
        handler->SendGlobalGMSysMessage("DB table `spell_group` (spell groups) reloaded.");
        return true;
    }

    static bool HandleReloadSpellLinkedSpellCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Spell Linked Spells...");
        sSpellMgr->LoadSpellLinked();
        handler->SendGlobalGMSysMessage("DB table `spell_linked_spell` reloaded.");
        return true;
    }

    static bool HandleReloadSpellProcEventCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Spell Proc Event conditions...");
        sSpellMgr->LoadSpellProcEvents();
        handler->SendGlobalGMSysMessage("DB table `spell_proc_event` (spell proc trigger requirements) reloaded.");
        return true;
    }

    static bool HandleReloadSpellProcsCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Spell Proc conditions and data...");
        sSpellMgr->LoadSpellProcs();
        handler->SendGlobalGMSysMessage("DB table `spell_proc` (spell proc conditions and data) reloaded.");
        return true;
    }

    static bool HandleReloadSpellBonusesCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Spell Bonus Data...");
        sSpellMgr->LoadSpellBonuses();
        handler->SendGlobalGMSysMessage("DB table `spell_bonus_data` (spell damage/healing coefficients) reloaded.");
        return true;
    }

    static bool HandleReloadSpellTargetPositionCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Spell target coordinates...");
        sSpellMgr->LoadSpellTargetPositions();
        handler->SendGlobalGMSysMessage("DB table `spell_target_position` (destination coordinates for spell targets) reloaded.");
        return true;
    }

    static bool HandleReloadSpellThreatsCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Aggro Spells Definitions...");
        sSpellMgr->LoadSpellThreats();
        handler->SendGlobalGMSysMessage("DB table `spell_threat` (spell aggro definitions) reloaded.");
        return true;
    }

    static bool HandleReloadSpellGroupStackRulesCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Spell Group Stack Rules...");
        sSpellMgr->LoadSpellGroupStackRules();
        handler->SendGlobalGMSysMessage("DB table `spell_group_stack_rules` (spell stacking definitions) reloaded.");
        return true;
    }

    static bool HandleReloadSpellPetAurasCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Spell pet auras...");
        sSpellMgr->LoadSpellPetAuras();
        handler->SendGlobalGMSysMessage("DB table `spell_pet_auras` reloaded.");
        return true;
    }

    static bool HandleReloadPageTextsCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Page Texts...");
        sObjectMgr->LoadPageTexts();
        handler->SendGlobalGMSysMessage("DB table `page_texts` reloaded.");
        handler->SendGlobalGMSysMessage("You need to delete your client cache or change the cache number in config in order for your players see the changes.");
        return true;
    }

    static bool HandleReloadItemEnchantementsCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Item Random Enchantments Table...");
        LoadRandomEnchantmentsTable();
        handler->SendGlobalGMSysMessage("DB table `item_enchantment_template` reloaded.");
        return true;
    }

    static bool HandleReloadItemSetNamesCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Item set names...");
        sObjectMgr->LoadItemSetNames();
        handler->SendGlobalGMSysMessage("DB table `item_set_names` reloaded.");
        return true;
    }

    static bool HandleReloadEventScriptsCommand(ChatHandler* handler)
    {
        if (sScriptMgr->IsScriptScheduled())
        {
            handler->SendErrorMessage("DB scripts used currently, please attempt reload later.");
            return false;
        }

        LOG_INFO("server.loading", "Reloading Scripts from `event_scripts`...");

        sObjectMgr->LoadEventScripts();

        handler->SendGlobalGMSysMessage("DB table `event_scripts` reloaded.");

        return true;
    }

    static bool HandleReloadWpScriptsCommand(ChatHandler* handler)
    {
        if (sScriptMgr->IsScriptScheduled())
        {
            handler->SendErrorMessage("DB scripts used currently, please attempt reload later.");
            return false;
        }

        LOG_INFO("server.loading", "Reloading Scripts from `waypoint_scripts`...");

        sObjectMgr->LoadWaypointScripts();

        handler->SendGlobalGMSysMessage("DB table `waypoint_scripts` reloaded.");

        return true;
    }

    static bool HandleReloadWpCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Waypoints data from 'waypoints_data'");
        sWaypointMgr->Load();
        handler->SendGlobalGMSysMessage("DB Table 'waypoint_data' reloaded.");

        return true;
    }

    static bool HandleReloadSpellScriptsCommand(ChatHandler* handler)
    {
        if (sScriptMgr->IsScriptScheduled())
        {
            handler->SendErrorMessage("DB scripts used currently, please attempt reload later.");
            return false;
        }

        LOG_INFO("server.loading", "Reloading Scripts from `spell_scripts`...");

        sObjectMgr->LoadSpellScripts();

        handler->SendGlobalGMSysMessage("DB table `spell_scripts` reloaded.");

        return true;
    }

    static bool HandleReloadGameGraveyardZoneCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Graveyard-zone links...");

        sGraveyard->LoadGraveyardZones();

        handler->SendGlobalGMSysMessage("DB table `graveyard_zone` reloaded.");

        return true;
    }

    static bool HandleReloadGameTeleCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Game Tele coordinates...");

        sObjectMgr->LoadGameTele();

        handler->SendGlobalGMSysMessage("DB table `game_tele` reloaded.");

        return true;
    }

    static bool HandleReloadDisablesCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading disables table...");
        DisableMgr::LoadDisables();
        LOG_INFO("server.loading", "Checking quest disables...");
        DisableMgr::CheckQuestDisables();
        handler->SendGlobalGMSysMessage("DB table `disables` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesAchievementRewardCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Achievement Reward Data Locale...");
        sAchievementMgr->LoadRewardLocales();
        handler->SendGlobalGMSysMessage("DB table `achievement_reward_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLfgRewardsCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading lfg dungeon rewards...");
        sLFGMgr->LoadRewards();
        handler->SendGlobalGMSysMessage("DB table `lfg_dungeon_rewards` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesCreatureCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Creature Template Locale...");
        sObjectMgr->LoadCreatureLocales();
        handler->SendGlobalGMSysMessage("DB table `creature_template_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesCreatureTextCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Creature Texts Locale...");
        sCreatureTextMgr->LoadCreatureTextLocales();
        handler->SendGlobalGMSysMessage("DB table `creature_text_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesGameobjectCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Gameobject Template Locale ... ");
        sObjectMgr->LoadGameObjectLocales();
        handler->SendGlobalGMSysMessage("DB table `gameobject_template_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesGossipMenuOptionCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Gossip Menu Option Locale ... ");
        sObjectMgr->LoadGossipMenuItemsLocales();
        handler->SendGlobalGMSysMessage("DB table `gossip_menu_option_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesItemCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Item Template Locale ... ");
        sObjectMgr->LoadItemLocales();
        handler->SendGlobalGMSysMessage("DB table `item_template_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesItemSetNameCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Item set name Locale... ");
        sObjectMgr->LoadItemSetNameLocales();
        handler->SendGlobalGMSysMessage("DB table `item_set_name_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesNpcTextCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading NPC Text Locale ... ");
        sObjectMgr->LoadNpcTextLocales();
        handler->SendGlobalGMSysMessage("DB table `npc_text_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesPageTextCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Page Text Locale ... ");
        sObjectMgr->LoadPageTextLocales();
        handler->SendGlobalGMSysMessage("DB table `page_text_locale` reloaded.");
        handler->SendGlobalGMSysMessage("You need to delete your client cache or change the cache number in config in order for your players see the changes.");
        return true;
    }

    static bool HandleReloadLocalesPointsOfInterestCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Points Of Interest Locale ... ");
        sObjectMgr->LoadPointOfInterestLocales();
        handler->SendGlobalGMSysMessage("DB table `points_of_interest_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesQuestCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Locales Quest ... ");
        sObjectMgr->LoadQuestLocales();
        handler->SendGlobalGMSysMessage("DB table `quest_template_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesQuestOfferRewardCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Quest Offer Reward Locale... ");
        sObjectMgr->LoadQuestOfferRewardLocale();
        handler->SendGlobalGMSysMessage("DB table `quest_offer_reward_locale` reloaded.");
        return true;
    }

    static bool HandleReloadLocalesQuestRequestItemsCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Quest Request Item Locale... ");
        sObjectMgr->LoadQuestRequestItemsLocale();
        handler->SendGlobalGMSysMessage("DB table `quest_request_item_locale` reloaded.");
        return true;
    }

    static bool HandleReloadMailLevelRewardCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Player level dependent mail rewards...");
        sObjectMgr->LoadMailLevelRewards();
        handler->SendGlobalGMSysMessage("DB table `mail_level_reward` reloaded.");
        return true;
    }

    static bool HandleReloadMailServerTemplateCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading `server_mail_template` table");
        sObjectMgr->LoadMailServerTemplates();
        handler->SendGlobalGMSysMessage("DB table `server_mail_template` reloaded.");
        return true;
    }

    static bool HandleReloadAuctionsCommand(ChatHandler* handler)
    {
        ///- Reload dynamic data tables from the database
        LOG_INFO("server.loading", "Reloading Auctions...");
        sAuctionMgr->LoadAuctionItems();
        sAuctionMgr->LoadAuctions();
        handler->SendGlobalGMSysMessage("Auctions reloaded.");
        return true;
    }

    static bool HandleReloadConditions(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Conditions...");
        sConditionMgr->LoadConditions(true);
        handler->SendGlobalGMSysMessage("Conditions reloaded.");
        return true;
    }

    static bool HandleReloadCreatureText(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Creature Texts...");
        sCreatureTextMgr->LoadCreatureTexts();
        handler->SendGlobalGMSysMessage("Creature Texts reloaded.");
        return true;
    }

    static bool HandleReloadSmartScripts(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading Smart Scripts...");
        sSmartScriptMgr->LoadSmartAIFromDB();
        handler->SendGlobalGMSysMessage("Smart Scripts reloaded.");
        return true;
    }

    static bool HandleReloadVehicleAccessoryCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading vehicle_accessory table...");
        sObjectMgr->LoadVehicleAccessories();
        handler->SendGlobalGMSysMessage("Vehicle accessories reloaded.");
        return true;
    }

    static bool HandleReloadVehicleTemplateAccessoryCommand(ChatHandler* handler)
    {
        LOG_INFO("server.loading", "Reloading vehicle_template_accessory table...");
        sObjectMgr->LoadVehicleTemplateAccessories();
        handler->SendGlobalGMSysMessage("Vehicle template accessories reloaded.");
        return true;
    }

    static bool HandleReloadGameGraveyardCommand(ChatHandler* handler)
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
