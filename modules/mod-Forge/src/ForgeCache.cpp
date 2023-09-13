#pragma once
#define OUT

#include <string>
#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "DatabaseEnv.h"
#include "SharedDefines.h"
#include "Gamemode.h"
#include <unordered_map>
#include <list>
#include <tuple>
#include <random>
#include <boost/lexical_cast.hpp>
#include <boost/uuid/uuid_io.hpp>
#include <boost/uuid/uuid.hpp>
#include <boost/uuid/uuid_generators.hpp>


enum CharacterPointType
{
    TALENT_TREE = 0,
    FORGE_SKILL_TREE = 1,
    PRESTIGE_TREE = 3,
    RACIAL_TREE = 4,
    SKILL_PAGE = 5,
    PRESTIGE_COUNT = 6,
    LEVEL_10_TAB = 7
};

enum ForgeSettingIndex
{
    FORGE_SETTING_SPEC_SLOTS = 0
};

#define FORGE_SETTINGS "ForgeSettings"
#define ACCOUNT_WIDE_TYPE CharacterPointType::PRESTIGE_TREE
#define ACCOUNT_WIDE_KEY 0xfffffffe

enum class SpecVisibility
{
    PRIVATE = 0,
    FRIENDS = 1,
    GUILD = 2,
    PUBLIC = 3
};

enum class PereqReqirementType
{
    ALL = 0,
    ONE = 1
};

struct ForgeCharacterPoint
{
    CharacterPointType PointType;
    uint32 SpecId;
    uint32 Sum;
    uint32 Max;
};

struct ClassSpecDetail
{
    std::string Name;
    uint32 SpellIconId;
    uint32 SpecId;
};

struct ForgeCharacterTalent
{
    uint32 SpellId;
    uint32 TabId;
    uint8 CurrentRank;
};

struct ForgeTalentPrereq
{
    uint32 reqId;
    uint32 Talent;
    uint32 TalentTabId;
    uint32 RequiredRank;
};

//////// PERK ////////
enum CharacterPerkType
{
    ARCHETYPE = 0,
    COMBAT = 1,
    UTILITY = 2,
    FUN = 3,
    MAX
};

struct Perk {
    uint32 spellId;
    bool isUnique;
    int32 allowableClass;
    bool isPermanent;
    uint8 chance;
    uint8 category;
    bool isAura;
    uint32 groupId;
    std::string tags;
    // rank number, spellId
    std::unordered_map<uint32, uint32> ranks;
    // SpellId, Rank Number
    std::unordered_map<uint32, uint32> ranksRev;
    bool operator () (const Perk& m) const
    {
        return m.spellId == m.spellId;
    }
};

struct ArchetypePerk {
    int32 allowableClass;
    int8 level;
    int8 role;
    Perk* perk;
    bool spell;
};

struct CharacterSpecPerk {
    Perk* spell;
    std::string uuid;
    uint8 rank;
    uint8 carryover;
    bool operator () (const CharacterSpecPerk* m) const
    {
        return m->spell->spellId == m->spell->spellId;
    }
};
//////////////////////

struct ForgeCharacterSpec
{
    uint32 Id;
    ObjectGuid CharacterGuid;
    std::string Name;
    std::string Description;
    bool Active;
    uint32 SpellIconId;
    SpecVisibility Visability;
    uint32 CharacterSpecTabId; // like holy ret pro
    uint8 ArchetypalRole;
    // TabId, Spellid
    std::unordered_map<uint32, std::unordered_map<uint32, ForgeCharacterTalent*>> Talents;
    // tabId
    std::unordered_map<uint32, uint8> PointsSpent;
    std::unordered_map<CharacterPerkType, std::unordered_map<uint32, CharacterSpecPerk*>> perks;
    std::unordered_map<uint32, Perk*> groupPerks;
    std::unordered_map<CharacterPerkType, std::vector<CharacterSpecPerk*>> prestigePerks;
    std::unordered_map<CharacterPerkType, std::unordered_map<std::string, std::vector<CharacterSpecPerk*>>> perkQueue;
};

struct ForgeTalent
{
    uint32 SpellId;
    uint32 TalentTabId;
    uint32 ColumnIndex;
    uint32 RowIndex;
    uint8 RankCost;
    uint16 TabPointReq;
    uint8 RequiredLevel;
    CharacterPointType TalentType;
    uint8 NumberOfRanks;
    PereqReqirementType PreReqType;
    std::list<ForgeTalentPrereq*> Prereqs;
    std::list<uint32> ExclusiveWith;
    std::list<uint32> UnlearnSpells;
    // rank number, spellId
    std::unordered_map<uint32, uint32> Ranks;
    // SpellId, Rank Number
    std::unordered_map<uint32, uint32> RanksRev; // only in memory
};

struct ForgeTalentTab
{
    uint32 Id;
    uint32 ClassMask;
    uint32 RaceMask;
    std::string Name;
    uint32 SpellIconId;
    std::string Background;
    CharacterPointType TalentType;
    uint32 TabIndex;
    std::unordered_map<uint32, ForgeTalent*> Talents;
};


class ForgeCache : public DatabaseScript
{
public:
    

    static ForgeCache *get_instance()
    {
        static ForgeCache* cache;

        if (cache == nullptr)
            cache = new ForgeCache();

        return cache;
    }

    ForgeCache() : DatabaseScript("ForgeCache")
    {
        RACE_LIST =
        {
            RACE_HUMAN,
            RACE_ORC,
            RACE_DWARF,
            RACE_NIGHTELF,
            RACE_UNDEAD_PLAYER,
            RACE_TAUREN,
            RACE_GNOME,
            RACE_TROLL,
            RACE_BLOODELF,
            RACE_DRAENEI
        };

        CLASS_LIST =
        {
            CLASS_WARRIOR,
            CLASS_PALADIN,
            CLASS_HUNTER,
            CLASS_ROGUE,
            CLASS_PRIEST,
            CLASS_DEATH_KNIGHT,
            CLASS_SHAMAN,
            CLASS_MAGE,
            CLASS_WARLOCK,
            CLASS_DRUID
        };

        TALENT_POINT_TYPES =
        {
            CharacterPointType::TALENT_TREE,
            CharacterPointType::FORGE_SKILL_TREE,
            CharacterPointType::PRESTIGE_TREE,
            CharacterPointType::RACIAL_TREE
        };
    }

    bool IsDatabaseBound() const override
    {
        return true;
    }

    void OnAfterDatabasesLoaded(uint32 updateFlags) override
    {
        BuildForgeCache();
    }

    bool TryGetTabIdForSpell(Player* player, uint32 spellId, OUT uint32& tabId)
    {
        auto tabItt = SpellToTalentTabMap.find(spellId);

        if (tabItt == SpellToTalentTabMap.end())
            return false;

        tabId = tabItt->second;
        return true;
    }

    bool TryGetSpellIddForTab(Player* player, uint32 tabId, OUT uint32& skillId)
    {
        auto tabItt = TalentTabToSpellMap.find(tabId);

        if (tabItt == TalentTabToSpellMap.end())
            return false;

        skillId = tabItt->second;
        return true;
    }

    bool TryGetCharacterTalents(Player* player, uint32 tabId, OUT std::unordered_map<uint32, ForgeCharacterTalent*>& spec)
    {
        ForgeCharacterSpec* charSpec;

        if (!TryGetCharacterActiveSpec(player, charSpec))
            return false;

        auto tabItt = charSpec->Talents.find(tabId);

        if (tabItt == charSpec->Talents.end())
            return false;

        spec = tabItt->second;
        return true;
    }

    bool TryGetCharacterPerksByType(Player* player, uint32 specId, CharacterPerkType type, OUT std::vector<CharacterSpecPerk*>& specPerks)
    {
        ForgeCharacterSpec* charSpec;
        if (!TryGetCharacterActiveSpec(player, charSpec))
            return false;

        for (auto perk : charSpec->perks[type])
            specPerks.push_back(perk.second);

        return specPerks.size() == charSpec->perks.size();
    }

    bool TryGetAllPerks(OUT std::vector<Perk*>& perks)
    {
        for (auto perk : AllPerks)
            perks.push_back(perk.second);

        return perks.size() == AllPerks.size();
    }

    bool TryGetAllCharacterSpecs(Player* player, OUT std::list<ForgeCharacterSpec*>& specs)
    {
        auto charSpecItt = CharacterSpecs.find(player->GetGUID());

        if (charSpecItt == CharacterSpecs.end())
            return false;

        for (auto& specKvp : charSpecItt->second)
            specs.push_back(specKvp.second);

        return true;
    }

    bool TryGetCharacterActiveSpec(Player* player, OUT ForgeCharacterSpec*& spec)
    {
        auto cas = CharacterActiveSpecs.find(player->GetGUID());

        if (cas == CharacterActiveSpecs.end())
            return false;

        return TryGetCharacterSpec(player, cas->second, spec);
    }

    int CountPerksByType(Player* player, CharacterPerkType type)
    {
        // TODO GRAB NUMBER FROM CATEGORY:COUNT MAP
        int count = 0;
        ForgeCharacterSpec* spec;
        if (TryGetCharacterActiveSpec(player, spec)) {
            auto perks = spec->perks[type];
            if (!perks.empty())
                for (auto perk : perks)
                    count += perk.second->rank;
        }
        return count;
    }

