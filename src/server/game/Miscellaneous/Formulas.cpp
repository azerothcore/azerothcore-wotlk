/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Formulas.h"
#include "Log.h"
#include "Creature.h"
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
        LOG_ERROR("server", "BaseGain: Unsupported content level %u", content);
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
        !(creature->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_NO_XP)))
    {
        float xpMod = 1.0f;

        gain = BaseGain(player->getLevel(), unit->getLevel(), GetContentLevelsForMapAndZone(unit->GetMapId(), unit->GetZoneId()));

        if (gain && creature)
        {
            if (creature->isElite())
            {
                // Elites in instances have a 2.75x XP bonus instead of the regular 2x world bonus.
                if (unit->GetMap() && unit->GetMap()->IsDungeon())
                    xpMod *= 2.75f;
                else
                    xpMod *= 2.0f;
            }

            // This requires TrinityCore creature_template.ExperienceModifier feature
            // xpMod *= creature->GetCreatureTemplate()->ModExperience;
        }

        xpMod *= isBattleGround ? sWorld->getRate(RATE_XP_BG_KILL) : sWorld->getRate(RATE_XP_KILL);
        gain = uint32(gain * xpMod);
    }

    //sScriptMgr->OnGainCalculation(gain, player, u); // pussywizard: optimization
    return gain;
}
