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

#include "QueryPackets.h"

void WorldPackets::Query::NameQuery::Read()
{
    _worldPacket >> Guid;
}

WorldPacket const* WorldPackets::Query::NameQueryResponse::Write()
{
    _worldPacket << Guid;
    _worldPacket << NameUnknown;
    if (NameUnknown)
        return &_worldPacket;

    _worldPacket << Name;
    _worldPacket << RealmName;
    _worldPacket << Race;
    _worldPacket << Sex;
    _worldPacket << Class;
    _worldPacket << Declined;
    if (Declined)
    {
        for (uint8 i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
            _worldPacket << DeclinedNames.name[i];
    }

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Query::TimeQueryResponse::Write()
{
    _worldPacket << ServerTime;
    _worldPacket << TimeResponse;

    return &_worldPacket;
}

void WorldPackets::Query::CorpseMapPositionQuery::Read()
{
    _worldPacket >> unk;
}
