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
    // TabId, Spellid
    std::unordered_map<uint32, std::unordered_map<uint32, ForgeCharacterTalent*>> Talents;
    // tabId
    std::unordered_map<uint32, uint8> PointsSpent;
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

// XMOG
struct ForgeCharacaterXmog
{
    std::string name;
    std::unordered_map<uint8, uint32> slottedItems;
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
        if (ACCOUNT_WIDE_TYPE == pointType)
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
        if (pointType != ACCOUNT_WIDE_TYPE)
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
            if (ACCOUNT_WIDE_TYPE == pt)
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
        bool isNotAccountWide = ACCOUNT_WIDE_TYPE != fp->PointType;

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

    void ApplyAccountBoundTalents(Player* player)
    {
        ForgeCharacterSpec* currentSpec;

        if (TryGetCharacterActiveSpec(player, currentSpec))
        {
            uint32 playerLevel = player->getLevel();
            auto modes = Gamemode::GetGameMode(player);

            for (auto charTabType : TALENT_POINT_TYPES)
            {
                if (ACCOUNT_WIDE_TYPE != charTabType)
                    continue;

                std::list<ForgeTalentTab*> tabs;
                if (TryGetForgeTalentTabs(player, charTabType, tabs))
                    for (auto* tab : tabs)
                    {
                        auto talItt = currentSpec->Talents.find(tab->Id);

                        for (auto spell : tab->Talents)
                        {

                            if (playerLevel != 80 && modes.size() == 0 && talItt != currentSpec->Talents.end())
                            {
                                auto spellItt = talItt->second.find(spell.first);

                                if (spellItt != talItt->second.end())
                                {
                                    uint32 currentRank = spell.second->Ranks[spellItt->second->CurrentRank];

                                    for (auto rank : spell.second->Ranks)
                                        if (currentRank != rank.second)
                                            player->removeSpell(rank.second, SPEC_MASK_ALL, false);

                                    if (!player->HasSpell(currentRank))
                                        player->learnSpell(currentRank, false, false);
                                }
                            }
                        }
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

            if (cpt == CharacterPointType::FORGE_SKILL_TREE)
                fp->Sum = GetConfig("level10ForgePoints", 30);
            else
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

            if (pointType != ACCOUNT_WIDE_TYPE)
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


    std::string BuildXmogSetsMsg(Player* player) {
        std::string out = "";

        auto sets = XmogSets.find(player->GetGUID().GetCounter());
        if (sets != XmogSets.end())
            for (auto set : sets->second)
                out += std::to_string(set.first) + "^" + set.second->name + ";";
        else
            out += "empty";

        return out;
    }

    void SaveXmogSet(Player* player, uint32 setId) {
        auto sets = XmogSets.find(player->GetGUID().GetCounter());
        if (sets != XmogSets.end()) {
            auto set = sets->second.find(setId);
            if (set != sets->second.end()) {
                for (int i : xmogSlots)
                    if (auto item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                        set->second->slottedItems[i] = item->GetTransmog();
                    else
                        set->second->slottedItems[i] = 0;

                SaveXmogSetInternal(player, setId, set->second);
            }
        }
    }

    void AddXmogSet(Player* player, uint32 setId, std::string name) {
        ForgeCharacaterXmog* xmog = new ForgeCharacaterXmog();
        xmog->name = name;

        auto newSetId = FirstOpenXmogSlot(player);

        for (int i : xmogSlots)
            if (auto item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                xmog->slottedItems[i] = item->GetTransmog();
            else
                xmog->slottedItems[i] = 0;

        XmogSets[player->GetGUID().GetCounter()][newSetId] = xmog;
        SaveXmogSetInternal(player, newSetId, xmog);
    }

    std::string BuildXmogFromEquipped(Player* player) {
        std::string out = "noname^";
        for (auto slot : xmogSlots) {
            auto item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
            out += item == nullptr ? "0^" : std::to_string(item->GetTransmog()) + "^";
        }
        return out + ";";
    }

    std::string BuildXmogFromSet(Player* player, uint8 setId) {
        std::string out = "";
        auto sets = XmogSets.find(player->GetGUID().GetCounter());

        if (sets != XmogSets.end()) {
            auto set = sets->second.find(setId);
            if (set != sets->second.end()) {
                out += set->second->name + "^";
                for (auto slot : xmogSlots) {
                    out += std::to_string(set->second->slottedItems[slot]) + "^";
                }
                out += ";";

                return out;
            }
        }

        return BuildXmogFromEquipped(player);
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

    // xmog
    std::unordered_map<uint32 /*char*/, std::unordered_map<uint8 /*setId*/, ForgeCharacaterXmog*>> XmogSets;
    uint8 xmogSlots[14] = { EQUIPMENT_SLOT_HEAD, EQUIPMENT_SLOT_SHOULDERS, EQUIPMENT_SLOT_BODY, EQUIPMENT_SLOT_CHEST,
        EQUIPMENT_SLOT_WAIST, EQUIPMENT_SLOT_LEGS, EQUIPMENT_SLOT_FEET, EQUIPMENT_SLOT_WRISTS, EQUIPMENT_SLOT_HANDS,
        EQUIPMENT_SLOT_BACK, EQUIPMENT_SLOT_MAINHAND, EQUIPMENT_SLOT_OFFHAND, EQUIPMENT_SLOT_RANGED, EQUIPMENT_SLOT_TABARD };

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
        AddTalentSpent();
        AddCharacterTalents();
        LOG_INFO("server.load", "Loading characters points...");
        AddCharacterPointsFromDB();
        AddCharacterClassSpecs();
        AddCharacterXmogSets();

        LOG_INFO("server.load", "Loading m+ difficulty multipliers...");
        sObjectMgr->LoadInstanceDifficultyMultiplier();
        LOG_INFO("server.load", "Loading m+ difficulty level scales...");
        sObjectMgr->LoadMythicLevelScale();
        LOG_INFO("server.load", "Loading m+ minion values...");
        sObjectMgr->LoadMythicMinionValue();
        LOG_INFO("server.load", "Loading m+ keys...");
        sObjectMgr->LoadMythicDungeonKeyMap();
        LOG_INFO("server.load", "Loading m+ affixes...");
        sObjectMgr->LoadMythicAffixes();
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
        if (TalentTabs[tabId]->TalentType != ACCOUNT_WIDE_TYPE)
            trans->Append("INSERT INTO `forge_character_talents` (`guid`,`spec`,`spellid`,`tabId`,`currentrank`) VALUES ({},{},{},{},{}) ON DUPLICATE KEY UPDATE `currentrank` = {}", charId, spec, spellId, tabId, known, known);
        else
            trans->Append("INSERT INTO `forge_character_talents` (`guid`,`spec`,`spellid`,`tabId`,`currentrank`) VALUES ({},{},{},{},{}) ON DUPLICATE KEY UPDATE `currentrank` = {}", account, ACCOUNT_WIDE_KEY, spellId, tabId, known, known);
    }

    void ForgetCharacterPerkInternal(uint32 charId, uint32 spec, uint32 spellId) {
        // TODO trans->Append("DELETE FROM character_perks WHERE spellId = {} and specId = {}", spellId, spec);
    }

    void AddCharacterXmogSets()
    {
        LOG_INFO("server.load", "Loading character xmog sets...");
        QueryResult xmogSets = CharacterDatabase.Query("SELECT * FROM `forge_character_transmogsets`");
        
        if (!xmogSets)
            return;

        XmogSets.clear();

        do
        {
            Field* xmogSet = xmogSets->Fetch();
            auto guid = xmogSet[0].Get<uint32>();
            auto setid = xmogSet[1].Get<uint32>();
            std::string name = xmogSet[2].Get<std::string>();
            uint32 head = xmogSet[3].Get<uint32>();
            uint32 shoulders = xmogSet[4].Get<uint32>();
            uint32 shirt = xmogSet[5].Get<uint32>();
            uint32 chest = xmogSet[6].Get<uint32>();
            uint32 waist = xmogSet[7].Get<uint32>();
            uint32 legs = xmogSet[8].Get<uint32>();
            uint32 feet = xmogSet[9].Get<uint32>();
            uint32 wrists = xmogSet[10].Get<uint32>();
            uint32 hands = xmogSet[11].Get<uint32>();
            uint32 back = xmogSet[12].Get<uint32>();
            uint32 mh = xmogSet[13].Get<uint32>();
            uint32 oh = xmogSet[14].Get<uint32>();
            uint32 ranged = xmogSet[15].Get<uint32>();
            uint32 tabard = xmogSet[16].Get<uint32>();

            ForgeCharacaterXmog* set = new ForgeCharacaterXmog();
            set->name = name;
            set->slottedItems[EQUIPMENT_SLOT_HEAD] = head;
            set->slottedItems[EQUIPMENT_SLOT_SHOULDERS] = shoulders;
            set->slottedItems[EQUIPMENT_SLOT_BODY] = shirt;
            set->slottedItems[EQUIPMENT_SLOT_CHEST] = chest;
            set->slottedItems[EQUIPMENT_SLOT_WAIST] = waist;
            set->slottedItems[EQUIPMENT_SLOT_LEGS] = legs;
            set->slottedItems[EQUIPMENT_SLOT_FEET] = feet;
            set->slottedItems[EQUIPMENT_SLOT_WRISTS] = wrists;
            set->slottedItems[EQUIPMENT_SLOT_HANDS] = hands;
            set->slottedItems[EQUIPMENT_SLOT_BACK] = back;
            set->slottedItems[EQUIPMENT_SLOT_MAINHAND] = mh;
            set->slottedItems[EQUIPMENT_SLOT_OFFHAND] = oh;
            set->slottedItems[EQUIPMENT_SLOT_RANGED] = ranged;
            set->slottedItems[EQUIPMENT_SLOT_TABARD] = tabard;

            XmogSets[guid][setid] = set;
        } while (xmogSets->NextRow());
    }

    void SaveXmogSetInternal(Player* player, uint32 set, ForgeCharacaterXmog* xmog) {
        auto trans = CharacterDatabase.BeginTransaction();
        trans->Append("INSERT INTO acore_characters.forge_character_transmogsets (guid, setid, setname, head, shoulders, shirt, chest, waist, legs, feet, wrists, hands, back, mh, oh, ranged, tabard) VALUES({}, {}, '{}', {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}) on duplicate key update setname = '{}' , head = {}, shoulders = {}, shirt = {}, chest = {}, waist = {}, legs = {}, feet = {}, wrists = {}, hands = {}, back = {}, mh = {}, oh = {}, ranged = {}, tabard = {}",
            player->GetGUID().GetCounter(), set, xmog->name, xmog->slottedItems[EQUIPMENT_SLOT_HEAD], xmog->slottedItems[EQUIPMENT_SLOT_SHOULDERS],
            xmog->slottedItems[EQUIPMENT_SLOT_BODY], xmog->slottedItems[EQUIPMENT_SLOT_CHEST], xmog->slottedItems[EQUIPMENT_SLOT_WAIST],
            xmog->slottedItems[EQUIPMENT_SLOT_LEGS], xmog->slottedItems[EQUIPMENT_SLOT_FEET], xmog->slottedItems[EQUIPMENT_SLOT_WRISTS],
            xmog->slottedItems[EQUIPMENT_SLOT_HANDS], xmog->slottedItems[EQUIPMENT_SLOT_BACK], xmog->slottedItems[EQUIPMENT_SLOT_MAINHAND],
            xmog->slottedItems[EQUIPMENT_SLOT_OFFHAND], xmog->slottedItems[EQUIPMENT_SLOT_RANGED], xmog->slottedItems[EQUIPMENT_SLOT_TABARD],
            xmog->name, xmog->slottedItems[EQUIPMENT_SLOT_HEAD], xmog->slottedItems[EQUIPMENT_SLOT_SHOULDERS],
            xmog->slottedItems[EQUIPMENT_SLOT_BODY], xmog->slottedItems[EQUIPMENT_SLOT_CHEST], xmog->slottedItems[EQUIPMENT_SLOT_WAIST],
            xmog->slottedItems[EQUIPMENT_SLOT_LEGS], xmog->slottedItems[EQUIPMENT_SLOT_FEET], xmog->slottedItems[EQUIPMENT_SLOT_WRISTS],
            xmog->slottedItems[EQUIPMENT_SLOT_HANDS], xmog->slottedItems[EQUIPMENT_SLOT_BACK], xmog->slottedItems[EQUIPMENT_SLOT_MAINHAND],
            xmog->slottedItems[EQUIPMENT_SLOT_OFFHAND], xmog->slottedItems[EQUIPMENT_SLOT_RANGED], xmog->slottedItems[EQUIPMENT_SLOT_TABARD]);
        CharacterDatabase.CommitTransaction(trans);
    }

    uint8 FirstOpenXmogSlot(Player* player) {
        auto playerSets = XmogSets[player->GetGUID().GetCounter()];
        int i = 0;
        for (auto it = playerSets.cbegin(), end = playerSets.cend();
            it != end && i == it->first; ++it, ++i)
        { }
        return i;
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
                LOG_ERROR("FORGE.ForgeCache", "Error loading talents, invaild tab id: " + std::to_string(newTalent->TalentTabId));
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
                LOG_ERROR("FORGE.ForgeCache", "Error loading AddTalentPrereqs, invaild req id: " + std::to_string(newTalent->reqId));
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
                LOG_ERROR("FORGE.ForgeCache", "Error loading AddTalentExclusiveness, invaild exclusiveSpellId id: " + std::to_string(exclusiveSpellId));
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
                LOG_ERROR("FORGE.ForgeCache", "Error loading AddTalentRanks, invaild talentTabId id: " + std::to_string(talentTabId) + " Rank: " + std::to_string(rank) + " SpellId: " + std::to_string(spellId));
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
                LOG_ERROR("FORGE.ForgeCache", "Error loading AddTalentUnlearn, invaild talentTabId id: " + std::to_string(talentTabId) + " ExclusiveSpell: " + std::to_string(exclusiveSpellId) + " SpellId: " + std::to_string(spellId));
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

    void AddPlayerSpellScaler()
    {
        QueryResult scale = WorldDatabase.Query("SELECT * FROM forge_player_spell_scale");

        if (!scale)
            return;

        do
        {
            Field* talentFields = scale->Fetch();
            uint32 id = talentFields[0].Get<uint32>();
            float data = talentFields[1].Get<float>();

            PlayerSpellScaleMap[id] = data;

        } while (scale->NextRow());
    }

};

#define sForgeCache ForgeCache::get_instance()
