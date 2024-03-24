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

#include "KillRewarder.h"
#include "Formulas.h"
#include "Group.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"

// KillRewarder incapsulates logic of rewarding player upon kill with:
// * XP;
// * honor;
// * reputation;
// * kill credit (for quest objectives).
// Rewarding is initiated in two cases: when player kills unit in Unit::Kill()
// and on battlegrounds in Battleground::RewardXPAtKill().
//
// Rewarding algorithm is:
// 1. Initialize internal variables to default values.
// 2. In case when player is in group, initialize variables necessary for group calculations:
// 2.1. _count - number of alive group members within reward distance;
// 2.2. _aliveSumLevel - sum of levels of alive group members within reward distance;
// 2.3. _sumLevel - sum of levels of group members within reward distance;
// 2.4. _maxLevel - maximum level of alive group member within reward distance;
// 2.5. _maxNotGrayMember - maximum level of alive group member within reward distance,
//      for whom victim is not gray;
// 2.6. _isFullXP - flag identifying that for all group members victim is not gray,
//      so 100% XP will be rewarded (50% otherwise).
// 3. Reward killer (and group, if necessary).
// 3.1. If killer is in group, reward group.
// 3.1.1. Initialize initial XP amount based on maximum level of group member,
//        for whom victim is not gray.
// 3.1.2. Alter group rate if group is in raid (not for battlegrounds).
// 3.1.3. Reward each group member (even dead) within reward distance (see 4. for more details).
// 3.2. Reward single killer (not group case).
// 3.2.1. Initialize initial XP amount based on killer's level.
// 3.2.2. Reward killer (see 4. for more details).
// 4. Reward player.
// 4.1. Give honor (player must be alive and not on BG).
// 4.2. Give XP.
// 4.2.1. If player is in group, adjust XP:
//        * set to 0 if player's level is more than maximum level of not gray member;
//        * cut XP in half if _isFullXP is false.
// 4.2.2. Apply auras modifying rewarded XP.
// 4.2.3. Give XP to player.
// 4.2.4. If player has pet, reward pet with XP (100% for single player, 50% for group case).
// 4.3. Give reputation (player must not be on BG).
// 4.4. Give kill credit (player must not be in group, or he must be alive or without corpse).
// 5. Credit instance encounter.
KillRewarder::KillRewarder(Player* killer, Unit* victim, bool isBattleGround) :
// 1. Initialize internal variables to default values.
        _killer(killer), _victim(victim), _group(killer->GetGroup()),
        _groupRate(1.0f), _maxNotGrayMember(nullptr), _count(0), _aliveSumLevel(0), _sumLevel(0), _xp(0),
        _isFullXP(false), _maxLevel(0), _isBattleGround(isBattleGround), _isPvP(false)
{
    // mark the credit as pvp if victim is player
    if (victim->GetTypeId() == TYPEID_PLAYER)
        _isPvP = true;
        // or if its owned by player and its not a vehicle
    else if (victim->GetCharmerOrOwnerGUID().IsPlayer())
        _isPvP = !victim->IsVehicle();

    _InitGroupData();
}

void KillRewarder::_InitGroupData()
{
    if (_group)
    {
        // 2. In case when player is in group, initialize variables necessary for group calculations:
        for (GroupReference* itr = _group->GetFirstMember(); itr != nullptr; itr = itr->next())
            if (Player* member = itr->GetSource())
                if ((_killer == member || member->IsAtGroupRewardDistance(_victim)))
                {
                    const uint8 lvl = member->GetLevel();
                    if (member->IsAlive())
                    {
                        // 2.1. _count - number of alive group members within reward distance;
                        ++_count;
                        // 2.2. _aliveSumLevel - sum of levels of alive group members within reward distance;
                        _aliveSumLevel += lvl;
                        // 2.3. _maxLevel - maximum level of alive group member within reward distance;
                        if (_maxLevel < lvl)
                        {
                            _maxLevel = lvl;
                        }
                        // 2.4. _maxNotGrayMember - maximum level of alive group member within reward distance,
                        //      for whom victim is not gray;
                        uint32 grayLevel = Acore::XP::GetGrayLevel(lvl);
                        if (_victim->GetLevel() > grayLevel && (!_maxNotGrayMember || _maxNotGrayMember->GetLevel() < lvl))
                        {
                            _maxNotGrayMember = member;
                        }
                    }
                    // 2.5. _sumLevel - sum of levels of group members within reward distance;
                    _sumLevel += lvl;
                }
        // 2.6. _isFullXP - flag identifying that for all group members victim is not gray,
        //      so 100% XP will be rewarded (50% otherwise).
        _isFullXP = _maxNotGrayMember && (_maxLevel == _maxNotGrayMember->GetLevel());
    }
    else
        _count = 1;
}

