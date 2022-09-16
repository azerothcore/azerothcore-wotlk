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

#ifndef _BATTLEGROUND_SCORE_H
#define _BATTLEGROUND_SCORE_H

#include "Errors.h"
#include "ObjectGuid.h"
#include "SharedDefines.h"

class WorldPacket;

enum ScoreType
{
    SCORE_KILLING_BLOWS = 1,
    SCORE_DEATHS,
    SCORE_HONORABLE_KILLS,
    SCORE_BONUS_HONOR,
    SCORE_DAMAGE_DONE,
    SCORE_HEALING_DONE,

    // WS and EY
    SCORE_FLAG_CAPTURES,
    SCORE_FLAG_RETURNS,

    // AB and IC
    SCORE_BASES_ASSAULTED,
    SCORE_BASES_DEFENDED,

    // AV
    SCORE_GRAVEYARDS_ASSAULTED,
    SCORE_GRAVEYARDS_DEFENDED,
    SCORE_TOWERS_ASSAULTED,
    SCORE_TOWERS_DEFENDED,
    SCORE_MINES_CAPTURED,
    //SCORE_LEADERS_KILLED,
    //SCORE_SECONDARY_OBJECTIVES,

    // SOTA
    SCORE_DESTROYED_DEMOLISHER,
    SCORE_DESTROYED_WALL
};

struct AC_GAME_API BattlegroundScore
{
    friend class Arena;
    friend class Battleground;

protected:
    BattlegroundScore(ObjectGuid playerGuid) : PlayerGuid(playerGuid) { }
    virtual ~BattlegroundScore() = default;

    virtual void UpdateScore(uint32 type, uint32 value)
    {
        switch (type)
        {
            case SCORE_KILLING_BLOWS:   // Killing blows
                KillingBlows += value;
                break;
            case SCORE_DEATHS:          // Deaths
                Deaths += value;
                break;
            case SCORE_HONORABLE_KILLS: // Honorable kills
                HonorableKills += value;
                break;
            case SCORE_BONUS_HONOR:     // Honor bonus
                BonusHonor += value;
                break;
            case SCORE_DAMAGE_DONE:     // Damage Done
                DamageDone += value;
                break;
            case SCORE_HEALING_DONE:    // Healing Done
                HealingDone += value;
                break;
            default:
                ABORT("Not implemented Battleground score type!");
                break;
        }
    }

    virtual void AppendToPacket(WorldPacket& data);
    virtual void BuildObjectivesBlock(WorldPacket& /*data*/) = 0;

    // For Logging purpose
    virtual std::string ToString() const { return ""; }

    [[nodiscard]] uint32 GetKillingBlows() const    { return KillingBlows; }
    [[nodiscard]] uint32 GetDeaths() const          { return Deaths; }
    [[nodiscard]] uint32 GetHonorableKills() const  { return HonorableKills; }
    [[nodiscard]] uint32 GetBonusHonor() const      { return BonusHonor; }
    [[nodiscard]] uint32 GetDamageDone() const      { return DamageDone; }
    [[nodiscard]] uint32 GetHealingDone() const     { return HealingDone; }

    [[nodiscard]] virtual uint32 GetAttr1() const { return 0; }
    [[nodiscard]] virtual uint32 GetAttr2() const { return 0; }
    [[nodiscard]] virtual uint32 GetAttr3() const { return 0; }
    [[nodiscard]] virtual uint32 GetAttr4() const { return 0; }
    [[nodiscard]] virtual uint32 GetAttr5() const { return 0; }

    ObjectGuid PlayerGuid;

    // Default score, present in every type
    uint32 KillingBlows = 0;
    uint32 Deaths = 0;
    uint32 HonorableKills = 0;
    uint32 BonusHonor = 0;
    uint32 DamageDone = 0;
    uint32 HealingDone = 0;
};

#endif // TRINITY_BATTLEGROUND_SCORE_H
