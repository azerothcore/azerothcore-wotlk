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

/* ScriptData
Name: cast_commandscript
%Complete: 100
Comment: All cast related commands
Category: commandscripts
EndScriptData */

#include "Chat.h"
#include "Creature.h"
#include "Language.h"
#include "Player.h"
#include "ScriptObject.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "WorldSession.h"

using namespace Acore::ChatCommands;

class cast_commandscript : public CommandScript
{
public:
    cast_commandscript() : CommandScript("cast_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable castCommandTable =
        {
            { "back",   HandleCastBackCommand,  SEC_GAMEMASTER, Console::No },
            { "dist",   HandleCastDistCommand,  SEC_GAMEMASTER, Console::No },
            { "self",   HandleCastSelfCommand,  SEC_GAMEMASTER, Console::No },
            { "target", HandleCastTargetCommad, SEC_GAMEMASTER, Console::No },
            { "dest",   HandleCastDestCommand,  SEC_GAMEMASTER, Console::No },
            { "",       HandleCastCommand,      SEC_GAMEMASTER, Console::No }
        };
        static ChatCommandTable commandTable =
        {
            { "cast", castCommandTable }
        };
        return commandTable;
    }

    static bool CheckSpellExistsAndIsValid(ChatHandler* handler, SpellInfo const* spell)
    {
        if (!spell)
        {
            handler->PSendSysMessage(LANG_COMMAND_NOSPELLFOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!SpellMgr::IsSpellValid(spell))
        {
            handler->PSendSysMessage(LANG_COMMAND_SPELL_BROKEN, spell->Id);
            handler->SetSentErrorMessage(true);
            return false;
        }
        return true;
    }

    static Optional<TriggerCastFlags> GetTriggerFlags(Optional<std::string> triggeredStr)
    {
        if (triggeredStr)
        {
            if (StringStartsWith("triggered", *triggeredStr)) // check if "triggered" starts with *triggeredStr (e.g. "trig", "trigger", etc.)
                return TRIGGERED_FULL_DEBUG_MASK;
            else
                return std::nullopt;
        }
        return TRIGGERED_NONE;
    }

    static bool HandleCastCommand(ChatHandler* handler, SpellInfo const* spell, Optional<std::string> triggeredStr)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target)
        {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!CheckSpellExistsAndIsValid(handler, spell))
            return false;

        Optional<TriggerCastFlags> triggerFlags = GetTriggerFlags(triggeredStr);
        if (!triggerFlags)
            return false;

        handler->GetSession()->GetPlayer()->CastSpell(target, spell->Id, *triggerFlags);

        return true;
    }

    static bool HandleCastBackCommand(ChatHandler* handler, SpellInfo const* spell, Optional<std::string> triggeredStr)
    {
        Creature* caster = handler->getSelectedCreature();
        if (!caster)
        {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!CheckSpellExistsAndIsValid(handler, spell))
            return false;

        Optional<TriggerCastFlags> triggerFlags = GetTriggerFlags(triggeredStr);
        if (!triggerFlags)
            return false;

        caster->CastSpell(handler->GetSession()->GetPlayer(), spell->Id, *triggerFlags);

        return true;
    }

    static bool HandleCastDistCommand(ChatHandler* handler, SpellInfo const* spell, float dist, Optional<std::string> triggeredStr)
    {
        if (!CheckSpellExistsAndIsValid(handler, spell))
            return false;

        Optional<TriggerCastFlags> triggerFlags = GetTriggerFlags(triggeredStr);
        if (!triggerFlags)
            return false;

        float x, y, z;
        handler->GetSession()->GetPlayer()->GetClosePoint(x, y, z, dist);
        handler->GetSession()->GetPlayer()->CastSpell(x, y, z, spell->Id, *triggerFlags);

        return true;
    }

    static bool HandleCastSelfCommand(ChatHandler* handler, SpellInfo const* spell, Optional<std::string> triggeredStr)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target)
        {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!CheckSpellExistsAndIsValid(handler, spell))
            return false;

        Optional<TriggerCastFlags> triggerFlags = GetTriggerFlags(triggeredStr);
        if (!triggerFlags)
            return false;

        target->CastSpell(target, spell->Id, *triggerFlags);

        return true;
    }

    static bool HandleCastTargetCommad(ChatHandler* handler, SpellInfo const* spell, Optional<std::string> triggeredStr)
    {
        Creature* caster = handler->getSelectedCreature();
        if (!caster)
        {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!caster->GetVictim())
        {
            handler->SendSysMessage(LANG_SELECTED_TARGET_NOT_HAVE_VICTIM);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!CheckSpellExistsAndIsValid(handler, spell))
            return false;

        Optional<TriggerCastFlags> triggerFlags = GetTriggerFlags(triggeredStr);
        if (!triggerFlags)
            return false;

        caster->CastSpell(caster->GetVictim(), spell->Id, *triggerFlags);

        return true;
    }

    static bool HandleCastDestCommand(ChatHandler* handler, SpellInfo const* spell, float x, float y, float z, Optional<std::string> triggeredStr)
    {
        Unit* caster = handler->getSelectedUnit();
        if (!caster)
        {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!CheckSpellExistsAndIsValid(handler, spell))
            return false;

        Optional<TriggerCastFlags> triggerFlags = GetTriggerFlags(triggeredStr);
        if (!triggerFlags)
            return false;

        caster->CastSpell(x, y, z, spell->Id, *triggerFlags);

        return true;
    }
};

void AddSC_cast_commandscript()
{
    new cast_commandscript();
}