    bool TryGetCharacterPerks(Player* player, uint32 specId, OUT std::vector<CharacterSpecPerk*>& specPerks)
    {
        ForgeCharacterSpec* charSpec;
        if (TryGetCharacterActiveSpec(player, charSpec)) {
            auto count = 0;
            for (int i = CharacterPerkType::ARCHETYPE; i < CharacterPerkType::MAX; i++)
                for (auto perk : charSpec->perks[CharacterPerkType(i)]) {
                    specPerks.push_back(perk.second);
                    count++;
                }

            return specPerks.size() == count;
        }
        return false;
    }


    bool TryGetCharacterSpec(Player* player, uint32 specId, OUT ForgeCharacterSpec*& spec)
    {
        auto charSpecItt = CharacterSpecs.find(player->GetGUID());

        if (charSpecItt == CharacterSpecs.end())
            return false;

        auto sp = charSpecItt->second.find(specId);

        if (sp == charSpecItt->second.end())
            return false;

        spec = sp->second;
        return true;
    }

    ForgeCharacterTalent* GetTalent(Player* player, uint32 spellId)
    {
        auto tabItt = SpellToTalentTabMap.find(spellId);

        if (tabItt == SpellToTalentTabMap.end())
            return nullptr;

        auto* tab = TalentTabs[tabItt->second];

        ForgeCharacterSpec* spec;
        if (TryGetCharacterActiveSpec(player, spec))
        {
            auto talTabItt = spec->Talents.find(tab->Id);

            if (talTabItt == spec->Talents.end())
                return nullptr;

            auto spellItt = talTabItt->second.find(spellId);

            if (spellItt == talTabItt->second.end())
                return nullptr;

            return spellItt->second;
        }

        return nullptr;
    }

    ForgeCharacterPoint* GetSpecPoints(Player* player, CharacterPointType pointType)
    {
        ForgeCharacterSpec* spec;

        if (TryGetCharacterActiveSpec(player, spec))
        {
            return GetSpecPoints(player, pointType, spec->Id);
        }

        AddCharacterSpecSlot(player);

        return GetSpecPoints(player, pointType);
    }

    ForgeCharacterPoint* GetSpecPoints(Player* player, CharacterPointType pointType, uint32 specId)
    {
        if (ACCOUNT_WIDE_TYPE == pointType || pointType == CharacterPointType::PRESTIGE_COUNT)
        {
            auto ptItt = AccountWidePoints.find(player->GetSession()->GetAccountId());

            if (ptItt != AccountWidePoints.end())
            {
                auto p = ptItt->second.find(pointType);

                if (p != ptItt->second.end())
                    return p->second;
            }

            return CreateAccountBoundCharPoint(player, pointType);
        }

        auto charGuid = player->GetGUID();
        auto cpItt = CharacterPoints.find(charGuid);

        if (cpItt != CharacterPoints.end())
        {
            auto ptItt = cpItt->second.find(pointType);

            if (ptItt != cpItt->second.end())
            {
                auto talItt = ptItt->second.find(specId);

                if (talItt != ptItt->second.end())
                    return talItt->second;
            }
        }

    
        ForgeCharacterPoint* fcp = new ForgeCharacterPoint();
        fcp->PointType = pointType;
        fcp->SpecId = specId;


        UpdateCharPoints(player, fcp);

        return fcp;
    }

    ForgeCharacterPoint* GetCommonCharacterPoint(Player* player, CharacterPointType pointType)
    {
        if (pointType != ACCOUNT_WIDE_TYPE && pointType != CharacterPointType::PRESTIGE_COUNT)
            return GetSpecPoints(player, pointType, UINT_MAX);
        else
            return GetSpecPoints(player, pointType);
    }

    bool TryGetTabPointType(uint32 tabId, CharacterPointType& pointType)
    {
        auto fttItt = TalentTabs.find(tabId);

        if (fttItt == TalentTabs.end())
            return false;

        pointType = fttItt->second->TalentType;
        return true;
    }

    bool TryGetTalentTab(Player* player, uint32 tabId, OUT ForgeTalentTab*& tab)
    {
        auto charRaceItt = RaceAndClassTabMap.find(player->getRace());

        if (charRaceItt == RaceAndClassTabMap.end())
            return false;

        auto charClassItt = charRaceItt->second.find(player->getClass());

        if (charClassItt == charRaceItt->second.end())
            return false;

        // all logic before this is to ensure player has access to the tab.

        auto fttItt = charClassItt->second.find(tabId);

        if (fttItt == charClassItt->second.end())
            return false;

        tab = TalentTabs[tabId];
        return true;
    }

    bool TryGetForgeTalentTabs(Player* player, CharacterPointType cpt, OUT std::list<ForgeTalentTab*>& talentTabs)
    {
        auto race = player->getRace();
        auto pClass = player->getClass();

        auto charRaceItt = RaceAndClassTabMap.find(race);

        if (charRaceItt == RaceAndClassTabMap.end())
            return false;

        auto charClassItt = charRaceItt->second.find(pClass);

        if (charClassItt == charRaceItt->second.end())
            return false;

        auto ptItt = CharacterPointTypeToTalentTabIds.find(cpt);

        if (ptItt == CharacterPointTypeToTalentTabIds.end())
            return false;

        for (auto iter : charClassItt->second)
        {
            if (ptItt->second.find(iter) != ptItt->second.end())
                talentTabs.push_back(TalentTabs[iter]);
        }

        return true;
    }


    void AddCharacterSpecSlot(Player* player)
    {
        uint32 act = player->GetSession()->GetAccountId();
        uint8 num = player->GetSpecsCount();

        num = num + 1;
        player->UpdatePlayerSetting(FORGE_SETTINGS, FORGE_SETTING_SPEC_SLOTS, num);

        ForgeCharacterSpec* spec = new ForgeCharacterSpec();
        spec->Id = num;
        spec->Active = num == 1;
        spec->CharacterGuid = player->GetGUID();
        spec->Name = "Specialization " + std::to_string(num);
        spec->Description = "Skill Specilization";
        spec->Visability = SpecVisibility::PRIVATE;
        spec->SpellIconId = 133743;

        player->SetSpecsCount(num);

        if (spec->Active)
            player->ActivateSpec(num);

        auto actItt = AccountWideCharacterSpecs.find(act);

        if (actItt != AccountWideCharacterSpecs.end())
        {
            for (auto& talent : actItt->second->Talents)
                for (auto& tal : talent.second)
                    spec->Talents[talent.first][tal.first] = tal.second;


            for (auto& pointsSpent : actItt->second->PointsSpent)
                spec->PointsSpent[pointsSpent.first] = pointsSpent.second;
        }

        for (auto pt : TALENT_POINT_TYPES)
        {
            if (ACCOUNT_WIDE_TYPE == pt || pt == CharacterPointType::PRESTIGE_COUNT)
            {
                if (actItt == AccountWideCharacterSpecs.end() || AccountWidePoints[act].find(pt) == AccountWidePoints[act].end())
                    CreateAccountBoundCharPoint(player, pt);

                continue;
            }

            ForgeCharacterPoint* fpt = GetCommonCharacterPoint(player, pt);
            ForgeCharacterPoint* maxCp = GetMaxPointDefaults(pt);

            ForgeCharacterPoint* newFp = new ForgeCharacterPoint();
            newFp->Max = maxCp->Max;
            newFp->PointType = pt;
            newFp->SpecId = spec->Id;
            newFp->Sum = fpt->Sum;

            UpdateCharPoints(player, newFp);
        }

        UpdateCharacterSpec(player, spec);
    }

    void ReloadDB()
    {
        BuildForgeCache();
    }

    void UpdateCharPoints(Player* player, ForgeCharacterPoint*& fp)
    {
        auto charGuid = player->GetGUID();
        auto acct = player->GetSession()->GetAccountId();
        bool isNotAccountWide = ACCOUNT_WIDE_TYPE != fp->PointType && fp->PointType != CharacterPointType::PRESTIGE_COUNT;

        if (isNotAccountWide)
            CharacterPoints[charGuid][fp->PointType][fp->SpecId] = fp;
        else
        {
            AccountWidePoints[acct][fp->PointType] = fp;

            auto pItt = PlayerCharacterMap.find(acct);

            if (pItt != PlayerCharacterMap.end())
                for (auto& ch : pItt->second)
                    for (auto& spec : CharacterSpecs[ch])
                        CharacterPoints[ch][fp->PointType][spec.first] = fp;
        }

        auto trans = CharacterDatabase.BeginTransaction();

        if (isNotAccountWide)
            trans->Append("INSERT INTO `forge_character_points` (`guid`,`type`,`spec`,`sum`,`max`) VALUES ({},{},{},{},{}) ON DUPLICATE KEY UPDATE `sum` = {}, `max` = {}", charGuid.GetCounter(), (int)fp->PointType, fp->SpecId, fp->Sum, fp->Max, fp->Sum, fp->Max);
        else
            trans->Append("INSERT INTO `forge_character_points` (`guid`,`type`,`spec`,`sum`,`max`) VALUES ({},{},{},{},{}) ON DUPLICATE KEY UPDATE `sum` = {}, `max` = {}", acct, (int)fp->PointType, ACCOUNT_WIDE_KEY, fp->Sum, fp->Max, fp->Sum, fp->Max);

        CharacterDatabase.CommitTransaction(trans);
    }

