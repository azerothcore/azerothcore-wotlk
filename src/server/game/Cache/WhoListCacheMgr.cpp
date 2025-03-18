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

#include "WhoListCacheMgr.h"
#include "GuildMgr.h"
#include "ObjectAccessor.h"
#include "World.h"
#include "WorldSessionMgr.h"

WhoListCacheMgr* WhoListCacheMgr::instance()
{
    static WhoListCacheMgr instance;
    return &instance;
}

void WhoListCacheMgr::Update()
{
    // clear current list
    _whoListStorage.clear();
    _whoListStorage.reserve(sWorldSessionMgr->GetPlayerCount() + 1);

    for (auto const& [guid, player] : ObjectAccessor::GetPlayers())
    {
        if (!player->FindMap() || player->GetSession()->PlayerLoading())
            continue;

        std::string playerName = player->GetName();
        std::wstring widePlayerName;

        if (!Utf8toWStr(playerName, widePlayerName))
            continue;

        wstrToLower(widePlayerName);

        std::string guildName = sGuildMgr->GetGuildNameById(player->GetGuildId());
        std::wstring wideGuildName;

        if (!Utf8toWStr(guildName, wideGuildName))
            continue;

        wstrToLower(wideGuildName);

        _whoListStorage.emplace_back(player->GetGUID(), player->GetTeamId(), player->GetSession()->GetSecurity(), player->GetLevel(),
            player->getClass(), player->getRace(),
            (player->IsSpectator() ? 4395 /*Dalaran*/ : player->GetZoneId()), player->getGender(), player->IsVisible(),
            widePlayerName, wideGuildName, playerName, guildName);
    }
}
