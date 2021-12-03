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


#include "Player.h"

/*********************************************************/
/***                    SETTINGS SYSTEM                ***/
/*********************************************************/

void Player::_LoadCharacterSettings(PreparedQueryResult result)
{
    m_charSettingsMap.clear();

    if (result)
    {
        do
        {
            Field* fields = result->Fetch();

            uint32 source = fields[0].GetUInt32();
            std::string data = fields[1].GetString();

            Tokenizer tokens(data, ' ');

            PlayerSettingVector setting;
            setting.resize(tokens.size());

            uint32 count = 0;

            for (auto token : tokens)
            {
                PlayerSetting set;
                set.value = atoi(token);
                setting[count] = set;
                ++count;
            }

            m_charSettingsMap[source] = setting;

        } while (result->NextRow());
    }
}

PlayerSetting Player::GetPlayerSetting(uint32 source, uint32 index) const
{
    auto itr = m_charSettingsMap.find(source);

    if (itr == m_charSettingsMap.end())
    {
        PlayerSetting setting;
        setting.value = 0;
        return setting;
    }

    return itr->second[index];
}

void Player::UpdatePlayerSetting(uint32 source, uint32 index, uint32 value)
{
    auto itr = m_charSettingsMap.find(source);

    if (itr == m_charSettingsMap.end())
    {
        return;
    }

    itr->second[index].value = value;
}

void Player::_SavePlayerSettings(CharacterDatabaseTransaction trans)
{
    std::string data;

    for (auto itr : m_charSettingsMap)
    {
        for (auto setting : itr.second)
        {
            data << setting.value;
        }
    }
}
