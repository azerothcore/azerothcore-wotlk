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

#include "AccountMgr.h"
#include "Chat.h"
#include "CommandScript.h"
#include "DatabaseEnv.h"
#include "Language.h"
#include "ObjectAccessor.h"
#include "Opcodes.h"
#include "Player.h"
#include "Realm.h"
#include "World.h"
#include "WorldSession.h"

using namespace Acore::ChatCommands;

class gm_commandscript : public CommandScript
{
public:
    gm_commandscript() : CommandScript("gm_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable gmCommandTable =
        {
            { "chat",      HandleGMChatCommand,       SEC_GAMEMASTER,     Console::No  },
            { "fly",       HandleGMFlyCommand,        SEC_GAMEMASTER,     Console::No  },
            { "ingame",    HandleGMListIngameCommand, SEC_PLAYER,         Console::Yes },
            { "list",      HandleGMListFullCommand,   SEC_ADMINISTRATOR,  Console::Yes },
            { "visible",   HandleGMVisibleCommand,    SEC_GAMEMASTER,     Console::No  },
            { "on",        HandleGMOnCommand,         SEC_MODERATOR,      Console::No  },
            { "off",       HandleGMOffCommand,        SEC_MODERATOR,      Console::No  },
            { "spectator", HandleGMSpectatorCommand,  SEC_GAMEMASTER,     Console::No  },
        };
        static ChatCommandTable commandTable =
        {
            { "gm", gmCommandTable }
        };
        return commandTable;
    }

    // Enables or disables the staff badge
    static bool HandleGMChatCommand(ChatHandler* handler, Optional<bool> enableArg)
    {
        if (WorldSession* session = handler->GetSession())
        {
            if (!enableArg)
            {
                if (!AccountMgr::IsPlayerAccount(session->GetSecurity()) && session->GetPlayer()->isGMChat())
                    handler->SendNotification(LANG_GM_CHAT_ON);
                else
                    handler->SendNotification(LANG_GM_CHAT_OFF);
                return true;
            }

            if (*enableArg)
            {
                session->GetPlayer()->SetGMChat(true);
                handler->SendNotification(LANG_GM_CHAT_ON);
                return true;
            }
            else
            {
                session->GetPlayer()->SetGMChat(false);
                handler->SendNotification(LANG_GM_CHAT_OFF);
                return true;
            }
        }

        handler->SendErrorMessage(LANG_USE_BOL);
        return false;
    }

    static bool HandleGMFlyCommand(ChatHandler* handler, Optional<bool> enable)
    {
        Player* target = handler->getSelectedPlayer();
        if (!target)
            target = handler->GetSession()->GetPlayer();

        bool canFly = false;
        if (enable.has_value())
        {
            canFly = *enable;
            target->SetCanFly(canFly);
        }
        else
        {
            canFly = !handler->GetSession()->GetPlayer()->CanFly();
            target->SetCanFly(canFly);
        }

        handler->PSendSysMessage(LANG_COMMAND_FLYMODE_STATUS, handler->GetNameLink(target), canFly ? "on" : "off");
        return true;
    }

    static bool HandleGMListIngameCommand(ChatHandler* handler)
    {
        bool first = true;
        bool footer = false;

        std::shared_lock<std::shared_mutex> lock(*HashMapHolder<Player>::GetLock());
        for (auto const& [playerGuid, player] : ObjectAccessor::GetPlayers())
        {
            AccountTypes playerSec = player->GetSession()->GetSecurity();
            if ((player->IsGameMaster() ||
                 (!AccountMgr::IsPlayerAccount(playerSec) && playerSec <= AccountTypes(sWorld->getIntConfig(CONFIG_GM_LEVEL_IN_GM_LIST)))) &&
                (!handler->GetSession() || player->IsVisibleGloballyFor(handler->GetSession()->GetPlayer())))
            {
                if (first)
                {
                    first = false;
                    footer = true;
                    handler->SendSysMessage(LANG_GMS_ON_SRV);
                    handler->SendSysMessage("========================");
                }
                std::string const& name = player->GetName();
                uint8 size = uint8(name.size());
                uint8 security = playerSec;
                uint8 max = ((16 - size) / 2);
                uint8 max2 = max;
                if ((max + max2 + size) == 16)
                    max2 = max - 1;
                if (handler->GetSession())
                    handler->PSendSysMessage("|    {} GMLevel {}", name, security);
                else
                    handler->PSendSysMessage("|{}{}{}|   {}  |", max, " ", name, max2, " ", security);
            }
        }
        if (footer)
            handler->SendSysMessage("========================");
        if (first)
            handler->SendSysMessage(LANG_GMS_NOT_LOGGED);
        return true;
    }

