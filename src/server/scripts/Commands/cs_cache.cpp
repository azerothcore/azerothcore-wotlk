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

#include "Chat.h"
#include "CommandScript.h"
#include "Group.h"
#include "Language.h"
#include "Player.h"

using namespace Acore::ChatCommands;

class cache_commandscript : public CommandScript
{
public:
    cache_commandscript() : CommandScript("cache_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable cacheCommandTable =
        {
            { "info",      HandleCacheInfoCommand,       SEC_GAMEMASTER, Console::Yes    },
            { "delete",    HandleCacheDeleteCommand,     SEC_ADMINISTRATOR, Console::Yes },
            { "refresh",   HandleCacheRefreshCommand,    SEC_GAMEMASTER, Console::Yes    }
        };

        static ChatCommandTable commandTable =
        {
            { "cache", cacheCommandTable },
        };
        return commandTable;
    }

    static bool HandleCacheInfoCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!player)
        {
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!player)
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        CharacterCacheEntry const* cache = sCharacterCache->GetCharacterCacheByGuid(player->GetGUID());

        if (!cache)
        {
            handler->SendErrorMessage(LANG_COMMAND_CACHE_NOT_FOUND, player->GetName());
            return false;
        }

        handler->PSendSysMessage(LANG_COMMAND_CACHE_INFO, cache->Name, cache->Guid.ToString(), cache->AccountId,
            cache->Class, cache->Race, cache->Sex, cache->Level, cache->MailCount, cache->GuildId, cache->GroupGuid.ToString(),
            cache->ArenaTeamId[ARENA_SLOT_2v2], cache->ArenaTeamId[ARENA_SLOT_3v3], cache->ArenaTeamId[ARENA_SLOT_5v5]);

        handler->SetSentErrorMessage(false);
        return true;
    }

    static bool HandleCacheDeleteCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!player)
        {
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!player)
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        sCharacterCache->DeleteCharacterCacheEntry(player->GetGUID(), player->GetName());
        handler->PSendSysMessage(LANG_COMMAND_CACHE_DELETE, player->GetName(), player->GetGUID().ToString());
        handler->SetSentErrorMessage(false);
        return true;
    }

    static bool HandleCacheRefreshCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!player)
        {
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!player)
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        if (player->IsConnected())
        {
            if (Player* cPlayer = ObjectAccessor::FindConnectedPlayer(player->GetGUID()))
            {
                if (sCharacterCache->HasCharacterCacheEntry(cPlayer->GetGUID()))
                {
                    sCharacterCache->UpdateCharacterData(cPlayer->GetGUID(), cPlayer->GetName(), cPlayer->getGender(), cPlayer->getRace());
                }
                else
                {
                    sCharacterCache->AddCharacterCacheEntry(cPlayer->GetGUID(), cPlayer->GetSession()->GetAccountId(), cPlayer->GetName(),
                        cPlayer->getGender(), cPlayer->getRace(), cPlayer->getClass(), cPlayer->GetLevel());
                }

                sCharacterCache->UpdateCharacterAccountId(cPlayer->GetGUID(), cPlayer->GetSession()->GetAccountId());
                sCharacterCache->UpdateCharacterGuildId(cPlayer->GetGUID(), cPlayer->GetGuildId());
                sCharacterCache->UpdateCharacterMailCount(cPlayer->GetGUID(), cPlayer->GetMailSize(), true);
                sCharacterCache->UpdateCharacterArenaTeamId(cPlayer->GetGUID(), ARENA_SLOT_2v2, cPlayer->GetArenaTeamId(ARENA_SLOT_2v2));
                sCharacterCache->UpdateCharacterArenaTeamId(cPlayer->GetGUID(), ARENA_SLOT_3v3, cPlayer->GetArenaTeamId(ARENA_SLOT_3v3));
                sCharacterCache->UpdateCharacterArenaTeamId(cPlayer->GetGUID(), ARENA_SLOT_5v5, cPlayer->GetArenaTeamId(ARENA_SLOT_5v5));

                if (Group* group = cPlayer->GetGroup())
                {
                    sCharacterCache->UpdateCharacterGroup(cPlayer->GetGUID(), group->GetGUID());
                }
                else
                {
                    sCharacterCache->ClearCharacterGroup(cPlayer->GetGUID());
                }
            }
        }
        else
        {
            sCharacterCache->RefreshCacheEntry(player->GetGUID().GetCounter());
        }

        handler->PSendSysMessage(LANG_COMMAND_CACHE_REFRESH, player->GetName(), player->GetGUID().ToString());
        handler->SetSentErrorMessage(false);
        return true;
    }
};

void AddSC_cache_commandscript()
{
    new cache_commandscript();
}
