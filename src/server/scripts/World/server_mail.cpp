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

#include "Mail.h"
#include "ObjectMgr.h"
#include "QueryResult.h"

class ServerMailReward : public PlayerScript
{
public:
    ServerMailReward() : PlayerScript("ServerMailReward") { }

    // CHARACTER_LOGIN = 8
    void OnLogin(Player* player) override
    {
        //                                                    0     1           2              3         4         5        6             7       8             9          10      11
        QueryResult result = CharacterDatabase.Query("SELECT `id`, `reqLevel`, `reqPlayTime`, `moneyA`, `moneyH`, `itemA`, `itemCountA`, `itemH`,`itemCountH`, `subject`, `body`, `active` FROM `mail_server_template`");
        if (!result)
            return;

        do
        {
            Field* fields = result->Fetch();

            ServerMail servMail;

            servMail.id          = fields[0].Get<uint32>();
            servMail.reqLevel    = fields[1].Get<uint8>();
            servMail.reqPlayTime = fields[2].Get<uint32>();
            servMail.moneyA      = fields[3].Get<uint32>();
            servMail.moneyH      = fields[4].Get<uint32>();
            servMail.itemA       = fields[5].Get<uint32>();
            servMail.itemCountA  = fields[6].Get<uint32>();
            servMail.itemH       = fields[7].Get<uint32>();
            servMail.itemCountH  = fields[8].Get<uint32>();
            servMail.subject     = fields[9].Get<std::string>();
            servMail.body        = fields[10].Get<std::string>();
            servMail.active      = fields[11].Get<uint8>();

            if (CharacterDatabase.Query("SELECT mailId from mail_server_character where guid = {} and mailId = {}", player->GetGUID().GetCounter(), servMail.id))
                continue;

            sObjectMgr->SendServerMail(player, servMail.id, servMail.reqLevel, servMail.reqPlayTime, servMail.moneyA, servMail.moneyH, servMail.itemA, servMail.itemCountA, servMail.itemH, servMail.itemCountH, servMail.subject, servMail.body, servMail.active);
        } while (result->NextRow());
    }
};

void AddSC_server_mail()
{
    new ServerMailReward();
}