    void UpdateCharacterSpec(Player* player, ForgeCharacterSpec* spec)
    {
        uint32 charId = player->GetGUID().GetCounter();
        uint32 acct = player->GetSession()->GetAccountId();

        auto trans = CharacterDatabase.BeginTransaction();

        if (spec->Active)
            CharacterActiveSpecs[player->GetGUID()] = spec->Id;

        UpdateForgeSpecInternal(player, trans, spec);

        for (auto& tabIdKvp : spec->Talents)
            for (auto& tabTypeKvp : tabIdKvp.second)
                UpdateChacterTalentInternal(acct, charId, trans, spec->Id, tabTypeKvp.second->SpellId, tabTypeKvp.second->TabId, tabTypeKvp.second->CurrentRank);
                

        CharacterDatabase.CommitTransaction(trans);
    }

    void UpdateCharacterSpecDetailsOnly(Player* player, ForgeCharacterSpec*& spec)
    {
        uint32 charId = player->GetGUID().GetCounter();
        auto trans = CharacterDatabase.BeginTransaction();
        UpdateForgeSpecInternal(player, trans, spec);

        CharacterDatabase.CommitTransaction(trans);
    }

    void UpdateChacterTalent(Player* player, uint32 spec, uint32 spellId, uint32 tabId, uint8 known)
    {
        auto trans = CharacterDatabase.BeginTransaction();
        UpdateChacterTalentInternal(player->GetSession()->GetAccountId(), player->GetGUID().GetCounter(), trans, spec, spellId, tabId, known);
        CharacterDatabase.CommitTransaction(trans);
    }

    void LearnCharacterPerkInternal(Player* player, ForgeCharacterSpec* spec, CharacterSpecPerk* perk, CharacterPerkType type) {
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

        trans->Append("INSERT INTO character_spec_perks (`guid`, `specId`, `type`, `uuid`, `spellId`, `rank`) VALUES ({}, {}, {}, '{}', {}, {}) ON DUPLICATE KEY UPDATE `rank` = {}",
            player->GetGUID().GetCounter(), spec->Id, type, perk->uuid, perk->spell->spellId, perk->rank, perk->rank);
        trans->Append("INSERT INTO character_perk_roll_history select {} as `accountId`, `guid`, `rollKey`, `specId`, `spellId`, {} as `level`, 0 as `carryover` from character_perk_selection_queue where rollkey = '{}' ON DUPLICATE KEY UPDATE `carryover` = `carryover`+1",
            player->GetSession()->GetAccountId(), player->GetLevel(), perk->uuid);
        trans->Append("DELETE FROM character_spec_perks where `guid` = {} and `specId` = {} and `rank` = 0", player->GetGUID().GetCounter(), spec->Id);

        CharacterDatabase.CommitTransaction(trans);
    }

