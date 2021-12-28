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

#include "Tokenize.h"
#include "StringConvert.h"
#include "Player.h"

/*********************************************************/
/***              PLAYER SETTINGS SYSTEM               ***/
/*********************************************************/

void Player::_LoadCharacterSettings(PreparedQueryResult result)
{
    m_charSettingsMap.clear();

    if (!sWorld->getBoolConfig(CONFIG_PLAYER_SETTINGS_ENABLED))
    {
        return;
    }

    if (result)
    {
        do
        {
            Field* fields = result->Fetch();

            std::string source = fields[0].GetString();;
            std::string data = fields[1].GetString();

            std::vector<std::string_view> tokens = Acore::Tokenize(data, ' ', true);

            PlayerSettingVector setting;
            setting.resize(tokens.size());

            uint32 count = 0;

            for (auto token : tokens)
            {
                PlayerSetting set;
                set.value = Acore::StringTo<uint32>(token).value();
                setting[++count] = set;
            }

            m_charSettingsMap[source] = setting;

        } while (result->NextRow());
    }
}

PlayerSetting Player::GetPlayerSetting(std::string source, uint8 index)
{
    auto itr = m_charSettingsMap.find(source);

    if (itr == m_charSettingsMap.end())
    {
        // Settings not found, this will initialize a new entry.
        UpdatePlayerSetting(source, index, 0);
        return GetPlayerSetting(source, index);
    }

    return itr->second[index];
}

void Player::_SavePlayerSettings(CharacterDatabaseTransaction trans)
{
    if (!sWorld->getBoolConfig(CONFIG_PLAYER_SETTINGS_ENABLED))
    {
        return;
    }

    for (auto itr : m_charSettingsMap)
    {
        std::ostringstream data;

        for (auto setting : itr.second)
        {
            data << setting.value << ' ';
        }

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_CHAR_SETTINGS);
        stmt->setUInt32(0, GetGUID().GetCounter());
        stmt->setString(1, itr.first);
        stmt->setString(2, data.str());
        trans->Append(stmt);
    }
}

void Player::UpdatePlayerSetting(std::string source, uint8 index, uint32 value)
{
    auto itr = m_charSettingsMap.find(source);

    if (itr == m_charSettingsMap.end())
    {
        // Settings not found, initialize a new entry.
        uint8 size = index ? index : index + 1;

        PlayerSettingVector setting;
        setting.resize(size);

        for (uint32 itr = 0; itr <= index; ++itr)
        {
            PlayerSetting set;
            set.value = itr == index ? value : 0;

            setting[itr] = set;
        }

        m_charSettingsMap[source] = setting;
    }
    else
    {
        itr->second[index].value = value;
    }
}
