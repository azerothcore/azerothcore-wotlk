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

#include "PlayerCommand.h"
#include "Language.h"

bool Acore::PlayerCommand::HandleLearnSpellCommand(ChatHandler* handler, Player* targetPlayer, uint32 spell, char const* all)
{
    if (!spell)
        return false;

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spell);
    if (!spellInfo)
    {
        handler->PSendSysMessage(LANG_COMMAND_NOSPELLFOUND);
        handler->SetSentErrorMessage(true);
        return false;
    }

    if (!SpellMgr::IsSpellValid(spellInfo))
    {
        handler->PSendSysMessage(LANG_COMMAND_SPELL_BROKEN, spell);
        handler->SetSentErrorMessage(true);
        return false;
    }

    if (handler->GetSession())
    {
        SpellScriptsBounds bounds = sObjectMgr->GetSpellScriptsBounds(spell);
        uint32 spellDifficultyId = sSpellMgr->GetSpellDifficultyId(spell);
        if (handler->GetSession() && handler->GetSession()->GetSecurity() < SEC_ADMINISTRATOR && (bounds.first != bounds.second || spellDifficultyId))
        {
            handler->PSendSysMessage("Spell %u cannot be learnt using a command!", spell);
            handler->SetSentErrorMessage(true);
            return false;
        }
    }

    bool allRanks = all ? (strncmp(all, "all", 3) == 0) : false;

    if (!allRanks && targetPlayer->HasSpell(spell))
    {
        if (handler->GetSession() && targetPlayer == handler->GetSession()->GetPlayer())
            handler->SendSysMessage(LANG_YOU_KNOWN_SPELL);
        else
            handler->PSendSysMessage(LANG_TARGET_KNOWN_SPELL, handler->GetNameLink(targetPlayer).c_str());
        handler->SetSentErrorMessage(true);
        return false;
    }

    if (allRanks)
        targetPlayer->learnSpellHighRank(spell);
    else
        targetPlayer->learnSpell(spell);

    uint32 firstSpell = sSpellMgr->GetFirstSpellInChain(spell);
    if (GetTalentSpellCost(firstSpell))
        targetPlayer->SendTalentsInfoData(false);

    return true;
}

bool Acore::PlayerCommand::HandleUnlearnSpellCommand(ChatHandler* handler, Player* target, uint32 spellId, char const* allStr)
{
    if (!spellId)
        return false;

    bool allRanks = allStr ? (strncmp(allStr, "all", 3) == 0) : false;

    if (allRanks)
        spellId = sSpellMgr->GetFirstSpellInChain (spellId);

    if (target->HasSpell(spellId))
        target->removeSpell(spellId, SPEC_MASK_ALL, false);
    else
        handler->SendSysMessage(LANG_FORGET_SPELL);

    if (GetTalentSpellCost(spellId))
        target->SendTalentsInfoData(false);

    return true;
}
