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

#include "BattlegroundSpamProtect.h"
#include "Battleground.h"
#include "GameTime.h"
#include "ObjectGuid.h"
#include "Player.h"
#include "World.h"

namespace
{
    std::unordered_map<ObjectGuid /*player guid*/, uint32 /*time*/> _players;

    void AddTime(ObjectGuid guid)
    {
        _players.insert_or_assign(guid, GameTime::GetGameTime().count());
    }

    uint32 GetTime(ObjectGuid guid)
    {
        auto const& itr = _players.find(guid);
        if (itr != _players.end())
        {
            return itr->second;
        }

        return 0;
    }

    bool IsCorrectDelay(ObjectGuid guid)
    {
        // Skip if spam time < 30 secs (default)
        return GameTime::GetGameTime().count() - GetTime(guid) >= sWorld->getIntConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_SPAM_DELAY);
    }
}

BGSpamProtect* BGSpamProtect::instance()
{
    static BGSpamProtect instance;
    return &instance;
}

bool BGSpamProtect::CanAnnounce(Player* player, Battleground* bg, uint32 minLevel, uint32 queueTotal)
{
    ObjectGuid guid = player->GetGUID();

    // Check prev time
    if (!IsCorrectDelay(guid))
    {
        return false;
    }

    if (bg)
    {
        // When limited, it announces only if there are at least CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_LIMIT_MIN_PLAYERS in queue
        auto limitQueueMinLevel = sWorld->getIntConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_LIMIT_MIN_LEVEL);
        if (limitQueueMinLevel && minLevel >= limitQueueMinLevel)
        {
            // limit only RBG for 80, WSG for lower levels
            auto bgTypeToLimit = minLevel == 80 ? BATTLEGROUND_RB : BATTLEGROUND_WS;

            if (bg->GetBgTypeID() == bgTypeToLimit && queueTotal < sWorld->getIntConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_LIMIT_MIN_PLAYERS))
            {
                return false;
            }
        }
    }

    AddTime(guid);
    return true;
}
