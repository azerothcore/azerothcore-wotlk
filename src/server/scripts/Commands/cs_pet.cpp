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
#include "DatabaseEnv.h"
#include <algorithm>
#include "Language.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Pet.h"
#include "Player.h"
#include "RBAC.h"
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
            { "create",  HandlePetCreateCommand,  rbac::RBAC_PERM_COMMAND_PET_CREATE,  Console::No  },
            { "delete",  HandlePetDeleteCommand,  rbac::RBAC_PERM_COMMAND_PET_DELETE,  Console::Yes },
            { "learn",   HandlePetLearnCommand,   rbac::RBAC_PERM_COMMAND_PET_LEARN,   Console::No  },
            { "list",    HandlePetListCommand,    rbac::RBAC_PERM_COMMAND_PET_LIST,    Console::Yes },
            { "unlearn", HandlePetUnlearnCommand, rbac::RBAC_PERM_COMMAND_PET_UNLEARN, Console::No  }
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

        if (!creatureTarget || creatureTarget->IsPet() || creatureTarget->IsPlayer())
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

    static bool HandlePetDeleteCommand(ChatHandler* handler, PlayerIdentifier owner, uint32 petNumber)
    {
        ObjectGuid ownerGuid = owner.GetGUID();

        QueryResult result = CharacterDatabase.Query(
            "SELECT entry, name FROM character_pet WHERE id = {} AND owner = {}",
            petNumber, ownerGuid.GetCounter());

        if (!result)
        {
            handler->SendErrorMessage(LANG_PET_DELETE_NOT_FOUND, petNumber, owner.GetName(),
                                      ownerGuid.GetCounter());
            return false;
        }

        if (Player* online = owner.GetConnectedPlayer())
        {
            if (Pet* activePet = online->GetPet())
            {
                if (activePet->GetCharmInfo() &&
                    activePet->GetCharmInfo()->GetPetNumber() == petNumber)
                {
                    online->RemovePet(activePet, PET_SAVE_AS_DELETED);
                }
            }

            // Drop the pet from the in-memory PetStable so the stable UI / call-pet
            // logic does not reference a row that no longer exists in the database.
            if (PetStable* stable = online->GetPetStable())
            {
                if (stable->CurrentPet && stable->CurrentPet->PetNumber == petNumber)
                    stable->CurrentPet.reset();

                for (Optional<PetStable::PetInfo>& stabled : stable->StabledPets)
                    if (stabled && stabled->PetNumber == petNumber)
                        stabled.reset();

                stable->UnslottedPets.erase(
                    std::remove_if(stable->UnslottedPets.begin(), stable->UnslottedPets.end(),
                        [petNumber](PetStable::PetInfo const& p) { return p.PetNumber == petNumber; }),
                    stable->UnslottedPets.end());
            }
        }

        Field* fields    = result->Fetch();
        uint32 entry     = fields[0].Get<uint32>();
        std::string name = fields[1].Get<std::string>();

        std::string creatureName = "<unknown>";
        if (CreatureTemplate const* cInfo = sObjectMgr->GetCreatureTemplate(entry))
            creatureName = cInfo->Name;

        Pet::DeleteFromDB(petNumber);

        handler->PSendSysMessage(LANG_PET_DELETE_SUCCESS, petNumber, name, entry, creatureName,
                                 owner.GetName(), ownerGuid.GetCounter());
        return true;
    }

    static bool HandlePetListCommand(ChatHandler* handler, PlayerIdentifier owner)
    {
        ObjectGuid ownerGuid = owner.GetGUID();

        QueryResult result = CharacterDatabase.Query(
            "SELECT id, entry, level, slot, name, PetType FROM character_pet "
            "WHERE owner = {} ORDER BY slot, id",
            ownerGuid.GetCounter());

        if (!result)
        {
            handler->PSendSysMessage(LANG_PET_LIST_EMPTY, owner.GetName(), ownerGuid.GetCounter());
            return true;
        }

        handler->PSendSysMessage(LANG_PET_LIST_HEADER, owner.GetName(), ownerGuid.GetCounter());

        do
        {
            Field* fields    = result->Fetch();
            uint32 petNumber = fields[0].Get<uint32>();
            uint32 entry     = fields[1].Get<uint32>();
            uint8  level     = fields[2].Get<uint8>();
            uint8  slot      = fields[3].Get<uint8>();
            std::string name = fields[4].Get<std::string>();
            uint8  petType   = fields[5].Get<uint8>();

            std::string creatureName = "<unknown>";
            if (CreatureTemplate const* cInfo = sObjectMgr->GetCreatureTemplate(entry))
                creatureName = cInfo->Name;

            handler->PSendSysMessage(LANG_PET_LIST_ENTRY, petNumber, uint32(slot), entry,
                                     creatureName, name, uint32(level), uint32(petType));
        } while (result->NextRow());

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
