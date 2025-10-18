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
 * @class BattlegroundMMRMgr
 * @brief Singleton manager for battleground MMR system
 * 
 * This system uses Player object caching for optimal performance:
 * - Rating data loaded once on login via LoginQueryHolder (async)
 * - All queries read from Player object (zero DB queries during gameplay)
 * - Updates saved async during Player::SaveToDB()
 * 
 * Benefits:
 * - No synchronous DB queries
 * - Minimal latency during matchmaking
 * - Automatic persistence with player saves
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
     * Reads from player object cache, calculates new rating, updates player object
     * Rating is saved async on next Player::SaveToDB()
     */
    void UpdatePlayerRating(Player* player, bool won, const std::vector<Player*>& opponents);
    
    /**
     * @brief Calculates gear score from equipped items
     */
    float CalculateGearScore(Player* player);
    
    /**
     * @brief Gets player's current MMR rating from player object (no DB query)
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
    
    /**
     * @brief Initializes default rating for new players
     * Called if LoginQueryHolder returns no existing record
     */
    void InitializePlayerRating(Player* player);
    
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
