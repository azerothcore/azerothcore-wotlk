/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Common.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Log.h"
#include "Opcodes.h"
#include "UpdateData.h"
#include "Player.h"

void WorldSession::HandleDuelAcceptedOpcode(WorldPacket& recvPacket)
{
    uint64 guid;
    Player* player;
    Player* plTarget;

    recvPacket >> guid;

    if (!GetPlayer()->duel)                                  // ignore accept from duel-sender
        return;

    player       = GetPlayer();
    plTarget = player->duel->opponent;

    if (player == player->duel->initiator || !plTarget || player == plTarget || player->duel->startTime != 0 || plTarget->duel->startTime != 0)
        return;

    //sLog->outDebug(LOG_FILTER_PACKETIO, "WORLD: Received CMSG_DUEL_ACCEPTED");
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outStaticDebug("Player 1 is: %u (%s)", player->GetGUIDLow(), player->GetName().c_str());
    sLog->outStaticDebug("Player 2 is: %u (%s)", plTarget->GetGUIDLow(), plTarget->GetName().c_str());
#endif

    time_t now = time(NULL);
    player->duel->startTimer = now;
    plTarget->duel->startTimer = now;

    player->SendDuelCountdown(3000);
    plTarget->SendDuelCountdown(3000);
}

void WorldSession::HandleDuelCancelledOpcode(WorldPacket& recvPacket)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_DUEL_CANCELLED");
#endif
    uint64 guid;
    recvPacket >> guid;

    // no duel requested
    if (!GetPlayer()->duel)
        return;

    // player surrendered in a duel using /forfeit
    if (GetPlayer()->duel->startTime != 0)
    {
        GetPlayer()->CombatStopWithPets(true);
        if (GetPlayer()->duel->opponent)
            GetPlayer()->duel->opponent->CombatStopWithPets(true);

        GetPlayer()->CastSpell(GetPlayer(), 7267, true);    // beg
        GetPlayer()->DuelComplete(DUEL_WON);
        return;
    }

    GetPlayer()->DuelComplete(DUEL_INTERRUPTED);
}
