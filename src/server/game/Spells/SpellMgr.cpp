/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "BattlefieldMgr.h"
#include "BattlefieldWG.h"
#include "BattlegroundIC.h"
#include "BattlegroundMgr.h"
#include "Chat.h"
#include "CreatureAI.h"
#include "DBCStores.h"
#include "GameGraveyard.h"
#include "InstanceScript.h"
#include "MapManager.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "SharedDefines.h"
#include "Spell.h"
#include "SpellAuraDefines.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
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
        if (itr->second->skillId == skillId)
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
                                LOG_ERROR("sql.sql", "Craft spell %u not have create item entry.", spellInfo->Id);
                            return false;
                        }
                    }
                    // also possible IsLootCrafting case but fake item must exist anyway
                    else if (!sObjectMgr->GetItemTemplate(spellInfo->Effects[i].ItemType))
                    {
                        if (msg)
                            LOG_ERROR("sql.sql", "Craft spell %u create not-exist in DB item (Entry: %u) and then...", spellInfo->Id, spellInfo->Effects[i].ItemType);
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
                            LOG_ERROR("sql.sql", "Spell %u learn to invalid spell %u, and then...", spellInfo->Id, spellInfo->Effects[i].TriggerSpell);
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
                    LOG_ERROR("sql.sql", "Craft spell %u have not-exist reagent in DB item (Entry: %u) and then...", spellInfo->Id, spellInfo->Reagent[j]);
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
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(stmts[i]);
        stmt->setUInt32(0, spellId);
        CharacterDatabase.Execute(stmt);
    }
}

bool SpellMgr::CheckSpellValid(SpellInfo const* spellInfo, uint32 spellId, bool isTalent)
{
    if (!spellInfo)
    {
        DeleteSpellFromAllPlayers(spellId);
        LOG_ERROR("server", "Player::%s: Non-existed in SpellStore spell #%u request.", (isTalent ? "AddTalent" : "addSpell"), spellId);
        return false;
    }

    if (!IsSpellValid(spellInfo))
    {
        DeleteSpellFromAllPlayers(spellId);
        LOG_ERROR("server", "Player::%s: Broken spell #%u learning not allowed.", (isTalent ? "AddTalent" : "addSpell"), spellId);
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
        LOG_ERROR("server", "SpellMgr::GetSpellIdForDifficulty: Incorrect Difficulty for spell %u.", spellId);
        return spellId; //return source spell
    }

    uint32 difficultyId = GetSpellDifficultyId(spellId);
    if (!difficultyId)
        return spellId; //return source spell, it has only REGULAR_DIFFICULTY

    SpellDifficultyEntry const* difficultyEntry = sSpellDifficultyStore.LookupEntry(difficultyId);
    if (!difficultyEntry)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        LOG_DEBUG("spells.aura", "SpellMgr::GetSpellIdForDifficulty: SpellDifficultyEntry not found for spell %u. This should never happen.", spellId);
#endif
        return spellId; //return source spell
    }

    if (difficultyEntry->SpellID[mode] <= 0 && mode > DUNGEON_DIFFICULTY_HEROIC)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        LOG_DEBUG("spells.aura", "SpellMgr::GetSpellIdForDifficulty: spell %u mode %u spell is nullptr, using mode %u", spellId, mode, mode - 2);
#endif
        mode -= 2;
    }

    if (difficultyEntry->SpellID[mode] <= 0)
    {
        LOG_ERROR("sql.sql", "SpellMgr::GetSpellIdForDifficulty: spell %u mode %u spell is 0. Check spelldifficulty_dbc!", spellId, mode);
        return spellId;
    }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("spells.aura", "SpellMgr::GetSpellIdForDifficulty: spellid for spell %u in mode %u is %d", spellId, mode, difficultyEntry->SpellID[mode]);
#endif
    return uint32(difficultyEntry->SpellID[mode]);
}

SpellInfo const* SpellMgr::GetSpellForDifficultyFromSpell(SpellInfo const* spell, Unit const* caster) const
{
    uint32 newSpellId = GetSpellIdForDifficulty(spell->Id, caster);
    SpellInfo const* newSpell = GetSpellInfo(newSpellId);
    if (!newSpell)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        LOG_DEBUG("spells.aura", "SpellMgr::GetSpellForDifficultyFromSpell: spell %u not found. Check spelldifficulty_dbc!", newSpellId);
#endif
        return spell;
    }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("spells.aura", "SpellMgr::GetSpellForDifficultyFromSpell: Spell id for instance mode is %u (original %u)", newSpell->Id, spell->Id);
