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

#include "SpellMgr.h"
#include "BattlefieldMgr.h"
#include "BattlegroundIC.h"
#include "BattlegroundMgr.h"
#include "Chat.h"
#include "DBCStores.h"
#include "GameGraveyard.h"
#include "InstanceScript.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "Spell.h"
#include "SpellAuraDefines.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "World.h"

bool IsPrimaryProfessionSkill(uint32 skill)
{
    SkillLineEntry const* pSkill = sSkillLineStore.LookupEntry(skill);
    if (!pSkill)
        return false;

    if (pSkill->categoryId != SKILL_CATEGORY_PROFESSION)
        return false;

    return true;
}

bool IsPartOfSkillLine(uint32 skillId, uint32 spellId)
{
    SkillLineAbilityMapBounds skillBounds = sSpellMgr->GetSkillLineAbilityMapBounds(spellId);
    for (SkillLineAbilityMap::const_iterator itr = skillBounds.first; itr != skillBounds.second; ++itr)
        if (itr->second->SkillLine == skillId)
            return true;

    return false;
}

DiminishingGroup GetDiminishingReturnsGroupForSpell(SpellInfo const* spellproto, bool triggered)
{
    if (spellproto->IsPositive())
        return DIMINISHING_NONE;

    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (spellproto->Effects[i].ApplyAuraName == SPELL_AURA_MOD_TAUNT)
            return DIMINISHING_TAUNT;
    }

    // Explicit Diminishing Groups
    switch (spellproto->SpellFamilyName)
    {
        case SPELLFAMILY_GENERIC:
            {
                // Pet charge effects (Infernal Awakening, Demon Charge)
                if (spellproto->SpellVisual[0] == 2816 && spellproto->SpellIconID == 15)
                    return DIMINISHING_CONTROLLED_STUN;
                // Gnaw
                else if (spellproto->Id == 47481)
                    return DIMINISHING_CONTROLLED_STUN;
                // Screams of the Past
                else if (spellproto->Id == 7074)
                    return DIMINISHING_NONE;
                break;
            }
        // Event spells
        case SPELLFAMILY_UNK1:
            return DIMINISHING_NONE;
        case SPELLFAMILY_MAGE:
            {
                // Frostbite
                if (spellproto->Id == 12494)
                    return DIMINISHING_ROOT;
                // Shattered Barrier
                else if (spellproto->Id == 55080)
                    return DIMINISHING_ROOT;
                // Deep Freeze
                else if (spellproto->SpellIconID == 2939 && spellproto->SpellVisual[0] == 9963)
                    return DIMINISHING_CONTROLLED_STUN;
                // Frost Nova / Freeze (Water Elemental)
                else if (spellproto->SpellIconID == 193)
                    return DIMINISHING_CONTROLLED_ROOT;
                // Dragon's Breath
                else if (spellproto->SpellFamilyFlags[0] & 0x800000)
                    return DIMINISHING_DRAGONS_BREATH;
                break;
            }
        case SPELLFAMILY_WARRIOR:
            {
                // Hamstring - limit duration to 10s in PvP
                if (spellproto->SpellFamilyFlags[0] & 0x2)
                    return DIMINISHING_LIMITONLY;
                // Improved Hamstring
                else if (spellproto->Id == 23694)
                    return DIMINISHING_ROOT;
                // Charge Stun (own diminishing)
                else if (spellproto->SpellFamilyFlags[0] & 0x01000000)
                    return DIMINISHING_CHARGE;
                break;
            }
        case SPELLFAMILY_WARLOCK:
            {
                // Curses/etc
                if ((spellproto->SpellFamilyFlags[0] & 0x80000000) || (spellproto->SpellFamilyFlags[1] & 0x200))
                    return DIMINISHING_LIMITONLY;
                // Seduction
                else if (spellproto->SpellFamilyFlags[1] & 0x10000000)
                    return DIMINISHING_FEAR;
                break;
            }
        case SPELLFAMILY_DRUID:
            {
                // Pounce
                if (spellproto->SpellFamilyFlags[0] & 0x20000)
                    return DIMINISHING_OPENING_STUN;
                // Cyclone
                else if (spellproto->SpellFamilyFlags[1] & 0x20)
                    return DIMINISHING_CYCLONE;
                // Entangling Roots
                // Nature's Grasp
                else if (spellproto->SpellFamilyFlags[0] & 0x00000200)
                    return DIMINISHING_CONTROLLED_ROOT;
                // Faerie Fire
                else if (spellproto->SpellFamilyFlags[0] & 0x400)
                    return DIMINISHING_LIMITONLY;
                // Feral Charge Root Effect
                else if (spellproto->Id == 45334)
                    return DIMINISHING_NONE;
                break;
            }
        case SPELLFAMILY_ROGUE:
            {
                // Gouge
                if (spellproto->SpellFamilyFlags[0] & 0x8)
                    return DIMINISHING_DISORIENT;
                // Blind
                else if (spellproto->SpellFamilyFlags[0] & 0x1000000)
                    return DIMINISHING_FEAR;
                // Cheap Shot
                else if (spellproto->SpellFamilyFlags[0] & 0x400)
                    return DIMINISHING_OPENING_STUN;
                // Crippling poison - Limit to 10 seconds in PvP (No SpellFamilyFlags)
                else if (spellproto->SpellIconID == 163)
                    return DIMINISHING_LIMITONLY;
                break;
            }
        case SPELLFAMILY_HUNTER:
            {
                // Hunter's Mark
                if ((spellproto->SpellFamilyFlags[0] & 0x400) && spellproto->SpellIconID == 538)
                    return DIMINISHING_LIMITONLY;
                // Scatter Shot (own diminishing)
                else if ((spellproto->SpellFamilyFlags[0] & 0x40000) && spellproto->SpellIconID == 132)
                    return DIMINISHING_SCATTER_SHOT;
                // Entrapment (own diminishing)
                else if (spellproto->SpellVisual[0] == 7484 && spellproto->SpellIconID == 20)
                    return DIMINISHING_ENTRAPMENT;
                // Wyvern Sting mechanic is MECHANIC_SLEEP but the diminishing is DIMINISHING_DISORIENT
                else if ((spellproto->SpellFamilyFlags[1] & 0x1000) && spellproto->SpellIconID == 1721)
                    return DIMINISHING_DISORIENT;
                // Freezing Arrow
                else if (spellproto->SpellFamilyFlags[0] & 0x8)
                    return DIMINISHING_DISORIENT;
                break;
            }
        case SPELLFAMILY_PALADIN:
            {
                // Judgement of Justice - limit duration to 10s in PvP
                if (spellproto->SpellFamilyFlags[0] & 0x100000)
                    return DIMINISHING_LIMITONLY;
                // Turn Evil
                else if ((spellproto->SpellFamilyFlags[1] & 0x804000) && spellproto->SpellIconID == 309)
                    return DIMINISHING_FEAR;
                break;
            }
        case SPELLFAMILY_SHAMAN:
            {
                // Storm, Earth and Fire - Earthgrab
                if (spellproto->SpellFamilyFlags[2] & 0x4000)
                    return DIMINISHING_NONE;
                break;
            }
        case SPELLFAMILY_DEATHKNIGHT:
            {
                // Hungering Cold (no flags)
                if (spellproto->SpellIconID == 2797)
                    return DIMINISHING_DISORIENT;
                // Mark of Blood
                else if ((spellproto->SpellFamilyFlags[0] & 0x10000000) && spellproto->SpellIconID == 2285)
                    return DIMINISHING_LIMITONLY;
                break;
            }
        default:
            break;
    }

    // Lastly - Set diminishing depending on mechanic
    uint32 mechanic = spellproto->GetAllEffectsMechanicMask();
    if (mechanic & (1 << MECHANIC_CHARM))
        return DIMINISHING_MIND_CONTROL;
    if (mechanic & (1 << MECHANIC_SILENCE))
        return DIMINISHING_SILENCE;
    if (mechanic & (1 << MECHANIC_SLEEP))
        return DIMINISHING_SLEEP;
    if (mechanic & ((1 << MECHANIC_SAPPED) | (1 << MECHANIC_POLYMORPH) | (1 << MECHANIC_SHACKLE)))
        return DIMINISHING_DISORIENT;
    // Mechanic Knockout, except Blast Wave
    if (mechanic & (1 << MECHANIC_KNOCKOUT) && spellproto->SpellIconID != 292)
        return DIMINISHING_DISORIENT;
    if (mechanic & (1 << MECHANIC_DISARM))
        return DIMINISHING_DISARM;
    if (mechanic & (1 << MECHANIC_FEAR))
        return DIMINISHING_FEAR;
    if (mechanic & (1 << MECHANIC_STUN))
        return triggered ? DIMINISHING_STUN : DIMINISHING_CONTROLLED_STUN;
    if (mechanic & (1 << MECHANIC_BANISH))
        return DIMINISHING_BANISH;
    if (mechanic & (1 << MECHANIC_ROOT))
        return triggered ? DIMINISHING_ROOT : DIMINISHING_CONTROLLED_ROOT;
    if (mechanic & (1 << MECHANIC_HORROR))
        return DIMINISHING_HORROR;

    return DIMINISHING_NONE;
}

DiminishingReturnsType GetDiminishingReturnsGroupType(DiminishingGroup group)
{
    switch (group)
    {
        case DIMINISHING_TAUNT:
        case DIMINISHING_CONTROLLED_STUN:
        case DIMINISHING_STUN:
        case DIMINISHING_OPENING_STUN:
        case DIMINISHING_CYCLONE:
        case DIMINISHING_CHARGE:
            return DRTYPE_ALL;
        case DIMINISHING_LIMITONLY:
        case DIMINISHING_NONE:
            return DRTYPE_NONE;
        default:
            return DRTYPE_PLAYER;
    }
}

DiminishingLevels GetDiminishingReturnsMaxLevel(DiminishingGroup group)
{
    switch (group)
    {
        case DIMINISHING_TAUNT:
            return DIMINISHING_LEVEL_TAUNT_IMMUNE;
        default:
            return DIMINISHING_LEVEL_IMMUNE;
    }
}

int32 GetDiminishingReturnsLimitDuration(DiminishingGroup group, SpellInfo const* spellproto)
{
    if (!IsDiminishingReturnsGroupDurationLimited(group))
        return 0;

    // Explicit diminishing duration
    switch (spellproto->SpellFamilyName)
    {
        case SPELLFAMILY_DRUID:
            {
                // Faerie Fire - limit to 40 seconds in PvP (3.1)
                if (spellproto->SpellFamilyFlags[0] & 0x400)
                    return 40 * IN_MILLISECONDS;
                break;
            }
        case SPELLFAMILY_HUNTER:
            {
                // Wyvern Sting
                if (spellproto->SpellFamilyFlags[1] & 0x1000)
                    return 6 * IN_MILLISECONDS;
                // Hunter's Mark
                if (spellproto->SpellFamilyFlags[0] & 0x400)
                    return 120 * IN_MILLISECONDS;
                break;
            }
        case SPELLFAMILY_PALADIN:
            {
                // Repentance - limit to 6 seconds in PvP
                if (spellproto->SpellFamilyFlags[0] & 0x4)
                    return 6 * IN_MILLISECONDS;
                break;
            }
        case SPELLFAMILY_WARLOCK:
            {
                // Banish - limit to 6 seconds in PvP
                if (spellproto->SpellFamilyFlags[1] & 0x8000000)
                    return 6 * IN_MILLISECONDS;
                // Curse of Tongues - limit to 12 seconds in PvP
                else if (spellproto->SpellFamilyFlags[2] & 0x800)
                    return 12 * IN_MILLISECONDS;
                // Curse of Elements - limit to 120 seconds in PvP
                else if (spellproto->SpellFamilyFlags[1] & 0x200)
                    return 120 * IN_MILLISECONDS;
                // Curse of Exhaustion
                else if (spellproto->SpellFamilyFlags[0] & 0x400000)
                    return 12 * IN_MILLISECONDS;
                break;
            }
        default:
            break;
    }

    return 10 * IN_MILLISECONDS;
}

bool IsDiminishingReturnsGroupDurationLimited(DiminishingGroup group)
{
    switch (group)
    {
        case DIMINISHING_BANISH:
        case DIMINISHING_CONTROLLED_STUN:
        case DIMINISHING_CONTROLLED_ROOT:
        case DIMINISHING_CYCLONE:
        case DIMINISHING_DISORIENT:
        case DIMINISHING_ENTRAPMENT:
        case DIMINISHING_FEAR:
        case DIMINISHING_HORROR:
        case DIMINISHING_MIND_CONTROL:
        case DIMINISHING_OPENING_STUN:
        case DIMINISHING_ROOT:
        case DIMINISHING_STUN:
        case DIMINISHING_SLEEP:
        case DIMINISHING_LIMITONLY:
            return true;
        default:
            return false;
    }
}

SpellMgr::SpellMgr()
{
}

SpellMgr::~SpellMgr()
{
    UnloadSpellInfoStore();
}

SpellMgr* SpellMgr::instance()
{
    static SpellMgr instance;
    return &instance;
}

/// Some checks for spells, to prevent adding deprecated/broken spells for trainers, spell book, etc
bool SpellMgr::ComputeIsSpellValid(SpellInfo const* spellInfo, bool msg)
{
    // not exist
    if (!spellInfo)
        return false;

    bool need_check_reagents = false;

    // check effects
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        switch (spellInfo->Effects[i].Effect)
        {
            case 0:
                continue;

            // craft spell for crafting non-existed item (break client recipes list show)
            case SPELL_EFFECT_CREATE_ITEM:
            case SPELL_EFFECT_CREATE_ITEM_2:
                {
                    if (spellInfo->Effects[i].ItemType == 0)
                    {
                        // skip auto-loot crafting spells, its not need explicit item info (but have special fake items sometime)
                        if (!spellInfo->IsLootCrafting())
                        {
                            if (msg)
                                LOG_ERROR("sql.sql", "Craft spell {} not have create item entry.", spellInfo->Id);
                            return false;
                        }
                    }
                    // also possible IsLootCrafting case but fake item must exist anyway
                    else if (!sObjectMgr->GetItemTemplate(spellInfo->Effects[i].ItemType))
                    {
                        if (msg)
                            LOG_ERROR("sql.sql", "Craft spell {} create not-exist in DB item (Entry: {}) and then...", spellInfo->Id, spellInfo->Effects[i].ItemType);
                        return false;
                    }

                    need_check_reagents = true;
                    break;
                }
            case SPELL_EFFECT_LEARN_SPELL:
                {
                    SpellInfo const* spellInfo2 = sSpellMgr->GetSpellInfo(spellInfo->Effects[i].TriggerSpell);
                    if (!ComputeIsSpellValid(spellInfo2, msg))
                    {
                        if (msg)
                            LOG_ERROR("sql.sql", "Spell {} learn to invalid spell {}, and then...", spellInfo->Id, spellInfo->Effects[i].TriggerSpell);
                        return false;
                    }
                    break;
                }
        }
    }

    if (need_check_reagents)
    {
        for (uint8 j = 0; j < MAX_SPELL_REAGENTS; ++j)
        {
            if (spellInfo->Reagent[j] > 0 && !sObjectMgr->GetItemTemplate(spellInfo->Reagent[j]))
            {
                if (msg)
                    LOG_ERROR("sql.sql", "Craft spell {} have not-exist reagent in DB item (Entry: {}) and then...", spellInfo->Id, spellInfo->Reagent[j]);
                return false;
            }
        }
    }

    return true;
}

bool SpellMgr::IsSpellValid(SpellInfo const* spellInfo)
{
    if (!spellInfo)
        return false;
    return spellInfo->IsSpellValid();
}

void DeleteSpellFromAllPlayers(uint32 spellId)
{
    CharacterDatabaseStatements stmts[2] = {CHAR_DEL_INVALID_SPELL_SPELLS, CHAR_DEL_INVALID_SPELL_TALENTS};
    for (uint8 i = 0; i < 2; i++)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(stmts[i]);
        stmt->SetData(0, spellId);
        CharacterDatabase.Execute(stmt);
    }
}

bool SpellMgr::CheckSpellValid(SpellInfo const* spellInfo, uint32 spellId, bool isTalent)
{
    if (!spellInfo)
    {
        DeleteSpellFromAllPlayers(spellId);
        LOG_ERROR("spells", "Player::{}: Non-existed in SpellStore spell #{} request.", (isTalent ? "AddTalent" : "addSpell"), spellId);
        return false;
    }

    if (!IsSpellValid(spellInfo))
    {
        DeleteSpellFromAllPlayers(spellId);
        LOG_ERROR("spells", "Player::{}: Broken spell #{} learning not allowed.", (isTalent ? "AddTalent" : "addSpell"), spellId);
        return false;
    }

    return true;
}

