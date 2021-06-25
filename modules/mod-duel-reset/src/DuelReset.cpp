/*
 *  Originally written  for TrinityCore by ShinDarth and GigaDev90 (www.trinitycore.org)
 *  Converted as module for AzerothCore by ShinDarth and Yehonal   (www.azerothcore.org)
 *  Reworked by Gozzim
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as published
 *  by the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "DuelReset.h"

DuelReset* DuelReset::instance()
{
    static DuelReset instance;
    return &instance;
}

void DuelReset::ResetSpellCooldowns(Player* player, bool onStartDuel)
{
    uint32 infTime = World::GetGameTimeMS() + player->infinityCooldownDelayCheck;
    SpellCooldowns::iterator itr, next;

    for (itr = player->GetSpellCooldownMap().begin(); itr != player->GetSpellCooldownMap().end(); itr = next)
    {
        next = itr;
        ++next;
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first);
        if (!spellInfo)
            continue;

        // Get correct spell cooldown times
        uint32 remainingCooldown = player->GetSpellCooldownDelay(spellInfo->Id);
        int32 totalCooldown = spellInfo->RecoveryTime;
        int32 categoryCooldown = spellInfo->CategoryRecoveryTime;
        player->ApplySpellMod(spellInfo->Id, SPELLMOD_COOLDOWN, totalCooldown, nullptr);
        if (int32 cooldownMod = player->GetTotalAuraModifier(SPELL_AURA_MOD_COOLDOWN))
            totalCooldown += cooldownMod * IN_MILLISECONDS;

        if (!spellInfo->HasAttribute(SPELL_ATTR6_NO_CATEGORY_COOLDOWN_MODS))
            player->ApplySpellMod(spellInfo->Id, SPELLMOD_COOLDOWN, categoryCooldown, nullptr);

        // Clear cooldown if < 10min & (passed time > 30sec or onDuelEnd)
        if (remainingCooldown > 0
            && itr->second.end < infTime
            && totalCooldown < 10 * MINUTE * IN_MILLISECONDS
            && categoryCooldown < 10 * MINUTE * IN_MILLISECONDS
            && remainingCooldown < 10 * MINUTE * IN_MILLISECONDS
            && (onStartDuel ? (totalCooldown - remainingCooldown) > m_cooldownAge * IN_MILLISECONDS : true)
            && (onStartDuel ? (categoryCooldown - remainingCooldown) > m_cooldownAge * IN_MILLISECONDS : true)
            )
            player->RemoveSpellCooldown(itr->first, true);
    }

    if (Pet* pet = player->GetPet())
    {
        for (CreatureSpellCooldowns::const_iterator itr2 = pet->m_CreatureSpellCooldowns.begin(); itr2 != pet->m_CreatureSpellCooldowns.end(); ++itr2)
            player->SendClearCooldown(itr2->first, pet);

        // actually clear cooldowns
        pet->m_CreatureSpellCooldowns.clear();
    }
}

void DuelReset::SaveCooldownStateBeforeDuel(Player* player) {

    if(!player)
        return;

    m_spellCooldownsBeforeDuel[player] = player->GetSpellCooldownMap();
}

void DuelReset::RestoreCooldownStateAfterDuel(Player* player)
{
    PlayersCooldownMap::iterator savedDuelCooldownsMap = m_spellCooldownsBeforeDuel.find(player);
    if (savedDuelCooldownsMap == m_spellCooldownsBeforeDuel.end())
        return;

    sDuelReset->ResetSpellCooldowns(player, false);

    SpellCooldowns playerSavedDuelCooldowns = savedDuelCooldownsMap->second;
    uint32 curMSTime = World::GetGameTimeMS();
    uint32 infTime = curMSTime + player->infinityCooldownDelayCheck;

    // add all profession CDs created while in duel (if any)
    for (auto itr = player->GetSpellCooldownMap().begin(); itr != player->GetSpellCooldownMap().end(); ++itr)
    {
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first);

        if (spellInfo && (spellInfo->RecoveryTime > 10 * MINUTE * IN_MILLISECONDS || spellInfo->CategoryRecoveryTime > 10 * MINUTE * IN_MILLISECONDS))
        {
            playerSavedDuelCooldowns[itr->first] = player->GetSpellCooldownMap()[itr->first];
        }
    }

    // check for spell with infinity delay active before and during the duel
    for (auto itr = playerSavedDuelCooldowns.begin(); itr != playerSavedDuelCooldowns.end(); ++itr)
    {
        if (itr->second.end < infTime && player->GetSpellCooldownMap()[itr->first].end < infTime)
            player->AddSpellCooldown(itr->first, itr->second.itemid, (itr->second.end > curMSTime ? itr->second.end - curMSTime : 0), itr->second.needSendToClient, false);
    }

    // update the client: restore old cooldowns
    PacketCooldowns cooldowns;

    for (auto itr = player->GetSpellCooldownMap().begin(); itr != player->GetSpellCooldownMap().end(); ++itr)
    {
        uint32 cooldown = itr->second.end > curMSTime ? itr->second.end - curMSTime : 0;

        // cooldownDuration must be between 0 and 10 minutes in order to avoid any visual bugs
        if (cooldown <= 0 || cooldown > 10 * MINUTE * IN_MILLISECONDS || itr->second.end >= infTime)
            continue;

        cooldowns[itr->first] = cooldown;
    }

    m_spellCooldownsBeforeDuel.erase(player);

    WorldPacket data;
    player->BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_INCLUDE_EVENT_COOLDOWNS, cooldowns);
    player->SendDirectMessage(&data);
}

void DuelReset::SaveHealthBeforeDuel(Player* player) {
    if(!player)
        return;

    m_healthBeforeDuel[player] = player->GetHealth();
}

void DuelReset::RestoreHealthAfterDuel(Player* player) {
    PlayersHealthMap::iterator savedPlayerHealth = m_healthBeforeDuel.find(player);
    if (savedPlayerHealth == m_healthBeforeDuel.end())
        return;

    player->SetHealth(savedPlayerHealth->second);
    m_healthBeforeDuel.erase(player);
}

void DuelReset::SaveManaBeforeDuel(Player* player) {
    if(!player)
        return;

    m_manaBeforeDuel[player] = player->GetPower(POWER_MANA);
}

void DuelReset::RestoreManaAfterDuel(Player* player) {
    PlayersManaMap::iterator savedPlayerMana = m_manaBeforeDuel.find(player);
    if (savedPlayerMana == m_manaBeforeDuel.end())
        return;

    player->SetPower(POWER_MANA, savedPlayerMana->second);
    m_manaBeforeDuel.erase(player);
}

void DuelReset::LoadConfig(bool /*reload*/)
{
    m_enableCooldowns = sConfigMgr->GetBoolDefault("DuelReset.Cooldowns", true);
    m_enableHealth = sConfigMgr->GetBoolDefault("DuelReset.HealthMana", true);
    m_cooldownAge = uint32(sConfigMgr->GetIntDefault("DuelReset.CooldownAge", 30));

    FillWhitelist(sConfigMgr->GetStringDefault("DuelReset.Zones", "0"), m_zoneWhitelist);
    FillWhitelist(sConfigMgr->GetStringDefault("DuelReset.Areas", "12;14;809"), m_areaWhitelist);
}

