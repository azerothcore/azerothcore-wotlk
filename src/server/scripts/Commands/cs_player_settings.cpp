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

#include "Chat.h"
#include "CommandScript.h"
#include "Player.h"
#include "PlayerSettings.h"
#include "RBAC.h"

using namespace Acore::ChatCommands;

class player_settings_commandscript : public CommandScript
{
public:
    player_settings_commandscript() : CommandScript("player_settings_commandscript") {}

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable announcerCommandTable =
        {
            { "autobroadcast", HandleSettingsAnnouncerAutobroadcast, rbac::RBAC_PERM_COMMAND_SETTINGS_ANNOUNCER, Console::No },
        };
        static ChatCommandTable playerSettingsCommandTable =
        {
            { "announcer", announcerCommandTable },
        };
        static ChatCommandTable commandTable =
        {
            { "settings", playerSettingsCommandTable },
        };
        return commandTable;
    }

    static bool HandleSettingsAnnouncerAutobroadcast(ChatHandler* handler, bool on)
    {
        Player* player = handler->GetPlayer();

        PlayerSetting setting = player->GetPlayerSetting(AzerothcorePSSource, SETTING_ANNOUNCER_FLAGS);

        if (player->GetLevel() < sWorld->getIntConfig(CONFIG_AUTOBROADCAST_MIN_LEVEL_DISABLE))
        {
            handler->SetSentErrorMessage(true);
            handler->PSendSysMessage(LANG_CMD_AUTOBROADCAST_LVL_ERROR, sWorld->getIntConfig(CONFIG_AUTOBROADCAST_MIN_LEVEL_DISABLE));
        }

        on ? setting.RemoveFlag(ANNOUNCER_FLAG_DISABLE_AUTOBROADCAST) : setting.AddFlag(ANNOUNCER_FLAG_DISABLE_AUTOBROADCAST);
        player->UpdatePlayerSetting(AzerothcorePSSource, SETTING_ANNOUNCER_FLAGS, setting.value);

        handler->SetSentErrorMessage(false);
        handler->PSendSysMessage(on ? LANG_CMD_SETTINGS_ANNOUNCER_ON : LANG_CMD_SETTINGS_ANNOUNCER_OFF, "autobroadcast");
        return true;
    }
};

void AddSC_player_settings_commandscript()
{
    new player_settings_commandscript();
}