uint32 SpellMgr::GetSpellDifficultyId(uint32 spellId) const
{
    SpellDifficultySearcherMap::const_iterator i = mSpellDifficultySearcherMap.find(spellId);
    return i == mSpellDifficultySearcherMap.end() ? 0 : (*i).second;
}

void SpellMgr::SetSpellDifficultyId(uint32 spellId, uint32 id)
{
    mSpellDifficultySearcherMap[spellId] = id;
}

uint32 SpellMgr::GetSpellIdForDifficulty(uint32 spellId, Unit const* caster) const
{
    if (!GetSpellInfo(spellId))
        return spellId;

    if (!caster || !caster->GetMap() || !caster->GetMap()->IsDungeon())
        return spellId;

    uint32 mode = uint32(caster->GetMap()->GetSpawnMode());
    if (mode >= MAX_DIFFICULTY)
    {
        LOG_ERROR("spells", "SpellMgr::GetSpellIdForDifficulty: Incorrect Difficulty for spell {}.", spellId);
        return spellId; //return source spell
    }

    uint32 difficultyId = GetSpellDifficultyId(spellId);
    if (!difficultyId)
        return spellId; //return source spell, it has only REGULAR_DIFFICULTY

    SpellDifficultyEntry const* difficultyEntry = sSpellDifficultyStore.LookupEntry(difficultyId);
    if (!difficultyEntry)
    {
        LOG_DEBUG("spells.aura", "SpellMgr::GetSpellIdForDifficulty: SpellDifficultyEntry not found for spell {}. This should never happen.", spellId);
        return spellId; //return source spell
    }

    if (difficultyEntry->SpellID[mode] <= 0 && mode > DUNGEON_DIFFICULTY_HEROIC)
    {
        LOG_DEBUG("spells.aura", "SpellMgr::GetSpellIdForDifficulty: spell {} mode {} spell is nullptr, using mode {}", spellId, mode, mode - 2);
        mode -= 2;
    }

    if (difficultyEntry->SpellID[mode] <= 0)
    {
        LOG_ERROR("sql.sql", "SpellMgr::GetSpellIdForDifficulty: spell {} mode {} spell is 0. Check spelldifficulty_dbc!", spellId, mode);
        return spellId;
    }

    LOG_DEBUG("spells.aura", "SpellMgr::GetSpellIdForDifficulty: spellid for spell {} in mode {} is {}", spellId, mode, difficultyEntry->SpellID[mode]);
    return uint32(difficultyEntry->SpellID[mode]);
}

SpellInfo const* SpellMgr::GetSpellForDifficultyFromSpell(SpellInfo const* spell, Unit const* caster) const
{
    uint32 newSpellId = GetSpellIdForDifficulty(spell->Id, caster);
    SpellInfo const* newSpell = GetSpellInfo(newSpellId);
    if (!newSpell)
    {
        LOG_DEBUG("spells.aura", "SpellMgr::GetSpellForDifficultyFromSpell: spell {} not found. Check spelldifficulty_dbc!", newSpellId);
        return spell;
    }

    LOG_DEBUG("spells.aura", "SpellMgr::GetSpellForDifficultyFromSpell: Spell id for instance mode is {} (original {})", newSpell->Id, spell->Id);
    return newSpell;
}

SpellChainNode const* SpellMgr::GetSpellChainNode(uint32 spell_id) const
{
    SpellChainMap::const_iterator itr = mSpellChains.find(spell_id);
    if (itr == mSpellChains.end())
        return nullptr;

    return &itr->second;
}

uint32 SpellMgr::GetFirstSpellInChain(uint32 spell_id) const
{
    if (SpellChainNode const* node = GetSpellChainNode(spell_id))
        return node->first->Id;

    return spell_id;
}

uint32 SpellMgr::GetLastSpellInChain(uint32 spell_id) const
{
    if (SpellChainNode const* node = GetSpellChainNode(spell_id))
        return node->last->Id;

    return spell_id;
}

uint32 SpellMgr::GetNextSpellInChain(uint32 spell_id) const
{
    if (SpellChainNode const* node = GetSpellChainNode(spell_id))
        if (node->next)
            return node->next->Id;

    return 0;
}

uint32 SpellMgr::GetPrevSpellInChain(uint32 spell_id) const
{
    if (SpellChainNode const* node = GetSpellChainNode(spell_id))
        if (node->prev)
            return node->prev->Id;

    return 0;
}

uint8 SpellMgr::GetSpellRank(uint32 spell_id) const
{
    if (SpellChainNode const* node = GetSpellChainNode(spell_id))
        return node->rank;

    return 0;
}

uint32 SpellMgr::GetSpellWithRank(uint32 spell_id, uint32 rank, bool strict) const
{
    if (SpellChainNode const* node = GetSpellChainNode(spell_id))
    {
        if (rank != node->rank)
            return GetSpellWithRank(node->rank < rank ? node->next->Id : node->prev->Id, rank, strict);
    }
    else if (strict && rank > 1)
        return 0;
    return spell_id;
}

SpellRequiredMapBounds SpellMgr::GetSpellsRequiredForSpellBounds(uint32 spell_id) const
{
    return mSpellReq.equal_range(spell_id);
}

SpellsRequiringSpellMapBounds SpellMgr::GetSpellsRequiringSpellBounds(uint32 spell_id) const
{
    return mSpellsReqSpell.equal_range(spell_id);
}

bool SpellMgr::IsSpellRequiringSpell(uint32 spellid, uint32 req_spellid) const
{
    SpellsRequiringSpellMapBounds spellsRequiringSpell = GetSpellsRequiringSpellBounds(req_spellid);
    for (SpellsRequiringSpellMap::const_iterator itr = spellsRequiringSpell.first; itr != spellsRequiringSpell.second; ++itr)
    {
        if (itr->second == spellid)
            return true;
    }
    return false;
}

bool SpellMgr::IsAdditionalTalentSpell(uint32 spellId) const
{
    return mTalentSpellAdditionalSet.find(spellId) != mTalentSpellAdditionalSet.end();
}

SpellLearnSkillNode const* SpellMgr::GetSpellLearnSkill(uint32 spell_id) const
{
    SpellLearnSkillMap::const_iterator itr = mSpellLearnSkills.find(spell_id);
    if (itr != mSpellLearnSkills.end())
        return &itr->second;
    else
        return nullptr;
}

SpellTargetPosition const* SpellMgr::GetSpellTargetPosition(uint32 spell_id, SpellEffIndex effIndex) const
{
    SpellTargetPositionMap::const_iterator itr = mSpellTargetPositions.find(std::make_pair(spell_id, effIndex));
    if (itr != mSpellTargetPositions.end())
        return &itr->second;
    return nullptr;
}

SpellGroupStackFlags SpellMgr::GetGroupStackFlags(uint32 groupid) const
{
    SpellGroupStackMap::const_iterator itr = mSpellGroupStackMap.find(groupid);
    if (itr != mSpellGroupStackMap.end())
        return itr->second;

    return SPELL_GROUP_STACK_FLAG_NONE;
}

uint32 SpellMgr::GetSpellGroup(uint32 spell_id) const
{
    uint32 first_rank = GetFirstSpellInChain(spell_id);
    SpellGroupMap::const_iterator itr = mSpellGroupMap.find(first_rank);
    if (itr != mSpellGroupMap.end())
        return itr->second.groupId;

    return 0;
}

SpellGroupSpecialFlags SpellMgr::GetSpellGroupSpecialFlags(uint32 spell_id) const
{
    uint32 first_rank = GetFirstSpellInChain(spell_id);
    SpellGroupMap::const_iterator itr = mSpellGroupMap.find(first_rank);
    if (itr != mSpellGroupMap.end())
        return itr->second.specialFlags;

    return SPELL_GROUP_SPECIAL_FLAG_NONE;
}

SpellGroupStackFlags SpellMgr::CheckSpellGroupStackRules(SpellInfo const* spellInfo1, SpellInfo const* spellInfo2, bool remove, bool areaAura) const
{
    uint32 spellid_1 = spellInfo1->GetFirstRankSpell()->Id;
    uint32 spellid_2 = spellInfo2->GetFirstRankSpell()->Id;

    uint32 groupId = GetSpellGroup(spellid_1);

    SpellGroupSpecialFlags flag1 = GetSpellGroupSpecialFlags(spellid_1);

    // xinef: dunno why i added this
    if (spellid_1 == spellid_2 && remove && !areaAura)
    {
        if (flag1 & SPELL_GROUP_SPECIAL_FLAG_SAME_SPELL_CHECK)
        {
            return SPELL_GROUP_STACK_FLAG_EXCLUSIVE;
        }

        return SPELL_GROUP_STACK_FLAG_NONE;
    }

    if (groupId > 0 && groupId == GetSpellGroup(spellid_2))
    {
        SpellGroupSpecialFlags flag2 = GetSpellGroupSpecialFlags(spellid_2);
        SpellGroupStackFlags additionFlag = SPELL_GROUP_STACK_FLAG_NONE;
        // xinef: first flags are used for elixir stacking rules
        if (flag1 & SPELL_GROUP_SPECIAL_FLAG_STACK_EXCLUSIVE_MAX && flag2 & SPELL_GROUP_SPECIAL_FLAG_STACK_EXCLUSIVE_MAX)
        {
            if (flag1 & flag2)
                return SPELL_GROUP_STACK_FLAG_NEVER_STACK;
        }
        // xinef: check only flag1 (new spell)
        else if (flag1 & SPELL_GROUP_SPECIAL_FLAG_FORCED_STRONGEST)
            additionFlag = SPELL_GROUP_STACK_FLAG_FORCED_STRONGEST;
        else if (flag2 & SPELL_GROUP_SPECIAL_FLAG_FORCED_STRONGEST)
            additionFlag = SPELL_GROUP_STACK_FLAG_FORCED_WEAKEST;

        return SpellGroupStackFlags(GetGroupStackFlags(groupId) | additionFlag);
    }

    return SPELL_GROUP_STACK_FLAG_NONE;
}

void SpellMgr::GetSetOfSpellsInSpellGroupWithFlag(uint32 group_id, SpellGroupSpecialFlags flag, std::set<uint32>& availableElixirs) const
{
    for (SpellGroupMap::const_iterator itr = mSpellGroupMap.begin(); itr != mSpellGroupMap.end(); ++itr)
        if (itr->second.groupId == group_id && itr->second.specialFlags == flag)
            availableElixirs.insert(itr->first); // insert spell id
}

SpellProcEventEntry const* SpellMgr::GetSpellProcEvent(uint32 spellId) const
{
    SpellProcEventMap::const_iterator itr = mSpellProcEventMap.find(spellId);
    if (itr != mSpellProcEventMap.end())
        return &itr->second;
    return nullptr;
}

bool SpellMgr::IsSpellProcEventCanTriggeredBy(SpellInfo const* spellProto, SpellProcEventEntry const* spellProcEvent, uint32 EventProcFlag, ProcEventInfo const& eventInfo, bool active) const
{
    // No extra req need
    uint32 procEvent_procEx = PROC_EX_NONE;
    uint32 procEvent_procPhase = PROC_SPELL_PHASE_HIT;

    uint32 procFlags = eventInfo.GetTypeMask();
    uint32 procExtra = eventInfo.GetHitMask();
    uint32 procPhase = eventInfo.GetSpellPhaseMask();
    SpellInfo const* procSpellInfo = eventInfo.GetSpellInfo();

    // check prockFlags for condition
    if ((procFlags & EventProcFlag) == 0)
        return false;

    // Xinef: Always trigger for this, including TAKEN_DAMAGE
    if (EventProcFlag & (PROC_FLAG_KILLED | PROC_FLAG_KILL | PROC_FLAG_DEATH | PROC_FLAG_TAKEN_DAMAGE))
        return true;

    bool hasFamilyMask = false;

    if (procFlags & PROC_FLAG_DONE_PERIODIC)
    {
        if (procExtra & PROC_EX_INTERNAL_HOT)
        {
            if (EventProcFlag == PROC_FLAG_DONE_PERIODIC)
            {
                /// no aura with only PROC_FLAG_DONE_PERIODIC and spellFamilyName == 0 can proc from a HOT.
                if (!spellProto->SpellFamilyName)
                    return false;
            }
            /// Aura must have positive procflags for a HOT to proc
            else if (!(EventProcFlag & (PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS | PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_POS)))
                return false;
        }
        /// Aura must have negative or neutral(PROC_FLAG_DONE_PERIODIC only) procflags for a DOT to proc
        else if (EventProcFlag != PROC_FLAG_DONE_PERIODIC)
            if (!(EventProcFlag & (PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG | PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_NEG | PROC_FLAG_DONE_TRAP_ACTIVATION)))
                return false;
    }

    if (procFlags & PROC_FLAG_TAKEN_PERIODIC)
    {
        if (procExtra & PROC_EX_INTERNAL_HOT)
        {
            /// No aura that only has PROC_FLAG_TAKEN_PERIODIC can proc from a HOT.
            if (EventProcFlag == PROC_FLAG_TAKEN_PERIODIC)
                return false;
            /// Aura must have positive procflags for a HOT to proc
            if (!(EventProcFlag & (PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_POS | PROC_FLAG_TAKEN_SPELL_NONE_DMG_CLASS_POS)))
                return false;
        }
        /// Aura must have negative or neutral(PROC_FLAG_TAKEN_PERIODIC only) procflags for a DOT to proc
        else if (EventProcFlag != PROC_FLAG_TAKEN_PERIODIC)
            if (!(EventProcFlag & (PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG | PROC_FLAG_TAKEN_SPELL_NONE_DMG_CLASS_NEG)))
                return false;
    }

    // Trap casts are active by default
    if (procFlags & PROC_FLAG_DONE_TRAP_ACTIVATION)
        active = true;

    if (spellProcEvent)     // Exist event data
    {
        // Store extra req
        procEvent_procEx = spellProcEvent->procEx;
        procEvent_procPhase = spellProcEvent->procPhase;

        // For melee triggers
        if (!procSpellInfo)
        {
            // Check (if set) for school (melee attack have Normal school)
            if (spellProcEvent->schoolMask && (spellProcEvent->schoolMask & SPELL_SCHOOL_MASK_NORMAL) == 0)
                return false;
        }
        else // For spells need check school/spell family/family mask
        {
            // Check (if set) for school
            if (spellProcEvent->schoolMask && (spellProcEvent->schoolMask & procSpellInfo->SchoolMask) == 0)
                return false;

            // Check (if set) for spellFamilyName
            if (spellProcEvent->spellFamilyName && (spellProcEvent->spellFamilyName != procSpellInfo->SpellFamilyName))
                return false;

            // spellFamilyName is Ok need check for spellFamilyMask if present
            if (spellProcEvent->spellFamilyMask)
            {
                if (!(spellProcEvent->spellFamilyMask & procSpellInfo->SpellFamilyFlags))
                    return false;
                hasFamilyMask = true;
                // Some spells are not considered as active even with have spellfamilyflags
                if (!(procEvent_procEx & PROC_EX_ONLY_ACTIVE_SPELL))
                    active = true;
            }

            // Check tick numbers
            if (procEvent_procEx & PROC_EX_ONLY_FIRST_TICK)
            {
                if (Spell const* procSpell = eventInfo.GetProcSpell())
                {
                    if (procSpell->GetTriggeredByAuraTickNumber() > 1)
                    {
                        return false;
                    }
                }
            }
        }
    }

    if (procExtra & (PROC_EX_INTERNAL_REQ_FAMILY))
    {
        if (!hasFamilyMask)
            return false;
    }

    if (!(procEvent_procPhase & procPhase))
    {
        return false;
    }

    // Check for extra req (if none) and hit/crit
    if (procEvent_procEx == PROC_EX_NONE)
    {
        // No extra req, so can trigger only for hit/crit - spell has to be active
        if ((procExtra & (PROC_EX_NORMAL_HIT | PROC_EX_CRITICAL_HIT)) && active)
            return true;
    }
    else // Passive spells hits here only if resist/reflect/immune/evade
    {
        if (procExtra & AURA_SPELL_PROC_EX_MASK)
        {
            // if spell marked as procing only from not active spells
            if (active && procEvent_procEx & PROC_EX_NOT_ACTIVE_SPELL)
                return false;
            // if spell marked as procing only from active spells
            if (!active && procEvent_procEx & PROC_EX_ONLY_ACTIVE_SPELL)
                return false;
            // Exist req for PROC_EX_EX_TRIGGER_ALWAYS
            if (procEvent_procEx & PROC_EX_EX_TRIGGER_ALWAYS)
                return true;
            // PROC_EX_NOT_ACTIVE_SPELL and PROC_EX_ONLY_ACTIVE_SPELL flags handle: if passed checks before
            if ((procExtra & (PROC_EX_NORMAL_HIT | PROC_EX_CRITICAL_HIT)) && ((procEvent_procEx & (AURA_SPELL_PROC_EX_MASK)) == 0))
                return true;
        }
        // Check Extra Requirement like (hit/crit/miss/resist/parry/dodge/block/immune/reflect/absorb and other)
        if (procEvent_procEx & procExtra)
            return true;
    }
    return false;
}

