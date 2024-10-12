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

#include "GameTime.h"
#include "Log.h"
#include "Opcodes.h"
#include "Player.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void WorldSession::HandleDuelAcceptedOpcode(WorldPacket& recvPacket)
{
    Player* player = GetPlayer();
    if (!player->duel || player == player->duel->Initiator || player->duel->State != DUEL_STATE_CHALLENGED)
        return;

    ObjectGuid guid;
    recvPacket >> guid;

    Player* target = player->duel->Opponent;
    if (target->GetGuidValue(PLAYER_DUEL_ARBITER) != guid)
        return;

    LOG_DEBUG("network.opcode", "Player 1 is: {} ({})", player->GetGUID().ToString(), player->GetName());
    LOG_DEBUG("network.opcode", "Player 2 is: {} ({})", target->GetGUID().ToString(), target->GetName());

    time_t now = GameTime::GetGameTime().count();
    player->duel->StartTime = now + 3;
    target->duel->StartTime = now + 3;

    player->duel->State = DUEL_STATE_COUNTDOWN;
    target->duel->State = DUEL_STATE_COUNTDOWN;

    player->SendDuelCountdown(3000);
    target->SendDuelCountdown(3000);
}

void WorldSession::HandleDuelCancelledOpcode(WorldPacket& recvPacket)
{
    Player* player = GetPlayer();

    ObjectGuid guid;
    recvPacket >> guid;

    // no duel requested
    if (!player->duel || player->duel->State == DUEL_STATE_COMPLETED)
        return;

    // player surrendered in a duel using /forfeit
    if (GetPlayer()->duel->State == DUEL_STATE_IN_PROGRESS)
    {
        GetPlayer()->CombatStopWithPets(true);
        GetPlayer()->duel->Opponent->CombatStopWithPets(true);

        GetPlayer()->CastSpell(GetPlayer(), 7267, true);    // beg
        GetPlayer()->DuelComplete(DUEL_WON);
        return;
    }

    GetPlayer()->DuelComplete(DUEL_INTERRUPTED);
}
