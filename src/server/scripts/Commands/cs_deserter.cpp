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

/**
* @file cs_deserter.cpp
* @brief .deserter related commands
*
* This file contains the CommandScripts for all deserter sub-commands
*/

#include "Chat.h"
#include "Language.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuras.h"

using namespace Acore::ChatCommands;

enum Spells
{
    LFG_SPELL_DUNGEON_DESERTER = 71041,
    BG_SPELL_DESERTER = 26013
};

class deserter_commandscript : public CommandScript
{
public:
    deserter_commandscript() : CommandScript("deserter_commandscript") { }

    /**
    * @brief Returns the command structure for the system.
    */

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable deserterInstanceCommandTable =
        {
            { "add",        HandleDeserterInstanceAdd,       SEC_ADMINISTRATOR, Console::Yes },
            { "remove all", HandleDeserterInstanceRemoveAll, SEC_ADMINISTRATOR, Console::Yes },
            { "remove",     HandleDeserterInstanceRemove,    SEC_ADMINISTRATOR, Console::Yes }
        };
        static ChatCommandTable deserterBGCommandTable =
        {
            { "add",        HandleDeserterBGAdd,       SEC_ADMINISTRATOR, Console::Yes },
            { "remove all", HandleDeserterBGRemoveAll, SEC_ADMINISTRATOR, Console::Yes },
            { "remove",     HandleDeserterBGRemove,    SEC_ADMINISTRATOR, Console::Yes }
        };

