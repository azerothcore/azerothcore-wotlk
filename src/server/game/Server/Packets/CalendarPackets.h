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

#ifndef CalendarPackets_h__
#define CalendarPackets_h__

#include "Guild.h"
#include "Packet.h"

namespace WorldPackets
{
    namespace Calendar
    {
        class GetEvent final : public ClientPacket
        {
        public:
            GetEvent(WorldPacket&& packet) : ClientPacket(CMSG_CALENDAR_GET_EVENT, std::move(packet)) {}

            void Read() override;

            uint64 EventId = 0;
        };

        class GuildFilter final : public ClientPacket
        {
        public:
            GuildFilter(WorldPacket&& packet) : ClientPacket(CMSG_CALENDAR_GUILD_FILTER, std::move(packet)) {}

            void Read() override;

            uint32 MinimumLevel = 1;
            uint32 MaximumLevel = 1;
            uint32 MinimumRank = GR_GUILDMASTER;
        };

        class ArenaTeam final : public ClientPacket
        {
        public:
            ArenaTeam(WorldPacket&& packet) : ClientPacket(CMSG_CALENDAR_ARENA_TEAM, std::move(packet)) {}

            void Read() override;

            uint32 ArenaTeamId = 0;
        };

        class CalendarComplain final : public ClientPacket
        {
        public:
            CalendarComplain(WorldPacket&& packet) : ClientPacket(CMSG_CALENDAR_COMPLAIN, std::move(packet)) {}

            void Read() override;

            uint64 EventId = 0;
            ObjectGuid ComplainGuid;
        };
    }
}

#endif // CalendarPackets_h__
