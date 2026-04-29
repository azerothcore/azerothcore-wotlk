/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Formulas.h"
#include "AreaDefines.h"
#include "Battleground.h"
#include "Creature.h"
#include "Log.h"
#include "Player.h"
#include "World.h"

uint32 Acore::XP::BaseGain(uint8 pl_level, uint8 mob_level, ContentLevels content)
{
    uint32 baseGain;
    uint32 nBaseExp;

    switch (content)
    {
    case CONTENT_1_60:
        nBaseExp = 45;
        break;
    case CONTENT_61_70:
        nBaseExp = 235;
        break;
    case CONTENT_71_80:
        nBaseExp = 580;
        break;
    default:
        LOG_ERROR("misc", "BaseGain: Unsupported content level {}", content);
        nBaseExp = 45;
        break;
    }

    if (mob_level >= pl_level)
    {
        uint8 nLevelDiff = mob_level - pl_level;
        if (nLevelDiff > 4)
            nLevelDiff = 4;

        baseGain = ((pl_level * 5 + nBaseExp) * (20 + nLevelDiff) / 10 + 1) / 2;
    }
    else
    {
        uint8 gray_level = GetGrayLevel(pl_level);
        if (mob_level > gray_level)
        {
            uint8 ZD = GetZeroDifference(pl_level);
            baseGain = (pl_level * 5 + nBaseExp) * (ZD + mob_level - pl_level) / ZD;
        }
        else
            baseGain = 0;
    }

    //sScriptMgr->OnBaseGainCalculation(baseGain, pl_level, mob_level, content); // pussywizard: optimization
    return baseGain;
}

uint32 Acore::XP::Gain(Player* player, Unit* unit, bool isBattleGround /*= false*/)
{
    Creature* creature = unit->ToCreature();
    uint32 gain = 0;

    if (!creature || (!creature->IsTotem() && !creature->IsPet() && !creature->IsCritter() &&
        !creature->HasFlagsExtra(CREATURE_FLAG_EXTRA_NO_XP)))
    {
        float xpMod = 1.0f;

        gain = BaseGain(player->GetLevel(), unit->GetLevel(), GetContentLevelsForMapAndZone(unit->GetMapId(), unit->GetZoneId()));

        if (gain && creature)
        {
            if (creature->isElite())
                xpMod *= 2.0f;

            // Instanced mobs (particularly bosses) oftentimes have higher bonuses, especially in later content levels
            xpMod *= creature->GetCreatureTemplate()->ModExperience;
        }

        if (isBattleGround)
        {
            switch (player->GetMapId())
            {
                case MAP_ALTERAC_VALLEY:
                    xpMod *= sWorld->getRate(RATE_XP_BG_KILL_AV);
                    break;
                case MAP_WARSONG_GULCH:
                    xpMod *= sWorld->getRate(RATE_XP_BG_KILL_WSG);
                    break;
                case MAP_ARATHI_BASIN:
                    xpMod *= sWorld->getRate(RATE_XP_BG_KILL_AB);
                    break;
                case MAP_EYE_OF_THE_STORM:
                    xpMod *= sWorld->getRate(RATE_XP_BG_KILL_EOTS);
                    break;
                case MAP_STRAND_OF_THE_ANCIENTS:
                    xpMod *= sWorld->getRate(RATE_XP_BG_KILL_SOTA);
                    break;
                case MAP_ISLE_OF_CONQUEST:
                    xpMod *= sWorld->getRate(RATE_XP_BG_KILL_IC);
                    break;
            }
        }
        else
        {
            xpMod *= sWorld->getRate(RATE_XP_KILL);
        }

        // if players dealt less than 50% of the damage and were credited anyway (due to CREATURE_FLAG_EXTRA_NO_PLAYER_DAMAGE_REQ), scale XP gained appropriately (linear scaling)
        if (creature && creature->GetPlayerDamageReq())
        {
            xpMod *= 1.0f - 2.0f * creature->GetPlayerDamageReq() / creature->GetMaxHealth();
        }

        gain = uint32(gain * xpMod);
    }

    //sScriptMgr->OnGainCalculation(gain, player, u); // pussywizard: optimization
    return gain;
}