        static ChatCommandTable deserterCommandTable =
        {
            { "instance", deserterInstanceCommandTable },
            { "bg",       deserterBGCommandTable }
        };
        static ChatCommandTable commandTable =
        {
            { "deserter", deserterCommandTable }
        };
        return commandTable;
    }

    /**
    * @brief Applies the Deserter Debuff to a player
    *
    * This function applies a Deserter Debuff of the given type (Instance or BG) to the
    * selected player, with the provided duration in seconds.
    *
    * @param handler The ChatHandler, passed by the system.
    * @param player The target player, either by name, the target or self
    * @param time The provided duration in seconds.
    * @param isInstance provided by the relaying functions, so we don't have
    * to write that much code :)
    *
    * @return true if everything was correct, false if an error occured.
    *
    * Example Usage:
    * @code
    * .deserter instance add 3600 (one hour) (using player target or self)
    * -or-
    * .deserter bg add 3600 (one hour) (using player target or self)
    * -or-
    * .deserter bg add Gozzim 3600 (one hour) (using player of name 'Gozzim')
    * @endcode
    */
    static bool HandleDeserterAdd(ChatHandler* handler, Optional<PlayerIdentifier> player, uint32 time, bool isInstance)
    {
        if (!player)
        {
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!player)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!time)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = player->GetConnectedPlayer();
        uint32 deserterSpell = isInstance ? LFG_SPELL_DUNGEON_DESERTER : BG_SPELL_DESERTER;

        if (target)
        {
            Aura* aura = target->GetAura(deserterSpell);
            if (aura && aura->GetDuration() >= (int32)time * IN_MILLISECONDS)
            {
                handler->PSendSysMessage("Player %s already has a longer %s Deserter active.", handler->playerLink(player->GetName()), isInstance ? "Instance" : "Battleground");
                return true;
            }

            aura = target->AddAura(deserterSpell, target);
            if (!aura)
            {
                handler->SendSysMessage(LANG_BAD_VALUE);
                handler->SetSentErrorMessage(true);
                return false;
            }
            aura->SetDuration(time * IN_MILLISECONDS);
        }
        else
        {
            int32 duration = 0;
            if (QueryResult result = CharacterDatabase.Query("SELECT remainTime FROM character_aura WHERE guid = {} AND spell = {}", player->GetGUID().GetCounter(), deserterSpell))
            {
                Field* fields = result->Fetch();
                duration = fields[0].Get<int32>();

                if (duration < 0 || duration >= (int32) time * IN_MILLISECONDS)
                {
                    handler->PSendSysMessage("Player %s already has a longer %s Deserter active.", handler->playerLink(player->GetName()), isInstance ? "Instance" : "Battleground");
                    return true;
                }
                CharacterDatabase.Query("DELETE FROM character_aura WHERE guid = {} AND spell = {}", player->GetGUID().GetCounter(), deserterSpell);
            }

            uint8 index = 0;
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_AURA);
            stmt->SetData(index++, player->GetGUID().GetCounter());
            stmt->SetData(index++, player->GetGUID().GetCounter());
            stmt->SetData(index++, 0);
            stmt->SetData(index++, deserterSpell);
            stmt->SetData(index++, 1);
            stmt->SetData(index++, 1);
            stmt->SetData(index++, 1);
            stmt->SetData(index++, 0);
            stmt->SetData(index++, 0);
            stmt->SetData(index++, 0);
            stmt->SetData(index++, 0);
            stmt->SetData(index++, 0);
            stmt->SetData(index++, 0);
            stmt->SetData(index++, isInstance ? 1800000 : 900000);
            stmt->SetData(index++, time * IN_MILLISECONDS);
            stmt->SetData(index, 0);
            CharacterDatabase.Execute(stmt);
        }

        handler->PSendSysMessage("%us of %s Deserter has been added to player %s.", time, isInstance ? "Instance" : "Battleground", handler->playerLink(player->GetName()));
        return true;
    }

    /**
    * @brief Removes the Deserter Debuff from a player
    *
    * This function removes a Deserter Debuff of the given type (Instance or BG) from the
    * selected player.
    *
    * @param handler The ChatHandler, passed by the system.
    * @param player The target player, either by name, the target or self
    * @param isInstance provided by the relaying functions, so we don't have
    * to write that much code :)
    *
    * @return true if everything was correct, false if an error occured.
    *
    * Example Usage:
    * @code
    * .deserter instance remove (using player target or self)
    * -or-
    * .deserter bg remove (using player target or self)
    * -or-
    * .deserter bg remove Gozzim (using player of name 'Gozzim')
    * @endcode
    */
    static bool HandleDeserterRemove(ChatHandler* handler, Optional<PlayerIdentifier> player, bool isInstance)
    {
        if (!player)
        {
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!player)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = player->GetConnectedPlayer();
        uint32 deserterSpell = isInstance ? LFG_SPELL_DUNGEON_DESERTER : BG_SPELL_DESERTER;
        int32 duration = 0;

        if (target)
        {
            if (Aura* aura = target->GetAura(deserterSpell))
            {
                duration = aura->GetDuration();
                target->RemoveAura(deserterSpell);
            }
        }
        else
        {
            if (QueryResult result = CharacterDatabase.Query("SELECT remainTime FROM character_aura WHERE guid = {} AND spell = {}", player->GetGUID().GetCounter(), deserterSpell))
            {
                Field* fields = result->Fetch();
                duration = fields[0].Get<int32>();
                CharacterDatabase.Execute("DELETE FROM character_aura WHERE guid = {} AND spell = {}", player->GetGUID().GetCounter(), deserterSpell);
            }
        }

        if (duration == 0)
        {
            handler->PSendSysMessage("Player %s does not have %s Deserter.", handler->playerLink(player->GetName()), isInstance ? "Instance" : "Battleground");
            handler->SetSentErrorMessage(true);
            return true;
        }

        if (duration < 0)
        {
            handler->PSendSysMessage("Permanent %s Deserter has been removed from player %s (GUID %u).", isInstance ? "Instance" : "Battleground", handler->playerLink(player->GetName()), player->GetGUID().GetCounter());
            handler->SetSentErrorMessage(true);
            return true;
        }

        handler->PSendSysMessage("%us of %s Deserter has been removed from player %s (GUID %u).", duration / IN_MILLISECONDS, isInstance ? "Instance" : "Battleground", handler->playerLink(player->GetName()), player->GetGUID().GetCounter());
        return true;
    }

    /**
    * @brief Removes the Deserter Debuff from all players
    *
    * This function removes a Deserter Debuff of the given type (Instance or BG) from
    * all players, online or offline.
    *
    * @param handler The ChatHandler, passed by the system.
    * @param isInstance provided by the relaying functions, so we don't have
    * to write that much code :)
    *
    * @return true if everything was correct, false if an error occured.
    *
    * Example Usage:
    * @code
    * .deserter instance remove all
    * -or-
    * .deserter bg remove all
    * @endcode
    */
    static bool HandleDeserterRemoveAll(ChatHandler* handler, bool isInstance)
    {
        uint32 deserterSpell = isInstance ? LFG_SPELL_DUNGEON_DESERTER : BG_SPELL_DESERTER;
        uint64 deserterCount = 0;
        bool countOnline = true;

        QueryResult result = CharacterDatabase.Query("SELECT COUNT(guid) FROM character_aura WHERE spell = {} AND remainTime <= 1800000", deserterSpell);
        if (result)
        {
            deserterCount = (*result)[0].Get<uint64>();
        }

        if (deserterCount > 0)
        {
            CharacterDatabase.Execute("DELETE FROM character_aura WHERE spell = {} AND remainTime <= 1800000", deserterSpell);
            countOnline = false;
        }

        std::shared_lock<std::shared_mutex> lock(*HashMapHolder<Player>::GetLock());
        HashMapHolder<Player>::MapType const& onlinePlayerList = ObjectAccessor::GetPlayers();
        for (HashMapHolder<Player>::MapType::const_iterator itr = onlinePlayerList.begin(); itr != onlinePlayerList.end(); ++itr)
        {
            Player* player = itr->second;
            Aura* aura = player->GetAura(deserterSpell);
            if (aura && aura->GetDuration() <= 1800000)
            {
                if (countOnline)
                    deserterCount++;
                player->RemoveAura(deserterSpell);
            }
        }

        if (deserterCount == 0)
        {
            handler->PSendSysMessage("No player on this realm has %s Deserter with a duration of 30min or less.", isInstance ? "Instance" : "Battleground");
            return true;
        }

        handler->PSendSysMessage("%s Deserter has been removed from %u player(s) with a duration of 30min or less.", isInstance ? "Instance" : "Battleground", deserterCount);
        return true;
    }

    /// @sa HandleDeserterAdd()
    static bool HandleDeserterInstanceAdd(ChatHandler* handler, Optional<PlayerIdentifier> player, uint32 time)
    {
        return HandleDeserterAdd(handler, player, time, true);
    }

    /// @sa HandleDeserterAdd()
    static bool HandleDeserterBGAdd(ChatHandler* handler, Optional<PlayerIdentifier> player, uint32 time)
    {
        return HandleDeserterAdd(handler, player, time, false);
    }

    /// @sa HandleDeserterRemove()
    static bool HandleDeserterInstanceRemove(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        return HandleDeserterRemove(handler, player, true);
    }

    /// @sa HandleDeserterRemove()
    static bool HandleDeserterBGRemove(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        return HandleDeserterRemove(handler, player, false);
    }

    static bool HandleDeserterInstanceRemoveAll(ChatHandler* handler)
    {
        return HandleDeserterRemoveAll(handler, true);
    }

    static bool HandleDeserterBGRemoveAll(ChatHandler* handler)
    {
        return HandleDeserterRemoveAll(handler, false);
    }
};

void AddSC_deserter_commandscript()
{
    new deserter_commandscript();
}
