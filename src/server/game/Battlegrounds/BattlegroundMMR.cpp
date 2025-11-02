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

#include "BattlegroundMMR.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "Item.h"
#include "Log.h"

BattlegroundMMRMgr* BattlegroundMMRMgr::instance()
{
    static BattlegroundMMRMgr instance;
    return &instance;
}

void BattlegroundMMRMgr::LoadConfig()
{
    _enabled = sConfigMgr->GetOption<bool>("BattleGround.MMR.Enable", false);
    _startingRating = sConfigMgr->GetOption<float>("BattleGround.MMR.StartingRating", 1500.0f);
    _startingRD = sConfigMgr->GetOption<float>("BattleGround.MMR.StartingRD", 200.0f);
    _startingVolatility = sConfigMgr->GetOption<float>("BattleGround.MMR.StartingVolatility", 0.06f);
    _systemTau = sConfigMgr->GetOption<float>("BattleGround.MMR.SystemConstant", 0.5f);
    _mmrWeight = sConfigMgr->GetOption<float>("BattleGround.MMR.MMRWeight", 0.7f);
    _gearWeight = sConfigMgr->GetOption<float>("BattleGround.MMR.GearWeight", 0.3f);
    
    _queueRelaxationEnabled = sConfigMgr->GetOption<bool>("BattleGround.MMR.QueueRelaxation.Enable", true);
    _initialMaxMMRDifference = sConfigMgr->GetOption<float>("BattleGround.MMR.QueueRelaxation.InitialTolerance", 200.0f);
    _relaxationIntervalSeconds = sConfigMgr->GetOption<uint32>("BattleGround.MMR.QueueRelaxation.IntervalSeconds", 120);
    _relaxationStepMMR = sConfigMgr->GetOption<float>("BattleGround.MMR.QueueRelaxation.StepMMR", 100.0f);
    _maxRelaxationSeconds = sConfigMgr->GetOption<uint32>("BattleGround.MMR.QueueRelaxation.MaxSeconds", 600);
    
    _glicko.SetTau(_systemTau);
    
    LOG_INFO("server.loading", ">> BattlegroundMMRMgr: System {} (Tau: {}, Starting Rating: {})",
             _enabled ? "ENABLED" : "DISABLED", _systemTau, _startingRating);
    
    if (_enabled && _queueRelaxationEnabled)
    {
        LOG_INFO("server.loading", ">> BattlegroundMMRMgr: Queue Relaxation ENABLED "
                 "(Initial: {}, Step: {} every {}s, Max: {}s)",
                 _initialMaxMMRDifference, _relaxationStepMMR, 
                 _relaxationIntervalSeconds, _maxRelaxationSeconds);
    }
}

