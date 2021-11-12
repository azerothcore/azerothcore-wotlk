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

#include "ScriptMgr.h"
#include "Chat.h"
#include "Language.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Pet.h"
#include "Player.h"
#include "SpellMgr.h"
#include "SpellInfo.h"
#include "WorldSession.h"

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
            handler->PSendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        CreatureTemplate const* creatrueTemplate = sObjectMgr->GetCreatureTemplate(creatureTarget->GetEntry());
        // Creatures with family 0 crashes the server
        if (!creatrueTemplate->family)
        {
            handler->PSendSysMessage("This creature cannot be tamed. (family id: 0).");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (player->GetPetGUID())
        {
            handler->PSendSysMessage("You already have a pet");
            handler->SetSentErrorMessage(true);
            return false;
        }

        // Everything looks OK, create new pet
        Pet* pet = new Pet(player, HUNTER_PET);
        if (!pet->CreateBaseAtCreature(creatureTarget))
        {
            delete pet;
            handler->PSendSysMessage("Error 1");
            return false;
        }

        creatureTarget->setDeathState(JUST_DIED);
        creatureTarget->RemoveCorpse();
        creatureTarget->SetHealth(0); // just for nice GM-mode view

        pet->SetGuidValue(UNIT_FIELD_CREATEDBY, player->GetGUID());
        pet->SetUInt32Value(UNIT_FIELD_FACTIONTEMPLATE, player->GetFaction());

        if (!pet->InitStatsForLevel(creatureTarget->getLevel()))
        {
            LOG_ERROR("misc", "InitStatsForLevel() in EffectTameCreature failed! Pet deleted.");
            handler->PSendSysMessage("Error 2");
            delete pet;
            return false;
        }

        // prepare visual effect for levelup
        pet->SetUInt32Value(UNIT_FIELD_LEVEL, creatureTarget->getLevel() - 1);
        pet->GetCharmInfo()->SetPetNumber(sObjectMgr->GeneratePetNumber(), true);

        // this enables pet details window (Shift+P)
        pet->InitPetCreateSpells();
        pet->SetFullHealth();
        pet->GetMap()->AddToMap(pet->ToCreature());

        // visual effect for levelup
        pet->SetUInt32Value(UNIT_FIELD_LEVEL, creatureTarget->getLevel());
        player->SetMinion(pet, true);
        pet->SavePetToDB(PET_SAVE_AS_CURRENT, false);
        player->PetSpellInitialize();

        return true;
    }

    static bool HandlePetLearnCommand(ChatHandler* handler, SpellInfo const* spell)
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

        Pet* pet = handler->GetSession()->GetPlayer()->GetPet();
        if (!pet)
        {
            handler->PSendSysMessage("You have no pet");
            handler->SetSentErrorMessage(true);
            return false;
        }

        SpellScriptsBounds bounds = sObjectMgr->GetSpellScriptsBounds(spell->Id);
        uint32 spellDifficultyId = sSpellMgr->GetSpellDifficultyId(spell->Id);
        if (bounds.first != bounds.second || spellDifficultyId)
        {
            handler->PSendSysMessage("Spell %u cannot be learnt using a command!", spell->Id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // Check if pet already has it
        if (pet->HasSpell(spell->Id))
        {
            handler->PSendSysMessage("Pet already has spell: %u", spell->Id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        pet->learnSpell(spell->Id);
        handler->PSendSysMessage("Pet has learned spell %u", spell->Id);

        return true;
    }

    static bool HandlePetUnlearnCommand(ChatHandler* handler, SpellInfo const* spell)
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

        Pet* pet = handler->GetSession()->GetPlayer()->GetPet();
        if (!pet)
        {
            handler->PSendSysMessage("You have no pet");
            handler->SetSentErrorMessage(true);
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
