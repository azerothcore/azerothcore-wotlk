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
Name: learn_commandscript
%Complete: 100
Comment: All learn related commands
Category: commandscripts
EndScriptData */

#include "CommandScript.h"
#include "Language.h"
#include "ObjectMgr.h"
#include "Pet.h"
#include "Player.h"
#include "PlayerCommand.h"
#include "SpellInfo.h"
#include "SpellMgr.h"

using namespace Acore::ChatCommands;

class learn_commandscript : public CommandScript
{
public:
    learn_commandscript() : CommandScript("learn_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable learnAllMyCommandTable =
        {
            { "class",      HandleLearnAllMyClassCommand,      SEC_GAMEMASTER, Console::No },
            { "pettalents", HandleLearnAllMyPetTalentsCommand, SEC_GAMEMASTER, Console::No },
            { "spells",     HandleLearnAllMySpellsCommand,     SEC_GAMEMASTER, Console::No },
            { "talents",    HandleLearnAllMyTalentsCommand,    SEC_GAMEMASTER, Console::No }
        };

        static ChatCommandTable learnAllCommandTable =
        {
            { "my", learnAllMyCommandTable },
            { "gm",        HandleLearnAllGMCommand,            SEC_GAMEMASTER, Console::No },
            { "crafts",    HandleLearnAllCraftsCommand,        SEC_GAMEMASTER, Console::No },
            { "default",   HandleLearnAllDefaultCommand,       SEC_GAMEMASTER, Console::No },
            { "lang",      HandleLearnAllLangCommand,          SEC_GAMEMASTER, Console::No },
            { "recipes",   HandleLearnAllRecipesCommand,       SEC_GAMEMASTER, Console::No },
        };

        static ChatCommandTable learnCommandTable =
        {
            { "all", learnAllCommandTable },
            { "",     HandleLearnCommand,                      SEC_GAMEMASTER, Console::No }
        };

        static ChatCommandTable commandTable =
        {
            { "learn", learnCommandTable },
            { "unlearn",     HandleUnLearnCommand,             SEC_GAMEMASTER, Console::No }
        };
        return commandTable;
    }

    static bool HandleLearnCommand(ChatHandler* handler, SpellInfo const* spell, Optional<EXACT_SEQUENCE("all")> allRanks)
    {
        Player* targetPlayer = handler->getSelectedPlayer();

        if (!targetPlayer)
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        return Acore::PlayerCommand::HandleLearnSpellCommand(handler, targetPlayer, spell, allRanks);
    }

    static bool HandleLearnAllGMCommand(ChatHandler* handler)
    {
        for (uint32 i = 0; i < sSpellMgr->GetSpellInfoStoreSize(); ++i)
        {
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(i);
            if (!spellInfo || !SpellMgr::IsSpellValid(spellInfo))
                continue;

            if (!spellInfo->IsAbilityOfSkillType(SKILL_INTERNAL))
                continue;

            handler->GetSession()->GetPlayer()->learnSpell(i);
        }

        handler->SendSysMessage(LANG_LEARNING_GM_SKILLS);
        return true;
    }

    static bool HandleLearnAllMyClassCommand(ChatHandler* handler)
    {
        HandleLearnAllMySpellsCommand(handler);
        HandleLearnAllMyTalentsCommand(handler);
        return true;
    }

    static bool HandleLearnAllMySpellsCommand(ChatHandler* handler)
    {
        ChrClassesEntry const* classEntry = sChrClassesStore.LookupEntry(handler->GetSession()->GetPlayer()->getClass());
        if (!classEntry)
            return true;
        uint32 family = classEntry->spellfamily;

        for (uint32 i = 0; i < sSkillLineAbilityStore.GetNumRows(); ++i)
        {
            SkillLineAbilityEntry const* entry = sSkillLineAbilityStore.LookupEntry(i);
            if (!entry)
                continue;

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(entry->Spell);
            if (!spellInfo)
                continue;

            // skip server-side/triggered spells
            if (spellInfo->SpellLevel == 0)
                continue;

            // skip wrong class/race skills
            if (!handler->GetSession()->GetPlayer()->IsSpellFitByClassAndRace(spellInfo->Id))
                continue;

            // skip other spell families
            if (spellInfo->SpellFamilyName != family)
                continue;

            // skip spells with first rank learned as talent (and all talents then also)
            uint32 firstRank = sSpellMgr->GetFirstSpellInChain(spellInfo->Id);
            if (GetTalentSpellCost(firstRank) > 0)
                continue;

            // skip broken spells
            if (!SpellMgr::IsSpellValid(spellInfo))
                continue;

            handler->GetSession()->GetPlayer()->learnSpell(spellInfo->Id);
        }

        handler->SendSysMessage(LANG_COMMAND_LEARN_CLASS_SPELLS);
        return true;
    }

