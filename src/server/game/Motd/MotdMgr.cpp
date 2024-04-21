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

#include "MotdMgr.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "ScriptMgr.h"
#include "Timer.h"
#include "Tokenize.h"
#include "WorldPacket.h"
#include <iterator>

namespace
{
    WorldPacket MotdPacket;
    std::string FormattedMotd;
}

MotdMgr* MotdMgr::instance()
{
    static MotdMgr instance;
    return &instance;
}

void MotdMgr::SetMotd(std::string motd)
{
    // scripts may change motd
    sScriptMgr->OnMotdChange(motd);

    WorldPacket data(SMSG_MOTD);                     // new in 2.0.1

    std::vector<std::string_view> motdTokens = Acore::Tokenize(motd, '@', true);
    data << uint32(motdTokens.size()); // line count

    for (std::string_view token : motdTokens)
        data << token;

    MotdPacket = data;

    if (!motdTokens.size())
        return;

    std::ostringstream oss;
    std::copy(motdTokens.begin(), motdTokens.end() - 1, std::ostream_iterator<std::string_view>(oss, "\n"));
    oss << *(motdTokens.end() - 1); // copy back element
    FormattedMotd = oss.str();
}

void MotdMgr::LoadMotd()
{
    uint32 oldMSTime = getMSTime();

    uint32 realmId = sConfigMgr->GetOption<int32>("RealmID", 0);
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_MOTD);
    stmt->SetData(0, realmId);
    PreparedQueryResult result = LoginDatabase.Query(stmt);
    std::string motd;

    if (result)
    {
        Field* fields = result->Fetch();
        motd = fields[0].Get<std::string>();
    }
    else
    {
        LOG_WARN("server.loading", ">> Loaded 0 motd definitions. DB table `motd` is empty for this realm!");
        LOG_INFO("server.loading", " ");
    }

    MotdMgr::SetMotd(motd);

    LOG_INFO("server.loading", ">> Loaded Motd Definitions in {} ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

char const* MotdMgr::GetMotd()
{
    return FormattedMotd.c_str();
}

WorldPacket const* MotdMgr::GetMotdPacket()
{
    return &MotdPacket;
}
