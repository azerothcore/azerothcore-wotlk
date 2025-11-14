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

#include "CreatureScript.h"
#include "Player.h"
#include "PlayerScript.h"
#include "QueryResult.h"
#include "ServerMailMgr.h"

class ServerMailReward : public PlayerScript
{
public:
    ServerMailReward() : PlayerScript("ServerMailReward", {PLAYERHOOK_ON_LOGIN}) { }

    // CHARACTER_LOGIN = 8
    void OnPlayerLogin(Player* player) override
    {
        // Retrieve all server mail records and session only once
        auto const& serverMailStore = sServerMailMgr->GetAllServerMailStore();
        WorldSession* session = player->GetSession();
        // We should always have a session, just incase
        if (!session)
            return;

        uint32 playerGUID = player->GetGUID().GetCounter();
        bool isAlliance = player->GetTeamId() == TEAM_ALLIANCE;

        for (auto const& [mailId, servMail] : serverMailStore)
        {
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_MAIL_SERVER_CHARACTER);
            stmt->SetData(0, playerGUID);
            stmt->SetData(1, mailId);

            // Capture servMail by value
            auto callback = [session, servMailWrapper = std::reference_wrapper<ServerMail const>(servMail), isAlliance](PreparedQueryResult result)
                {
                    ServerMail const& servMail = servMailWrapper.get();  // Dereference the wrapper to get the original object

                    if (!result)
                    {
                        uint32 money = isAlliance ? servMail.moneyA : servMail.moneyH;
                        std::vector<ServerMailItems> const& items = isAlliance ? servMail.itemsA : servMail.itemsH;
                        std::vector<ServerMailCondition> const& conditions = servMail.conditions;

                        sServerMailMgr->SendServerMail(
                            session->GetPlayer(),
                            servMail.id,
                            money,
                            items,
                            conditions,
                            servMail.subject,
                            servMail.body
                        );
                    }
                };

            // Execute the query asynchronously and add the callback
            session->GetQueryProcessor().AddCallback(CharacterDatabase.AsyncQuery(stmt).WithPreparedCallback(callback));
        }
    }
};

void AddSC_server_mail()
{
    new ServerMailReward();
}