SpellProcEntry const* SpellMgr::GetSpellProcEntry(uint32 spellId) const
{
    SpellProcMap::const_iterator itr = mSpellProcMap.find(spellId);
    if (itr != mSpellProcMap.end())
        return &itr->second;
    return nullptr;
}

bool SpellMgr::CanSpellTriggerProcOnEvent(SpellProcEntry const& procEntry, ProcEventInfo& eventInfo) const
{
    // proc type doesn't match
    if (!(eventInfo.GetTypeMask() & procEntry.ProcFlags))
        return false;

    // check XP or honor target requirement
    if (procEntry.AttributesMask & PROC_ATTR_REQ_EXP_OR_HONOR)
        if (Player* actor = eventInfo.GetActor()->ToPlayer())
            if (eventInfo.GetActionTarget() && !actor->isHonorOrXPTarget(eventInfo.GetActionTarget()))
                return false;

    // always trigger for these types
    if (eventInfo.GetTypeMask() & (PROC_FLAG_KILLED | PROC_FLAG_KILL | PROC_FLAG_DEATH))
        return true;

    // check school mask (if set) for other trigger types
    if (procEntry.SchoolMask && !(eventInfo.GetSchoolMask() & procEntry.SchoolMask))
        return false;

    // check spell family name/flags (if set) for spells
    if (eventInfo.GetTypeMask() & (PERIODIC_PROC_FLAG_MASK | SPELL_PROC_FLAG_MASK | PROC_FLAG_DONE_TRAP_ACTIVATION))
    {
        if (procEntry.SpellFamilyName && (procEntry.SpellFamilyName != eventInfo.GetSpellInfo()->SpellFamilyName))
            return false;

        if (procEntry.SpellFamilyMask && !(procEntry.SpellFamilyMask & eventInfo.GetSpellInfo()->SpellFamilyFlags))
            return false;
    }

    // check spell type mask (if set)
    if (eventInfo.GetTypeMask() & (SPELL_PROC_FLAG_MASK | PERIODIC_PROC_FLAG_MASK))
    {
        if (procEntry.SpellTypeMask && !(eventInfo.GetSpellTypeMask() & procEntry.SpellTypeMask))
            return false;
    }

    // check spell phase mask
    if (eventInfo.GetTypeMask() & REQ_SPELL_PHASE_PROC_FLAG_MASK)
    {
        if (!(eventInfo.GetSpellPhaseMask() & procEntry.SpellPhaseMask))
            return false;
    }

    // check hit mask (on taken hit or on done hit, but not on spell cast phase)
    if ((eventInfo.GetTypeMask() & TAKEN_HIT_PROC_FLAG_MASK) || ((eventInfo.GetTypeMask() & DONE_HIT_PROC_FLAG_MASK) && !(eventInfo.GetSpellPhaseMask() & PROC_SPELL_PHASE_CAST)))
    {
        uint32 hitMask = procEntry.HitMask;
        // get default values if hit mask not set
        if (!hitMask)
        {
            // for taken procs allow normal + critical hits by default
            if (eventInfo.GetTypeMask() & TAKEN_HIT_PROC_FLAG_MASK)
                hitMask |= PROC_HIT_NORMAL | PROC_HIT_CRITICAL;
            // for done procs allow normal + critical + absorbs by default
            else
                hitMask |= PROC_HIT_NORMAL | PROC_HIT_CRITICAL | PROC_HIT_ABSORB;
        }
        if (!(eventInfo.GetHitMask() & hitMask))
            return false;
    }

    return true;
}

SpellBonusEntry const* SpellMgr::GetSpellBonusData(uint32 spellId) const
{
    // Lookup data
    SpellBonusMap::const_iterator itr = mSpellBonusMap.find(spellId);
    if (itr != mSpellBonusMap.end())
        return &itr->second;
    // Not found, try lookup for 1 spell rank if exist
    if (uint32 rank_1 = GetFirstSpellInChain(spellId))
    {
        SpellBonusMap::const_iterator itr2 = mSpellBonusMap.find(rank_1);
        if (itr2 != mSpellBonusMap.end())
            return &itr2->second;
    }
    return nullptr;
}

SpellThreatEntry const* SpellMgr::GetSpellThreatEntry(uint32 spellID) const
{
    SpellThreatMap::const_iterator itr = mSpellThreatMap.find(spellID);
    if (itr != mSpellThreatMap.end())
        return &itr->second;
    else
    {
        uint32 firstSpell = GetFirstSpellInChain(spellID);
        itr = mSpellThreatMap.find(firstSpell);
        if (itr != mSpellThreatMap.end())
            return &itr->second;
    }
    return nullptr;
}

float SpellMgr::GetSpellMixologyBonus(uint32 spellId) const
{
    SpellMixologyMap::const_iterator itr = mSpellMixologyMap.find(spellId);
    if (itr == mSpellMixologyMap.end())
        return 30.0f;

    return itr->second;
}

SkillLineAbilityMapBounds SpellMgr::GetSkillLineAbilityMapBounds(uint32 spell_id) const
{
    return mSkillLineAbilityMap.equal_range(spell_id);
}

PetAura const* SpellMgr::GetPetAura(uint32 spell_id, uint8 eff) const
{
    SpellPetAuraMap::const_iterator itr = mSpellPetAuraMap.find((spell_id << 8) + eff);
    if (itr != mSpellPetAuraMap.end())
        return &itr->second;
    else
        return nullptr;
}

SpellEnchantProcEntry const* SpellMgr::GetSpellEnchantProcEvent(uint32 enchId) const
{
    SpellEnchantProcEventMap::const_iterator itr = mSpellEnchantProcEventMap.find(enchId);
    if (itr != mSpellEnchantProcEventMap.end())
        return &itr->second;
    return nullptr;
}

bool SpellMgr::IsArenaAllowedEnchancment(uint32 ench_id) const
{
    return mEnchantCustomAttr[ench_id];
}

const std::vector<int32>* SpellMgr::GetSpellLinked(int32 spell_id) const
{
    SpellLinkedMap::const_iterator itr = mSpellLinkedMap.find(spell_id);
    return itr != mSpellLinkedMap.end() ? &(itr->second) : nullptr;
}

PetLevelupSpellSet const* SpellMgr::GetPetLevelupSpellList(uint32 petFamily) const
{
    PetLevelupSpellMap::const_iterator itr = mPetLevelupSpellMap.find(petFamily);
    if (itr != mPetLevelupSpellMap.end())
        return &itr->second;
    else
        return nullptr;
}

PetDefaultSpellsEntry const* SpellMgr::GetPetDefaultSpellsEntry(int32 id) const
{
    PetDefaultSpellsMap::const_iterator itr = mPetDefaultSpellsMap.find(id);
    if (itr != mPetDefaultSpellsMap.end())
        return &itr->second;
    return nullptr;
}

SpellAreaMapBounds SpellMgr::GetSpellAreaMapBounds(uint32 spell_id) const
{
    return mSpellAreaMap.equal_range(spell_id);
}

SpellAreaForQuestMapBounds SpellMgr::GetSpellAreaForQuestMapBounds(uint32 quest_id) const
{
    return mSpellAreaForQuestMap.equal_range(quest_id);
}

SpellAreaForQuestMapBounds SpellMgr::GetSpellAreaForQuestEndMapBounds(uint32 quest_id) const
{
    return mSpellAreaForQuestEndMap.equal_range(quest_id);
}

SpellAreaForAuraMapBounds SpellMgr::GetSpellAreaForAuraMapBounds(uint32 spell_id) const
{
    return mSpellAreaForAuraMap.equal_range(spell_id);
}

SpellAreaForAreaMapBounds SpellMgr::GetSpellAreaForAreaMapBounds(uint32 area_id) const
{
    return mSpellAreaForAreaMap.equal_range(area_id);
}

bool SpellArea::IsFitToRequirements(Player const* player, uint32 newZone, uint32 newArea) const
{
    if (gender != GENDER_NONE)                   // not in expected gender
        if (!player || gender != player->getGender())
            return false;

    if (raceMask)                                // not in expected race
        if (!player || !(raceMask & player->getRaceMask()))
            return false;

    if (areaId)                                  // not in expected zone
        if (newZone != areaId && newArea != areaId)
            return false;

    if (questStart)                              // not in expected required quest state
        if (!player || (((1 << player->GetQuestStatus(questStart)) & questStartStatus) == 0))
            return false;

    if (questEnd)                                // not in expected forbidden quest state
        if (!player || (((1 << player->GetQuestStatus(questEnd)) & questEndStatus) == 0))
            return false;

    if (auraSpell)                               // not have expected aura
        if (!player || (auraSpell > 0 && !player->HasAura(auraSpell)) || (auraSpell < 0 && player->HasAura(-auraSpell)))
            return false;

    // Extra conditions -- leaving the possibility add extra conditions...
    switch (spellId)
    {
        case 58600: // No fly Zone - Dalaran
            {
                if (!player)
                    return false;

                AreaTableEntry const* pArea = sAreaTableStore.LookupEntry(player->GetAreaId());
                if (!(pArea && pArea->flags & AREA_FLAG_NO_FLY_ZONE))
                    return false;
                if (!player->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED) && !player->HasAuraType(SPELL_AURA_FLY))
                    return false;
                // Xinef: Underbelly elixir
                if (player->GetPositionZ() < 637.0f && player->HasAuraType(SPELL_AURA_TRANSFORM))
                    return false;
                break;
            }
        case 58730: // No fly Zone - Wintergrasp
            {
                if (!player)
                    return false;

                Battlefield* Bf = sBattlefieldMgr->GetBattlefieldToZoneId(player->GetZoneId());
                if (!Bf || Bf->CanFlyIn() || (!player->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED) && !player->HasAuraType(SPELL_AURA_FLY)))
                    return false;
                break;
            }
        // xinef: northrend flying mounts
        // xinef: NE wisp and spectral gryphon
        case 55164:
        case 55173:
            {
                Battlefield* Bf = sBattlefieldMgr->GetBattlefieldToZoneId(player->GetZoneId());
                return !Bf || Bf->CanFlyIn();
            }
        case 57940: // Essence of Wintergrasp OUTSIDE
        case 58045: // Essence of Wintergrasp INSIDE
            {
                if (!player)
                    return false;

                if (sWorld->getIntConfig(CONFIG_WINTERGRASP_ENABLE) != 1)
                    return false;

                Battlefield* Bf = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);
                if (!Bf || player->GetTeamId() != Bf->GetDefenderTeam() || Bf->IsWarTime())
                    return false;
                break;
            }
        case 74411: // Battleground - Dampening
            {
                if (!player)
                    return false;

                if (Battlefield* bf = sBattlefieldMgr->GetBattlefieldToZoneId(player->GetZoneId()))
                    return bf->IsWarTime();
                break;
            }
        case 68719: // Oil Refinery - Isle of Conquest.
        case 68720: // Quarry - Isle of Conquest.
            {
                if (!player)
                    return false;

                Battleground* bg = player->GetBattleground();
                if (!bg || bg->GetBgTypeID(true) != BATTLEGROUND_IC)
                    return false;

                uint8 nodeType = spellId == 68719 ? NODE_TYPE_REFINERY : NODE_TYPE_QUARRY;
                uint8 nodeState = player->GetTeamId() == TEAM_ALLIANCE ? NODE_STATE_CONTROLLED_A : NODE_STATE_CONTROLLED_H;

                return bg->ToBattlegroundIC()->GetNodeState(nodeType) == nodeState;
            }
        case 56618: // Horde Controls Factory Phase Shift
        case 56617: // Alliance Controls Factory Phase Shift
            {
                if (!player)
                    return false;

                Battlefield* bf = sBattlefieldMgr->GetBattlefieldToZoneId(player->GetZoneId());

                if (!bf || bf->GetTypeId() != BATTLEFIELD_WG)
                    return false;

                // team that controls the workshop in the specified area
                uint32 team = bf->GetData(newArea);

                if (team == TEAM_HORDE)
                    return spellId == 56618;
                else if (team == TEAM_ALLIANCE)
                    return spellId == 56617;
                else
                    return false;
                break;
            }
        // Hellscream's Warsong
        case 73816:
        case 73818:
        case 73819:
        case 73820:
        case 73821:
        case 73822:
        // Strength of Wrynn
        case 73762:
        case 73824:
        case 73825:
        case 73826:
        case 73827:
        case 73828:
            if (player)
                if (InstanceScript* s = const_cast<Player*>(player)->GetInstanceScript())
                    return s->GetData(251 /*DATA_BUFF_AVAILABLE*/) != 0;
            return false;
            break;
    }

    return true;
}

void SpellMgr::UnloadSpellInfoChains()
{
    for (SpellChainMap::iterator itr = mSpellChains.begin(); itr != mSpellChains.end(); ++itr)
        mSpellInfoMap[itr->first]->ChainEntry = nullptr;

    mSpellChains.clear();
}

void SpellMgr::LoadSpellTalentRanks()
{
    // cleanup core data before reload - remove reference to ChainNode from SpellInfo
    UnloadSpellInfoChains();

    for (uint32 i = 0; i < sTalentStore.GetNumRows(); ++i)
    {
        TalentEntry const* talentInfo = sTalentStore.LookupEntry(i);
        if (!talentInfo)
            continue;

        SpellInfo const* lastSpell = nullptr;
        for (uint8 rank = MAX_TALENT_RANK - 1; rank > 0; --rank)
        {
            if (talentInfo->RankID[rank])
            {
                lastSpell = GetSpellInfo(talentInfo->RankID[rank]);
                break;
            }
        }

        if (!lastSpell)
            continue;

        SpellInfo const* firstSpell = GetSpellInfo(talentInfo->RankID[0]);
        if (!firstSpell)
        {
            LOG_ERROR("sql.sql", "SpellMgr::LoadSpellTalentRanks: First Rank Spell {} for TalentEntry {} does not exist.", talentInfo->RankID[0], i);
            continue;
        }

        SpellInfo const* prevSpell = nullptr;
        for (uint8 rank = 0; rank < MAX_TALENT_RANK; ++rank)
        {
            uint32 spellId = talentInfo->RankID[rank];
            if (!spellId)
                break;

            SpellInfo const* currentSpell = GetSpellInfo(spellId);
            if (!currentSpell)
            {
                LOG_ERROR("sql.sql", "SpellMgr::LoadSpellTalentRanks: Spell {} (Rank: {}) for TalentEntry {} does not exist.", spellId, rank + 1, i);
                break;
            }

            SpellChainNode node;
            node.first = firstSpell;
            node.last  = lastSpell;
            node.rank  = rank + 1;

            node.prev = prevSpell;
            node.next = node.rank < MAX_TALENT_RANK ? GetSpellInfo(talentInfo->RankID[node.rank]) : nullptr;

            mSpellChains[spellId] = node;
            mSpellInfoMap[spellId]->ChainEntry = &mSpellChains[spellId];

            prevSpell = currentSpell;
        }
    }
}

