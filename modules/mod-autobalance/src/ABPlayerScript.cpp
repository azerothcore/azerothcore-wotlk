#include <string>

#include "ABConfig.h"
#include "ABCreatureInfo.h"
#include "ABMapInfo.h"
#include "ABPlayerScript.h"
#include "ABUtils.h"

#include "Chat.h"
#include "Message.h"

void AutoBalance_PlayerScript::OnPlayerLogin(Player* Player)
{
    if (EnableGlobal && Announcement)
        ChatHandler(Player->GetSession()).SendSysMessage("This server is running the |cff4CFF00AutoBalance |rmodule.");
}

void AutoBalance_PlayerScript::OnPlayerLevelChanged(Player* player, uint8 oldlevel)
{
    LOG_DEBUG("module.AutoBalance", "AutoBalance:: ------------------------------------------------");

    LOG_DEBUG("module.AutoBalance", "AutoBalance_PlayerScript::OnLevelChanged: {} has leveled ({}->{})", player->GetName(), oldlevel, player->GetLevel());
    if (!player || player->IsGameMaster())
        return;

    Map* map = player->GetMap();

    if (!map || !map->IsDungeon())
        return;

    // update the map's player stats
    UpdateMapPlayerStats(map);

    // schedule all creatures for an update
    AutoBalanceMapInfo* mapABInfo = GetMapInfo(map);
    mapABInfo->mapConfigTime = GetCurrentConfigTime();
}

void AutoBalance_PlayerScript::OnPlayerGiveXP(Player* player, uint32& amount, Unit* victim, uint8 /*xpSource*/)
{
    Map* map = player->GetMap();

    // If this isn't a dungeon, make no changes
    if (!map->IsDungeon() || !map->GetInstanceId() || !victim)
        return;

    AutoBalanceMapInfo* mapABInfo = GetMapInfo(map);

    if (victim && RewardScalingXP && mapABInfo->enabled)
    {
        Map* map = player->GetMap();

        AutoBalanceCreatureInfo* creatureABInfo = victim->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");

        if (map->IsDungeon())
        {
            if (RewardScalingMethod == AUTOBALANCE_SCALING_DYNAMIC)
            {
                LOG_DEBUG("module.AutoBalance", "AutoBalance_PlayerScript::OnGiveXP: Distributing XP from '{}' to '{}' in dynamic mode - {}->{}",
                    victim->GetName(), player->GetName(), amount, uint32(amount * creatureABInfo->XPModifier));
                amount = uint32(amount * creatureABInfo->XPModifier);
            }
            else if (RewardScalingMethod == AUTOBALANCE_SCALING_FIXED)
            {
                // Ensure that the players always get the same XP, even when entering the dungeon alone
                auto maxPlayerCount = map->ToInstanceMap()->GetMaxPlayers();
                auto currentPlayerCount = mapABInfo->playerCount;
                LOG_DEBUG("module.AutoBalance", "AutoBalance_PlayerScript::OnGiveXP: Distributing XP from '{}' to '{}' in fixed mode - {}->{}",
                    victim->GetName(), player->GetName(), amount, uint32(amount * creatureABInfo->XPModifier * ((float)currentPlayerCount / maxPlayerCount)));
                amount = uint32(amount * creatureABInfo->XPModifier * ((float)currentPlayerCount / maxPlayerCount));
            }
        }
    }
}

void AutoBalance_PlayerScript::OnPlayerBeforeLootMoney(Player* player, Loot* loot)
{
    Map* map = player->GetMap();

    // If this isn't a dungeon, make no changes
    if (!map->IsDungeon())
        return;

    AutoBalanceMapInfo* mapABInfo = GetMapInfo(map);
    ObjectGuid sourceGuid = loot->sourceWorldObjectGUID;

    if (mapABInfo->enabled && RewardScalingMoney)
    {
        // if the loot source is a creature, honor the modifiers for that creature
        if (sourceGuid.IsCreature())
        {
            Creature* sourceCreature = ObjectAccessor::GetCreature(*player, sourceGuid);
            AutoBalanceCreatureInfo* creatureABInfo = sourceCreature->CustomData.GetDefault<AutoBalanceCreatureInfo>("AutoBalanceCreatureInfo");

            // Dynamic Mode
            if (RewardScalingMethod == AUTOBALANCE_SCALING_DYNAMIC)
            {
                LOG_DEBUG("module.AutoBalance", "AutoBalance_PlayerScript::OnBeforeLootMoney: Distributing money from '{}' in dynamic mode - {}->{}",
                    sourceCreature->GetName(), loot->gold, uint32(loot->gold * creatureABInfo->MoneyModifier));
                loot->gold = uint32(loot->gold * creatureABInfo->MoneyModifier);
            }
            // Fixed Mode
            else if (RewardScalingMethod == AUTOBALANCE_SCALING_FIXED)
            {
                // Ensure that the players always get the same money, even when entering the dungeon alone
                auto maxPlayerCount = map->ToInstanceMap()->GetMaxPlayers();
                auto currentPlayerCount = mapABInfo->playerCount;
                LOG_DEBUG("module.AutoBalance", "AutoBalance_PlayerScript::OnBeforeLootMoney: Distributing money from '{}' in fixed mode - {}->{}",
                    sourceCreature->GetName(), loot->gold, uint32(loot->gold * creatureABInfo->MoneyModifier * ((float)currentPlayerCount / maxPlayerCount)));
                loot->gold = uint32(loot->gold * creatureABInfo->MoneyModifier * ((float)currentPlayerCount / maxPlayerCount));
            }
        }
        // for all other loot sources, just distribute in Fixed mode as though the instance was full
        else
        {
            auto maxPlayerCount = map->ToInstanceMap()->GetMaxPlayers();
            auto currentPlayerCount = mapABInfo->playerCount;
            LOG_DEBUG("module.AutoBalance", "AutoBalance_PlayerScript::OnBeforeLootMoney: Distributing money from a non-creature in fixed mode - {}->{}",
                loot->gold, uint32(loot->gold * ((float)currentPlayerCount / maxPlayerCount)));
            loot->gold = uint32(loot->gold * ((float)currentPlayerCount / maxPlayerCount));
        }
    }
}

