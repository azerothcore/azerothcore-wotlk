/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "Chat.h"
#include "ScriptMgr.h"
#include "Language.h"
#include "Player.h"
#include "PlayerCommand.h"

bool PlayerCommand::Learn(ChatHandler* handler, Player* targetPlayer, uint32 spell, char const* all)
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
        if (targetPlayer == handler->GetSession()->GetPlayer())
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

bool PlayerCommand::UnLearn(ChatHandler* handler, Player* target, uint32 spellId, char const* allStr)
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