float BattlegroundMMRMgr::CalculateGearScore(Player* player)
{
    if (!player)
        return 0.0f;
    
    static const std::unordered_map<uint8, float> slotWeights = {
        {EQUIPMENT_SLOT_HEAD, 1.2f},
        {EQUIPMENT_SLOT_NECK, 1.0f},
        {EQUIPMENT_SLOT_SHOULDERS, 1.1f},
        {EQUIPMENT_SLOT_BODY, 1.0f},
        {EQUIPMENT_SLOT_CHEST, 1.3f},
        {EQUIPMENT_SLOT_WAIST, 1.0f},
        {EQUIPMENT_SLOT_LEGS, 1.3f},
        {EQUIPMENT_SLOT_FEET, 1.0f},
        {EQUIPMENT_SLOT_WRISTS, 1.0f},
        {EQUIPMENT_SLOT_HANDS, 1.0f},
        {EQUIPMENT_SLOT_FINGER1, 1.0f},
        {EQUIPMENT_SLOT_FINGER2, 1.0f},
        {EQUIPMENT_SLOT_TRINKET1, 1.1f},
        {EQUIPMENT_SLOT_TRINKET2, 1.1f},
        {EQUIPMENT_SLOT_BACK, 1.0f},
        {EQUIPMENT_SLOT_MAINHAND, 1.5f},
        {EQUIPMENT_SLOT_OFFHAND, 1.5f},
        {EQUIPMENT_SLOT_RANGED, 1.5f}
    };
    
    float totalItemLevel = 0.0f;
    float totalWeight = 0.0f;
    
    for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
    {
        if (Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
        {
            auto weightItr = slotWeights.find(slot);
            float weight = (weightItr != slotWeights.end()) ? weightItr->second : 1.0f;
            
            totalItemLevel += item->GetTemplate()->ItemLevel * weight;
            totalWeight += weight;
        }
    }
    
    return totalWeight > 0.0f ? totalItemLevel / totalWeight : 0.0f;
}

void BattlegroundMMRMgr::UpdatePlayerRating(Player* player, bool won, const std::vector<Player*>& opponents)
{
    if (!_enabled || !player || opponents.empty())
    {
        LOG_DEBUG("bg.mmr", "UpdatePlayerRating early return - Enabled: {}, Player: {}, Opponents: {}",
                  _enabled, (player != nullptr), opponents.size());
        return;
    }

    // Get current rating from player object (already loaded on login)
    BattlegroundRatingData currentRating = player->GetBGRating();

    LOG_DEBUG("bg.mmr", "UpdatePlayerRating called for {} - Current rating: {:.2f}, Loaded: {}",
              player->GetName(), currentRating.rating, currentRating.loaded);
    
    // Build opponent list for Glicko-2
    std::vector<Glicko2Opponent> glickoOpponents;
    glickoOpponents.reserve(opponents.size());
    
    for (Player* opponent : opponents)
    {
        if (!opponent)
            continue;
        
        BattlegroundRatingData oppRating = opponent->GetBGRating();
        glickoOpponents.emplace_back(oppRating.rating, oppRating.ratingDeviation, won ? 1.0f : 0.0f);
    }
    
    // Store old values for history
    float oldRating = currentRating.rating;
    float oldRD = currentRating.ratingDeviation;
    float oldVolatility = currentRating.volatility;
    
    // Update rating using Glicko-2
    Glicko2Rating glickoRating(currentRating.rating, currentRating.ratingDeviation, currentRating.volatility);
    Glicko2Rating newRating = _glicko.UpdateRating(glickoRating, glickoOpponents);
    
    currentRating.rating = newRating.rating;
    currentRating.ratingDeviation = newRating.ratingDeviation;
    currentRating.volatility = newRating.volatility;
    currentRating.matchesPlayed++;
    
    if (won)
        currentRating.wins++;
    else
        currentRating.losses++;
    
    // Update player object (will be saved async on next SaveToDB)
    player->SetBGRating(currentRating);
    
    // Log to history table (async)
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_BG_MMR_HISTORY);
    stmt->SetData(0, player->GetGUID().GetCounter());
    stmt->SetData(1, oldRating);
    stmt->SetData(2, currentRating.rating);
    stmt->SetData(3, oldRD);
    stmt->SetData(4, currentRating.ratingDeviation);
    stmt->SetData(5, oldVolatility);
    stmt->SetData(6, currentRating.volatility);
    stmt->SetData(7, won ? 1 : 0);
    CharacterDatabase.Execute(stmt);
    
    LOG_DEBUG("bg.mmr", "Player {} rating updated: {} -> {} (RD: {} -> {}, Result: {})",
              player->GetName(), oldRating, currentRating.rating, oldRD, currentRating.ratingDeviation,
              won ? "WIN" : "LOSS");
}

float BattlegroundMMRMgr::GetPlayerMMR(Player* player) const
{
    if (!_enabled || !player)
        return _startingRating;
    
    // Read from cached player object - no DB query!
    return player->GetBGRating().rating;
}

float BattlegroundMMRMgr::GetPlayerGearScore(Player* player)
{
    if (!_enabled || !player)
        return 0.0f;
    
    return CalculateGearScore(player);
}

float BattlegroundMMRMgr::GetPlayerCombinedScore(Player* player)
{
    if (!_enabled || !player)
        return 0.0f;
    
    float mmr = GetPlayerMMR(player);
    float gearScore = GetPlayerGearScore(player);
    
    float normalizedGear = (gearScore / 300.0f) * 1500.0f;
    
    return (mmr * _mmrWeight) + (normalizedGear * _gearWeight);
}

float BattlegroundMMRMgr::GetRelaxedMMRTolerance(uint32 queueTimeSeconds) const
{
    if (!_queueRelaxationEnabled)
        return _initialMaxMMRDifference;
    
    if (queueTimeSeconds >= _maxRelaxationSeconds)
        return 999999.0f;
    
    uint32 intervalsElapsed = queueTimeSeconds / _relaxationIntervalSeconds;
    
    float relaxedTolerance = _initialMaxMMRDifference + (intervalsElapsed * _relaxationStepMMR);
    
    return relaxedTolerance;
}

void BattlegroundMMRMgr::InitializePlayerRating(Player* player)
{
    if (!_enabled || !player)
        return;
    
    // Only initialize if not already loaded
    if (!player->IsBGRatingLoaded())
    {
        BattlegroundRatingData data;
        data.rating = _startingRating;
        data.ratingDeviation = _startingRD;
        data.volatility = _startingVolatility;
        data.matchesPlayed = 0;
        data.wins = 0;
        data.losses = 0;
        data.loaded = true;
        
        player->SetBGRating(data);
    }
}