void AutoBalance_PlayerScript::OnPlayerEnterCombat(Player* player, Unit* /*enemy*/)
{
    // if the player or their map is gone, return
    if (!player || !player->GetMap())
        return;

    Map* map = player->GetMap();

    // If this isn't a dungeon, no work to do
    if (!map || !map->IsDungeon())
        return;

    LOG_DEBUG("module.AutoBalance_CombatLocking", "AutoBalance_PlayerScript::OnPlayerEnterCombat: {} enters combat.", player->GetName());

    AutoBalanceMapInfo* mapABInfo = GetMapInfo(map);

    // if this map isn't enabled, no work to do
    if (!mapABInfo->enabled)
        return;

    // lock the current map
    if (!mapABInfo->combatLocked)
    {
        mapABInfo->combatLocked = true;
        mapABInfo->combatLockMinPlayers = mapABInfo->playerCount;

        LOG_DEBUG("module.AutoBalance_CombatLocking", "AutoBalance_PlayerScript::OnPlayerEnterCombat: Map {} ({}{}) | Locking difficulty to no less than ({}) as {} enters combat.",
            map->GetMapName(),
            map->GetId(),
            map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
            mapABInfo->combatLockMinPlayers,
            player->GetName()
        );
    }
}

void AutoBalance_PlayerScript::OnPlayerLeaveCombat(Player* player)
{
    // if the player or their map is gone, return
    if (!player || !player->GetMap())
        return;

    Map* map = player->GetMap();

    // If this isn't a dungeon, no work to do
    if (!map || !map->IsDungeon())
        return;

    // this hook can get called even if the player isn't in combat
    // I believe this happens whenever AC attempts to remove combat, but it doesn't check to see if the player is in combat first
    // unfortunately, `player->IsInCombat()` doesn't work here
    LOG_DEBUG("module.AutoBalance_CombatLocking", "AutoBalance_PlayerScript::OnPlayerLeaveCombat: {} leaves (or wasn't in) combat.", player->GetName());

    AutoBalanceMapInfo* mapABInfo = GetMapInfo(map);

    // if this map isn't enabled, no work to do
    if (!mapABInfo->enabled)
        return;

    // check to see if any of the other players are in combat
    bool anyPlayersInCombat = false;
    for (auto player : mapABInfo->allMapPlayers)
    {
        if (player && player->IsInCombat())
        {
            anyPlayersInCombat = true;

            LOG_DEBUG("module.AutoBalance_CombatLocking", "AutoBalance_PlayerScript::OnPlayerLeaveCombat: Map {} ({}{}) | Player {} (and potentially others) are still in combat.",
                map->GetMapName(),
                map->GetId(),
                map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                player->GetName()
            );

            break;
        }
    }

    auto locale = player->GetSession()->GetSessionDbLocaleIndex();

    // if no players are in combat, unlock the map
    if (!anyPlayersInCombat && mapABInfo->combatLocked)
    {
        mapABInfo->combatLocked = false;
        mapABInfo->combatLockMinPlayers = 0;

        LOG_DEBUG("module.AutoBalance_CombatLocking", "AutoBalance_PlayerScript::OnPlayerLeaveCombat: Map {} ({}{}) | Unlocking difficulty as {} leaves combat.",
            map->GetMapName(),
            map->GetId(),
            map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
            player->GetName()
        );

        // if the combat lock needed to be used, notify the players of it lifting
        if (mapABInfo->combatLockTripped)
        {
            for (auto player : mapABInfo->allMapPlayers)
            {
                if (player && player->GetSession())
                    ChatHandler(player->GetSession()).PSendSysMessage(ABGetLocaleText(locale, "leaving_instance_combat_change").c_str());
            }
        }

        // if the number of players changed while combat was in progress, schedule the map for an update
        if (mapABInfo->combatLockTripped && mapABInfo->playerCount != mapABInfo->combatLockMinPlayers)
        {
            mapABInfo->mapConfigTime = 1;
            LOG_DEBUG("module.AutoBalance_CombatLocking", "AutoBalance_PlayerScript::OnPlayerLeaveCombat: Map {} ({}{}) | Reset map config time to ({}).",
                map->GetMapName(),
                map->GetId(),
                map->GetInstanceId() ? "-" + std::to_string(map->GetInstanceId()) : "",
                mapABInfo->mapConfigTime
            );

            mapABInfo->combatLockTripped = false;
        }
    }
}
