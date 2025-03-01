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

#ifndef _SERVERMAILMGR_H
#define _SERVERMAILMGR_H

#include "Player.h"
#include <string>
#include <unordered_map>
#include <vector>

struct ServerMailItems
{
    ServerMailItems() = default;
    uint32 item{ 0 };
    uint32 itemCount{ 0 };
};

struct ServerMail
{
    ServerMail() = default;
    uint32 id{ 0 };
    uint8 reqLevel{ 0 };
    uint32 reqPlayTime{ 0 };
    uint32 moneyA{ 0 };
    uint32 moneyH{ 0 };
    std::string subject;
    std::string body;
    uint8 active{ 0 };

    // Items from mail_server_template_items
    std::vector<ServerMailItems> itemsA;
    std::vector<ServerMailItems> itemsH;
};

typedef std::unordered_map<uint32, ServerMail> ServerMailContainer;

class ServerMailMgr
{
private:
    ServerMailMgr();
    ~ServerMailMgr();
public:
    static ServerMailMgr* instance();

    void LoadMailServerTemplates();
    void LoadMailServerTemplatesItems();
    void SendServerMail(Player* player, uint32 id, uint32 reqLevel, uint32 reqPlayTime, uint32 rewardMoneyA, uint32 rewardMoneyH, std::vector<ServerMailItems> const& items, std::string subject, std::string body, uint8 active) const;

    [[nodiscard]] ServerMailContainer const& GetAllServerMailStore() const { return _serverMailStore; }

private:
    ServerMailContainer _serverMailStore;
};

#define sServerMailMgr ServerMailMgr::instance()

#endif // _SERVERMAILMGR_H
