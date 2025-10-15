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

#ifndef _BATTLEGROUND_MMR_H
#define _BATTLEGROUND_MMR_H

#include "Glicko2.h"
#include "Player.h"

/**
 * @brief MMR data structure (used internally, not cached)
 */
struct BattlegroundPlayerMMR
{
    float rating;
    float ratingDeviation;
    float volatility;
    float gearScore;
    uint32 matchesPlayed;
    uint32 wins;
    uint32 losses;
    
    BattlegroundPlayerMMR() : rating(1500.0f), ratingDeviation(200.0f), 
                              volatility(0.06f), gearScore(0.0f), 
                              matchesPlayed(0), wins(0), losses(0) {}
};

/**
 * @class BattlegroundMMRMgr
 * @brief Singleton manager for battleground MMR system (cache-free design)
 * 
 * All data is queried directly from the database on demand.
 * No caching = no cache invalidation bugs = simpler and more reliable.
 */
class BattlegroundMMRMgr
{
private:
    BattlegroundMMRMgr() = default;
    ~BattlegroundMMRMgr() = default;

public:
    static BattlegroundMMRMgr* instance();
    
    /**
     * @brief Updates a player's rating after a battleground match
     * Queries current rating from DB, calculates new rating, saves to DB
     */
    void UpdatePlayerRating(Player* player, bool won, const std::vector<Player*>& opponents);
    
    /**
     * @brief Calculates gear score from equipped items
     */
    float CalculateGearScore(Player* player) const;
    
    /**
     * @brief Gets player's current MMR rating from database
     */
    float GetPlayerMMR(Player* player) const;
    
    /**
     * @brief Gets player's gear score (calculates on demand)
     */
    float GetPlayerGearScore(Player* player);
    
    /**
     * @brief Gets combined matchmaking score
     */
    float GetPlayerCombinedScore(Player* player);
    
    // Configuration accessors
    bool IsEnabled() const { return _enabled; }
    float GetMMRWeight() const { return _mmrWeight; }
    float GetGearWeight() const { return _gearWeight; }
    float GetStartingRating() const { return _startingRating; }
    float GetStartingRD() const { return _startingRD; }
    float GetStartingVolatility() const { return _startingVolatility; }
    float GetSystemTau() const { return _systemTau; }
    
    bool IsQueueRelaxationEnabled() const { return _queueRelaxationEnabled; }
    float GetRelaxedMMRTolerance(uint32 queueTimeSeconds) const;
    float GetInitialMaxMMRDifference() const { return _initialMaxMMRDifference; }
    
    void LoadConfig();
    
private:
    /**
     * @brief Loads MMR data from database (internal use)
     */
    BattlegroundPlayerMMR LoadFromDB(Player* player) const;
    
    /**
     * @brief Saves MMR data to database (internal use)
     */
    void SaveToDB(Player* player, const BattlegroundPlayerMMR& data);
    
    // Configuration
    bool _enabled;
    float _startingRating;
    float _startingRD;
    float _startingVolatility;
    float _systemTau;
    float _mmrWeight;
    float _gearWeight;
    
    bool _queueRelaxationEnabled;
    float _initialMaxMMRDifference;
    uint32 _relaxationIntervalSeconds;
    float _relaxationStepMMR;
    uint32 _maxRelaxationSeconds;
    
    Glicko2System _glicko;
};

#define sBattlegroundMMRMgr BattlegroundMMRMgr::instance()

#endif // _BATTLEGROUND_MMR_H