#endif
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
    // xinef: dunno why i added this
    if (spellid_1 == spellid_2 && remove && !areaAura)
        return SPELL_GROUP_STACK_FLAG_NONE;

    uint32 groupId = GetSpellGroup(spellid_1);
    if (groupId > 0 && groupId == GetSpellGroup(spellid_2))
    {
        SpellGroupSpecialFlags flag1 = GetSpellGroupSpecialFlags(spellid_1);
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

bool SpellMgr::IsSpellProcEventCanTriggeredBy(SpellInfo const* spellProto, SpellProcEventEntry const* spellProcEvent, uint32 EventProcFlag, SpellInfo const* procSpell, uint32 procFlags, uint32 procExtra, bool active) const
{
    // No extra req need
    uint32 procEvent_procEx = PROC_EX_NONE;

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

        // For melee triggers
        if (procSpell == nullptr)
        {
            // Check (if set) for school (melee attack have Normal school)
            if (spellProcEvent->schoolMask && (spellProcEvent->schoolMask & SPELL_SCHOOL_MASK_NORMAL) == 0)
                return false;
        }
        else // For spells need check school/spell family/family mask
        {
            // Check (if set) for school
            if (spellProcEvent->schoolMask && (spellProcEvent->schoolMask & procSpell->SchoolMask) == 0)
                return false;

            // Check (if set) for spellFamilyName
            if (spellProcEvent->spellFamilyName && (spellProcEvent->spellFamilyName != procSpell->SpellFamilyName))
                return false;

            // spellFamilyName is Ok need check for spellFamilyMask if present
            if (spellProcEvent->spellFamilyMask)
            {
                if (!(spellProcEvent->spellFamilyMask & procSpell->SpellFamilyFlags))
                    return false;
                hasFamilyMask = true;
                // Some spells are not considered as active even with have spellfamilyflags
                if (!(procEvent_procEx & PROC_EX_ONLY_ACTIVE_SPELL))
                    active = true;
            }
        }
    }

    if (procExtra & (PROC_EX_INTERNAL_REQ_FAMILY))
    {
        if (!hasFamilyMask)
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
    if (!(eventInfo.GetTypeMask() & procEntry.typeMask))
        return false;

    // check XP or honor target requirement
    if (procEntry.attributesMask & PROC_ATTR_REQ_EXP_OR_HONOR)
        if (Player* actor = eventInfo.GetActor()->ToPlayer())
            if (eventInfo.GetActionTarget() && !actor->isHonorOrXPTarget(eventInfo.GetActionTarget()))
                return false;

    // always trigger for these types
    if (eventInfo.GetTypeMask() & (PROC_FLAG_KILLED | PROC_FLAG_KILL | PROC_FLAG_DEATH))
        return true;

    // check school mask (if set) for other trigger types
    if (procEntry.schoolMask && !(eventInfo.GetSchoolMask() & procEntry.schoolMask))
        return false;

    // check spell family name/flags (if set) for spells
    if (eventInfo.GetTypeMask() & (PERIODIC_PROC_FLAG_MASK | SPELL_PROC_FLAG_MASK | PROC_FLAG_DONE_TRAP_ACTIVATION))
    {
        if (procEntry.spellFamilyName && (procEntry.spellFamilyName != eventInfo.GetSpellInfo()->SpellFamilyName))
            return false;

        if (procEntry.spellFamilyMask && !(procEntry.spellFamilyMask & eventInfo.GetSpellInfo()->SpellFamilyFlags))
            return false;
    }

    // check spell type mask (if set)
    if (eventInfo.GetTypeMask() & (SPELL_PROC_FLAG_MASK | PERIODIC_PROC_FLAG_MASK))
    {
        if (procEntry.spellTypeMask && !(eventInfo.GetSpellTypeMask() & procEntry.spellTypeMask))
            return false;
    }

    // check spell phase mask
    if (eventInfo.GetTypeMask() & REQ_SPELL_PHASE_PROC_FLAG_MASK)
    {
        if (!(eventInfo.GetSpellPhaseMask() & procEntry.spellPhaseMask))
            return false;
    }

    // check hit mask (on taken hit or on done hit, but not on spell cast phase)
    if ((eventInfo.GetTypeMask() & TAKEN_HIT_PROC_FLAG_MASK) || ((eventInfo.GetTypeMask() & DONE_HIT_PROC_FLAG_MASK) && !(eventInfo.GetSpellPhaseMask() & PROC_SPELL_PHASE_CAST)))
    {
        uint32 hitMask = procEntry.hitMask;
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

                if (!sWorld->getBoolConfig(CONFIG_WINTERGRASP_ENABLE))
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
            LOG_ERROR("sql.sql", "SpellMgr::LoadSpellTalentRanks: First Rank Spell %u for TalentEntry %u does not exist.", talentInfo->RankID[0], i);
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
                LOG_ERROR("sql.sql", "SpellMgr::LoadSpellTalentRanks: Spell %u (Rank: %u) for TalentEntry %u does not exist.", spellId, rank + 1, i);
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
        LOG_INFO("server", ">> Loaded 0 spell rank records. DB table `spell_ranks` is empty.");
        LOG_INFO("server", " ");
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

            currentSpell = fields[0].GetUInt32();
            if (lastSpell == -1)
                lastSpell = currentSpell;
            uint32 spell_id = fields[1].GetUInt32();
            uint32 rank = fields[2].GetUInt8();

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
            LOG_ERROR("sql.sql", "Spell rank identifier(first_spell_id) %u listed in `spell_ranks` does not exist!", lastSpell);
            continue;
        }
        // check if chain is long enough
        if (rankChain.size() < 2)
        {
            LOG_ERROR("sql.sql", "There is only 1 spell rank for identifier(first_spell_id) %u in `spell_ranks`, entry is not needed!", lastSpell);
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
                LOG_ERROR("sql.sql", "Spell %u (rank %u) listed in `spell_ranks` for chain %u does not exist!", itr->first, itr->second, lastSpell);
                valid = false;
                break;
            }
            ++curRank;
            if (itr->second != curRank)
            {
                LOG_ERROR("sql.sql", "Spell %u (rank %u) listed in `spell_ranks` for chain %u does not have proper rank value(should be %u)!", itr->first, itr->second, lastSpell, curRank);
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

    LOG_INFO("server", ">> Loaded %u spell rank records in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
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
        LOG_INFO("server", ">> Loaded 0 spell required records. DB table `spell_required` is empty.");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 spellId = fields[0].GetUInt32();
        uint32 spellReq = fields[1].GetUInt32();

        // check if chain is made with valid first spell
        SpellInfo const* spellInfo = GetSpellInfo(spellId);
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "spell_id %u in `spell_required` table is not found in dbcs, skipped", spellId);
            continue;
        }

        SpellInfo const* reqSpellInfo = GetSpellInfo(spellReq);
        if (!reqSpellInfo)
        {
            LOG_ERROR("sql.sql", "req_spell %u in `spell_required` table is not found in dbcs, skipped", spellReq);
            continue;
        }

        if (GetFirstSpellInChain(spellId) == GetFirstSpellInChain(spellReq))
        {
            LOG_ERROR("sql.sql", "req_spell %u and spell_id %u in `spell_required` table are ranks of the same spell, entry not needed, skipped", spellReq, spellId);
            continue;
        }

        if (IsSpellRequiringSpell(spellId, spellReq))
        {
            LOG_ERROR("sql.sql", "duplicated entry of req_spell %u and spell_id %u in `spell_required`, skipped", spellReq, spellId);
            continue;
        }

        mSpellReq.insert (std::pair<uint32, uint32>(spellId, spellReq));
        mSpellsReqSpell.insert (std::pair<uint32, uint32>(spellReq, spellId));
        ++count;

        // xinef: fill additionalTalentInfo data, currently Blessing of Sanctuary only
        if (GetTalentSpellCost(spellReq) > 0)
            mTalentSpellAdditionalSet.insert(spellId);
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %u spell required records in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
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
            if (entry->Effects[i].Effect == SPELL_EFFECT_SKILL)
            {
                SpellLearnSkillNode dbc_node;
                dbc_node.skill = entry->Effects[i].MiscValue;
                dbc_node.step  = entry->Effects[i].CalcValue();
                if (dbc_node.skill != SKILL_RIDING)
                    dbc_node.value = 1;
                else
                    dbc_node.value = dbc_node.step * 75;
                dbc_node.maxvalue = dbc_node.step * 75;
                mSpellLearnSkills[spell] = dbc_node;
                ++dbc_count;
                break;
            }
        }
    }

    LOG_INFO("server", ">> Loaded %u Spell Learn Skills from DBC in %u ms", dbc_count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void SpellMgr::LoadSpellTargetPositions()
{
    uint32 oldMSTime = getMSTime();

    mSpellTargetPositions.clear();                                // need for reload case

    //                                                0      1          2        3         4           5            6
    QueryResult result = WorldDatabase.Query("SELECT ID, EffectIndex, MapID, PositionX, PositionY, PositionZ, Orientation FROM spell_target_position");

    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 spell target coordinates. DB table `spell_target_position` is empty.");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 Spell_ID = fields[0].GetUInt32();

        SpellEffIndex effIndex = SpellEffIndex(fields[1].GetUInt8());

        SpellTargetPosition st;

        st.target_mapId       = fields[2].GetUInt16();
        st.target_X           = fields[3].GetFloat();
        st.target_Y           = fields[4].GetFloat();
        st.target_Z           = fields[5].GetFloat();
        st.target_Orientation = fields[6].GetFloat();

        MapEntry const* mapEntry = sMapStore.LookupEntry(st.target_mapId);
        if (!mapEntry)
        {
            LOG_ERROR("sql.sql", "Spell (Id: %u, effIndex: %u) target map (ID: %u) does not exist in `Map.dbc`.", Spell_ID, effIndex, st.target_mapId);
            continue;
        }

        if (st.target_X == 0 && st.target_Y == 0 && st.target_Z == 0)
        {
            LOG_ERROR("sql.sql", "Spell (Id: %u, effIndex: %u) target coordinates not provided.", Spell_ID, effIndex);
            continue;
        }

        SpellInfo const* spellInfo = GetSpellInfo(Spell_ID);
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Spell (ID:%u) listed in `spell_target_position` does not exist.", Spell_ID);
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
            LOG_ERROR("sql.sql", "Spell (Id: %u, effIndex: %u) listed in `spell_target_position` does not have target TARGET_DEST_DB (17).", Spell_ID, effIndex);
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
    #if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                LOG_DEBUG("spells.aura", "Spell (ID: %u) does not have record in `spell_target_position`", i);
    #endif
        }
    }*/

    LOG_INFO("server", ">> Loaded %u spell teleport coordinates in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void SpellMgr::LoadSpellGroups()
{
    uint32 oldMSTime = getMSTime();

    mSpellGroupMap.clear();                                  // need for reload case

    //                                                0     1            2
    QueryResult result = WorldDatabase.Query("SELECT id, spell_id, special_flag FROM spell_group");
    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 spell group definitions. DB table `spell_group` is empty.");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 group_id = fields[0].GetUInt32();
        int32 spell_id = fields[1].GetUInt32();
        SpellGroupSpecialFlags specialFlag = (SpellGroupSpecialFlags)fields[2].GetUInt32();
        SpellInfo const* spellInfo = GetSpellInfo(spell_id);

        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_group` does not exist", spell_id);
            continue;
        }
        else if (spellInfo->GetRank() > 1)
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_group` is not first rank of spell", spell_id);
            continue;
        }

        if (mSpellGroupMap.find(spell_id) != mSpellGroupMap.end())
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_group` has more than one group", spell_id);
            continue;
        }

        if (specialFlag >= SPELL_GROUP_SPECIAL_FLAG_MAX)
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_group` has invalid special flag!", spell_id);
            continue;
        }

        SpellStackInfo ssi;
        ssi.groupId = group_id;
        ssi.specialFlags = specialFlag;
        mSpellGroupMap[spell_id] = ssi;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %u spell group definitions in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void SpellMgr::LoadSpellGroupStackRules()
{
    uint32 oldMSTime = getMSTime();

    mSpellGroupStackMap.clear();                                  // need for reload case

    //                                                       0         1
    QueryResult result = WorldDatabase.Query("SELECT group_id, stack_rule FROM spell_group_stack_rules");
    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 spell group stack rules. DB table `spell_group_stack_rules` is empty.");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 group_id = fields[0].GetUInt32();
        uint8 stack_rule = fields[1].GetInt8();
        if (stack_rule >= SPELL_GROUP_STACK_FLAG_MAX)
        {
            LOG_ERROR("sql.sql", "SpellGroupStackRule %u listed in `spell_group_stack_rules` does not exist", stack_rule);
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
            LOG_ERROR("sql.sql", "SpellGroup id %u listed in `spell_group_stack_rules` does not exist", group_id);
            continue;
        }

        mSpellGroupStackMap[group_id] = (SpellGroupStackFlags)stack_rule;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %u spell group stack rules in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void SpellMgr::LoadSpellProcEvents()
{
    uint32 oldMSTime = getMSTime();

    mSpellProcEventMap.clear();                             // need for reload case

    //                                                0      1           2                3                 4                 5                 6          7       8        9             10
    QueryResult result = WorldDatabase.Query("SELECT entry, SchoolMask, SpellFamilyName, SpellFamilyMask0, SpellFamilyMask1, SpellFamilyMask2, procFlags, procEx, ppmRate, CustomChance, Cooldown FROM spell_proc_event");
    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 spell proc event conditions. DB table `spell_proc_event` is empty.");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        int32 spellId = fields[0].GetInt32();

        bool allRanks = false;
        if (spellId < 0)
        {
            allRanks = true;
            spellId = -spellId;
        }

        SpellInfo const* spellInfo = GetSpellInfo(spellId);
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_proc_event` does not exist", spellId);
            continue;
        }

        if (allRanks)
        {
            if (!spellInfo->IsRanked())
                LOG_ERROR("sql.sql", "Spell %u listed in `spell_proc_event` with all ranks, but spell has no ranks.", spellId);

            if (spellInfo->GetFirstRankSpell()->Id != uint32(spellId))
            {
                LOG_ERROR("sql.sql", "Spell %u listed in `spell_proc_event` is not first rank of spell.", spellId);
                continue;
            }
        }

        SpellProcEventEntry spellProcEvent;

        spellProcEvent.schoolMask         = fields[1].GetInt8();
        spellProcEvent.spellFamilyName    = fields[2].GetUInt16();
        spellProcEvent.spellFamilyMask[0] = fields[3].GetUInt32();
        spellProcEvent.spellFamilyMask[1] = fields[4].GetUInt32();
        spellProcEvent.spellFamilyMask[2] = fields[5].GetUInt32();
        spellProcEvent.procFlags          = fields[6].GetUInt32();
        spellProcEvent.procEx             = fields[7].GetUInt32();
        spellProcEvent.ppmRate            = fields[8].GetFloat();
        spellProcEvent.customChance       = fields[9].GetFloat();
        spellProcEvent.cooldown           = fields[10].GetUInt32();

        while (spellInfo)
        {
            if (mSpellProcEventMap.find(spellInfo->Id) != mSpellProcEventMap.end())
            {
                LOG_ERROR("sql.sql", "Spell %u listed in `spell_proc_event` already has its first rank in table.", spellInfo->Id);
                break;
            }

            if (!spellInfo->ProcFlags && !spellProcEvent.procFlags)
                LOG_ERROR("sql.sql", "Spell %u listed in `spell_proc_event` probally not triggered spell", spellInfo->Id);

            mSpellProcEventMap[spellInfo->Id] = spellProcEvent;

            if (allRanks)
                spellInfo = spellInfo->GetNextRankSpell();
            else
                break;
        }

        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %u extra spell proc event conditions in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void SpellMgr::LoadSpellProcs()
{
    uint32 oldMSTime = getMSTime();

    mSpellProcMap.clear();                             // need for reload case

    //                                                 0        1           2                3                 4                 5                 6         7              8               9        10              11             12      13        14
    QueryResult result = WorldDatabase.Query("SELECT spellId, schoolMask, spellFamilyName, spellFamilyMask0, spellFamilyMask1, spellFamilyMask2, typeMask, spellTypeMask, spellPhaseMask, hitMask, attributesMask, ratePerMinute, chance, cooldown, charges FROM spell_proc");
    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 spell proc conditions and data. DB table `spell_proc` is empty.");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        int32 spellId = fields[0].GetInt32();

        bool allRanks = false;
        if (spellId < 0)
        {
            allRanks = true;
            spellId = -spellId;
        }

        SpellInfo const* spellInfo = GetSpellInfo(spellId);
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_proc` does not exist", spellId);
            continue;
        }

        if (allRanks)
        {
            if (spellInfo->GetFirstRankSpell()->Id != uint32(spellId))
            {
                LOG_ERROR("sql.sql", "Spell %u listed in `spell_proc` is not first rank of spell.", fields[0].GetInt32());
                continue;
            }
        }

        SpellProcEntry baseProcEntry;

        baseProcEntry.schoolMask      = fields[1].GetInt8();
        baseProcEntry.spellFamilyName = fields[2].GetUInt16();
        baseProcEntry.spellFamilyMask[0] = fields[3].GetUInt32();
        baseProcEntry.spellFamilyMask[1] = fields[4].GetUInt32();
        baseProcEntry.spellFamilyMask[2] = fields[5].GetUInt32();
        baseProcEntry.typeMask        = fields[6].GetUInt32();
        baseProcEntry.spellTypeMask   = fields[7].GetUInt32();
        baseProcEntry.spellPhaseMask  = fields[8].GetUInt32();
        baseProcEntry.hitMask         = fields[9].GetUInt32();
        baseProcEntry.attributesMask  = fields[10].GetUInt32();
        baseProcEntry.ratePerMinute   = fields[11].GetFloat();
        baseProcEntry.chance          = fields[12].GetFloat();
        float cooldown                = fields[13].GetFloat();
        baseProcEntry.cooldown        = uint32(cooldown);
        baseProcEntry.charges         = fields[14].GetUInt32();

        while (spellInfo)
        {
            if (mSpellProcMap.find(spellInfo->Id) != mSpellProcMap.end())
            {
                LOG_ERROR("sql.sql", "Spell %u listed in `spell_proc` has duplicate entry in the table", spellId);
                break;
            }
            SpellProcEntry procEntry = SpellProcEntry(baseProcEntry);

            // take defaults from dbcs
            if (!procEntry.typeMask)
                procEntry.typeMask = spellInfo->ProcFlags;
            if (!procEntry.charges)
                procEntry.charges = spellInfo->ProcCharges;
            if (!procEntry.chance && !procEntry.ratePerMinute)
                procEntry.chance = float(spellInfo->ProcChance);

            // validate data
            if (procEntry.schoolMask & ~SPELL_SCHOOL_MASK_ALL)
                LOG_ERROR("sql.sql", "`spell_proc` table entry for spellId %u has wrong `schoolMask` set: %u", spellId, procEntry.schoolMask);
            if (procEntry.spellFamilyName && (procEntry.spellFamilyName < 3 || procEntry.spellFamilyName > 17 || procEntry.spellFamilyName == 14 || procEntry.spellFamilyName == 16))
                LOG_ERROR("sql.sql", "`spell_proc` table entry for spellId %u has wrong `spellFamilyName` set: %u", spellId, procEntry.spellFamilyName);
            if (procEntry.chance < 0)
            {
                LOG_ERROR("sql.sql", "`spell_proc` table entry for spellId %u has negative value in `chance` field", spellId);
                procEntry.chance = 0;
            }
            if (procEntry.ratePerMinute < 0)
            {
                LOG_ERROR("sql.sql", "`spell_proc` table entry for spellId %u has negative value in `ratePerMinute` field", spellId);
                procEntry.ratePerMinute = 0;
            }
            if (cooldown < 0)
            {
                LOG_ERROR("sql.sql", "`spell_proc` table entry for spellId %u has negative value in `cooldown` field", spellId);
                procEntry.cooldown = 0;
            }
            if (procEntry.chance == 0 && procEntry.ratePerMinute == 0)
                LOG_ERROR("sql.sql", "`spell_proc` table entry for spellId %u doesn't have `chance` and `ratePerMinute` values defined, proc will not be triggered", spellId);
            if (procEntry.charges > 99)
            {
                LOG_ERROR("sql.sql", "`spell_proc` table entry for spellId %u has too big value in `charges` field", spellId);
                procEntry.charges = 99;
            }
            if (!procEntry.typeMask)
                LOG_ERROR("sql.sql", "`spell_proc` table entry for spellId %u doesn't have `typeMask` value defined, proc will not be triggered", spellId);
            if (procEntry.spellTypeMask & ~PROC_SPELL_TYPE_MASK_ALL)
                LOG_ERROR("sql.sql", "`spell_proc` table entry for spellId %u has wrong `spellTypeMask` set: %u", spellId, procEntry.spellTypeMask);
            if (procEntry.spellTypeMask && !(procEntry.typeMask & (SPELL_PROC_FLAG_MASK | PERIODIC_PROC_FLAG_MASK)))
                LOG_ERROR("sql.sql", "`spell_proc` table entry for spellId %u has `spellTypeMask` value defined, but it won't be used for defined `typeMask` value", spellId);
            if (!procEntry.spellPhaseMask && procEntry.typeMask & REQ_SPELL_PHASE_PROC_FLAG_MASK)
                LOG_ERROR("sql.sql", "`spell_proc` table entry for spellId %u doesn't have `spellPhaseMask` value defined, but it's required for defined `typeMask` value, proc will not be triggered", spellId);
            if (procEntry.spellPhaseMask & ~PROC_SPELL_PHASE_MASK_ALL)
                LOG_ERROR("sql.sql", "`spell_proc` table entry for spellId %u has wrong `spellPhaseMask` set: %u", spellId, procEntry.spellPhaseMask);
            if (procEntry.spellPhaseMask && !(procEntry.typeMask & REQ_SPELL_PHASE_PROC_FLAG_MASK))
                LOG_ERROR("sql.sql", "`spell_proc` table entry for spellId %u has `spellPhaseMask` value defined, but it won't be used for defined `typeMask` value", spellId);
            if (procEntry.hitMask & ~PROC_HIT_MASK_ALL)
                LOG_ERROR("sql.sql", "`spell_proc` table entry for spellId %u has wrong `hitMask` set: %u", spellId, procEntry.hitMask);
            if (procEntry.hitMask && !(procEntry.typeMask & TAKEN_HIT_PROC_FLAG_MASK || (procEntry.typeMask & DONE_HIT_PROC_FLAG_MASK && (!procEntry.spellPhaseMask || procEntry.spellPhaseMask & (PROC_SPELL_PHASE_HIT | PROC_SPELL_PHASE_FINISH)))))
                LOG_ERROR("sql.sql", "`spell_proc` table entry for spellId %u has `hitMask` value defined, but it won't be used for defined `typeMask` and `spellPhaseMask` values", spellId);

            mSpellProcMap[spellInfo->Id] = procEntry;

            if (allRanks)
                spellInfo = spellInfo->GetNextRankSpell();
            else
                break;
        }
        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %u spell proc conditions and data in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void SpellMgr::LoadSpellBonusess()
{
    uint32 oldMSTime = getMSTime();

    mSpellBonusMap.clear();                             // need for reload case

    //                                                0      1             2          3         4
    QueryResult result = WorldDatabase.Query("SELECT entry, direct_bonus, dot_bonus, ap_bonus, ap_dot_bonus FROM spell_bonus_data");
    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 spell bonus data. DB table `spell_bonus_data` is empty.");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();
        uint32 entry = fields[0].GetUInt32();

        SpellInfo const* spell = GetSpellInfo(entry);
        if (!spell)
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_bonus_data` does not exist", entry);
            continue;
        }

        SpellBonusEntry& sbe = mSpellBonusMap[entry];
        sbe.direct_damage = fields[1].GetFloat();
        sbe.dot_damage    = fields[2].GetFloat();
        sbe.ap_bonus      = fields[3].GetFloat();
        sbe.ap_dot_bonus   = fields[4].GetFloat();

        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %u extra spell bonus data in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void SpellMgr::LoadSpellThreats()
{
    uint32 oldMSTime = getMSTime();

    mSpellThreatMap.clear();                                // need for reload case

    //                                                0      1        2       3
    QueryResult result = WorldDatabase.Query("SELECT entry, flatMod, pctMod, apPctMod FROM spell_threat");
    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 aggro generating spells. DB table `spell_threat` is empty.");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].GetUInt32();

        if (!GetSpellInfo(entry))
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_threat` does not exist", entry);
            continue;
        }

        SpellThreatEntry ste;
        ste.flatMod  = fields[1].GetInt32();
        ste.pctMod   = fields[2].GetFloat();
        ste.apPctMod = fields[3].GetFloat();

        mSpellThreatMap[entry] = ste;
        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %u SpellThreatEntries in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void SpellMgr::LoadSpellMixology()
{
    uint32 oldMSTime = getMSTime();

    mSpellMixologyMap.clear();                                // need for reload case

    //                                                0      1
    QueryResult result = WorldDatabase.Query("SELECT entry, pctMod FROM spell_mixology");
    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 mixology bonuses. DB table `spell_mixology` is empty.");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].GetUInt32();

        if (!GetSpellInfo(entry))
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_mixology` does not exist", entry);
            continue;
        }

        mSpellMixologyMap[entry] = fields[1].GetFloat();
        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %u Mixology bonuses in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
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

        mSkillLineAbilityMap.insert(SkillLineAbilityMap::value_type(SkillInfo->spellId, SkillInfo));
        ++count;
    }

    LOG_INFO("server", ">> Loaded %u SkillLineAbility MultiMap Data in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void SpellMgr::LoadSpellPetAuras()
{
    uint32 oldMSTime = getMSTime();

    mSpellPetAuraMap.clear();                                  // need for reload case

    //                                                  0       1       2    3
    QueryResult result = WorldDatabase.Query("SELECT spell, effectId, pet, aura FROM spell_pet_auras");
    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 spell pet auras. DB table `spell_pet_auras` is empty.");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 spell = fields[0].GetUInt32();
        uint8 eff = fields[1].GetUInt8();
        uint32 pet = fields[2].GetUInt32();
        uint32 aura = fields[3].GetUInt32();

        SpellPetAuraMap::iterator itr = mSpellPetAuraMap.find((spell << 8) + eff);
        if (itr != mSpellPetAuraMap.end())
            itr->second.AddAura(pet, aura);
        else
        {
            SpellInfo const* spellInfo = GetSpellInfo(spell);
            if (!spellInfo)
            {
                LOG_ERROR("sql.sql", "Spell %u listed in `spell_pet_auras` does not exist", spell);
                continue;
            }
            if (spellInfo->Effects[eff].Effect != SPELL_EFFECT_DUMMY &&
                    (spellInfo->Effects[eff].Effect != SPELL_EFFECT_APPLY_AURA ||
                     spellInfo->Effects[eff].ApplyAuraName != SPELL_AURA_DUMMY))
            {
                LOG_ERROR("server", "Spell %u listed in `spell_pet_auras` does not have dummy aura or dummy effect", spell);
                continue;
            }

            SpellInfo const* spellInfo2 = GetSpellInfo(aura);
            if (!spellInfo2)
            {
                LOG_ERROR("sql.sql", "Aura %u listed in `spell_pet_auras` does not exist", aura);
                continue;
            }

            PetAura pa(pet, aura, spellInfo->Effects[eff].TargetA.GetTarget() == TARGET_UNIT_PET, spellInfo->Effects[eff].CalcValue());
            mSpellPetAuraMap[(spell << 8) + eff] = pa;
        }

        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %u spell pet auras in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
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

        // TODO: find a better check
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

    LOG_INFO("server", ">> Loaded %u custom enchant attributes in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void SpellMgr::LoadSpellEnchantProcData()
{
    uint32 oldMSTime = getMSTime();

    mSpellEnchantProcEventMap.clear();                             // need for reload case

    //                                                  0         1           2         3
    QueryResult result = WorldDatabase.Query("SELECT entry, customChance, PPMChance, procEx FROM spell_enchant_proc_data");
    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 spell enchant proc event conditions. DB table `spell_enchant_proc_data` is empty.");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 enchantId = fields[0].GetUInt32();

        SpellItemEnchantmentEntry const* ench = sSpellItemEnchantmentStore.LookupEntry(enchantId);
        if (!ench)
        {
            LOG_ERROR("sql.sql", "Enchancment %u listed in `spell_enchant_proc_data` does not exist", enchantId);
            continue;
        }

        SpellEnchantProcEntry spe;

        spe.customChance = fields[1].GetUInt32();
        spe.PPMChance = fields[2].GetFloat();
        spe.procEx = fields[3].GetUInt32();

        mSpellEnchantProcEventMap[enchantId] = spe;

        ++count;
    } while (result->NextRow());

    LOG_INFO("server", ">> Loaded %u enchant proc data definitions in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void SpellMgr::LoadSpellLinked()
{
    uint32 oldMSTime = getMSTime();

    mSpellLinkedMap.clear();    // need for reload case

    //                                                0              1             2
    QueryResult result = WorldDatabase.Query("SELECT spell_trigger, spell_effect, type FROM spell_linked_spell");
    if (!result)
    {
        LOG_INFO("server", ">> Loaded 0 linked spells. DB table `spell_linked_spell` is empty.");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        int32 trigger = fields[0].GetInt32();
        int32 effect = fields[1].GetInt32();
        int32 type = fields[2].GetUInt8();

        SpellInfo const* spellInfo = GetSpellInfo(abs(trigger));
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_linked_spell` does not exist", abs(trigger));
            continue;
        }
        spellInfo = GetSpellInfo(abs(effect));
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_linked_spell` does not exist", abs(effect));
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

    LOG_INFO("server", ">> Loaded %u linked spells in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
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

            for (uint32 k = 0; k < sSkillLineAbilityStore.GetNumRows(); ++k)
            {
                SkillLineAbilityEntry const* skillLine = sSkillLineAbilityStore.LookupEntry(k);
                if (!skillLine)
                    continue;

                //if (skillLine->skillId != creatureFamily->skillLine[0] &&
                //    (!creatureFamily->skillLine[1] || skillLine->skillId != creatureFamily->skillLine[1]))
                //    continue;

                if (skillLine->skillId != creatureFamily->skillLine[j])
                    continue;

                if (skillLine->learnOnGetSkill != ABILITY_LEARNED_ON_GET_RACE_OR_CLASS_SKILL)
                    continue;

                SpellInfo const* spell = GetSpellInfo(skillLine->spellId);
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

    LOG_INFO("server", ">> Loaded %u pet levelup and default spells for %u families in %u ms", count, family_count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
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

    LOG_INFO("server", ">> Loaded addition spells for %u pet spell data entries in %u ms", countData, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");

    LOG_INFO("server", "Loading summonable creature templates...");
    oldMSTime = getMSTime();

    // different summon spells
    for (uint32 i = 0; i < GetSpellInfoStoreSize(); ++i)
    {
        SpellInfo const* spellEntry = GetSpellInfo(i);
        if (!spellEntry)
            continue;

        for (uint8 k = 0; k < MAX_SPELL_EFFECTS; ++k)
        {
            if (spellEntry->Effects[k].Effect == SPELL_EFFECT_SUMMON || spellEntry->Effects[k].Effect == SPELL_EFFECT_SUMMON_PET)
            {
                uint32 creature_id = spellEntry->Effects[k].MiscValue;
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

    LOG_INFO("server", ">> Loaded %u summonable creature templates in %u ms", countCreature, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
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
        LOG_INFO("server", ">> Loaded 0 spell area requirements. DB table `spell_area` is empty.");
        LOG_INFO("server", " ");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 spell = fields[0].GetUInt32();
        SpellArea spellArea;
        spellArea.spellId             = spell;
        spellArea.areaId              = fields[1].GetUInt32();
        spellArea.questStart          = fields[2].GetUInt32();
        spellArea.questStartStatus    = fields[3].GetUInt32();
        spellArea.questEndStatus      = fields[4].GetUInt32();
        spellArea.questEnd            = fields[5].GetUInt32();
        spellArea.auraSpell           = fields[6].GetInt32();
        spellArea.raceMask            = fields[7].GetUInt32();
        spellArea.gender              = Gender(fields[8].GetUInt8());
        spellArea.autocast            = fields[9].GetBool();

        if (SpellInfo const* spellInfo = GetSpellInfo(spell))
        {
            if (spellArea.autocast)
                const_cast<SpellInfo*>(spellInfo)->Attributes |= SPELL_ATTR0_NO_AURA_CANCEL;
        }
        else
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_area` does not exist", spell);
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
                LOG_ERROR("sql.sql", "Spell %u listed in `spell_area` already listed with similar requirements.", spell);
                continue;
            }
        }

        if (spellArea.areaId && !sAreaTableStore.LookupEntry(spellArea.areaId))
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_area` have wrong area (%u) requirement", spell, spellArea.areaId);
            continue;
        }

        if (spellArea.questStart && !sObjectMgr->GetQuestTemplate(spellArea.questStart))
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_area` have wrong start quest (%u) requirement", spell, spellArea.questStart);
            continue;
        }

        if (spellArea.questEnd)
        {
            if (!sObjectMgr->GetQuestTemplate(spellArea.questEnd))
            {
                LOG_ERROR("sql.sql", "Spell %u listed in `spell_area` have wrong end quest (%u) requirement", spell, spellArea.questEnd);
                continue;
            }
        }

        if (spellArea.auraSpell)
        {
            SpellInfo const* spellInfo = GetSpellInfo(abs(spellArea.auraSpell));
            if (!spellInfo)
            {
                LOG_ERROR("sql.sql", "Spell %u listed in `spell_area` have wrong aura spell (%u) requirement", spell, abs(spellArea.auraSpell));
                continue;
            }

            if (uint32(abs(spellArea.auraSpell)) == spellArea.spellId)
            {
                LOG_ERROR("sql.sql", "Spell %u listed in `spell_area` have aura spell (%u) requirement for itself", spell, abs(spellArea.auraSpell));
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
                    LOG_ERROR("sql.sql", "Spell %u listed in `spell_area` have aura spell (%u) requirement that itself autocast from aura", spell, spellArea.auraSpell);
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
                    LOG_ERROR("sql.sql", "Spell %u listed in `spell_area` have aura spell (%u) requirement that itself autocast from aura", spell, spellArea.auraSpell);
                    continue;
                }
            }
        }

        if (spellArea.raceMask && (spellArea.raceMask & RACEMASK_ALL_PLAYABLE) == 0)
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_area` have wrong race mask (%u) requirement", spell, spellArea.raceMask);
            continue;
        }

        if (spellArea.gender != GENDER_NONE && spellArea.gender != GENDER_FEMALE && spellArea.gender != GENDER_MALE)
        {
            LOG_ERROR("sql.sql", "Spell %u listed in `spell_area` have wrong gender (%u) requirement", spell, spellArea.gender);
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
            mSpellAreaForAuraMap.insert(SpellAreaForAuraMap::value_type(abs(spellArea.auraSpell), sa));

        ++count;
    } while (result->NextRow());

    if (sWorld->getIntConfig(CONFIG_ICC_BUFF_HORDE) > 0)
    {
        LOG_INFO("server", ">> Using ICC buff Horde: %u", sWorld->getIntConfig(CONFIG_ICC_BUFF_HORDE));
        SpellArea spellAreaICCBuffHorde = { sWorld->getIntConfig(CONFIG_ICC_BUFF_HORDE), ICC_AREA, 0, 0, 0, ICC_RACEMASK_HORDE, Gender(2), 64, 11, 1 };
        SpellArea const* saICCBuffHorde = &mSpellAreaMap.insert(SpellAreaMap::value_type(sWorld->getIntConfig(CONFIG_ICC_BUFF_HORDE), spellAreaICCBuffHorde))->second;
        mSpellAreaForAreaMap.insert(SpellAreaForAreaMap::value_type(ICC_AREA, saICCBuffHorde));
        ++count;
    }
    else
        LOG_INFO("server", ">> ICC buff Horde: disabled");

    if (sWorld->getIntConfig(CONFIG_ICC_BUFF_ALLIANCE) > 0)
    {
        LOG_INFO("server", ">> Using ICC buff Alliance: %u", sWorld->getIntConfig(CONFIG_ICC_BUFF_ALLIANCE));
        SpellArea spellAreaICCBuffAlliance = { sWorld->getIntConfig(CONFIG_ICC_BUFF_ALLIANCE), ICC_AREA, 0, 0, 0, ICC_RACEMASK_ALLIANCE, Gender(2), 64, 11, 1 };
        SpellArea const* saICCBuffAlliance = &mSpellAreaMap.insert(SpellAreaMap::value_type(sWorld->getIntConfig(CONFIG_ICC_BUFF_ALLIANCE), spellAreaICCBuffAlliance))->second;
        mSpellAreaForAreaMap.insert(SpellAreaForAreaMap::value_type(ICC_AREA, saICCBuffAlliance));
        ++count;
    }
    else
        LOG_INFO("server", ">> ICC buff Alliance: disabled");

    LOG_INFO("server", ">> Loaded %u spell area requirements in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void SpellMgr::LoadSpellInfoStore()
{
    uint32 oldMSTime = getMSTime();

    UnloadSpellInfoStore();
    mSpellInfoMap.resize(sSpellStore.GetNumRows(), nullptr);

    for (uint32 i = 0; i < sSpellStore.GetNumRows(); ++i)
    {
        if (SpellEntry const* spellEntry = sSpellStore.LookupEntry(i))
            mSpellInfoMap[i] = new SpellInfo(spellEntry);
    }

    LOG_INFO("server", ">> Loaded spell custom attributes in %u ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void SpellMgr::UnloadSpellInfoStore()
{
    for (uint32 i = 0; i < mSpellInfoMap.size(); ++i)
    {
        if (mSpellInfoMap[i])
            delete mSpellInfoMap[i];
    }
    mSpellInfoMap.clear();
}

void SpellMgr::UnloadSpellInfoImplicitTargetConditionLists()
{
    for (uint32 i = 0; i < mSpellInfoMap.size(); ++i)
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

    LOG_INFO("server", ">> Loaded spell specific and aura state in %u ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

void SpellMgr::LoadSpellCustomAttr()
{
    uint32 oldMSTime = getMSTime();
    uint32 customAttrTime = getMSTime();
    uint32 count;

    QueryResult result = WorldDatabase.Query("SELECT spell_id, attributes FROM spell_custom_attr");

    if (!result)
        LOG_INFO("server", ">> Loaded 0 spell custom attributes from DB. DB table `spell_custom_attr` is empty.");
    else
    {
        for (count = 0; result->NextRow(); ++count)
        {
            Field* fields = result->Fetch();

            uint32 spellId = fields[0].GetUInt32();
            uint32 attributes = fields[1].GetUInt32();

            SpellInfo* spellInfo = _GetSpellInfo(spellId);
            if (!spellInfo)
            {
                LOG_INFO("server", "Table `spell_custom_attr` has wrong spell (spell_id: %u), ignored.", spellId);
                continue;
            }

            if ((attributes & SPELL_ATTR0_CU_NEGATIVE) != 0)
            {
                for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                {
                    if (spellInfo->Effects[i].IsEffect())
                        continue;

                    if ((attributes & (SPELL_ATTR0_CU_NEGATIVE_EFF0 << i)) != 0)
                    {
                        LOG_ERROR("sql.sql", "Table `spell_custom_attr` has attribute SPELL_ATTR0_CU_NEGATIVE_EFF%u for spell %u with no EFFECT_%u", uint32(i), spellId, uint32(i));
                        continue;
                    }
                }
            }

            if ((attributes & SPELL_ATTR0_CU_POSITIVE) != 0)
            {
                for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                {
                    if (spellInfo->Effects[i].IsEffect())
                        continue;

                    if ((attributes & (SPELL_ATTR0_CU_POSITIVE_EFF0 << i)) != 0)
                    {
                        LOG_ERROR("sql.sql", "Table `spell_custom_attr` has attribute SPELL_ATTR0_CU_POSITIVE_EFF%u for spell %u with no EFFECT_%u", uint32(i), spellId, uint32(i));
                        continue;
                    }
                }
            }

            spellInfo->AttributesCu |= attributes;
        }
        LOG_INFO("server", ">> Loaded %u spell custom attributes from DB in %u ms", count, GetMSTimeDiffToNow(customAttrTime));
    }

    // xinef: create talent spells set
    for (uint32 i = 0; i < sTalentStore.GetNumRows(); ++i)
    {
        TalentEntry const* talentInfo = sTalentStore.LookupEntry(i);
        if (!talentInfo)
            continue;

        for (uint8 j = 0; j < MAX_TALENT_RANK; j++)
            if (uint32 spellId = talentInfo->RankID[j])
                if (const SpellInfo* spellInfo = GetSpellInfo(spellId))
                    for (uint8 k = 0; k < MAX_SPELL_EFFECTS; ++k)
                        if (spellInfo->Effects[k].Effect == SPELL_EFFECT_LEARN_SPELL)
                            if (const SpellInfo* learnSpell = GetSpellInfo(spellInfo->Effects[k].TriggerSpell))
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
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_NO_INITIAL_THREAT;
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

                                SpellInfo* procInfo = (SpellInfo*)GetSpellInfo(enchant->spellid[s]);
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
                            [[fallthrough]]; // TODO: Not sure whether the fallthrough was a mistake (forgetting a break) or intended. This should be double-checked.
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
            case 13877: // Blade Flurry (Rogue Spell) should ignore armor and share damage to 2nd mob
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
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_SINGLE_AURA_STACK;
                break;
            case 43138: // North Fleet Reservist Kill Credit
                spellInfo->AttributesCu |= SPELL_ATTR0_CU_ALLOW_INFLIGHT_TARGET;
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
        }
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

    CreatureAI::FillAISpellInfo();

    LOG_INFO("server", ">> Loaded spell custom attributes in %u ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}

inline void ApplySpellFix(std::initializer_list<uint32> spellIds, void(*fix)(SpellEntry*))
{
    for (uint32 spellId : spellIds)
    {
        SpellEntry const* spellInfo = (SpellEntry*)sSpellStore.LookupEntry(spellId);
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Spell info correction specified for non-existing spell %u", spellId);
            continue;
        }

        fix(const_cast<SpellEntry*>(spellInfo));
    }
}

void SpellMgr::LoadDbcDataCorrections()
{
    uint32 oldMSTime = getMSTime();

    ApplySpellFix({
        467,    // Thorns (Rank 1)
        782,    // Thorns (Rank 2)
        1075,   // Thorns (Rank 3)
        8914,   // Thorns (Rank 4)
        9756,   // Thorns (Rank 5)
        9910,   // Thorns (Rank 6)
        26992,  // Thorns (Rank 7)
        53307,  // Thorns (Rank 8)
        53352   // Explosive Shot (trigger)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Elixir of Minor Fortitude
    ApplySpellFix({ 2378 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ManaCost = 0;
        spellInfo->ManaPerSecond = 0;
    });

    // Elixir of Detect Undead
    ApplySpellFix({ 11389 }, [](SpellEntry* spellInfo)
    {
        spellInfo->PowerType = POWER_MANA;
        spellInfo->ManaCost = 0;
        spellInfo->ManaPerSecond = 0;
    });

    // Evergrove Druid Transform Crow
    ApplySpellFix({ 38776 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 4; // 120 seconds
    });

    ApplySpellFix({
        63026, // Force Cast (HACK: Target shouldn't be changed)
        63137  // Force Cast (HACK: Target shouldn't be changed; summon position should be untied from spell destination)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_DEST_DB;
    });

    ApplySpellFix({
        53096,  // Quetz'lun's Judgment
        70743,  // AoD Special
        70614   // AoD Special - Vegard
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
    });

    ApplySpellFix({
        52611,  // Summon Skeletons
        52612   // Summon Skeletons
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectMiscValueB[0] = 64;
    });

    ApplySpellFix({
        45257,  // Using Steam Tonk Controller
        45440,  // Steam Tonk Controller
        60256,  // Collect Sample
        45634   // Neural Needle
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx4 &= ~SPELL_ATTR4_ALLOW_CAST_WHILE_CASTING;    // Crashes client on pressing ESC
    });

    ApplySpellFix({
        40244,  // Simon Game Visual
        40245,  // Simon Game Visual
        40246,  // Simon Game Visual
        40247,  // Simon Game Visual
        42835   // Spout, remove damage effect, only anim is needed
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = 0;
    });

    ApplySpellFix({
        63665,  // Charge (Argent Tournament emote on riders)
        31298,  // Sleep (needs target selection script)
        2895,   // Wrath of Air Totem rank 1 (Aura)
        68933,  // Wrath of Air Totem rank 2 (Aura)
        29200   // Purify Helboar Meat
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
        spellInfo->EffectImplicitTargetB[0] = 0;
    });

    // Howl of Azgalor
    ApplySpellFix({ 31344 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_100_YARDS; // 100yards instead of 50000?!
    });

    ApplySpellFix({
        42818,  // Headless Horseman - Wisp Flight Port
        42821   // Headless Horseman - Wisp Flight Missile
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 6; // 100 yards
    });

    //They Must Burn Bomb Aura (self)
    ApplySpellFix({ 36350 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[0] = 36325; // They Must Burn Bomb Drop (DND)
    });

    // Mana Shield (rank 2)
    ApplySpellFix({ 8494 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ProcChance = 0; // because of bug in dbc
    });

    ApplySpellFix({
        63320,  // Glyph of Life Tap
        20335,  // Heart of the Crusader
        20336,  // Heart of the Crusader
        20337,  // Heart of the Crusader
        53228,  // Rapid Killing (Rank 1)
        53232,  // Rapid Killing (Rank 2)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_CAN_PROC_FROM_PROCS; // Entries were not updated after spell effect change, we have to do that manually
    });

    ApplySpellFix({
        31347,  // Doom
        41635,  // Prayer of Mending
        39365,  // Thundering Storm
        52124,  // Sky Darkener Assault
        42442,  // Vengeance Landing Cannonfire
        45863,  // Cosmetic - Incinerate to Random Target
        25425,  // Shoot
        45761,  // Shoot
        42611,  // Shoot
        61588,  // Blazing Harpoon
        36327   // Shoot Arcane Explosion Arrow
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
    });

    // Skartax Purple Beam
    ApplySpellFix({ 36384 }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 2;
    });

    ApplySpellFix({
        37790,  // Spread Shot
        54172,  // Divine Storm (heal)
        66588,  // Flaming Spear
        54171   // Divine Storm
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 3;
    });

    // Divine Storm (Damage)
    ApplySpellFix({ 53385 }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 4;
    });

    // Spitfire Totem
    ApplySpellFix({ 38296 }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 5;
    });

    ApplySpellFix({
        40827,  // Sinful Beam
        40859,  // Sinister Beam
        40860,  // Vile Beam
        40861   // Wicked Beam
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 10;
    });

    // Unholy Frenzy
    ApplySpellFix({ 50312 }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 15;
    });

    ApplySpellFix({
        17941,  // Shadow Trance
        22008,  // Netherwind Focus
        31834,  // Light's Grace
        34754,  // Clearcasting
        34936,  // Backlash
        48108,  // Hot Streak
        51124,  // Killing Machine
        54741,  // Firestarter
        57761,  // Fireball!
        64823,  // Item - Druid T8 Balance 4P Bonus
        34477,  // Misdirection
        44401,  // Missile Barrage
        18820   // Insight
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->ProcCharges = 1;
    });

    // Tidal Wave
    ApplySpellFix({ 53390 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ProcCharges = 2;
    });

    // Oscillation Field
    ApplySpellFix({ 37408 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Ascendance (Talisman of Ascendance trinket)
    ApplySpellFix({ 28200 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ProcCharges = 6;
    });

    // The Eye of Acherus (no spawn in phase 2 in db)
    ApplySpellFix({ 51852 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectMiscValue[0] |= 1;
    });

    // Crafty's Ultra-Advanced Proto-Typical Shortening Blaster
    ApplySpellFix({ 51912 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectAmplitude[0] = 3000;
    });

    // Desecration Arm - 36 instead of 37 - typo?
    ApplySpellFix({ 29809 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = 37;
    });

    // Sic'em
    ApplySpellFix({ 42767 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_NEARBY_ENTRY;
    });

    // Master Shapeshifter: missing stance data for forms other than bear - bear version has correct data
    // To prevent aura staying on target after talent unlearned
    ApplySpellFix({ 48420 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Stances = 1 << (FORM_CAT - 1);
    });

    ApplySpellFix({ 48421 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Stances = 1 << (FORM_MOONKIN - 1);
    });

    ApplySpellFix({ 48422 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Stances = 1 << (FORM_TREE - 1);
    });

    // Elemental Oath
    ApplySpellFix({ 51466, 51470 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[EFFECT_1] = SPELL_EFFECT_APPLY_AURA;
        spellInfo->EffectApplyAuraName[EFFECT_1] = SPELL_AURA_ADD_FLAT_MODIFIER;
        spellInfo->EffectMiscValue[EFFECT_1] = SPELLMOD_EFFECT2;
        spellInfo->EffectSpellClassMask[EFFECT_1] = flag96(0x00000000, 0x00004000, 0x00000000);
    });

    // Improved Shadowform (Rank 1)
    ApplySpellFix({ 47569 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes &= ~SPELL_ATTR0_NOT_SHAPESHIFTED;   // with this spell atrribute aura can be stacked several times
    });

    // Nether Portal - Perseverence
    ApplySpellFix({ 30421 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[2] += 30000;
    });

    // Natural shapeshifter
    ApplySpellFix({ 16834, 16835 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 21;
    });

    // Ebon Plague
    ApplySpellFix({ 51735, 51734, 51726 }, [](SpellEntry* spellInfo)
    {
        spellInfo->SpellFamilyFlags[2] = 0x10;
        spellInfo->EffectApplyAuraName[1] = SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Parasitic Shadowfiend Passive
    ApplySpellFix({ 41013 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectApplyAuraName[0] = SPELL_AURA_DUMMY;   // proc debuff, and summon infinite fiends
    });

    ApplySpellFix({
        27892,  // To Anchor 1
        27928,  // To Anchor 1
        27935,  // To Anchor 1
        27915,  // Anchor to Skulls
        27931,  // Anchor to Skulls
        27937   // Anchor to Skulls
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 13;
    });

    // Wrath of the Plaguebringer
    ApplySpellFix({ 29214, 54836 }, [](SpellEntry* spellInfo)
    {
        // target allys instead of enemies, target A is src_caster, spells with effect like that have ally target
        // this is the only known exception, probably just wrong data
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ALLY;
        spellInfo->EffectImplicitTargetB[1] = TARGET_UNIT_SRC_AREA_ALLY;
    });

    // Wind Shear
    ApplySpellFix({ 57994 }, [](SpellEntry* spellInfo)
    {
        // improper data for EFFECT_1 in 3.3.5 DBC, but is correct in 4.x
        spellInfo->Effect[EFFECT_1] = SPELL_EFFECT_MODIFY_THREAT_PERCENT;
        spellInfo->EffectBasePoints[EFFECT_1] = -6; // -5%
    });

    // Improved Devouring Plague
    ApplySpellFix({ 63675 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBonusMultiplier[0] = 0;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    });

    ApplySpellFix({
        8145,   // Tremor Totem (instant pulse)
        6474    // Earthbind Totem (instant pulse)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx5 |= SPELL_ATTR5_EXTRA_INITIAL_PERIOD;
    });

    // Marked for Death
    ApplySpellFix({ 53241, 53243, 53244, 53245, 53246 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectSpellClassMask[0] = flag96(423937, 276955137, 2049);
    });

    ApplySpellFix({
        70728,  // Exploit Weakness
        70840   // Devious Minds
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_PET;
    });

    // Culling The Herd
    ApplySpellFix({ 70893 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_MASTER;
    });

    // Sigil of the Frozen Conscience
    ApplySpellFix({ 54800 }, [](SpellEntry* spellInfo)
    {
        // change class mask to custom extended flags of Icy Touch
        // this is done because another spell also uses the same SpellFamilyFlags as Icy Touch
        // SpellFamilyFlags[0] & 0x00000040 in SPELLFAMILY_DEATHKNIGHT is currently unused (3.3.5a)
        // this needs research on modifier applying rules, does not seem to be in Attributes fields
        spellInfo->EffectSpellClassMask[0] = flag96(0x00000040, 0x00000000, 0x00000000);
    });

    // Idol of the Flourishing Life
    ApplySpellFix({ 64949 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectSpellClassMask[EFFECT_0] = flag96(0x00000000, 0x02000000, 0x00000000);
        spellInfo->EffectApplyAuraName[EFFECT_0] = SPELL_AURA_ADD_FLAT_MODIFIER;
    });

    ApplySpellFix({
        34231,  // Libram of the Lightbringer
        60792,  // Libram of Tolerance
        64956   // Libram of the Resolute
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectSpellClassMask[EFFECT_0] = flag96(0x80000000, 0x00000000, 0x00000000);
        spellInfo->EffectApplyAuraName[EFFECT_0] = SPELL_AURA_ADD_FLAT_MODIFIER;
    });

    ApplySpellFix({
        28851,  // Libram of Light
        28853,  // Libram of Divinity
        32403   // Blessed Book of Nagrand
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectSpellClassMask[EFFECT_0] = flag96(0x40000000, 0x00000000, 0x00000000);
        spellInfo->EffectApplyAuraName[EFFECT_0] = SPELL_AURA_ADD_FLAT_MODIFIER;
    });

    // Ride Carpet
    ApplySpellFix({ 45602 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[EFFECT_0] = 0; // force seat 0, vehicle doesn't have the required seat flags for "no seat specified (-1)"
    });

    ApplySpellFix({
        64745,  // Item - Death Knight T8 Tank 4P Bonus
        64936   // Item - Warrior T8 Protection 4P Bonus
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[EFFECT_0] = 100; // 100% chance of procc'ing, not -10% (chance calculated in PrepareTriggersExecutedOnHit)
    });

    // Easter Lay Noblegarden Egg Aura
    ApplySpellFix({ 61719 }, [](SpellEntry* spellInfo)
    {
        // Interrupt flags copied from aura which this aura is linked with
        spellInfo->AuraInterruptFlags = AURA_INTERRUPT_FLAG_HITBYSPELL | AURA_INTERRUPT_FLAG_TAKE_DAMAGE;
    });

    // Bleh, need to change FamilyFlags :/ (have the same as original aura - bad!)
    ApplySpellFix({ 63510 }, [](SpellEntry* spellInfo)
    {
        spellInfo->SpellFamilyFlags[0] = 0;
        spellInfo->SpellFamilyFlags[2] = 0x4000000;
    });

    ApplySpellFix({ 63514 }, [](SpellEntry* spellInfo)
    {
        spellInfo->SpellFamilyFlags[0] = 0;
        spellInfo->SpellFamilyFlags[2] = 0x2000000;
    });

    ApplySpellFix({ 63531 }, [](SpellEntry* spellInfo)
    {
        spellInfo->SpellFamilyFlags[0] = 0;
        spellInfo->SpellFamilyFlags[2] = 0x8000000;
    });

    // And affecting spells
    ApplySpellFix({
        20138,  // Improved Devotion Aura
        20139,
        20140
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectSpellClassMask[1][0] = 0;
        spellInfo->EffectSpellClassMask[1][2] = 0x2000000;
    });

    ApplySpellFix({
        20254,  // Improved concentration aura
        20255,
        20256
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectSpellClassMask[1][0] = 0;
        spellInfo->EffectSpellClassMask[1][2] = 0x4000000;
        spellInfo->EffectSpellClassMask[2][0] = 0;
        spellInfo->EffectSpellClassMask[2][2] = 0x4000000;
    });

    ApplySpellFix({
        53379,  // Swift Retribution
        53484,
        53648
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectSpellClassMask[0][0] = 0;
        spellInfo->EffectSpellClassMask[0][2] = 0x8000000;
    });

    // Sanctified Retribution
    ApplySpellFix({ 31869 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectSpellClassMask[0][0] = 0;
        spellInfo->EffectSpellClassMask[0][2] = 0x8000000;
    });

    // Seal of Light trigger
    ApplySpellFix({ 20167 }, [](SpellEntry* spellInfo)
    {
        spellInfo->SpellLevel = 0;
        spellInfo->BaseLevel = 0;
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
    });

    // Light's Beacon, Beacon of Light
    ApplySpellFix({ 53651 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Hand of Reckoning
    ApplySpellFix({ 62124 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION;
    });

    // Redemption
    ApplySpellFix({ 7328, 10322, 10324, 20772, 20773, 48949, 48950 }, [](SpellEntry* spellInfo)
    {
        spellInfo->SpellFamilyName = SPELLFAMILY_PALADIN;
    });

    ApplySpellFix({
        20184,  // Judgement of Justice
        20185,  // Judgement of Light
        20186,  // Judgement of Wisdom
        68055   // Judgements of the Just
        }, [](SpellEntry* spellInfo)
    {
        // hack for seal of light and few spells, judgement consists of few single casts and each of them can proc
        // some spell, base one has disabled proc flag but those dont have this flag
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_CASTER_PROCS;
    });

    // Blessing of sanctuary stats
    ApplySpellFix({ 67480 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectMiscValue[0] = -1;
        spellInfo->SpellFamilyName = SPELLFAMILY_UNK1; // allows stacking
        spellInfo->EffectApplyAuraName[1] = SPELL_AURA_DUMMY; // just a marker
    });

    // Seal of Command trigger
    ApplySpellFix({ 20424 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 &= ~SPELL_ATTR3_SUPRESS_CASTER_PROCS;
    });

    ApplySpellFix({
        54968,  // Glyph of Holy Light, Damage Class should be magic
        53652,  // Beacon of Light heal, Damage Class should be magic
        53654
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
    });

    // Wild Hunt
    ApplySpellFix({ 62758, 62762 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = SPELL_EFFECT_APPLY_AURA;
        spellInfo->EffectApplyAuraName[0] = SPELL_AURA_DUMMY;
        spellInfo->Effect[1] = SPELL_EFFECT_APPLY_AURA;
        spellInfo->EffectApplyAuraName[1] = SPELL_AURA_DUMMY;
    });

    // Intervene
    ApplySpellFix({ 3411 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Roar of Sacrifice
    ApplySpellFix({ 53480 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[1] = SPELL_EFFECT_APPLY_AURA;
        spellInfo->EffectApplyAuraName[1] = SPELL_AURA_SPLIT_DAMAGE_PCT;
        spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_TARGET_ALLY;
        spellInfo->EffectDieSides[1] = 1;
        spellInfo->EffectBasePoints[1] = 19;
        spellInfo->EffectMiscValue[1] = 127; // all schools
    });

    // Silencing Shot
    ApplySpellFix({ 34490, 41084, 42671 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Speed = 0.0f;
    });

    // Monstrous Bite
    ApplySpellFix({ 54680, 55495, 55496, 55497, 55498, 55499 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_CASTER;
    });

    // Hunter's Mark
    ApplySpellFix({ 1130, 14323, 14324, 14325, 53338 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Cobra Strikes
    ApplySpellFix({ 53257 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ProcCharges = 2;
        spellInfo->StackAmount = 0;
    });

    // Kill Command
    ApplySpellFix({ 34027 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ProcCharges = 0;
    });

    // Kindred Spirits, damage aura
    ApplySpellFix({ 57458 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx4 |= SPELL_ATTR4_ALLOW_ENETRING_ARENA;
    });

    // Chimera Shot - Serpent trigger
    ApplySpellFix({ 53353 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    });

    // Entrapment trigger
    ApplySpellFix({ 19185, 64803, 64804 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_DEST_TARGET_ENEMY;
        spellInfo->EffectImplicitTargetB[EFFECT_0] = TARGET_UNIT_DEST_AREA_ENEMY;
        spellInfo->AttributesEx5 |= SPELL_ATTR5_ALWAYS_AOE_LINE_OF_SIGHT;
    });

    // Improved Stings (Rank 2)
    ApplySpellFix({ 19465 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[EFFECT_2] = TARGET_UNIT_CASTER;
    });

    // Heart of the Phoenix (triggered)
    ApplySpellFix({ 54114 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx &= ~SPELL_ATTR1_DISMISS_PET_FIRST;
        spellInfo->RecoveryTime = 8 * 60 * IN_MILLISECONDS; // prev 600000
    });

    // Master of Subtlety
    ApplySpellFix({ 31221, 31222, 31223 }, [](SpellEntry* spellInfo)
    {
        spellInfo->SpellFamilyName = SPELLFAMILY_ROGUE;
    });

    ApplySpellFix({
        31666,  // Master of Subtlety triggers
        58428   // Overkill
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = SPELL_EFFECT_SCRIPT_EFFECT;
    });

    // Honor Among Thieves
    ApplySpellFix({ 51698, 51700, 51701 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[0] = 51699;
    });

    ApplySpellFix({
        5171,   // Slice and Dice
        6774,   // Slice and Dice
        1725    // Distract
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Envenom
    ApplySpellFix({ 32645, 32684, 57992, 57993 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Dispel = DISPEL_NONE;
    });

    //////////////////////////////////////////
    ////////// ULDUAR
    //////////////////////////////////////////
    ApplySpellFix({ 64014, 64032, 64028, 64031, 64030, 64029, 64024, 64025, 65042 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetB[EFFECT_1] = TARGET_DEST_DB;
    });

    // Killing Spree (teleport)
    ApplySpellFix({ 57840 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 6; // 100 yards
    });

    // Killing Spree
    ApplySpellFix({ 51690 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_ALLOW_WHILE_STEALTHED;
    });

    // Blood Tap visual cd reset
    ApplySpellFix({ 47804 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[2] = 0;
        spellInfo->Effect[1] = 0;
        spellInfo->RuneCostID = 442;
    });

    // Chains of Ice
    ApplySpellFix({ 45524 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[EFFECT_2] = 0;
    });

    // Impurity
    ApplySpellFix({ 49220, 49633, 49635, 49636, 49638 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = SPELL_EFFECT_APPLY_AURA;
        spellInfo->EffectApplyAuraName[0] = SPELL_AURA_DUMMY;
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
        spellInfo->SpellFamilyName = SPELLFAMILY_DEATHKNIGHT;
    });

    // Deadly Aggression (Deadly Gladiator's Death Knight Relic, item: 42620)
    ApplySpellFix({ 60549 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[1] = 0;
    });

    // Magic Suppression
    ApplySpellFix({ 49224, 49610, 49611 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ProcCharges = 0;
    });

    // Wandering Plague
    ApplySpellFix({ 50526 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Dancing Rune Weapon
    ApplySpellFix({ 49028 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[2] = 0;
        spellInfo->ProcFlags |= PROC_FLAG_DONE_MELEE_AUTO_ATTACK;
    });

    // Death and Decay
    ApplySpellFix({ 52212 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->AttributesEx6 |= SPELL_ATTR6_IGNORE_PHASE_SHIFT;
    });

    // T9 blood plague crit bonus
    ApplySpellFix({ 67118 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[1] = 0;
    });

    // Pestilence
    ApplySpellFix({ 50842 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[2] = TARGET_DEST_TARGET_ENEMY;
    });

    // Horn of Winter, stacking issues
    ApplySpellFix({ 57330, 57623 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[1] = 0;
    });

    // Scourge Strike trigger
    ApplySpellFix({ 70890 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_CASTER_PROCS;
    });

    // Blood-caked Blade - Blood-caked Strike trigger
    ApplySpellFix({ 50463 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_CASTER_PROCS;
    });

    // Blood Gorged
    ApplySpellFix({ 61274, 61275, 61276, 61277,61278 }, [](SpellEntry* spellInfo)
    {
        // ARP affect Death Strike and Rune Strike
        spellInfo->EffectSpellClassMask[EFFECT_0] = flag96(0x1400011, 0x20000000, 0x0);
    });

    // Death Grip
    ApplySpellFix({ 49576, 49560 }, [](SpellEntry* spellInfo)
    {
        // remove main grip mechanic, leave only effect one
        //  should fix taunt on bosses and not break the pull protection at the same time (no aura provides immunity to grip mechanic)
        spellInfo->Mechanic = 0;
    });

    // Death Grip Jump Dest
    ApplySpellFix({ 57604 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Death Pact
    ApplySpellFix({ 48743 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx &= ~SPELL_ATTR1_EXCLUDE_CASTER;
    });

    // Raise Ally (trigger)
    ApplySpellFix({ 46619 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes &= ~SPELL_ATTR0_NO_AURA_CANCEL;
    });

    // Frost Strike
    ApplySpellFix({ 49143, 51416, 51417, 51418, 51419, 55268 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_COMPLETELY_BLOCKED;
    });

    // Death Knight T10 Tank 2p Bonus
    ApplySpellFix({ 70650 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectApplyAuraName[0] = SPELL_AURA_ADD_PCT_MODIFIER;
    });

    ApplySpellFix({ 45297, 45284 }, [](SpellEntry* spellInfo)
    {
        spellInfo->CategoryRecoveryTime = 0;
        spellInfo->RecoveryTime = 0;
        spellInfo->AttributesEx6 |= SPELL_ATTR6_IGNORE_CASTER_DAMAGE_MODIFIERS;
    });

    // Improved Earth Shield
    ApplySpellFix({ 51560, 51561 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectMiscValue[1] = SPELLMOD_DAMAGE;
    });

    // Tidal Force
    ApplySpellFix({ 55166, 55198 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 18;
        spellInfo->ProcCharges = 0;
    });

    // Healing Stream Totem
    ApplySpellFix({ 52042 }, [](SpellEntry* spellInfo)
    {
        spellInfo->SpellLevel = 0;
        spellInfo->BaseLevel = 0;
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
    });

    // Earth Shield
    ApplySpellFix({ 379 }, [](SpellEntry* spellInfo)
    {
        spellInfo->SpellLevel = 0;
        spellInfo->BaseLevel = 0;
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    });

    // Stormstrike
    ApplySpellFix({ 17364 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Strength of Earth totem effect
    ApplySpellFix({ 8076, 8162, 8163, 10441, 25362, 25527, 57621, 58646 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[1] = spellInfo->EffectRadiusIndex[0];
        spellInfo->EffectRadiusIndex[2] = spellInfo->EffectRadiusIndex[0];
    });

    // Flametongue Totem effect
    ApplySpellFix({ 52109, 52110, 52111, 52112, 52113, 58651, 58654, 58655 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetB[2] = spellInfo->EffectImplicitTargetB[1] = spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->EffectImplicitTargetA[2] = spellInfo->EffectImplicitTargetA[1] = spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
    });

    // Sentry Totem
    ApplySpellFix({ 6495 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = 0;
    });

    // Bind Sight (PT)
    ApplySpellFix({ 6277 }, [](SpellEntry* spellInfo)
    {
        // because it is passive, needs this to be properly removed at death in RemoveAllAurasOnDeath()
        spellInfo->AttributesEx &= ~SPELL_ATTR1_IS_CHANNELED;
        spellInfo->Attributes |= SPELL_ATTR0_PASSIVE;
        spellInfo->AttributesEx7 |= SPELL_ATTR7_DISABLE_AURA_WHILE_DEAD;
    });

    // Ancestral Awakening Heal
    ApplySpellFix({ 52752 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    });

    // Heroism
    ApplySpellFix({ 32182 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 57723; // Exhaustion
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Bloodlust
    ApplySpellFix({ 2825 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 57724; // Sated
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Improved Succubus
    ApplySpellFix({ 18754, 18755, 18756 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
    });

    // Unstable Affliction
    ApplySpellFix({ 31117 }, [](SpellEntry* spellInfo)
    {
        spellInfo->PreventionType = SPELL_PREVENTION_TYPE_NONE;
    });

    // Shadowflame - trigger
    ApplySpellFix({
        47960,  // r1
        61291   // r2
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION;
    });

    // Curse of Doom
    ApplySpellFix({ 18662 }, [](SpellEntry* spellInfo)
    {
        // summoned doomguard duration fix
        spellInfo->DurationIndex = 6;
    });

    // Glyph of Voidwalker
    ApplySpellFix({ 56247 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectApplyAuraName[EFFECT_0] = SPELL_AURA_ADD_FLAT_MODIFIER;
        spellInfo->EffectMiscValue[EFFECT_0] = SPELLMOD_EFFECT1;
        spellInfo->EffectSpellClassMask[EFFECT_0] = flag96(0x8000000, 0, 0);
    });

    // Everlasting Affliction
    ApplySpellFix({ 47201, 47202, 47203, 47204, 47205 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectSpellClassMask[1][0] |= 2; // add corruption to affected spells
    });

    // Death's Embrace
    ApplySpellFix({ 47198, 47199, 47200 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectSpellClassMask[1][0] |= 0x4000; // include Drain Soul
    });

    // Improved Demonic Tactics
    ApplySpellFix({ 54347, 54348, 54349 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[EFFECT_1] = spellInfo->Effect[EFFECT_0];
        spellInfo->EffectApplyAuraName[EFFECT_1] = spellInfo->EffectApplyAuraName[EFFECT_0];
        spellInfo->EffectImplicitTargetA[EFFECT_1] = spellInfo->EffectImplicitTargetA[EFFECT_0];
        spellInfo->EffectMiscValue[EFFECT_0] = SPELLMOD_EFFECT1;
        spellInfo->EffectMiscValue[EFFECT_1] = SPELLMOD_EFFECT2;
    });

    // Rain of Fire (Doomguard)
    ApplySpellFix({ 42227 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Speed = 0.0f;
    });

    // Ritual Enslavement
    ApplySpellFix({ 22987 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectApplyAuraName[EFFECT_0] = SPELL_AURA_MOD_CHARM;
    });

    // Combustion, make this passive
    ApplySpellFix({ 11129 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Dispel = DISPEL_NONE;
    });

    // Magic Absorption
    ApplySpellFix({ 29441, 29444 }, [](SpellEntry* spellInfo)
    {
        spellInfo->SpellLevel = 0;
    });

    // Living Bomb
    ApplySpellFix({ 44461, 55361, 55362 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
        spellInfo->AttributesEx4 |= SPELL_ATTR4_REACTIVE_DAMAGE_PROC;
    });

    // Evocation
    ApplySpellFix({ 12051 }, [](SpellEntry* spellInfo)
    {
        spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
    });

    // MI Fireblast, WE Frostbolt, MI Frostbolt
    ApplySpellFix({ 59637, 31707, 72898 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
    });

    // Blazing Speed
    ApplySpellFix({ 31641, 31642 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[0] = 31643;
    });

    // Summon Water Elemental (permanent)
    ApplySpellFix({ 70908 }, [](SpellEntry* spellInfo)
    {
        // treat it as pet
        spellInfo->Effect[0] = SPELL_EFFECT_SUMMON_PET;
    });

    // // Burnout, trigger
    ApplySpellFix({ 44450 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = SPELL_EFFECT_POWER_BURN;
    });

    // Mirror Image - Summon Spells
    ApplySpellFix({ 58831, 58833, 58834, 65047 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_DEST_CASTER;
        spellInfo->EffectRadiusIndex[EFFECT_0] = 0;
    });

    // Initialize Images (Mirror Image)
    ApplySpellFix({ 58836 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[EFFECT_1] = TARGET_UNIT_CASTER;
    });

    // Arcane Blast, can't be dispelled
    ApplySpellFix({ 36032 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_NO_IMMUNITIES;
    });

    // Chilled (frost armor, ice armor proc)
    ApplySpellFix({ 6136, 7321 }, [](SpellEntry* spellInfo)
    {
        spellInfo->PreventionType = SPELL_PREVENTION_TYPE_NONE;
    });

    // Mirror Image Frostbolt
    ApplySpellFix({ 59638 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
        spellInfo->SpellFamilyName = SPELLFAMILY_MAGE;
        spellInfo->SpellFamilyFlags = flag96(0x20, 0x0, 0x0);
    });

    // Fingers of Frost
    ApplySpellFix({ 44544 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Dispel = DISPEL_NONE;
        spellInfo->AttributesEx4 |= SPELL_ATTR4_CANNOT_BE_STOLEN;
        spellInfo->EffectSpellClassMask[0] = flag96(685904631, 1151040, 32);
    });

    // Fingers of Frost visual buff
    ApplySpellFix({ 74396 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ProcCharges = 2;
        spellInfo->StackAmount = 0;
    });

    // Glyph of blocking
    ApplySpellFix({ 58375 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[0] = 58374;
    });

    // Sweeping Strikes stance change
    ApplySpellFix({ 12328 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_NOT_SHAPESHIFTED;
    });

    // Damage Shield
    ApplySpellFix({ 59653 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
        spellInfo->SpellLevel = 0;
    });

    ApplySpellFix({
        20230,  // Retaliation
        871,    // Shield Wall
        1719    // Recklessness
        }, [](SpellEntry* spellInfo)
    {
        // Strange shared cooldown
        spellInfo->AttributesEx6 |= SPELL_ATTR6_NO_CATEGORY_COOLDOWN_MODS;
    });

    // Vigilance
    ApplySpellFix({ 50720 }, [](SpellEntry* spellInfo)
    {
        // fixes bug with empowered renew, single target aura
        spellInfo->SpellFamilyName = SPELLFAMILY_WARRIOR;
    });

    // Sunder Armor
    ApplySpellFix({ 58567 }, [](SpellEntry* spellInfo)
    {
        // trigger, remove spellfamilyflags because of glyph of sunder armor
        spellInfo->SpellFamilyFlags = flag96(0x0, 0x0, 0x0);
    });

    // Sunder Armor - Old Ranks
    ApplySpellFix({ 7405, 8380, 11596, 11597, 25225, 47467 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[EFFECT_0] = 11971;
        spellInfo->Effect[EFFECT_0] = SPELL_EFFECT_TRIGGER_SPELL_WITH_VALUE;
    });

    // Improved Spell Reflection
    ApplySpellFix({ 59725 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_UNIT_CASTER_AREA_PARTY;
    });

    // Shadow Weaving
    ApplySpellFix({ 15257, 15331, 15332 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
        spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PROC_TRIGGER_SPELL;
    });

    // Hymn of Hope
    ApplySpellFix({ 64904 }, [](SpellEntry* spellInfo)
    {
        // rewrite part of aura system or swap effects...
        spellInfo->EffectApplyAuraName[1] = SPELL_AURA_MOD_INCREASE_ENERGY_PERCENT;
        spellInfo->Effect[2] = spellInfo->Effect[0];
        spellInfo->Effect[0] = 0;
        spellInfo->EffectDieSides[2] = spellInfo->EffectDieSides[0];
        spellInfo->EffectImplicitTargetA[2] = spellInfo->EffectImplicitTargetB[0];
        spellInfo->EffectRadiusIndex[2] = spellInfo->EffectRadiusIndex[0];
        spellInfo->EffectBasePoints[2] = spellInfo->EffectBasePoints[0];
    });

    // Divine Hymn
    ApplySpellFix({ 64844 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
        spellInfo->SpellLevel = 0;
    });

    ApplySpellFix({
        14898,  // Spiritual Healing affects prayer of mending
        15349,
        15354,
        15355,
        15356,
        47562,  // Divine Providence affects prayer of mending
        47564,
        47565,
        47566,
        47567,
        47586,  // Twin Disciplines affects prayer of mending
        47587,
        47588,
        52802,
        52803
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectSpellClassMask[0][1] |= 0x20; // prayer of mending
    });

    // Power Infusion
    ApplySpellFix({ 10060 }, [](SpellEntry* spellInfo)
    {
        // hack to fix stacking with arcane power
        spellInfo->Effect[EFFECT_2] = SPELL_EFFECT_APPLY_AURA;
        spellInfo->EffectApplyAuraName[EFFECT_2] = SPELL_AURA_ADD_PCT_MODIFIER;
        spellInfo->EffectImplicitTargetA[EFFECT_2] = TARGET_UNIT_TARGET_ALLY;
    });

    // Lifebloom final bloom
    ApplySpellFix({ 33778 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
        spellInfo->SpellLevel = 0;
        spellInfo->SpellFamilyFlags = flag96(0, 0x10, 0);
    });

    // Owlkin Frenzy
    ApplySpellFix({ 48391 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_NOT_SHAPESHIFTED;
    });

    // Item T10 Restoration 4P Bonus
    ApplySpellFix({ 70691 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    });

    ApplySpellFix({
        770,    // Faerie Fire
        16857   // Faerie Fire (Feral)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx &= ~SPELL_ATTR1_IMMUNITY_TO_HOSTILE_AND_FRIENDLY_EFFECTS;
    });

    // Feral Charge - Cat
    ApplySpellFix({ 49376, 61138, 61132, 50259 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Glyph of Barkskin
    ApplySpellFix({ 63058 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectApplyAuraName[EFFECT_0] = SPELL_AURA_MOD_ATTACKER_MELEE_CRIT_CHANCE;
    });

    // Resurrection Sickness
    ApplySpellFix({ 15007 }, [](SpellEntry* spellInfo)
    {
        spellInfo->SpellFamilyName = SPELLFAMILY_GENERIC;
    });

    // Luck of the Draw
    ApplySpellFix({ 72221 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CHANGE_MAP;
    });

    // Bind
    ApplySpellFix({ 3286 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Targets = 0; // neutral innkeepers not friendly?
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
        spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_TARGET_ANY;
    });

    // Playback Speech
    ApplySpellFix({ 74209 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 1;
    });

    ApplySpellFix({
        2641, // Dismiss Pet
        23356 // Taming Lesson
        }, [](SpellEntry* spellInfo)
    {
        // remove creaturetargettype
        spellInfo->TargetCreatureType = 0;
    });

    // Aspect of the Viper
    ApplySpellFix({ 34074 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[2] = SPELL_EFFECT_APPLY_AURA;
        spellInfo->EffectImplicitTargetA[2] = 1;
        spellInfo->EffectApplyAuraName[2] = SPELL_AURA_DUMMY;
    });

    // Strength of Wrynn
    ApplySpellFix({ 60509 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[2] = 1500;
        spellInfo->EffectBasePoints[1] = 150;
        spellInfo->EffectApplyAuraName[1] = SPELL_AURA_PERIODIC_HEAL;
    });

    // Winterfin First Responder
    ApplySpellFix({ 48739 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[0] = 1;
        spellInfo->EffectRealPointsPerLevel[0] = 0;
        spellInfo->EffectDieSides[0] = 0;
        spellInfo->EffectDamageMultiplier[0] = 0;
        spellInfo->EffectBonusMultiplier[0] = 0;
    });

    // Army of the Dead (trigger npc aura)
    ApplySpellFix({ 49099 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectAmplitude[0] = 15000;
    });

    // Isle of Conquest
    ApplySpellFix({ 66551 }, [](SpellEntry* spellInfo)
    {
        // Teleport in, missing range
        spellInfo->RangeIndex = 13; // 50000yd
    });

    // A'dal's Song of Battle
    ApplySpellFix({ 39953 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_SRC_CASTER;
        spellInfo->EffectImplicitTargetA[EFFECT_1] = TARGET_SRC_CASTER;
        spellInfo->EffectImplicitTargetA[EFFECT_2] = TARGET_SRC_CASTER;
        spellInfo->EffectImplicitTargetB[EFFECT_0] = TARGET_UNIT_SRC_AREA_ALLY;
        spellInfo->EffectImplicitTargetB[EFFECT_1] = TARGET_UNIT_SRC_AREA_ALLY;
        spellInfo->EffectImplicitTargetB[EFFECT_2] = TARGET_UNIT_SRC_AREA_ALLY;
        spellInfo->DurationIndex = 367; // 2 Hours
    });

    ApplySpellFix({
        57607,  // WintergraspCatapult - Spell Plague Barrel - EffectRadiusIndex
        57619,  // WintergraspDemolisher - Spell Hourl Boulder - EffectRadiusIndex
        57610   // Cannon (Siege Turret)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_25_YARDS; // SPELL_EFFECT_WMO_DAMAGE
    });

    // WintergraspCannon - Spell Fire Cannon - EffectRadiusIndex
    ApplySpellFix({ 51422 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_10_YARDS; // SPELL_EFFECT_SCHOOL_DAMAGE
    });

    // WintergraspDemolisher - Spell Ram -  EffectRadiusIndex
    ApplySpellFix({ 54107 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_3_YARDS; // SPELL_EFFECT_KNOCK_BACK
        spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_3_YARDS; // SPELL_EFFECT_SCHOOL_DAMAGE
        spellInfo->EffectRadiusIndex[2] = EFFECT_RADIUS_3_YARDS; // SPELL_EFFECT_WEAPON_DAMAGE
    });

    // WintergraspSiegeEngine - Spell Ram - EffectRadiusIndex
    ApplySpellFix({ 51678 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_10_YARDS; // SPELL_EFFECT_KNOCK_BACK
        spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_10_YARDS; // SPELL_EFFECT_SCHOOL_DAMAGE
        spellInfo->EffectRadiusIndex[2] = EFFECT_RADIUS_20_YARDS; // SPELL_EFFECT_WEAPON_DAMAGE
    });

    // WintergraspCatapult - Spell Plague Barrell - Range
    ApplySpellFix({ 57606 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 164; // "Catapult Range"
    });

    // Boulder (Demolisher)
    ApplySpellFix({ 50999 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[EFFECT_0] = 13; // 10yd
    });

    // Flame Breath (Catapult)
    ApplySpellFix({ 50990 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[EFFECT_0] = 19; // 18yd
    });

    // Jormungar Bite
    ApplySpellFix({ 56103 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_UNIT_TARGET_ENEMY;
        spellInfo->EffectImplicitTargetB[EFFECT_0] = 0;
    });

    // Throw Proximity Bomb
    ApplySpellFix({ 34095 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_DEST_TARGET_ENEMY;
        spellInfo->EffectImplicitTargetB[EFFECT_0] = 0;
    });

    ApplySpellFix({
        53348,  // DEATH KNIGHT SCARLET FIRE ARROW
        53117   // BALISTA
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->RecoveryTime = 5000;
        spellInfo->CategoryRecoveryTime = 5000;
    });

    // Teleport To Molten Core
    ApplySpellFix({ 25139 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALLOW_AURA_WHILE_DEAD;
    });

    // Landen Stilwell Transform
    ApplySpellFix({ 31310 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_PASSIVE;
    });

    // Shadowstalker Stealth
    ApplySpellFix({ 5916 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRealPointsPerLevel[EFFECT_0] = 5.0f;
    });

    // Sneak
    ApplySpellFix({ 22766 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRealPointsPerLevel[EFFECT_0] = 5.0f;
    });

    // Murmur's Touch
    ApplySpellFix({ 38794, 33711 }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
        spellInfo->EffectTriggerSpell[0] = 33760;
    });

    // Negaton Field
    ApplySpellFix({
        36729,  // Normal
        38834   // Heroic
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Curse of the Doomsayer NORMAL
    ApplySpellFix({ 36173 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[0] = 36174; // Currently triggers heroic version...
    });

    // Crystal Channel
    ApplySpellFix({ 34156 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 35; // 35yd;
        spellInfo->ChannelInterruptFlags |= AURA_INTERRUPT_FLAG_MOVE;
    });

    // Debris
    ApplySpellFix({ 36449 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_AURA_IS_DEBUFF;
    });

    // Soul Channel
    ApplySpellFix({ 30531 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Debris Visual
    ApplySpellFix({ 30632 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetB[0] = TARGET_DEST_DYNOBJ_ALLY;
    });

    // Activate Sunblade Protecto
    ApplySpellFix({ 46475, 46476 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 14; // 60yd
    });

    // Break Ice
    ApplySpellFix({ 46638 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 &= ~SPELL_ATTR3_ONLY_ON_PLAYER; // Obvious fail, it targets gameobject...
    });

    // Sinister Reflection Clone
    ApplySpellFix({ 45785 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Speed = 0.0f;
    });

    // Armageddon
    ApplySpellFix({ 45909 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Speed = 8.0f;
    });

    // Spell Absorption
    ApplySpellFix({ 41034 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[EFFECT_2] = SPELL_EFFECT_APPLY_AURA;
        spellInfo->EffectApplyAuraName[EFFECT_2] = SPELL_AURA_SCHOOL_ABSORB;
        spellInfo->EffectImplicitTargetA[EFFECT_2] = TARGET_UNIT_CASTER;
        spellInfo->EffectMiscValue[EFFECT_2] = SPELL_SCHOOL_MASK_MAGIC;
    });

    // Shared Bonds
    ApplySpellFix({ 41363 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx &= ~SPELL_ATTR1_IS_CHANNELED;
    });

    ApplySpellFix({
        41485,  // Deadly Poison
        41487   // Envenom
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx6 |= SPELL_ATTR6_IGNORE_PHASE_SHIFT;
    });

    // Parasitic Shadowfiend
    ApplySpellFix({ 41914 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_AURA_IS_DEBUFF;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Teleport Maiev
    ApplySpellFix({ 41221 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 13; // 0-50000yd
    });

    // Watery Grave Explosion
    ApplySpellFix({ 37852 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx5 |= SPELL_ATTR5_ALLOW_WHILE_STUNNED;
    });

    // Amplify Damage
    ApplySpellFix({ 39095 }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
    });

    // Energy Feedback
    ApplySpellFix({ 44335 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CHANGE_MAP;
    });

    ApplySpellFix({
        31984,  // Finger of Death
        35354   // Hand of Death
        }, [](SpellEntry* spellInfo)
    {
        // Spell doesn't need to ignore invulnerabilities
        spellInfo->Attributes = SPELL_ATTR0_IS_ABILITY;
    });

    // Finger of Death
    ApplySpellFix({ 32111 }, [](SpellEntry* spellInfo)
    {
        spellInfo->CastingTimeIndex = 0;    // We only need the animation, no damage
    });

    // Flame Breath, catapult spell
    ApplySpellFix({ 50989 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes &= ~SPELL_ATTR0_SCALES_WITH_CREATURE_LEVEL;
    });

    // Koralon, Flaming Cinder
    ApplySpellFix({ 66690 }, [](SpellEntry* spellInfo)
    {
        // missing radius index
        spellInfo->EffectRadiusIndex[0] = 12; //100yd
        spellInfo->MaxAffectedTargets = 1;
    });

    // Acid Volley
    ApplySpellFix({ 54714, 29325 }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
    });

    // Summon Plagued Warrior
    ApplySpellFix({ 29237 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = SPELL_EFFECT_DUMMY;
        spellInfo->Effect[1] = spellInfo->Effect[2] = 0;
    });

    // Icebolt
    ApplySpellFix({ 28526 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
    });

    // Infected Wound
    ApplySpellFix({ 29306 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Hopeless
    ApplySpellFix({ 29125 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENTRY;
    });

    // Jagged Knife
    ApplySpellFix({ 55550 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_USES_RANGED_SLOT;
    });

    // Moorabi - Transformation
    ApplySpellFix({ 55098 }, [](SpellEntry* spellInfo)
    {
        spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
    });

    ApplySpellFix({
        55521,  // Poisoned Spear (Normal)
        58967,  // Poisoned Spear (Heroic)
        55348,  // Throw (Normal)
        58966   // Throw (Heroic)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_USES_RANGED_SLOT;
    });

    // Charged Chaotic rift aura, trigger
    ApplySpellFix({ 47737 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 37; // 50yd
    });

    // Vanish
    ApplySpellFix({ 55964 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[1] = 0;
        spellInfo->Effect[2] = 0;
    });

    // Trollgore - Summon Drakkari Invader
    ApplySpellFix({ 49456, 49457, 49458 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DB;
    });

    ApplySpellFix({
        48278,  // Paralyse
        47669   // Awaken subboss
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
        spellInfo->EffectImplicitTargetB[0] = 0;
    });

    // Flame Breath
    ApplySpellFix({ 47592 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectAmplitude[0] = 200;
    });

    // Skarvald, Charge
    ApplySpellFix({ 43651 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 13; // 0-50000yd
    });

    // Ingvar the Plunderer, Woe Strike
    ApplySpellFix({ 42730 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[1] = 42739;
    });

    ApplySpellFix({ 59735 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[1] = 59736;
    });

    // Ingvar the Plunderer, Ingvar transform
    ApplySpellFix({ 42796 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALLOW_AURA_WHILE_DEAD;
    });

    ApplySpellFix({
        42772,  // Hurl Dagger (Normal)
        59685   // Hurl Dagger (Heroic)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_USES_RANGED_SLOT;
    });

    // Control Crystal Activation
    ApplySpellFix({ 57804 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = 1;
        spellInfo->EffectImplicitTargetB[0] = 0;
    });

    // Destroy Door Seal
    ApplySpellFix({ 58040 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ChannelInterruptFlags &= ~(AURA_INTERRUPT_FLAG_HITBYSPELL | AURA_INTERRUPT_FLAG_TAKE_DAMAGE);
    });

    // Ichoron, Water Blast
    ApplySpellFix({ 54237, 59520 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Krik'thir - Mind Flay
    ApplySpellFix({ 52586, 59367 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ChannelInterruptFlags |= AURA_INTERRUPT_FLAG_MOVE;
    });

    // Glare of the Tribunal
    ApplySpellFix({ 50988, 59870 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
        spellInfo->EffectImplicitTargetB[0] = 0;
    });

    // Static Charge
    ApplySpellFix({ 50835, 59847 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ALLY;
    });

    // Lava Strike damage
    ApplySpellFix({ 57697 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
    });

    // Lava Strike trigger
    ApplySpellFix({ 57578 }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
    });

    // Gift of Twilight Shadow/Fire
    ApplySpellFix({ 57835, 58766 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx &= ~SPELL_ATTR1_IS_CHANNELED;
    });

    // Pyrobuffet
    ApplySpellFix({ 57557 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 56911;
    });

    // Arcane Barrage
    ApplySpellFix({ 56397 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ENEMY;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_TARGET_ENEMY;
        spellInfo->EffectImplicitTargetB[1] = 0;
        spellInfo->EffectImplicitTargetA[2] = TARGET_UNIT_TARGET_ENEMY;
        spellInfo->EffectImplicitTargetB[2] = 0;
    });

    ApplySpellFix({
        55849,  // Power Spark (ground +50% dmg aura)
        56438,  // Arcane Overload (-50% dmg taken) - this is to prevent apply -> unapply -> apply ... dunno whether it's correct
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Vortex (Control Vehicle)
    ApplySpellFix({ 56263 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Haste (Nexus Lord, increase run Speed of the disk)
    ApplySpellFix({ 57060 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[2] = TARGET_UNIT_VEHICLE;
    });

    // Arcane Overload
    ApplySpellFix({ 56430 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = SPELL_EFFECT_TRIGGER_MISSILE;
        spellInfo->EffectTriggerSpell[0] = 56429;
    });

    // Summon Arcane Bomb
    ApplySpellFix({ 56429 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->EffectImplicitTargetA[1] = 0;
        spellInfo->EffectImplicitTargetB[1] = 0;
        spellInfo->EffectImplicitTargetA[2] = 0;
        spellInfo->EffectImplicitTargetB[2] = 0;
    });

    // Destroy Platform Event
    ApplySpellFix({ 59099 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[1] = 22;
        spellInfo->EffectImplicitTargetB[1] = 15;
        spellInfo->EffectImplicitTargetA[2] = 22;
        spellInfo->EffectImplicitTargetB[2] = 15;
    });

    // Surge of Power (Phase 3)
    ApplySpellFix({
        57407,  // N
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
        spellInfo->InterruptFlags = 0;
        spellInfo->EffectRadiusIndex[0] = 28;
        spellInfo->AttributesEx4 |= SPELL_ATTR4_ALLOW_CAST_WHILE_CASTING;
        spellInfo->EffectImplicitTargetA[0] = TARGET_SRC_CASTER;
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENEMY;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Surge of Power (Phase 3)
    ApplySpellFix({
        60936   // H
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 3;
        spellInfo->InterruptFlags = 0;
        spellInfo->EffectRadiusIndex[0] = 28;
        spellInfo->AttributesEx4 |= SPELL_ATTR4_ALLOW_CAST_WHILE_CASTING;
        spellInfo->EffectImplicitTargetA[0] = TARGET_SRC_CASTER;
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENEMY;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Wyrmrest Drake - Life Burst
    ApplySpellFix({ 57143 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = 0;
        spellInfo->EffectImplicitTargetA[0] = 0;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->EffectImplicitTargetA[1] = TARGET_SRC_CASTER;
        spellInfo->EffectImplicitTargetB[1] = TARGET_UNIT_SRC_AREA_ALLY;
        spellInfo->EffectPointsPerComboPoint[1] = 2500;
        spellInfo->EffectBasePoints[1] = 2499;
        spellInfo->RangeIndex = 1;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    //Alexstrasza - Gift
    ApplySpellFix({ 61028 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
    });

    // Vortex (freeze anim)
    ApplySpellFix({ 55883 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CHANGE_MAP;
    });

    // Hurl Pyrite
    ApplySpellFix({ 62490 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[EFFECT_1] = 0;
    });

    // Ulduar, Mimiron, Magnetic Core (summon)
    ApplySpellFix({ 64444 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_CASTER;
    });

    // Ulduar, Mimiron, bomb bot explosion
    ApplySpellFix({ 63801 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectMiscValue[1] = 17286;
    });

    // Ulduar, Mimiron, Summon Flames Initial
    ApplySpellFix({ 64563 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
        spellInfo->EffectImplicitTargetB[0] = 0;
    });

    // Ulduar, Mimiron, Flames (damage)
    ApplySpellFix({ 64566 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->AttributesEx4 &= ~SPELL_ATTR4_NO_CAST_LOG;
    });

    // Ulduar, Hodir, Starlight
    ApplySpellFix({ 62807 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = 16; // 1yd
    });

    // Hodir Shatter Cache
    ApplySpellFix({ 62502 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_SRC_AREA_ENTRY;
    });

    // Ulduar, General Vezax, Mark of the Faceless
    ApplySpellFix({ 63278 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = 0;
    });

    // Boom (XT-002)
    ApplySpellFix({ 62834 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[EFFECT_1] = 0;
    });

    // Supercharge
    ApplySpellFix({ 61920 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Lightning Whirl
    ApplySpellFix({ 61916 }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 3;
    });

    ApplySpellFix({ 63482 }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 8;
    });

    // Stone Grip, remove absorb aura
    ApplySpellFix({ 62056, 63985 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[1] = 0;
    });

    // Sentinel Blast
    ApplySpellFix({ 64389, 64678 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Dispel = DISPEL_MAGIC;
    });

    // Potent Pheromones
    ApplySpellFix({ 62619 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_IMMUNITY_PURGES_EFFECT;
    });

    // Healthy spore summon periodic
    ApplySpellFix({ 62566 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectAmplitude[0] = 2000;
        spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_TRIGGER_SPELL;
    });

    // Brightleaf Essence trigger
    ApplySpellFix({ 62968 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[1] = 0; // duplicate
    });

    // Potent Pheromones
    ApplySpellFix({ 64321 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ONLY_ON_PLAYER;
        spellInfo->AttributesEx |= SPELL_ATTR1_IMMUNITY_PURGES_EFFECT;
    });

    // Lightning Orb Charged
    ApplySpellFix({ 62186 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectAmplitude[0] = 5000; // Duration 5 secs, amplitude 8 secs...
    });

    // Lightning Pillar
    ApplySpellFix({ 62976 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 6;
        spellInfo->DurationIndex = 28;
    });

    // Sif's Blizzard
    ApplySpellFix({ 62576, 62602 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = 14; // 8yd
        spellInfo->EffectRadiusIndex[1] = 14; // 8yd
    });

    // Protective Gaze
    ApplySpellFix({ 64175 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RecoveryTime = 25000;
    });

    // Shadow Beacon
    ApplySpellFix({ 64465 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[0] = 64467; // why do they need two script effects :/ (this one has visual effect)
    });

    // Sanity
    ApplySpellFix({ 63050 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx6 |= SPELL_ATTR6_IGNORE_PHASE_SHIFT;
    });

    // Shadow Nova
    ApplySpellFix({ 62714, 65209 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Cosmic Smash (Algalon the Observer)
    ApplySpellFix({ 62293 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetB[0] = TARGET_DEST_CASTER;
    });

    // Cosmic Smash (Algalon the Observer)
    ApplySpellFix({ 62311, 64596 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->EffectRadiusIndex[0] = 12; // 100yd
        spellInfo->RangeIndex = 13;  // 50000yd
    });

    // Constellation Phase Effect
    ApplySpellFix({ 65509 }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
    });

    // Black Hole
    ApplySpellFix({ 62168, 65250, 62169 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_AURA_IS_DEBUFF;
    });

    // Ground Slam
    ApplySpellFix({ 62625 }, [](SpellEntry* spellInfo)
    {
        spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
    });

    // Onyxia's Lair, Onyxia, Flame Breath (TriggerSpell = 0 and spamming errors in console)
    ApplySpellFix({ 18435 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[1] = 0;
    });

    // Onyxia's Lair, Onyxia, Create Onyxia Spawner
    ApplySpellFix({ 17647 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 37;
    });

    ApplySpellFix({
        17646,  // Onyxia's Lair, Onyxia, Summon Onyxia Whelp
        68968   // Onyxia's Lair, Onyxia, Summon Lair Guard
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
        spellInfo->RangeIndex = 13;
        spellInfo->DurationIndex = 5;
    });

    // Onyxia's Lair, Onyxia, Eruption
    ApplySpellFix({ 17731, 69294 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[1] = SPELL_EFFECT_DUMMY;
        spellInfo->CastingTimeIndex = 3;
        spellInfo->EffectRadiusIndex[1] = 19; // 18yd instead of 13yd to make sure all cracks erupt
    });

    // Onyxia's Lair, Onyxia, Breath
    ApplySpellFix({
        18576, 18578, 18579, 18580, 18581, 18582, 18583, 18609, 18611, 18612, 18613, 18614, 18615, 18616, 18584,
        18585, 18586, 18587, 18588, 18589, 18590, 18591, 18592, 18593, 18594, 18595, 18564, 18565, 18566, 18567,
        18568, 18569, 18570, 18571, 18572, 18573, 18574, 18575, 18596, 18597, 18598, 18599, 18600, 18601, 18602,
        18603, 18604, 18605, 18606, 18607, 18617, 18619, 18620, 18621, 18622, 18623, 18624, 18625, 18626, 18627,
        18628, 18618, 18351, 18352, 18353, 18354, 18355, 18356, 18357, 18358, 18359, 18360, 18361, 17086, 17087,
        17088, 17089, 17090, 17091, 17092, 17093, 17094, 17095, 17097, 22267, 22268, 21132, 21133, 21135, 21136,
        21137, 21138, 21139
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 328; // 250ms
        spellInfo->EffectImplicitTargetA[1] = 1;
        if (spellInfo->Effect[1])
        {
            spellInfo->Effect[1] = SPELL_EFFECT_APPLY_AURA;
            spellInfo->EffectApplyAuraName[1] = SPELL_AURA_PERIODIC_TRIGGER_SPELL;
            spellInfo->EffectAmplitude[1] = ((spellInfo->CastingTimeIndex == 170) ? 50 : 215);
        }
    });

    ApplySpellFix({
        48760,  // Oculus, Teleport to Coldarra DND
        49305   // Oculus, Teleport to Boss 1 DND
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = 25;
        spellInfo->EffectImplicitTargetB[0] = 17;
    });

    // Oculus, Drake spell Stop Time
    ApplySpellFix({ 49838 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
        spellInfo->ExcludeTargetAuraSpell = 51162; // exclude planar shift
        spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_150_YARDS;
    });

    // Oculus, Varos Cloudstrider, Energize Cores
    ApplySpellFix({ 61407, 62136, 56251, 54069 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CONE_ENTRY;
        spellInfo->EffectImplicitTargetB[0] = 0;
    });

    // Halls of Lightning, Arc Weld
    ApplySpellFix({ 59086 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = 1;
    });

    // Halls of Lightning, Arcing Burn
    ApplySpellFix({ 52671, 59834 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Trial of the Champion, Death's Respite
    ApplySpellFix({ 68306 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = 25;
        spellInfo->EffectImplicitTargetA[1] = 25;
    });

    // Trial of the Champion, Eadric Achievement (The Faceroller)
    ApplySpellFix({ 68197 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ALLY;
        spellInfo->Attributes |= SPELL_ATTR0_ALLOW_CAST_WHILE_DEAD;
    });

    // Trial of the Champion, Earth Shield
    ApplySpellFix({ 67530 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PROC_TRIGGER_SPELL; // will trigger 67537
    });

    // Trial of the Champion, Hammer of the Righteous
    ApplySpellFix({ 66867 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = SPELL_EFFECT_DUMMY;
    });

    // Trial of the Champion, Summon Risen Jaeren/Arelas
    ApplySpellFix({ 67705, 67715 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_ALLOW_DEAD_TARGET;
    });

    // Trial of the Champion, Ghoul Explode
    ApplySpellFix({ 67751 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_SRC_CASTER;
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENTRY;
        spellInfo->EffectRadiusIndex[0] = 12;
        spellInfo->EffectImplicitTargetA[1] = TARGET_SRC_CASTER;
        spellInfo->EffectImplicitTargetB[1] = TARGET_UNIT_SRC_AREA_ENTRY;
        spellInfo->EffectRadiusIndex[1] = 12;
        spellInfo->EffectImplicitTargetA[2] = TARGET_SRC_CASTER;
        spellInfo->EffectImplicitTargetB[2] = TARGET_UNIT_SRC_AREA_ENTRY;
        spellInfo->EffectRadiusIndex[2] = 12;
    });

    // Trial of the Champion, Desecration
    ApplySpellFix({ 67778, 67877 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[0] = 68766;
    });

    // Killing Spree (Off hand damage)
    ApplySpellFix({ 57842 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 2; // Melee Range
    });

    // Trial of the Crusader, Jaraxxus Intro spell
    ApplySpellFix({ 67888 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT;
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_THREAT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Trial of the Crusader, Lich King Intro spell
    ApplySpellFix({ 68193 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENEMY;
    });

    // Trial of the Crusader, Gormok, player vehicle spell, CUSTOM! (default jump to hand, not used)
    ApplySpellFix({ 66342 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = SPELL_EFFECT_APPLY_AURA;
        spellInfo->EffectApplyAuraName[0] = SPELL_AURA_SET_VEHICLE_ID;
        spellInfo->EffectMiscValue[0] = 496;
        spellInfo->DurationIndex = 21;
        spellInfo->RangeIndex = 13;
        spellInfo->EffectImplicitTargetA[0] = 25;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->AuraInterruptFlags = AURA_INTERRUPT_FLAG_CHANGE_MAP;
    });

    // Trial of the Crusader, Gormok, Fire Bomb
    ApplySpellFix({ 66313 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
        spellInfo->EffectImplicitTargetB[0] = TARGET_DEST_TARGET_ANY;
        spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_TARGET_ANY;
        spellInfo->EffectImplicitTargetB[1] = TARGET_DEST_TARGET_ANY;
        spellInfo->Effect[1] = 0;
    });

    ApplySpellFix({ 66317 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT;
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_THREAT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    ApplySpellFix({ 66318 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->Speed = 14.0f;
        spellInfo->Attributes |= SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT;
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_THREAT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    ApplySpellFix({ 66320, 67472, 67473, 67475 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = 7;
        spellInfo->EffectRadiusIndex[1] = 7;
    });

    // Trial of the Crusader, Acidmaw & Dreadscale, Emerge
    ApplySpellFix({ 66947 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx5 |= SPELL_ATTR5_ALLOW_WHILE_STUNNED;
    });

    // Trial of the Crusader, Jaraxxus, Curse of the Nether
    ApplySpellFix({ 66211 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 66209; // exclude Touch of Jaraxxus
    });

    // Trial of the Crusader, Jaraxxus, Summon Volcano
    ApplySpellFix({ 66258, 67901 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 85; // summon for 18 seconds, 15 not enough
    });

    // Trial of the Crusader, Jaraxxus, Spinning Pain Spike
    ApplySpellFix({ 66281 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = 26;
    });

    ApplySpellFix({ 66287 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[1] = SPELL_EFFECT_APPLY_AURA;
        spellInfo->EffectApplyAuraName[1] = SPELL_AURA_MOD_TAUNT;
        spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_NEARBY_ENTRY;
        spellInfo->Effect[2] = SPELL_EFFECT_APPLY_AURA;
        spellInfo->EffectApplyAuraName[2] = SPELL_AURA_MOD_STUN;
        spellInfo->EffectImplicitTargetA[2] = TARGET_UNIT_CASTER;
        spellInfo->DurationIndex = 35; // 4 secs
    });

    // Trial of the Crusader, Jaraxxus, Fel Fireball
    ApplySpellFix({ 66532, 66963, 66964, 66965 }, [](SpellEntry* spellInfo)
    {
        spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
    });

    // tempfix, make Nether Power not stealable
    ApplySpellFix({ 66228, 67106, 67107, 67108 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx4 |= SPELL_ATTR4_CANNOT_BE_STOLEN;
    });

    // Trial of the Crusader, Faction Champions, Druid - Tranquality
    ApplySpellFix({ 66086, 67974, 67975, 67976 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = SPELL_EFFECT_APPLY_AREA_AURA_FRIEND;
    });

    // Trial of the Crusader, Faction Champions, Shaman - Earth Shield
    ApplySpellFix({ 66063 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PROC_TRIGGER_SPELL;
        spellInfo->EffectTriggerSpell[0] = 66064;
    });

    // Trial of the Crusader, Faction Champions, Priest - Mana Burn
    ApplySpellFix({ 66100 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[0] = 5;
        spellInfo->EffectDieSides[0] = 0;
    });

    ApplySpellFix({ 68026 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[0] = 8;
        spellInfo->EffectDieSides[0] = 0;
    });

    ApplySpellFix({ 68027 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[0] = 6;
        spellInfo->EffectDieSides[0] = 0;
    });

    ApplySpellFix({ 68028 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[0] = 10;
        spellInfo->EffectDieSides[0] = 0;
    });

    // Trial of the Crusader, Twin Valkyr, Touch of Light/Darkness, Light/Dark Surge
    ApplySpellFix({
        65950   // light 0
        }, [](SpellEntry* spellInfo)
    {
        //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->EffectImplicitTargetA[0] = 6;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->Effect[1] = 0;
        spellInfo->Effect[2] = 0;
    });

    ApplySpellFix({
        65767   // light surge 0
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 65686;
    });

    ApplySpellFix({
        67296   // light 1
        }, [](SpellEntry* spellInfo)
    {
        //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->EffectImplicitTargetA[0] = 6;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->Effect[1] = 0;
        spellInfo->Effect[2] = 0;
    });

    ApplySpellFix({
        67274   // light surge 1
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 67222;
    });

    ApplySpellFix({
        67297   // light 2
        }, [](SpellEntry* spellInfo)
    {
        //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->EffectImplicitTargetA[0] = 6;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->Effect[1] = 0;
        spellInfo->Effect[2] = 0;
    });

    ApplySpellFix({
        67275   // light surge 2
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 67223;
    });

    ApplySpellFix({
        67298   // light 3
        }, [](SpellEntry* spellInfo)
    {
        //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->EffectImplicitTargetA[0] = 6;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->Effect[1] = 0;
        spellInfo->Effect[2] = 0;
    });

    ApplySpellFix({
        67276   // light surge 3
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 67224;
    });

    ApplySpellFix({
        66001   // dark 0
        }, [](SpellEntry* spellInfo)
    {
        //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->EffectImplicitTargetA[0] = 6;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->Effect[1] = 0;
        spellInfo->Effect[2] = 0;
    });

    ApplySpellFix({
        65769   // dark surge 0
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 65684;
    });

    ApplySpellFix({
        67281   // dark 1
        }, [](SpellEntry* spellInfo)
    {
        //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->EffectImplicitTargetA[0] = 6;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->Effect[1] = 0;
        spellInfo->Effect[2] = 0;
    });

    ApplySpellFix({
        67265   // dark surge 1
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 67176;
    });

    ApplySpellFix({
        67282   // dark 2
        }, [](SpellEntry* spellInfo)
    {
        //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->EffectImplicitTargetA[0] = 6;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->Effect[1] = 0;
        spellInfo->Effect[2] = 0;
    });

    ApplySpellFix({
        67266   // dark surge 2
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 67177;
    });

    ApplySpellFix({
        67283   // dark 3
        }, [](SpellEntry* spellInfo)
    {
        //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->EffectImplicitTargetA[0] = 6;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->Effect[1] = 0;
        spellInfo->Effect[2] = 0;
    });

    ApplySpellFix({
        67267   // dark surge 3
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 67178;
    });

    // Trial of the Crusader, Twin Valkyr, Twin's Pact
    ApplySpellFix({ 65875, 67303, 67304, 67305, 65876, 67306, 67307, 67308 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[1] = 0;
        spellInfo->Effect[2] = 0;
    });

    // Trial of the Crusader, Anub'arak, Emerge
    ApplySpellFix({ 65982 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx5 |= SPELL_ATTR5_ALLOW_WHILE_STUNNED;
    });

    // Trial of the Crusader, Anub'arak, Penetrating Cold
    ApplySpellFix({ 66013, 67700, 68509, 68510 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = 12; // 100yd
    });

    // Trial of the Crusader, Anub'arak, Shadow Strike
    ApplySpellFix({ 66134 }, [](SpellEntry* spellInfo)
    {
        spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
        spellInfo->Effect[0] = 0;
    });

    // Trial of the Crusader, Anub'arak, Pursuing Spikes
    ApplySpellFix({ 65920, 65922, 65923 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
        //spellInfo->EffectTriggerSpell[0] = 0;
    });

    // Trial of the Crusader, Anub'arak, Summon Scarab
    ApplySpellFix({ 66339 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 35;
        spellInfo->EffectImplicitTargetA[0] = 25;
        spellInfo->EffectImplicitTargetB[0] = 0;
    });

    // Trial of the Crusader, Anub'arak, Achievements: The Traitor King
    ApplySpellFix({
        68186,  // Anub'arak Scarab Achievement 10
        68515   // Anub'arak Scarab Achievement 25
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_SRC_CASTER;
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENEMY;
        spellInfo->Attributes |= SPELL_ATTR0_ALLOW_CAST_WHILE_DEAD;
    });

    // Trial of the Crusader, Anub'arak, Spider Frenzy
    ApplySpellFix({ 66129 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Soul Sickness
    ApplySpellFix({ 69131 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_TRIGGER_SPELL;
        spellInfo->EffectAmplitude[0] = 8000;
        spellInfo->EffectTriggerSpell[0] = 69133;
    });

    // Phantom Blast
    ApplySpellFix({ 68982, 70322 }, [](SpellEntry* spellInfo)
    {
        spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
    });

    // Empowered Blizzard
    ApplySpellFix({ 70131 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
    });

    // Ice Lance Volley
    ApplySpellFix({ 70464 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_SRC_CASTER;
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENTRY;
        spellInfo->EffectRadiusIndex[0] = 25;
    });

    ApplySpellFix({
        70513,   // Multi-Shot
        59514    // Shriek of the Highborne
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CONE_ENTRY;
        spellInfo->EffectImplicitTargetB[0] = 0;
    });

    // Icicle
    ApplySpellFix({ 69428, 69426 }, [](SpellEntry* spellInfo)
    {
        spellInfo->InterruptFlags = 0;
        spellInfo->AuraInterruptFlags = 0;
        spellInfo->ChannelInterruptFlags = 0;
    });

    ApplySpellFix({ 70525, 70639 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = 0;
        spellInfo->Effect[1] = 0;
        spellInfo->EffectImplicitTargetA[2] = TARGET_SRC_CASTER;
        spellInfo->EffectImplicitTargetB[2] = TARGET_UNIT_SRC_AREA_ENTRY;
        spellInfo->EffectRadiusIndex[2] = 30; // 500yd
    });

    // Frost Nova
    ApplySpellFix({ 68198 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 13;
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
    });

    // Blight
    ApplySpellFix({ 69604, 70286 }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
        spellInfo->AttributesEx3 |= (SPELL_ATTR3_ALWAYS_HIT | SPELL_ATTR3_ONLY_ON_PLAYER);
    });

    // Chilling Wave
    ApplySpellFix({ 68778, 70333 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_TARGET_ENEMY;
        spellInfo->EffectImplicitTargetB[0] = 0;
    });

    ApplySpellFix({ 68786, 70336 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= (SPELL_ATTR3_ALWAYS_HIT | SPELL_ATTR3_ONLY_ON_PLAYER);
        spellInfo->Effect[2] = SPELL_EFFECT_DUMMY;
    });

    // Pursuit
    ApplySpellFix({ 68987 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_TARGET_ANY;
        spellInfo->EffectImplicitTargetB[1] = 0;
        spellInfo->EffectImplicitTargetA[2] = TARGET_UNIT_CASTER;
        spellInfo->EffectImplicitTargetB[2] = 0;
        spellInfo->RangeIndex = 6; // 100yd
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    ApplySpellFix({ 69029, 70850 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[2] = 0;
    });

    // Explosive Barrage
    ApplySpellFix({ 69263 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectApplyAuraName[0] = SPELL_AURA_MOD_STUN;
    });

    // Overlord's Brand
    ApplySpellFix({ 69172 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ProcFlags = DONE_HIT_PROC_FLAG_MASK & ~PROC_FLAG_DONE_PERIODIC;
        spellInfo->ProcChance = 100;
    });

    // Icy Blast
    ApplySpellFix({ 69232 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[1] = 69238;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    ApplySpellFix({ 69233, 69646 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    ApplySpellFix({ 69238, 69628 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
        spellInfo->EffectImplicitTargetB[0] = TARGET_DEST_DYNOBJ_NONE;
        spellInfo->EffectImplicitTargetA[1] = TARGET_DEST_DEST;
        spellInfo->EffectImplicitTargetB[1] = TARGET_DEST_DYNOBJ_NONE;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Hoarfrost
    ApplySpellFix({ 69246, 69245, 69645 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Devour Humanoid
    ApplySpellFix({ 69503 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ChannelInterruptFlags |= 0;
        spellInfo->AuraInterruptFlags = AURA_INTERRUPT_FLAG_MOVE | AURA_INTERRUPT_FLAG_TURNING;
    });

    // Falric: Defiling Horror
    ApplySpellFix({ 72435, 72452 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;
        spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_200_YARDS;
    });

    // Frostsworn General - Throw Shield
    ApplySpellFix({ 69222, 73076 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[2] = TARGET_UNIT_TARGET_ENEMY;
    });

    // Halls of Reflection Clone
    ApplySpellFix({ 69828 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[1] = 0;
        spellInfo->Effect[2] = 0;
    });

    // Summon Ice Wall
    ApplySpellFix({ 69768 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
    });

    ApplySpellFix({ 69767 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_TARGET_ANY;
        spellInfo->EffectImplicitTargetA[2] = TARGET_UNIT_TARGET_ANY;
    });

    // Essence of the Captured
    ApplySpellFix({ 73035, 70719 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 13;
    });

    // Achievement Check
    ApplySpellFix({ 72830 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;
    });

    ApplySpellFix({
        70781,  // Light's Hammer Teleport
        70856,  // Oratory of the Damned Teleport
        70857,  // Rampart of Skulls Teleport
        70858,  // Deathbringer's Rise Teleport
        70859,  // Upper Spire Teleport
        70860,  // Frozen Throne Teleport
        70861   // Sindragosa's Lair Teleport
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->EffectImplicitTargetA[1] = TARGET_DEST_DB;   // this target is for SPELL_EFFECT_TELEPORT_UNITS
        spellInfo->EffectImplicitTargetB[1] = 0;
        spellInfo->EffectImplicitTargetA[2] = TARGET_UNIT_TARGET_ANY;
        spellInfo->EffectImplicitTargetB[2] = 0;
    });

    ApplySpellFix({
        70960,  // Bone Flurry
        71258   // Adrenaline Rush (Ymirjar Battle-Maiden)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx &= ~SPELL_ATTR1_IS_SELF_CHANNELED;
    });

    // Saber Lash (Lord Marrowgar)
    ApplySpellFix({ 69055, 70814 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = 8;    // 5yd
    });

    // Impaled (Lord Marrowgar)
    ApplySpellFix({ 69065 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = 0;   // remove stun so Dispersion can be used
    });

    // Cold Flame (Lord Marrowgar)
    ApplySpellFix({ 72701, 72702, 72703, 72704 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
        spellInfo->EffectImplicitTargetA[1] = TARGET_DEST_DEST;
        spellInfo->EffectImplicitTargetB[1] = 0;
        spellInfo->DurationIndex = 9;   // 30 secs instead of 12, need him for longer, but will stop his actions after 12 secs
    });

    ApplySpellFix({ 69138 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = 0;
        spellInfo->EffectImplicitTargetA[1] = TARGET_DEST_DEST;
        spellInfo->DurationIndex = 9;   // 30 secs instead of 12, need him for longer, but will stop his actions after 12 secs
    });

    ApplySpellFix({ 69146, 70823, 70824, 70825 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = 15;   // 3yd instead of 5yd
        spellInfo->AttributesEx4 &= ~SPELL_ATTR4_NO_CAST_LOG;
    });

    // Dark Martyrdom (Lady Deathwhisper)
    ApplySpellFix({ 70897 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_ALLOW_DEAD_TARGET;
    });

    ApplySpellFix({
        69075,  // Bone Storm (Lord Marrowgar)
        70834,  // Bone Storm (Lord Marrowgar)
        70835,  // Bone Storm (Lord Marrowgar)
        70836,  // Bone Storm (Lord Marrowgar)
        72378,  // Blood Nova (Deathbringer Saurfang)
        73058,  // Blood Nova (Deathbringer Saurfang)
        72769,  // Scent of Blood (Deathbringer Saurfang)
        72385,  // Boiling Blood (Deathbringer Saurfang)
        72441,  // Boiling Blood (Deathbringer Saurfang)
        72442,  // Boiling Blood (Deathbringer Saurfang)
        72443,  // Boiling Blood (Deathbringer Saurfang)
        71160,  // Plague Stench (Stinky)
        71161,  // Plague Stench (Stinky)
        71123,  // Decimate (Stinky & Precious)
        71464   // Divine Surge (Sister Svalna)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = 12;   // 100yd
    });

    // Shadow's Fate
    ApplySpellFix({ 71169 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Lock Players and Tap Chest
    ApplySpellFix({ 72347 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 &= ~SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Award Reputation - Boss Kill
    ApplySpellFix({ 73843, 73844, 73845, 73846 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_50000_YARDS;
    });

    // Death Plague (Rotting Frost Giant)
    ApplySpellFix({ 72864 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 0;
    });

    // Gunship Battle, spell Below Zero
    ApplySpellFix({ 69705 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Resistant Skin (Deathbringer Saurfang adds)
    ApplySpellFix({ 72723 }, [](SpellEntry* spellInfo)
    {
        // this spell initially granted Shadow damage immunity, however it was removed but the data was left in client
        spellInfo->Effect[2] = 0;
    });

    // Mark of the Fallen Champion (Deathbringer Saurfang)
    ApplySpellFix({ 72255, 72444, 72445, 72446 }, [](SpellEntry* spellInfo)
    {
        // Patch 3.3.2 (2010-01-02): Deathbringer Saurfang will no longer gain blood power from Mark of the Fallen Champion.
        // prevented in script, effect needed for Prayer of Mending
        spellInfo->AttributesEx3 &= ~SPELL_ATTR3_SUPRESS_CASTER_PROCS;
    });

    // Coldflame Jets (Traps after Saurfang)
    ApplySpellFix({ 70460 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 1;   // 10 seconds
    });

    ApplySpellFix({
        70461,  // Coldflame Jets (Traps after Saurfang)
        71289   // Dominate Mind (Lady Deathwhisper)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Severed Essence (Val'kyr Herald)
    ApplySpellFix({ 71906, 71942 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ENEMY;
        spellInfo->EffectImplicitTargetB[0] = 0;
        spellInfo->Effect[1] = 0;
    });

    ApplySpellFix({
        71159,  // Awaken Plagued Zombies (Precious)
        71302   // Awaken Ymirjar Fallen (Ymirjar Deathbringer)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 21;
    });

    // Blood Prince Council, Invocation of Blood
    ApplySpellFix({ 70981, 70982, 70952 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = 0; // clear share health aura
    });

    // Ymirjar Frostbinder, Frozen Orb
    ApplySpellFix({ 71274 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = 6;
    });

    // Ooze Flood (Rotface)
    ApplySpellFix({ 69783, 69797, 69799, 69802 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_EXCLUDE_CASTER;
    });

    // Volatile Ooze Beam Protection
    ApplySpellFix({ 70530 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = SPELL_EFFECT_APPLY_AURA; // blizzard typo, 65 instead of 6, aura itself is defined (dummy)
    });

    // Professor Putricide, Gaseous Bloat (Orange Ooze Channel)
    ApplySpellFix({ 70672, 72455, 72832, 72833 }, [](SpellEntry* spellInfo)
    {
        // copied attributes from Green Ooze Channel
        spellInfo->Attributes |= SPELL_ATTR0_NO_IMMUNITIES;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    ApplySpellFix({
        71412,  // Green Ooze Summon (Professor Putricide)
        71415   // Orange Ooze Summon (Professor Putricide)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
    });

    ApplySpellFix({
        71621,  // Create Concoction (Professor Putricide)
        72850,
        72851,
        72852,
        71893,  // Guzzle Potions (Professor Putricide)
        73120,
        73121,
        73122
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->CastingTimeIndex = 15; // 4 sec
    });

    // Mutated Plague (Professor Putricide)
    ApplySpellFix({ 72454, 72464, 72506, 72507 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx4 |= SPELL_ATTR4_NO_CAST_LOG;
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
    });

    // Unbound Plague (Professor Putricide) (needs target selection script)
    ApplySpellFix({ 70911, 72854, 72855, 72856 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_TARGET_ENEMY;
    });

    // Mutated Transformation (Professor Putricide)
    ApplySpellFix({ 70402, 72511, 72512, 72513 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
    });

    // Empowered Flare (Blood Prince Council)
    ApplySpellFix({ 71708, 72785, 72786, 72787 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    });

    ApplySpellFix({
        71518,  // Unholy Infusion Quest Credit (Professor Putricide)
        72934,  // Blood Infusion Quest Credit (Blood-Queen Lana'thel)
        72289   // Frost Infusion Quest Credit (Sindragosa)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // another missing radius
    });

    // Swarming Shadows
    ApplySpellFix({ 71266, 72890 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AreaGroupId = 0; // originally, these require area 4522, which is... outside of Icecrown Citadel
    });

    ApplySpellFix({
        71301,  // Summon Dream Portal (Valithria Dreamwalker)
        71977   // Summon Nightmare Portal (Valithria Dreamwalker)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
        spellInfo->EffectImplicitTargetB[0] = 0;
    });

    // Column of Frost (visual marker)
    ApplySpellFix({ 70715 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 32; // 6 seconds (missing)
    });

    // Mana Void (periodic aura)
    ApplySpellFix({ 71085 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 9; // 30 seconds (missing)
    });

    // Summon Suppressor (needs target selection script)
    ApplySpellFix({ 70936 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
        spellInfo->EffectImplicitTargetB[0] = 0;
    });

    // Corruption
    ApplySpellFix({ 70602 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    ApplySpellFix({
        72706,  // Achievement Check (Valithria Dreamwalker)
        71357   // Order Whelp
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // 200yd
    });

    // Sindragosa's Fury
    ApplySpellFix({ 70598 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
    });

    // Tail Smash (Sindragosa)
    ApplySpellFix({ 71077 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_CASTER_BACK;
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_DEST_AREA_ENEMY;
        spellInfo->EffectImplicitTargetA[1] = TARGET_DEST_CASTER_BACK;
        spellInfo->EffectImplicitTargetB[1] = TARGET_UNIT_DEST_AREA_ENEMY;
    });

    // Frost Bomb
    ApplySpellFix({ 69846 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Speed = 0.0f;    // This spell's summon happens instantly
    });

    // Mystic Buffet (Sindragosa)
    ApplySpellFix({ 70127, 72528, 72529, 72530 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[1] = 0; // remove obsolete spell effect with no targets
    });

    // Sindragosa, Frost Aura
    ApplySpellFix({ 70084, 71050, 71051, 71052 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes &= ~SPELL_ATTR0_NO_IMMUNITIES;
    });

    // Ice Lock
    ApplySpellFix({ 71614 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Mechanic = MECHANIC_STUN;
    });

    // Lich King, Infest
    ApplySpellFix({ 70541, 73779, 73780, 73781 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Lich King, Necrotic Plague
    ApplySpellFix({ 70337, 73912, 73913, 73914, 70338, 73785, 73786, 73787 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    ApplySpellFix({
        69099,  // Ice Pulse 10n
        73776,  // Ice Pulse 25n
        73777,  // Ice Pulse 10h
        73778   // Ice Pulse 25h
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
        spellInfo->AttributesEx4 &= ~SPELL_ATTR4_NO_CAST_LOG;
    });

    // Fury of Frostmourne
    ApplySpellFix({ 72350 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
        spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
    });

    ApplySpellFix({
        72351,  // Fury of Frostmourne
        72431,  // Jump (removes Fury of Frostmourne debuff)
        72429,  // Mass Resurrection
        73159   // Play Movie
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
    });

    // Raise Dead
    ApplySpellFix({ 72376 }, [](SpellEntry* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 4;
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
    });

    // Jump
    ApplySpellFix({ 71809 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 5; // 40yd
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_10_YARDS; // 10yd
        spellInfo->EffectMiscValue[0] = 190;
    });

    // Broken Frostmourne
    ApplySpellFix({ 72405 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_200_YARDS;   // 200yd
    });

    // Summon Shadow Trap
    ApplySpellFix({ 73540 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 3;   // 60 seconds
    });

    // Shadow Trap (visual)
    ApplySpellFix({ 73530 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 28;          // 5 seconds
    });

    // Shadow Trap
    ApplySpellFix({ 73529 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_10_YARDS;   // 10yd
    });

    // Shadow Trap (searcher)
    ApplySpellFix({ 74282 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_3_YARDS;   // 3yd
    });

    // Raging Spirit Visual
    ApplySpellFix({ 69198 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 13; // 50000yd
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Defile
    ApplySpellFix({ 72762 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 559; // 53 seconds
        spellInfo->ExcludeCasterAuraSpell = 0;
        spellInfo->Attributes |= SPELL_ATTR0_NO_IMMUNITIES;
        spellInfo->AttributesEx6 |= (SPELL_ATTR6_IGNORE_PHASE_SHIFT | SPELL_ATTR6_CAN_TARGET_UNTARGETABLE);
    });

    // Defile
    ApplySpellFix({ 72743 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 22; // 45 seconds
    });

    ApplySpellFix({ 72754, 73708, 73709, 73710 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // 200yd
        spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_200_YARDS;   // 200yd
    });

    // Val'kyr Target Search
    ApplySpellFix({ 69030 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // 200yd
        spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_200_YARDS;   // 200yd
        spellInfo->Attributes |= SPELL_ATTR0_NO_IMMUNITIES;
    });

    // Harvest Souls
    ApplySpellFix({ 73654, 74295, 74296, 74297 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
        spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
        spellInfo->EffectRadiusIndex[2] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
    });

    // Restore Soul
    ApplySpellFix({ 72595, 73650 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // 200yd
    });

    // Kill Frostmourne Players
    ApplySpellFix({ 75127 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_50000_YARDS;    // 50000yd
    });

    // Harvest Soul
    ApplySpellFix({ 73655 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    });

    // Destroy Soul
    ApplySpellFix({ 74086 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // 200yd
    });

    // Summon Spirit Bomb
    ApplySpellFix({ 74302, 74342 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // 200yd
        spellInfo->MaxAffectedTargets = 1;
    });

    // Summon Spirit Bomb
    ApplySpellFix({ 74341, 74343 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // 200yd
        spellInfo->MaxAffectedTargets = 3;
    });

    // Summon Spirit Bomb
    ApplySpellFix({ 73579 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_25_YARDS;   // 25yd
    });

    // Trigger Vile Spirit (Inside, Heroic)
    ApplySpellFix({ 73582 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
    });

    // Scale Aura (used during Dominate Mind from Lady Deathwhisper)
    ApplySpellFix({ 73261 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CHANGE_MAP;
    });

    // Leap to a Random Location
    ApplySpellFix({ 70485 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 6; // 100yd
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_10_YARDS;
        spellInfo->EffectMiscValue[0] = 100;
    });

    // Empowered Blood
    ApplySpellFix({ 70227, 70232 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AreaGroupId = 2452; // Whole icc instead of Crimson Halls only, remove when area calculation is fixed
    });

    ApplySpellFix({ 74509 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_20_YARDS;
        spellInfo->EffectRadiusIndex[EFFECT_1] = EFFECT_RADIUS_20_YARDS;
    });

    // Rallying Shout
    ApplySpellFix({ 75414 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_20_YARDS;
    });

    // Barrier Channel
    ApplySpellFix({ 76221 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ChannelInterruptFlags &= ~(AURA_INTERRUPT_FLAG_TURNING | AURA_INTERRUPT_FLAG_MOVE);
        spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_UNIT_NEARBY_ENTRY;
    });

    // Intimidating Roar
    ApplySpellFix({ 74384 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_100_YARDS;
        spellInfo->EffectRadiusIndex[EFFECT_1] = EFFECT_RADIUS_100_YARDS;
    });

    ApplySpellFix({
        74562,  // Fiery Combustion
        74792   // Soul Consumption
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION;
    });

    // Combustion
    ApplySpellFix({ 75883, 75884 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_6_YARDS;
        spellInfo->EffectRadiusIndex[EFFECT_1] = EFFECT_RADIUS_6_YARDS;
    });

    // Consumption
    ApplySpellFix({ 75875, 75876 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_6_YARDS;
        spellInfo->EffectRadiusIndex[EFFECT_1] = EFFECT_RADIUS_6_YARDS;
        spellInfo->EffectMechanic[EFFECT_0] = 0;
        spellInfo->EffectMechanic[EFFECT_1] = MECHANIC_SNARE;
    });

    // Soul Consumption
    ApplySpellFix({ 74799 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[EFFECT_1] = EFFECT_RADIUS_12_YARDS;
    });

    // Twilight Cutter
    ApplySpellFix({ 74769, 77844, 77845, 77846 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_100_YARDS;
    });

    // Twilight Mending
    ApplySpellFix({ 75509 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx6 |= SPELL_ATTR6_IGNORE_PHASE_SHIFT;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_100_YARDS;
        spellInfo->EffectRadiusIndex[EFFECT_1] = EFFECT_RADIUS_100_YARDS;
    });

    // Meteor Strike
    ApplySpellFix({ 74637 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Speed = 0;
    });

    //Blazing Aura
    ApplySpellFix({ 75885, 75886 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx4 &= ~SPELL_ATTR4_NO_CAST_LOG;
    });

    ApplySpellFix({
        75952,  //Meteor Strike
        74629   //Combustion Periodic
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx4 &= ~SPELL_ATTR4_NO_CAST_LOG;
    });

    // Going Bearback
    ApplySpellFix({ 54897 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[1] = SPELL_EFFECT_DUMMY;
        spellInfo->EffectRadiusIndex[1] = spellInfo->EffectRadiusIndex[0];
        spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_DEST_AREA_ENTRY;
        spellInfo->AttributesEx4 &= ~SPELL_ATTR4_ALLOW_CAST_WHILE_CASTING;
    });

    // Still At It
    ApplySpellFix({ 51931, 51932, 51933 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = 38;
        spellInfo->EffectImplicitTargetB[0] = 0;
    });

    // Rallying the Troops
    ApplySpellFix({ 47394 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 47394;
    });

    // A Tangled Skein
    ApplySpellFix({ 51165, 51173 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    ApplySpellFix({
        69563,  // A Cloudlet of Classy Cologne
        69445,  // A Perfect Puff of Perfume
        69489   // Bonbon Blitz
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_CASTER;
    });

    // Control
    ApplySpellFix({ 30790 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectMiscValue[1] = 0;
    });

    // Reclusive Runemaster
    ApplySpellFix({ 48028 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_SRC_CASTER;
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENEMY;
    });

    // Mastery of
    ApplySpellFix({ 65147 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Category = 1244;
        spellInfo->CategoryRecoveryTime = 1500;
    });

    // Weakness to Lightning
    ApplySpellFix({ 46432 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 &= ~SPELL_ATTR3_ALLOW_AURA_WHILE_DEAD;
    });

    // Wrangle Some Aether Rays!
    ApplySpellFix({ 40856 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 27; // 3000ms
    });

    // The Black Knight's Orders
    ApplySpellFix({ 63163 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[0] = 52390;
    });

    // The Warp Rifts
    ApplySpellFix({ 34888 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 5; // 300 secs
    });

    // The Smallest Creatures
    ApplySpellFix({ 38544 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectMiscValueB[0] = 427;
        spellInfo->EffectImplicitTargetA[0] = 1;
        spellInfo->Effect[1] = 0;
    });

    // Ridding the red rocket
    ApplySpellFix({ 49177 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[0] = 1; // corrects seat id (points - 1 = seatId)
    });

    // Jormungar Strike
    ApplySpellFix({ 56513 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RecoveryTime = 2000;
    });

    ApplySpellFix({
        37851, // Tag Greater Felfire Diemetradon
        37918  // Arcano-pince
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->RecoveryTime = 3000;
    });

    ApplySpellFix({
        54997, // Cast Net (tooltip says 10s but sniffs say 6s)
        56524  // Acid Breath
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->RecoveryTime = 6000;
    });

    ApplySpellFix({
        47911, // EMP
        48620, // Wing Buffet
        51752  // Stampy's Stompy-Stomp
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->RecoveryTime = 10000;
    });

    ApplySpellFix({
        37727, // Touch of Darkness
        54996  // Ice Slick (tooltip says 20s but sniffs say 12s)
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->RecoveryTime = 12000;
    });

    // Signal Helmet to Attack
    ApplySpellFix({ 51748 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RecoveryTime = 15000;
    });

    ApplySpellFix({
        51756, // Charge
        37919, //Arcano-dismantle
        37917  //Arcano-Cloak
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->RecoveryTime = 20000;
    });

    // Kaw the Mammoth Destroyer
    ApplySpellFix({ 46260 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // That's Abominable
    ApplySpellFix({ 59565 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectMiscValueB[0] = 1721; // controlable guardian
    });

    // Investigate the Blue Recluse (1920)
    // Investigate the Alchemist Shop (1960)
    ApplySpellFix({ 9095 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectApplyAuraName[0] = SPELL_AURA_DUMMY;
        spellInfo->EffectRadiusIndex[0] = 13;
    });

    // Dragonmaw Race: All parts
    ApplySpellFix({
        40890   // Oldie's Rotten Pumpkin
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
        spellInfo->EffectTriggerSpell[0] = 40905;
        spellInfo->Effect[0] = SPELL_EFFECT_TRIGGER_MISSILE;
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
    });

    // Trope's Slime Cannon
    ApplySpellFix({ 40909 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
        spellInfo->EffectTriggerSpell[0] = 40905;
        spellInfo->Effect[0] = SPELL_EFFECT_TRIGGER_MISSILE;
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
    });

    // Corlok's Skull Barrage
    ApplySpellFix({ 40894 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
        spellInfo->EffectTriggerSpell[0] = 40900;
        spellInfo->Effect[0] = SPELL_EFFECT_TRIGGER_MISSILE;
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
    });

    // Ichman's Blazing Fireball
    ApplySpellFix({ 40928 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
        spellInfo->EffectTriggerSpell[0] = 40929;
        spellInfo->Effect[0] = SPELL_EFFECT_TRIGGER_MISSILE;
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
    });

    // Mulverick's Great Balls of Lightning
    ApplySpellFix({ 40930 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
        spellInfo->EffectTriggerSpell[0] = 40931;
        spellInfo->Effect[0] = SPELL_EFFECT_TRIGGER_MISSILE;
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
    });

    // Sky Shatter
    ApplySpellFix({ 40945 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
        spellInfo->EffectTriggerSpell[0] = 41064;
        spellInfo->Effect[0] = SPELL_EFFECT_TRIGGER_MISSILE;
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
    });

    // Gauging the Resonant Frequency (10594)
    ApplySpellFix({ 37390 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectMiscValueB[0] = 181;
    });

    // Where in the World is Hemet Nesingwary? (12521)
    ApplySpellFix({ 50860 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[0] = 50860;
    });

    ApplySpellFix({ 50861 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[0] = 0;
    });

    // Krolmir, Hammer of Storms (13010)
    ApplySpellFix({ 56606, 56541 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[0] = 1;
    });

    // Blightbeasts be Damned! (12072)
    ApplySpellFix({ 47424 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AuraInterruptFlags &= ~AURA_INTERRUPT_FLAG_NOT_ABOVEWATER;
    });

    // Leading the Charge (13380), All Infra-Green bomber quests
    ApplySpellFix({ 59059 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx4 &= ~SPELL_ATTR4_ALLOW_CAST_WHILE_CASTING;
    });

    // Dark Horizon (12664), Reunited (12663)
    ApplySpellFix({ 52190 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[EFFECT_0] = 52391 - 1;
    });

    // The Sum is Greater than the Parts (13043) - Chained Grip
    ApplySpellFix({ 60540 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectMiscValue[EFFECT_0] = 300;
    });

    // Not a Bug (13342)
    ApplySpellFix({ 60531 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_ALLOW_DEAD_TARGET;
    });

    // Frankly,  It Makes No Sense... (10672)
    ApplySpellFix({ 37851 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Honor Challenge (12939)
    ApplySpellFix({ 21855 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Convocation at Zol'Heb (12730)
    ApplySpellFix({ 52956 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_DEST_AREA_ENTRY;
    });

    // Mangletooth Quests (http://www.wowhead.com/npc=3430)
    ApplySpellFix({ 7764, 10767, 16610, 16612, 16618, 17013 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->AttributesEx5 |= SPELL_ATTR5_ALWAYS_AOE_LINE_OF_SIGHT;
    });

    //Crushing the Crown
    ApplySpellFix({ 71024 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DYNOBJ_NONE;
    });

    // Battle for the Undercity
    ApplySpellFix({
        59892   // Cyclone fall
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[EFFECT_0] = SPELL_EFFECT_APPLY_AREA_AURA_FRIEND;
        spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_10_YARDS;
        spellInfo->AttributesEx &= ~SPELL_ATTR0_NO_AURA_CANCEL;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ONLY_ON_PLAYER;
    });

    // enchant Lightweave Embroidery
    ApplySpellFix({ 55637 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectMiscValue[1] = 126;
    });

    // Magic Broom
    ApplySpellFix({ 47977 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = 0;
        spellInfo->Effect[1] = 0;
    });

    // Titanium Seal of Dalaran, Toss your luck
    ApplySpellFix({ 60476 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
    });

    // Mind Amplification Dish, change charm aura
    ApplySpellFix({ 26740 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectApplyAuraName[0] = SPELL_AURA_MOD_CHARM;
    });

    // Persistent Shield (fixes idiocity)
    ApplySpellFix({ 26467 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PROC_TRIGGER_SPELL_WITH_VALUE;
        spellInfo->EffectTriggerSpell[0] = 26470;
    });

    // Deadly Swiftness
    ApplySpellFix({ 31255 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[0] = 22588;
    });

    // Black Magic enchant
    ApplySpellFix({ 59630 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_PASSIVE;
    });

    // Precious's Ribbon
    ApplySpellFix({ 72968 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALLOW_AURA_WHILE_DEAD;
    });

    ApplySpellFix({
        71646,  // Item - Bauble of True Blood 10m
        71607,  // Item - Bauble of True Blood 25m
        71610,  // Item - Althor's Abacus trigger 10m
        71641   // Item - Althor's Abacus trigger 25m
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
        spellInfo->SpellLevel = 0;
    });

    ApplySpellFix({
        6789,  // Warlock - Death Coil (Rank 1)
        17925, // Warlock - Death Coil (Rank 2)
        17926, // Warlock - Death Coil (Rank 3)
        27223, // Warlock - Death Coil (Rank 4)
        47859, // Warlock - Death Coil (Rank 5)
        71838, // Drain Life - Bryntroll Normal
        71839  // Drain Life - Bryntroll Heroic
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
        spellInfo->AttributesEx4 |= SPELL_ATTR4_NO_CAST_LOG;
    });

    // Alchemist's Stone
    ApplySpellFix({ 17619 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALLOW_AURA_WHILE_DEAD;
    });

    // Gnomish Death Ray
    ApplySpellFix({ 13278, 13280 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ENEMY;
    });

    // Stormchops
    ApplySpellFix({ 43730 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[1] = 1;
        spellInfo->EffectImplicitTargetB[1] = 0;
    });

    // Savory Deviate Delight (transformations), allow to mount while transformed
    ApplySpellFix({ 8219, 8220, 8221, 8222 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Attributes &= ~SPELL_ATTR0_NO_IMMUNITIES;
    });

    // Clamlette Magnifique
    ApplySpellFix({ 72623 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectBasePoints[EFFECT_0] = spellInfo->EffectBasePoints[EFFECT_1];
    });

    // Compact Harvest Reaper
    ApplySpellFix({ 4078 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 6; // 10 minutes
    });

    // Dragon Kite, Tuskarr Kite - Kite String
    ApplySpellFix({ 45192 }, [](SpellEntry* spellInfo)
    {
        spellInfo->RangeIndex = 6; // 100yd
    });

    // Frigid Frostling, Infrigidate
    ApplySpellFix({ 74960 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectRadiusIndex[EFFECT_0] = 9; // 20yd
    });

    // Apple Trap
    ApplySpellFix({ 43450 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_SRC_AREA_ENEMY;
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_CASTER;
        spellInfo->Effect[0] = SPELL_EFFECT_DUMMY;
    });

    // Dark Iron Attack - spawn mole machine
    ApplySpellFix({ 43563 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[2] = 0; // summon GO's manually
    });

    // Throw Mug visual
    ApplySpellFix({ 42300 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
    });

    // Dark Iron knockback Aura
    ApplySpellFix({ 42299 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectApplyAuraName[1] = SPELL_AURA_DUMMY;
        spellInfo->EffectMiscValue[0] = 100;
        spellInfo->EffectBasePoints[0] = 79;
    });

    // Chug and Chuck!
    ApplySpellFix({ 42436 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_SRC_CASTER;
        spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENTRY;
        spellInfo->MaxAffectedTargets = 0;
        spellInfo->ExcludeCasterAuraSpell = 42299;
    });

    // Catch the Wild Wolpertinger!
    ApplySpellFix({ 41621 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = SPELL_EFFECT_DUMMY;
    });

    // Brewfest quests
    ApplySpellFix({ 47134, 51798 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = 0;
    });

    // The Heart of The Storms (12998)
    ApplySpellFix({ 43528 }, [](SpellEntry* spellInfo)
    {
        spellInfo->DurationIndex = 18;
        spellInfo->EffectImplicitTargetA[0] = 25;
    });

    // Water splash
    ApplySpellFix({ 42348 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[0] = 0;
    });

    // Summon Lantersn
    ApplySpellFix({ 44255, 44231 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
        spellInfo->EffectImplicitTargetB[0] = 0;
    });

    // Throw Head Back
    ApplySpellFix({ 42401 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_NEARBY_ENTRY;
    });

    // Various food
    ApplySpellFix({ 65418 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[2] = 65410;
    });

    ApplySpellFix({ 65422 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[2] = 65414;
    });

    ApplySpellFix({ 65419 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[2] = 65416;
    });

    ApplySpellFix({ 65420 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[2] = 65412;
    });

    ApplySpellFix({ 65421 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectTriggerSpell[2] = 65415;
    });

    // Stamp Out Bonfire
    ApplySpellFix({ 45437 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Effect[1] = SPELL_EFFECT_DUMMY;
        spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_NEARBY_ENTRY;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Light Bonfire (DND)
    ApplySpellFix({ 29831 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Infernal
    ApplySpellFix({ 33240 }, [](SpellEntry* spellInfo)
    {
        spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_DEST_TARGET_ANY;
        spellInfo->EffectImplicitTargetA[EFFECT_1] = TARGET_UNIT_TARGET_ANY;
        spellInfo->EffectImplicitTargetA[EFFECT_2] = TARGET_UNIT_TARGET_ANY;
    });

    // Check for SPELL_ATTR7_CAN_CAUSE_INTERRUPT
    ApplySpellFix({
        47476,  // Deathknight - Strangulate
        15487,  // Priest - Silence
        5211,   // Druid - Bash  - R1
        6798,   // Druid - Bash  - R2
        8983    // Druid - Bash  - R3
        }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx7 |= SPELL_ATTR7_CAN_CAUSE_INTERRUPT;
    });

    // Clicking on Warlock Summoning portal should not require mana
    ApplySpellFix({ 61994 }, [](SpellEntry* spellInfo)
    {
        spellInfo->ManaCostPercentage = 0;
    });

    // Shadowmeld
    ApplySpellFix({ 58984 }, [](SpellEntry* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ONLY_ON_PLAYER;
    });

    // Flare activation speed
    ApplySpellFix({ 1543 }, [](SpellEntry* spellInfo)
    {
        spellInfo->Speed = 0.0f;
    });

    for (uint32 i = 0; i < sSpellStore.GetNumRows(); ++i)
    {
        SpellEntry* spellInfo = (SpellEntry*)sSpellStore.LookupEntry(i);
        if (!spellInfo)
        {
            continue;
        }

        for (uint8 j = 0; j < MAX_SPELL_EFFECTS; ++j)
        {
            switch (spellInfo->Effect[j])
            {
                case SPELL_EFFECT_CHARGE:
                case SPELL_EFFECT_CHARGE_DEST:
                case SPELL_EFFECT_JUMP:
                case SPELL_EFFECT_JUMP_DEST:
                case SPELL_EFFECT_LEAP_BACK:
                    if (!spellInfo->Speed && !spellInfo->SpellFamilyName)
                    {
                        spellInfo->Speed = SPEED_CHARGE;
                    }
                    break;
            }

            // Xinef: i hope this will fix the problem with not working resurrection
            if (spellInfo->Effect[j] == SPELL_EFFECT_SELF_RESURRECT)
            {
                spellInfo->EffectImplicitTargetA[j] = TARGET_UNIT_CASTER;
            }
        }

        // Xinef: Fix range for trajectories and triggered spells
        for (uint8 j = 0; j < 3; ++j)
        {
            if (spellInfo->RangeIndex == 1 && (spellInfo->EffectImplicitTargetA[j] == TARGET_DEST_TRAJ || spellInfo->EffectImplicitTargetB[j] == TARGET_DEST_TRAJ))
            {
                if (SpellEntry* spellInfo2 = (SpellEntry*)sSpellStore.LookupEntry(spellInfo->EffectTriggerSpell[j]))
                {
                    spellInfo2->RangeIndex = 187; // 300yd
                }
            }
        }

        if (spellInfo->ActiveIconID == 2158)  // flight
        {
            spellInfo->Attributes |= SPELL_ATTR0_PASSIVE;
        }

        switch (spellInfo->SpellFamilyName)
        {
            case SPELLFAMILY_PALADIN:
                // Seals of the Pure should affect Seal of Righteousness
                if (spellInfo->SpellIconID == 25 && (spellInfo->Attributes & SPELL_ATTR0_PASSIVE))
                    spellInfo->EffectSpellClassMask[0][1] |= 0x20000000;
                break;
            case SPELLFAMILY_DEATHKNIGHT:
                // Icy Touch - extend FamilyFlags (unused value) for Sigil of the Frozen Conscience to use
                if (spellInfo->SpellIconID == 2721 && spellInfo->SpellFamilyFlags[0] & 0x2)
                    spellInfo->SpellFamilyFlags[0] |= 0x40;
                break;
        }
    }

    // Xinef: The Veiled Sea area in outlands (Draenei zone), client blocks casting flying mounts
    for (uint32 i = 0; i < sAreaTableStore.GetNumRows(); ++i)
        if (AreaTableEntry* areaEntry = const_cast<AreaTableEntry*>(sAreaTableStore.LookupEntry(i)))
        {
            if (areaEntry->ID == 3479)
                areaEntry->flags |= AREA_FLAG_NO_FLY_ZONE;
            // Xinef: Dun Morogh, Kharanos tavern, missing resting flag
            else if (areaEntry->ID == 2102)
                areaEntry->flags |= AREA_FLAG_REST_ZONE_ALLIANCE;
        }

    // Xinef: fix for something?
    SummonPropertiesEntry* properties = const_cast<SummonPropertiesEntry*>(sSummonPropertiesStore.LookupEntry(121));
    properties->Type = SUMMON_TYPE_TOTEM;
    properties = const_cast<SummonPropertiesEntry*>(sSummonPropertiesStore.LookupEntry(647)); // 52893
    properties->Type = SUMMON_TYPE_TOTEM;
    if ((properties = const_cast<SummonPropertiesEntry*>(sSummonPropertiesStore.LookupEntry(628)))) // Hungry Plaguehound
    {
        properties->Category = SUMMON_CATEGORY_PET;
        properties->Type = SUMMON_TYPE_PET;
    }

    // Correct Pet Size
    CreatureDisplayInfoEntry* displayEntry = const_cast<CreatureDisplayInfoEntry*>(sCreatureDisplayInfoStore.LookupEntry(17028)); // Kurken
    displayEntry->scale = 2.5f;

    // Oracles and Frenzyheart faction
    FactionEntry* factionEntry = const_cast<FactionEntry*>(sFactionStore.LookupEntry(1104));
    factionEntry->ReputationFlags[0] = 0;
    factionEntry = const_cast<FactionEntry*>(sFactionStore.LookupEntry(1105));
    factionEntry->ReputationFlags[0] = 0;

    // Various factions, added 14, 16 to hostile mask
    FactionTemplateEntry* factionTemplateEntry = const_cast<FactionTemplateEntry*>(sFactionTemplateStore.LookupEntry(1978)); // Warsong Offensive
    factionTemplateEntry->hostileMask |= 8;
    factionTemplateEntry = const_cast<FactionTemplateEntry*>(sFactionTemplateStore.LookupEntry(1921)); // The Taunka
    factionTemplateEntry->hostileMask |= 8;

    // Remove vehicles attr, making accessories selectable
    VehicleSeatEntry* vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(4689)); // Siege Engine, Accessory
    vse->m_flags &= ~VEHICLE_SEAT_FLAG_PASSENGER_NOT_SELECTABLE;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(4692)); // Siege Engine, Accessory
    vse->m_flags &= ~VEHICLE_SEAT_FLAG_PASSENGER_NOT_SELECTABLE;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(4693)); // Siege Engine, Accessory
    vse->m_flags &= ~VEHICLE_SEAT_FLAG_PASSENGER_NOT_SELECTABLE;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(3011)); // Salvaged Demolisher, Ulduar - not allow to change seats
    vse->m_flags &= ~VEHICLE_SEAT_FLAG_CAN_SWITCH;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(3077)); // Salvaged Demolisher Seat, Ulduar - not allow to change seats
    vse->m_flags &= ~VEHICLE_SEAT_FLAG_CAN_SWITCH;

    // pussywizard: fix z offset for some vehicles:
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(6206)); // Marrowgar - Bone Spike
    vse->m_attachmentOffsetZ = 4.0f;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(3806)); // Mimiron - seat on VX-001 for ACU during last phase
    vse->m_attachmentOffsetZ = 15.0f;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(3566)); // Mimiron - Working seat
    vse->m_attachmentOffsetX = -3.5f;
    vse->m_attachmentOffsetY = 0.0f;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(3567)); // Mimiron - Working seat
    vse->m_attachmentOffsetX = 2.3f;
    vse->m_attachmentOffsetY = -2.3f;

    // Pilgrim's Bounty offsets
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(2841));
    vse->m_attachmentOffsetX += 1.65f;
    vse->m_attachmentOffsetY += 0.75f;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(2842));
    vse->m_attachmentOffsetX += 1.6f;
    vse->m_attachmentOffsetY += -1.0f;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(2843));
    vse->m_attachmentOffsetX += -1.2f;
    vse->m_attachmentOffsetY += 0.2f;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(2844));
    vse->m_attachmentOffsetX += -0.1f;
    vse->m_attachmentOffsetY += -1.6f;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(2845));
    vse->m_attachmentOffsetX += 0.0f;
    vse->m_attachmentOffsetY += 1.6f;

    // Once Bitten, Twice Shy (10 player) - Icecrown Citadel
    AchievementEntry* achievement = const_cast<AchievementEntry*>(sAchievementStore.LookupEntry(4539));
    achievement->mapID = 631;    // Correct map requirement (currently has Ulduar)

    // Ring of Valor starting Locations
    GraveyardStruct const* entry = sGraveyard->GetGraveyard(1364);
    const_cast<GraveyardStruct*>(entry)->z += 6.0f;
    entry = sGraveyard->GetGraveyard(1365);
    const_cast<GraveyardStruct*>(entry)->z += 6.0f;

    LockEntry* key = const_cast<LockEntry*>(sLockStore.LookupEntry(36)); // 3366 Opening, allows to open without proper key
    key->Type[2] = LOCK_KEY_NONE;

    LOG_INFO("server", ">> Loading spell dbc data corrections  in %u ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server", " ");
}