    void ApplyTalents(Player* player)
    {
        ForgeCharacterSpec* currentSpec;

        if (TryGetCharacterActiveSpec(player, currentSpec))
        {
            uint32 playerLevel = player->getLevel();
            auto modes = Gamemode::GetGameMode(player);

            for (auto charTabType : TALENT_POINT_TYPES)
            {
                if (ACCOUNT_WIDE_TYPE != charTabType && charTabType != TALENT_TREE
                    && charTabType != RACIAL_TREE)
                    continue;

                std::list<ForgeTalentTab*> tabs;
                if (TryGetForgeTalentTabs(player, charTabType, tabs)) {
                    for (auto* tab : tabs)
                    {
                        auto talItt = currentSpec->Talents.find(tab->Id);
                        for (auto spell : tab->Talents)
                        {
                            if (modes.size() == 0 && talItt != currentSpec->Talents.end())
                            {
                                auto spellItt = talItt->second.find(spell.first);
                                if (spellItt != talItt->second.end())
                                {
                                    if (spellItt->second->CurrentRank > 0) {
                                        uint32 currentRank = spell.second->Ranks[spellItt->second->CurrentRank];

                                        if (auto spellInfo = sSpellMgr->GetSpellInfo(currentRank)) {
                                            for (auto rank : spell.second->Ranks) {
                                                if (currentRank != rank.second) {
                                                    player->removeSpell(rank.second, SPEC_MASK_ALL, false);
                                                }
                                                else {
                                                    if (!player->HasSpell(currentRank)) {
                                                        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                                                            if (spellInfo->Effects[i].Effect == SPELL_EFFECT_LEARN_SPELL)
                                                                player->learnSpell(spellInfo->Effects[i].TriggerSpell);

                                                        player->learnSpell(currentRank, spellInfo->IsPassive());
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                }
            }
            UpdateCharacterSpec(player, currentSpec);
            player->SendInitialSpells();
            player->AutoUnequipOffhandIfNeed();
        }
    }

    void ApplyActivePerks(Player* player)
    {
        ForgeCharacterSpec* currentSpec;

        if (TryGetCharacterActiveSpec(player, currentSpec))
        {
            for (int i = CharacterPerkType::ARCHETYPE; i < CharacterPerkType::MAX; i++)
                for (auto perk : currentSpec->perks[CharacterPerkType(i)]) {
                    auto currentRank = perk.second->spell->ranks[perk.second->rank];
                    auto spell = perk.second->spell;
                
                    if (auto spellInfo = sSpellMgr->GetSpellInfo(currentRank)) {
                        for (auto rank : spell->ranks)
                            if (currentRank != rank.second)
                                player->removeSpell(rank.second, SPEC_MASK_ALL, false);
                            else
                                if (!player->HasSpell(currentRank))
                                    player->learnSpell(currentRank, true);
                    }
                }   
        }
    }

    void RemoveActivePerks(Player* player) {
        ForgeCharacterSpec* currentSpec;

        if (TryGetCharacterActiveSpec(player, currentSpec))
        {
            for (int i = 1; i < CharacterPerkType::MAX; i++)
                for (auto perk : currentSpec->perks[CharacterPerkType(i)]) {
                    auto rankedSpell = perk.second->spell->ranks[perk.second->rank];
                    if (auto spellInfo = sSpellMgr->GetSpellInfo(rankedSpell)) {
                        player->removeSpell(rankedSpell, SPEC_MASK_ALL, false);
                    }
                }
        }
    }

    void RemoveTalents(Player* player) {
        ForgeCharacterSpec* currentSpec;
        if (TryGetCharacterActiveSpec(player, currentSpec))
        {
            for (auto charTabType : TALENT_POINT_TYPES)
            {
                if (ACCOUNT_WIDE_TYPE != charTabType && charTabType != CharacterPointType::TALENT_TREE && charTabType != RACIAL_TREE)
                    continue;

                std::list<ForgeTalentTab*> tabs;
                if (TryGetForgeTalentTabs(player, charTabType, tabs))
                    for (auto* tab : tabs)
                        for (auto spell : tab->Talents)
                            for (auto rank : spell.second->Ranks)
                                if (auto spellInfo = sSpellMgr->GetSpellInfo(rank.second))
                                    for (auto rank : spell.second->Ranks) {
                                        if (spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
                                            for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                                                player->removeSpell(spellInfo->Effects[i].TriggerSpell, SPEC_MASK_ALL, false);

                                        player->removeSpell(rank.second, SPEC_MASK_ALL, false);
                                        player->RemoveAura(rank.second);
                                    }
            }

            player->SendInitialSpells();
        }
    }

    ForgeCharacterPoint* GetMaxPointDefaults(CharacterPointType cpt)
    {
        auto fpd = MaxPointDefaults.find(cpt);

        // Get default skill max and current. Happens at level 10. Players start with 10 forge points. can be changed in DB with UINT_MAX entry.
        if (fpd == MaxPointDefaults.end())
        {
            ForgeCharacterPoint* fp = new ForgeCharacterPoint();
            fp->PointType = cpt;
            fp->SpecId = UINT_MAX;
            fp->Max = 0;
            fp->Sum = 0;

            return fp;
        }
        else
            return fpd->second;
    }

    void AddCharacterPointsToAllSpecs(Player* player, CharacterPointType pointType,  uint32 amount)
    {
        ForgeCharacterPoint* m = GetMaxPointDefaults(pointType);
        ForgeCharacterPoint* ccp = GetCommonCharacterPoint(player, pointType);

        if (m->Max > 0)
        {
            auto maxPoints = amount + ccp->Sum;

            if (maxPoints >= m->Max)
            {
                maxPoints = maxPoints - m->Max;
                amount = amount - maxPoints;
            }
        }

        if (amount > 0)
        {
            ccp->Sum += amount;
            UpdateCharPoints(player, ccp);

            if (pointType != ACCOUNT_WIDE_TYPE && pointType != CharacterPointType::PRESTIGE_COUNT)
                for (auto& spec : CharacterSpecs[player->GetGUID()])
                {
                    ForgeCharacterPoint* cp = GetSpecPoints(player, pointType, spec.first);
                    cp->Sum += amount;
                    UpdateCharPoints(player, cp);
                }

            ChatHandler(player->GetSession()).SendSysMessage("|cff8FCE00You have been awarded " + std::to_string(amount) + " " + GetpointTypeName(pointType) + " point(s).");
        }
    }

    std::string GetpointTypeName(CharacterPointType t)
    {
        switch (t)
        {
        case CharacterPointType::PRESTIGE_TREE:
            return "Prestige";
        case CharacterPointType::TALENT_TREE:
            return "Talent";
        case CharacterPointType::RACIAL_TREE:
            return "Racial";
        case CharacterPointType::FORGE_SKILL_TREE:
            return "Forge";
        default:
            return "";
        }
    }

    bool TryGetClassSpecilizations(Player* player, OUT std::vector<ClassSpecDetail*>& list)
    {
        auto raceItt = ClassSpecDetails.find(player->getRace());


        if (raceItt == ClassSpecDetails.end())
            return false;

        auto classItt = raceItt->second.find(player->getClass());

        if (classItt == raceItt->second.end())
            return false;

        list = classItt->second;
        return true;
    }

    void DeleteCharacter(ObjectGuid guid, uint32 accountId)
    {
        if (GetConfig("PermaDeleteForgecharacter", 0) == 1)
        {
            auto trans = CharacterDatabase.BeginTransaction();
            trans->Append("DELETE FROM forge_character_specs WHERE guid = {}", guid.GetCounter());
            trans->Append("DELETE FROM character_modes WHERE guid = {}", guid.GetCounter());
            trans->Append("DELETE FROM forge_character_points WHERE guid = {} AND spec != {}", guid.GetCounter(), ACCOUNT_WIDE_KEY);
            trans->Append("DELETE FROM forge_character_talents WHERE guid = {} AND spec != {}", guid.GetCounter(), ACCOUNT_WIDE_KEY);
            trans->Append("DELETE FROM forge_character_talents_spent WHERE guid = {} AND spec != {}", guid.GetCounter(), ACCOUNT_WIDE_KEY);
            trans->Append("DELETE FROM character_spec_perks WHERE guid = {}", guid.GetCounter());
            trans->Append("DELETE FROM character_perk_selection_queue WHERE guid = {}", guid.GetCounter());
            trans->Append("DELETE FROM character_prestige_perk_carryover WHERE guid = {}", guid.GetCounter());
            CharacterDatabase.CommitTransaction(trans);
        }
    }

    uint32 GetConfig(std::string key, uint32 defaultValue)
    {
        auto valItt = CONFIG.find(key);

        if (valItt == CONFIG.end())
        {
            auto trans = WorldDatabase.BeginTransaction();
            trans->Append("INSERT INTO forge_config (`cfgName`,`cfgValue`) VALUES ('{}',{})", key, defaultValue);
            WorldDatabase.CommitTransaction(trans);

            CONFIG[key] = defaultValue;
            return defaultValue;
        }

        return valItt->second;
    }


    bool isNumber(const std::string& s)
    {
        return std::ranges::all_of(s.begin(), s.end(), [](char c) { return isdigit(c) != 0; });
    }

    void UpdateCharacters(uint32 account, Player* player)
    {
        if (PlayerCharacterMap.find(account) != PlayerCharacterMap.end())
            PlayerCharacterMap.erase(account);

        QueryResult query = CharacterDatabase.Query("SELECT guid, account FROM characters where account = {}", account);

        if (!query)
            return;

        do
        {
            Field* field = query->Fetch();
            PlayerCharacterMap[field[1].Get<uint32>()].push_back(ObjectGuid::Create<HighGuid::Player>(field[0].Get<uint32>()));

        } while (query->NextRow());
    }

    ForgeCharacterPoint* CreateAccountBoundCharPoint(Player* player, const CharacterPointType& pt)
    {
        ForgeCharacterPoint* maxCp = GetMaxPointDefaults(pt);

        ForgeCharacterPoint* newFp = new ForgeCharacterPoint();
        newFp->Max = maxCp->Max;
        newFp->PointType = pt;
        newFp->SpecId = ACCOUNT_WIDE_KEY;
        newFp->Sum = 0;

        UpdateCharPoints(player, newFp);
        return newFp;
    }

    Perk* GetPerk(uint32 charClass, uint32 spellId, CharacterPerkType type)
    {
        Perk* perk = new Perk();
        perk->spellId = spellId;

        auto it = std::find_if(Perks[type][charClass].begin(), Perks[type][charClass].end(),
            [&spellId](Perk* perk) {return perk->spellId == spellId; });

        if (it != Perks[type][charClass].end())
            return *it;
        else
            return nullptr;
    }

    Perk* GetRandomPerk(Player* player, CharacterPerkType type)
    {
        std::random_device rd;
        std::mt19937 eng(rd());
        auto perks = Perks[type][player->getClass()];
        if (!perks.empty()) {
            std::uniform_int_distribution<> distr(0, perks.size() - 1);
            auto index = distr(eng);
            auto it = perks[index];
            return it;
        }
        return nullptr;
    }

    std::vector<Perk*> GetArchetypeForPlayer(Player* player) {
        return Archetypes[player->getClass()][player->GetLevel()];
    }

    bool perkEquals(Perk a, Perk b) {
        return a.spellId == b.spellId;
    }

    uint32 CountCharacterSpecPerkOccurences(Player* player, uint8 specId, CharacterPerkType type, Perk* perk)
    {
        ForgeCharacterSpec* charSpec;

        if (TryGetCharacterActiveSpec(player, charSpec)) {

            uint16 count = 0;

            auto perks = charSpec->perks[type];
            if (!perks.empty()) {
                auto csp = perks.find(perk->spellId);
                if (csp != perks.end())
                    count += csp->second->rank;
            }
            auto gp = charSpec->groupPerks.find(perk->groupId);
            if (gp != charSpec->groupPerks.end())
                count += 1;

            for (auto roll : charSpec->perkQueue[type])
                for (auto cperk : roll.second)
                    if (cperk->spell->spellId == perk->spellId)
                        count += 1;

            for (auto pp : charSpec->prestigePerks[type])
                if (pp->spell->spellId == perk->spellId)
                    count += 1;

            return count;
        }
        else
            return -1;
    }

    void InsertPerkSelection(Player* player, CharacterPerkType type, Perk* perk, std::string rollKey, uint8 carryover)
    {
        ForgeCharacterSpec* charSpec;

        if (TryGetCharacterActiveSpec(player, charSpec)) {

            CharacterDatabase.DirectExecute("INSERT INTO character_perk_selection_queue (`guid`, `specId`, `type`, `rollkey`, `spellId`) VALUES ({}, {}, {}, '{}', {} )",
                player->GetGUID().GetCounter(), charSpec->Id, type, rollKey, perk->spellId);

            CharacterSpecPerk* csp = new CharacterSpecPerk();
            csp->spell = perk;
            csp->uuid = rollKey;
            csp->rank = 1;
            csp->carryover = carryover;

            charSpec->perkQueue[type][rollKey].push_back(csp);
        }
    }

    void PrestigePerks(Player* player)
    {
        std::unordered_map<uint32, ForgeCharacterSpec*> charSpecs = CharacterSpecs.at(player->GetGUID());
        for (auto i : charSpecs) {
            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
            i.second->perkQueue.clear();
            i.second->prestigePerks.clear();
            trans->Append("delete from character_prestige_perk_carryover where `guid` = {} and specId = {}", player->GetGUID().GetCounter(), i.first);
            trans->Append("delete from character_perk_selection_queue where `guid` = {} and specId = {}", player->GetGUID().GetCounter(), i.first);

            for (int t = 1; t < CharacterPerkType::MAX; t++) {
                auto type = CharacterPerkType(t);
                for (auto perkMap : i.second->perks[type]) {
                    auto perk = perkMap.second;
                    for (auto j = 1; j <= perk->rank; j++) {
                        trans->Append("INSERT INTO character_prestige_perk_carryover (`guid`, `specId`, `type`, `uuid`, `spellId`, `rank`) VALUES ({} , {} , {} , '{}' , {} , {} )",
                            player->GetGUID().GetCounter(), i.first, type, perk->uuid, perk->spell->spellId, j);

                        CharacterSpecPerk* copy = new CharacterSpecPerk();
                        copy->uuid = perk->uuid;
                        copy->spell = perk->spell;
                        copy->rank = 1;
                        i.second->prestigePerks[type].push_back(copy);
                    }
                    PurgePerk(player, perk);
                }
            }
            trans->Append("DELETE FROM character_spec_perks WHERE `guid` = {} AND `specId` = {}",
                player->GetGUID().GetCounter(), i.first);
            CharacterDatabase.CommitTransaction(trans);
            i.second->perks.clear();
        }
    }

    CharacterSpecPerk* GetPrestigePerk(Player* player, CharacterPerkType type) {
        ForgeCharacterSpec* spec;
        if (TryGetCharacterActiveSpec(player, spec)) {
            if (spec->prestigePerks[type].size() > 0) {
                std::random_device rd;
                std::mt19937 eng(rd());
                std::uniform_int_distribution<> distr(0, spec->prestigePerks[type].size() - 1);
                auto index = distr(eng);
                auto it = spec->prestigePerks[type][index];

                CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
                trans->Append("DELETE FROM character_prestige_perk_carryover WHERE `guid` = {} AND `specId` = {} AND `uuid` = '{}' AND `spellId` = {} LIMIT 1"
                    , player->GetGUID().GetCounter(), spec->Id, it->uuid, it->spell->spellId, it->rank);
                CharacterDatabase.CommitTransaction(trans);
                spec->prestigePerks[type].erase(spec->prestigePerks[type].begin() + index);

                return it;
            }
            else
                return nullptr;
        }
    }

    bool PerkInQueue(ForgeCharacterSpec* spec, uint32 spellId, CharacterPerkType type)
    {
        std::string out;
        if (!spec->perkQueue[type].empty())
            for (auto perk : spec->perkQueue[type].begin()->second)
                if (perk->spell->spellId == spellId)
                    return true;

        return false;
    }

    void InsertNewPerksForLevelUp(Player* player, ForgeCharacterSpec* spec, CharacterPerkType type)
    {
        ForgeCharacterPoint* pp = GetCommonCharacterPoint(player, CharacterPointType::PRESTIGE_COUNT);
        bool prestiged = pp->Sum > 0;
        uint8 maxPerks = 3;

        auto roll = boost::uuids::random_generator()();
        auto rollKey = boost::lexical_cast<std::string>(roll);
        auto guid = player->GetGUID().GetCounter();

        switch (type) {
        case CharacterPerkType::ARCHETYPE: {
            auto choices = GetArchetypeForPlayer(player);
            if (!choices.empty())
                for (auto at : choices)
                    InsertPerkSelection(player, type, at, player->GetName() + std::to_string(player->GetLevel()), 0);

            break;
        }
        case CharacterPerkType::COMBAT: {
            if (prestiged && type != CharacterPerkType::ARCHETYPE) {
                CharacterSpecPerk* perk = GetPrestigePerk(player, type);
                if (perk != nullptr) {
                    InsertPerkSelection(player, type, perk->spell, rollKey, 1);
                    maxPerks--;
                }
            }

            do {
                Perk* possibility = GetRandomPerk(player, type);

                uint32 count = CountCharacterSpecPerkOccurences(player, player->GetActiveSpec(), type, possibility);
                if ((count != -1) && ((count < 3 && !possibility->isUnique) || (count == 0 && possibility->isUnique))
                    && std::find_if(spec->perkQueue[type][rollKey].begin(), spec->perkQueue[type][rollKey].end(),
                        [&possibility](CharacterSpecPerk* perk) {return perk->spell->spellId == possibility->spellId; }) == spec->perkQueue[type][rollKey].end())
                {
                    InsertPerkSelection(player, type, possibility, rollKey, 0);
                    maxPerks--;
                }
            } while (0 < maxPerks);
            break;
        }
        default:
            return;
        }
    }

    bool IsFlaggedReset(uint32 guid) {
        auto flagged = std::find(FlaggedForReset.begin(), FlaggedForReset.end(), guid);
        if (flagged != FlaggedForReset.end()) {
            return true;
        }
        return false;
    }

    void ClearResetFlag(uint32 guid) {
        FlaggedForReset.erase(std::remove(FlaggedForReset.begin(), FlaggedForReset.end(), guid), FlaggedForReset.end());
        auto trans = WorldDatabase.BeginTransaction();
        trans->Append("delete from forge_talent_flagged_reset where guid = {}", guid);
        WorldDatabase.CommitTransaction(trans);
    }

    std::vector<uint32> RACE_LIST;
    std::vector<uint32> CLASS_LIST;
    std::vector<CharacterPointType> TALENT_POINT_TYPES;

    // tabId
    std::unordered_map<uint32, ForgeTalentTab*> TalentTabs;
private:
    std::unordered_map<ObjectGuid, uint32> CharacterActiveSpecs;
    std::unordered_map<std::string, uint32> CONFIG;

    // charId, specId
    std::unordered_map<ObjectGuid, std::unordered_map<uint32, ForgeCharacterSpec*>> CharacterSpecs;
    std::unordered_map<uint32, ForgeCharacterSpec*> AccountWideCharacterSpecs;
    
    // charId, PointType, specid
    std::unordered_map<ObjectGuid, std::unordered_map<CharacterPointType, std::unordered_map<uint32, ForgeCharacterPoint*>>> CharacterPoints;
    std::unordered_map<CharacterPointType, ForgeCharacterPoint*> MaxPointDefaults;
    std::unordered_map < uint32, std::unordered_map<uint32, ForgeCharacterPoint*>> AccountWidePoints;
    // skillid
    std::unordered_map<uint32, uint32> SpellToTalentTabMap;

    // skillid
    std::unordered_map<uint32, uint32> TalentTabToSpellMap;
    std::unordered_map<CharacterPointType, std::unordered_set<uint32>> CharacterPointTypeToTalentTabIds;

    // Race, class, tabtype
    std::unordered_map<uint8, std::unordered_map<uint8, std::unordered_set<uint32>>> RaceAndClassTabMap;

    // Race, class
    std::unordered_map<uint8, std::unordered_map<uint8, std::vector<ClassSpecDetail*>>> ClassSpecDetails;

    std::unordered_map<uint32, std::vector<ObjectGuid>> PlayerCharacterMap;

    // Flagged for spec reset
    std::vector<uint32 /*guid*/> FlaggedForReset;

    // Perks
    std::unordered_map<CharacterPerkType, std::unordered_map<uint32 /*class*/, std::vector<Perk*>>> Perks;
    std::unordered_map<uint32 /*class*/, std::unordered_map<uint32 /*level*/, std::vector<Perk*>>> Archetypes;
    std::unordered_map<uint32 /*id*/, Perk*> AllPerks;


    void BuildForgeCache()
    {
        CharacterActiveSpecs.clear();
        CharacterSpecs.clear();
        CharacterPoints.clear();
        MaxPointDefaults.clear();
        SpellToTalentTabMap.clear();
        TalentTabToSpellMap.clear();
        TalentTabs.clear();
        RaceAndClassTabMap.clear();
        ClassSpecDetails.clear();
        PRESTIGE_IGNORE_SPELLS.clear();
        CONFIG.clear();
        CharacterPointTypeToTalentTabIds.clear();

        for (const auto& race : RACE_LIST)
        {
            for (const auto& wowClass : CLASS_LIST)
            {
                for (const auto& ptType : TALENT_POINT_TYPES)
                    RaceAndClassTabMap[race][wowClass];
            }
        }

        GetCharacters();
        GetConfig();
        AddTalentTrees();
        AddTalentsToTrees();
        AddTalentPrereqs();
        AddTalentExclusiveness();
        AddTalentRanks();
        AddTalentUnlearn();
        AddCharacterSpecs();
        AddPerks();
        AddPerkRanks();
        AddArchetypes();
        LOG_INFO("server.load", "Loading talents spent...");
        AddTalentSpent();
        LOG_INFO("server.load", "Loading character talents...");
        AddCharacterTalents();
        LOG_INFO("server.load", "Loading charcaters points...");
        AddCharacterPointsFromDB();
        LOG_INFO("server.load", "Loading characters class specs...");
        AddCharacterClassSpecs();
        AddCharacterPerks();
        AddCharacterQueuedPerks();
        AddCharacterPrestigePerks();
        LoadCharacterResetFlags();
    }

    void GetCharacters()
    {
        QueryResult query = CharacterDatabase.Query("SELECT guid, account FROM characters");

        if (!query)
            return;

        do
        {
            Field* field = query->Fetch();
            PlayerCharacterMap[field[1].Get<uint32>()].push_back(ObjectGuid::Create<HighGuid::Player>(field[0].Get<uint32>()));

        } while (query->NextRow());
    }

    void GetConfig()
    {
        QueryResult query = WorldDatabase.Query("SELECT * FROM forge_config");

        if (!query)
            return;

        do
        {
            Field* field = query->Fetch();
            CONFIG[field[0].Get<std::string>()] = field[1].Get<uint32>();

        } while (query->NextRow());
    }

    void GetMaxLevelQuests()
    {
        QueryResult query = WorldDatabase.Query("SELECT spellid FROM forge_prestige_ignored_spells");

        if (!query)
            return;

        do
        {
            Field* field = query->Fetch();
            PRESTIGE_IGNORE_SPELLS.push_back(field[0].Get<uint32>());

        } while (query->NextRow());
    }

    void UpdateForgeSpecInternal(Player* player, CharacterDatabaseTransaction& trans, ForgeCharacterSpec*& spec)
    {
        ObjectGuid charId = player->GetGUID();
        uint32 actId = player->GetSession()->GetAccountId();
        CharacterSpecs[charId][spec->Id] = spec;

        // check for account wide info, apply to other specs for all other characters of the account in the cache.
        for (auto& actChr : PlayerCharacterMap[actId])
            for (auto& sp : CharacterSpecs[actChr])
            {
                for (auto& ts : spec->PointsSpent)
                {
                    if (TalentTabs[ts.first]->TalentType == ACCOUNT_WIDE_TYPE)
                        CharacterSpecs[charId][sp.first]->PointsSpent[ts.first] = spec->PointsSpent[ts.first];
                }

                for (auto& tals : spec->Talents)
                {
                    if (TalentTabs[tals.first]->TalentType == ACCOUNT_WIDE_TYPE)
                        for (auto& tal : tals.second)
                            sp.second->Talents[tals.first][tal.first] = tal.second;
                }
            }

        auto activeSpecItt = CharacterActiveSpecs.find(charId);

        if (activeSpecItt != CharacterActiveSpecs.end() && spec->Active && activeSpecItt->second != spec->Id)
        {
            ForgeCharacterSpec* activeSpec;
            if (TryGetCharacterSpec(player, activeSpecItt->second, activeSpec))
            {
                activeSpec->Active = false;
                AddCharSpecUpdateToTransaction(actId, trans, activeSpec);
            }
        }

        if (spec->Active)
            CharacterActiveSpecs[charId] = spec->Id;

        AddCharSpecUpdateToTransaction(actId, trans, spec);
    }

    void AddCharSpecUpdateToTransaction(uint32 accountId, CharacterDatabaseTransaction& trans, ForgeCharacterSpec*& spec)
    {
        auto guid = spec->CharacterGuid.GetCounter();
        trans->Append("INSERT INTO `forge_character_specs` (`id`,`guid`,`name`,`description`,`active`,`spellicon`,`visability`,`charSpec`) VALUES ({},{},\"{}\",\"{}\",{},{},{},{}) ON DUPLICATE KEY UPDATE `name` = \"{}\", `description` = \"{}\", `active` = {}, `spellicon` = {}, `visability` = {}, `charSpec` = {}",
            spec->Id, guid, spec->Name, spec->Description, spec->Active, spec->SpellIconId, (int)spec->Visability, spec->CharacterSpecTabId,
            spec->Name, spec->Description, spec->Active, spec->SpellIconId, (int)spec->Visability, spec->CharacterSpecTabId);

        for (auto& kvp : spec->PointsSpent)
        {
            if(TalentTabs[kvp.first]->TalentType != ACCOUNT_WIDE_TYPE)
                trans->Append("INSERT INTO forge_character_talents_spent(`guid`,`spec`,`tabid`,`spent`) VALUES({}, {}, {}, {}) ON DUPLICATE KEY UPDATE spent = {}",
                    guid, spec->Id, kvp.first, kvp.second,
                    kvp.second);
            else
                trans->Append("INSERT INTO forge_character_talents_spent(`guid`,`spec`,`tabid`,`spent`) VALUES({}, {}, {}, {}) ON DUPLICATE KEY UPDATE spent = {}",
                    accountId, ACCOUNT_WIDE_KEY, kvp.first, kvp.second,
                    kvp.second);
        }
    }

    void UpdateChacterTalentInternal(uint32 account, uint32 charId, CharacterDatabaseTransaction& trans, uint32 spec, uint32 spellId, uint32 tabId, uint8 known)
    {
        if (TalentTabs[tabId]->TalentType != ACCOUNT_WIDE_TYPE) {
            trans->Append("INSERT INTO `forge_character_talents` (`guid`,`spec`,`spellid`,`tabId`,`currentrank`) VALUES ({},{},{},{},{}) ON DUPLICATE KEY UPDATE `currentrank` = {}", charId, spec, spellId, tabId, known, known);
            trans->Append("DELETE FROM `forge_character_talents` WHERE `guid` = {} and `spec` = {} and `currentRank` = 0", charId, spec);
        }
        else
            trans->Append("INSERT INTO `forge_character_talents` (`guid`,`spec`,`spellid`,`tabId`,`currentrank`) VALUES ({},{},{},{},{}) ON DUPLICATE KEY UPDATE `currentrank` = {}", account, ACCOUNT_WIDE_KEY, spellId, tabId, known, known);
    }

    void ForgetCharacterPerkInternal(uint32 charId, uint32 spec, uint32 spellId) {
        // TODO trans->Append("DELETE FROM character_perks WHERE spellId = {} and specId = {}", spellId, spec);
    }

    void AddPerkRanks()
    {
        LOG_INFO("server.load", "Loading perk ranks...");
        QueryResult perkRanks = WorldDatabase.Query("SELECT * FROM `acore_world`.`perk_ranks`");
        do
        {
            Field* perkFields = perkRanks->Fetch();
            auto perkId = perkFields[0].Get<uint32>();
            auto rank = perkFields[1].Get<uint32>();
            auto spellId = perkFields[2].Get<uint32>();

            AllPerks[perkId]->ranks[rank] = spellId;
            AllPerks[perkId]->ranksRev[spellId] = rank;
        } while (perkRanks->NextRow());
    }

    void AddPerks()
    {
        LOG_INFO("server.load", "Loading all perks...");
        QueryResult perks = WorldDatabase.Query("SELECT * FROM perks ORDER BY `allowableClass` ASC");
        do
        {
            Field* perkFields = perks->Fetch();
            Perk* newPerk = new Perk();
            newPerk->spellId = perkFields[0].Get<uint32>();
            newPerk->isUnique = perkFields[1].Get<int>() == 0 ? false : true;
            newPerk->allowableClass = perkFields[2].Get<int>();
            newPerk->isPermanent = perkFields[3].Get<int>() == 0 ? false : true;
            newPerk->chance = perkFields[4].Get<uint8>();
            newPerk->category = perkFields[5].Get<uint8>();
            newPerk->isAura = perkFields[6].Get<int>() == 0 ? false : true;
            newPerk->groupId = perkFields[7].Get<int>();
            newPerk->tags = perkFields[8].Get<std::string>();

            auto val = newPerk->allowableClass;
            auto type = CharacterPerkType(newPerk->category);
            if (val > 0) {
                if (val & (1 << (CLASS_WARRIOR - 1)))
                    Perks[type][CLASS_WARRIOR].push_back(newPerk);

                if (val & (1 << (CLASS_PALADIN - 1)))
                    Perks[type][CLASS_PALADIN].push_back(newPerk);

                if (val & (1 << (CLASS_HUNTER - 1)))
                    Perks[type][CLASS_HUNTER].push_back(newPerk);

                if (val & (1 << (CLASS_ROGUE - 1)))
                    Perks[type][CLASS_ROGUE].push_back(newPerk);

                if (val & (1 << (CLASS_PRIEST - 1)))
                    Perks[type][CLASS_PRIEST].push_back(newPerk);

                if (val & (1 << (CLASS_DEATH_KNIGHT - 1)))
                    Perks[type][CLASS_DEATH_KNIGHT].push_back(newPerk);

                if (val & (1 << (CLASS_SHAMAN - 1)))
                    Perks[type][CLASS_SHAMAN].push_back(newPerk);

                if (val & (1 << (CLASS_MAGE - 1)))
                    Perks[type][CLASS_MAGE].push_back(newPerk);

                if (val & (1 << (CLASS_WARLOCK - 1)))
                    Perks[type][CLASS_WARLOCK].push_back(newPerk);

                if (val & (1 << (CLASS_DRUID - 1)))
                    Perks[type][CLASS_DRUID].push_back(newPerk);
            } else {
                Perks[type][CLASS_WARRIOR].push_back(newPerk);
                Perks[type][CLASS_PALADIN].push_back(newPerk);
                Perks[type][CLASS_HUNTER].push_back(newPerk);
                Perks[type][CLASS_ROGUE].push_back(newPerk);
                Perks[type][CLASS_PRIEST].push_back(newPerk);
                Perks[type][CLASS_DEATH_KNIGHT].push_back(newPerk);
                Perks[type][CLASS_SHAMAN].push_back(newPerk);
                Perks[type][CLASS_MAGE].push_back(newPerk);
                Perks[type][CLASS_WARLOCK].push_back(newPerk);
                Perks[type][CLASS_DRUID].push_back(newPerk);
            }

            AllPerks[newPerk->spellId] = newPerk;
        } while (perks->NextRow());
    }

    void AddArchetypes()
    {
        LOG_INFO("server.load", "Loading archetypes...");

        QueryResult archetypes = WorldDatabase.Query("SELECT * FROM archetype ORDER BY `allowableClass` ASC");
        do
        {
            Field* archetypeFields = archetypes->Fetch();
            auto allowableClass = archetypeFields[0].Get<int>();
            auto level = archetypeFields[1].Get<uint32>();
            auto role = archetypeFields[2].Get<uint8>();
            auto perkId = archetypeFields[3].Get<uint32>();
            auto isSpell = archetypeFields[4].Get<int>() == 0 ? false : true;

            if (allowableClass & (1 << (CLASS_WARRIOR - 1)))
                Archetypes[CLASS_WARRIOR][level].push_back(GetPerk(CLASS_WARRIOR, perkId, CharacterPerkType::ARCHETYPE));

            if (allowableClass & (1 << (CLASS_PALADIN - 1)))
                Archetypes[CLASS_PALADIN][level].push_back(GetPerk(CLASS_PALADIN, perkId, CharacterPerkType::ARCHETYPE));

            if (allowableClass & (1 << (CLASS_HUNTER - 1)))
                Archetypes[CLASS_HUNTER][level].push_back(GetPerk(CLASS_HUNTER, perkId, CharacterPerkType::ARCHETYPE));

            if (allowableClass & (1 << (CLASS_ROGUE - 1)))
                Archetypes[CLASS_ROGUE][level].push_back(GetPerk(CLASS_ROGUE, perkId, CharacterPerkType::ARCHETYPE));

            if (allowableClass & (1 << (CLASS_PRIEST - 1)))
                Archetypes[CLASS_PRIEST][level].push_back(GetPerk(CLASS_PRIEST, perkId, CharacterPerkType::ARCHETYPE));

            if (allowableClass & (1 << (CLASS_DEATH_KNIGHT - 1)))
                Archetypes[CLASS_DEATH_KNIGHT][level].push_back(GetPerk(CLASS_DEATH_KNIGHT, perkId, CharacterPerkType::ARCHETYPE));

            if (allowableClass & (1 << (CLASS_SHAMAN - 1)))
                Archetypes[CLASS_SHAMAN][level].push_back(GetPerk(CLASS_SHAMAN, perkId, CharacterPerkType::ARCHETYPE));

            if (allowableClass & (1 << (CLASS_MAGE - 1)))
                Archetypes[CLASS_MAGE][level].push_back(GetPerk(CLASS_MAGE, perkId, CharacterPerkType::ARCHETYPE));

            if (allowableClass & (1 << (CLASS_WARLOCK - 1)))
                Archetypes[CLASS_WARLOCK][level].push_back(GetPerk(CLASS_WARLOCK, perkId, CharacterPerkType::ARCHETYPE));

            if (allowableClass & (1 << (CLASS_DRUID - 1)))
                Archetypes[CLASS_DRUID][level].push_back(GetPerk(CLASS_DRUID, perkId, CharacterPerkType::ARCHETYPE));

        } while (archetypes->NextRow());
    }

    void AddTalentTrees()
    {
        QueryResult talentTab = WorldDatabase.Query("SELECT * FROM forge_talent_tabs");

        if (!talentTab)
            return;

        do
        {
            Field* talentFields = talentTab->Fetch();
            ForgeTalentTab* newTab = new ForgeTalentTab();
            newTab->Id = talentFields[0].Get<uint32>();
            newTab->ClassMask = talentFields[1].Get<uint32>();
            newTab->RaceMask = talentFields[2].Get<uint32>();
            newTab->Name = talentFields[3].Get<std::string>();
            newTab->SpellIconId = talentFields[4].Get<uint32>();
            newTab->Background = talentFields[5].Get<std::string>();
            newTab->TalentType = (CharacterPointType)talentFields[6].Get<uint8>();
            newTab->TabIndex = talentFields[7].Get<uint32>();

            for (auto& race : RaceAndClassTabMap)
            {
                auto bit = (newTab->RaceMask & (1 << (race.first - 1)));

                if (newTab->RaceMask != 0 && bit == 0)
                    continue;

                for (const auto& wowClass : race.second)
                {
                    auto classBit = (newTab->ClassMask & (1 << (wowClass.first - 1)));

                    if (classBit != 0 || newTab->ClassMask == 0)
                    {
                        RaceAndClassTabMap[race.first][wowClass.first].insert(newTab->Id);
                        SpellToTalentTabMap[newTab->SpellIconId] = newTab->Id;
                        TalentTabToSpellMap[newTab->Id] = newTab->SpellIconId;
                        CharacterPointTypeToTalentTabIds[newTab->TalentType].insert(newTab->Id);
                    }
                }
            }

            TalentTabs[newTab->Id] = newTab;
        } while (talentTab->NextRow());

    }

    void AddTalentsToTrees()
    {
        QueryResult talents = WorldDatabase.Query("SELECT * FROM forge_talents");

        if (!talents)
            return;

        do
        {
            Field* talentFields = talents->Fetch();
            ForgeTalent* newTalent = new ForgeTalent();
            newTalent->SpellId = talentFields[0].Get<uint32>();
            newTalent->TalentTabId = talentFields[1].Get<uint32>();
            newTalent->ColumnIndex = talentFields[2].Get<uint32>();
            newTalent->RowIndex = talentFields[3].Get<uint32>();
            newTalent->RankCost = talentFields[4].Get<uint8>();
            newTalent->RequiredLevel = talentFields[5].Get<uint8>();
            newTalent->TalentType = (CharacterPointType)talentFields[6].Get<uint8>();
            newTalent->NumberOfRanks = talentFields[7].Get<uint8>();
            newTalent->PreReqType = (PereqReqirementType)talentFields[8].Get<uint8>();
            newTalent->TabPointReq = talentFields[9].Get<uint16>();

            auto tabItt = TalentTabs.find(newTalent->TalentTabId);

            if (tabItt == TalentTabs.end())
            {
                LOG_ERROR("FORGE.ForgeCache", "Error loading talents, invalid tab id: " + std::to_string(newTalent->TalentTabId));
            }
            else
                tabItt->second->Talents[newTalent->SpellId] = newTalent;

        } while (talents->NextRow());
    }

    void AddTalentPrereqs()
    {
        QueryResult preReqTalents = WorldDatabase.Query("SELECT * FROM forge_talent_prereq");

        if (!preReqTalents)
            return;

        do
        {
            Field* talentFields = preReqTalents->Fetch();
            ForgeTalentPrereq* newTalent = new ForgeTalentPrereq();
            newTalent->reqId = talentFields[0].Get<uint32>();
            newTalent->Talent = talentFields[3].Get<uint32>();
            newTalent->TalentTabId = talentFields[4].Get<uint32>();
            newTalent->RequiredRank = talentFields[5].Get<uint32>();
            
            ForgeTalent* lt = TalentTabs[talentFields[2].Get<uint32>()]->Talents[talentFields[1].Get<uint32>()];

            if (lt != nullptr)
            {
                lt->Prereqs.push_back(newTalent);
            }
            else
            {
                LOG_ERROR("FORGE.ForgeCache", "Error loading AddTalentPrereqs, invalid req id: " + std::to_string(newTalent->reqId));
            }

        } while (preReqTalents->NextRow());
    }

    void AddTalentExclusiveness()
    {
        QueryResult exclTalents = WorldDatabase.Query("SELECT * FROM forge_talent_exclusive");

        if (!exclTalents)
            return;

        do
        {
            Field* talentFields = exclTalents->Fetch();
            uint32 spellId = talentFields[0].Get<uint32>();
            uint32 talentTabId = talentFields[1].Get<uint32>();
            uint32 exclusiveSpellId = talentFields[2].Get<uint32>();

            ForgeTalent* lt = TalentTabs[talentTabId]->Talents[spellId];
            if (lt != nullptr)
            {
                lt->ExclusiveWith.push_back(exclusiveSpellId);
            }
            else
            {
                LOG_ERROR("FORGE.ForgeCache", "Error loading AddTalentExclusiveness, invalid exclusiveSpellId id: " + std::to_string(exclusiveSpellId));
            }

        } while (exclTalents->NextRow());
    }

    void AddTalentRanks()
    {
        QueryResult talentRanks = WorldDatabase.Query("SELECT * FROM forge_talent_ranks");

        if (!talentRanks)
            return;

        do
        {
            Field* talentFields = talentRanks->Fetch();
            uint32 talentspellId = talentFields[0].Get<uint32>();
            uint32 talentTabId = talentFields[1].Get<uint32>();
            uint32 rank = talentFields[2].Get<uint32>();
            uint32 spellId = talentFields[3].Get<uint32>();

            ForgeTalent* lt = TalentTabs[talentTabId]->Talents[talentspellId];

            if (lt != nullptr)
            {
                lt->Ranks[rank] = spellId;
                lt->RanksRev[spellId] = rank;
            }
            else
            {
                LOG_ERROR("FORGE.ForgeCache", "Error loading AddTalentRanks, invalid talentTabId id: " + std::to_string(talentTabId) + " Rank: " + std::to_string(rank) + " SpellId: " + std::to_string(spellId));
            }

        } while (talentRanks->NextRow());
    }

    void AddTalentUnlearn()
    {
        QueryResult exclTalents = WorldDatabase.Query("SELECT * FROM forge_talent_unlearn");

        if (!exclTalents)
            return;

        do
        {
            Field* talentFields = exclTalents->Fetch();
            uint32 spellId = talentFields[1].Get<uint32>();
            uint32 talentTabId = talentFields[0].Get<uint32>();
            uint32 exclusiveSpellId = talentFields[2].Get<uint32>();

            ForgeTalent* lt = TalentTabs[talentTabId]->Talents[spellId];

            if (lt != nullptr)
            {
                lt->UnlearnSpells.push_back(exclusiveSpellId);
            }
            else
            {
                LOG_ERROR("FORGE.ForgeCache", "Error loading AddTalentUnlearn, invalid talentTabId id: " + std::to_string(talentTabId) + " ExclusiveSpell: " + std::to_string(exclusiveSpellId) + " SpellId: " + std::to_string(spellId));
            }

        } while (exclTalents->NextRow());
    }

    void AddCharacterSpecs()
    {
        QueryResult charSpecs = CharacterDatabase.Query("SELECT * FROM forge_character_specs");

        if (!charSpecs)
            return;
        
        do
        {
            Field* specFields = charSpecs->Fetch();
            ForgeCharacterSpec* spec = new ForgeCharacterSpec();
            spec->Id = specFields[0].Get<uint32>();
            spec->CharacterGuid = ObjectGuid::Create<HighGuid::Player>(specFields[1].Get<uint32>());
            spec->Name = specFields[2].Get<std::string>();
            spec->Description = specFields[3].Get<std::string>();
            spec->Active = specFields[4].Get<bool>();
            spec->SpellIconId = specFields[5].Get<uint32>();
            spec->Visability = (SpecVisibility)specFields[6].Get<uint8>();
            spec->CharacterSpecTabId = specFields[7].Get<uint32>();
            spec->ArchetypalRole = specFields[8].Get<uint8>();

            if (spec->Active)
                CharacterActiveSpecs[spec->CharacterGuid] = spec->Id;

            CharacterSpecs[spec->CharacterGuid][spec->Id] = spec;
        } while (charSpecs->NextRow());
    }

    void AddTalentSpent()
    {
        QueryResult exclTalents = CharacterDatabase.Query("SELECT * FROM forge_character_talents_spent");

        if (!exclTalents)
            return;

        do
        {
            Field* talentFields = exclTalents->Fetch();
            uint32 id = talentFields[0].Get<uint32>();
            uint32 spec = talentFields[1].Get<uint32>();
            uint32 tabId = talentFields[2].Get<uint32>();

            if (spec != ACCOUNT_WIDE_KEY)
            {
                ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>(id);
               
                CharacterSpecs[guid][spec]->PointsSpent[tabId] = talentFields[3].Get<uint8>();
            }
            else
            {
                auto aws = AccountWideCharacterSpecs.find(id);
                

                if (aws == AccountWideCharacterSpecs.end())
                    AccountWideCharacterSpecs[id] = new ForgeCharacterSpec();

                AccountWideCharacterSpecs[id]->PointsSpent[tabId] = talentFields[3].Get<uint8>();

                for (auto& ch : PlayerCharacterMap[id])
                    for (auto& spec : CharacterSpecs[ch])
                        spec.second->PointsSpent[tabId] = talentFields[3].Get<uint8>();
            }

        } while (exclTalents->NextRow());
    }

    void AddCharacterTalents()
    {
        QueryResult talentsQuery = CharacterDatabase.Query("SELECT * FROM forge_character_talents");

        if (!talentsQuery)
            return;

        do
        {
            Field* talentFields = talentsQuery->Fetch();
            uint32 id = talentFields[0].Get<uint32>();
            ObjectGuid characterGuid = ObjectGuid::Create<HighGuid::Player>(id);
            uint32 specId = talentFields[1].Get<uint32>();
            ForgeCharacterTalent* talent = new ForgeCharacterTalent();
            talent->SpellId = talentFields[2].Get<uint32>();
            talent->TabId = talentFields[3].Get<uint32>();
            talent->CurrentRank = talentFields[4].Get<uint8>();

            if (specId != ACCOUNT_WIDE_KEY)
            {
                ForgeTalent* ft = TalentTabs[talent->TabId]->Talents[talent->SpellId];
                ForgeCharacterSpec* spec = CharacterSpecs[characterGuid][specId];

                spec->Talents[talent->TabId][talent->SpellId] = talent;
            }
            else
            {
                AccountWideCharacterSpecs[id]->Talents[talent->TabId][talent->SpellId] = talent;

                for (auto& ch : PlayerCharacterMap[id])
                    for (auto& spec : CharacterSpecs[ch])
                    {
                        ForgeTalent* ft = TalentTabs[talent->TabId]->Talents[talent->SpellId];
                        spec.second->Talents[talent->TabId][talent->SpellId] = talent;
                    }
            }

        } while (talentsQuery->NextRow());
    }

    void AddCharacterPerks()
    {
        LOG_INFO("server.load", "Loading character perks...");
        QueryResult perkQuery = CharacterDatabase.Query("SELECT A.* ,c.class FROM `character_spec_perks` A join `characters` c on A.guid = c.guid");
        if (!perkQuery) return;

        do {
            Field* perkFields = perkQuery->Fetch();
            uint32 guid = perkFields[0].Get<uint64>();
            ObjectGuid characterGuid = ObjectGuid::Create<HighGuid::Player>(guid);
            uint8 specId = perkFields[1].Get<uint8>();
            uint8 type = perkFields[2].Get<uint8>();
            std::string uuid = perkFields[3].Get<std::string>();
            uint32 spellId = perkFields[4].Get<uint32>();
            uint8 rank = perkFields[5].Get<uint8>();
            uint32 classMask = perkFields[6].Get<uint32>();

            CharacterSpecPerk* perk = new CharacterSpecPerk();
            Perk* copy = GetPerk(classMask, spellId, CharacterPerkType(type));
            perk->spell = copy;
            perk->rank = rank;
            perk->uuid = uuid;

            ForgeCharacterSpec* spec = CharacterSpecs[characterGuid][specId];

            spec->perks[CharacterPerkType(type)][spellId] = perk;

            if (copy->groupId > 0)
                spec->groupPerks[copy->groupId] = copy;
        } while (perkQuery->NextRow());
    }

    void AddCharacterQueuedPerks()
    {
        LOG_INFO("server.load", "Loading character perk queues...");
        QueryResult queueQuery = CharacterDatabase.Query("SELECT A.*, c.class FROM character_perk_selection_queue A join `characters` c WHERE A.guid = c.guid");
        if (!queueQuery) return;

        do {
            Field* selectionFields = queueQuery->Fetch();
            uint32 guid = selectionFields[0].Get<uint64>();
            ObjectGuid characterGuid = ObjectGuid::Create<HighGuid::Player>(guid);
            uint8 specId = selectionFields[1].Get<uint8>();
            uint8 type = selectionFields[2].Get<uint8>();
            std::string rollKey = selectionFields[3].Get<std::string>();
            uint32 spellId = selectionFields[4].Get<uint32>();
            uint32 classMask = selectionFields[5].Get<uint32>();

            CharacterSpecPerk* perk = new CharacterSpecPerk();
            Perk* copy = GetPerk(classMask, spellId, CharacterPerkType(type));
            perk->spell = copy;
            perk->rank = 1;
            perk->uuid = rollKey;

            ForgeCharacterSpec* spec = CharacterSpecs[characterGuid][specId];
            spec->perkQueue[CharacterPerkType(type)][rollKey].push_back(perk);
            if (copy->groupId > 0)
                spec->groupPerks[copy->groupId] = copy;
        } while (queueQuery->NextRow());
    }

    void AddCharacterPrestigePerks()
    {
        LOG_INFO("server.load", "Loading character prestige perks...");
        QueryResult prestigeQuery = CharacterDatabase.Query("SELECT A.*, c.class FROM character_prestige_perk_carryover A join acore_characters.`characters` c where A.guid  = c.guid");
        if (!prestigeQuery) return;

        do {
            Field* perkFields = prestigeQuery->Fetch();
            uint32 guid = perkFields[0].Get<uint64>();
            ObjectGuid characterGuid = ObjectGuid::Create<HighGuid::Player>(guid);
            uint8 specId = perkFields[1].Get<uint8>();
            uint8 type = perkFields[2].Get<uint8>();
            std::string uuid = perkFields[3].Get<std::string>();
            uint32 spellId = perkFields[4].Get<uint32>();
            uint8 rank = perkFields[5].Get<uint32>();
            uint32 pClass = perkFields[6].Get<uint32>();

            CharacterSpecPerk* perk = new CharacterSpecPerk();
            perk->spell = GetPerk(pClass, spellId, CharacterPerkType::COMBAT);
            perk->uuid = uuid;
            perk->rank = 1;

            ForgeCharacterSpec* spec = CharacterSpecs[characterGuid][specId];
            spec->prestigePerks[CharacterPerkType(type)].push_back(perk);
        } while (prestigeQuery->NextRow());
    }

    void AddCharacterPointsFromDB()
    {
        QueryResult pointsQuery = CharacterDatabase.Query("SELECT * FROM forge_character_points");

        if (!pointsQuery)
            return;
        uint32 almostMax = UINT_MAX - 1;

        do
        {
            Field* pointsFields = pointsQuery->Fetch();
            uint32 guid = pointsFields[0].Get<uint32>();
            CharacterPointType pt = (CharacterPointType)pointsFields[1].Get<uint8>();
            ForgeCharacterPoint* cp = new ForgeCharacterPoint();
            cp->PointType = pt;
            cp->SpecId = pointsFields[2].Get<uint32>();
            cp->Sum = pointsFields[3].Get<uint32>();
            cp->Max = pointsFields[4].Get<uint32>();

            if (guid == UINT_MAX)
            {
                MaxPointDefaults[pt] = cp;
            }
            else
            {
                if (cp->SpecId == ACCOUNT_WIDE_KEY)
                {
                    AccountWidePoints[guid][pt] = cp;

                    for (auto& ch : PlayerCharacterMap[guid])
                        for (auto& spec : CharacterSpecs[ch])
                            CharacterPoints[ch][cp->PointType][spec.first] = cp;
                        
                }
                else
                {
                    ObjectGuid og = ObjectGuid::Create<HighGuid::Player>(guid);
                    CharacterPoints[og][cp->PointType][cp->SpecId] = cp;
                }
            }
            
        } while (pointsQuery->NextRow());
    }


    void LoadCharacterResetFlags()
    {
        QueryResult flags = WorldDatabase.Query("select guid from forge_talent_flagged_reset order by guid asc");
        if (!flags)
            return;

        do
        {
            Field* flagField = flags->Fetch();
            uint32 guid = flagField[0].Get<uint32>();

            FlaggedForReset.push_back(guid);
        } while (flags->NextRow());
    }

    void AddCharacterClassSpecs()
    {
       /* QueryResult specsQuery = WorldDatabase.Query("SELECT sl.DisplayName_Lang_enUS as specName, sl.SpellIconID as specIcon, src.ClassMask, src.RaceMask, sl.id FROM acore_world.db_SkillLine_12340 sl LEFT JOIN acore_world.db_SkillRaceClassInfo_12340 src ON src.SkillID = sl.id WHERE sl.CategoryID = 7 AND ClassMask IS NOT NULL AND sl.SpellIconID != 1 AND sl.SpellIconID != 0 order by src.ClassMask asc, sl.DisplayName_Lang_enUS asc");


        if (!specsQuery)
            return;

        do
        {
            Field* spec = specsQuery->Fetch();
            ClassSpecDetail* cs = new ClassSpecDetail();
            cs->Name = spec[0].Get<std::string>();
            cs->SpellIconId = spec[1].Get<uint32>();
            cs->SpecId = spec[4].Get<uint32>();

            uint32 classMask = spec[2].Get<uint32>();
            std::string raceMMask = spec[3].Get<std::string>();

            if (raceMMask == "-1")
            {
                for (const auto& race : RACE_LIST)
                    ClassSpecDetails[race][classMask].push_back(cs);
            }
            else
            {
                ClassSpecDetails[static_cast<uint32_t>(std::stoul(raceMMask))][classMask].push_back(cs);
            }

        } while (specsQuery->NextRow());*/
    }

    std::string FindRollKey(ForgeCharacterSpec* spec, std::string uuid)
    {
        std::string out = "NONE";
        for (auto roll : spec->perkQueue[CharacterPerkType::COMBAT])
            for (auto perk : roll.second)
                if (perk->uuid == uuid)
                    out = roll.first;
        return out;
    }

    void PurgePerk(Player* player, CharacterSpecPerk* perk)
    {
        for (auto rank : AllPerks[perk->spell->spellId]->ranksRev) {
            auto spellId = rank.first;
            player->removeSpell(spellId, SPEC_MASK_ALL, false);
        }
    }
};

#define sForgeCache ForgeCache::get_instance()
