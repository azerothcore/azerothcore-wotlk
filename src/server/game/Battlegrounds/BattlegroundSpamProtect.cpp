/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "BattlegroundSpamProtect.h"
#include "Battleground.h"
#include "ObjectGuid.h"
#include "Player.h"
#include "World.h"

namespace
{
    std::unordered_map<ObjectGuid /*player guid*/, uint32 /*time*/> _players;

    void AddTime(ObjectGuid guid)
    {
        _players.insert_or_assign(guid, sWorld->GetGameTime());
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
        return sWorld->GetGameTime() - GetTime(guid) >= sWorld->getIntConfig(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_SPAM_DELAY);
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
