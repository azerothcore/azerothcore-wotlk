/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "SpellMgr.h"
#include "SpellInfo.h"
#include "ObjectMgr.h"
#include "SpellAuras.h"
#include "SpellAuraDefines.h"
#include "SharedDefines.h"
#include "DBCStores.h"
#include "World.h"
#include "Chat.h"
#include "Spell.h"
#include "BattlegroundMgr.h"
#include "CreatureAI.h"
#include "MapManager.h"
#include "BattlegroundIC.h"
#include "BattlefieldWG.h"
#include "BattlefieldMgr.h"
#include "InstanceScript.h"
#include "Player.h"
#include "GameGraveyard.h"

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

/// Some checks for spells, to prevent adding deprecated/broken spells for trainers, spell book, etc
bool SpellMgr::ComputeIsSpellValid(SpellInfo const *spellInfo, bool msg)
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
                            sLog->outErrorDb("Craft spell %u not have create item entry.", spellInfo->Id);
                        return false;
                    }

                }
                // also possible IsLootCrafting case but fake item must exist anyway
                else if (!sObjectMgr->GetItemTemplate(spellInfo->Effects[i].ItemType))
                {
                    if (msg)
                        sLog->outErrorDb("Craft spell %u create not-exist in DB item (Entry: %u) and then...", spellInfo->Id, spellInfo->Effects[i].ItemType);
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
                        sLog->outErrorDb("Spell %u learn to invalid spell %u, and then...", spellInfo->Id, spellInfo->Effects[i].TriggerSpell);
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
                    sLog->outErrorDb("Craft spell %u have not-exist reagent in DB item (Entry: %u) and then...", spellInfo->Id, spellInfo->Reagent[j]);
                return false;
            }
        }
    }

    return true;
}

bool SpellMgr::IsSpellValid(SpellInfo const *spellInfo)
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
        sLog->outError("Player::%s: Non-existed in SpellStore spell #%u request.", (isTalent ? "AddTalent" : "addSpell"), spellId);
        return false;
    }

    if (!IsSpellValid(spellInfo))
    {
        DeleteSpellFromAllPlayers(spellId);
        sLog->outError("Player::%s: Broken spell #%u learning not allowed.", (isTalent ? "AddTalent" : "addSpell"), spellId);
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
        sLog->outError("SpellMgr::GetSpellIdForDifficulty: Incorrect Difficulty for spell %u.", spellId);
        return spellId; //return source spell
    }

    uint32 difficultyId = GetSpellDifficultyId(spellId);
    if (!difficultyId)
        return spellId; //return source spell, it has only REGULAR_DIFFICULTY

    SpellDifficultyEntry const* difficultyEntry = sSpellDifficultyStore.LookupEntry(difficultyId);
    if (!difficultyEntry)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_SPELLS_AURAS, "SpellMgr::GetSpellIdForDifficulty: SpellDifficultyEntry not found for spell %u. This should never happen.", spellId);
#endif
        return spellId; //return source spell
    }

    if (difficultyEntry->SpellID[mode] <= 0 && mode > DUNGEON_DIFFICULTY_HEROIC)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_SPELLS_AURAS, "SpellMgr::GetSpellIdForDifficulty: spell %u mode %u spell is NULL, using mode %u", spellId, mode, mode - 2);
#endif
        mode -= 2;
    }

    if (difficultyEntry->SpellID[mode] <= 0)
    {
        sLog->outErrorDb("SpellMgr::GetSpellIdForDifficulty: spell %u mode %u spell is 0. Check spelldifficulty_dbc!", spellId, mode);
        return spellId;
    }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_SPELLS_AURAS, "SpellMgr::GetSpellIdForDifficulty: spellid for spell %u in mode %u is %d", spellId, mode, difficultyEntry->SpellID[mode]);
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
        sLog->outDebug(LOG_FILTER_SPELLS_AURAS, "SpellMgr::GetSpellForDifficultyFromSpell: spell %u not found. Check spelldifficulty_dbc!", newSpellId);
#endif
        return spell;
    }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_SPELLS_AURAS, "SpellMgr::GetSpellForDifficultyFromSpell: Spell id for instance mode is %u (original %u)", newSpell->Id, spell->Id);
#endif
    return newSpell;
}

SpellChainNode const* SpellMgr::GetSpellChainNode(uint32 spell_id) const
{
    SpellChainMap::const_iterator itr = mSpellChains.find(spell_id);
    if (itr == mSpellChains.end())
        return NULL;

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
        return NULL;
}

SpellTargetPosition const* SpellMgr::GetSpellTargetPosition(uint32 spell_id, SpellEffIndex effIndex) const
{
    SpellTargetPositionMap::const_iterator itr = mSpellTargetPositions.find(std::make_pair(spell_id, effIndex));
    if (itr != mSpellTargetPositions.end())
        return &itr->second;
    return NULL;
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
    return NULL;
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
        if (procSpell == NULL)
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
        if ((procExtra & (PROC_EX_NORMAL_HIT|PROC_EX_CRITICAL_HIT)) && active)
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
            if ((procExtra & (PROC_EX_NORMAL_HIT|PROC_EX_CRITICAL_HIT)) && ((procEvent_procEx & (AURA_SPELL_PROC_EX_MASK)) == 0))
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
    return NULL;
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
    return NULL;
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
    return NULL;
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
    SpellPetAuraMap::const_iterator itr = mSpellPetAuraMap.find((spell_id<<8) + eff);
    if (itr != mSpellPetAuraMap.end())
        return &itr->second;
    else
        return NULL;
}

SpellEnchantProcEntry const* SpellMgr::GetSpellEnchantProcEvent(uint32 enchId) const
{
    SpellEnchantProcEventMap::const_iterator itr = mSpellEnchantProcEventMap.find(enchId);
    if (itr != mSpellEnchantProcEventMap.end())
        return &itr->second;
    return NULL;
}

bool SpellMgr::IsArenaAllowedEnchancment(uint32 ench_id) const
{
    return mEnchantCustomAttr[ench_id];
}

const std::vector<int32>* SpellMgr::GetSpellLinked(int32 spell_id) const
{
    SpellLinkedMap::const_iterator itr = mSpellLinkedMap.find(spell_id);
    return itr != mSpellLinkedMap.end() ? &(itr->second) : NULL;
}

PetLevelupSpellSet const* SpellMgr::GetPetLevelupSpellList(uint32 petFamily) const
{
    PetLevelupSpellMap::const_iterator itr = mPetLevelupSpellMap.find(petFamily);
    if (itr != mPetLevelupSpellMap.end())
        return &itr->second;
    else
        return NULL;
}

