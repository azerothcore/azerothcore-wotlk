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

#include "GameTime.h"
#include "Opcodes.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void WorldSession::SendAuthResponse(uint8 code, bool shortForm, uint32 queuePos)
{
    // BillingTimeRested: seconds of "healthy" play left before CAIS halves XP/loot from creatures
    // and quests. The client's GetBillingTimeRested() reads this; only meaningful while the CAIS
    // billing flag is set, so it stays 0 on realms/accounts without the play time limit.
    uint32 billingTimeRested = 0;
    if (IsAffectedByCAIS())
    {
        Seconds const played = GetConsecutivePlayTime(GameTime::GetGameTime());
        if (played < PLAY_TIME_LIMIT_PARTIAL)
            billingTimeRested = uint32((PLAY_TIME_LIMIT_PARTIAL - played).count());
    }

    WorldPacket packet(SMSG_AUTH_RESPONSE, 1 + 4 + 1 + 4 + 1 + (shortForm ? 0 : (4 + 1)));
    packet << uint8(code);
    packet << uint32(0); // BillingTimeRemaining
    packet << GetBillingPlanFlags();
    packet << billingTimeRested;
    uint8 exp = Expansion(); // 0 - normal, 1 - TBC, 2 - WotLK, must be set in database manually for each account

    if (exp >= MAX_EXPANSIONS)
        exp = MAX_EXPANSIONS - 1;

    packet << uint8(exp);

    if (!shortForm)
    {
        packet << uint32(queuePos);                             // Queue position
        packet << uint8(0);                                     // Realm has a free character migration - bool
    }

    SendPacket(&packet);
}

void WorldSession::SendClientCacheVersion(uint32 version)
{
    WorldPacket data(SMSG_CLIENTCACHE_VERSION, 4);
    data << uint32(version);
    SendPacket(&data);
}