    static bool HandleLearnAllMyTalentsCommand(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();
        uint32 classMask = player->getClassMask();

        for (uint32 i = 0; i < sTalentStore.GetNumRows(); ++i)
        {
            TalentEntry const* talentInfo = sTalentStore.LookupEntry(i);
            if (!talentInfo)
                continue;

            TalentTabEntry const* talentTabInfo = sTalentTabStore.LookupEntry(talentInfo->TalentTab);
            if (!talentTabInfo)
                continue;

            if ((classMask & talentTabInfo->ClassMask) == 0)
                continue;

            // xinef: search highest talent rank
            uint32 spellId = 0;
            uint8 rankId = MAX_TALENT_RANK;
            for (int8 rank = MAX_TALENT_RANK - 1; rank >= 0; --rank)
            {
                if (talentInfo->RankID[rank] != 0)
                {
                    rankId = rank;
                    spellId = talentInfo->RankID[rank];
                    break;
                }
            }

            // xinef: some errors?
            if (!spellId || rankId == MAX_TALENT_RANK)
                continue;

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
            if (!spellInfo || !SpellMgr::IsSpellValid(spellInfo))
                continue;

            player->LearnTalent(talentInfo->TalentID, rankId, true);
        }

        player->SetFreeTalentPoints(0);
        player->SendTalentsInfoData(false);

        handler->SendSysMessage(LANG_COMMAND_LEARN_CLASS_TALENTS);
        return true;
    }

    static bool HandleLearnAllMyPetTalentsCommand(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();

        Pet* pet = player->GetPet();
        if (!pet)
        {
            handler->SendErrorMessage(LANG_NO_PET_FOUND);
            return false;
        }

        CreatureTemplate const* creatureInfo = pet->GetCreatureTemplate();
        if (!creatureInfo)
        {
            handler->SendErrorMessage(LANG_WRONG_PET_TYPE);
            return false;
        }

        CreatureFamilyEntry const* petFamily = sCreatureFamilyStore.LookupEntry(creatureInfo->family);
        if (!petFamily)
        {
            handler->SendErrorMessage(LANG_WRONG_PET_TYPE);
            return false;
        }

        if (petFamily->petTalentType < 0)                       // not hunter pet
        {
            handler->SendErrorMessage(LANG_WRONG_PET_TYPE);
            return false;
        }

        for (uint32 i = 0; i < sTalentStore.GetNumRows(); ++i)
        {
            TalentEntry const* talentInfo = sTalentStore.LookupEntry(i);
            if (!talentInfo)
                continue;

            TalentTabEntry const* talentTabInfo = sTalentTabStore.LookupEntry(talentInfo->TalentTab);
            if (!talentTabInfo)
                continue;

            // prevent learn talent for different family (cheating)
            if (((1 << petFamily->petTalentType) & talentTabInfo->petTalentMask) == 0)
                continue;

            // search highest talent rank
            uint32 spellId = 0;

            for (int8 rank = MAX_TALENT_RANK - 1; rank >= 0; --rank)
            {
                if (talentInfo->RankID[rank] != 0)
                {
                    spellId = talentInfo->RankID[rank];
                    break;
                }
            }

            if (!spellId)                                        // ??? none spells in talent
                continue;

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
            if (!spellInfo || !SpellMgr::IsSpellValid(spellInfo))
                continue;

            // learn highest rank of talent and learn all non-talent spell ranks (recursive by tree)
            pet->learnSpellHighRank(spellId);
        }

        pet->SetFreeTalentPoints(0);

        handler->SendSysMessage(LANG_COMMAND_LEARN_PET_TALENTS);
        return true;
    }

    static bool HandleLearnAllLangCommand(ChatHandler* handler)
    {
        for (LanguageDesc const& langDesc : lang_description)
            if (uint32 langSpellId = langDesc.spell_id)
            {
                handler->GetPlayer()->learnSpell(langSpellId);
                handler->GetPlayer()->SetSkill(langDesc.skill_id, 0, 300, 300);
            }

        handler->SendSysMessage(LANG_COMMAND_LEARN_ALL_LANG);
        return true;
    }

    static bool HandleLearnAllDefaultCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!player)
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        if (!player || !player->IsConnected())
            return false;

        Player* target = player->GetConnectedPlayer();
        target->LearnDefaultSkills();
        target->LearnCustomSpells();
        target->learnQuestRewardedSpells();

        handler->PSendSysMessage(LANG_COMMAND_LEARN_ALL_DEFAULT_AND_QUEST, handler->GetNameLink(target).c_str());
        return true;
    }

    static bool HandleLearnAllCraftsCommand(ChatHandler* handler)
    {
        for (uint32 i = 0; i < sSkillLineStore.GetNumRows(); ++i)
        {
            SkillLineEntry const* skillInfo = sSkillLineStore.LookupEntry(i);
            if (!skillInfo)
                continue;

            if ((skillInfo->categoryId == SKILL_CATEGORY_PROFESSION || skillInfo->categoryId == SKILL_CATEGORY_SECONDARY) &&
                    skillInfo->canLink)                             // only prof. with recipes have
            {
                HandleLearnSkillRecipesHelper(handler->GetSession()->GetPlayer(), skillInfo->id);
            }
        }

        handler->SendSysMessage(LANG_COMMAND_LEARN_ALL_CRAFT);
        return true;
    }

    static bool HandleLearnAllRecipesCommand(ChatHandler* handler, WTail namePart)
    {
        //  Learns all recipes of specified profession and sets skill to max
        //  Example: .learn all_recipes enchanting

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        if (namePart.empty())
            return false;

        // converting string that we try to find to lower case
        wstrToLower(namePart);

        SkillLineEntry const* targetSkillInfo = nullptr;
        char const* name = nullptr;
        for (uint32 i = 1; i < sSkillLineStore.GetNumRows(); ++i)
        {
            SkillLineEntry const* skillInfo = sSkillLineStore.LookupEntry(i);
            if (!skillInfo)
                continue;

            if ((skillInfo->categoryId != SKILL_CATEGORY_PROFESSION &&
                 skillInfo->categoryId != SKILL_CATEGORY_SECONDARY) ||
                !skillInfo->canLink)                            // only prof with recipes have set
                continue;

            uint8 locale = 0;
            for (; locale < TOTAL_LOCALES; ++locale)
            {
                name = skillInfo->name[locale];
                if (!name || !*name)
                    continue;

                if (Utf8FitTo(name, namePart))
                    break;
            }

            if (locale < TOTAL_LOCALES)
            {
                targetSkillInfo = skillInfo;
                break;
            }
        }

        if (!(name && targetSkillInfo))
            return false;

        HandleLearnSkillRecipesHelper(target, targetSkillInfo->id);

        uint16 maxLevel = target->GetPureMaxSkillValue(targetSkillInfo->id);
        target->SetSkill(targetSkillInfo->id, target->GetSkillStep(targetSkillInfo->id), maxLevel, maxLevel);
        handler->PSendSysMessage(LANG_COMMAND_LEARN_ALL_RECIPES, name);
        return true;
    }

    static void HandleLearnSkillRecipesHelper(Player* player, uint32 skillId)
    {
        uint32 classmask = player->getClassMask();

        for (SkillLineAbilityEntry const* skillLine : GetSkillLineAbilitiesBySkillLine(skillId))
        {
            // not high rank
            if (skillLine->SupercededBySpell)
                continue;

            // skip racial skills
            if (skillLine->RaceMask != 0)
                continue;

            // skip wrong class skills
            if (skillLine->ClassMask && (skillLine->ClassMask & classmask) == 0)
                continue;

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(skillLine->Spell);
            if (!spellInfo || !SpellMgr::IsSpellValid(spellInfo))
                continue;

            player->learnSpell(skillLine->Spell);
        }
    }

    static bool HandleUnLearnCommand(ChatHandler* handler, SpellInfo const* spell, Optional<EXACT_SEQUENCE("all")> allRanks)
    {
        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendErrorMessage(LANG_NO_CHAR_SELECTED);
            return false;
        }

        return Acore::PlayerCommand::HandleUnlearnSpellCommand(handler, target, spell, allRanks);
    }
};

void AddSC_learn_commandscript()
{
    new learn_commandscript();
}