PetDefaultSpellsEntry const* SpellMgr::GetPetDefaultSpellsEntry(int32 id) const
{
    PetDefaultSpellsMap::const_iterator itr = mPetDefaultSpellsMap.find(id);
    if (itr != mPetDefaultSpellsMap.end())
        return &itr->second;
    return NULL;
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
            if (!bg || bg->GetBgTypeID() != BATTLEGROUND_IC)
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
        mSpellInfoMap[itr->first]->ChainEntry = NULL;

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

        SpellInfo const* lastSpell = NULL;
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
            sLog->outErrorDb("SpellMgr::LoadSpellTalentRanks: First Rank Spell %u for TalentEntry %u does not exist.", talentInfo->RankID[0], i);
            continue;
        }

        SpellInfo const* prevSpell = NULL;
        for (uint8 rank = 0; rank < MAX_TALENT_RANK; ++rank)
        {
            uint32 spellId = talentInfo->RankID[rank];
            if (!spellId)
                break;

            SpellInfo const* currentSpell = GetSpellInfo(spellId);
            if (!currentSpell)
            {
                sLog->outErrorDb("SpellMgr::LoadSpellTalentRanks: Spell %u (Rank: %u) for TalentEntry %u does not exist.", spellId, rank + 1, i);
                break;
            }

            SpellChainNode node;
            node.first = firstSpell;
            node.last  = lastSpell;
            node.rank  = rank + 1;

            node.prev = prevSpell;
            node.next = node.rank < MAX_TALENT_RANK ? GetSpellInfo(talentInfo->RankID[node.rank]) : NULL;

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

    //                                                     0             1      2
    QueryResult result = WorldDatabase.Query("SELECT first_spell_id, spell_id, rank from spell_ranks ORDER BY first_spell_id, rank");

    if (!result)
    {
        sLog->outString(">> Loaded 0 spell rank records. DB table `spell_ranks` is empty.");
        sLog->outString();
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
            sLog->outErrorDb("Spell rank identifier(first_spell_id) %u listed in `spell_ranks` does not exist!", lastSpell);
            continue;
        }
        // check if chain is long enough
        if (rankChain.size() < 2)
        {
            sLog->outErrorDb("There is only 1 spell rank for identifier(first_spell_id) %u in `spell_ranks`, entry is not needed!", lastSpell);
            continue;
        }
        int32 curRank = 0;
        bool valid = true;
        // check spells in chain
        for (std::list<std::pair<int32, int32> >::iterator itr = rankChain.begin(); itr!= rankChain.end(); ++itr)
        {
            SpellInfo const* spell = GetSpellInfo(itr->first);
            if (!spell)
            {
                sLog->outErrorDb("Spell %u (rank %u) listed in `spell_ranks` for chain %u does not exist!", itr->first, itr->second, lastSpell);
                valid = false;
                break;
            }
            ++curRank;
            if (itr->second != curRank)
            {
                sLog->outErrorDb("Spell %u (rank %u) listed in `spell_ranks` for chain %u does not have proper rank value(should be %u)!", itr->first, itr->second, lastSpell, curRank);
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
                mSpellChains[addedSpell].next = NULL;
                break;
            }
            else
                mSpellChains[addedSpell].next = GetSpellInfo(itr->first);
        }
        while (true);
    } while (!finished);

    sLog->outString(">> Loaded %u spell rank records in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
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
        sLog->outString(">> Loaded 0 spell required records. DB table `spell_required` is empty.");
        sLog->outString();
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
            sLog->outErrorDb("spell_id %u in `spell_required` table is not found in dbcs, skipped", spellId);
            continue;
        }

        SpellInfo const* reqSpellInfo = GetSpellInfo(spellReq);
        if (!reqSpellInfo)
        {
            sLog->outErrorDb("req_spell %u in `spell_required` table is not found in dbcs, skipped", spellReq);
            continue;
        }

        if (GetFirstSpellInChain(spellId) == GetFirstSpellInChain(spellReq))
        {
            sLog->outErrorDb("req_spell %u and spell_id %u in `spell_required` table are ranks of the same spell, entry not needed, skipped", spellReq, spellId);
            continue;
        }

        if (IsSpellRequiringSpell(spellId, spellReq))
        {
            sLog->outErrorDb("duplicated entry of req_spell %u and spell_id %u in `spell_required`, skipped", spellReq, spellId);
            continue;
        }

        mSpellReq.insert (std::pair<uint32, uint32>(spellId, spellReq));
        mSpellsReqSpell.insert (std::pair<uint32, uint32>(spellReq, spellId));
        ++count;

        // xinef: fill additionalTalentInfo data, currently Blessing of Sanctuary only
        if (GetTalentSpellCost(spellReq) > 0)
            mTalentSpellAdditionalSet.insert(spellId);

    } while (result->NextRow());

    sLog->outString(">> Loaded %u spell required records in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
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

    sLog->outString(">> Loaded %u Spell Learn Skills from DBC in %u ms", dbc_count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void SpellMgr::LoadSpellTargetPositions()
{
    uint32 oldMSTime = getMSTime();

    mSpellTargetPositions.clear();                                // need for reload case

    //                                                0      1          2        3         4           5            6
    QueryResult result = WorldDatabase.Query("SELECT ID, EffectIndex, MapID, PositionX, PositionY, PositionZ, Orientation FROM spell_target_position");

    if (!result)
    {
        sLog->outString(">> Loaded 0 spell target coordinates. DB table `spell_target_position` is empty.");
        sLog->outString();
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
            sLog->outErrorDb("Spell (Id: %u, effIndex: %u) target map (ID: %u) does not exist in `Map.dbc`.", Spell_ID, effIndex, st.target_mapId);
            continue;
        }

        if (st.target_X==0 && st.target_Y==0 && st.target_Z==0)
        {
            sLog->outErrorDb("Spell (Id: %u, effIndex: %u) target coordinates not provided.", Spell_ID, effIndex);
            continue;
        }

        SpellInfo const* spellInfo = GetSpellInfo(Spell_ID);
        if (!spellInfo)
        {
            sLog->outErrorDb("Spell (ID:%u) listed in `spell_target_position` does not exist.", Spell_ID);
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
            sLog->outErrorDb("Spell (Id: %u, effIndex: %u) listed in `spell_target_position` does not have target TARGET_DEST_DB (17).", Spell_ID, effIndex);
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
                sLog->outDebug(LOG_FILTER_SPELLS_AURAS, "Spell (ID: %u) does not have record in `spell_target_position`", i);
#endif
        }
    }*/

    sLog->outString(">> Loaded %u spell teleport coordinates in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void SpellMgr::LoadSpellGroups()
{
    uint32 oldMSTime = getMSTime();

    mSpellGroupMap.clear();                                  // need for reload case

    //                                                0     1            2
    QueryResult result = WorldDatabase.Query("SELECT id, spell_id, special_flag FROM spell_group");
    if (!result)
    {
        sLog->outString(">> Loaded 0 spell group definitions. DB table `spell_group` is empty.");
        sLog->outString();
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
            sLog->outErrorDb("Spell %u listed in `spell_group` does not exist", spell_id);
            continue;
        }
        else if (spellInfo->GetRank() > 1)
        {
            sLog->outErrorDb("Spell %u listed in `spell_group` is not first rank of spell", spell_id);
            continue;
        }

        if (mSpellGroupMap.find(spell_id) != mSpellGroupMap.end())
        {
            sLog->outErrorDb("Spell %u listed in `spell_group` has more than one group", spell_id);
            continue;
        }

        if (specialFlag >= SPELL_GROUP_SPECIAL_FLAG_MAX)
        {
            sLog->outErrorDb("Spell %u listed in `spell_group` has invalid special flag!", spell_id);
            continue;
        }

        SpellStackInfo ssi;
        ssi.groupId = group_id;
        ssi.specialFlags = specialFlag;
        mSpellGroupMap[spell_id] = ssi;

        ++count;
    } while (result->NextRow());


    sLog->outString(">> Loaded %u spell group definitions in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void SpellMgr::LoadSpellGroupStackRules()
{
    uint32 oldMSTime = getMSTime();

    mSpellGroupStackMap.clear();                                  // need for reload case

    //                                                       0         1
    QueryResult result = WorldDatabase.Query("SELECT group_id, stack_rule FROM spell_group_stack_rules");
    if (!result)
    {
        sLog->outString(">> Loaded 0 spell group stack rules. DB table `spell_group_stack_rules` is empty.");
        sLog->outString();
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
            sLog->outErrorDb("SpellGroupStackRule %u listed in `spell_group_stack_rules` does not exist", stack_rule);
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
            sLog->outErrorDb("SpellGroup id %u listed in `spell_group_stack_rules` does not exist", group_id);
            continue;
        }

        mSpellGroupStackMap[group_id] = (SpellGroupStackFlags)stack_rule;

        ++count;
    } while (result->NextRow());

    sLog->outString(">> Loaded %u spell group stack rules in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void SpellMgr::LoadSpellProcEvents()
{
    uint32 oldMSTime = getMSTime();

    mSpellProcEventMap.clear();                             // need for reload case

    //                                                0      1           2                3                 4                 5                 6          7       8        9             10
    QueryResult result = WorldDatabase.Query("SELECT entry, SchoolMask, SpellFamilyName, SpellFamilyMask0, SpellFamilyMask1, SpellFamilyMask2, procFlags, procEx, ppmRate, CustomChance, Cooldown FROM spell_proc_event");
    if (!result)
    {
        sLog->outString(">> Loaded 0 spell proc event conditions. DB table `spell_proc_event` is empty.");
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
            sLog->outErrorDb("Spell %u listed in `spell_proc_event` does not exist", spellId);
            continue;
        }

        if (allRanks)
        {
            if (!spellInfo->IsRanked())
                sLog->outErrorDb("Spell %u listed in `spell_proc_event` with all ranks, but spell has no ranks.", spellId);

            if (spellInfo->GetFirstRankSpell()->Id != uint32(spellId))
            {
                sLog->outErrorDb("Spell %u listed in `spell_proc_event` is not first rank of spell.", spellId);
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
                sLog->outErrorDb("Spell %u listed in `spell_proc_event` already has its first rank in table.", spellInfo->Id);
                break;
            }

            if (!spellInfo->ProcFlags && !spellProcEvent.procFlags)
                sLog->outErrorDb("Spell %u listed in `spell_proc_event` probally not triggered spell", spellInfo->Id);

            mSpellProcEventMap[spellInfo->Id] = spellProcEvent;

            if (allRanks)
                spellInfo = spellInfo->GetNextRankSpell();
            else
                break;
        }

        ++count;
    }
    while (result->NextRow());

    sLog->outString(">> Loaded %u extra spell proc event conditions in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
}

void SpellMgr::LoadSpellProcs()
{
    uint32 oldMSTime = getMSTime();

    mSpellProcMap.clear();                             // need for reload case

    //                                                 0        1           2                3                 4                 5                 6         7              8               9        10              11             12      13        14
    QueryResult result = WorldDatabase.Query("SELECT spellId, schoolMask, spellFamilyName, spellFamilyMask0, spellFamilyMask1, spellFamilyMask2, typeMask, spellTypeMask, spellPhaseMask, hitMask, attributesMask, ratePerMinute, chance, cooldown, charges FROM spell_proc");
    if (!result)
    {
        sLog->outString(">> Loaded 0 spell proc conditions and data. DB table `spell_proc` is empty.");
        sLog->outString();
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
            sLog->outErrorDb("Spell %u listed in `spell_proc` does not exist", spellId);
            continue;
        }

        if (allRanks)
        {
            if (spellInfo->GetFirstRankSpell()->Id != uint32(spellId))
            {
                sLog->outErrorDb("Spell %u listed in `spell_proc` is not first rank of spell.", fields[0].GetInt32());
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
                sLog->outErrorDb("Spell %u listed in `spell_proc` has duplicate entry in the table", spellId);
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
                sLog->outErrorDb("`spell_proc` table entry for spellId %u has wrong `schoolMask` set: %u", spellId, procEntry.schoolMask);
            if (procEntry.spellFamilyName && (procEntry.spellFamilyName < 3 || procEntry.spellFamilyName > 17 || procEntry.spellFamilyName == 14 || procEntry.spellFamilyName == 16))
                sLog->outErrorDb("`spell_proc` table entry for spellId %u has wrong `spellFamilyName` set: %u", spellId, procEntry.spellFamilyName);
            if (procEntry.chance < 0)
            {
                sLog->outErrorDb("`spell_proc` table entry for spellId %u has negative value in `chance` field", spellId);
                procEntry.chance = 0;
            }
            if (procEntry.ratePerMinute < 0)
            {
                sLog->outErrorDb("`spell_proc` table entry for spellId %u has negative value in `ratePerMinute` field", spellId);
                procEntry.ratePerMinute = 0;
            }
            if (cooldown < 0)
            {
                sLog->outErrorDb("`spell_proc` table entry for spellId %u has negative value in `cooldown` field", spellId);
                procEntry.cooldown = 0;
            }
            if (procEntry.chance == 0 && procEntry.ratePerMinute == 0)
                sLog->outErrorDb("`spell_proc` table entry for spellId %u doesn't have `chance` and `ratePerMinute` values defined, proc will not be triggered", spellId);
            if (procEntry.charges > 99)
            {
                sLog->outErrorDb("`spell_proc` table entry for spellId %u has too big value in `charges` field", spellId);
                procEntry.charges = 99;
            }
            if (!procEntry.typeMask)
                sLog->outErrorDb("`spell_proc` table entry for spellId %u doesn't have `typeMask` value defined, proc will not be triggered", spellId);
            if (procEntry.spellTypeMask & ~PROC_SPELL_TYPE_MASK_ALL)
                sLog->outErrorDb("`spell_proc` table entry for spellId %u has wrong `spellTypeMask` set: %u", spellId, procEntry.spellTypeMask);
            if (procEntry.spellTypeMask && !(procEntry.typeMask & (SPELL_PROC_FLAG_MASK | PERIODIC_PROC_FLAG_MASK)))
                sLog->outErrorDb("`spell_proc` table entry for spellId %u has `spellTypeMask` value defined, but it won't be used for defined `typeMask` value", spellId);
            if (!procEntry.spellPhaseMask && procEntry.typeMask & REQ_SPELL_PHASE_PROC_FLAG_MASK)
                sLog->outErrorDb("`spell_proc` table entry for spellId %u doesn't have `spellPhaseMask` value defined, but it's required for defined `typeMask` value, proc will not be triggered", spellId);
            if (procEntry.spellPhaseMask & ~PROC_SPELL_PHASE_MASK_ALL)
                sLog->outErrorDb("`spell_proc` table entry for spellId %u has wrong `spellPhaseMask` set: %u", spellId, procEntry.spellPhaseMask);
            if (procEntry.spellPhaseMask && !(procEntry.typeMask & REQ_SPELL_PHASE_PROC_FLAG_MASK))
                sLog->outErrorDb("`spell_proc` table entry for spellId %u has `spellPhaseMask` value defined, but it won't be used for defined `typeMask` value", spellId);
            if (procEntry.hitMask & ~PROC_HIT_MASK_ALL)
                sLog->outErrorDb("`spell_proc` table entry for spellId %u has wrong `hitMask` set: %u", spellId, procEntry.hitMask);
            if (procEntry.hitMask && !(procEntry.typeMask & TAKEN_HIT_PROC_FLAG_MASK || (procEntry.typeMask & DONE_HIT_PROC_FLAG_MASK && (!procEntry.spellPhaseMask || procEntry.spellPhaseMask & (PROC_SPELL_PHASE_HIT | PROC_SPELL_PHASE_FINISH)))))
                sLog->outErrorDb("`spell_proc` table entry for spellId %u has `hitMask` value defined, but it won't be used for defined `typeMask` and `spellPhaseMask` values", spellId);

            mSpellProcMap[spellInfo->Id] = procEntry;

            if (allRanks)
                spellInfo = spellInfo->GetNextRankSpell();
            else
                break;
        }
        ++count;
    }
    while (result->NextRow());

    sLog->outString(">> Loaded %u spell proc conditions and data in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void SpellMgr::LoadSpellBonusess()
{
    uint32 oldMSTime = getMSTime();

    mSpellBonusMap.clear();                             // need for reload case

    //                                                0      1             2          3         4
    QueryResult result = WorldDatabase.Query("SELECT entry, direct_bonus, dot_bonus, ap_bonus, ap_dot_bonus FROM spell_bonus_data");
    if (!result)
    {
        sLog->outString(">> Loaded 0 spell bonus data. DB table `spell_bonus_data` is empty.");
        sLog->outString();
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
            sLog->outErrorDb("Spell %u listed in `spell_bonus_data` does not exist", entry);
            continue;
        }

        SpellBonusEntry& sbe = mSpellBonusMap[entry];
        sbe.direct_damage = fields[1].GetFloat();
        sbe.dot_damage    = fields[2].GetFloat();
        sbe.ap_bonus      = fields[3].GetFloat();
        sbe.ap_dot_bonus   = fields[4].GetFloat();

        ++count;
    } while (result->NextRow());

    sLog->outString(">> Loaded %u extra spell bonus data in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void SpellMgr::LoadSpellThreats()
{
    uint32 oldMSTime = getMSTime();

    mSpellThreatMap.clear();                                // need for reload case

    //                                                0      1        2       3
    QueryResult result = WorldDatabase.Query("SELECT entry, flatMod, pctMod, apPctMod FROM spell_threat");
    if (!result)
    {
        sLog->outString(">> Loaded 0 aggro generating spells. DB table `spell_threat` is empty.");
        sLog->outString();
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].GetUInt32();

        if (!GetSpellInfo(entry))
        {
            sLog->outErrorDb("Spell %u listed in `spell_threat` does not exist", entry);
            continue;
        }

        SpellThreatEntry ste;
        ste.flatMod  = fields[1].GetInt32();
        ste.pctMod   = fields[2].GetFloat();
        ste.apPctMod = fields[3].GetFloat();

        mSpellThreatMap[entry] = ste;
        ++count;
    } while (result->NextRow());

    sLog->outString(">> Loaded %u SpellThreatEntries in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void SpellMgr::LoadSpellMixology()
{
    uint32 oldMSTime = getMSTime();

    mSpellMixologyMap.clear();                                // need for reload case

    //                                                0      1
    QueryResult result = WorldDatabase.Query("SELECT entry, pctMod FROM spell_mixology");
    if (!result)
    {
        sLog->outString(">> Loaded 0 mixology bonuses. DB table `spell_mixology` is empty.");
        sLog->outString();
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();

        uint32 entry = fields[0].GetUInt32();

        if (!GetSpellInfo(entry))
        {
            sLog->outErrorDb("Spell %u listed in `spell_mixology` does not exist", entry);
            continue;
        }

        mSpellMixologyMap[entry] = fields[1].GetFloat();;
        ++count;
    } while (result->NextRow());

    sLog->outString(">> Loaded %u Mixology bonuses in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
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

    sLog->outString(">> Loaded %u SkillLineAbility MultiMap Data in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void SpellMgr::LoadSpellPetAuras()
{
    uint32 oldMSTime = getMSTime();

    mSpellPetAuraMap.clear();                                  // need for reload case

    //                                                  0       1       2    3
    QueryResult result = WorldDatabase.Query("SELECT spell, effectId, pet, aura FROM spell_pet_auras");
    if (!result)
    {
        sLog->outString(">> Loaded 0 spell pet auras. DB table `spell_pet_auras` is empty.");
        sLog->outString();
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

        SpellPetAuraMap::iterator itr = mSpellPetAuraMap.find((spell<<8) + eff);
        if (itr != mSpellPetAuraMap.end())
            itr->second.AddAura(pet, aura);
        else
        {
            SpellInfo const* spellInfo = GetSpellInfo(spell);
            if (!spellInfo)
            {
                sLog->outErrorDb("Spell %u listed in `spell_pet_auras` does not exist", spell);
                continue;
            }
            if (spellInfo->Effects[eff].Effect != SPELL_EFFECT_DUMMY &&
               (spellInfo->Effects[eff].Effect != SPELL_EFFECT_APPLY_AURA ||
                spellInfo->Effects[eff].ApplyAuraName != SPELL_AURA_DUMMY))
            {
                sLog->outError("Spell %u listed in `spell_pet_auras` does not have dummy aura or dummy effect", spell);
                continue;
            }

            SpellInfo const* spellInfo2 = GetSpellInfo(aura);
            if (!spellInfo2)
            {
                sLog->outErrorDb("Aura %u listed in `spell_pet_auras` does not exist", aura);
                continue;
            }

            PetAura pa(pet, aura, spellInfo->Effects[eff].TargetA.GetTarget() == TARGET_UNIT_PET, spellInfo->Effects[eff].CalcValue());
            mSpellPetAuraMap[(spell<<8) + eff] = pa;
        }

        ++count;
    } while (result->NextRow());

    sLog->outString(">> Loaded %u spell pet auras in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
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
        if (!spellInfo->HasAttribute(SPELL_ATTR2_PRESERVE_ENCHANT_IN_ARENA)/* || !spellInfo->HasAttribute(SPELL_ATTR0_NOT_SHAPESHIFT)*/)
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

    sLog->outString(">> Loaded %u custom enchant attributes in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void SpellMgr::LoadSpellEnchantProcData()
{
    uint32 oldMSTime = getMSTime();

    mSpellEnchantProcEventMap.clear();                             // need for reload case

    //                                                  0         1           2         3
    QueryResult result = WorldDatabase.Query("SELECT entry, customChance, PPMChance, procEx FROM spell_enchant_proc_data");
    if (!result)
    {
        sLog->outString(">> Loaded 0 spell enchant proc event conditions. DB table `spell_enchant_proc_data` is empty.");
        sLog->outString();
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
            sLog->outErrorDb("Enchancment %u listed in `spell_enchant_proc_data` does not exist", enchantId);
            continue;
        }

        SpellEnchantProcEntry spe;

        spe.customChance = fields[1].GetUInt32();
        spe.PPMChance = fields[2].GetFloat();
        spe.procEx = fields[3].GetUInt32();

        mSpellEnchantProcEventMap[enchantId] = spe;

        ++count;
    } while (result->NextRow());

    sLog->outString(">> Loaded %u enchant proc data definitions in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void SpellMgr::LoadSpellLinked()
{
    uint32 oldMSTime = getMSTime();

    mSpellLinkedMap.clear();    // need for reload case

    //                                                0              1             2
    QueryResult result = WorldDatabase.Query("SELECT spell_trigger, spell_effect, type FROM spell_linked_spell");
    if (!result)
    {
        sLog->outString(">> Loaded 0 linked spells. DB table `spell_linked_spell` is empty.");
        sLog->outString();
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
            sLog->outErrorDb("Spell %u listed in `spell_linked_spell` does not exist", abs(trigger));
            continue;
        }
        spellInfo = GetSpellInfo(abs(effect));
        if (!spellInfo)
        {
            sLog->outErrorDb("Spell %u listed in `spell_linked_spell` does not exist", abs(effect));
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

    sLog->outString(">> Loaded %u linked spells in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
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

    sLog->outString(">> Loaded %u pet levelup and default spells for %u families in %u ms", count, family_count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
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
    if (PetLevelupSpellSet const* levelupSpells = cInfo->family ? sSpellMgr->GetPetLevelupSpellList(cInfo->family) : NULL)
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

    sLog->outString(">> Loaded addition spells for %u pet spell data entries in %u ms", countData, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();

    sLog->outString("Loading summonable creature templates...");
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

    sLog->outString(">> Loaded %u summonable creature templates in %u ms", countCreature, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
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
        sLog->outString(">> Loaded 0 spell area requirements. DB table `spell_area` is empty.");
        sLog->outString();
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
                const_cast<SpellInfo*>(spellInfo)->Attributes |= SPELL_ATTR0_CANT_CANCEL;
        }
        else
        {
            sLog->outErrorDb("Spell %u listed in `spell_area` does not exist", spell);
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
                sLog->outErrorDb("Spell %u listed in `spell_area` already listed with similar requirements.", spell);
                continue;
            }
        }

        if (spellArea.areaId && !sAreaTableStore.LookupEntry(spellArea.areaId))
        {
            sLog->outErrorDb("Spell %u listed in `spell_area` have wrong area (%u) requirement", spell, spellArea.areaId);
            continue;
        }

        if (spellArea.questStart && !sObjectMgr->GetQuestTemplate(spellArea.questStart))
        {
            sLog->outErrorDb("Spell %u listed in `spell_area` have wrong start quest (%u) requirement", spell, spellArea.questStart);
            continue;
        }

        if (spellArea.questEnd)
        {
            if (!sObjectMgr->GetQuestTemplate(spellArea.questEnd))
            {
                sLog->outErrorDb("Spell %u listed in `spell_area` have wrong end quest (%u) requirement", spell, spellArea.questEnd);
                continue;
            }
        }

        if (spellArea.auraSpell)
        {
            SpellInfo const* spellInfo = GetSpellInfo(abs(spellArea.auraSpell));
            if (!spellInfo)
            {
                sLog->outErrorDb("Spell %u listed in `spell_area` have wrong aura spell (%u) requirement", spell, abs(spellArea.auraSpell));
                continue;
            }

            if (uint32(abs(spellArea.auraSpell)) == spellArea.spellId)
            {
                sLog->outErrorDb("Spell %u listed in `spell_area` have aura spell (%u) requirement for itself", spell, abs(spellArea.auraSpell));
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
                    sLog->outErrorDb("Spell %u listed in `spell_area` have aura spell (%u) requirement that itself autocast from aura", spell, spellArea.auraSpell);
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
                    sLog->outErrorDb("Spell %u listed in `spell_area` have aura spell (%u) requirement that itself autocast from aura", spell, spellArea.auraSpell);
                    continue;
                }
            }
        }

        if (spellArea.raceMask && (spellArea.raceMask & RACEMASK_ALL_PLAYABLE) == 0)
        {
            sLog->outErrorDb("Spell %u listed in `spell_area` have wrong race mask (%u) requirement", spell, spellArea.raceMask);
            continue;
        }

        if (spellArea.gender != GENDER_NONE && spellArea.gender != GENDER_FEMALE && spellArea.gender != GENDER_MALE)
        {
            sLog->outErrorDb("Spell %u listed in `spell_area` have wrong gender (%u) requirement", spell, spellArea.gender);
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

    sLog->outString(">> Loaded %u spell area requirements in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void SpellMgr::LoadSpellInfoStore()
{
    uint32 oldMSTime = getMSTime();

    UnloadSpellInfoStore();
    mSpellInfoMap.resize(sSpellStore.GetNumRows(), NULL);

    for (uint32 i = 0; i < sSpellStore.GetNumRows(); ++i)
    {
        if (SpellEntry const* spellEntry = sSpellStore.LookupEntry(i))
            mSpellInfoMap[i] = new SpellInfo(spellEntry);
    }

    sLog->outString(">> Loaded spell custom attributes in %u ms", GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
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

    SpellInfo* spellInfo = NULL;
    for (uint32 i = 0; i < GetSpellInfoStoreSize(); ++i)
    {
        spellInfo = mSpellInfoMap[i];
        if (!spellInfo)
            continue;
        spellInfo->_spellSpecific = spellInfo->LoadSpellSpecific();
        spellInfo->_auraState = spellInfo->LoadAuraState();
    }

    sLog->outString(">> Loaded spell specific and aura state in %u ms", GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void SpellMgr::LoadSpellCustomAttr()
{
    uint32 oldMSTime = getMSTime();

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
                                if (learnSpell->IsRanked() && !learnSpell->HasAttribute(SpellAttr0(SPELL_ATTR0_PASSIVE|SPELL_ATTR0_HIDDEN_CLIENTSIDE)))
                                    mTalentSpellAdditionalSet.insert(learnSpell->Id);
    }

    SpellInfo* spellInfo = NULL;
    for (uint32 i = 0; i < GetSpellInfoStoreSize(); ++i)
    {
        spellInfo = mSpellInfoMap[i];
        if (!spellInfo)
            continue;

        for (uint8 j = 0; j < MAX_SPELL_EFFECTS; ++j)
        {
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
                        for (uint8 s = 0; s < MAX_ITEM_ENCHANTMENT_EFFECTS; ++s)
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
        if (!spellInfo->HasAttribute(SPELL_ATTR3_IGNORE_HIT_RESULT))
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
                        default:
                            if (spellInfo->Effects[j].CalcValue() || ((spellInfo->Effects[j].Effect == SPELL_EFFECT_INTERRUPT_CAST || spellInfo->HasAttribute(SPELL_ATTR0_CU_AURA_CC)) && !spellInfo->HasAttribute(SPELL_ATTR0_UNAFFECTED_BY_INVULNERABILITY)))
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
            case 65775: // Anub'arak, Swarm Scarab, Acid-Drenched Mandibles
            case 67861:
            case 67862:
            case 67863:
            case 67721: // Anub'arak, Nerubian Burrower, Expose Weakness
            case 64638: // Ulduar, Winter Jormungar, Acidic Bite
            case 71157: // Icecrown Citadel, Plagued Zombie, Infected Wound
            case 72963: // Icecrown Citadel, Valithria Dreamwalker, Flesh Rot (Rot Worm)
            case 72964:
            case 72965:
            case 72966:
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
            case 29306: // Naxxramas(Gluth's Zombies): Infected Wound
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

        switch (spellInfo->SpellFamilyName)
        {
            case SPELLFAMILY_WARRIOR:
                // Shout / Piercing Howl
                if (spellInfo->SpellFamilyFlags[0] & 0x20000 || spellInfo->SpellFamilyFlags[1] & 0x20)
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_AURA_CC;
                break;
            case SPELLFAMILY_DRUID:
                // Roar
                if (spellInfo->SpellFamilyFlags[0] & 0x8)
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_AURA_CC;
                break;
            case SPELLFAMILY_GENERIC:
                // Stoneclaw Totem effect
                if(spellInfo->Id == 5729)
                    spellInfo->AttributesCu |= SPELL_ATTR0_CU_AURA_CC;
                break;
            default:
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

    sLog->outString(">> Loaded spell custom attributes in %u ms", GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void SpellMgr::LoadDbcDataCorrections()
{
    uint32 oldMSTime = getMSTime();

    SpellEntry* spellInfo = NULL;
    for (uint32 i = 0; i < sSpellStore.GetNumRows(); ++i)
    {
        spellInfo = (SpellEntry*)sSpellStore.LookupEntry(i);
        if (!spellInfo)
            continue;

        for (uint8 j = 0; j < MAX_SPELL_EFFECTS; ++j)
        {
            switch (spellInfo->Effect[j])
            {
                case SPELL_EFFECT_CHARGE:
                case SPELL_EFFECT_CHARGE_DEST:
                case SPELL_EFFECT_JUMP:
                case SPELL_EFFECT_JUMP_DEST:
                case SPELL_EFFECT_LEAP_BACK:
                    if (!spellInfo->speed && !spellInfo->SpellFamilyName)
                        spellInfo->speed = SPEED_CHARGE;
                    break;
            }

            // Xinef: i hope this will fix the problem with not working resurrection
            if (spellInfo->Effect[j] == SPELL_EFFECT_SELF_RESURRECT)
                spellInfo->EffectImplicitTargetA[j] = TARGET_UNIT_CASTER;
        }

        // Xinef: Fix range for trajectories and triggered spells
        for (uint8 j = 0; j < 3; ++j)
            if (spellInfo->rangeIndex == 1 && (spellInfo->EffectImplicitTargetA[j] == TARGET_DEST_TRAJ || spellInfo->EffectImplicitTargetB[j] == TARGET_DEST_TRAJ))
                if (SpellEntry* spellInfo2 = (SpellEntry*)sSpellStore.LookupEntry(spellInfo->EffectTriggerSpell[j]))
                    spellInfo2->rangeIndex = 187; // 300yd

        if (spellInfo->activeIconID == 2158)  // flight
            spellInfo->Attributes |= SPELL_ATTR0_PASSIVE;

        switch (spellInfo->Id)
        {
            case 38776: // Evergrove Druid Transform Crow
                spellInfo->DurationIndex = 4; // 120 seconds
                break;
            case 63026: // Force Cast (HACK: Target shouldn't be changed)
            case 63137: // Force Cast (HACK: Target shouldn't be changed; summon position should be untied from spell destination)
                spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_DEST_DB;
                break;
            case 53096: // Quetz'lun's Judgment
            case 70743: // AoD Special
            case 70614: // AoD Special - Vegard
                spellInfo->MaxAffectedTargets = 1;
                break;
            case 52611: // Summon Skeletons
            case 52612: // Summon Skeletons
                spellInfo->EffectMiscValueB[0] = 64;
                break;
            case 45257: // Using Steam Tonk Controller
            case 45440: // Steam Tonk Controller
            case 60256: // Collect Sample
                // Crashes client on pressing ESC
                spellInfo->AttributesEx4 &= ~SPELL_ATTR4_CAN_CAST_WHILE_CASTING;
                break;
            case 40244: // Simon Game Visual
            case 40245: // Simon Game Visual
            case 40246: // Simon Game Visual
            case 40247: // Simon Game Visual
            case 42835: // Spout, remove damage effect, only anim is needed
                spellInfo->Effect[0] = 0;
                break;
            case 63665: // Charge (Argent Tournament emote on riders)
            case 31298: // Sleep (needs target selection script)
            case 2895:  // Wrath of Air Totem rank 1 (Aura)
            case 68933: // Wrath of Air Totem rank 2 (Aura)
            case 29200: // Purify Helboar Meat
                spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
                spellInfo->EffectImplicitTargetB[0] = 0;
                break;
            case 31344: // Howl of Azgalor
                spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_100_YARDS; // 100yards instead of 50000?!
                break;
            case 42818: // Headless Horseman - Wisp Flight Port
            case 42821: // Headless Horseman - Wisp Flight Missile
                spellInfo->rangeIndex = 6; // 100 yards
                break;
            case 36350: //They Must Burn Bomb Aura (self)
                spellInfo->EffectTriggerSpell[0] = 36325; // They Must Burn Bomb Drop (DND)
                break;
        case 8494: // Mana Shield (rank 2)
            // because of bug in dbc
            spellInfo->procChance = 0;
            break;
        case 63320: // Glyph of Life Tap
        // Entries were not updated after spell effect change, we have to do that manually :/
            spellInfo->AttributesEx3 |= SPELL_ATTR3_CAN_PROC_WITH_TRIGGERED;
            break;
        case 31347: // Doom
        case 41635: // Prayer of Mending
        case 39365: // Thundering Storm
        case 52124: // Sky Darkener Assault
        case 42442: // Vengeance Landing Cannonfire
        case 45863: // Cosmetic - Incinerate to Random Target
        case 25425: // Shoot
        case 45761: // Shoot
        case 42611: // Shoot
        case 61588: // Blazing Harpoon
        case 36327: // Shoot Arcane Explosion Arrow
            spellInfo->MaxAffectedTargets = 1;
            break;
        case 36384: // Skartax Purple Beam
            spellInfo->MaxAffectedTargets = 2;
            break;
        case 37790: // Spread Shot
        case 54172: // Divine Storm (heal)
        case 66588: // Flaming Spear
        case 54171: // Divine Storm
            spellInfo->MaxAffectedTargets = 3;
            break;
        case 53385: // Divine Storm (Damage)
            spellInfo->MaxAffectedTargets = 4;
            break;
        case 38296: // Spitfire Totem
            spellInfo->MaxAffectedTargets = 5;
            break;
        case 40827: // Sinful Beam
        case 40859: // Sinister Beam
        case 40860: // Vile Beam
        case 40861: // Wicked Beam
            spellInfo->MaxAffectedTargets = 10;
            break;
        case 50312: // Unholy Frenzy
            spellInfo->MaxAffectedTargets = 15;
            break;
        case 17941: // Shadow Trance
        case 22008: // Netherwind Focus
        case 31834: // Light's Grace
        case 34754: // Clearcasting
        case 34936: // Backlash
        case 48108: // Hot Streak
        case 51124: // Killing Machine
        case 54741: // Firestarter
        case 57761: // Fireball!
        case 39805: // Lightning Overload
        case 64823: // Item - Druid T8 Balance 4P Bonus
        case 34477: // Misdirection
        case 44401: // Missile Barrage
        case 18820: // Insight
            spellInfo->procCharges = 1;
            break;
        case 53390: // Tidal Wave
            spellInfo->procCharges = 2;
            break;
        case 37408: // Oscillation Field
            spellInfo->AttributesEx3 |= SPELL_ATTR3_STACK_FOR_DIFF_CASTERS;
            break;
        case 28200: // Ascendance (Talisman of Ascendance trinket)
            spellInfo->procCharges = 6;
            break;
        case 51852: // The Eye of Acherus (no spawn in phase 2 in db)
            spellInfo->EffectMiscValue[0] |= 1;
            break;
        case 51912: // Crafty's Ultra-Advanced Proto-Typical Shortening Blaster
            spellInfo->EffectAmplitude[0] = 3000;
            break;
        case 29809: // Desecration Arm - 36 instead of 37 - typo? :/
            spellInfo->EffectRadiusIndex[0] = 37;
            break;
        // Master Shapeshifter: missing stance data for forms other than bear - bear version has correct data
        // To prevent aura staying on target after talent unlearned
        case 48420:
            spellInfo->Stances = 1 << (FORM_CAT - 1);
            break;
        case 48421:
            spellInfo->Stances = 1 << (FORM_MOONKIN - 1);
            break;
        case 48422:
            spellInfo->Stances = 1 << (FORM_TREE - 1);
            break;
        case 51466: // Elemental Oath (Rank 1)
        case 51470: // Elemental Oath (Rank 2)
            spellInfo->Effect[EFFECT_1] = SPELL_EFFECT_APPLY_AURA;
            spellInfo->EffectApplyAuraName[EFFECT_1] = SPELL_AURA_ADD_FLAT_MODIFIER;
            spellInfo->EffectMiscValue[EFFECT_1] = SPELLMOD_EFFECT2;
            spellInfo->EffectSpellClassMask[EFFECT_1] = flag96(0x00000000, 0x00004000, 0x00000000);
            break;
        case 47569: // Improved Shadowform (Rank 1)
            // with this spell atrribute aura can be stacked several times
            spellInfo->Attributes &= ~SPELL_ATTR0_NOT_SHAPESHIFT;
            break;
        case 30421: // Nether Portal - Perseverence
            spellInfo->EffectBasePoints[2] += 30000;
            break;
        case 16834: // Natural shapeshifter
        case 16835:
            spellInfo->DurationIndex = 21;
            break;
        case 51735: // Ebon Plague
        case 51734:
        case 51726:
            spellInfo->SpellFamilyFlags[2] = 0x10;
            spellInfo->EffectApplyAuraName[1] = SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN;
            spellInfo->AttributesEx3 |= SPELL_ATTR3_STACK_FOR_DIFF_CASTERS;
            break;
        case 41013: // Parasitic Shadowfiend Passive
            spellInfo->EffectApplyAuraName[0] = SPELL_AURA_DUMMY; // proc debuff, and summon infinite fiends
            break;
        case 27892: // To Anchor 1
        case 27928: // To Anchor 1
        case 27935: // To Anchor 1
        case 27915: // Anchor to Skulls
        case 27931: // Anchor to Skulls
        case 27937: // Anchor to Skulls
            spellInfo->rangeIndex = 13;
            break;
        // target allys instead of enemies, target A is src_caster, spells with effect like that have ally target
        // this is the only known exception, probably just wrong data
        case 29214: // Wrath of the Plaguebringer
        case 54836: // Wrath of the Plaguebringer
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ALLY;
            spellInfo->EffectImplicitTargetB[1] = TARGET_UNIT_SRC_AREA_ALLY;
            break;
        case 57994: // Wind Shear - improper data for EFFECT_1 in 3.3.5 DBC, but is correct in 4.x
            spellInfo->Effect[EFFECT_1] = SPELL_EFFECT_MODIFY_THREAT_PERCENT;
            spellInfo->EffectBasePoints[EFFECT_1] = -6; // -5%
            break;
        case 63675: // Improved Devouring Plague
            spellInfo->EffectBonusMultiplier[0] = 0;
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_DONE_BONUS;
            break;
        case 8145: // Tremor Totem (instant pulse)
        case 6474: // Earthbind Totem (instant pulse)
            spellInfo->AttributesEx5 |= SPELL_ATTR5_START_PERIODIC_AT_APPLY;
            break;
        case 53241: // Marked for Death (Rank 1)
        case 53243: // Marked for Death (Rank 2)
        case 53244: // Marked for Death (Rank 3)
        case 53245: // Marked for Death (Rank 4)
        case 53246: // Marked for Death (Rank 5)
            spellInfo->EffectSpellClassMask[0] = flag96(423937, 276955137, 2049);
            break;
        case 70728: // Exploit Weakness
        case 70840: // Devious Minds
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_PET;
            break;
        case 70893: // Culling The Herd
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_MASTER;
            break;
        case 54800: // Sigil of the Frozen Conscience - change class mask to custom extended flags of Icy Touch
                        // this is done because another spell also uses the same SpellFamilyFlags as Icy Touch
                        // SpellFamilyFlags[0] & 0x00000040 in SPELLFAMILY_DEATHKNIGHT is currently unused (3.3.5a)
                        // this needs research on modifier applying rules, does not seem to be in Attributes fields
            spellInfo->EffectSpellClassMask[0] = flag96(0x00000040, 0x00000000, 0x00000000);
            break;
        case 64949: // Idol of the Flourishing Life
            spellInfo->EffectSpellClassMask[EFFECT_0] = flag96(0x00000000, 0x02000000, 0x00000000);
            spellInfo->EffectApplyAuraName[EFFECT_0] = SPELL_AURA_ADD_FLAT_MODIFIER;
            break;
        case 34231: // Libram of the Lightbringer
        case 60792: // Libram of Tolerance
        case 64956: // Libram of the Resolute
            spellInfo->EffectSpellClassMask[EFFECT_0] = flag96(0x80000000, 0x00000000, 0x00000000);
            spellInfo->EffectApplyAuraName[EFFECT_0] = SPELL_AURA_ADD_FLAT_MODIFIER;
            break;
        case 28851: // Libram of Light
        case 28853: // Libram of Divinity
        case 32403: // Blessed Book of Nagrand
            spellInfo->EffectSpellClassMask[EFFECT_0] = flag96(0x40000000, 0x00000000, 0x00000000);
            spellInfo->EffectApplyAuraName[EFFECT_0] = SPELL_AURA_ADD_FLAT_MODIFIER;
            break;
        case 45602: // Ride Carpet
            spellInfo->EffectBasePoints[EFFECT_0] = 0; // force seat 0, vehicle doesn't have the required seat flags for "no seat specified (-1)"
            break;
        case 64745: // Item - Death Knight T8 Tank 4P Bonus
        case 64936: // Item - Warrior T8 Protection 4P Bonus
            spellInfo->EffectBasePoints[EFFECT_0] = 100; // 100% chance of procc'ing, not -10% (chance calculated in PrepareTriggersExecutedOnHit)
            break;
        case 61719: // Easter Lay Noblegarden Egg Aura - Interrupt flags copied from aura which this aura is linked with
            spellInfo->AuraInterruptFlags = AURA_INTERRUPT_FLAG_HITBYSPELL | AURA_INTERRUPT_FLAG_TAKE_DAMAGE;
            break;
        case 51640: // spell for item The Flag of Ownership (38578)
            spellInfo->AttributesEx3 |= SPELL_ATTR3_ONLY_TARGET_PLAYERS;
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_DEAD;
            spellInfo->MaxAffectedTargets = 1;
            break;
        case 34471: // The Beast Within
            spellInfo->AttributesEx5 |= SPELL_ATTR5_USABLE_WHILE_CONFUSED | SPELL_ATTR5_USABLE_WHILE_FEARED | SPELL_ATTR5_USABLE_WHILE_STUNNED;
            break;
        case 40055: // Introspection
        case 40165: // Introspection
        case 40166: // Introspection
        case 40167: // Introspection
            spellInfo->Attributes |= SPELL_ATTR0_NEGATIVE_1;
            break;
        case 2378: // Minor Fortitude
            spellInfo->manaCost = 0;
            spellInfo->manaPerSecond = 0;
            break;
        case 24314: // Threatening Gaze
            spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CAST | AURA_INTERRUPT_FLAG_MOVE | AURA_INTERRUPT_FLAG_JUMP;
            break;


        /////////////////////////////////////////////
        /////////////////CLASS SPELLS////////////////
        /////////////////////////////////////////////

        /////////////////////////////////
        ///// PALADIN
        /////////////////////////////////
        // Heart of the Crusader
        case 20335:
        case 20336:
        case 20337:
            if (spellInfo->Id == 20335)
                spellInfo->EffectTriggerSpell[0] = 21183;
            else if (spellInfo->Id == 20336)
                spellInfo->EffectTriggerSpell[0] = 54498;
            else
                spellInfo->EffectTriggerSpell[0] = 54499;
            spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PROC_TRIGGER_SPELL;
            break;
        // Bleh, need to change FamilyFlags :/ (have the same as original aura - bad!)
        case 63510:
            spellInfo->SpellFamilyFlags[0] = 0;
            spellInfo->SpellFamilyFlags[2] = 0x4000000;
            break;
        case 63514:
            spellInfo->SpellFamilyFlags[0] = 0;
            spellInfo->SpellFamilyFlags[2] = 0x2000000;
            break;
        case 63531:
            spellInfo->SpellFamilyFlags[0] = 0;
            spellInfo->SpellFamilyFlags[2] = 0x8000000;
            break;
        // And affecting spells
        case 20138:
        case 20139:
        case 20140:// Improved Devotion Aura
            spellInfo->EffectSpellClassMask[1][0] = 0;
            spellInfo->EffectSpellClassMask[1][2] = 0x2000000;
            break;
        case 20254:
        case 20255:
        case 20256:// Improved concentration aura
            spellInfo->EffectSpellClassMask[1][0] = 0;
            spellInfo->EffectSpellClassMask[1][2] = 0x4000000;
            spellInfo->EffectSpellClassMask[2][0] = 0;
            spellInfo->EffectSpellClassMask[2][2] = 0x4000000;
            break;
        case 53379:
        case 53484:
        case 53648:// Swift Retribution
            spellInfo->EffectSpellClassMask[0][0] = 0;
            spellInfo->EffectSpellClassMask[0][2] = 0x8000000;
            break;
        case 31869:// Sanctified Retribution
            spellInfo->EffectSpellClassMask[0][0] = 0;
            spellInfo->EffectSpellClassMask[0][2] = 0x8000000;
            break;
        /* Judgements Facing   -- SCEICCO: not sure this is offylike
        case 20271:
        case 53407:
        case 53408:
            spellInfo->FacingCasterFlags |= SPELL_FACING_FLAG_INFRONT;
            break;*/
        // Seal of Light trigger
        case 20167:
            spellInfo->spellLevel = 0;
            spellInfo->baseLevel = 0;
            spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
            break;
        // Light's Beacon, Beacon of Light
        case 53651:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_STACK_FOR_DIFF_CASTERS;
            break;
        // Hand of Reckoning
        case 62124:
            spellInfo->AttributesEx |= SPELL_ATTR1_CANT_BE_REDIRECTED;
            break;
        // Redemption
        case 7328:
        case 10322:
        case 10324:
        case 20772:
        case 20773:
        case 48949:
        case 48950:
            spellInfo->SpellFamilyName = SPELLFAMILY_PALADIN;
            break;
        // hack for seal of light and few spells, judgement consists of few single casts and each of them can proc
        // some spell, base one has disabled proc flag but those dont have this flag
        case 20184:
        case 20185:
        case 20186:
        case 68055:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_CANT_TRIGGER_PROC;
            break;
        // Blessing of sanctuary stats
        case 67480:
            spellInfo->EffectMiscValue[0] = -1;
            spellInfo->SpellFamilyName = SPELLFAMILY_UNK1; // allows stacking
            spellInfo->EffectApplyAuraName[1] = SPELL_AURA_DUMMY; // just a marker
            break;
        // Seal of Command trigger
        case 20424:
            spellInfo->AttributesEx3 &= ~SPELL_ATTR3_CANT_TRIGGER_PROC;
            break;
        // Glyph of Holy Light, Damage Class should be magic
        case 54968:
        // Beacon of Light heal, Damage Class should be magic
        case 53652:
        case 53654:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_DONE_BONUS;
            spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
            break;


        /////////////////////////////////
        ///// HUNTER
        /////////////////////////////////
        // Furious Howl
        case 64491:
        case 64492:
        case 64493:
        case 64494:
        case 64495:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_MASTER;
            spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_CASTER;
            spellInfo->EffectImplicitTargetB[1] = TARGET_UNIT_MASTER;
            break;
        // Call of the Wild
        case 53434:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_MASTER;
            spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_MASTER;
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_CASTER;
            spellInfo->EffectImplicitTargetB[1] = TARGET_UNIT_CASTER;
            break;
        // Wild Hunt
        case 62758:
        case 62762:
            spellInfo->Effect[0] = SPELL_EFFECT_APPLY_AURA;
            spellInfo->EffectApplyAuraName[0] = SPELL_AURA_DUMMY;
            spellInfo->Effect[1] = SPELL_EFFECT_APPLY_AURA;
            spellInfo->EffectApplyAuraName[1] = SPELL_AURA_DUMMY;
            break;
        // Intervene
        case 3411:
            spellInfo->Attributes |= SPELL_ATTR0_STOP_ATTACK_TARGET;
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_INITIAL_AGGRO;
            break;
        // Roar of Sacrifice
        case 53480:
            spellInfo->Effect[1] = SPELL_EFFECT_APPLY_AURA;
            spellInfo->EffectApplyAuraName[1] = SPELL_AURA_SPLIT_DAMAGE_PCT;
            spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_TARGET_ALLY;
            spellInfo->EffectDieSides[1] = 1;
            spellInfo->EffectBasePoints[1] = 19;
            spellInfo->EffectMiscValue[1] = 127; // all schools
            break;
        // Silencing Shot
        case 34490:
        case 41084:
        case 42671:
            spellInfo->speed = 0.0f;
            break;
        // Monstrous Bite
        case 54680:
        case 55495:
        case 55496:
        case 55497:
        case 55498:
        case 55499:
            spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_CASTER;
            break;
        // Hunter's Mark
        case 1130:
        case 14323:
        case 14324:
        case 14325:
        case 53338:
            spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
            spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_HIT_RESULT;
            break;
        // Cobra Strikes
        case 53257:
            spellInfo->procCharges = 2;
            spellInfo->StackAmount = 0;
            break;
        // Kill Command
        case 34027:
            spellInfo->procCharges = 0;
            break;
        // Kindred Spirits, damage aura
        case 57458:
            spellInfo->AttributesEx4 |= SPELL_ATTR4_UNK21;
            break;
        // Chimera Shot - Serpent trigger
        case 53353:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_DONE_BONUS;
            break;
        // Entrapment trigger
        case 19185:
        case 64803:
        case 64804:
            spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_DEST_TARGET_ENEMY;
            spellInfo->EffectImplicitTargetB[EFFECT_0] = TARGET_UNIT_DEST_AREA_ENEMY;
            spellInfo->AttributesEx5 |= SPELL_ATTR5_SKIP_CHECKCAST_LOS_CHECK;
            break;
         // Improved Stings (Rank 2)
        case 19465:
            spellInfo->EffectImplicitTargetA[EFFECT_2] = TARGET_UNIT_CASTER;
            break;
        // Explosive Shot (trigger)
        case 53352:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_HIT_RESULT;
            break;
        // Heart of the Phoenix (triggered)
        case 54114:
            spellInfo->AttributesEx &= ~SPELL_ATTR1_DISMISS_PET;
            spellInfo->RecoveryTime = 8*60*IN_MILLISECONDS; // prev 600000
            break;



        /////////////////////////////////
        ///// ROGUE
        /////////////////////////////////
        // Master of Subtlety
        case 31221:
        case 31222:
        case 31223:
            spellInfo->SpellFamilyName = SPELLFAMILY_ROGUE;
            break;
        // Master of Subtlety triggers
        case 31666:
        // Overkill
        case 58428:
            spellInfo->Effect[0] = SPELL_EFFECT_SCRIPT_EFFECT;
            break;
        // Honor Among Thieves
        case 51698:
        case 51700:
        case 51701:
            spellInfo->EffectTriggerSpell[0] = 51699;
            break;
        // Slice and Dice
        case 5171:
        case 6774:
        // Distract
        case 1725:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_INITIAL_AGGRO;
            break;
        // Envenom
        case 32645:
        case 32684:
        case 57992:
        case 57993:
            spellInfo->Dispel = DISPEL_NONE;
            break;
        // Killing Spree (teleport)
        case 57840:
            spellInfo->rangeIndex = 6; // 100 yards
            break;
        // Killing Spree
        case 51690:
            spellInfo->AttributesEx |= SPELL_ATTR1_NOT_BREAK_STEALTH;
            break;


        /////////////////////////////////
        ///// DEATH KNIGHT
        /////////////////////////////////
        // Blood Tap visual cd reset
        case 47804:
            spellInfo->Effect[2] = 0;
            spellInfo->Effect[1] = 0;
            spellInfo->runeCostID = 442;
            break;
        // Chains of Ice
        case 45524:
            spellInfo->Effect[EFFECT_2] = 0;
            break;
        // Impurity
        case 49220:
        case 49633:
        case 49635:
        case 49636:
        case 49638:
            spellInfo->Effect[0] = SPELL_EFFECT_APPLY_AURA;
            spellInfo->EffectApplyAuraName[0] = SPELL_AURA_DUMMY;
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            spellInfo->SpellFamilyName = SPELLFAMILY_DEATHKNIGHT;
            break;
        // Deadly Aggression (Deadly Gladiator's Death Knight Relic, item: 42620)
        case 60549:
            spellInfo->Effect[1] = 0;
            break;
        // Magic Suppression
        case 49224:
        case 49610:
        case 49611:
            spellInfo->procCharges = 0;
            break;
        // Wandering Plague
        case 50526:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_DONE_BONUS;
            spellInfo->AttributesEx3 |=  SPELL_ATTR3_NO_INITIAL_AGGRO;
            break;
        // Dancing Rune Weapon
        case 49028:
            spellInfo->Effect[2] = 0;
            spellInfo->procFlags |= PROC_FLAG_DONE_MELEE_AUTO_ATTACK;
            break;
        // Death and Decay
        case 52212:
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            spellInfo->AttributesEx6 |= SPELL_ATTR6_CAN_TARGET_INVISIBLE;
            break;
        // T9 blood plague crit bonus
        case 67118:
            spellInfo->Effect[1] = 0;
            break;
        // Pestilence
        case 50842:
            spellInfo->EffectImplicitTargetA[2] = TARGET_DEST_TARGET_ENEMY;
            break;
        // Horn of Winter, stacking issues
        case 57330:
        case 57623:
            spellInfo->EffectImplicitTargetA[1] = 0;
            break;
        // Scourge Strike trigger
        case 70890:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_CANT_TRIGGER_PROC;
            break;
        // Blood-caked Blade - Blood-caked Strike trigger
        case 50463:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_CANT_TRIGGER_PROC;
            break;
        // Blood Gorged - ARP affect Death Strike and Rune Strike
        case 61274:
        case 61275:
        case 61276:
        case 61277:
        case 61278:
            spellInfo->EffectSpellClassMask[EFFECT_0] = flag96(0x1400011, 0x20000000, 0x0);
            break;
        // Death Grip, remove main grip mechanic, leave only effect one
        // Death Grip, should fix taunt on bosses and not break the pull protection at the same time (no aura provides immunity to grip mechanic)
        case 49576:
        case 49560:
            spellInfo->Mechanic = 0;
            break;
        // Death Grip Jump Dest
        case 57604:
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            break;
        // Death Pact
        case 48743:
            spellInfo->AttributesEx &= ~SPELL_ATTR1_CANT_TARGET_SELF;
            break;
        // Raise Ally (trigger)
        case 46619:
            spellInfo->Attributes &= ~SPELL_ATTR0_CANT_CANCEL;
            break;
        // Frost Strike
        case 49143:
        case 51416:
        case 51417:
        case 51418:
        case 51419:
        case 55268:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_BLOCKABLE_SPELL;
            break;



        /////////////////////////////////
        ///// SHAMAN
        /////////////////////////////////
        // Lightning overload
        case 45297:
        case 45284:
            spellInfo->CategoryRecoveryTime = 0;
            spellInfo->RecoveryTime = 0;
            spellInfo->AttributesEx6 |= SPELL_ATTR6_LIMIT_PCT_DAMAGE_MODS;
            break;
        // Improved Earth Shield
        case 51560:
        case 51561:
            spellInfo->EffectMiscValue[1] = SPELLMOD_DAMAGE;
            break;
        // Tidal Force
        case 55166:
        case 55198:
            spellInfo->DurationIndex = 18;
            spellInfo->procCharges = 0;
            break;
        // Healing Stream Totem
        case 52042:
            spellInfo->spellLevel = 0;
            spellInfo->baseLevel = 0;
            spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
            break;
        // Earth Shield
        case 379:
            spellInfo->spellLevel = 0;
            spellInfo->baseLevel = 0;
            spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_DONE_BONUS;
            break;
        // Stormstrike
        case 17364:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_STACK_FOR_DIFF_CASTERS;
            break;
        // Strength of Earth totem effect
        case 8076:
        case 8162:
        case 8163:
        case 10441:
        case 25362:
        case 25527:
        case 57621:
        case 58646:
            spellInfo->EffectRadiusIndex[1] = spellInfo->EffectRadiusIndex[0];
            spellInfo->EffectRadiusIndex[2] = spellInfo->EffectRadiusIndex[0];
            break;
        // Flametongue Totem effect
        case 52109:
        case 52110:
        case 52111:
        case 52112:
        case 52113:
        case 58651:
        case 58654:
        case 58655:
            spellInfo->EffectImplicitTargetB[2] = spellInfo->EffectImplicitTargetB[1] = spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->EffectImplicitTargetA[2] = spellInfo->EffectImplicitTargetA[1] = spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            break;
        // Sentry Totem
        case 6495:
            spellInfo->EffectRadiusIndex[0] = 0;
            break;
        // Bind Sight (PT)
        case 6277:
            spellInfo->AttributesEx &= ~SPELL_ATTR1_CHANNELED_1;
            spellInfo->Attributes |= SPELL_ATTR0_PASSIVE;
            spellInfo->AttributesEx7 |= SPELL_ATTR7_REACTIVATE_AT_RESURRECT; // because it is passive, needs this to be properly removed at death in RemoveAllAurasOnDeath()
            break;
        // Ancestral Awakening Heal
        case 52752:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_DONE_BONUS;
            break;
        case 32182: // Heroism
            spellInfo->excludeTargetAuraSpell = 57723; // Exhaustion
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            break;
        case 2825:  // Bloodlust
            spellInfo->excludeTargetAuraSpell = 57724; // Sated
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            break;

        /////////////////////////////////
        ///// WARLOCK
        /////////////////////////////////
        // Improved Succubus
        case 18754:
        case 18755:
        case 18756:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            break;
        // Unstable Affliction
        case 31117:
            spellInfo->PreventionType = SPELL_PREVENTION_TYPE_NONE;
            break;
        // Shadowflame - trigger
        case 47960: // r1
        case 61291: // r2
            spellInfo->AttributesEx |= SPELL_ATTR1_CANT_BE_REDIRECTED;
            break;
        // Curse of Doom - summoned doomguard duration fix
        case 18662:
            spellInfo->DurationIndex = 6;
            break;
        // Glyph of Voidwalker
        case 56247:
            spellInfo->EffectApplyAuraName[EFFECT_0] = SPELL_AURA_ADD_FLAT_MODIFIER;
            spellInfo->EffectMiscValue[EFFECT_0] = SPELLMOD_EFFECT1;
            spellInfo->EffectSpellClassMask[EFFECT_0] = flag96(0x8000000, 0, 0);
            break;
        // Everlasting Affliction
        case 47201:
        case 47202:
        case 47203:
        case 47204:
        case 47205:
            spellInfo->EffectSpellClassMask[1][0] |= 2; // add corruption to affected spells
            break;
        // Death's Embrace
        case 47198:
        case 47199:
        case 47200:
            spellInfo->EffectSpellClassMask[1][0] |= 0x4000; // include Drain Soul
            break;
        // Improved Demonic Tactics
        case 54347:
        case 54348:
        case 54349:
            spellInfo->Effect[EFFECT_1] = spellInfo->Effect[EFFECT_0];
            spellInfo->EffectApplyAuraName[EFFECT_1] = spellInfo->EffectApplyAuraName[EFFECT_0];
            spellInfo->EffectImplicitTargetA[EFFECT_1] = spellInfo->EffectImplicitTargetA[EFFECT_0];
            spellInfo->EffectMiscValue[EFFECT_0] = SPELLMOD_EFFECT1;
            spellInfo->EffectMiscValue[EFFECT_1] = SPELLMOD_EFFECT2;
            break;
        // Rain of Fire (Doomguard)
        case 42227:
            spellInfo->speed = 0.0f;
            break;
        // Ritual Enslavement
        case 22987:
            spellInfo->EffectApplyAuraName[EFFECT_0] = SPELL_AURA_MOD_CHARM;
            break;


        /////////////////////////////////
        ///// MAGE
        /////////////////////////////////
        // Combustion, make this passive
        case 11129:
            spellInfo->Dispel = DISPEL_NONE;
            break;
        // Magic Absorption (nigga stole my code)
        case 29441:
        case 29444:
            spellInfo->spellLevel = 0;
            break;
        // Living Bomb
        case 44461:
        case 55361:
        case 55362:
            spellInfo->AttributesEx3 |=  SPELL_ATTR3_NO_INITIAL_AGGRO;
            spellInfo->AttributesEx4 |= SPELL_ATTR4_DAMAGE_DOESNT_BREAK_AURAS;
            break;
        // Evocation
        case 12051:
            spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
            break;
        // MI Fireblast, WE Frostbolt, MI Frostbolt
        case 59637:
        case 31707:
        case 72898:
            spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
            break;
        // Blazing Speed
        case 31641:
        case 31642:
            spellInfo->EffectTriggerSpell[0] = 31643;
            break;
        // Summon Water Elemental (permanent), treat it as pet
        case 70908:
            spellInfo->Effect[0] = SPELL_EFFECT_SUMMON_PET;
            break;
        // Burnout, trigger
        case 44450:
            spellInfo->Effect[0] = SPELL_EFFECT_POWER_BURN;
            break;
        // Mirror Image - Summon Spells
        case 58831:
        case 58833:
        case 58834:
        case 65047:
            spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_DEST_CASTER;
            spellInfo->EffectRadiusIndex[EFFECT_0] = 0;
            break;
        // Initialize Images (Mirror Image)
        case 58836:
            spellInfo->EffectImplicitTargetA[EFFECT_1] = TARGET_UNIT_CASTER;
            break;
        // Arcane Blast, can't be dispelled
        case 36032:
            spellInfo->Attributes |= SPELL_ATTR0_UNAFFECTED_BY_INVULNERABILITY;
            break;
        // Chilled (frost armor, ice armor proc)
        case 6136:
        case 7321:
            spellInfo->PreventionType = SPELL_PREVENTION_TYPE_NONE;
            break;
        // Mirror Image Frostbolt
        case 59638:
            spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
            spellInfo->SpellFamilyName = SPELLFAMILY_MAGE;
            spellInfo->SpellFamilyFlags = flag96(0x20, 0x0, 0x0);
            break;
        // Fingers of Frost
        case 44544:
            spellInfo->Dispel = DISPEL_NONE;
            spellInfo->AttributesEx4 |= SPELL_ATTR4_NOT_STEALABLE;
            spellInfo->EffectSpellClassMask[0] = flag96(685904631, 1151040, 32); // xinef: removed molten armor
            break;
        // Fingers of Frost visual buff
        case 74396:
            spellInfo->procCharges = 2;
            spellInfo->StackAmount = 0;
            break;


        /////////////////////////////////
        ///// WARRIOR
        /////////////////////////////////
        // Glyph of blocking
        case 58375:
            spellInfo->EffectTriggerSpell[0] = 58374;
            break;
        // Sweeping Strikes stance change
        case 12328:
            spellInfo->Attributes |= SPELL_ATTR0_NOT_SHAPESHIFT;
            break;
        // Damage Shield
        case 59653:
            spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
            spellInfo->spellLevel = 0;
            break;
        // Strange shared cooldown
        case 20230: // Retaliation
        case 871: // Shield Wall
        case 1719: // Recklessness
            spellInfo->AttributesEx6 |= SPELL_ATTR6_IGNORE_CATEGORY_COOLDOWN_MODS;
            break;
        // Vigilance, fixes bug with empowered renew, single target aura
        case 50720:
            spellInfo->SpellFamilyName = SPELLFAMILY_WARRIOR;
            break;
        // Sunder Armor - trigger, remove spellfamilyflags because of glyph of sunder armor
        case 58567:
            spellInfo->SpellFamilyFlags = flag96(0x0, 0x0, 0x0);
            break;
        // Sunder Armor - Old Ranks
        case 7405:
        case 8380:
        case 11596:
        case 11597:
        case 25225:
        case 47467:
            spellInfo->EffectTriggerSpell[EFFECT_0] = 11971;
            spellInfo->Effect[EFFECT_0] = SPELL_EFFECT_TRIGGER_SPELL_WITH_VALUE;
            break;
        // Improved Spell Reflection
        case 59725:
            spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_UNIT_CASTER_AREA_PARTY;
            break;



        /////////////////////////////////
        ///// PRIEST
        /////////////////////////////////
        // Shadow Weaving
        case 15257:
        case 15331:
        case 15332:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PROC_TRIGGER_SPELL;
            break;
        // Hymn of Hope - rewrite part of aura system or swap effects...
        case 64904:
            spellInfo->EffectApplyAuraName[1] = SPELL_AURA_MOD_INCREASE_ENERGY_PERCENT;
            spellInfo->Effect[2] = spellInfo->Effect[0];
            spellInfo->Effect[0] = 0;
            spellInfo->EffectDieSides[2] = spellInfo->EffectDieSides[0];
            spellInfo->EffectImplicitTargetA[2] = spellInfo->EffectImplicitTargetB[0];
            spellInfo->EffectRadiusIndex[2] = spellInfo->EffectRadiusIndex[0];
            spellInfo->EffectBasePoints[2] = spellInfo->EffectBasePoints[0];
            break;
        // Divine Hymn
        case 64844:
            spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
            spellInfo->spellLevel = 0;
            break;
        // Spiritual Healing affects prayer of mending
        case 14898:     case 15349:     case 15354:     case 15355:     case 15356:
        // Divine Providence affects prayer of mending
        case 47562:     case 47564:     case 47565:     case 47566:     case 47567:
        // Twin Disciplines affects prayer of mending
        case 47586:     case 47587:     case 47588:     case 52802:     case 52803:
            spellInfo->EffectSpellClassMask[0][1] |= 0x20; // prayer of mending
            break;
        // Power Infusion, hack to fix stacking with arcane power
        case 10060:
            spellInfo->Effect[EFFECT_2] = SPELL_EFFECT_APPLY_AURA;
            spellInfo->EffectApplyAuraName[EFFECT_2] = SPELL_AURA_ADD_PCT_MODIFIER;
            spellInfo->EffectImplicitTargetA[EFFECT_2] = TARGET_UNIT_TARGET_ALLY;
            break;



        /////////////////////////////////
        ///// DRUID
        /////////////////////////////////
        // Lifebloom final bloom
        case 33778:
            spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
            spellInfo->spellLevel = 0;
            spellInfo->SpellFamilyFlags = flag96(0, 0x10, 0);
            break;
        // Clearcasting
        case 16870:
            spellInfo->DurationIndex = 31; // 8 secs
            break;
        // Owlkin Frenzy
        case 48391:
            spellInfo->Attributes |= SPELL_ATTR0_NOT_SHAPESHIFT;
            break;
        // Item T10 Restoration 4P Bonus
        case 70691:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_DONE_BONUS;
            break;
        // Faerie Fire, Faerie Fire (Feral)
        case 770:
        case 16857:
            spellInfo->AttributesEx &= ~SPELL_ATTR1_UNAFFECTED_BY_SCHOOL_IMMUNE;
            break;
        // Feral Charge - Cat
        case 49376:
        case 61138:
        case 61132:
        case 50259:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_INITIAL_AGGRO;
            break;
        // Glyph of Barkskin
        case 63058:
            spellInfo->EffectApplyAuraName[EFFECT_0] = SPELL_AURA_MOD_ATTACKER_MELEE_CRIT_CHANCE;
            break;


        /////////////////////////////////
        ///// MISC
        /////////////////////////////////
        // Resurrection Sickness
        case 15007:
            spellInfo->SpellFamilyName = SPELLFAMILY_GENERIC;
            break;
        // Luck of the Draw
        case 72221:
            spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CHANGE_MAP;
            break;
        case 3286:  // Bind
            spellInfo->Targets = 0; // neutral innkeepers not friendly?
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
            spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_TARGET_ANY;
            break;
        // remove creaturetargettype
        case 2641:
        case 23356:
            spellInfo->TargetCreatureType = 0;
            break;
        case 34074: // Aspect of the Viper
            spellInfo->Effect[2] = SPELL_EFFECT_APPLY_AURA;
            spellInfo->EffectImplicitTargetA[2] = 1;
            spellInfo->EffectApplyAuraName[2] = SPELL_AURA_DUMMY;
            break;
        // Strength of Wrynn
        case 60509:
            spellInfo->EffectBasePoints[2] = 1500;
            spellInfo->EffectBasePoints[1] = 150;
            spellInfo->EffectApplyAuraName[1] = SPELL_AURA_PERIODIC_HEAL;
            break;
        // Playback Speech
        case 74209:
            spellInfo->DurationIndex = 1;
            break;
        // Winterfin First Responder
        case 48739:
            spellInfo->EffectBasePoints[0] = 1;
            spellInfo->EffectRealPointsPerLevel[0] = 0;
            spellInfo->EffectDieSides[0] = 0;
            spellInfo->EffectDamageMultiplier[0] = 0;
            spellInfo->EffectBonusMultiplier[0] = 0;
            break;
        // Army of the Dead (trigger npc aura)
        case 49099:
            spellInfo->EffectAmplitude[0] = 15000;
            break;
        // Isle of Conquest - Teleport in, missing range
        case 66551:
            spellInfo->rangeIndex = 13; // 50000yd
            break;
        // A'dal's Song of Battle
        case 39953:
            spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_SRC_CASTER;
            spellInfo->EffectImplicitTargetA[EFFECT_1] = TARGET_SRC_CASTER;
            spellInfo->EffectImplicitTargetA[EFFECT_2] = TARGET_SRC_CASTER;
            spellInfo->EffectImplicitTargetB[EFFECT_0] = TARGET_UNIT_SRC_AREA_ALLY;
            spellInfo->EffectImplicitTargetB[EFFECT_1] = TARGET_UNIT_SRC_AREA_ALLY;
            spellInfo->EffectImplicitTargetB[EFFECT_2] = TARGET_UNIT_SRC_AREA_ALLY;
            spellInfo->DurationIndex = 367; // 2 Hours
            break;
        // Wintergrasp spells
        case 51422: // Cannon (Tower Cannon)
            spellInfo->EffectRadiusIndex[EFFECT_0] = 13; // 10yd
            break;
        case 57610: // Cannon (Siege Turret)
            spellInfo->EffectRadiusIndex[EFFECT_0] = 13; // 10yd
            break;
        case 50999: // Boulder (Demolisher)
            spellInfo->EffectRadiusIndex[EFFECT_0] = 13; // 10yd
            break;
        case 50990: // Flame Breath (Catapult)
            spellInfo->EffectRadiusIndex[EFFECT_0] = 19; // 18yd
            break;

        /////////////////////////////////
        ///// Generic NPC Spells
        /////////////////////////////////

        // Throw Proximity Bomb
        case 34095:
            spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_DEST_TARGET_ENEMY;
            spellInfo->EffectImplicitTargetB[EFFECT_0] = 0;
            break;
        // DEATH KNIGHT SCARLET FIRE ARROW
        case 53348:
        // BALISTA
        case 53117:
            spellInfo->RecoveryTime = 5000;
            spellInfo->CategoryRecoveryTime = 5000;
            break;
        // Teleport To Molten Core
        case 25139:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_DEATH_PERSISTENT;
            break;


        // ///////////////////////////////////////////
        // ////////////////BOSS SPELLS////////////////
        // ///////////////////////////////////////////
        //////////////////////////////////////////
        ////////// Vanilla Instances
        //////////////////////////////////////////

        // Shadowfang Keep
        // Landen Stilwell Transform
        case 31310:
            spellInfo->Attributes |= SPELL_ATTR0_PASSIVE;
            break;

        // Blackfathom Deeps
        // Shadowstalker Stealth
        case 5916:
            spellInfo->EffectRealPointsPerLevel[EFFECT_0] = 5.0f;
            break;

        // Maraudon
        // Sneak
        case 22766:
            spellInfo->EffectRealPointsPerLevel[EFFECT_0] = 5.0f;
            break;


        //////////////////////////////////////////
        ////////// TBC Instances
        //////////////////////////////////////////

        // Shadow Labirynth
        // Murmur's Touch
        case 38794:
        case 33711:
            spellInfo->MaxAffectedTargets = 1;
            spellInfo->EffectTriggerSpell[0] = 33760;
            break;

        // The Arcatraz
        // Negaton Field
        case 36729: // Normal
        case 38834: // Heroic
            spellInfo->AttributesEx3 |= SPELL_ATTR3_STACK_FOR_DIFF_CASTERS;
            break;
        // Curse of the Doomsayer NORMAL
        case 36173:
            spellInfo->EffectTriggerSpell[0] = 36174; // Currently triggers heroic version...
            break;

        // The Botanica
        // Crystal Channel
        case 34156:
            spellInfo->rangeIndex = 35; // 35yd;
            spellInfo->ChannelInterruptFlags |= AURA_INTERRUPT_FLAG_MOVE;
            break;

        // Magtheridon's Lair
        // Debris
        case 36449:
            spellInfo->Attributes |= SPELL_ATTR0_NEGATIVE_1;
            break;
        // Soul Channel
        case 30531:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_STACK_FOR_DIFF_CASTERS;
            break;
        // Debris Visual
        case 30632:
            spellInfo->EffectImplicitTargetB[0] = TARGET_DEST_DYNOBJ_ALLY;
            break;

        // Sunwell Plateu
        // Activate Sunblade Protecto
        case 46475:
        case 46476:
            spellInfo->rangeIndex = 14; // 60yd
            break;
        // Break Ice
        case 46638:
            spellInfo->AttributesEx3 &= ~SPELL_ATTR3_ONLY_TARGET_PLAYERS; // Obvious fail, it targets gameobject...
            break;
        // Sinister Reflection Clone
        case 45785:
            spellInfo->speed = 0.0f;
            break;
        // Armageddon
        case 45909:
            spellInfo->speed = 8.0f;
            break;

        // Black Temple
        // Spell Absorption
        case 41034:
            spellInfo->Effect[EFFECT_2] = SPELL_EFFECT_APPLY_AURA;
            spellInfo->EffectApplyAuraName[EFFECT_2] = SPELL_AURA_SCHOOL_ABSORB;
            spellInfo->EffectImplicitTargetA[EFFECT_2] = TARGET_UNIT_CASTER;
            spellInfo->EffectMiscValue[EFFECT_2] = SPELL_SCHOOL_MASK_MAGIC;
            break;
        // Shared Bonds
        case 41363:
            spellInfo->AttributesEx &= ~SPELL_ATTR1_CHANNELED_1;
            break;
        // Deadly Poison
        case 41485:
        // Envenom
        case 41487:
            spellInfo->AttributesEx6 |= SPELL_ATTR6_CAN_TARGET_INVISIBLE;
            break;
        // Parasitic Shadowfiend
        case 41914:
            spellInfo->Attributes |= SPELL_ATTR0_NEGATIVE_1;
            spellInfo->AttributesEx3 |= SPELL_ATTR3_STACK_FOR_DIFF_CASTERS;
            break;
        // Teleport Maiev
        case 41221:
            spellInfo->rangeIndex = 13; // 0-50000yd
            break;

        // Serpentshrine Cavern
        // Watery Grave Explosion
        case 37852:
            spellInfo->AttributesEx5 |= SPELL_ATTR5_USABLE_WHILE_STUNNED;
            break;

        // Magisters' Terrace
        // Energy Feedback
        case 44335:
            spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CHANGE_MAP;
            break;



        //////////////////////////////////////////
        ////////// Vault of Archavon (VOA)
        //////////////////////////////////////////
        // Flame Breath, catapult spell
        case 50989:
            spellInfo->Attributes &= ~SPELL_ATTR0_LEVEL_DAMAGE_CALCULATION;
            break;
        // Koralon, Flaming Cinder missing radius index
        case 66690:
            spellInfo->EffectRadiusIndex[0] = 12; //100yd
            spellInfo->MaxAffectedTargets = 1;
            break;

        //////////////////////////////////////////
        ////////// Naxxramas
        //////////////////////////////////////////
        // Acid Volley
        case 54714:
        case 29325:
            spellInfo->MaxAffectedTargets = 1;
            break;
        // Summon Plagued Warrior
        case 29237:
            spellInfo->Effect[0] = SPELL_EFFECT_DUMMY;
            spellInfo->Effect[1] = spellInfo->Effect[2] = 0;
            break;
        // Icebolt
        case 28526:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
            break;
        // Infected Wound
        case 29306:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_STACK_FOR_DIFF_CASTERS;
            break;
        // Hopeless
        case 29125:
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENTRY;
            break;

        //////////////////////////////////////////
        ////////// Gundrak
        //////////////////////////////////////////
        // Moorabi - Transformation
        case 55098:
            spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
            break;

        //////////////////////////////////////////
        ////////// The Nexus: Nexus
        //////////////////////////////////////////
        // Charged Chaotic rift aura, trigger
        case 47737:
            spellInfo->rangeIndex = 37; // 50yd
            break;

        //////////////////////////////////////////
        ////////// AHN'KAHET: THE OLD KINGDOM
        //////////////////////////////////////////
        // Vanish
        case 55964:
            spellInfo->Effect[1] = 0;
            spellInfo->Effect[2] = 0;
            break;

        //////////////////////////////////////////
        ////////// DRAK'THARON KEEP
        //////////////////////////////////////////
        // Trollgore - Summon Drakkari Invader
        case 49456:
        case 49457:
        case 49458:
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DB;
            break;

        //////////////////////////////////////////
        ////////// UTGARDE PINNACLE
        //////////////////////////////////////////
        // Paralyse
        case 48278:
        // Awaken subboss
        case 47669:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
            spellInfo->EffectImplicitTargetB[0] = 0;
            break;
        // Flame Breath
        case 47592:
            spellInfo->EffectAmplitude[0] = 200;
            break;

        //////////////////////////////////////////
        ////////// UTGARDE KEEP
        //////////////////////////////////////////
        // Skarvald, Charge
        case 43651:
            spellInfo->rangeIndex = 13; // 0-50000yd
            break;
        // Ingvar the Plunderer, Woe Strike
        case 42730:
            spellInfo->EffectTriggerSpell[1] = 42739;
            break;
        case 59735:
            spellInfo->EffectTriggerSpell[1] = 59736;
            break;
        // Ingvar the Plunderer, Ingvar transform
        case 42796:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_DEATH_PERSISTENT;
            break;

        //////////////////////////////////////////
        ////////// VIOLET HOLD
        //////////////////////////////////////////
        // Control Crystal Activation
        case 57804:
            spellInfo->EffectImplicitTargetA[0] = 1;
            spellInfo->EffectImplicitTargetB[0] = 0;
            break;
        // Destroy Door Seal
        case 58040:
            spellInfo->ChannelInterruptFlags &= ~(AURA_INTERRUPT_FLAG_HITBYSPELL | AURA_INTERRUPT_FLAG_TAKE_DAMAGE);
            break;
        // Ichoron, Water Blast
        case 54237:
        case 59520:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_HIT_RESULT;
            break;

        //////////////////////////////////////////
        ////////// AZJOL'NERUB
        //////////////////////////////////////////

        // Krik'thir - Mind Flay
        case 52586:
        case 59367:
            spellInfo->ChannelInterruptFlags |= AURA_INTERRUPT_FLAG_MOVE;
            break;

        //////////////////////////////////////////
        ////////// HALLS OF STONE
        //////////////////////////////////////////
        // Glare of the Tribunal
        case 50988:
        case 59870:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
            spellInfo->EffectImplicitTargetB[0] = 0;
            break;
        // Static Charge
        case 50835:
        case 59847:
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ALLY;
            break;

        //////////////////////////////////////////
        ////////// OBSIDIAN SANCTUM
        //////////////////////////////////////////
        // Lava Strike damage
        case 57697:
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            break;
        // Lava Strike trigger
        case 57578:
            spellInfo->MaxAffectedTargets = 1;
            break;
        // Gift of Twilight Shadow/Fire
        case 57835:
        case 58766:
            spellInfo->AttributesEx &= ~SPELL_ATTR1_CHANNELED_1;
            break;
        // Pyrobuffet
        case 57557:
            spellInfo->excludeTargetAuraSpell = 56911;
            break;

        //////////////////////////////////////////
        ////////// EYE OF ETERNITY
        //////////////////////////////////////////
        // Arcane Barrage
        case 56397:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ENEMY;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_TARGET_ENEMY;
            spellInfo->EffectImplicitTargetB[1] = 0;
            spellInfo->EffectImplicitTargetA[2] = TARGET_UNIT_TARGET_ENEMY;
            spellInfo->EffectImplicitTargetB[2] = 0;
            break;
        // Power Spark (ground +50% dmg aura)
        case 55849:
        // Arcane Overload (-50% dmg taken) - this is to prevent apply -> unapply -> apply ... dunno whether it's correct
        case 56438:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_STACK_FOR_DIFF_CASTERS;
            break;
        // Vortex (Control Vehicle)
        case 56263:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_HIT_RESULT;
            break;
        // Haste (Nexus Lord, increase run speed of the disk)
        case 57060:
            spellInfo->EffectImplicitTargetA[2] = TARGET_UNIT_VEHICLE;
            break;
        // Arcane Overload
        case 56430:
            spellInfo->Effect[0] = SPELL_EFFECT_TRIGGER_MISSILE;
            spellInfo->EffectTriggerSpell[0] = 56429;
            // no break intended
        case 56429:
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->EffectImplicitTargetA[1] = 0;
            spellInfo->EffectImplicitTargetB[1] = 0;
            spellInfo->EffectImplicitTargetA[2] = 0;
            spellInfo->EffectImplicitTargetB[2] = 0;
            break;
        // Destroy Platform Event
        case 59099:
            spellInfo->EffectImplicitTargetA[1] = 22;
            spellInfo->EffectImplicitTargetB[1] = 15;
            spellInfo->EffectImplicitTargetA[2] = 22;
            spellInfo->EffectImplicitTargetB[2] = 15;
            break;
        // Surge of Power (Phase 3)
        case 57407: // N
        case 60936: // H
            spellInfo->MaxAffectedTargets = (i == 60936 ? 3 : 1);
            spellInfo->InterruptFlags = 0;
            spellInfo->EffectRadiusIndex[0] = 28;
            spellInfo->AttributesEx4 |= SPELL_ATTR4_CAN_CAST_WHILE_CASTING;
            spellInfo->EffectImplicitTargetA[0] = TARGET_SRC_CASTER;
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENEMY;
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            break;
        // Wyrmrest Drake - Life Burst
        case 57143:
            spellInfo->Effect[0] = 0;
            spellInfo->EffectImplicitTargetA[0] = 0;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->EffectImplicitTargetA[1] = TARGET_SRC_CASTER;
            spellInfo->EffectImplicitTargetB[1] = TARGET_UNIT_SRC_AREA_ALLY;
            spellInfo->EffectPointsPerComboPoint[1] = 2500;
            spellInfo->EffectBasePoints[1] = 2499;
            spellInfo->rangeIndex = 1;
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            break;
        //Alexstrasza - Gift
        case 61028:
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            break;
        // Vortex (freeze anim)
        case 55883:
            spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CHANGE_MAP;
            break;

        //////////////////////////////////////////
        ////////// ULDUAR
        //////////////////////////////////////////
        // Flame Leviathan
        // Hurl Pyrite
        case 62490:
            spellInfo->Effect[EFFECT_1] = 0;
            break;

        // Ulduar, Mimiron, Magnetic Core (summon)
        case 64444:
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_CASTER;
            break;
        // Ulduar, Mimiron, bomb bot explosion
        case 63801:
            spellInfo->EffectMiscValue[1] = 17286;
            break;
        // Ulduar, Mimiron, Summon Flames Initial
        case 64563:
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_HIT_RESULT;
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            spellInfo->EffectImplicitTargetB[0] = 0;
            break;
        // Ulduar, Mimiron, Flames (damage)
        case 64566:
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            spellInfo->AttributesEx4 &= ~SPELL_ATTR4_IGNORE_RESISTANCES;
            break;

        // Ulduar, Hodir, Starlight
        case 62807:
            spellInfo->EffectRadiusIndex[0] = 16; // 1yd
            break;

        // Ulduar, General Vezax, Mark of the Faceless
        case 63278:
            spellInfo->Effect[0] = 0;
            break;

        // XT-002 DECONSTRUCTOR
        case 62834: // Boom (XT-002)
            spellInfo->Effect[EFFECT_1] = 0;
            break;

        // ASSEMBLY OF IRON
        // Supercharge
        case 61920:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_STACK_FOR_DIFF_CASTERS;
            break;
        // Lightning Whirl
        case 61916:
            spellInfo->MaxAffectedTargets = 3;
            break;
        case 63482:
            spellInfo->MaxAffectedTargets = 8;
            break;

        // KOLOGARN
        // Stone Grip, remove absorb aura
        case 62056:
        case 63985:
            spellInfo->Effect[1] = 0;
            break;

        // AURIAYA
        // Sentinel Blast
        case 64389:
        case 64678:
            spellInfo->Dispel = DISPEL_MAGIC;
            break;

        // FREYA
        // Potent Pheromones
        case 62619:
            spellInfo->AttributesEx |= SPELL_ATTR1_DISPEL_AURAS_ON_IMMUNITY;
            break;
        // Healthy spore summon periodic
        case 62566:
            spellInfo->EffectAmplitude[0] = 2000;
            spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_TRIGGER_SPELL;
            break;
        // Brightleaf Essence trigger
        case 62968:
            spellInfo->Effect[1] = 0; // duplicate
            break;
        // Potent Pheromones
        case 64321:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_ONLY_TARGET_PLAYERS;
            spellInfo->AttributesEx |= SPELL_ATTR1_DISPEL_AURAS_ON_IMMUNITY;
            break;

        // THORIM
        // charge obr stuff
        case 62186:
            spellInfo->EffectAmplitude[0] = 5000; // Duration 5 secs, amplitude 8 secs...
            break;
        // Charge Orb P2
        case 62976:
            spellInfo->rangeIndex = 6;
            spellInfo->DurationIndex = 28;
            break;
        // Sif's Blizzard
        case 62576:
        case 62602:
            spellInfo->EffectRadiusIndex[0] = 14; // 8yd
            spellInfo->EffectRadiusIndex[1] = 14; // 8yd
            break;

        // YOGG-SARON
        // Protective Gaze
        case 64175:
            spellInfo->RecoveryTime = 25000;
            break;
        // Shadow Beacon
        case 64465:
            spellInfo->EffectTriggerSpell[0] = 64467; // why do they need two script effects :/ (this one has visual effect)
            break;
        // Sanity
        case 63050:
            spellInfo->AttributesEx6 |= SPELL_ATTR6_CAN_TARGET_INVISIBLE;
            break;
        // Shadow Nova
        case 62714:
        case 65209:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_HIT_RESULT;
            break;

        // ALGALON
         // Cosmic Smash (Algalon the Observer)
        case 62293:
            spellInfo->EffectImplicitTargetB[0] = TARGET_DEST_CASTER;
            break;
        // Cosmic Smash (Algalon the Observer)
        case 62311:
        case 64596:
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            spellInfo->EffectRadiusIndex[0] = 12; // 100yd
            spellInfo->rangeIndex = 13;  // 50000yd
            break;
        // Constellation Phase Effect
        case 65509:
            spellInfo->MaxAffectedTargets = 1;
            break;
        // Black Hole
        case 62168:
        case 65250:
        case 62169:
            spellInfo->Attributes |= SPELL_ATTR0_NEGATIVE_1;
            break;

        // TRASH
        // Ground Slam
        case 62625:
            spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
            break;

        //////////////////////////////////////////
        ////////// ONYXIA'S LAIR
        //////////////////////////////////////////
        // Onyxia's Lair, Onyxia, Flame Breath (TriggerSpell = 0 and spamming errors in console)
        case 18435:
            spellInfo->Effect[1] = 0;
            break;
        // Onyxia's Lair, Onyxia, Create Onyxia Spawner
        case 17647:
            spellInfo->DurationIndex = 37;
            break;
        // Onyxia's Lair, Onyxia, Summon Onyxia Whelp
        case 17646:
        // Onyxia's Lair, Onyxia, Summon Lair Guard
        case 68968:
            spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            spellInfo->rangeIndex = 13;
            spellInfo->DurationIndex = 5;
            break;
        // Onyxia's Lair, Onyxia, Eruption:
        case 17731:
        case 69294:
            spellInfo->Effect[1] = SPELL_EFFECT_DUMMY;
            spellInfo->CastingTimeIndex = 3;
            spellInfo->EffectRadiusIndex[1] = 19; // 18yd instead of 13yd to make sure all cracks erupt
            break;
        // Onyxia's Lair, Onyxia, Breath:
        // TODO: fix it by IconId / SpellVisual
        case 18576: case 18578: case 18579: case 18580:
        case 18581: case 18582: case 18583: case 18609: case 18611: case 18612: case 18613: case 18614:
        case 18615: case 18616: case 18584: case 18585: case 18586: case 18587: case 18588: case 18589:
        case 18590: case 18591: case 18592: case 18593: case 18594: case 18595: case 18564: case 18565:
        case 18566: case 18567: case 18568: case 18569: case 18570: case 18571: case 18572: case 18573:
        case 18574: case 18575: case 18596: case 18597: case 18598: case 18599: case 18600: case 18601:
        case 18602: case 18603: case 18604: case 18605: case 18606: case 18607: case 18617: case 18619:
        case 18620: case 18621: case 18622: case 18623: case 18624: case 18625: case 18626: case 18627:
        case 18628: case 18618: case 18351: case 18352: case 18353: case 18354: case 18355: case 18356:
        case 18357: case 18358: case 18359: case 18360: case 18361: case 17086: case 17087: case 17088:
        case 17089: case 17090: case 17091: case 17092: case 17093: case 17094: case 17095: case 17097:
        case 22267: case 22268: case 21132: case 21133: case 21135: case 21136: case 21137: case 21138:
        case 21139:
            spellInfo->DurationIndex = 328; // 250ms
            spellInfo->EffectImplicitTargetA[1] = 1;
            if( spellInfo->Effect[1] )
            {
                spellInfo->Effect[1] = SPELL_EFFECT_APPLY_AURA;
                spellInfo->EffectApplyAuraName[1] = SPELL_AURA_PERIODIC_TRIGGER_SPELL;
                spellInfo->EffectAmplitude[1] = ((spellInfo->CastingTimeIndex == 170) ? 50 : 215);
            }
            break;

        //////////////////////////////////////////
        ////////// THE NEXUS: OCULUS
        //////////////////////////////////////////
        // Oculus, Teleport to Coldarra DND
        case 48760:
        // Oculus, Teleport to Boss 1 DND
        case 49305:
            spellInfo->EffectImplicitTargetA[0] = 25;
            spellInfo->EffectImplicitTargetB[0] = 17;
            break;
        // Oculus, Drake spell Stop Time
        case 49838:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_INITIAL_AGGRO;
            spellInfo->excludeTargetAuraSpell = 51162; // exclude planar shift
            spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_150_YARDS;
            break;
        // Oculus, Varos Cloudstrider, Energize Cores
        case 61407:
        case 62136:
        case 56251:
        case 54069:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CONE_ENTRY;
            spellInfo->EffectImplicitTargetB[0] = 0;
            break;

        //////////////////////////////////////////
        ////////// HALLS OF LIGHTNING
        //////////////////////////////////////////
        // Halls of Lightning, Arc Weld
        case 59086:
            spellInfo->EffectImplicitTargetA[0] = 1;
            break;
        // Halls of Lightning, Arcing Burn
        case 52671:
        case 59834:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_STACK_FOR_DIFF_CASTERS;
            break;

        //////////////////////////////////////////
        ////////// TRIAL OF THE CHAMPION
        //////////////////////////////////////////
        // Trial of the Champion, Death's Respite
        case 68306:
            spellInfo->EffectImplicitTargetA[0] = 25;
            spellInfo->EffectImplicitTargetA[1] = 25;
            break;
        // Trial of the Champion, Eadric Achievement (The Faceroller)
        case 68197:
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ALLY;
            spellInfo->Attributes |= SPELL_ATTR0_CASTABLE_WHILE_DEAD;
            break;
        // Trial of the Champion, Earth Shield
        case 67530:
            spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PROC_TRIGGER_SPELL; // will trigger 67537
            break;
        // Trial of the Champion, Hammer of the Righteous
        case 66867:
            spellInfo->Effect[0] = SPELL_EFFECT_DUMMY;
            break;
        // Trial of the Champion, Summon Risen Jaeren/Arelas
        case 67705:
        case 67715:
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_DEAD;
            break;
        // Trial of the Champion, Ghoul Explode
        case 67751:
            spellInfo->EffectImplicitTargetA[0] = TARGET_SRC_CASTER;
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENTRY;
            spellInfo->EffectRadiusIndex[0] = 12;
            spellInfo->EffectImplicitTargetA[1] = TARGET_SRC_CASTER;
            spellInfo->EffectImplicitTargetB[1] = TARGET_UNIT_SRC_AREA_ENTRY;
            spellInfo->EffectRadiusIndex[1] = 12;
            spellInfo->EffectImplicitTargetA[2] = TARGET_SRC_CASTER;
            spellInfo->EffectImplicitTargetB[2] = TARGET_UNIT_SRC_AREA_ENTRY;
            spellInfo->EffectRadiusIndex[2] = 12;
            break;
        // Trial of the Champion, Desecration
        case 67778:
        case 67877:
            spellInfo->EffectTriggerSpell[0] = 68766;
            break;

        //////////////////////////////////////////
        ////////// TRIAL OF THE CRUSADER
        //////////////////////////////////////////
        // Trial of the Crusader, Jaraxxus Intro spell
        case 67888:
            spellInfo->Attributes |= SPELL_ATTR0_STOP_ATTACK_TARGET;
            spellInfo->AttributesEx |= SPELL_ATTR1_NO_THREAT;
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_INITIAL_AGGRO;
            break;
        // Trial of the Crusader, Lich King Intro spell
        case 68193:
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENEMY;
            break;
        // Trial of the Crusader, Gormok, player vehicle spell, CUSTOM! (default jump to hand, not used)
        case 66342:
            spellInfo->Effect[0] = SPELL_EFFECT_APPLY_AURA;
            spellInfo->EffectApplyAuraName[0] = SPELL_AURA_SET_VEHICLE_ID;
            spellInfo->EffectMiscValue[0] = 496;
            spellInfo->DurationIndex = 21;
            spellInfo->rangeIndex = 13;
            spellInfo->EffectImplicitTargetA[0] = 25;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->AuraInterruptFlags = AURA_INTERRUPT_FLAG_CHANGE_MAP;
            break;
        // Trial of the Crusader, Gormok, Fire Bomb
        case 66313:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
            spellInfo->EffectImplicitTargetB[0] = TARGET_DEST_TARGET_ANY;
            spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_TARGET_ANY;
            spellInfo->EffectImplicitTargetB[1] = TARGET_DEST_TARGET_ANY;
            spellInfo->Effect[1] = 0;
            // no break intended
        case 66317:
            spellInfo->Attributes |= SPELL_ATTR0_STOP_ATTACK_TARGET;
            spellInfo->AttributesEx |= SPELL_ATTR1_NO_THREAT;
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_INITIAL_AGGRO;
            break;
        case 66318:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->speed = 14.0f;
            spellInfo->Attributes |= SPELL_ATTR0_STOP_ATTACK_TARGET;
            spellInfo->AttributesEx |= SPELL_ATTR1_NO_THREAT;
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_INITIAL_AGGRO;
            break;
        case 66320:
        case 67472:
        case 67473:
        case 67475:
            spellInfo->EffectRadiusIndex[0] = 7;
            spellInfo->EffectRadiusIndex[1] = 7;
            break;
        // Trial of the Crusader, Acidmaw & Dreadscale, Emerge
        case 66947:
            spellInfo->AttributesEx5 |= SPELL_ATTR5_USABLE_WHILE_STUNNED;
            break;
        // Trial of the Crusader, Jaraxxus, Curse of the Nether
        case 66211:
            spellInfo->excludeTargetAuraSpell = 66209; // exclude Touch of Jaraxxus
            break;
        // Trial of the Crusader, Jaraxxus, Summon Volcano
        case 66258:
        case 67901:
            spellInfo->DurationIndex = 85; // summon for 18 seconds, 15 not enough
            break;
        // Trial of the Crusader, Jaraxxus, Spinning Pain Spike
        case 66281:
            spellInfo->EffectRadiusIndex[0] = 26;
            break;
        case 66287:
            spellInfo->Effect[1] = SPELL_EFFECT_APPLY_AURA;
            spellInfo->EffectApplyAuraName[1] = SPELL_AURA_MOD_TAUNT;
            spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_NEARBY_ENTRY;
            spellInfo->Effect[2] = SPELL_EFFECT_APPLY_AURA;
            spellInfo->EffectApplyAuraName[2] = SPELL_AURA_MOD_STUN;
            spellInfo->EffectImplicitTargetA[2] = TARGET_UNIT_CASTER;
            spellInfo->DurationIndex = 35; // 4 secs
            break;
        // Trial of the Crusader, Jaraxxus, Fel Fireball
        case 66532:
        case 66963:
        case 66964:
        case 66965:
            spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
            break;
        // tempfix, make Nether Power not stealable
        case 66228:
        case 67106:
        case 67107:
        case 67108:
            spellInfo->AttributesEx4 |= SPELL_ATTR4_NOT_STEALABLE;
            break;
        // Trial of the Crusader, Faction Champions, Druid - Tranquality
        case 66086:
        case 67974:
        case 67975:
        case 67976:
            spellInfo->Effect[0] = SPELL_EFFECT_APPLY_AREA_AURA_FRIEND;
            break;
        // Trial of the Crusader, Faction Champions, Shaman - Earth Shield
        case 66063:
            spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PROC_TRIGGER_SPELL;
            spellInfo->EffectTriggerSpell[0] = 66064;
            break;
        // Trial of the Crusader, Faction Champions, Priest - Mana Burn
        case 66100:
            spellInfo->EffectBasePoints[0] = 5;
            spellInfo->EffectDieSides[0] = 0;
            break;
        case 68026:
            spellInfo->EffectBasePoints[0] = 8;
            spellInfo->EffectDieSides[0] = 0;
            break;
        case 68027:
            spellInfo->EffectBasePoints[0] = 6;
            spellInfo->EffectDieSides[0] = 0;
            break;
        case 68028:
            spellInfo->EffectBasePoints[0] = 10;
            spellInfo->EffectDieSides[0] = 0;
            break;

        // Trial of the Crusader, Twin Valkyr, Touch of Light/Darkness, Light/Dark Surge
        case 65950: // light 0
            //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
            spellInfo->EffectImplicitTargetA[0] = 6;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->Effect[1] = 0; spellInfo->Effect[2] = 0;
        case 65767: // light surge 0
            spellInfo->excludeTargetAuraSpell = 65686;
            break;
        case 67296: // light 1
            //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
            spellInfo->EffectImplicitTargetA[0] = 6;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->Effect[1] = 0; spellInfo->Effect[2] = 0;
        case 67274: // light surge 1
            spellInfo->excludeTargetAuraSpell = 67222;
            break;
        case 67297: // light 2
            //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
            spellInfo->EffectImplicitTargetA[0] = 6;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->Effect[1] = 0; spellInfo->Effect[2] = 0;
        case 67275: // light surge 2
            spellInfo->excludeTargetAuraSpell = 67223;
            break;
        case 67298: // light 3
            //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
            spellInfo->EffectImplicitTargetA[0] = 6;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->Effect[1] = 0; spellInfo->Effect[2] = 0;
        case 67276: // light surge 3
            spellInfo->excludeTargetAuraSpell = 67224;
            break;
        case 66001: // dark 0
            //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
            spellInfo->EffectImplicitTargetA[0] = 6;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->Effect[1] = 0; spellInfo->Effect[2] = 0;
        case 65769: // dark surge 0
            spellInfo->excludeTargetAuraSpell = 65684;
            break;
        case 67281: // dark 1
            //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
            spellInfo->EffectImplicitTargetA[0] = 6;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->Effect[1] = 0; spellInfo->Effect[2] = 0;
        case 67265: // dark surge 1
            spellInfo->excludeTargetAuraSpell = 67176;
            break;
        case 67282: // dark 2
            //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
            spellInfo->EffectImplicitTargetA[0] = 6;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->Effect[1] = 0; spellInfo->Effect[2] = 0;
        case 67266: // dark surge 2
            spellInfo->excludeTargetAuraSpell = 67177;
            break;
        case 67283: // dark 3
            //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
            spellInfo->EffectImplicitTargetA[0] = 6;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->Effect[1] = 0; spellInfo->Effect[2] = 0;
        case 67267: // dark surge 3
            spellInfo->excludeTargetAuraSpell = 67178;
            break;

        // Trial of the Crusader, Twin Valkyr, Twin's Pact
        case 65875: case 67303: case 67304: case 67305: case 65876: case 67306: case 67307: case 67308:
            spellInfo->Effect[1] = 0; spellInfo->Effect[2] = 0;
            break;
        // Trial of the Crusader, Anub'arak, Emerge
        case 65982:
            spellInfo->AttributesEx5 |= SPELL_ATTR5_USABLE_WHILE_STUNNED;
            break;
        // Trial of the Crusader, Anub'arak, Penetrating Cold
        case 66013:
        case 67700:
        case 68509:
        case 68510:
            spellInfo->EffectRadiusIndex[0] = 12; // 100yd
            break;
        // Trial of the Crusader, Anub'arak, Shadow Strike
        case 66134:
            spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
            spellInfo->Effect[0] = 0;
            break;
        // Trial of the Crusader, Anub'arak, Pursuing Spikes
        case 65920:
        case 65922:
        case 65923:
            spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
            //spellInfo->EffectTriggerSpell[0] = 0;
            break;
        // Trial of the Crusader, Anub'arak, Summon Scarab
        case 66339:
            spellInfo->DurationIndex = 35;
            spellInfo->EffectImplicitTargetA[0] = 25;
            spellInfo->EffectImplicitTargetB[0] = 0;
            break;
        // Trial of the Crusader, Anub'arak, Achievements: The Traitor King
        case 68186: // Anub'arak Scarab Achievement 10
        case 68515: // Anub'arak Scarab Achievement 25
            spellInfo->EffectImplicitTargetA[0] = TARGET_SRC_CASTER;
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENEMY;
            spellInfo->Attributes |= SPELL_ATTR0_CASTABLE_WHILE_DEAD;
            break;
        // Trial of the Crusader, Anub'arak, Spider Frenzy
        case 66129:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_STACK_FOR_DIFF_CASTERS;
            break;

        //////////////////////////////////////////
        ////////// THE FORGE OF SOULS
        //////////////////////////////////////////
        // Soul Sickness (69131)
        case 69131:
            spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_TRIGGER_SPELL;
            spellInfo->EffectAmplitude[0] = 8000;
            spellInfo->EffectTriggerSpell[0] = 69133;
            break;
        // Phantom Blast (68982,70322)
        case 68982:
        case 70322:
            spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
            break;

        //////////////////////////////////////////
        ////////// PIT OF SARON
        //////////////////////////////////////////
        // Empowered Blizzard
        case 70131:
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            break;
        // Ice Lance Volley
        case 70464:
            spellInfo->EffectImplicitTargetA[0] = TARGET_SRC_CASTER;
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENTRY;
            spellInfo->EffectRadiusIndex[0] = 25;
            break;
        // Multi-Shot
        case 70513:
        // Shriek of the Highborne
        case 59514:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CONE_ENTRY;
            spellInfo->EffectImplicitTargetB[0] = 0;
            break;
        // Icicle
        case 69428:
        case 69426:
            spellInfo->InterruptFlags = 0;
            spellInfo->AuraInterruptFlags = 0;
            spellInfo->ChannelInterruptFlags = 0;
            break;
        // Jaina's Call
        case 70525:
        // Call of Sylvanas
        case 70639:
            spellInfo->Effect[0] = 0;
            spellInfo->Effect[1] = 0;
            spellInfo->EffectImplicitTargetA[2] = TARGET_SRC_CASTER;
            spellInfo->EffectImplicitTargetB[2] = TARGET_UNIT_SRC_AREA_ENTRY;
            spellInfo->EffectRadiusIndex[2] = 30; // 500yd
            break;
        // Frost Nova
        case 68198:
            spellInfo->rangeIndex = 13;
            spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
            break;
        // Blight
        case 69604:
        case 70286:
            spellInfo->MaxAffectedTargets = 1;
            spellInfo->AttributesEx3 |= (SPELL_ATTR3_IGNORE_HIT_RESULT | SPELL_ATTR3_ONLY_TARGET_PLAYERS);
            break;
        // Chilling Wave
        case 68778:
        case 70333:
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_TARGET_ENEMY;
            spellInfo->EffectImplicitTargetB[0] = 0;
            break;
        // Permafrost
        case 68786:
        case 70336:
            spellInfo->AttributesEx3 |= (SPELL_ATTR3_IGNORE_HIT_RESULT | SPELL_ATTR3_ONLY_TARGET_PLAYERS);
            spellInfo->Effect[2] = SPELL_EFFECT_DUMMY;
            break;
        // Pursuit:
        case 68987:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_TARGET_ANY;
            spellInfo->EffectImplicitTargetB[1] = 0;
            spellInfo->EffectImplicitTargetA[2] = TARGET_UNIT_CASTER;
            spellInfo->EffectImplicitTargetB[2] = 0;
            spellInfo->rangeIndex = 6; // 100yd
            spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_HIT_RESULT;
            break;
        case 69029:
        case 70850:
            spellInfo->Effect[2] = 0;
            break;
        // Explosive Barrage:
        case 69263:
            spellInfo->EffectApplyAuraName[0] = SPELL_AURA_MOD_STUN;
            break;
        // Overlord's Brand:
        case 69172:
            spellInfo->procFlags = DONE_HIT_PROC_FLAG_MASK & ~PROC_FLAG_DONE_PERIODIC;
            spellInfo->procChance = 100;
            break;
        // Icy Blast:
        case 69232:
            spellInfo->EffectTriggerSpell[1] = 69238;
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            break;
        case 69233:
        case 69646:
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            break;
        case 69238:
        case 69628:
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            spellInfo->EffectImplicitTargetB[0] = TARGET_DEST_DYNOBJ_NONE;
            spellInfo->EffectImplicitTargetA[1] = TARGET_DEST_DEST;
            spellInfo->EffectImplicitTargetB[1] = TARGET_DEST_DYNOBJ_NONE;
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            break;
        // Hoarfrost:
        case 69246:
        case 69245:
        case 69645:
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            break;
        // Devour Humanoid:
        case 69503:
            spellInfo->ChannelInterruptFlags |= 0;
            spellInfo->AuraInterruptFlags = AURA_INTERRUPT_FLAG_MOVE | AURA_INTERRUPT_FLAG_TURNING;
            break;

        //////////////////////////////////////////
        ////////// HALLS OF REFLECTION
        //////////////////////////////////////////
        // Falric: Defiling Horror
        case 72435:
        case 72452:
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;
            spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_200_YARDS;
            break;
        // Frostsworn General - Throw Shield
        case 69222:
        case 73076:
            spellInfo->EffectImplicitTargetA[2] = TARGET_UNIT_TARGET_ENEMY;
            break;
        // Halls of Reflection Clone
        case 69828:
            spellInfo->Effect[1] = 0;
            spellInfo->Effect[2] = 0;
            break;
        // Summon Ice Wall
        case 69768:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
            break;
        case 69767:
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_TARGET_ANY;
            spellInfo->EffectImplicitTargetA[2] = TARGET_UNIT_TARGET_ANY;
            break;
        // Essence of the Captured
        case 73035:
        case 70719:
            spellInfo->rangeIndex = 13;
            break;
        // Achievement Check
        case 72830:
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;
            break;

        //////////////////////////////////////////
        ////////// ICECROWN CITADEL
        //////////////////////////////////////////
        case 70781: // Light's Hammer Teleport
        case 70856: // Oratory of the Damned Teleport
        case 70857: // Rampart of Skulls Teleport
        case 70858: // Deathbringer's Rise Teleport
        case 70859: // Upper Spire Teleport
        case 70860: // Frozen Throne Teleport
        case 70861: // Sindragosa's Lair Teleport
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->EffectImplicitTargetA[1] = TARGET_DEST_DB; // this target is for SPELL_EFFECT_TELEPORT_UNITS
            spellInfo->EffectImplicitTargetB[1] = 0;
            spellInfo->EffectImplicitTargetA[2] = TARGET_UNIT_TARGET_ANY;
            spellInfo->EffectImplicitTargetB[2] = 0;
            break;
        case 70960: // Bone Flurry
        case 71258: // Adrenaline Rush (Ymirjar Battle-Maiden)
            spellInfo->AttributesEx &= ~SPELL_ATTR1_CHANNELED_2;
            break;
        case 69055: // Saber Lash (Lord Marrowgar)
        case 70814: // Saber Lash (Lord Marrowgar)
            spellInfo->EffectRadiusIndex[0] = 8;    // 5yd
            break;
        case 69065: // Impaled (Lord Marrowgar)
            spellInfo->Effect[0] = 0; // remove stun so Dispersion can be used
            break;
        case 72701: // Cold Flame (Lord Marrowgar)
        case 72702: // Cold Flame (Lord Marrowgar)
        case 72703: // Cold Flame (Lord Marrowgar)
        case 72704: // Cold Flame (Lord Marrowgar)
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            spellInfo->EffectImplicitTargetA[1] = TARGET_DEST_DEST;
            spellInfo->EffectImplicitTargetB[1] = 0;
            spellInfo->DurationIndex = 9; // 30 secs instead of 12, need him for longer, but will stop his actions after 12 secs
            break;
        case 69138: // Coldflame (Lord Marrowgar)
            spellInfo->Effect[0] = 0;
            spellInfo->EffectImplicitTargetA[1] = TARGET_DEST_DEST;
            spellInfo->DurationIndex = 9; // 30 secs instead of 12, need him for longer, but will stop his actions after 12 secs
            break;
        case 69146: case 70823: case 70824: case 70825: // Coldflame (Lord Marrowgar)
            spellInfo->EffectRadiusIndex[0] = 15; // 3yd instead of 5yd
            spellInfo->AttributesEx4 &= ~SPELL_ATTR4_IGNORE_RESISTANCES;
            break;
        case 70897: // Dark Martyrdom (Lady Deathwhisper)
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_DEAD;
            break;
        case 69075: // Bone Storm (Lord Marrowgar)
        case 70834: // Bone Storm (Lord Marrowgar)
        case 70835: // Bone Storm (Lord Marrowgar)
        case 70836: // Bone Storm (Lord Marrowgar)
        case 72378: // Blood Nova (Deathbringer Saurfang)
        case 73058: // Blood Nova (Deathbringer Saurfang)
        case 72769: // Scent of Blood (Deathbringer Saurfang)
        case 72385: // Boiling Blood (Deathbringer Saurfang)
        case 72441: // Boiling Blood (Deathbringer Saurfang)
        case 72442: // Boiling Blood (Deathbringer Saurfang)
        case 72443: // Boiling Blood (Deathbringer Saurfang)
        case 71160: // Plague Stench (Stinky)
        case 71161: // Plague Stench (Stinky)
        case 71123: // Decimate (Stinky & Precious)
        case 71464: // Divine Surge (Sister Svalna)
            spellInfo->EffectRadiusIndex[0] = 12;   // 100yd
            break;
        case 71169: // Shadow's Fate
            spellInfo->AttributesEx3 |= SPELL_ATTR3_STACK_FOR_DIFF_CASTERS;
            break;
        case 72347: // Lock Players and Tap Chest
            spellInfo->AttributesEx3 &= ~SPELL_ATTR3_NO_INITIAL_AGGRO;
            break;
        case 73843: // Award Reputation - Boss Kill
        case 73844: // Award Reputation - Boss Kill
        case 73845: // Award Reputation - Boss Kill
        case 73846: // Award Reputation - Boss Kill
            spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_50000_YARDS;
            break;
        case 72864: // Death Plague (Rotting Frost Giant)
            spellInfo->excludeTargetAuraSpell = 0;
            break;
        case 69705: // Gunship Battle, spell Below Zero
            spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_HIT_RESULT;
            break;
        case 72723: // Resistant Skin (Deathbringer Saurfang adds)
            // this spell initially granted Shadow damage immunity, however it was removed but the data was left in client
            spellInfo->Effect[2] = 0;
            break;
        case 72255: // Mark of the Fallen Champion (Deathbringer Saurfang) // Patch 3.3.2 (2010-01-02): Deathbringer Saurfang will no longer gain blood power from Mark of the Fallen Champion.
        case 72444: // Mark of the Fallen Champion (Deathbringer Saurfang) // Xinef: prevented in script, effect needed for Prayer of Mending
        case 72445: // Mark of the Fallen Champion (Deathbringer Saurfang)
        case 72446: // Mark of the Fallen Champion (Deathbringer Saurfang)
            spellInfo->AttributesEx3 &= ~SPELL_ATTR3_CANT_TRIGGER_PROC;
            break;
        case 70460: // Coldflame Jets (Traps after Saurfang)
            spellInfo->DurationIndex = 1;   // 10 seconds
            break;
        case 70461: // Coldflame Jets (Traps after Saurfang)
        case 71289: // Dominate Mind (Lady Deathwhisper)
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            break;
        case 71906: // Severed Essence (Val'kyr Herald)
        case 71942: // Severed Essence (Val'kyr Herald)
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ENEMY;
            spellInfo->EffectImplicitTargetB[0] = 0;
            spellInfo->Effect[1] = 0;
            break;
        case 71159: // Awaken Plagued Zombies (Precious)
        case 71302: // Awaken Ymirjar Fallen (Ymirjar Deathbringer)
            spellInfo->DurationIndex = 21;
            break;
        case 70981: // Blood Prince Council, Invocation of Blood
        case 70982: // Blood Prince Council, Invocation of Blood
        case 70952: // Blood Prince Council, Invocation of Blood
            spellInfo->Effect[0] = 0; // clear share health aura
            break;
        case 71274: // Ymirjar Frostbinder, Frozen Orb
            spellInfo->EffectImplicitTargetA[0] = 6;
            break;
        case 69783: // Ooze Flood (Rotface)
        case 69797:
        case 69799:
        case 69802:
            spellInfo->AttributesEx |= SPELL_ATTR1_CANT_TARGET_SELF;
            break;
        case 70530: // Volatile Ooze Beam Protection
            spellInfo->Effect[0] = SPELL_EFFECT_APPLY_AURA; // blizzard typo, 65 instead of 6, aura itself is defined (dummy)
            break;
        case 70672: case 72455: case 72832: case 72833: // Professor Putricide, Gaseous Bloat (Orange Ooze Channel) -- copied attributes from Green Ooze Channel
            spellInfo->Attributes |= SPELL_ATTR0_UNAFFECTED_BY_INVULNERABILITY;
            spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_HIT_RESULT;
            break;
        case 71412: // Green Ooze Summon (Professor Putricide)
        case 71415: // Orange Ooze Summon (Professor Putricide)
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
            break;
        case 71621: case 72850: case 72851: case 72852: // Create Concoction (Professor Putricide)
        case 71893: case 73120: case 73121: case 73122: // Guzzle Potions (Professor Putricide)
            spellInfo->CastingTimeIndex = 15; // 4 sec
            break;
        case 72454: // Mutated Plague (Professor Putricide)
        case 72464: // Mutated Plague (Professor Putricide)
        case 72506: // Mutated Plague (Professor Putricide)
        case 72507: // Mutated Plague (Professor Putricide)
            spellInfo->AttributesEx4 |= SPELL_ATTR4_IGNORE_RESISTANCES;
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
            break;
        case 70911: // Unbound Plague (Professor Putricide) (needs target selection script)
        case 72854: // Unbound Plague (Professor Putricide) (needs target selection script)
        case 72855: // Unbound Plague (Professor Putricide) (needs target selection script)
        case 72856: // Unbound Plague (Professor Putricide) (needs target selection script)
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_TARGET_ENEMY;
            break;
        case 70402: // Mutated Transformation (Professor Putricide)
        case 72511: // Mutated Transformation (Professor Putricide)
        case 72512: // Mutated Transformation (Professor Putricide)
        case 72513: // Mutated Transformation (Professor Putricide)
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
            break;
        case 71708: // Empowered Flare (Blood Prince Council)
        case 72785: // Empowered Flare (Blood Prince Council)
        case 72786: // Empowered Flare (Blood Prince Council)
        case 72787: // Empowered Flare (Blood Prince Council)
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_DONE_BONUS;
            break;
        case 71518: // Unholy Infusion Quest Credit (Professor Putricide)
        case 72934: // Blood Infusion Quest Credit (Blood-Queen Lana'thel)
        case 72289: // Frost Infusion Quest Credit (Sindragosa)
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // another missing radius
            break;
        case 71266: // Swarming Shadows
        case 72890: // Swarming Shadows
            spellInfo->AreaGroupId = 0; // originally, these require area 4522, which is... outside of Icecrown Citadel
            break;
        case 71301: // Summon Dream Portal (Valithria Dreamwalker)
        case 71977: // Summon Nightmare Portal (Valithria Dreamwalker)
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            spellInfo->EffectImplicitTargetB[0] = 0;
            break;
        case 70715: // Column of Frost (visual marker)
            spellInfo->DurationIndex = 32; // 6 seconds (missing)
            break;
        case 71085: // Mana Void (periodic aura)
            spellInfo->DurationIndex = 9; // 30 seconds (missing)
            break;
        case 70936: // Summon Suppressor (needs target selection script)
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
            spellInfo->EffectImplicitTargetB[0] = 0;
            break;
        case 70602: // Corruption
            spellInfo->AttributesEx3 |= SPELL_ATTR3_STACK_FOR_DIFF_CASTERS;
            break;
        case 72706: // Achievement Check (Valithria Dreamwalker)
        case 71357: // Order Whelp
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // 200yd
            break;
        case 70598: // Sindragosa's Fury
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            break;
        case 71077: // Tail Smash (Sindragosa)
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_CASTER_BACK;
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_DEST_AREA_ENEMY;
            spellInfo->EffectImplicitTargetA[1] = TARGET_DEST_CASTER_BACK;
            spellInfo->EffectImplicitTargetB[1] = TARGET_UNIT_DEST_AREA_ENEMY;
            break;
        case 69846: // Frost Bomb
            spellInfo->speed = 0.0f;    // This spell's summon happens instantly
            break;
        case 70127: // Mystic Buffet (Sindragosa) - remove obsolete spell effect with no targets
        case 72528:
        case 72529:
        case 72530:
            spellInfo->Effect[1] = 0;
            break;
        case 70084: // Sindragosa, Frost Aura
        case 71050:
        case 71051:
        case 71052:
            spellInfo->Attributes &= ~SPELL_ATTR0_UNAFFECTED_BY_INVULNERABILITY;
            break;

        case 71614: // Ice Lock
            spellInfo->Mechanic = MECHANIC_STUN;
            break;
        case 70541: // Lich King, Infest
        case 73779:
        case 73780:
        case 73781:
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            break;
        case 70337: // Lich King, Necrotic Plague
        case 73912:
        case 73913:
        case 73914:
        case 70338:
        case 73785:
        case 73786:
        case 73787:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_HIT_RESULT;
            break;
        case 69099: // Ice Pulse 10n
        case 73776: // Ice Pulse 25n
        case 73777: // Ice Pulse 10h
        case 73778: // Ice Pulse 25h
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
            spellInfo->AttributesEx4 &= ~SPELL_ATTR4_IGNORE_RESISTANCES;
            break;
        case 72350: // Fury of Frostmourne
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
            spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
            break;
        case 72351: // Fury of Frostmourne
        case 72431: // Jump (removes Fury of Frostmourne debuff)
        case 72429: // Mass Resurrection
        case 73159: // Play Movie
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
            break;
        case 72376: // Raise Dead
            spellInfo->MaxAffectedTargets = 4;
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
            break;
        case 71809: // Jump
            spellInfo->rangeIndex = 5; // 40yd
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_10_YARDS; // 10yd
            spellInfo->EffectMiscValue[0] = 190;
            break;
        case 72405: // Broken Frostmourne
            spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_200_YARDS;   // 200yd
            break;
        case 73540: // Summon Shadow Trap
            spellInfo->DurationIndex = 3;          // 60 seconds
            break;
        case 73530: // Shadow Trap (visual)
            spellInfo->DurationIndex = 28;          // 5 seconds
            break;
        case 73529: // Shadow Trap
            spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_10_YARDS;   // 10yd
            break;
        case 74282: // Shadow Trap (searcher)
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_3_YARDS;   // 3yd
            break;
        case 69198: // Raging Spirit Visual
            spellInfo->rangeIndex = 13;             // 50000yd
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_HIT_RESULT;
            break;
        case 72762: // Defile
            spellInfo->DurationIndex = 559; // 53 seconds
            spellInfo->excludeCasterAuraSpell = 0;
            spellInfo->Attributes |= SPELL_ATTR0_UNAFFECTED_BY_INVULNERABILITY;
            spellInfo->AttributesEx6 |= (SPELL_ATTR6_CAN_TARGET_INVISIBLE | SPELL_ATTR6_CAN_TARGET_UNTARGETABLE);
            break;
        case 72743: // Defile
            spellInfo->DurationIndex = 22; // 45 seconds
            break;
        case 72754: // Defile
        case 73708: // Defile
        case 73709: // Defile
        case 73710: // Defile
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // 200yd
            spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_200_YARDS;   // 200yd
            break;
        case 69030: // Val'kyr Target Search
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // 200yd
            spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_200_YARDS;   // 200yd
            spellInfo->Attributes |= SPELL_ATTR0_UNAFFECTED_BY_INVULNERABILITY;
            break;
        case 73654: // Harvest Souls
        case 74295: // Harvest Souls
        case 74296: // Harvest Souls
        case 74297: // Harvest Souls
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
            spellInfo->EffectRadiusIndex[1] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
            spellInfo->EffectRadiusIndex[2] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
            break;
        case 72595: // Restore Soul
        case 73650: // Restore Soul
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // 200yd
            break;
        case 75127: // Kill Frostmourne Players
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
            break;
        case 73655: // Harvest Soul
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_DONE_BONUS;
            break;
        case 74086: // Destroy Soul
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // 200yd
            break;
        case 74302: // Summon Spirit Bomb
        case 74342: // Summon Spirit Bomb
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // 200yd
            spellInfo->MaxAffectedTargets = 1;
            break;
        case 74341: // Summon Spirit Bomb
        case 74343: // Summon Spirit Bomb
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_200_YARDS;   // 200yd
            spellInfo->MaxAffectedTargets = 3;
            break;
        case 73579: // Summon Spirit Bomb
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_25_YARDS;   // 25yd
            break;
        case 73582: // Trigger Vile Spirit (Inside, Heroic)
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_50000_YARDS;   // 50000yd
            break;
        // Scale Aura (used during Dominate Mind from Lady Deathwhisper)
        case 73261:
            spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CHANGE_MAP;
            break;
        // Leap to a Random Location
        case 70485:
            spellInfo->rangeIndex = 6; // 100yd
            spellInfo->EffectRadiusIndex[0] = EFFECT_RADIUS_10_YARDS;
            spellInfo->EffectMiscValue[0] = 100;
            break;
        // Empowered Blood
        case 70227:
        case 70232:
            spellInfo->AreaGroupId = 2452; // Whole icc instead of Crimson Halls only, remove when area calculation is fixed
            break;

        //////////////////////////////////////////
        ////////// RUBY SANCTUN
        //////////////////////////////////////////
        // Repelling Wave
        case 74509:
            spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_20_YARDS;
            spellInfo->EffectRadiusIndex[EFFECT_1] = EFFECT_RADIUS_20_YARDS;
            break;
        // Rallying Shout
        case 75414:
            spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_20_YARDS;
            break;
        // Barrier Channel
        case 76221:
            spellInfo->ChannelInterruptFlags &= ~(AURA_INTERRUPT_FLAG_TURNING|AURA_INTERRUPT_FLAG_MOVE);
            spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_UNIT_NEARBY_ENTRY;
            break;
        // Intimidating Roar
        case 74384:
            spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_100_YARDS;
            spellInfo->EffectRadiusIndex[EFFECT_1] = EFFECT_RADIUS_100_YARDS;
            break;
        // Fiery Combustion
        case 74562:
        // Soul Consumption
        case 74792:
            spellInfo->AttributesEx |= SPELL_ATTR1_CANT_BE_REDIRECTED;
            break;
        // Combustion
        case 75883:
        case 75884:
            spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_6_YARDS;
            spellInfo->EffectRadiusIndex[EFFECT_1] = EFFECT_RADIUS_6_YARDS;
            break;
        // Consumption
        case 75875:
        case 75876:
            spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_6_YARDS;
            spellInfo->EffectRadiusIndex[EFFECT_1] = EFFECT_RADIUS_6_YARDS;
            spellInfo->EffectMechanic[EFFECT_0] = 0;
            spellInfo->EffectMechanic[EFFECT_1] = MECHANIC_SNARE;
            break;
        // Soul Consumption
        case 74799:
            spellInfo->EffectRadiusIndex[EFFECT_1] = EFFECT_RADIUS_12_YARDS;
            break;
        // Twilight Cutter
        case 74769:
        case 77844:
        case 77845:
        case 77846:
            spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_100_YARDS;
            break;
        // Twilight Mending
        case 75509:
            spellInfo->AttributesEx6 |= SPELL_ATTR6_CAN_TARGET_INVISIBLE;
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            spellInfo->EffectRadiusIndex[EFFECT_0] = EFFECT_RADIUS_100_YARDS;
            spellInfo->EffectRadiusIndex[EFFECT_1] = EFFECT_RADIUS_100_YARDS;
            break;
        // Meteor Strike
        case 74637:
            spellInfo->speed = 0;
            break;


        // ///////////////////////////////////////////
        // ////////////////QUESTS/////////////////////
        // ///////////////////////////////////////////
        // Going Bearback (12851)
        case 54897:
            spellInfo->Effect[1] = SPELL_EFFECT_DUMMY;
            spellInfo->EffectRadiusIndex[1] = spellInfo->EffectRadiusIndex[0];
            spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_DEST_AREA_ENTRY;
			spellInfo->AttributesEx4 &= ~SPELL_ATTR4_CAN_CAST_WHILE_CASTING;
            break;
        // Still At It (12644)
        case 51931:
        case 51932:
        case 51933:
            spellInfo->EffectImplicitTargetA[0] = 38;
            spellInfo->EffectImplicitTargetB[0] = 0;
            break;
        // Rallying the Troops (12070)
        case 47394:
            spellInfo->excludeTargetAuraSpell = 47394;
            break;
        // A Tangled Skein (12555)
        case 51165:
        case 51173:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_INITIAL_AGGRO;
            break;
        // A Cloudlet of Classy Cologne (24635)
        case 69563:
        // A Perfect Puff of Perfume (24629)
        case 69445:
        // Bonbon Blitz (24636)
        case 69489:
            spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_CASTER;
            break;
        // Control (9595)
        case 30790:
            spellInfo->EffectMiscValue[1] = 0;
            break;
        // Reclusive Runemaster (12150)
        case 48028:
            spellInfo->EffectImplicitTargetA[0] = TARGET_SRC_CASTER;
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENEMY;
            break;
        // Mastery of
        case 65147:
            spellInfo->Category = 1244;
            spellInfo->CategoryRecoveryTime = 1500;
            break;
        // Weakness to Lightning (11896)
        case 46432:
            spellInfo->AttributesEx3 &= ~SPELL_ATTR3_DEATH_PERSISTENT;
            break;
        // Wrangle Some Aether Rays! (11065)
        case 40856:
            spellInfo->DurationIndex = 27; // 3000ms
            break;
        // The Black Knight's Orders (13663)
        case 63163:
            spellInfo->EffectBasePoints[0] = 52390;
            break;
        // The Warp Rifts (10278)
        case 34888:
            spellInfo->DurationIndex = 5; // 300 secs
            break;
        // The Smallest Creatures (10720)
        case 38544:
            spellInfo->EffectMiscValueB[0] = 427;
            spellInfo->EffectImplicitTargetA[0] = 1;
            spellInfo->Effect[1] = 0;
            break;
        // Ridding the red rocket
        case 49177:
            spellInfo->EffectBasePoints[0] = 1; // corrects seat id (points - 1 = seatId)
            break;
        // The Iron Colossus (13007)
        case 56513:
        case 56524:
            spellInfo->RecoveryTime = (spellInfo->Id == 56524 ? 6000 : 2000);
            break;
        // Kaw the Mammoth Destroyer (11879)
        case 46260:
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            break;
        // That's Abominable (13264)(13276)(13288)(13289)
        case 59565:
            spellInfo->EffectMiscValueB[0] = 1721; // controlable guardian
            break;
        // Investigate the Blue Recluse (1920)
        // Investigate the Alchemist Shop (1960)
        case 9095:
            spellInfo->EffectApplyAuraName[0] = SPELL_AURA_DUMMY;
            spellInfo->EffectRadiusIndex[0] = 13;
            break;
        // Dragonmaw Race: All parts
        case 40890: // Oldie's Rotten Pumpkin
            spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
            spellInfo->EffectTriggerSpell[0] = 40905;
            spellInfo->Effect[0] = SPELL_EFFECT_TRIGGER_MISSILE;
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            break;
        case 40909: // Trope's Slime Cannon
            spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
            spellInfo->EffectTriggerSpell[0] = 40905;
            spellInfo->Effect[0] = SPELL_EFFECT_TRIGGER_MISSILE;
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            break;
        case 40894: // Corlok's Skull Barrage
            spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
            spellInfo->EffectTriggerSpell[0] = 40900;
            spellInfo->Effect[0] = SPELL_EFFECT_TRIGGER_MISSILE;
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            break;
        case 40928: // Ichman's Blazing Fireball
            spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
            spellInfo->EffectTriggerSpell[0] = 40929;
            spellInfo->Effect[0] = SPELL_EFFECT_TRIGGER_MISSILE;
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            break;
        case 40930: // Mulverick's Great Balls of Lightning
            spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
            spellInfo->EffectTriggerSpell[0] = 40931;
            spellInfo->Effect[0] = SPELL_EFFECT_TRIGGER_MISSILE;
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            break;
        case 40945: // Sky Shatter
            spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
            spellInfo->EffectTriggerSpell[0] = 41064;
            spellInfo->Effect[0] = SPELL_EFFECT_TRIGGER_MISSILE;
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            break;
        // Gauging the Resonant Frequency (10594)
        case 37390:
            spellInfo->EffectMiscValueB[0] = 181;
            break;
        // Where in the World is Hemet Nesingwary? (12521)
        case 50860:
            spellInfo->EffectBasePoints[0] = 50860;
            break;
        case 50861:
            spellInfo->EffectBasePoints[0] = 0;
            break;
        // Krolmir, Hammer of Storms (13010)
        case 56606:
        case 56541:
            spellInfo->EffectBasePoints[0] = 1;
            break;
        // Blightbeasts be Damned! (12072)
        case 47424:
            spellInfo->AuraInterruptFlags &= ~AURA_INTERRUPT_FLAG_NOT_ABOVEWATER;
            break;
        // Leading the Charge (13380), All Infra-Green bomber quests
        case 59059:
            spellInfo->AttributesEx4 &= ~SPELL_ATTR4_CAN_CAST_WHILE_CASTING;
            break;
        // Dark Horizon (12664), Reunited (12663)
        case 52190:
            spellInfo->EffectBasePoints[EFFECT_0] = 52391-1;
            break;
        // The Sum is Greater than the Parts (13043) - Chained Grip
        case 60540:
            spellInfo->EffectMiscValue[EFFECT_0] = 300;
            break;
        // Not a Bug (13342)
        case 60531:
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_DEAD;
            break;
        // Frankly,  It Makes No Sense... (10672)
        case 37851:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_INITIAL_AGGRO;
            break;
        // Honor Challenge (12939)
        case 21855:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_NO_INITIAL_AGGRO;
            break;
        // Convocation at Zol'Heb (12730)
        case 52956:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_DEST_AREA_ENTRY;
            break;
       // Mangletooth Quests (http://www.wowhead.com/npc=3430)
        case 7764:
        case 10767:
        case 16610:
        case 16612:
        case 16618:
        case 17013:
             spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
             spellInfo->AttributesEx5 |= SPELL_ATTR5_SKIP_CHECKCAST_LOS_CHECK;
             break;
        //Crushing the Crown
        case 71024:
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DYNOBJ_NONE;
            break;

        // ///////////////////////////////////////////
        // ////////////////ITEMS//////////////////////
        // ///////////////////////////////////////////
        // enchant Lightweave Embroidery
        case 55637:
            spellInfo->EffectMiscValue[1] = 126;
            break;
        // Magic Broom
        case 47977:
            spellInfo->Effect[0] = 0;
            spellInfo->Effect[1] = 0;
            break;
        // Titanium Seal of Dalaran, Toss your luck
        case 60476:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            break;
        // Mind Amplification Dish, change charm aura
        case 26740:
            spellInfo->EffectApplyAuraName[0] = SPELL_AURA_MOD_CHARM;
            break;
        // Persistent Shield (fixes idiocity)
        case 26467:
            spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PROC_TRIGGER_SPELL_WITH_VALUE;
            spellInfo->EffectTriggerSpell[0] = 26470;
            break;
        // Deadly Swiftness
        case 31255:
            spellInfo->EffectTriggerSpell[0] = 22588;
            break;
        // Black Magic enchant
        case 59630:
            spellInfo->Attributes |= SPELL_ATTR0_PASSIVE;
            break;
        // Precious's Ribbon
        case 72968:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_DEATH_PERSISTENT;
            break;
        // Item - Bauble of True Blood 10m
        // Item - Bauble of True Blood 25m
        case 71646:
        case 71607:
        // Item - Althor's Abacus trigger 10m
        // Item - Althor's Abacus trigger 25m
        case 71610:
        case 71641:
            spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
            spellInfo->spellLevel = 0;
            break;
        // Drain Life - Bryntroll Normal / Heroic
        case 71838:
        case 71839:
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
            spellInfo->AttributesEx4 |= SPELL_ATTR4_IGNORE_RESISTANCES;
            break;
        // Alchemist's Stone
        case 17619:
            spellInfo->AttributesEx3 |= SPELL_ATTR3_DEATH_PERSISTENT;
            break;
        // Gnomish Death Ray
        case 13278:
        case 13280:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ENEMY;
            break;
        // Stormchops
        case 43730:
            spellInfo->EffectImplicitTargetA[1] = 1;
            spellInfo->EffectImplicitTargetB[1] = 0;
            break;
        // Savory Deviate Delight (transformations), allow to mount while transformed
        case 8219:
        case 8220:
        case 8221:
        case 8222:
            spellInfo->Attributes &= ~SPELL_ATTR0_UNAFFECTED_BY_INVULNERABILITY;
            break;
        // Clamlette Magnifique
        case 72623: // drink triggered spell
            spellInfo->EffectBasePoints[EFFECT_0] = spellInfo->EffectBasePoints[EFFECT_1];
            break;
        // Compact Harvest Reaper
        case 4078:
            spellInfo->DurationIndex = 6; // 10 minutes
            break;
        // Dragon Kite, Tuskarr Kite - Kite String
        case 45192:
            spellInfo->rangeIndex = 6; // 100yd
            break;
        // Frigid Frostling, Infrigidate
        case 74960:
            spellInfo->EffectRadiusIndex[EFFECT_0] = 9; // 20yd
            break;


        // ///////////////////////////////////////////
        // ////////////////EVENTS/////////////////////
        // ///////////////////////////////////////////

        //////////////////////////////////////////
        ////////// BREWFEST
        //////////////////////////////////////////
        // Apple Trap
        case 43450:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_SRC_AREA_ENEMY;
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_CASTER;
            spellInfo->Effect[0] = SPELL_EFFECT_DUMMY;
            break;
        // Dark Iron Attack - spawn mole machine
        case 43563:
            spellInfo->Effect[2] = 0; // summon GO's manually
            break;
        // Throw Mug visual
        case 42300:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_TARGET_ANY;
            break;
        // Dark Iron knockback Aura
        case 42299:
            spellInfo->EffectApplyAuraName[1] = SPELL_AURA_DUMMY;
            spellInfo->EffectMiscValue[0] = 100;
            spellInfo->EffectBasePoints[0] = 79;
            break;
        // Chug and Chuck!
        case 42436:
            spellInfo->EffectImplicitTargetA[0] = TARGET_SRC_CASTER;
            spellInfo->EffectImplicitTargetB[0] = TARGET_UNIT_SRC_AREA_ENTRY;
            spellInfo->MaxAffectedTargets = 0;
            spellInfo->excludeCasterAuraSpell = 42299;
            break;
        // Catch the Wild Wolpertinger!
        case 41621:
            spellInfo->Effect[0] = SPELL_EFFECT_DUMMY;
            break;
        // Brewfest quests
        case 47134:
        case 51798:
            spellInfo->Effect[0] = 0;
            break;
        // The Heart of The Storms (12998)
        case 43528:
            spellInfo->DurationIndex = 18;
            spellInfo->EffectImplicitTargetA[0] = 25;
            break;

        //////////////////////////////////////////
        ////////// Hallow's End
        //////////////////////////////////////////
        // Water splash
        case 42348:
            spellInfo->Effect[0] = 0;
            break;
        // Summon Lantersn
        case 44255:
        case 44231:
            spellInfo->EffectImplicitTargetA[0] = TARGET_DEST_DEST;
            spellInfo->EffectImplicitTargetB[0] = 0;
            break;
        // Throw Head Back
        case 42401:
            spellInfo->EffectImplicitTargetA[0] = TARGET_UNIT_NEARBY_ENTRY;
            break;

        //////////////////////////////////////////
        ////////// Pilgrim's Bounty
        //////////////////////////////////////////
        // Various food
        case 65418:
            spellInfo->EffectTriggerSpell[2] = 65410;
            break;
        case 65422:
            spellInfo->EffectTriggerSpell[2] = 65414;
            break;
        case 65419:
            spellInfo->EffectTriggerSpell[2] = 65416;
            break;
        case 65420:
            spellInfo->EffectTriggerSpell[2] = 65412;
            break;
        case 65421:
            spellInfo->EffectTriggerSpell[2] = 65415;
            break;

        //////////////////////////////////////////
        ////////// Midsummer
        //////////////////////////////////////////
        // Stamp Out Bonfire
        case 45437:
            spellInfo->Effect[1] = SPELL_EFFECT_DUMMY;
            spellInfo->EffectImplicitTargetA[1] = TARGET_UNIT_NEARBY_ENTRY;
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            break;
        // Light Bonfire (DND)
        case 29831:
            spellInfo->AttributesEx2 |= SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS;
            break;
        //////////////////////////////////////////
        ////////// Misc Events
        //////////////////////////////////////////
        // Infernal
        case 33240:
            spellInfo->EffectImplicitTargetA[EFFECT_0] = TARGET_DEST_TARGET_ANY;
            spellInfo->EffectImplicitTargetA[EFFECT_1] = TARGET_UNIT_TARGET_ANY;
            spellInfo->EffectImplicitTargetA[EFFECT_2] = TARGET_UNIT_TARGET_ANY;
            break;
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

    sLog->outString(">> Loading spell dbc data corrections  in %u ms", GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}