void KillRewarder::_InitXP(Player* player)
{
    // Get initial value of XP for kill.
    // XP is given:
    // * on battlegrounds;
    // * otherwise, not in PvP;
    // * not if killer is on vehicle.
    if (_victim && (_isBattleGround || (!_isPvP && !_killer->GetVehicle())))
        _xp = Acore::XP::Gain(player, _victim, _isBattleGround);

    if (_xp && !_isBattleGround && _victim) // pussywizard: npcs with relatively low hp give lower exp
        if (_victim->GetTypeId() == TYPEID_UNIT)
            if (const CreatureTemplate* ct = _victim->ToCreature()->GetCreatureTemplate())
                if (ct->ModHealth <= 0.75f && ct->ModHealth >= 0.0f)
                    _xp = uint32(_xp * ct->ModHealth);
}

void KillRewarder::_RewardHonor(Player* player)
{
    // Rewarded player must be alive.
    if (player->IsAlive())
        player->RewardHonor(_victim, _count, -1);
}

void KillRewarder::_RewardXP(Player* player, float rate)
{
    uint32 xp(_xp);
    if (_group)
    {
        // 4.2.1. If player is in group, adjust XP:
        //        * set to 0 if player's level is more than maximum level of not gray member;
        //        * cut XP in half if _isFullXP is false.
        if (_maxNotGrayMember && player->IsAlive() &&
            _maxNotGrayMember->GetLevel() >= player->GetLevel())
            xp = _isFullXP ?
                 uint32(xp * rate) :             // Reward FULL XP if all group members are not gray.
                 uint32(xp * rate / 2) + 1;      // Reward only HALF of XP if some of group members are gray.
        else
            xp = 0;
    }
    if (xp)
    {
        // 4.2.2. Apply auras modifying rewarded XP (SPELL_AURA_MOD_XP_PCT).
        Unit::AuraEffectList const& auras = player->GetAuraEffectsByType(SPELL_AURA_MOD_XP_PCT);
        for (Unit::AuraEffectList::const_iterator i = auras.begin(); i != auras.end(); ++i)
            AddPct(xp, (*i)->GetAmount());

        // 4.2.3. Give XP to player.
        sScriptMgr->OnGivePlayerXP(player, xp, _victim, PlayerXPSource::XPSOURCE_KILL);
        player->GiveXP(xp, _victim, _groupRate);
        if (Pet* pet = player->GetPet())
            // 4.2.4. If player has pet, reward pet with XP (100% for single player, 50% for group case).
            pet->GivePetXP(_group ? xp / 2 : xp);
    }
}

void KillRewarder::_RewardReputation(Player* player)
{
    // 4.3. Give reputation (player must not be on BG).
    // Even dead players and corpses are rewarded.
    player->RewardReputation(_victim);
}

void KillRewarder::_RewardKillCredit(Player* player)
{
    // 4.4. Give kill credit (player must not be in group, or he must be alive or without corpse).
    if (!_group || player->IsAlive() || !player->GetCorpse())
        if (Creature* target = _victim->ToCreature())
        {
            player->KilledMonster(target->GetCreatureTemplate(), target->GetGUID());
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE_TYPE, target->GetCreatureType(), 1, target);
        }
}

