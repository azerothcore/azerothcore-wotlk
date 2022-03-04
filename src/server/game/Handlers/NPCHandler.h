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

#ifndef __NPCHANDLER_H
#define __NPCHANDLER_H

#include "Define.h"
#include <vector>

struct QEmote
{
    uint32 _Emote;
    uint32 _Delay;
};

#define MAX_GOSSIP_TEXT_EMOTES 3

struct GossipTextOption
{
    std::string Text_0;
    std::string Text_1;
    uint32 BroadcastTextID;
    uint32 Language;
    float Probability;
    QEmote Emotes[MAX_GOSSIP_TEXT_EMOTES];
};

#define MAX_GOSSIP_TEXT_OPTIONS 8

struct GossipText
{
    GossipTextOption Options[MAX_GOSSIP_TEXT_OPTIONS];
};

#endif