void DuelReset::FillWhitelist(std::string zonesAreas, std::vector<uint32> &whitelist)
{
    whitelist.clear();

    if (zonesAreas.empty())
        return;

    std::string zone;
    std::istringstream zoneStream(zonesAreas);
    while (std::getline(zoneStream, zone, ';'))
    {
        whitelist.push_back(stoi(zone));
    }
}

bool DuelReset::IsAllowedInArea(Player* player) const
{
    return (std::find(m_zoneWhitelist.begin(), m_zoneWhitelist.end(), player->GetZoneId()) != m_zoneWhitelist.end())
        || (std::find(m_areaWhitelist.begin(), m_areaWhitelist.end(), player->GetAreaId()) != m_areaWhitelist.end())
        || m_zoneWhitelist.empty();
}

bool DuelReset::GetResetCooldownsEnabled() const
{
    return m_enableCooldowns;
}

bool DuelReset::GetResetHealthEnabled() const
{
    return m_enableHealth;
}

uint32 DuelReset::GetCooldownAge() const
{
    return m_cooldownAge;
}

std::vector<uint32> DuelReset::GetZoneWhitelist() const
{
    return m_zoneWhitelist;
}

std::vector<uint32> DuelReset::GetAreaWhitelist() const
{
    return m_areaWhitelist;
}