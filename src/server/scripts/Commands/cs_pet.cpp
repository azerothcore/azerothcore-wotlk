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
#include "Language.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Pet.h"
#include "Player.h"
#include "SpellInfo.h"
#include "SpellMgr.h"

using namespace Acore::ChatCommands;

class pet_commandscript : public CommandScript
{
public:
    pet_commandscript() : CommandScript("pet_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable petCommandTable =
        {
            { "create",  HandlePetCreateCommand,  SEC_GAMEMASTER, Console::No },
            { "learn",   HandlePetLearnCommand,   SEC_GAMEMASTER, Console::No },
            { "unlearn", HandlePetUnlearnCommand, SEC_GAMEMASTER, Console::No }
        };

        static ChatCommandTable commandTable =
        {
            { "pet", petCommandTable }
        };

        return commandTable;
    }

    static bool HandlePetCreateCommand(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();
        Creature* creatureTarget = handler->getSelectedCreature();

        if (!creatureTarget || creatureTarget->IsPet() || creatureTarget->GetTypeId() == TYPEID_PLAYER)
        {
            handler->SendErrorMessage(LANG_SELECT_CREATURE);
            return false;
        }

        CreatureTemplate const* creatrueTemplate = sObjectMgr->GetCreatureTemplate(creatureTarget->GetEntry());
        // Creatures with family 0 crashes the server
        if (!creatrueTemplate->family)
        {
            handler->SendErrorMessage(LANG_CREATURE_NON_TAMEABLE, creatrueTemplate->Entry);
            return false;
        }

        if (player->IsExistPet())
        {
            handler->SendErrorMessage(LANG_YOU_ALREADY_HAVE_PET);
            return false;
        }

        if (!player->CreatePet(creatureTarget))
        {
            handler->SendErrorMessage(LANG_CREATURE_NON_TAMEABLE, creatrueTemplate->Entry);
            return false;
        }

        return true;
    }

    static bool HandlePetLearnCommand(ChatHandler* handler, SpellInfo const* spell)
    {
        if (!spell)
        {
            handler->SendErrorMessage(LANG_COMMAND_NOSPELLFOUND);
            return false;
        }

        if (!SpellMgr::IsSpellValid(spell))
        {
            handler->SendErrorMessage(LANG_COMMAND_SPELL_BROKEN, spell->Id);
            return false;
        }

        Pet* pet = handler->GetSession()->GetPlayer()->GetPet();
        if (!pet)
        {
            handler->SendErrorMessage("You have no pet");
            return false;
        }

        SpellScriptsBounds bounds = sObjectMgr->GetSpellScriptsBounds(spell->Id);
        uint32 spellDifficultyId = sSpellMgr->GetSpellDifficultyId(spell->Id);
        if (bounds.first != bounds.second || spellDifficultyId)
        {
            handler->SendErrorMessage("Spell {} cannot be learnt using a command!", spell->Id);
            return false;
        }

        // Check if pet already has it
        if (pet->HasSpell(spell->Id))
        {
            handler->SendErrorMessage("Pet already has spell: {}", spell->Id);
            return false;
        }

        pet->learnSpell(spell->Id);
        handler->PSendSysMessage("Pet has learned spell {}", spell->Id);

        return true;
    }

    static bool HandlePetUnlearnCommand(ChatHandler* handler, SpellInfo const* spell)
    {
        if (!spell)
        {
            handler->SendErrorMessage(LANG_COMMAND_NOSPELLFOUND);
            return false;
        }

        if (!SpellMgr::IsSpellValid(spell))
        {
            handler->SendErrorMessage(LANG_COMMAND_SPELL_BROKEN, spell->Id);
            return false;
        }

        Pet* pet = handler->GetSession()->GetPlayer()->GetPet();
        if (!pet)
        {
            handler->SendErrorMessage("You have no pet");
            return false;
        }

        if (pet->HasSpell(spell->Id))
        {
            pet->removeSpell(spell->Id, false);
        }
        else
        {
            handler->PSendSysMessage("Pet doesn't have that spell");
        }

        return true;
    }
};

void AddSC_pet_commandscript()
{
    new pet_commandscript();
}