void KillRewarder::_RewardPlayer(Player* player, bool isDungeon)
{
    // 4. Reward player.
    if (!_isBattleGround)
    {
        // 4.1. Give honor (player must be alive and not on BG).
        _RewardHonor(player);
        // 4.1.1 Send player killcredit for quests with PlayerSlain
        if (_victim->GetTypeId() == TYPEID_PLAYER)
            player->KilledPlayerCredit();
    }

    // Give XP only in PvE or in battlegrounds.
    // Give reputation and kill credit only in PvE.
    if (!_isPvP || _isBattleGround)
    {
        float xpRate = _group ? _groupRate * float(player->GetLevel()) / _aliveSumLevel : /*Personal rate is 100%.*/ 1.0f; // Group rate depends on the sum of levels.
        sScriptMgr->OnRewardKillRewarder(player, this, isDungeon, xpRate);                                              // Personal rate is 100%.

        if (_xp)
        {
            // 4.2. Give XP.
            _RewardXP(player, xpRate);
        }
        if (!_isBattleGround)
        {
            // If killer is in dungeon then all members receive full reputation at kill.
            _RewardReputation(player);
            _RewardKillCredit(player);
        }
    }
}

void KillRewarder::_RewardGroup()
{
    if (_maxLevel)
    {
        if (_maxNotGrayMember)
            // 3.1.1. Initialize initial XP amount based on maximum level of group member,
            //        for whom victim is not gray.
            _InitXP(_maxNotGrayMember);
        // To avoid unnecessary calculations and calls,
        // proceed only if XP is not ZERO or player is not on battleground
        // (battleground rewards only XP, that's why).
        if (!_isBattleGround || _xp)
        {
            const bool isDungeon = !_isPvP && sMapStore.LookupEntry(_killer->GetMapId())->IsDungeon();
            if (!_isBattleGround)
            {
                // 3.1.2. Alter group rate if group is in raid (not for battlegrounds).
                const bool isRaid = !_isPvP && sMapStore.LookupEntry(_killer->GetMapId())->IsRaid() && _group->isRaidGroup();
                _groupRate = Acore::XP::xp_in_group_rate(_count, isRaid);
            }

            // 3.1.3. Reward each group member (even dead or corpse) within reward distance.
            for (GroupReference* itr = _group->GetFirstMember(); itr != nullptr; itr = itr->next())
            {
                if (Player* member = itr->GetSource())
                {
                    if (_killer == member || member->IsAtGroupRewardDistance(_victim))
                    {
                        _RewardPlayer(member, isDungeon);
                        // Xinef: only count players
                        //if (_victim->GetTypeId() == TYPEID_PLAYER)
                        //    member->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_SPECIAL_PVP_KILL, 1, 0, _victim);
                    }
                }
            }
        }
    }
}

void KillRewarder::Reward()
{
    // 3. Reward killer (and group, if necessary).
    if (_group)
        // 3.1. If killer is in group, reward group.
        _RewardGroup();
    else
    {
        // 3.2. Reward single killer (not group case).
        // 3.2.1. Initialize initial XP amount based on killer's level.
        _InitXP(_killer);
        // To avoid unnecessary calculations and calls,
        // proceed only if XP is not ZERO or player is not on battleground
        // (battleground rewards only XP, that's why).
        if (!_isBattleGround || _xp)
            // 3.2.2. Reward killer.
            if (_killer->IsInMap(_victim)) // pussywizard: killer may be on other map (crashfix), when killing in a group same map is required, so its not a problem
                _RewardPlayer(_killer, false);
    }

    // 5. Credit instance encounter.
    if (Creature* victim = _victim->ToCreature())
        if (victim->IsDungeonBoss())
            if (Map* map = _victim->FindMap())
                map->UpdateEncounterState(ENCOUNTER_CREDIT_KILL_CREATURE, _victim->GetEntry(), _victim);
}

Unit* KillRewarder::GetVictim()
{
    return _victim;
}

Player* KillRewarder::GetKiller()
{
    return _killer;
}