void SpellMgr::LoadSpellRanks()
{
    // cleanup data and load spell ranks for talents from dbc
    LoadSpellTalentRanks();

    uint32 oldMSTime = getMSTime();

    //                                               0               1          2
    QueryResult result = WorldDatabase.Query("SELECT first_spell_id, spell_id, `rank` from spell_ranks ORDER BY first_spell_id, `rank`");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 spell rank records. DB table `spell_ranks` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    bool finished = false;

    do
    {
        // spellid, rank
        std::list < std::pair < int32, int32 > > rankChain;
        int32 currentSpell = -1;
        int32 lastSpell = -1;

        // fill one chain
        while (currentSpell == lastSpell && !finished)
        {
            Field* fields = result->Fetch();

            currentSpell = fields[0].Get<uint32>();
            if (lastSpell == -1)
                lastSpell = currentSpell;
            uint32 spell_id = fields[1].Get<uint32>();
            uint32 rank = fields[2].Get<uint8>();

            // don't drop the row if we're moving to the next rank
            if (currentSpell == lastSpell)
            {
                rankChain.push_back(std::make_pair(spell_id, rank));
                if (!result->NextRow())
                    finished = true;
            }
            else
                break;
        }
        // check if chain is made with valid first spell
        SpellInfo const* first = GetSpellInfo(lastSpell);
        if (!first)
        {
            LOG_ERROR("sql.sql", "Spell rank identifier(first_spell_id) {} listed in `spell_ranks` does not exist!", lastSpell);
            continue;
        }
        // check if chain is long enough
        if (rankChain.size() < 2)
        {
            LOG_ERROR("sql.sql", "There is only 1 spell rank for identifier(first_spell_id) {} in `spell_ranks`, entry is not needed!", lastSpell);
            continue;
        }
        int32 curRank = 0;
        bool valid = true;
        // check spells in chain
        for (std::list<std::pair<int32, int32> >::iterator itr = rankChain.begin(); itr != rankChain.end(); ++itr)
        {
            SpellInfo const* spell = GetSpellInfo(itr->first);
            if (!spell)
            {
                LOG_ERROR("sql.sql", "Spell {} (rank {}) listed in `spell_ranks` for chain {} does not exist!", itr->first, itr->second, lastSpell);
                valid = false;
                break;
            }
            ++curRank;
            if (itr->second != curRank)
            {
                LOG_ERROR("sql.sql", "Spell {} (rank {}) listed in `spell_ranks` for chain {} does not have proper rank value(should be {})!", itr->first, itr->second, lastSpell, curRank);
                valid = false;
                break;
            }
        }
        if (!valid)
            continue;
        int32 prevRank = 0;
        // insert the chain
        std::list<std::pair<int32, int32> >::iterator itr = rankChain.begin();
        do
        {
            ++count;
            int32 addedSpell = itr->first;
            mSpellChains[addedSpell].first = GetSpellInfo(lastSpell);
            mSpellChains[addedSpell].last = GetSpellInfo(rankChain.back().first);
            mSpellChains[addedSpell].rank = itr->second;
            mSpellChains[addedSpell].prev = GetSpellInfo(prevRank);
            mSpellInfoMap[addedSpell]->ChainEntry = &mSpellChains[addedSpell];
            prevRank = addedSpell;
            ++itr;
            if (itr == rankChain.end())
            {
                mSpellChains[addedSpell].next = nullptr;
                break;
            }
            else
                mSpellChains[addedSpell].next = GetSpellInfo(itr->first);
        } while (true);
    } while (!finished);

    LOG_INFO("server.loading", ">> Loaded {} spell rank records in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellRequired()
{
    uint32 oldMSTime = getMSTime();

    mSpellsReqSpell.clear();                                   // need for reload case
    mSpellReq.clear();                                         // need for reload case

    //                                                   0        1
    QueryResult result = WorldDatabase.Query("SELECT spell_id, req_spell from spell_required");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 spell required records. DB table `spell_required` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 spellId = fields[0].Get<uint32>();
        uint32 spellReq = fields[1].Get<uint32>();

        // check if chain is made with valid first spell
        SpellInfo const* spellInfo = GetSpellInfo(spellId);
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "spell_id {} in `spell_required` table is not found in dbcs, skipped", spellId);
            continue;
        }

        SpellInfo const* reqSpellInfo = GetSpellInfo(spellReq);
        if (!reqSpellInfo)
        {
            LOG_ERROR("sql.sql", "req_spell {} in `spell_required` table is not found in dbcs, skipped", spellReq);
            continue;
        }

        if (GetFirstSpellInChain(spellId) == GetFirstSpellInChain(spellReq))
        {
            LOG_ERROR("sql.sql", "req_spell {} and spell_id {} in `spell_required` table are ranks of the same spell, entry not needed, skipped", spellReq, spellId);
            continue;
        }

        if (IsSpellRequiringSpell(spellId, spellReq))
        {
            LOG_ERROR("sql.sql", "duplicated entry of req_spell {} and spell_id {} in `spell_required`, skipped", spellReq, spellId);
            continue;
        }

        mSpellReq.insert (std::pair<uint32, uint32>(spellId, spellReq));
        mSpellsReqSpell.insert (std::pair<uint32, uint32>(spellReq, spellId));
        ++count;

        // xinef: fill additionalTalentInfo data, currently Blessing of Sanctuary only
        if (GetTalentSpellCost(spellReq) > 0)
            mTalentSpellAdditionalSet.insert(spellId);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Spell Required Records in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellLearnSkills()
{
    uint32 oldMSTime = getMSTime();

    mSpellLearnSkills.clear();                              // need for reload case

    // search auto-learned skills and add its to map also for use in unlearn spells/talents
    uint32 dbc_count = 0;
    for (uint32 spell = 0; spell < GetSpellInfoStoreSize(); ++spell)
    {
        SpellInfo const* entry = GetSpellInfo(spell);

        if (!entry)
            continue;

        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            SpellLearnSkillNode dbc_node;
            switch (entry->Effects[i].Effect)
            {
                case SPELL_EFFECT_SKILL:
                    dbc_node.skill = entry->Effects[i].MiscValue;
                    dbc_node.step  = entry->Effects[i].CalcValue();
                    if (dbc_node.skill != SKILL_RIDING)
                    {
                        dbc_node.value = 1;
                    }
                    else
                    {
                        dbc_node.value = dbc_node.step * 75;
                    }
                    dbc_node.maxvalue = dbc_node.step * 75;
                    break;
                case SPELL_EFFECT_DUAL_WIELD:
                    dbc_node.skill = SKILL_DUAL_WIELD;
                    dbc_node.step = 1;
                    dbc_node.value = 1;
                    dbc_node.maxvalue = 1;
                    break;
                default:
                    continue;
            }

            mSpellLearnSkills[spell] = dbc_node;
            ++dbc_count;
            break;
        }
    }

    LOG_INFO("server.loading", ">> Loaded {} Spell Learn Skills From DBC in {} ms", dbc_count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellTargetPositions()
{
    uint32 oldMSTime = getMSTime();

    mSpellTargetPositions.clear();                                // need for reload case

    //                                                0      1          2        3         4           5            6
    QueryResult result = WorldDatabase.Query("SELECT ID, EffectIndex, MapID, PositionX, PositionY, PositionZ, Orientation FROM spell_target_position");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 spell target coordinates. DB table `spell_target_position` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 Spell_ID = fields[0].Get<uint32>();

        SpellEffIndex effIndex = SpellEffIndex(fields[1].Get<uint8>());

        SpellTargetPosition st;

        st.target_mapId       = fields[2].Get<uint16>();
        st.target_X           = fields[3].Get<float>();
        st.target_Y           = fields[4].Get<float>();
        st.target_Z           = fields[5].Get<float>();
        st.target_Orientation = fields[6].Get<float>();

        MapEntry const* mapEntry = sMapStore.LookupEntry(st.target_mapId);
        if (!mapEntry)
        {
            LOG_ERROR("sql.sql", "Spell (Id: {}, effIndex: {}) target map (ID: {}) does not exist in `Map.dbc`.", Spell_ID, effIndex, st.target_mapId);
            continue;
        }

        if (st.target_X == 0 && st.target_Y == 0 && st.target_Z == 0)
        {
            LOG_ERROR("sql.sql", "Spell (Id: {}, effIndex: {}) target coordinates not provided.", Spell_ID, effIndex);
            continue;
        }

        SpellInfo const* spellInfo = GetSpellInfo(Spell_ID);
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Spell (ID:{}) listed in `spell_target_position` does not exist.", Spell_ID);
            continue;
        }

        if (spellInfo->Effects[effIndex].TargetA.GetTarget() == TARGET_DEST_DB || spellInfo->Effects[effIndex].TargetB.GetTarget() == TARGET_DEST_DB)
        {
            std::pair<uint32, SpellEffIndex> key = std::make_pair(Spell_ID, effIndex);
            mSpellTargetPositions[key] = st;
            ++count;
        }
        else
        {
            LOG_ERROR("sql.sql", "Spell (Id: {}, effIndex: {}) listed in `spell_target_position` does not have target TARGET_DEST_DB (17).", Spell_ID, effIndex);
            continue;
        }
    } while (result->NextRow());

    /*
    // Check all spells
    for (uint32 i = 1; i < GetSpellInfoStoreSize; ++i)
    {
        SpellInfo const* spellInfo = GetSpellInfo(i);
        if (!spellInfo)
            continue;

        bool found = false;
        for (int j = 0; j < MAX_SPELL_EFFECTS; ++j)
        {
            switch (spellInfo->Effects[j].TargetA)
            {
                case TARGET_DEST_DB:
                    found = true;
                    break;
            }
            if (found)
                break;
            switch (spellInfo->Effects[j].TargetB)
            {
                case TARGET_DEST_DB:
                    found = true;
                    break;
            }
            if (found)
                break;
        }
        if (found)
        {
            if (!sSpellMgr->GetSpellTargetPosition(i))
                LOG_DEBUG("spells.aura", "Spell (ID: {}) does not have record in `spell_target_position`", i);
        }
    }*/

    LOG_INFO("server.loading", ">> Loaded {} Spell Teleport Coordinates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellGroups()
{
    uint32 oldMSTime = getMSTime();

    mSpellGroupMap.clear();                                  // need for reload case

    //                                                0     1            2
    QueryResult result = WorldDatabase.Query("SELECT id, spell_id, special_flag FROM spell_group");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 spell group definitions. DB table `spell_group` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 group_id = fields[0].Get<uint32>();
        int32 spell_id = fields[1].Get<uint32>();
        SpellGroupSpecialFlags specialFlag = (SpellGroupSpecialFlags)fields[2].Get<uint32>();
        SpellInfo const* spellInfo = GetSpellInfo(spell_id);

        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_group` does not exist", spell_id);
            continue;
        }
        else if (spellInfo->GetRank() > 1)
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_group` is not first rank of spell", spell_id);
            continue;
        }

        if (mSpellGroupMap.find(spell_id) != mSpellGroupMap.end())
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_group` has more than one group", spell_id);
            continue;
        }

        if (specialFlag >= SPELL_GROUP_SPECIAL_FLAG_MAX)
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_group` has invalid special flag!", spell_id);
            continue;
        }

        SpellStackInfo ssi;
        ssi.groupId = group_id;
        ssi.specialFlags = specialFlag;
        mSpellGroupMap[spell_id] = ssi;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Spell Group Definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellGroupStackRules()
{
    uint32 oldMSTime = getMSTime();

    mSpellGroupStackMap.clear();                                  // need for reload case

    //                                                       0         1
    QueryResult result = WorldDatabase.Query("SELECT group_id, stack_rule FROM spell_group_stack_rules");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 spell group stack rules. DB table `spell_group_stack_rules` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 group_id = fields[0].Get<uint32>();
        uint8 stack_rule = fields[1].Get<int8>();
        if (stack_rule >= SPELL_GROUP_STACK_FLAG_MAX)
        {
            LOG_ERROR("sql.sql", "SpellGroupStackRule {} listed in `spell_group_stack_rules` does not exist", stack_rule);
            continue;
        }

        bool present = false;
        for (SpellGroupMap::const_iterator itr = mSpellGroupMap.begin(); itr != mSpellGroupMap.end(); ++itr)
            if (itr->second.groupId == group_id)
            {
                present = true;
                break;
            }

        if (!present)
        {
            LOG_ERROR("sql.sql", "SpellGroup id {} listed in `spell_group_stack_rules` does not exist", group_id);
            continue;
        }

        mSpellGroupStackMap[group_id] = (SpellGroupStackFlags)stack_rule;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Spell Group Stack Rules in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellProcEvents()
{
    uint32 oldMSTime = getMSTime();

    mSpellProcEventMap.clear();                             // need for reload case

    //                                                0      1           2                3                 4                 5                 6          7       8          9             10       11
    QueryResult result = WorldDatabase.Query("SELECT entry, SchoolMask, SpellFamilyName, SpellFamilyMask0, SpellFamilyMask1, SpellFamilyMask2, procFlags, procEx, procPhase, ppmRate, CustomChance, Cooldown FROM spell_proc_event");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 spell proc event conditions. DB table `spell_proc_event` is empty.");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        int32 spellId = fields[0].Get<int32>();

        bool allRanks = false;
        if (spellId < 0)
        {
            allRanks = true;
            spellId = -spellId;
        }

        SpellInfo const* spellInfo = GetSpellInfo(spellId);
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_proc_event` does not exist", spellId);
            continue;
        }

        if (allRanks)
        {
            if (!spellInfo->IsRanked())
                LOG_ERROR("sql.sql", "Spell {} listed in `spell_proc_event` with all ranks, but spell has no ranks.", spellId);

            if (spellInfo->GetFirstRankSpell()->Id != uint32(spellId))
            {
                LOG_ERROR("sql.sql", "Spell {} listed in `spell_proc_event` is not first rank of spell.", spellId);
                continue;
            }
        }

        SpellProcEventEntry spellProcEvent;

        spellProcEvent.schoolMask         = fields[1].Get<int8>();
        spellProcEvent.spellFamilyName    = fields[2].Get<uint16>();
        spellProcEvent.spellFamilyMask[0] = fields[3].Get<uint32>();
        spellProcEvent.spellFamilyMask[1] = fields[4].Get<uint32>();
        spellProcEvent.spellFamilyMask[2] = fields[5].Get<uint32>();
        spellProcEvent.procFlags          = fields[6].Get<uint32>();
        spellProcEvent.procEx             = fields[7].Get<uint32>();
        spellProcEvent.procPhase          = fields[8].Get<uint32>();
        spellProcEvent.ppmRate            = fields[9].Get<float>();
        spellProcEvent.customChance       = fields[10].Get<float>();
        spellProcEvent.cooldown           = fields[11].Get<uint32>();

        // PROC_SPELL_PHASE_NONE is by default PROC_SPELL_PHASE_HIT
        if (spellProcEvent.procPhase == PROC_SPELL_PHASE_NONE)
        {
            spellProcEvent.procPhase = PROC_SPELL_PHASE_HIT;
        }

        while (spellInfo)
        {
            if (mSpellProcEventMap.find(spellInfo->Id) != mSpellProcEventMap.end())
            {
                LOG_ERROR("sql.sql", "Spell {} listed in `spell_proc_event` already has its first rank in table.", spellInfo->Id);
                break;
            }

            if (!spellInfo->ProcFlags && !spellProcEvent.procFlags)
                LOG_ERROR("sql.sql", "Spell {} listed in `spell_proc_event` probally not triggered spell", spellInfo->Id);

            mSpellProcEventMap[spellInfo->Id] = spellProcEvent;

            if (allRanks)
                spellInfo = spellInfo->GetNextRankSpell();
            else
                break;
        }

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Extra Spell Proc Event Conditions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellProcs()
{
    uint32 oldMSTime = getMSTime();

    mSpellProcMap.clear();                             // need for reload case

    //                                                 0        1           2                3                 4                 5                 6          7              8              9         10              11             12      13        14
    QueryResult result = WorldDatabase.Query("SELECT SpellId, SchoolMask, SpellFamilyName, SpellFamilyMask0, SpellFamilyMask1, SpellFamilyMask2, ProcFlags, SpellTypeMask, SpellPhaseMask, HitMask, AttributesMask, ProcsPerMinute, Chance, Cooldown, Charges FROM spell_proc");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Spell Proc Conditions And Data. DB table `spell_proc` Is Empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        int32 spellId = fields[0].Get<int32>();

        bool allRanks = false;
        if (spellId < 0)
        {
            allRanks = true;
            spellId = -spellId;
        }

        SpellInfo const* spellInfo = GetSpellInfo(spellId);
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_proc` does not exist", spellId);
            continue;
        }

        if (allRanks)
        {
            if (spellInfo->GetFirstRankSpell()->Id != uint32(spellId))
            {
                LOG_ERROR("sql.sql", "Spell {} listed in `spell_proc` is not first rank of spell.", fields[0].Get<int32>());
                continue;
            }
        }

        SpellProcEntry baseProcEntry;

        baseProcEntry.SchoolMask         = fields[1].Get<int8>();
        baseProcEntry.SpellFamilyName    = fields[2].Get<uint16>();
        baseProcEntry.SpellFamilyMask[0] = fields[3].Get<uint32>();
        baseProcEntry.SpellFamilyMask[1] = fields[4].Get<uint32>();
        baseProcEntry.SpellFamilyMask[2] = fields[5].Get<uint32>();
        baseProcEntry.ProcFlags          = fields[6].Get<uint32>();
        baseProcEntry.SpellTypeMask      = fields[7].Get<uint32>();
        baseProcEntry.SpellPhaseMask     = fields[8].Get<uint32>();
        baseProcEntry.HitMask            = fields[9].Get<uint32>();
        baseProcEntry.AttributesMask     = fields[10].Get<uint32>();
        baseProcEntry.ProcsPerMinute     = fields[11].Get<float>();
        baseProcEntry.Chance             = fields[12].Get<float>();
        baseProcEntry.Cooldown           = Milliseconds(fields[13].Get<uint32>());
        baseProcEntry.Charges            = fields[14].Get<uint32>();

        while (spellInfo)
        {
            if (mSpellProcMap.find(spellInfo->Id) != mSpellProcMap.end())
            {
                LOG_ERROR("sql.sql", "Spell {} listed in `spell_proc` has duplicate entry in the table", spellId);
                break;
            }
            SpellProcEntry procEntry = SpellProcEntry(baseProcEntry);

            // take defaults from dbcs
            if (!procEntry.ProcFlags)
                procEntry.ProcFlags = spellInfo->ProcFlags;
            if (!procEntry.Charges)
                procEntry.Charges = spellInfo->ProcCharges;
            if (!procEntry.Chance && !procEntry.ProcsPerMinute)
                procEntry.Chance = float(spellInfo->ProcChance);

            // validate data
            if (procEntry.SchoolMask & ~SPELL_SCHOOL_MASK_ALL)
                LOG_ERROR("sql.sql", "`spell_proc` table entry for SpellId {} has wrong `SchoolMask` set: {}", spellId, procEntry.SchoolMask);
            if (procEntry.SpellFamilyName && (procEntry.SpellFamilyName < 3 || procEntry.SpellFamilyName > 17 || procEntry.SpellFamilyName == 14 || procEntry.SpellFamilyName == 16))
                LOG_ERROR("sql.sql", "`spell_proc` table entry for SpellId {} has wrong `SpellFamilyName` set: {}", spellId, procEntry.SpellFamilyName);
            if (procEntry.Chance < 0)
            {
                LOG_ERROR("sql.sql", "`spell_proc` table entry for SpellId {} has negative value in `Chance` field", spellId);
                procEntry.Chance = 0;
            }
            if (procEntry.ProcsPerMinute < 0)
            {
                LOG_ERROR("sql.sql", "`spell_proc` table entry for SpellId {} has negative value in `ProcsPerMinute` field", spellId);
                procEntry.ProcsPerMinute = 0;
            }
            if (procEntry.Chance == 0 && procEntry.ProcsPerMinute == 0)
                LOG_ERROR("sql.sql", "`spell_proc` table entry for SpellId {} doesn't have `Chance` and `ProcsPerMinute` values defined, proc will not be triggered", spellId);
            if (procEntry.Charges > 99)
            {
                LOG_ERROR("sql.sql", "`spell_proc` table entry for SpellId {} has too big value in `Charges` field", spellId);
                procEntry.Charges = 99;
            }
            if (!procEntry.ProcFlags)
                LOG_ERROR("sql.sql", "`spell_proc` table entry for SpellId {} doesn't have `ProcFlags` value defined, proc will not be triggered", spellId);
            if (procEntry.SpellTypeMask & ~PROC_SPELL_TYPE_MASK_ALL)
                LOG_ERROR("sql.sql", "`spell_proc` table entry for SpellId {} has wrong `SpellTypeMask` set: {}", spellId, procEntry.SpellTypeMask);
            if (procEntry.SpellTypeMask && !(procEntry.ProcFlags & (SPELL_PROC_FLAG_MASK | PERIODIC_PROC_FLAG_MASK)))
                LOG_ERROR("sql.sql", "`spell_proc` table entry for SpellId {} has `SpellTypeMask` value defined, but it won't be used for defined `ProcFlags` value", spellId);
            if (!procEntry.SpellPhaseMask && procEntry.ProcFlags & REQ_SPELL_PHASE_PROC_FLAG_MASK)
                LOG_ERROR("sql.sql", "`spell_proc` table entry for SpellId {} doesn't have `SpellPhaseMask` value defined, but it's required for defined `ProcFlags` value, proc will not be triggered", spellId);
            if (procEntry.SpellPhaseMask & ~PROC_SPELL_PHASE_MASK_ALL)
                LOG_ERROR("sql.sql", "`spell_proc` table entry for SpellId {} has wrong `SpellPhaseMask` set: {}", spellId, procEntry.SpellPhaseMask);
            if (procEntry.SpellPhaseMask && !(procEntry.ProcFlags & REQ_SPELL_PHASE_PROC_FLAG_MASK))
                LOG_ERROR("sql.sql", "`spell_proc` table entry for SpellId {} has `SpellPhaseMask` value defined, but it won't be used for defined `ProcFlags` value", spellId);
            if (procEntry.HitMask & ~PROC_HIT_MASK_ALL)
                LOG_ERROR("sql.sql", "`spell_proc` table entry for SpellId {} has wrong `HitMask` set: {}", spellId, procEntry.HitMask);
            if (procEntry.HitMask && !(procEntry.ProcFlags & TAKEN_HIT_PROC_FLAG_MASK || (procEntry.ProcFlags & DONE_HIT_PROC_FLAG_MASK && (!procEntry.SpellPhaseMask || procEntry.SpellPhaseMask & (PROC_SPELL_PHASE_HIT | PROC_SPELL_PHASE_FINISH)))))
                LOG_ERROR("sql.sql", "`spell_proc` table entry for SpellId {} has `HitMask` value defined, but it won't be used for defined `ProcFlags` and `SpellPhaseMask` values", spellId);

            mSpellProcMap[spellInfo->Id] = procEntry;

            if (allRanks)
                spellInfo = spellInfo->GetNextRankSpell();
            else
                break;
        }
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} spell proc conditions and data in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellBonuses()
{
    uint32 oldMSTime = getMSTime();

    mSpellBonusMap.clear();                             // need for reload case

    //                                                0      1             2          3         4
    QueryResult result = WorldDatabase.Query("SELECT entry, direct_bonus, dot_bonus, ap_bonus, ap_dot_bonus FROM spell_bonus_data");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 spell bonus data. DB table `spell_bonus_data` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();
        uint32 entry = fields[0].Get<uint32>();

        SpellInfo const* spell = GetSpellInfo(entry);
        if (!spell)
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_bonus_data` does not exist", entry);
            continue;
        }

        SpellBonusEntry& sbe = mSpellBonusMap[entry];
        sbe.direct_damage = fields[1].Get<float>();
        sbe.dot_damage    = fields[2].Get<float>();
        sbe.ap_bonus      = fields[3].Get<float>();
        sbe.ap_dot_bonus   = fields[4].Get<float>();

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Extra Spell Bonus Data in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellThreats()
{
    uint32 oldMSTime = getMSTime();

    mSpellThreatMap.clear();                                // need for reload case

    //                                                0      1        2       3
    QueryResult result = WorldDatabase.Query("SELECT entry, flatMod, pctMod, apPctMod FROM spell_threat");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 aggro generating spells. DB table `spell_threat` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].Get<uint32>();

        if (!GetSpellInfo(entry))
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_threat` does not exist", entry);
            continue;
        }

        SpellThreatEntry ste;
        ste.flatMod  = fields[1].Get<int32>();
        ste.pctMod   = fields[2].Get<float>();
        ste.apPctMod = fields[3].Get<float>();

        mSpellThreatMap[entry] = ste;
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} SpellThreatEntries in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellMixology()
{
    uint32 oldMSTime = getMSTime();

    mSpellMixologyMap.clear();                                // need for reload case

    //                                                0      1
    QueryResult result = WorldDatabase.Query("SELECT entry, pctMod FROM spell_mixology");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 mixology bonuses. DB table `spell_mixology` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].Get<uint32>();

        if (!GetSpellInfo(entry))
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_mixology` does not exist", entry);
            continue;
        }

        mSpellMixologyMap[entry] = fields[1].Get<float>();
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Mixology Bonuses in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSkillLineAbilityMap()
{
    uint32 oldMSTime = getMSTime();

    mSkillLineAbilityMap.clear();

    uint32 count = 0;

    for (uint32 i = 0; i < sSkillLineAbilityStore.GetNumRows(); ++i)
    {
        SkillLineAbilityEntry const* SkillInfo = sSkillLineAbilityStore.LookupEntry(i);
        if (!SkillInfo)
            continue;

        mSkillLineAbilityMap.insert(SkillLineAbilityMap::value_type(SkillInfo->Spell, SkillInfo));
        ++count;
    }

    LOG_INFO("server.loading", ">> Loaded {} SkillLineAbility MultiMap Data in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellPetAuras()
{
    uint32 oldMSTime = getMSTime();

    mSpellPetAuraMap.clear();                                  // need for reload case

    //                                                  0       1       2    3
    QueryResult result = WorldDatabase.Query("SELECT spell, effectId, pet, aura FROM spell_pet_auras");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 spell pet auras. DB table `spell_pet_auras` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 spell = fields[0].Get<uint32>();
        uint8 eff = fields[1].Get<uint8>();
        uint32 pet = fields[2].Get<uint32>();
        uint32 aura = fields[3].Get<uint32>();

        SpellPetAuraMap::iterator itr = mSpellPetAuraMap.find((spell << 8) + eff);
        if (itr != mSpellPetAuraMap.end())
            itr->second.AddAura(pet, aura);
        else
        {
            SpellInfo const* spellInfo = GetSpellInfo(spell);
            if (!spellInfo)
            {
                LOG_ERROR("sql.sql", "Spell {} listed in `spell_pet_auras` does not exist", spell);
                continue;
            }
            if (spellInfo->Effects[eff].Effect != SPELL_EFFECT_DUMMY &&
                    (spellInfo->Effects[eff].Effect != SPELL_EFFECT_APPLY_AURA ||
                     spellInfo->Effects[eff].ApplyAuraName != SPELL_AURA_DUMMY))
            {
                LOG_ERROR("spells", "Spell {} listed in `spell_pet_auras` does not have dummy aura or dummy effect", spell);
                continue;
            }

            SpellInfo const* spellInfo2 = GetSpellInfo(aura);
            if (!spellInfo2)
            {
                LOG_ERROR("sql.sql", "Aura {} listed in `spell_pet_auras` does not exist", aura);
                continue;
            }

            PetAura pa(pet, aura, spellInfo->Effects[eff].TargetA.GetTarget() == TARGET_UNIT_PET, spellInfo->Effects[eff].CalcValue());
            mSpellPetAuraMap[(spell << 8) + eff] = pa;
        }

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Spell Pet Auras in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

// Fill custom data about enchancments
void SpellMgr::LoadEnchantCustomAttr()
{
    uint32 oldMSTime = getMSTime();

    uint32 size = sSpellItemEnchantmentStore.GetNumRows();
    mEnchantCustomAttr.resize(size);

    for (uint32 i = 0; i < size; ++i)
        mEnchantCustomAttr[i] = 0;

    uint32 count = 0;
    for (uint32 i = 0; i < GetSpellInfoStoreSize(); ++i)
    {
        SpellInfo const* spellInfo = GetSpellInfo(i);
        if (!spellInfo)
            continue;

        /// @todo: find a better check
        // Xinef: commented second part, fixes warlock enchants like firestone, spellstone
        if (!spellInfo->HasAttribute(SPELL_ATTR2_ENCHANT_OWN_ITEM_ONLY)/* || !spellInfo->HasAttribute(SPELL_ATTR0_NOT_SHAPESHIFTED)*/)
            continue;

        for (uint32 j = 0; j < MAX_SPELL_EFFECTS; ++j)
        {
            if (spellInfo->Effects[j].Effect == SPELL_EFFECT_ENCHANT_ITEM_TEMPORARY)
            {
                uint32 enchId = spellInfo->Effects[j].MiscValue;
                SpellItemEnchantmentEntry const* ench = sSpellItemEnchantmentStore.LookupEntry(enchId);
                if (!ench)
                    continue;
                mEnchantCustomAttr[enchId] = true;
                ++count;
                break;
            }
        }
    }

    LOG_INFO("server.loading", ">> Loaded {} Custom Enchant Attributes in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellEnchantProcData()
{
    uint32 oldMSTime = getMSTime();

    mSpellEnchantProcEventMap.clear();                             // need for reload case

    //                                                  0         1           2         3          4
    QueryResult result = WorldDatabase.Query("SELECT entry, customChance, PPMChance, procEx, attributeMask FROM spell_enchant_proc_data");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 spell enchant proc event conditions. DB table `spell_enchant_proc_data` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 enchantId = fields[0].Get<uint32>();

        SpellItemEnchantmentEntry const* ench = sSpellItemEnchantmentStore.LookupEntry(enchantId);
        if (!ench)
        {
            LOG_ERROR("sql.sql", "Enchancment {} listed in `spell_enchant_proc_data` does not exist", enchantId);
            continue;
        }

        SpellEnchantProcEntry spe;

        spe.customChance = fields[1].Get<uint32>();
        spe.PPMChance = fields[2].Get<float>();
        spe.procEx = fields[3].Get<uint32>();
        spe.attributeMask = fields[4].Get<uint32>();

        mSpellEnchantProcEventMap[enchantId] = spe;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Enchant Proc Data Definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellLinked()
{
    uint32 oldMSTime = getMSTime();

    mSpellLinkedMap.clear();    // need for reload case

    //                                                0              1             2
    QueryResult result = WorldDatabase.Query("SELECT spell_trigger, spell_effect, type FROM spell_linked_spell");
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 linked spells. DB table `spell_linked_spell` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        int32 trigger = fields[0].Get<int32>();
        int32 effect = fields[1].Get<int32>();
        int32 type = fields[2].Get<uint8>();

        SpellInfo const* spellInfo = GetSpellInfo(std::abs(trigger));
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_linked_spell` does not exist", std::abs(trigger));
            continue;
        }
        spellInfo = GetSpellInfo(std::abs(effect));
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_linked_spell` does not exist", std::abs(effect));
            continue;
        }

        if (type) //we will find a better way when more types are needed
        {
            if (trigger > 0)
                trigger += SPELL_LINKED_MAX_SPELLS * type;
            else
                trigger -= SPELL_LINKED_MAX_SPELLS * type;
        }
        mSpellLinkedMap[trigger].push_back(effect);

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Linked Spells in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadPetLevelupSpellMap()
{
    uint32 oldMSTime = getMSTime();

    mPetLevelupSpellMap.clear();                                   // need for reload case

    uint32 count = 0;
    uint32 family_count = 0;

    for (uint32 i = 0; i < sCreatureFamilyStore.GetNumRows(); ++i)
    {
        CreatureFamilyEntry const* creatureFamily = sCreatureFamilyStore.LookupEntry(i);
        if (!creatureFamily)                                     // not exist
            continue;

        for (uint8 j = 0; j < 2; ++j)
        {
            if (!creatureFamily->skillLine[j])
                continue;

            for (SkillLineAbilityEntry const* skillLine : GetSkillLineAbilitiesBySkillLine(creatureFamily->skillLine[j]))
            {
                if (skillLine->AcquireMethod != SKILL_LINE_ABILITY_LEARNED_ON_SKILL_LEARN)
                    continue;

                SpellInfo const* spell = GetSpellInfo(skillLine->Spell);
                if (!spell) // not exist or triggered or talent
                    continue;

                if (!spell->SpellLevel)
                    continue;

                PetLevelupSpellSet& spellSet = mPetLevelupSpellMap[creatureFamily->ID];
                if (spellSet.empty())
                    ++family_count;

                spellSet.insert(PetLevelupSpellSet::value_type(spell->SpellLevel, spell->Id));
                ++count;
            }
        }
    }

    LOG_INFO("server.loading", ">> Loaded {} Pet Levelup And Default Spells For {} Families in {} ms", count, family_count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

bool LoadPetDefaultSpells_helper(CreatureTemplate const* cInfo, PetDefaultSpellsEntry& petDefSpells)
{
    // skip empty list;
    bool have_spell = false;
    for (uint8 j = 0; j < MAX_CREATURE_SPELL_DATA_SLOT; ++j)
    {
        if (petDefSpells.spellid[j])
        {
            have_spell = true;
            break;
        }
    }
    if (!have_spell)
        return false;

    // remove duplicates with levelupSpells if any
    if (PetLevelupSpellSet const* levelupSpells = cInfo->family ? sSpellMgr->GetPetLevelupSpellList(cInfo->family) : nullptr)
    {
        for (uint8 j = 0; j < MAX_CREATURE_SPELL_DATA_SLOT; ++j)
        {
            if (!petDefSpells.spellid[j])
                continue;

            for (PetLevelupSpellSet::const_iterator itr = levelupSpells->begin(); itr != levelupSpells->end(); ++itr)
            {
                if (itr->second == petDefSpells.spellid[j])
                {
                    petDefSpells.spellid[j] = 0;
                    break;
                }
            }
        }
    }

    // skip empty list;
    have_spell = false;
    for (uint8 j = 0; j < MAX_CREATURE_SPELL_DATA_SLOT; ++j)
    {
        if (petDefSpells.spellid[j])
        {
            have_spell = true;
            break;
        }
    }

    return have_spell;
}

void SpellMgr::LoadPetDefaultSpells()
{
    uint32 oldMSTime = getMSTime();

    mPetDefaultSpellsMap.clear();

    uint32 countCreature = 0;
    uint32 countData = 0;

    CreatureTemplateContainer const* ctc = sObjectMgr->GetCreatureTemplates();
    for (CreatureTemplateContainer::const_iterator itr = ctc->begin(); itr != ctc->end(); ++itr)
    {
        if (!itr->second.PetSpellDataId)
            continue;

        // for creature with PetSpellDataId get default pet spells from dbc
        CreatureSpellDataEntry const* spellDataEntry = sCreatureSpellDataStore.LookupEntry(itr->second.PetSpellDataId);
        if (!spellDataEntry)
            continue;

        int32 petSpellsId = -int32(itr->second.PetSpellDataId);
        PetDefaultSpellsEntry petDefSpells;
        for (uint8 j = 0; j < MAX_CREATURE_SPELL_DATA_SLOT; ++j)
            petDefSpells.spellid[j] = spellDataEntry->spellId[j];

        if (LoadPetDefaultSpells_helper(&itr->second, petDefSpells))
        {
            mPetDefaultSpellsMap[petSpellsId] = petDefSpells;
            ++countData;
        }
    }

    LOG_INFO("server.loading", ">> Loaded Addition Spells For {} Pet Spell Data Entries in {} ms", countData, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");

    LOG_INFO("server.loading", "Loading Summonable Creature Templates...");
    oldMSTime = getMSTime();

    // different summon spells
    for (uint32 i = 0; i < GetSpellInfoStoreSize(); ++i)
    {
        SpellInfo const* spellInfo = GetSpellInfo(i);
        if (!spellInfo)
            continue;

        for (uint8 k = 0; k < MAX_SPELL_EFFECTS; ++k)
        {
            if (spellInfo->Effects[k].Effect == SPELL_EFFECT_SUMMON || spellInfo->Effects[k].Effect == SPELL_EFFECT_SUMMON_PET)
            {
                uint32 creature_id = spellInfo->Effects[k].MiscValue;
                CreatureTemplate const* cInfo = sObjectMgr->GetCreatureTemplate(creature_id);
                if (!cInfo)
                    continue;

                // already loaded
                if (cInfo->PetSpellDataId)
                    continue;

                // for creature without PetSpellDataId get default pet spells from creature_template
                int32 petSpellsId = cInfo->Entry;
                if (mPetDefaultSpellsMap.find(cInfo->Entry) != mPetDefaultSpellsMap.end())
                    continue;

                PetDefaultSpellsEntry petDefSpells;
                for (uint8 j = 0; j < MAX_CREATURE_SPELL_DATA_SLOT; ++j)
                    petDefSpells.spellid[j] = cInfo->spells[j];

                if (LoadPetDefaultSpells_helper(cInfo, petDefSpells))
                {
                    mPetDefaultSpellsMap[petSpellsId] = petDefSpells;
                    ++countCreature;
                }
            }
        }
    }

    LOG_INFO("server.loading", ">> Loaded {} Summonable Creature emplates in {} ms", countCreature, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellAreas()
{
    uint32 oldMSTime = getMSTime();

    mSpellAreaMap.clear();                                  // need for reload case
    mSpellAreaForQuestMap.clear();
    mSpellAreaForQuestEndMap.clear();
    mSpellAreaForAuraMap.clear();

    //                                                  0     1         2              3               4                 5          6          7       8         9
    QueryResult result = WorldDatabase.Query("SELECT spell, area, quest_start, quest_start_status, quest_end_status, quest_end, aura_spell, racemask, gender, autocast FROM spell_area");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 spell area requirements. DB table `spell_area` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 spell = fields[0].Get<uint32>();
        SpellArea spellArea;
        spellArea.spellId             = spell;
        spellArea.areaId              = fields[1].Get<uint32>();
        spellArea.questStart          = fields[2].Get<uint32>();
        spellArea.questStartStatus    = fields[3].Get<uint32>();
        spellArea.questEndStatus      = fields[4].Get<uint32>();
        spellArea.questEnd            = fields[5].Get<uint32>();
        spellArea.auraSpell           = fields[6].Get<int32>();
        spellArea.raceMask            = fields[7].Get<uint32>();
        spellArea.gender              = Gender(fields[8].Get<uint8>());
        spellArea.autocast            = fields[9].Get<bool>();

        if (SpellInfo const* spellInfo = GetSpellInfo(spell))
        {
            if (spellArea.autocast)
                const_cast<SpellInfo*>(spellInfo)->Attributes |= SPELL_ATTR0_NO_AURA_CANCEL;
        }
        else
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_area` does not exist", spell);
            continue;
        }

        {
            bool ok = true;
            SpellAreaMapBounds sa_bounds = GetSpellAreaMapBounds(spellArea.spellId);
            for (SpellAreaMap::const_iterator itr = sa_bounds.first; itr != sa_bounds.second; ++itr)
            {
                if (spellArea.spellId != itr->second.spellId)
                    continue;
                if (spellArea.areaId != itr->second.areaId)
                    continue;
                if (spellArea.questStart != itr->second.questStart)
                    continue;
                if (spellArea.auraSpell != itr->second.auraSpell)
                    continue;
                if ((spellArea.raceMask & itr->second.raceMask) == 0)
                    continue;
                if (spellArea.gender != itr->second.gender)
                    continue;

                // duplicate by requirements
                ok = false;
                break;
            }

            if (!ok)
            {
                LOG_ERROR("sql.sql", "Spell {} listed in `spell_area` already listed with similar requirements.", spell);
                continue;
            }
        }

        if (spellArea.areaId && !sAreaTableStore.LookupEntry(spellArea.areaId))
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_area` have wrong area ({}) requirement", spell, spellArea.areaId);
            continue;
        }

        if (spellArea.questStart && !sObjectMgr->GetQuestTemplate(spellArea.questStart))
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_area` have wrong start quest ({}) requirement", spell, spellArea.questStart);
            continue;
        }

        if (spellArea.questEnd)
        {
            if (!sObjectMgr->GetQuestTemplate(spellArea.questEnd))
            {
                LOG_ERROR("sql.sql", "Spell {} listed in `spell_area` have wrong end quest ({}) requirement", spell, spellArea.questEnd);
                continue;
            }
        }

        if (spellArea.auraSpell)
        {
            SpellInfo const* spellInfo = GetSpellInfo(std::abs(spellArea.auraSpell));
            if (!spellInfo)
            {
                LOG_ERROR("sql.sql", "Spell {} listed in `spell_area` have wrong aura spell ({}) requirement", spell, std::abs(spellArea.auraSpell));
                continue;
            }

            if (uint32(std::abs(spellArea.auraSpell)) == spellArea.spellId)
            {
                LOG_ERROR("sql.sql", "Spell {} listed in `spell_area` have aura spell ({}) requirement for itself", spell, std::abs(spellArea.auraSpell));
                continue;
            }

            // not allow autocast chains by auraSpell field (but allow use as alternative if not present)
            if (spellArea.autocast && spellArea.auraSpell > 0)
            {
                bool chain = false;
                SpellAreaForAuraMapBounds saBound = GetSpellAreaForAuraMapBounds(spellArea.spellId);
                for (SpellAreaForAuraMap::const_iterator itr = saBound.first; itr != saBound.second; ++itr)
                {
                    if (itr->second->autocast && itr->second->auraSpell > 0)
                    {
                        chain = true;
                        break;
                    }
                }

                if (chain)
                {
                    LOG_ERROR("sql.sql", "Spell {} listed in `spell_area` have aura spell ({}) requirement that itself autocast from aura", spell, spellArea.auraSpell);
                    continue;
                }

                SpellAreaMapBounds saBound2 = GetSpellAreaMapBounds(spellArea.auraSpell);
                for (SpellAreaMap::const_iterator itr2 = saBound2.first; itr2 != saBound2.second; ++itr2)
                {
                    if (itr2->second.autocast && itr2->second.auraSpell > 0)
                    {
                        chain = true;
                        break;
                    }
                }

                if (chain)
                {
                    LOG_ERROR("sql.sql", "Spell {} listed in `spell_area` have aura spell ({}) requirement that itself autocast from aura", spell, spellArea.auraSpell);
                    continue;
                }
            }
        }

        if (spellArea.raceMask && (spellArea.raceMask & RACEMASK_ALL_PLAYABLE) == 0)
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_area` have wrong race mask ({}) requirement", spell, spellArea.raceMask);
            continue;
        }

        if (spellArea.gender != GENDER_NONE && spellArea.gender != GENDER_FEMALE && spellArea.gender != GENDER_MALE)
        {
            LOG_ERROR("sql.sql", "Spell {} listed in `spell_area` have wrong gender ({}) requirement", spell, spellArea.gender);
            continue;
        }

        SpellArea const* sa = &mSpellAreaMap.insert(SpellAreaMap::value_type(spell, spellArea))->second;

        // for search by current zone/subzone at zone/subzone change
        if (spellArea.areaId)
            mSpellAreaForAreaMap.insert(SpellAreaForAreaMap::value_type(spellArea.areaId, sa));

        // for search at quest start/reward
        if (spellArea.questStart)
            mSpellAreaForQuestMap.insert(SpellAreaForQuestMap::value_type(spellArea.questStart, sa));

        // for search at quest start/reward
        if (spellArea.questEnd)
            mSpellAreaForQuestEndMap.insert(SpellAreaForQuestMap::value_type(spellArea.questEnd, sa));

        // for search at aura apply
        if (spellArea.auraSpell)
            mSpellAreaForAuraMap.insert(SpellAreaForAuraMap::value_type(std::abs(spellArea.auraSpell), sa));

        ++count;
    } while (result->NextRow());

    if (sWorld->getIntConfig(CONFIG_ICC_BUFF_HORDE) > 0)
    {
        LOG_INFO("server.loading", ">> Using ICC Buff Horde: {}", sWorld->getIntConfig(CONFIG_ICC_BUFF_HORDE));
        SpellArea spellAreaICCBuffHorde = { sWorld->getIntConfig(CONFIG_ICC_BUFF_HORDE), ICC_AREA, 0, 0, 0, ICC_RACEMASK_HORDE, Gender(2), 64, 11, 1 };
        SpellArea const* saICCBuffHorde = &mSpellAreaMap.insert(SpellAreaMap::value_type(sWorld->getIntConfig(CONFIG_ICC_BUFF_HORDE), spellAreaICCBuffHorde))->second;
        mSpellAreaForAreaMap.insert(SpellAreaForAreaMap::value_type(ICC_AREA, saICCBuffHorde));
        ++count;
    }
    else
        LOG_INFO("server.loading", ">> ICC Buff Horde: disabled");

    if (sWorld->getIntConfig(CONFIG_ICC_BUFF_ALLIANCE) > 0)
    {
        LOG_INFO("server.loading", ">> Using ICC Buff Alliance: {}", sWorld->getIntConfig(CONFIG_ICC_BUFF_ALLIANCE));
        SpellArea spellAreaICCBuffAlliance = { sWorld->getIntConfig(CONFIG_ICC_BUFF_ALLIANCE), ICC_AREA, 0, 0, 0, ICC_RACEMASK_ALLIANCE, Gender(2), 64, 11, 1 };
        SpellArea const* saICCBuffAlliance = &mSpellAreaMap.insert(SpellAreaMap::value_type(sWorld->getIntConfig(CONFIG_ICC_BUFF_ALLIANCE), spellAreaICCBuffAlliance))->second;
        mSpellAreaForAreaMap.insert(SpellAreaForAreaMap::value_type(ICC_AREA, saICCBuffAlliance));
        ++count;
    }
    else
        LOG_INFO("server.loading", ">> ICC Buff Alliance: disabled");

    LOG_INFO("server.loading", ">> Loaded {} Spell Area Requirements in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellInfoStore()
{
    uint32 oldMSTime = getMSTime();

    UnloadSpellInfoStore();
    mSpellInfoMap.resize(sSpellStore.GetNumRows(), nullptr);

    for (SpellEntry const* spellEntry : sSpellStore)
        mSpellInfoMap[spellEntry->Id] = new SpellInfo(spellEntry);

    for (uint32 spellIndex = 0; spellIndex < GetSpellInfoStoreSize(); ++spellIndex)
    {
        if (!mSpellInfoMap[spellIndex])
            continue;

        for (SpellEffectInfo const& spellEffectInfo : mSpellInfoMap[spellIndex]->GetEffects())
        {
            //ASSERT(effect.EffectIndex < MAX_SPELL_EFFECTS, "MAX_SPELL_EFFECTS must be at least {}", effect.EffectIndex + 1);
            ASSERT(spellEffectInfo.Effect < TOTAL_SPELL_EFFECTS, "TOTAL_SPELL_EFFECTS must be at least {}", spellEffectInfo.Effect + 1);
            ASSERT(spellEffectInfo.ApplyAuraName < TOTAL_AURAS, "TOTAL_AURAS must be at least {}", spellEffectInfo.ApplyAuraName + 1);
            ASSERT(spellEffectInfo.TargetA.GetTarget() < TOTAL_SPELL_TARGETS, "TOTAL_SPELL_TARGETS must be at least {}", spellEffectInfo.TargetA.GetTarget() + 1);
            ASSERT(spellEffectInfo.TargetB.GetTarget() < TOTAL_SPELL_TARGETS, "TOTAL_SPELL_TARGETS must be at least {}", spellEffectInfo.TargetB.GetTarget() + 1);
        }
    }

    LOG_INFO("server.loading", ">> Loaded Spell Custom Attributes in {} ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellCooldownOverrides()
{
    uint32 oldMSTime = getMSTime();

    mSpellCooldownOverrideMap.clear();

    QueryResult result = WorldDatabase.Query("SELECT Id, RecoveryTime, CategoryRecoveryTime, StartRecoveryTime, StartRecoveryCategory FROM spell_cooldown_overrides");

    uint32 count = 0;

    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            SpellCooldownOverride spellCooldown;
            uint32 spellId = fields[0].Get<uint32>();
            spellCooldown.RecoveryTime = fields[1].Get<uint32>();
            spellCooldown.CategoryRecoveryTime = fields[2].Get<uint32>();
            spellCooldown.StartRecoveryTime = fields[3].Get<uint32>();
            spellCooldown.StartRecoveryCategory = fields[4].Get<uint32>();
            mSpellCooldownOverrideMap[spellId] = spellCooldown;

            ++count;
        } while (result->NextRow());
    }

    LOG_INFO("server.loading", ">> Loaded {} Spell Cooldown Overrides entries in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

bool SpellMgr::HasSpellCooldownOverride(uint32 spellId) const
{
    return mSpellCooldownOverrideMap.find(spellId) != mSpellCooldownOverrideMap.end();
}

SpellCooldownOverride SpellMgr::GetSpellCooldownOverride(uint32 spellId) const
{
    auto range = mSpellCooldownOverrideMap.find(spellId);
    return range->second;
}

void SpellMgr::UnloadSpellInfoStore()
{
    for (uint32 i = 0; i < GetSpellInfoStoreSize(); ++i)
        delete mSpellInfoMap[i];

    mSpellInfoMap.clear();
}

void SpellMgr::UnloadSpellInfoImplicitTargetConditionLists()
{
    for (uint32 i = 0; i < GetSpellInfoStoreSize(); ++i)
    {
        if (mSpellInfoMap[i])
            mSpellInfoMap[i]->_UnloadImplicitTargetConditionLists();
    }
}

void SpellMgr::LoadSpellSpecificAndAuraState()
{
    uint32 oldMSTime = getMSTime();

    SpellInfo* spellInfo = nullptr;
    for (uint32 i = 0; i < GetSpellInfoStoreSize(); ++i)
    {
        spellInfo = mSpellInfoMap[i];
        if (!spellInfo)
            continue;
        spellInfo->_spellSpecific = spellInfo->LoadSpellSpecific();
        spellInfo->_auraState = spellInfo->LoadAuraState();
    }

    LOG_INFO("server.loading", ">> Loaded Spell Specific And Aura State in {} ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void SpellMgr::LoadSpellInfoCustomAttributes()
{
    uint32 const oldMSTime = getMSTime();
    uint32 const customAttrTime = getMSTime();
    uint32 count;

    QueryResult result = WorldDatabase.Query("SELECT spell_id, attributes FROM spell_custom_attr");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 Spell Custom Attributes From DB. DB table `spell_custom_attr` Is Empty.");
    }
    else
    {
        for (count = 0; result->NextRow(); ++count)
        {
            Field const* fields = result->Fetch();

            uint32 const spellId = fields[0].Get<uint32>();
            uint32 attributes = fields[1].Get<uint32>();

            SpellInfo* spellInfo = _GetSpellInfo(spellId);
            if (!spellInfo)
            {
                LOG_INFO("sql.sql", "Table `spell_custom_attr` has wrong spell (spell_id: {}), ignored.", spellId);
                continue;
            }

            if (attributes & SPELL_ATTR0_CU_NEGATIVE)
            {
                for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                {
                    if (spellInfo->Effects[i].IsEffect())
                    {
                        if ((attributes & (SPELL_ATTR0_CU_NEGATIVE_EFF0 << i)) && (attributes & (SPELL_ATTR0_CU_POSITIVE_EFF0 << i)))
                        {
                            LOG_ERROR("sql.sql", "Table `spell_custom_attr` has attribute SPELL_ATTR0_CU_NEGATIVE_EFF{} and SPELL_ATTR0_CU_POSITIVE_EFF{} attributes for spell {} which cannot stack together. Attributes will not get applied", static_cast<uint32>(i), static_cast<uint32>(i), spellId);
                            attributes &= ~(SPELL_ATTR0_CU_NEGATIVE_EFF0 << i)|(SPELL_ATTR0_CU_POSITIVE_EFF0 << i);
                        }
                        continue;
                    }

                    if (attributes & (SPELL_ATTR0_CU_NEGATIVE_EFF0 << i))
                    {
                        LOG_ERROR("sql.sql", "Table `spell_custom_attr` has attribute SPELL_ATTR0_CU_NEGATIVE_EFF{} for spell {} with no EFFECT_{}", static_cast<uint32>(i), spellId, static_cast<uint32>(i));
                        attributes &= ~(SPELL_ATTR0_CU_NEGATIVE_EFF0 << i);
                    }
                }
            }

            if (attributes & SPELL_ATTR0_CU_POSITIVE)
            {
                for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                {
                    if (spellInfo->Effects[i].IsEffect())
                    {
                        continue;
                    }

                    if ((attributes & (SPELL_ATTR0_CU_POSITIVE_EFF0 << i)))
                    {
                        LOG_ERROR("sql.sql", "Table `spell_custom_attr` has attribute SPELL_ATTR0_CU_POSITIVE_EFF{} for spell {} with no EFFECT_{}", uint32(i), spellId, uint32(i));
                        attributes &= ~(SPELL_ATTR0_CU_POSITIVE_EFF0 << i);
                    }
                }
            }

            if ((attributes & SPELL_ATTR0_CU_FORCE_AURA_SAVING) && (attributes & SPELL_ATTR0_CU_AURA_CANNOT_BE_SAVED))
            {
                LOG_ERROR("sql.sql", "Table `spell_custom_attr` attribute1 field has attributes SPELL_ATTR1_CU_FORCE_AURA_SAVING and SPELL_ATTR0_CU_AURA_CANNOT_BE_SAVED which cannot stack for spell {}. Both attributes will be ignored.", spellId);
                attributes &= ~(SPELL_ATTR0_CU_FORCE_AURA_SAVING | SPELL_ATTR0_CU_AURA_CANNOT_BE_SAVED);
            }

            spellInfo->AttributesCu |= attributes;
        }
        LOG_INFO("server.loading", ">> Loaded {} spell custom attributes from DB in {} ms", count, GetMSTimeDiffToNow(customAttrTime));
    }

    // xinef: create talent spells set
    for (uint32 i = 0; i < sTalentStore.GetNumRows(); ++i)
    {
        TalentEntry const* talentInfo = sTalentStore.LookupEntry(i);
        if (!talentInfo)
            continue;

        for (uint8 j = 0; j < MAX_TALENT_RANK; j++)
            if (uint32 spellId = talentInfo->RankID[j])
                if (SpellInfo const* spellInfo = GetSpellInfo(spellId))
                    for (uint8 k = 0; k < MAX_SPELL_EFFECTS; ++k)
                        if (spellInfo->Effects[k].Effect == SPELL_EFFECT_LEARN_SPELL)
                            if (SpellInfo const* learnSpell = GetSpellInfo(spellInfo->Effects[k].TriggerSpell))
                                if (learnSpell->IsRanked() && !learnSpell->HasAttribute(SpellAttr0(SPELL_ATTR0_PASSIVE | SPELL_ATTR0_DO_NOT_DISPLAY)))
                                    mTalentSpellAdditionalSet.insert(learnSpell->Id);
    }

    SpellInfo* spellInfo = nullptr;
    for (uint32 i = 0; i < GetSpellInfoStoreSize(); ++i)
    {
        spellInfo = mSpellInfoMap[i];
        if (!spellInfo)
            continue;

        for (uint8 j = 0; j < MAX_SPELL_EFFECTS; ++j)
        {
            switch (spellInfo->Effects[j].ApplyAuraName)
            {
                case SPELL_AURA_MOD_INVISIBILITY:
                {
                    switch (spellInfo->Id)
                    {
                        // Exceptions
                        case 44801: // Spectral Invisibility (Kalecgos, SWP)
                        case 46021: // Spectral Realm (SWP)
                            break;
                        default:
                            spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CAST;
                            break;
                    }
                }
                break;
                case SPELL_AURA_PERIODIC_HEAL:
                case SPELL_AURA_PERIODIC_DAMAGE:
                case SPELL_AURA_PERIODIC_DAMAGE_PERCENT:
                case SPELL_AURA_PERIODIC_LEECH:
                case SPELL_AURA_PERIODIC_MANA_LEECH:
                case SPELL_AURA_PERIODIC_HEALTH_FUNNEL:
                case SPELL_AURA_PERIODIC_ENERGIZE:
                case SPELL_AURA_OBS_MOD_HEALTH:
                case SPELL_AURA_OBS_MOD_POWER:
                case SPELL_AURA_POWER_BURN:
                case SPELL_AURA_TRACK_CREATURES:
                case SPELL_AURA_MOD_RANGED_HASTE:
                case SPELL_AURA_MOD_POSSESS_PET:
                case SPELL_AURA_MOD_INVISIBILITY_DETECT:
                case SPELL_AURA_WATER_BREATHING:
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_NO_INITIAL_THREAT;
                    break;
            }

            switch (spellInfo->Effects[j].ApplyAuraName)
            {
                case SPELL_AURA_CONVERT_RUNE:   // Can't be saved - aura handler relies on calculated amount and changes it
                case SPELL_AURA_OPEN_STABLE:    // No point in saving this, since the stable dialog can't be open on aura load anyway.
                // Auras that require both caster & target to be in world cannot be saved
                case SPELL_AURA_CONTROL_VEHICLE:
                case SPELL_AURA_BIND_SIGHT:
                case SPELL_AURA_MOD_POSSESS:
                case SPELL_AURA_MOD_POSSESS_PET:
                case SPELL_AURA_MOD_CHARM:
                case SPELL_AURA_AOE_CHARM:
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_AURA_CANNOT_BE_SAVED;
                    break;
                default:
                    break;
            }

            switch (spellInfo->Effects[j].ApplyAuraName)
            {
                case SPELL_AURA_MOD_POSSESS:
                case SPELL_AURA_MOD_CONFUSE:
                case SPELL_AURA_MOD_CHARM:
                case SPELL_AURA_AOE_CHARM:
                case SPELL_AURA_MOD_FEAR:
                case SPELL_AURA_MOD_STUN:
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_AURA_CC;
                    break;
                case SPELL_AURA_BIND_SIGHT:
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_NO_PVP_FLAG;
                    break;
                default:
                    break;
            }

            switch (spellInfo->Effects[j].Effect)
            {
                case SPELL_EFFECT_SCHOOL_DAMAGE:
                case SPELL_EFFECT_WEAPON_DAMAGE:
                case SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL:
                case SPELL_EFFECT_NORMALIZED_WEAPON_DMG:
                case SPELL_EFFECT_WEAPON_PERCENT_DAMAGE:
                case SPELL_EFFECT_HEAL:
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_DIRECT_DAMAGE;
                    break;
                case SPELL_EFFECT_POWER_DRAIN:
                case SPELL_EFFECT_POWER_BURN:
                case SPELL_EFFECT_HEAL_MAX_HEALTH:
                case SPELL_EFFECT_HEALTH_LEECH:
                case SPELL_EFFECT_HEAL_PCT:
                case SPELL_EFFECT_ENERGIZE_PCT:
                case SPELL_EFFECT_ENERGIZE:
                case SPELL_EFFECT_HEAL_MECHANICAL:
                case SPELL_EFFECT_CREATE_ITEM:
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_NO_INITIAL_THREAT;
                    break;
                case SPELL_EFFECT_CHARGE:
                case SPELL_EFFECT_CHARGE_DEST:
                case SPELL_EFFECT_JUMP:
                case SPELL_EFFECT_JUMP_DEST:
                case SPELL_EFFECT_LEAP_BACK:
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_CHARGE;
                    break;
                case SPELL_EFFECT_PICKPOCKET:
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_PICKPOCKET;
                    break;
                case SPELL_EFFECT_ENCHANT_ITEM:
                case SPELL_EFFECT_ENCHANT_ITEM_TEMPORARY:
                case SPELL_EFFECT_ENCHANT_ITEM_PRISMATIC:
                case SPELL_EFFECT_ENCHANT_HELD_ITEM:
                    {
                        // only enchanting profession enchantments procs can stack
                        if (IsPartOfSkillLine(SKILL_ENCHANTING, i))
                        {
                            uint32 enchantId = spellInfo->Effects[j].MiscValue;
                            SpellItemEnchantmentEntry const* enchant = sSpellItemEnchantmentStore.LookupEntry(enchantId);
                            for (uint8 s = 0; s < MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS; ++s)
                            {
                                if (enchant->type[s] != ITEM_ENCHANTMENT_TYPE_COMBAT_SPELL)
                                    continue;

                                SpellInfo* procInfo = _GetSpellInfo(enchant->spellid[s]);
                                if (!procInfo)
                                    continue;

                                // if proced directly from enchantment, not via proc aura
                                // NOTE: Enchant Weapon - Blade Ward also has proc aura spell and is proced directly
                                // however its not expected to stack so this check is good
                                if (procInfo->HasAura(SPELL_AURA_PROC_TRIGGER_SPELL))
                                    continue;

                                procInfo->AttributesCu |= SPELL_ATTR0_CU_ENCHANT_PROC;
                            }
                        }
                        break;
                    }
            }
        }

        // Xinef: spells ignoring hit result should not be binary
        if (!spellInfo->HasAttribute(SPELL_ATTR3_ALWAYS_HIT))
        {
            for (uint8 j = 0; j < MAX_SPELL_EFFECTS; ++j)
            {
                if (spellInfo->Effects[j].Effect)
                {
                    switch(spellInfo->Effects[j].Effect)
                    {
                        case SPELL_EFFECT_SCHOOL_DAMAGE:
                        case SPELL_EFFECT_WEAPON_DAMAGE:
                        case SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL:
                        case SPELL_EFFECT_NORMALIZED_WEAPON_DMG:
                        case SPELL_EFFECT_WEAPON_PERCENT_DAMAGE:
                        case SPELL_EFFECT_TRIGGER_SPELL:
                        case SPELL_EFFECT_TRIGGER_SPELL_WITH_VALUE:
                            continue;
                        case SPELL_EFFECT_PERSISTENT_AREA_AURA:
                        case SPELL_EFFECT_APPLY_AURA:
                        case SPELL_EFFECT_APPLY_AREA_AURA_PARTY:
                        case SPELL_EFFECT_APPLY_AREA_AURA_RAID:
                        case SPELL_EFFECT_APPLY_AREA_AURA_FRIEND:
                        case SPELL_EFFECT_APPLY_AREA_AURA_ENEMY:
                        case SPELL_EFFECT_APPLY_AREA_AURA_PET:
                        case SPELL_EFFECT_APPLY_AREA_AURA_OWNER:
                            if (spellInfo->Effects[j].ApplyAuraName == SPELL_AURA_PERIODIC_DAMAGE ||
                                    spellInfo->Effects[j].ApplyAuraName == SPELL_AURA_PERIODIC_DAMAGE_PERCENT ||
                                    spellInfo->Effects[j].ApplyAuraName == SPELL_AURA_DUMMY ||
                                    spellInfo->Effects[j].ApplyAuraName == SPELL_AURA_PERIODIC_LEECH ||
                                    spellInfo->Effects[j].ApplyAuraName == SPELL_AURA_PERIODIC_HEALTH_FUNNEL ||
                                    spellInfo->Effects[j].ApplyAuraName == SPELL_AURA_PERIODIC_DUMMY)
                                continue;
                            [[fallthrough]]; /// @todo: Not sure whether the fallthrough was a mistake (forgetting a break) or intended. This should be double-checked.
                        default:
                            if (spellInfo->Effects[j].CalcValue() || ((spellInfo->Effects[j].Effect == SPELL_EFFECT_INTERRUPT_CAST || spellInfo->HasAttribute(SPELL_ATTR0_CU_DONT_BREAK_STEALTH)) && !spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES)))
                                if (spellInfo->Id != 69649 && spellInfo->Id != 71056 && spellInfo->Id != 71057 && spellInfo->Id != 71058 && spellInfo->Id != 73061 && spellInfo->Id != 73062 && spellInfo->Id != 73063 && spellInfo->Id != 73064) // Sindragosa Frost Breath
                                    if (spellInfo->SpellFamilyName != SPELLFAMILY_MAGE || !(spellInfo->SpellFamilyFlags[0] & 0x20)) // frostbolt
                                        if (spellInfo->Id != 55095) // frost fever
                                            if (spellInfo->SpellFamilyName != SPELLFAMILY_WARLOCK || !(spellInfo->SpellFamilyFlags[1] & 0x40000)) // Haunt
                                            {
                                                spellInfo->AttributesCu |= SPELL_ATTR0_CU_BINARY_SPELL;
                                                break;
                                            }
                            continue;
                    }
                }
            }
        }

        // pussywizard:
        if ((spellInfo->SchoolMask & SPELL_SCHOOL_MASK_NORMAL) && (spellInfo->SchoolMask & SPELL_SCHOOL_MASK_MAGIC))
        {
            spellInfo->SchoolMask &= ~SPELL_SCHOOL_MASK_NORMAL;
            spellInfo->AttributesCu |= SPELL_ATTR0_CU_SCHOOLMASK_NORMAL_WITH_MAGIC;
        }

        if (!spellInfo->_IsPositiveEffect(EFFECT_0, false))
            spellInfo->AttributesCu |= SPELL_ATTR0_CU_NEGATIVE_EFF0;

        if (!spellInfo->_IsPositiveEffect(EFFECT_1, false))
            spellInfo->AttributesCu |= SPELL_ATTR0_CU_NEGATIVE_EFF1;

        if (!spellInfo->_IsPositiveEffect(EFFECT_2, false))
            spellInfo->AttributesCu |= SPELL_ATTR0_CU_NEGATIVE_EFF2;

        if (spellInfo->SpellVisual[0] == 3879)
            spellInfo->AttributesCu |= SPELL_ATTR0_CU_CONE_BACK;

        switch (spellInfo->SpellFamilyName)
        {
            case SPELLFAMILY_WARRIOR:
                // Shout
                if (spellInfo->SpellFamilyFlags[0] & 0x20000 || spellInfo->SpellFamilyFlags[1] & 0x20)
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_AURA_CC;
                break;
            case SPELLFAMILY_DRUID:
                // Roar
                if (spellInfo->SpellFamilyFlags[0] & 0x8)
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_AURA_CC;
                break;
            case SPELLFAMILY_HUNTER:
                // Aspects
                if (spellInfo->GetCategory() == 47)
                {
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_NO_INITIAL_THREAT;
                }
                // Aimed Shot
                if (spellInfo->SpellFamilyFlags[0] & 0x00020000)
                {
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_FORCE_SEND_CATEGORY_COOLDOWNS;
                }
                break;
            default:
                break;
        }

        switch (spellInfo->Id)
        {
            // Xinef: additional spells which should be binary
            case 45145: // Snake Trap Effect
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_BINARY_SPELL;
                break;
            case 1776: // Gouge
            case 1777:
            case 8629:
            case 11285:
            case 11286:
            case 12540:
            case 13579:
            case 24698:
            case 28456:
            case 29425:
            case 34940:
            case 36862:
            case 38764:
            case 38863:
            case 52743: // Head Smack
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_REQ_TARGET_FACING_CASTER;
                break;
            case 53: // Backstab
            case 2589:
            case 2590:
            case 2591:
            case 7159:
            case 8627:
            case 8721:
            case 11279:
            case 11280:
            case 11281:
            case 15582:
            case 15657:
            case 22416:
            case 25300:
            case 26863:
            case 37685:
            case 48656:
            case 48657:
            case 703: // Garrote
            case 8631:
            case 8632:
            case 8633:
            case 11289:
            case 11290:
            case 26839:
            case 26884:
            case 48675:
            case 48676:
            case 5221: // Shred
            case 6800:
            case 8992:
            case 9829:
            case 9830:
            case 27001:
            case 27002:
            case 48571:
            case 48572:
            case 8676: // Ambush
            case 8724:
            case 8725:
            case 11267:
            case 11268:
            case 11269:
            case 27441:
            case 48689:
            case 48690:
            case 48691:
            case 6785: // Ravage
            case 6787:
            case 9866:
            case 9867:
            case 27005:
            case 48578:
            case 48579:
            case 21987: // Lash of Pain
            case 23959: // Test Stab R50
            case 24825: // Test Backstab
            case 58563: // Assassinate Restless Lookout
            case 63124: // quest There's Something About the Squire (13654)
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_REQ_CASTER_BEHIND_TARGET;
                break;
            case 26029: // Dark Glare
            case 43140: // Flame Breath
            case 43215: // Flame Breath
            case 70461: // Coldflame Trap
            case 72133: // Pain and Suffering
            case 73788: // Pain and Suffering
            case 73789: // Pain and Suffering
            case 73790: // Pain and Suffering
            case 63293: // Mimiron - spinning damage
            case 68873: // Wailing Souls
            case 70324: // Wailing Souls
            case 64619: // Ulduar, Mimiron, Emergency Fire Bot, Water Spray
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_CONE_LINE;
                break;
            case 58690: // Cyanigosa, Tail Sweep
            case 59283: // Cyanigosa, Tail Sweep
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_CONE_BACK;
                break;
            case 24340: // Meteor
            case 26558: // Meteor
            case 28884: // Meteor
            case 36837: // Meteor
            case 38903: // Meteor
            case 41276: // Meteor
            case 57467: // Meteor
            case 26789: // Shard of the Fallen Star
            case 31436: // Malevolent Cleave
            case 35181: // Dive Bomb
            case 40810: // Saber Lash
            case 43267: // Saber Lash
            case 43268: // Saber Lash
            case 42384: // Brutal Swipe
            case 45150: // Meteor Slash
            case 64688: // Sonic Screech
            case 72373: // Shared Suffering
            case 71904: // Chaos Bane
            case 70492: // Ooze Eruption
            case 72505: // Ooze Eruption
            case 72624: // Ooze Eruption
            case 72625: // Ooze Eruption
            // ONLY SPELLS WITH SPELLFAMILY_GENERIC and EFFECT_SCHOOL_DAMAGE, OR WEAPON_DMG_X
            case 66809: // Meteor Fists
            case 67331: // Meteor Fists
            case 66765: // Meteor Fists
            case 67333: // Meteor Fists
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_SHARE_DAMAGE;
                break;
            case 18500: // Wing Buffet
            case 33086: // Wild Bite
            case 49749: // Piercing Blow
            case 52890: // Penetrating Strike
            case 53454: // Impale
            case 59446: // Impale
            case 62383: // Shatter
            case 64777: // Machine Gun
            case 65239: // Machine Gun
            case 69293: // Wing Buffet
            case 74439: // Machine Gun
            // Trial of the Crusader, Jaraxxus, Shivan Slash
            case 66378:
            case 67097:
            case 67098:
            case 67099:
            // Trial of the Crusader, Anub'arak, Impale
            case 65919:
            case 67858:
            case 67859:
            case 67860:
            case 63278: // Mark of the Faceless (General Vezax)
            case 64125: // Ulduar, Yogg-Saron, Squeeze
            case 64126: // Ulduar, Yogg-Saron, Squeeze
            case 62544: // Thrust (Argent Tournament)
            case 64588: // Thrust (Argent Tournament)
            case 66479: // Thrust (Argent Tournament)
            case 68505: // Thrust (Argent Tournament)
            case 62709: // Counterattack! (Argent Tournament)
            case 62626: // Break-Shield (Argent Tournament, Player)
            case 64590: // Break-Shield (Argent Tournament, Player)
            case 64342: // Break-Shield (Argent Tournament, NPC)
            case 64686: // Break-Shield (Argent Tournament, NPC)
            case 65147: // Break-Shield (Argent Tournament, NPC)
            case 68504: // Break-Shield (Argent Tournament, NPC)
            case 62874: // Charge (Argent Tournament, Player)
            case 68498: // Charge (Argent Tournament, Player)
            case 64591: // Charge (Argent Tournament, Player)
            case 63003: // Charge (Argent Tournament, NPC)
            case 63010: // Charge (Argent Tournament, NPC)
            case 68321: // Charge (Argent Tournament, NPC)
            case 72255: // Mark of the Fallen Champion (Deathbringer Saurfang)
            case 72444: // Mark of the Fallen Champion (Deathbringer Saurfang)
            case 72445: // Mark of the Fallen Champion (Deathbringer Saurfang)
            case 72446: // Mark of the Fallen Champion (Deathbringer Saurfang)
            case 72409: // Rune of Blood (Deathbringer Saurfang)
            case 72447: // Rune of Blood (Deathbringer Saurfang)
            case 72448: // Rune of Blood (Deathbringer Saurfang)
            case 72449: // Rune of Blood (Deathbringer Saurfang)
            case 49882: // Leviroth Self-Impale
            case 62775: // Ulduar: XT-002 Tympanic Tamparum
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_IGNORE_ARMOR;
                break;
            case 64422: // Sonic Screech (Auriaya)
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_SHARE_DAMAGE;
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_IGNORE_ARMOR;
                break;
            case 72293: // Mark of the Fallen Champion (Deathbringer Saurfang)
            case 72347: // Lock Players and Tap Chest (Gunship Battle)
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_NEGATIVE_EFF0;
                break;
            default:
                break;
            case 63675: // Improved Devouring Plague
            case 17962: // Conflagrate
            case 32593: // Earth Shield aura
            case 32594: // Earth Shield aura
            case 49283: // Earth Shield aura
            case 49284: // Earth Shield aura
            case 50526: // Wandering Plague
            case 53353: // Chimera Shot - Serpent trigger
            case 52752: // Ancestral Awakening Heal
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_NO_POSITIVE_TAKEN_BONUS;
                break;
            case 65280: // Ulduar, Hodir, Singed
            case 28969: // Naxxramas, Crypt Guard, Acid Spit (10 normal)
            case 56098: // Naxxramas, Crypt Guard, Acid Spit (25 normal)
            case 27891: // Naxxramas, Sludge Belcher, Acidic Sludge (10 normal)
            case 54331: // Naxxramas, Sludge Belcher, Acidic Sludge (25 normal)
            case 29325: // Naxxramas, Stoneskin Gargoyle, Acid Volley (10 normal)
            case 54714: // Naxxramas, Stoneskin Gargoyle, Acid Volley (25 normal)
            case 65775: // Anub'arak, Swarm Scarab, Acid-Drenched Mandibles (10 normal)
            case 67861: // Anub'arak, Swarm Scarab, Acid-Drenched Mandibles (25 normal)
            case 67862: // Anub'arak, Swarm Scarab, Acid-Drenched Mandibles (10 heroic)
            case 67863: // Anub'arak, Swarm Scarab, Acid-Drenched Mandibles (25 heroic)
            case 55604: // Naxxramas, Unrelenting Trainee, Death Plague (10 normal)
            case 55645: // Naxxramas, Unrelenting Trainee, Death Plague (25 normal)
            case 67721: // Anub'arak, Nerubian Burrower, Expose Weakness (normal)
            case 67847: // Anub'arak, Nerubian Burrower, Expose Weakness (heroic)
            case 64638: // Ulduar, Winter Jormungar, Acidic Bite
            case 71157: // Icecrown Citadel, Plagued Zombie, Infected Wound
            case 72963: // Icecrown Citadel, Rot Worm, Flesh Rot (10 normal)
            case 72964: // Icecrown Citadel, Rot Worm, Flesh Rot (25 normal)
            case 72965: // Icecrown Citadel, Rot Worm, Flesh Rot (10 heroic)
            case 72966: // Icecrown Citadel, Rot Worm, Flesh Rot (25 heroic)
            case 72465: // Icecrown Citadel, Sindragosa, Respite for a Tormented Soul (weekly quest)
            case 45271: // Sunwell, Eredar Twins encounter, Dark Strike
            case 45347: // Sunwell, Eredar Twins encounter, Dark Touched
            case 45348: // Sunwell, Eredar Twins encounter, Flame Touched
            case 35859: // The Eye, Nether Vapor
            case 40520: // Black Temple, Shade Soul Channel
            case 40327: // Black Temple, Atrophy
            case 38449: // Serpentshrine Cavern, Blessing of the Tides
            case 38044: // Serpentshrine Cavern, Surge
            case 74507: // Ruby Sanctum, Siphoned Might
            case 49381: // Drak'tharon Keep, Consume
            case 59805: // Drak'tharon Keep, Consume
            case 55093: // Gundrak, Grip of Slad'ran
            case 30659: // Hellfire Ramparts, Fel Infusion
            case 54314: // Azjol'Nerub Drain Power
            case 59354: // Azjol'Nerub Drain Power
            case 34655: // Snake Trap, Deadly Poison
            case 11971: // Sunder Armor
            case 58567: // Player Sunder Armor
            case 12579: // Player Winter's Chill
            case 29306: // Naxxramas(Gluth's Zombies): Infected Wound
            case 61920: // Ulduar(Spellbreaker): Supercharge
            case 63978: // Ulduar(Rubble): Stone Nova
            case 15502: // Sunder Armor
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_SINGLE_AURA_STACK;
                break;
            case 43138: // North Fleet Reservist Kill Credit
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_ALLOW_INFLIGHT_TARGET;
                break;
            case 6197: // Eagle Eye
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_NO_INITIAL_THREAT;
                break;
            case 50315: // Disco Ball
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_NO_PVP_FLAG;
                break;
            case 14183: // Premeditation
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_DONT_BREAK_STEALTH;
                break;

            // Xinef: NOT CUSTOM, cant add in DBC CORRECTION because i need to swap effects, too much work to do there
            // Envenom
            case 32645:
            case 32684:
            case 57992:
            case 57993:
                {
                    SpellEffectInfo info = spellInfo->Effects[EFFECT_0];
                    spellInfo->Effects[EFFECT_0] = spellInfo->Effects[EFFECT_2];
                    spellInfo->Effects[EFFECT_2] = info;
                    break;
                }

            // Xinef: Cooldown overwrites
            // Jotunheim Rapid-Fire Harpoon: Energy Reserve
            case 56585:
                spellInfo->RecoveryTime = 30000;
                spellInfo->_requireCooldownInfo = true;
                break;
            // Jotunheim Rapid-Fire Harpoon: Rapid-Fire Harpoon
            case 56570:
                spellInfo->RecoveryTime = 200;
                break;
            // Burst of Speed
            case 57493:
                spellInfo->RecoveryTime = 60000;
                spellInfo->_requireCooldownInfo = true;
                break;
            // Strafe Jotunheim Building
            case 7769:
                spellInfo->RecoveryTime = 1500;
                spellInfo->_requireCooldownInfo = true;
                break;
            case 44535: // Spirit Heal, abilities also have no cost
                spellInfo->Effects[EFFECT_0].MiscValue = 127;
                break;
            case 45537: // Cosmetic - Lightning Beam Channel
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_IGNORE_EVADE;
                break;
        }

        if (spellInfo->Speed > 0.0f)
        {
            if (SpellVisualEntry const* spellVisual = sSpellVisualStore.LookupEntry(spellInfo->SpellVisual[0]))
            {
                if (spellVisual->HasMissile)
                {
                    if (spellVisual->MissileModel == -4 || spellVisual->MissileModel == -5)
                    {
                        spellInfo->AttributesCu |= SPELL_ATTR0_CU_NEEDS_AMMO_DATA;
                    }
                }
            }
        }

        spellInfo->_InitializeExplicitTargetMask();

        if (sSpellMgr->HasSpellCooldownOverride(spellInfo->Id))
        {
            SpellCooldownOverride spellOverride = sSpellMgr->GetSpellCooldownOverride(spellInfo->Id);

            if (spellInfo->RecoveryTime != spellOverride.RecoveryTime)
            {
                spellInfo->RecoveryTime = spellOverride.RecoveryTime;
            }

            if (spellInfo->CategoryRecoveryTime != spellOverride.CategoryRecoveryTime)
            {
                spellInfo->CategoryRecoveryTime = spellOverride.CategoryRecoveryTime;
            }

            if (spellInfo->StartRecoveryTime != spellOverride.StartRecoveryTime)
            {
                spellInfo->RecoveryTime = spellOverride.RecoveryTime;
            }

            if (spellInfo->StartRecoveryCategory != spellOverride.StartRecoveryCategory)
            {
                spellInfo->RecoveryTime = spellOverride.RecoveryTime;
            }
        }

        sScriptMgr->OnLoadSpellCustomAttr(spellInfo);
    }

    // Xinef: addition for binary spells, ommit spells triggering other spells
    for (uint32 i = 0; i < GetSpellInfoStoreSize(); ++i)
    {
        spellInfo = mSpellInfoMap[i];
        if (!spellInfo)
            continue;

        if (!(spellInfo->AttributesCu & SPELL_ATTR0_CU_BINARY_SPELL))
            continue;

        bool allNonBinary = true;
        bool overrideAttr = false;
        for (uint8 j = 0; j < MAX_SPELL_EFFECTS; ++j)
        {
            if (spellInfo->Effects[j].ApplyAuraName && spellInfo->Effects[j].TriggerSpell)
            {
                switch(spellInfo->Effects[j].ApplyAuraName)
                {
                    case SPELL_AURA_PERIODIC_TRIGGER_SPELL:
                    case SPELL_AURA_PERIODIC_TRIGGER_SPELL_FROM_CLIENT:
                    case SPELL_AURA_PERIODIC_TRIGGER_SPELL_WITH_VALUE:
                        if (SpellInfo const* triggerSpell = sSpellMgr->GetSpellInfo(spellInfo->Effects[j].TriggerSpell))
                        {
                            overrideAttr = true;
                            if (triggerSpell->AttributesCu & SPELL_ATTR0_CU_BINARY_SPELL)
                                allNonBinary = false;
                        }
                }
            }
        }

        if (overrideAttr && allNonBinary)
            spellInfo->AttributesCu &= ~SPELL_ATTR0_CU_BINARY_SPELL;
    }

    LOG_INFO("server.loading", ">> Loaded SpellInfo Custom Attributes in {} ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}