    /// Display the list of GMs
    static bool HandleGMListFullCommand(ChatHandler* handler)
    {
        ///- Get the accounts with GM Level >0
        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_GM_ACCOUNTS);
        stmt->SetData(0, uint8(SEC_MODERATOR));
        stmt->SetData(1, int32(realm.Id.Realm));
        PreparedQueryResult result = LoginDatabase.Query(stmt);

        if (result)
        {
            handler->SendSysMessage(LANG_GMLIST);
            handler->SendSysMessage("========================");
            ///- Cycle through them. Display username and GM level
            do
            {
                Field* fields = result->Fetch();
                std::string name = fields[0].Get<std::string>();
                uint8 security = fields[1].Get<uint8>();
                uint8 max = (16 - name.length()) / 2;
                uint8 max2 = max;
                if ((max + max2 + name.length()) == 16)
                    max2 = max - 1;
                if (handler->GetSession())
                    handler->PSendSysMessage("|    {} GMLevel {}", name, security);
                else
                    handler->PSendSysMessage("|{}{}{}|   {}  |", max, " ", name, max2, " ", security);
            } while (result->NextRow());
            handler->SendSysMessage("========================");
        }
        else
            handler->PSendSysMessage(LANG_GMLIST_EMPTY);
        return true;
    }

    //Enable\Disable Invisible mode
    static bool HandleGMVisibleCommand(ChatHandler* handler, Optional<bool> visibleArg)
    {
        Player* _player = handler->GetSession()->GetPlayer();

        if (!visibleArg)
        {
            handler->PSendSysMessage(LANG_YOU_ARE, _player->isGMVisible() ? handler->GetAcoreString(LANG_VISIBLE) : handler->GetAcoreString(LANG_INVISIBLE));
            return true;
        }

        const uint32 VISUAL_AURA = 37800;

        if (*visibleArg)
        {
            if (_player->HasAura(VISUAL_AURA))
                _player->RemoveAurasDueToSpell(VISUAL_AURA);

            _player->SetGMVisible(true);
            _player->UpdateObjectVisibility();
            handler->SendNotification(LANG_INVISIBLE_VISIBLE);
        }
        else
        {
            _player->AddAura(VISUAL_AURA, _player);
            _player->SetGMVisible(false);
            _player->UpdateObjectVisibility();
            handler->SendNotification(LANG_INVISIBLE_INVISIBLE);
        }

        return true;
    }

    static bool HandleGMOnCommand(ChatHandler* handler)
    {
        handler->GetPlayer()->SetGameMaster(true);
        handler->GetPlayer()->UpdateTriggerVisibility();
        handler->SendNotification(LANG_GM_ON);
        return true;
    }

    static bool HandleGMOffCommand(ChatHandler* handler)
    {
        handler->GetPlayer()->SetGameMaster(false);
        handler->GetPlayer()->UpdateTriggerVisibility();
        handler->SendNotification(LANG_GM_OFF);
        return true;
    }

    static bool HandleGMSpectatorCommand(ChatHandler* handler, Optional<bool> enable)
    {
        Player* player = handler->GetSession()->GetPlayer();

        if (enable.has_value())
            player->SetGMSpectator(*enable);
        else
            player->SetGMSpectator(!player->IsGMSpectator());
        handler->SendNotification(player->IsGMSpectator() ? LANG_GM_SPECTATOR_ON : LANG_GM_SPECTATOR_OFF);

        return true;
    }
};

void AddSC_gm_commandscript()
{
    new gm_commandscript();
}
