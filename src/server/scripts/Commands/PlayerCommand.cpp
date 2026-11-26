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

#include "PlayerCommand.h"
#include "Group.h"
#include "InstanceSaveMgr.h"
#include "Language.h"
#include "Map.h"
#include "MotionMaster.h"
#include "Player.h"
#include "RBAC.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "WorldSession.h"

bool Acore::PlayerCommand::HandleLearnSpellCommand(ChatHandler* handler, Player* targetPlayer, SpellInfo const* spell, Optional<EXACT_SEQUENCE("all")> allRanks)
{
    if (!SpellMgr::IsSpellValid(spell))
    {
        handler->SendErrorMessage(LANG_COMMAND_SPELL_BROKEN, spell->Id);
        return false;
    }

    if (!allRanks && targetPlayer->HasSpell(spell->Id))
    {
        if (targetPlayer == handler->GetPlayer())
        {
            handler->SendErrorMessage(LANG_YOU_KNOWN_SPELL);
        }
        else
        {
            handler->SendErrorMessage(LANG_TARGET_KNOWN_SPELL, handler->GetNameLink(targetPlayer).c_str());
        }

        return false;
    }

    targetPlayer->learnSpell(spell->Id, false);

    if (allRanks)
    {
        uint32 spellId = spell->Id;

        while ((spellId = sSpellMgr->GetNextSpellInChain(spellId)))
        {
            targetPlayer->learnSpell(spellId, false);
        }
    }

    if (GetTalentSpellCost(spell->GetFirstRankSpell()->Id))
    {
        targetPlayer->SendTalentsInfoData(false);
    }

    return true;
}

bool Acore::PlayerCommand::HandleUnlearnSpellCommand(ChatHandler* handler, Player* target, SpellInfo const* spell, Optional<EXACT_SEQUENCE("all")> allRanks)
{
    uint32 spellId = spell->Id;

    if (allRanks)
    {
        spellId = sSpellMgr->GetFirstSpellInChain(spellId);
    }

    if (target->HasSpell(spellId))
    {
        target->removeSpell(spellId, SPEC_MASK_ALL, false);
    }
    else
    {
        handler->SendSysMessage(LANG_FORGET_SPELL);
    }

    if (GetTalentSpellCost(spellId))
    {
        target->SendTalentsInfoData(false);
    }

    return true;
}

bool Acore::PlayerCommand::SummonOnlinePlayer(ChatHandler* handler, Player* target)
{
    Player* summoner = handler->GetPlayer();
    std::string const nameLink = handler->GetNameLink(target);

    if (handler->HasLowerSecurity(target))
        return false;

    if (target->IsBeingTeleported())
    {
        handler->SendErrorMessage(LANG_IS_TELEPORTED, nameLink);
        return false;
    }

    Map* map = summoner->GetMap();
    if (map->IsDungeon())
    {
        if (target->GetSession()->GetSecurity() == SEC_PLAYER && !handler->GetSession()->HasPermission(rbac::RBAC_PERM_COMMANDS_SUMMON_PLAYERS_TO_INSTANCE))
        {
            handler->SendErrorMessage(LANG_CANNOT_SUMMON_PLAYER_TO_INST, nameLink);
            return false;
        }

        // Leaving the battleground or battlefield drops this raid before the teleport picks the instance copy,
        // so the bind check below would read the wrong leader
        if (Group* group = target->GetGroup(); group && (group->isBGGroup() || group->isBFGroup()))
        {
            handler->SendErrorMessage(LANG_CANNOT_SUMMON_BG_RAID_TO_INST, nameLink);
            return false;
        }

        // The teleport picks the instance copy from the target's own bind or their group leader's bind, never from the summoner.
        if (sInstanceSaveMgr->PlayerGetDestinationInstanceId(target, map->GetId(), target->GetDifficulty(map->IsRaid())) != map->GetInstanceId())
        {
            handler->SendErrorMessage(LANG_CANNOT_SUMMON_TO_INST, nameLink);
            return false;
        }
    }

    handler->PSendSysMessage(LANG_SUMMONING, nameLink, "");
    if (handler->needReportToTarget(target))
        ChatHandler(target->GetSession()).PSendSysMessage(LANG_SUMMONED_BY, handler->GetNameLink());

    if (target->IsInFlight())
    {
        target->GetMotionMaster()->MovementExpired();
        target->CleanupAfterTaxiFlight();
    }
    else
        target->SaveRecallPosition();

    float x, y, z;
    summoner->GetClosePoint(x, y, z, target->GetObjectSize());
    target->TeleportTo(summoner->GetMapId(), x, y, z, target->GetOrientation(), 0, summoner);
    return true;
}
