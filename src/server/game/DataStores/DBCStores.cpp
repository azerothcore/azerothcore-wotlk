/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "DBCStores.h"

#include "Log.h"
#include "SharedDefines.h"
#include "SpellMgr.h"
#include "TransportMgr.h"
#include "DBCfmt.h"
#include "BattlegroundMgr.h"
#include "World.h"

#include <map>

typedef std::map<uint16, uint32> AreaFlagByAreaID;
typedef std::map<uint32, uint32> AreaFlagByMapID;

struct WMOAreaTableTripple
{
    WMOAreaTableTripple(int32 r, int32 a, int32 g) :  groupId(g), rootId(r), adtId(a)
    {
    }

    bool operator <(const WMOAreaTableTripple& b) const
    {
        return memcmp(this, &b, sizeof(WMOAreaTableTripple))<0;
    }

    // ordered by entropy; that way memcmp will have a minimal medium runtime
    int32 groupId;
    int32 rootId;
    int32 adtId;
};

typedef std::map<WMOAreaTableTripple, WMOAreaTableEntry const*> WMOAreaInfoByTripple;

DBCStorage <AreaTableEntry> sAreaTableStore(AreaTableEntryfmt);
DBCStorage <AreaGroupEntry> sAreaGroupStore(AreaGroupEntryfmt);
DBCStorage <AreaPOIEntry> sAreaPOIStore(AreaPOIEntryfmt);

static WMOAreaInfoByTripple sWMOAreaInfoByTripple;

DBCStorage <AchievementEntry> sAchievementStore(Achievementfmt);
DBCStorage <AchievementCategoryEntry> sAchievementCategoryStore(AchievementCategoryfmt);
DBCStorage <AchievementCriteriaEntry> sAchievementCriteriaStore(AchievementCriteriafmt);
DBCStorage <AuctionHouseEntry> sAuctionHouseStore(AuctionHouseEntryfmt);
DBCStorage <BankBagSlotPricesEntry> sBankBagSlotPricesStore(BankBagSlotPricesEntryfmt);
DBCStorage <BattlemasterListEntry> sBattlemasterListStore(BattlemasterListEntryfmt);
DBCStorage <BarberShopStyleEntry> sBarberShopStyleStore(BarberShopStyleEntryfmt);
DBCStorage <CharStartOutfitEntry> sCharStartOutfitStore(CharStartOutfitEntryfmt);
std::map<uint32, CharStartOutfitEntry const*> sCharStartOutfitMap;
DBCStorage <CharTitlesEntry> sCharTitlesStore(CharTitlesEntryfmt);
DBCStorage <ChatChannelsEntry> sChatChannelsStore(ChatChannelsEntryfmt);
DBCStorage <ChrClassesEntry> sChrClassesStore(ChrClassesEntryfmt);
DBCStorage <ChrRacesEntry> sChrRacesStore(ChrRacesEntryfmt);
DBCStorage <CinematicSequencesEntry> sCinematicSequencesStore(CinematicSequencesEntryfmt);
DBCStorage <CreatureDisplayInfoEntry> sCreatureDisplayInfoStore(CreatureDisplayInfofmt);
DBCStorage <CreatureFamilyEntry> sCreatureFamilyStore(CreatureFamilyfmt);
DBCStorage <CreatureModelDataEntry> sCreatureModelDataStore(CreatureModelDatafmt);
DBCStorage <CreatureSpellDataEntry> sCreatureSpellDataStore(CreatureSpellDatafmt);
DBCStorage <CreatureTypeEntry> sCreatureTypeStore(CreatureTypefmt);
DBCStorage <CurrencyTypesEntry> sCurrencyTypesStore(CurrencyTypesfmt);

DBCStorage <DestructibleModelDataEntry> sDestructibleModelDataStore(DestructibleModelDatafmt);
DBCStorage <DungeonEncounterEntry> sDungeonEncounterStore(DungeonEncounterfmt);
DBCStorage <DurabilityQualityEntry> sDurabilityQualityStore(DurabilityQualityfmt);
DBCStorage <DurabilityCostsEntry> sDurabilityCostsStore(DurabilityCostsfmt);

DBCStorage <EmotesEntry> sEmotesStore(EmotesEntryfmt);
DBCStorage <EmotesTextEntry> sEmotesTextStore(EmotesTextEntryfmt);

typedef std::map<uint32, SimpleFactionsList> FactionTeamMap;
static FactionTeamMap sFactionTeamMap;
DBCStorage <FactionEntry> sFactionStore(FactionEntryfmt);
DBCStorage <FactionTemplateEntry> sFactionTemplateStore(FactionTemplateEntryfmt);

DBCStorage <GameObjectDisplayInfoEntry> sGameObjectDisplayInfoStore(GameObjectDisplayInfofmt);
DBCStorage <GemPropertiesEntry> sGemPropertiesStore(GemPropertiesEntryfmt);
DBCStorage <GlyphPropertiesEntry> sGlyphPropertiesStore(GlyphPropertiesfmt);
DBCStorage <GlyphSlotEntry> sGlyphSlotStore(GlyphSlotfmt);

DBCStorage <GtBarberShopCostBaseEntry>    sGtBarberShopCostBaseStore(GtBarberShopCostBasefmt);
DBCStorage <GtCombatRatingsEntry>         sGtCombatRatingsStore(GtCombatRatingsfmt);
DBCStorage <GtChanceToMeleeCritBaseEntry> sGtChanceToMeleeCritBaseStore(GtChanceToMeleeCritBasefmt);
DBCStorage <GtChanceToMeleeCritEntry>     sGtChanceToMeleeCritStore(GtChanceToMeleeCritfmt);
DBCStorage <GtChanceToSpellCritBaseEntry> sGtChanceToSpellCritBaseStore(GtChanceToSpellCritBasefmt);
DBCStorage <GtChanceToSpellCritEntry>     sGtChanceToSpellCritStore(GtChanceToSpellCritfmt);
DBCStorage <GtNPCManaCostScalerEntry>     sGtNPCManaCostScalerStore(GtNPCManaCostScalerfmt);
DBCStorage <GtOCTClassCombatRatingScalarEntry> sGtOCTClassCombatRatingScalarStore(GtOCTClassCombatRatingScalarfmt);
DBCStorage <GtOCTRegenHPEntry>            sGtOCTRegenHPStore(GtOCTRegenHPfmt);
//DBCStorage <GtOCTRegenMPEntry>            sGtOCTRegenMPStore(GtOCTRegenMPfmt);  -- not used currently
DBCStorage <GtRegenHPPerSptEntry>         sGtRegenHPPerSptStore(GtRegenHPPerSptfmt);
DBCStorage <GtRegenMPPerSptEntry>         sGtRegenMPPerSptStore(GtRegenMPPerSptfmt);

DBCStorage <HolidaysEntry>                sHolidaysStore(Holidaysfmt);

DBCStorage <ItemBagFamilyEntry>           sItemBagFamilyStore(ItemBagFamilyfmt);
//DBCStorage <ItemCondExtCostsEntry> sItemCondExtCostsStore(ItemCondExtCostsEntryfmt);
DBCStorage <ItemDisplayInfoEntry> sItemDisplayInfoStore(ItemDisplayTemplateEntryfmt);
DBCStorage <ItemExtendedCostEntry> sItemExtendedCostStore(ItemExtendedCostEntryfmt);
DBCStorage <ItemLimitCategoryEntry> sItemLimitCategoryStore(ItemLimitCategoryEntryfmt);
DBCStorage <ItemRandomPropertiesEntry> sItemRandomPropertiesStore(ItemRandomPropertiesfmt);
DBCStorage <ItemRandomSuffixEntry> sItemRandomSuffixStore(ItemRandomSuffixfmt);
DBCStorage <ItemSetEntry> sItemSetStore(ItemSetEntryfmt);

DBCStorage <LFGDungeonEntry> sLFGDungeonStore(LFGDungeonEntryfmt);
DBCStorage <LightEntry> sLightStore(LightEntryfmt);
DBCStorage <LiquidTypeEntry> sLiquidTypeStore(LiquidTypefmt);
DBCStorage <LockEntry> sLockStore(LockEntryfmt);

DBCStorage <MailTemplateEntry> sMailTemplateStore(MailTemplateEntryfmt);
DBCStorage <MapEntry> sMapStore(MapEntryfmt);

// DBC used only for initialization sMapDifficultyMap at startup.
DBCStorage <MapDifficultyEntry> sMapDifficultyStore(MapDifficultyEntryfmt); // only for loading
MapDifficultyMap sMapDifficultyMap;

DBCStorage <MovieEntry> sMovieStore(MovieEntryfmt);

DBCStorage <OverrideSpellDataEntry> sOverrideSpellDataStore(OverrideSpellDatafmt);

DBCStorage <PowerDisplayEntry> sPowerDisplayStore(PowerDisplayfmt);
DBCStorage <PvPDifficultyEntry> sPvPDifficultyStore(PvPDifficultyfmt);

DBCStorage <QuestSortEntry> sQuestSortStore(QuestSortEntryfmt);
DBCStorage <QuestXPEntry>   sQuestXPStore(QuestXPfmt);
DBCStorage <QuestFactionRewEntry>  sQuestFactionRewardStore(QuestFactionRewardfmt);
DBCStorage <RandomPropertiesPointsEntry> sRandomPropertiesPointsStore(RandomPropertiesPointsfmt);
DBCStorage <ScalingStatDistributionEntry> sScalingStatDistributionStore(ScalingStatDistributionfmt);
DBCStorage <ScalingStatValuesEntry> sScalingStatValuesStore(ScalingStatValuesfmt);

DBCStorage <SkillLineEntry> sSkillLineStore(SkillLinefmt);
DBCStorage <SkillLineAbilityEntry> sSkillLineAbilityStore(SkillLineAbilityfmt);

DBCStorage <SoundEntriesEntry> sSoundEntriesStore(SoundEntriesfmt);

DBCStorage <SpellItemEnchantmentEntry> sSpellItemEnchantmentStore(SpellItemEnchantmentfmt);
DBCStorage <SpellItemEnchantmentConditionEntry> sSpellItemEnchantmentConditionStore(SpellItemEnchantmentConditionfmt);
DBCStorage <SpellEntry> sSpellStore(SpellEntryfmt);
SpellCategoryStore sSpellsByCategoryStore;
PetFamilySpellsStore sPetFamilySpellsStore;

DBCStorage <SpellCastTimesEntry> sSpellCastTimesStore(SpellCastTimefmt);
DBCStorage <SpellCategoryEntry> sSpellCategoryStore(SpellCategoryfmt);
DBCStorage <SpellDifficultyEntry> sSpellDifficultyStore(SpellDifficultyfmt);
DBCStorage <SpellDurationEntry> sSpellDurationStore(SpellDurationfmt);
DBCStorage <SpellFocusObjectEntry> sSpellFocusObjectStore(SpellFocusObjectfmt);
DBCStorage <SpellRadiusEntry> sSpellRadiusStore(SpellRadiusfmt);
DBCStorage <SpellRangeEntry> sSpellRangeStore(SpellRangefmt);
DBCStorage <SpellRuneCostEntry> sSpellRuneCostStore(SpellRuneCostfmt);
DBCStorage <SpellShapeshiftEntry> sSpellShapeshiftStore(SpellShapeshiftfmt);
DBCStorage <StableSlotPricesEntry> sStableSlotPricesStore(StableSlotPricesfmt);
DBCStorage <SummonPropertiesEntry> sSummonPropertiesStore(SummonPropertiesfmt);
DBCStorage <TalentEntry> sTalentStore(TalentEntryfmt);
TalentSpellPosMap sTalentSpellPosMap;
DBCStorage <TalentTabEntry> sTalentTabStore(TalentTabEntryfmt);

DBCStorage <TaxiNodesEntry> sTaxiNodesStore(TaxiNodesEntryfmt);
TaxiMask sTaxiNodesMask;
TaxiMask sOldContinentsNodesMask;
TaxiMask sHordeTaxiNodesMask;
TaxiMask sAllianceTaxiNodesMask;
TaxiMask sDeathKnightTaxiNodesMask;

// DBC used only for initialization sTaxiPathSetBySource at startup.
TaxiPathSetBySource sTaxiPathSetBySource;
DBCStorage <TaxiPathEntry> sTaxiPathStore(TaxiPathEntryfmt);

// DBC used only for initialization sTaxiPathNodeStore at startup.
TaxiPathNodesByPath sTaxiPathNodesByPath;
static DBCStorage <TaxiPathNodeEntry> sTaxiPathNodeStore(TaxiPathNodeEntryfmt);

DBCStorage <TeamContributionPointsEntry> sTeamContributionPointsStore(TeamContributionPointsfmt);
DBCStorage <TotemCategoryEntry> sTotemCategoryStore(TotemCategoryEntryfmt);
DBCStorage <TransportAnimationEntry> sTransportAnimationStore(TransportAnimationfmt);
DBCStorage <TransportRotationEntry> sTransportRotationStore(TransportRotationfmt);
DBCStorage <VehicleEntry> sVehicleStore(VehicleEntryfmt);
DBCStorage <VehicleSeatEntry> sVehicleSeatStore(VehicleSeatEntryfmt);
DBCStorage <WMOAreaTableEntry> sWMOAreaTableStore(WMOAreaTableEntryfmt);
DBCStorage <WorldMapAreaEntry> sWorldMapAreaStore(WorldMapAreaEntryfmt);
DBCStorage <WorldMapOverlayEntry> sWorldMapOverlayStore(WorldMapOverlayEntryfmt);

typedef std::list<std::string> StoreProblemList;

uint32 DBCFileCount = 0;

static bool LoadDBC_assert_print(uint32 fsize, uint32 rsize, const std::string& filename)
{
    sLog->outError("Size of '%s' set by format string (%u) not equal size of C++ structure (%u).", filename.c_str(), fsize, rsize);

    // ASSERT must fail after function call
    return false;
}

template<class T>
inline void LoadDBC(uint32& availableDbcLocales, StoreProblemList& errors, DBCStorage<T>& storage, std::string const& dbcPath, std::string const& filename, std::string const* customFormat = NULL, std::string const* customIndexName = NULL)
{
    // compatibility format and C++ structure sizes
    ASSERT(DBCFileLoader::GetFormatRecordSize(storage.GetFormat()) == sizeof(T) || LoadDBC_assert_print(DBCFileLoader::GetFormatRecordSize(storage.GetFormat()), sizeof(T), filename));

    ++DBCFileCount;
    std::string dbcFilename = dbcPath + filename;
    SqlDbc * sql = NULL;
    if (customFormat)
        sql = new SqlDbc(&filename, customFormat, customIndexName, storage.GetFormat());

    if (storage.Load(dbcFilename.c_str(), sql))
    {
        for (uint8 i = 0; i < TOTAL_LOCALES; ++i)
        {
            if (!(availableDbcLocales & (1 << i)))
                continue;

            std::string localizedName(dbcPath);
            localizedName.append(localeNames[i]);
            localizedName.push_back('/');
            localizedName.append(filename);

            if (!storage.LoadStringsFrom(localizedName.c_str()))
                availableDbcLocales &= ~(1<<i);             // mark as not available for speedup next checks
        }
    }
    else
    {
        // sort problematic dbc to (1) non compatible and (2) non-existed
        if (FILE* f = fopen(dbcFilename.c_str(), "rb"))
        {
            std::ostringstream stream;
            stream << dbcFilename << " exists, and has " << storage.GetFieldCount() << " field(s) (expected " << strlen(storage.GetFormat()) << "). Extracted file might be from wrong client version or a database-update has been forgotten.";
            std::string buf = stream.str();
            errors.push_back(buf);
            fclose(f);
        }
        else
            errors.push_back(dbcFilename);
    }

    delete sql;
}

void LoadDBCStores(const std::string& dataPath)
{
    uint32 oldMSTime = getMSTime();

    std::string dbcPath = dataPath+"dbc/";

    StoreProblemList bad_dbc_files;
    uint32 availableDbcLocales = 0xFFFFFFFF;

    LoadDBC(availableDbcLocales, bad_dbc_files, sAreaTableStore, dbcPath, "AreaTable.dbc");

    LoadDBC(availableDbcLocales, bad_dbc_files, sAchievementStore,            dbcPath, "Achievement.dbc", &CustomAchievementfmt, &CustomAchievementIndex);
    LoadDBC(availableDbcLocales, bad_dbc_files, sAchievementCategoryStore,    dbcPath, "Achievement_Category.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sAchievementCriteriaStore,    dbcPath, "Achievement_Criteria.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sAreaGroupStore,              dbcPath, "AreaGroup.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sAreaPOIStore,                dbcPath, "AreaPOI.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sAuctionHouseStore,           dbcPath, "AuctionHouse.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sBankBagSlotPricesStore,      dbcPath, "BankBagSlotPrices.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sBattlemasterListStore,       dbcPath, "BattlemasterList.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sBarberShopStyleStore,        dbcPath, "BarberShopStyle.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sCharStartOutfitStore,        dbcPath, "CharStartOutfit.dbc");
    for (uint32 i = 0; i < sCharStartOutfitStore.GetNumRows(); ++i)
        if (CharStartOutfitEntry const* outfit = sCharStartOutfitStore.LookupEntry(i))
            sCharStartOutfitMap[outfit->Race | (outfit->Class << 8) | (outfit->Gender << 16)] = outfit;

    LoadDBC(availableDbcLocales, bad_dbc_files, sCharTitlesStore,             dbcPath, "CharTitles.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sChatChannelsStore,           dbcPath, "ChatChannels.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sChrClassesStore,             dbcPath, "ChrClasses.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sChrRacesStore,               dbcPath, "ChrRaces.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sCinematicSequencesStore,     dbcPath, "CinematicSequences.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sCreatureDisplayInfoStore,    dbcPath, "CreatureDisplayInfo.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sCreatureFamilyStore,         dbcPath, "CreatureFamily.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sCreatureModelDataStore,      dbcPath, "CreatureModelData.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sCreatureSpellDataStore,      dbcPath, "CreatureSpellData.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sCreatureTypeStore,           dbcPath, "CreatureType.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sCurrencyTypesStore,          dbcPath, "CurrencyTypes.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sDestructibleModelDataStore,  dbcPath, "DestructibleModelData.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sDungeonEncounterStore,       dbcPath, "DungeonEncounter.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sDurabilityCostsStore,        dbcPath, "DurabilityCosts.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sDurabilityQualityStore,      dbcPath, "DurabilityQuality.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sEmotesStore,                 dbcPath, "Emotes.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sEmotesTextStore,             dbcPath, "EmotesText.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sFactionStore,                dbcPath, "Faction.dbc");
    for (uint32 i=0; i<sFactionStore.GetNumRows(); ++i)
    {
        FactionEntry const* faction = sFactionStore.LookupEntry(i);
        if (faction && faction->team)
        {
            SimpleFactionsList &flist = sFactionTeamMap[faction->team];
            flist.push_back(i);
        }
    }

    LoadDBC(availableDbcLocales, bad_dbc_files, sFactionTemplateStore,        dbcPath, "FactionTemplate.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sGameObjectDisplayInfoStore,  dbcPath, "GameObjectDisplayInfo.dbc");
    for (uint32 i = 0; i < sGameObjectDisplayInfoStore.GetNumRows(); ++i)
    {
        if (GameObjectDisplayInfoEntry const* info = sGameObjectDisplayInfoStore.LookupEntry(i))
        {
            if (info->maxX < info->minX)
                std::swap(*(float*)(&info->maxX), *(float*)(&info->minX));
            if (info->maxY < info->minY)
                std::swap(*(float*)(&info->maxY), *(float*)(&info->minY));
            if (info->maxZ < info->minZ)
                std::swap(*(float*)(&info->maxZ), *(float*)(&info->minZ));
        }
    }

    LoadDBC(availableDbcLocales, bad_dbc_files, sGemPropertiesStore,          dbcPath, "GemProperties.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sGlyphPropertiesStore,        dbcPath, "GlyphProperties.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sGlyphSlotStore,              dbcPath, "GlyphSlot.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sGtBarberShopCostBaseStore,   dbcPath, "gtBarberShopCostBase.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sGtCombatRatingsStore,        dbcPath, "gtCombatRatings.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sGtChanceToMeleeCritBaseStore, dbcPath, "gtChanceToMeleeCritBase.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sGtChanceToMeleeCritStore,    dbcPath, "gtChanceToMeleeCrit.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sGtChanceToSpellCritBaseStore, dbcPath, "gtChanceToSpellCritBase.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sGtChanceToSpellCritStore,    dbcPath, "gtChanceToSpellCrit.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sGtNPCManaCostScalerStore,    dbcPath, "gtNPCManaCostScaler.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sGtOCTClassCombatRatingScalarStore,    dbcPath, "gtOCTClassCombatRatingScalar.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sGtOCTRegenHPStore,           dbcPath, "gtOCTRegenHP.dbc");
    //LoadDBC(dbcCount, availableDbcLocales, bad_dbc_files, sGtOCTRegenMPStore,           dbcPath, "gtOCTRegenMP.dbc");       -- not used currently
    LoadDBC(availableDbcLocales, bad_dbc_files, sGtRegenHPPerSptStore,        dbcPath, "gtRegenHPPerSpt.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sGtRegenMPPerSptStore,        dbcPath, "gtRegenMPPerSpt.dbc");

    LoadDBC(availableDbcLocales, bad_dbc_files, sHolidaysStore,               dbcPath, "Holidays.dbc");

    LoadDBC(availableDbcLocales, bad_dbc_files, sItemBagFamilyStore,          dbcPath, "ItemBagFamily.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sItemDisplayInfoStore,        dbcPath, "ItemDisplayInfo.dbc");
    //LoadDBC(dbcCount, availableDbcLocales, bad_dbc_files, sItemCondExtCostsStore,       dbcPath, "ItemCondExtCosts.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sItemExtendedCostStore,       dbcPath, "ItemExtendedCost.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sItemLimitCategoryStore,      dbcPath, "ItemLimitCategory.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sItemRandomPropertiesStore,   dbcPath, "ItemRandomProperties.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sItemRandomSuffixStore,       dbcPath, "ItemRandomSuffix.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sItemSetStore,                dbcPath, "ItemSet.dbc");

    LoadDBC(availableDbcLocales, bad_dbc_files, sLFGDungeonStore,             dbcPath, "LFGDungeons.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sLightStore,                  dbcPath, "Light.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sLiquidTypeStore,             dbcPath, "LiquidType.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sLockStore,                   dbcPath, "Lock.dbc");

    LoadDBC(availableDbcLocales, bad_dbc_files, sMailTemplateStore,           dbcPath, "MailTemplate.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sMapStore,                    dbcPath, "Map.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sMapDifficultyStore,          dbcPath, "MapDifficulty.dbc");
    // fill data
    for (uint32 i = 1; i < sMapDifficultyStore.GetNumRows(); ++i)
        if (MapDifficultyEntry const* entry = sMapDifficultyStore.LookupEntry(i))
            sMapDifficultyMap[MAKE_PAIR32(entry->MapId, entry->Difficulty)] = MapDifficulty(entry->resetTime, entry->maxPlayers, entry->areaTriggerText[0] != '\0');
    sMapDifficultyStore.Clear();

    LoadDBC(availableDbcLocales, bad_dbc_files, sMovieStore,                  dbcPath, "Movie.dbc");

    LoadDBC(availableDbcLocales, bad_dbc_files, sOverrideSpellDataStore,      dbcPath, "OverrideSpellData.dbc");

    LoadDBC(availableDbcLocales, bad_dbc_files, sPowerDisplayStore,           dbcPath, "PowerDisplay.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sPvPDifficultyStore,          dbcPath, "PvpDifficulty.dbc");
    for (uint32 i = 0; i < sPvPDifficultyStore.GetNumRows(); ++i)
        if (PvPDifficultyEntry const* entry = sPvPDifficultyStore.LookupEntry(i))
            if (entry->bracketId > MAX_BATTLEGROUND_BRACKETS)
                ASSERT(false && "Need update MAX_BATTLEGROUND_BRACKETS by DBC data");

    LoadDBC(availableDbcLocales, bad_dbc_files, sQuestXPStore,                dbcPath, "QuestXP.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sQuestFactionRewardStore,     dbcPath, "QuestFactionReward.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sQuestSortStore,              dbcPath, "QuestSort.dbc");

    LoadDBC(availableDbcLocales, bad_dbc_files, sRandomPropertiesPointsStore, dbcPath, "RandPropPoints.dbc");

    LoadDBC(availableDbcLocales, bad_dbc_files, sScalingStatDistributionStore, dbcPath, "ScalingStatDistribution.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sScalingStatValuesStore,      dbcPath, "ScalingStatValues.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sSkillLineStore,              dbcPath, "SkillLine.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sSkillLineAbilityStore,       dbcPath, "SkillLineAbility.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sSoundEntriesStore,           dbcPath, "SoundEntries.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sSpellStore,                  dbcPath, "Spell.dbc", &CustomSpellEntryfmt, &CustomSpellEntryIndex);
    for (uint32 i = 1; i < sSpellStore.GetNumRows(); ++i)
    {
        SpellEntry const* spell = sSpellStore.LookupEntry(i);
        if (spell && spell->Category)
            sSpellsByCategoryStore[spell->Category].insert(i);
    }

    for (uint32 j = 0; j < sSkillLineAbilityStore.GetNumRows(); ++j)
    {
        SkillLineAbilityEntry const* skillLine = sSkillLineAbilityStore.LookupEntry(j);

        if (!skillLine)
            continue;

        SpellEntry const* spellInfo = sSpellStore.LookupEntry(skillLine->spellId);

        if (spellInfo && (spellInfo->Attributes & SPELL_ATTR0_PASSIVE))
        {
            for (uint32 i = 1; i < sCreatureFamilyStore.GetNumRows(); ++i)
            {
                CreatureFamilyEntry const* cFamily = sCreatureFamilyStore.LookupEntry(i);
                if (!cFamily)
                    continue;

                if (skillLine->skillId != cFamily->skillLine[0] && skillLine->skillId != cFamily->skillLine[1])
                    continue;
                if (spellInfo->spellLevel)
                    continue;

                if (skillLine->learnOnGetSkill != ABILITY_LEARNED_ON_GET_RACE_OR_CLASS_SKILL)
                    continue;

                sPetFamilySpellsStore[i].insert(spellInfo->Id);
            }
        }
    }

    LoadDBC(availableDbcLocales, bad_dbc_files, sSpellCastTimesStore,         dbcPath, "SpellCastTimes.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sSpellCategoryStore,          dbcPath, "SpellCategory.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sSpellDifficultyStore,        dbcPath, "SpellDifficulty.dbc", &CustomSpellDifficultyfmt, &CustomSpellDifficultyIndex);
    LoadDBC(availableDbcLocales, bad_dbc_files, sSpellDurationStore,          dbcPath, "SpellDuration.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sSpellFocusObjectStore,       dbcPath, "SpellFocusObject.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sSpellItemEnchantmentStore,   dbcPath, "SpellItemEnchantment.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sSpellItemEnchantmentConditionStore, dbcPath, "SpellItemEnchantmentCondition.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sSpellRadiusStore,            dbcPath, "SpellRadius.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sSpellRangeStore,             dbcPath, "SpellRange.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sSpellRuneCostStore,          dbcPath, "SpellRuneCost.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sSpellShapeshiftStore,        dbcPath, "SpellShapeshiftForm.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sStableSlotPricesStore,       dbcPath, "StableSlotPrices.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sSummonPropertiesStore,       dbcPath, "SummonProperties.dbc");

    LoadDBC(availableDbcLocales, bad_dbc_files, sTalentStore,                 dbcPath, "Talent.dbc");

    // Create Spelldifficulty searcher
    for (uint32 i = 0; i < sSpellDifficultyStore.GetNumRows(); ++i)
    {
        SpellDifficultyEntry const* spellDiff = sSpellDifficultyStore.LookupEntry(i);
        if (!spellDiff)
            continue;

        SpellDifficultyEntry newEntry;
        memset(newEntry.SpellID, 0, 4*sizeof(uint32));
        for (int x = 0; x < MAX_DIFFICULTY; ++x)
        {
            if (spellDiff->SpellID[x] <= 0 || !sSpellStore.LookupEntry(spellDiff->SpellID[x]))
            {
                if (spellDiff->SpellID[x] > 0)//don't show error if spell is <= 0, not all modes have spells and there are unknown negative values
                    sLog->outErrorDb("spelldifficulty_dbc: spell %i at field id:%u at spellid%i does not exist in SpellStore (spell.dbc), loaded as 0", spellDiff->SpellID[x], spellDiff->ID, x);
                newEntry.SpellID[x] = 0;//spell was <= 0 or invalid, set to 0
            }
            else
                newEntry.SpellID[x] = spellDiff->SpellID[x];
        }
        if (newEntry.SpellID[0] <= 0 || newEntry.SpellID[1] <= 0)//id0-1 must be always set!
            continue;

        for (int x = 0; x < MAX_DIFFICULTY; ++x)
            if (newEntry.SpellID[x])
                sSpellMgr->SetSpellDifficultyId(uint32(newEntry.SpellID[x]), spellDiff->ID);
    }

    // create talent spells set
    for (uint32 i = 0; i < sTalentStore.GetNumRows(); ++i)
    {
        TalentEntry const* talentInfo = sTalentStore.LookupEntry(i);
        if (!talentInfo)
            continue;

        for (int j = 0; j < MAX_TALENT_RANK; j++)
            if (talentInfo->RankID[j])
                sTalentSpellPosMap[talentInfo->RankID[j]] = TalentSpellPos(i, j);
    }

    LoadDBC(availableDbcLocales, bad_dbc_files, sTalentTabStore,              dbcPath, "TalentTab.dbc");

    LoadDBC(availableDbcLocales, bad_dbc_files, sTaxiNodesStore,              dbcPath, "TaxiNodes.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sTaxiPathStore,               dbcPath, "TaxiPath.dbc");
    for (uint32 i = 1; i < sTaxiPathStore.GetNumRows(); ++i)
        if (TaxiPathEntry const* entry = sTaxiPathStore.LookupEntry(i))
            sTaxiPathSetBySource[entry->from][entry->to] = TaxiPathBySourceAndDestination(entry->ID, entry->price);
    uint32 pathCount = sTaxiPathStore.GetNumRows();

    //## TaxiPathNode.dbc ## Loaded only for initialization different structures
    LoadDBC(availableDbcLocales, bad_dbc_files, sTaxiPathNodeStore,           dbcPath, "TaxiPathNode.dbc");
    // Calculate path nodes count
    std::vector<uint32> pathLength;
    pathLength.resize(pathCount);                           // 0 and some other indexes not used
    for (uint32 i = 1; i < sTaxiPathNodeStore.GetNumRows(); ++i)
        if (TaxiPathNodeEntry const* entry = sTaxiPathNodeStore.LookupEntry(i))
        {
            if (pathLength[entry->path] < entry->index + 1)
                pathLength[entry->path] = entry->index + 1;
        }
    // Set path length
    sTaxiPathNodesByPath.resize(pathCount);                 // 0 and some other indexes not used
    for (uint32 i = 1; i < sTaxiPathNodesByPath.size(); ++i)
        sTaxiPathNodesByPath[i].resize(pathLength[i]);
    // fill data
    for (uint32 i = 1; i < sTaxiPathNodeStore.GetNumRows(); ++i)
        if (TaxiPathNodeEntry const* entry = sTaxiPathNodeStore.LookupEntry(i))
            sTaxiPathNodesByPath[entry->path][entry->index] = entry;

    // Initialize global taxinodes mask
    // include existed nodes that have at least single not spell base (scripted) path
    {
        std::set<uint32> spellPaths;
        for (uint32 i = 1; i < sSpellStore.GetNumRows(); ++i)
            if (SpellEntry const* sInfo = sSpellStore.LookupEntry (i))
                for (int j = 0; j < MAX_SPELL_EFFECTS; ++j)
                    if (sInfo->Effect[j] == SPELL_EFFECT_SEND_TAXI)
                        spellPaths.insert(sInfo->EffectMiscValue[j]);

        memset(sTaxiNodesMask, 0, sizeof(sTaxiNodesMask));
        memset(sOldContinentsNodesMask, 0, sizeof(sOldContinentsNodesMask));
        memset(sHordeTaxiNodesMask, 0, sizeof(sHordeTaxiNodesMask));
        memset(sAllianceTaxiNodesMask, 0, sizeof(sAllianceTaxiNodesMask));
        memset(sDeathKnightTaxiNodesMask, 0, sizeof(sDeathKnightTaxiNodesMask));
        for (uint32 i = 1; i < sTaxiNodesStore.GetNumRows(); ++i)
        {
            TaxiNodesEntry const* node = sTaxiNodesStore.LookupEntry(i);
            if (!node)
                continue;

            TaxiPathSetBySource::const_iterator src_i = sTaxiPathSetBySource.find(i);
            if (src_i != sTaxiPathSetBySource.end() && !src_i->second.empty())
            {
                bool ok = false;
                for (TaxiPathSetForSource::const_iterator dest_i = src_i->second.begin(); dest_i != src_i->second.end(); ++dest_i)
                {
                    // not spell path
                    if (dest_i->second.price || spellPaths.find(dest_i->second.ID) == spellPaths.end())
                    {
                        ok = true;
                        break;
                    }
                }

                if (!ok)
                    continue;
            }

            // valid taxi network node
            uint8  field   = (uint8)((i - 1) / 32);
            uint32 submask = 1<<((i-1)%32);
            sTaxiNodesMask[field] |= submask;

            if (node->MountCreatureID[0] && node->MountCreatureID[0] != 32981)
                sHordeTaxiNodesMask[field] |= submask;
            if (node->MountCreatureID[1] && node->MountCreatureID[1] != 32981)
                sAllianceTaxiNodesMask[field] |= submask;
            if (node->MountCreatureID[0] == 32981 || node->MountCreatureID[1] == 32981)
                sDeathKnightTaxiNodesMask[field] |= submask;

            // old continent node (+ nodes virtually at old continents, check explicitly to avoid loading map files for zone info)
            if (node->map_id < 2 || i == 82 || i == 83 || i == 93 || i == 94)
                sOldContinentsNodesMask[field] |= submask;

            // fix DK node at Ebon Hold and Shadow Vault flight master
            if (i == 315 || i == 333)
                ((TaxiNodesEntry*)node)->MountCreatureID[1] = 32981;
        }
    }

    LoadDBC(availableDbcLocales, bad_dbc_files, sTeamContributionPointsStore, dbcPath, "TeamContributionPoints.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sTotemCategoryStore,          dbcPath, "TotemCategory.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sTransportAnimationStore,     dbcPath, "TransportAnimation.dbc");
    for (uint32 i = 0; i < sTransportAnimationStore.GetNumRows(); ++i)
    {
        TransportAnimationEntry const* anim = sTransportAnimationStore.LookupEntry(i);
        if (!anim)
            continue;

        sTransportMgr->AddPathNodeToTransport(anim->TransportEntry, anim->TimeSeg, anim);
    }

    LoadDBC(availableDbcLocales, bad_dbc_files, sTransportRotationStore,     dbcPath, "TransportRotation.dbc");
    for (uint32 i = 0; i < sTransportRotationStore.GetNumRows(); ++i)
    {
        TransportRotationEntry const* rot = sTransportRotationStore.LookupEntry(i);
        if (!rot)
            continue;

        sTransportMgr->AddPathRotationToTransport(rot->TransportEntry, rot->TimeSeg, rot);
    }

    LoadDBC(availableDbcLocales, bad_dbc_files, sVehicleStore,                dbcPath, "Vehicle.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sVehicleSeatStore,            dbcPath, "VehicleSeat.dbc");

    LoadDBC(availableDbcLocales, bad_dbc_files, sWMOAreaTableStore,           dbcPath, "WMOAreaTable.dbc");
    for (uint32 i = 0; i < sWMOAreaTableStore.GetNumRows(); ++i)
        if (WMOAreaTableEntry const* entry = sWMOAreaTableStore.LookupEntry(i))
            sWMOAreaInfoByTripple.insert(WMOAreaInfoByTripple::value_type(WMOAreaTableTripple(entry->rootId, entry->adtId, entry->groupId), entry));
    LoadDBC(availableDbcLocales, bad_dbc_files, sWorldMapAreaStore,           dbcPath, "WorldMapArea.dbc");
    LoadDBC(availableDbcLocales, bad_dbc_files, sWorldMapOverlayStore,        dbcPath, "WorldMapOverlay.dbc");

    // error checks
    if (bad_dbc_files.size() >= DBCFileCount)
    {
        sLog->outError("Incorrect DataDir value in worldserver.conf or ALL required *.dbc files (%d) not found by path: %sdbc", DBCFileCount, dataPath.c_str());
        exit(1);
    }
    else if (!bad_dbc_files.empty())
    {
        std::string str;
        for (StoreProblemList::iterator i = bad_dbc_files.begin(); i != bad_dbc_files.end(); ++i)
            str += *i + "\n";

        sLog->outError("Some required *.dbc files (%u from %d) not found or not compatible:\n%s", (uint32)bad_dbc_files.size(), DBCFileCount, str.c_str());
        exit(1);
    }

    // Check loaded DBC files proper version
    if (!sAreaTableStore.LookupEntry(4987)         ||       // last area added in 3.3.5a
        !sCharTitlesStore.LookupEntry(177)         ||       // last char title added in 3.3.5a
        !sGemPropertiesStore.LookupEntry(1629)     ||       // last added spell in 3.3.5a
        !sItemExtendedCostStore.LookupEntry(2997)  ||       // last item extended cost added in 3.3.5a
        !sMapStore.LookupEntry(724)                ||       // last map added in 3.3.5a
        !sSpellStore.LookupEntry(80864)            )        // last client known item added in 3.3.5a
    {
        sLog->outError("You have _outdated_ DBC files. Please extract correct versions from current using client.");
        exit(1);
    }

    sLog->outString(">> Initialized %d data stores in %u ms", DBCFileCount, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

SimpleFactionsList const* GetFactionTeamList(uint32 faction)
{
    FactionTeamMap::const_iterator itr = sFactionTeamMap.find(faction);
    if (itr != sFactionTeamMap.end())
        return &itr->second;

    return NULL;
}

char* GetPetName(uint32 petfamily, uint32 dbclang)
{
    if (!petfamily)
        return NULL;
    CreatureFamilyEntry const* pet_family = sCreatureFamilyStore.LookupEntry(petfamily);
    if (!pet_family)
        return NULL;
    return pet_family->Name[dbclang]?pet_family->Name[dbclang]:NULL;
}

TalentSpellPos const* GetTalentSpellPos(uint32 spellId)
{
    TalentSpellPosMap::const_iterator itr = sTalentSpellPosMap.find(spellId);
    if (itr == sTalentSpellPosMap.end())
        return NULL;

    return &itr->second;
}

uint32 GetTalentSpellCost(uint32 spellId)
{
    if (TalentSpellPos const* pos = GetTalentSpellPos(spellId))
        return pos->rank+1;

    return 0;
}

WMOAreaTableEntry const* GetWMOAreaTableEntryByTripple(int32 rootid, int32 adtid, int32 groupid)
{
    WMOAreaInfoByTripple::iterator i = sWMOAreaInfoByTripple.find(WMOAreaTableTripple(rootid, adtid, groupid));
    if (i == sWMOAreaInfoByTripple.end())
        return NULL;
    return i->second;
}

uint32 GetVirtualMapForMapAndZone(uint32 mapid, uint32 zoneId)
{
    if (mapid != 530 && mapid != 571)                        // speed for most cases
        return mapid;

    if (WorldMapAreaEntry const* wma = sWorldMapAreaStore.LookupEntry(zoneId))
        return wma->virtual_map_id >= 0 ? wma->virtual_map_id : wma->map_id;

    return mapid;
}

ContentLevels GetContentLevelsForMapAndZone(uint32 mapid, uint32 zoneId)
{
    mapid = GetVirtualMapForMapAndZone(mapid, zoneId);
    if (mapid < 2)
        return CONTENT_1_60;

    MapEntry const* mapEntry = sMapStore.LookupEntry(mapid);
    if (!mapEntry)
        return CONTENT_1_60;

    switch (mapEntry->Expansion())
    {
        default: return CONTENT_1_60;
        case 1:  return CONTENT_61_70;
        case 2:  return CONTENT_71_80;
    }
}

void Zone2MapCoordinates(float& x, float& y, uint32 zone)
{
    WorldMapAreaEntry const* maEntry = sWorldMapAreaStore.LookupEntry(zone);

    // if not listed then map coordinates (instance)
    if (!maEntry)
        return;

    std::swap(x, y);                                         // at client map coords swapped
    x = x*((maEntry->x2-maEntry->x1)/100)+maEntry->x1;
    y = y*((maEntry->y2-maEntry->y1)/100)+maEntry->y1;      // client y coord from top to down
}

void Map2ZoneCoordinates(float& x, float& y, uint32 zone)
{
    WorldMapAreaEntry const* maEntry = sWorldMapAreaStore.LookupEntry(zone);

    // if not listed then map coordinates (instance)
    if (!maEntry)
        return;

    x = (x-maEntry->x1)/((maEntry->x2-maEntry->x1)/100);
    y = (y-maEntry->y1)/((maEntry->y2-maEntry->y1)/100);    // client y coord from top to down
    std::swap(x, y);                                         // client have map coords swapped
}

MapDifficulty const* GetMapDifficultyData(uint32 mapId, Difficulty difficulty)
{
    MapDifficultyMap::const_iterator itr = sMapDifficultyMap.find(MAKE_PAIR32(mapId, difficulty));
    return itr != sMapDifficultyMap.end() ? &itr->second : NULL;
}

MapDifficulty const* GetDownscaledMapDifficultyData(uint32 mapId, Difficulty &difficulty)
{
    uint32 tmpDiff = difficulty;
    MapDifficulty const* mapDiff = GetMapDifficultyData(mapId, Difficulty(tmpDiff));
    if (!mapDiff)
    {
        if (tmpDiff > RAID_DIFFICULTY_25MAN_NORMAL) // heroic, downscale to normal
            tmpDiff -= 2;
        else
            tmpDiff -= 1;   // any non-normal mode for raids like tbc (only one mode)

        // pull new data
        mapDiff = GetMapDifficultyData(mapId, Difficulty(tmpDiff)); // we are 10 normal or 25 normal
        if (!mapDiff)
        {
            tmpDiff -= 1;
            mapDiff = GetMapDifficultyData(mapId, Difficulty(tmpDiff)); // 10 normal
        }
    }

    difficulty = Difficulty(tmpDiff);
    return mapDiff;
}

PvPDifficultyEntry const* GetBattlegroundBracketByLevel(uint32 mapid, uint32 level)
{
    if (mapid == sBattlegroundMgr->randomBgDifficultyEntry.mapId)
    {
        if (level < sBattlegroundMgr->randomBgDifficultyEntry.minLevel)
            return NULL;
        return &sBattlegroundMgr->randomBgDifficultyEntry;
    }

    PvPDifficultyEntry const* maxEntry = NULL;              // used for level > max listed level case
    for (uint32 i = 0; i < sPvPDifficultyStore.GetNumRows(); ++i)
    {
        if (PvPDifficultyEntry const* entry = sPvPDifficultyStore.LookupEntry(i))
        {
            // skip unrelated and too-high brackets
            if (entry->mapId != mapid || entry->minLevel > level)
                continue;

            // exactly fit
            if (entry->maxLevel >= level)
                return entry;

            // remember for possible out-of-range case (search higher from existed)
            if (!maxEntry || maxEntry->maxLevel < entry->maxLevel)
                maxEntry = entry;
        }
    }

    return maxEntry;
}

PvPDifficultyEntry const* GetBattlegroundBracketById(uint32 mapid, BattlegroundBracketId id)
{
    if (mapid == sBattlegroundMgr->randomBgDifficultyEntry.mapId)
    {
        if (id != sBattlegroundMgr->randomBgDifficultyEntry.bracketId)
            return NULL;
        return &sBattlegroundMgr->randomBgDifficultyEntry;
    }

    for (uint32 i = 0; i < sPvPDifficultyStore.GetNumRows(); ++i)
        if (PvPDifficultyEntry const* entry = sPvPDifficultyStore.LookupEntry(i))
            if (entry->mapId == mapid && entry->GetBracketId() == id)
                return entry;

    return NULL;
}

bool IsSharedDifficultyMap(uint32 mapid)
{ 
    return sWorld->getBoolConfig(CONFIG_INSTANCE_SHARED_ID) && (mapid == 631 || mapid == 724); 
}

uint32 GetLiquidFlags(uint32 liquidType)
{
    if (LiquidTypeEntry const* liq = sLiquidTypeStore.LookupEntry(liquidType))
        return 1 << liq->Type;

    return 0;
}

CharStartOutfitEntry const* GetCharStartOutfitEntry(uint8 race, uint8 class_, uint8 gender)
{
    std::map<uint32, CharStartOutfitEntry const*>::const_iterator itr = sCharStartOutfitMap.find(race | (class_ << 8) | (gender << 16));
    if (itr == sCharStartOutfitMap.end())
        return NULL;

    return itr->second;
}

/// Returns LFGDungeonEntry for a specific map and difficulty. Will return first found entry if multiple dungeons use the same map (such as Scarlet Monastery)
LFGDungeonEntry const* GetLFGDungeon(uint32 mapId, Difficulty difficulty)
{
    for (uint32 i = 0; i < sLFGDungeonStore.GetNumRows(); ++i)
    {
        LFGDungeonEntry const* dungeon = sLFGDungeonStore.LookupEntry(i);
        if (!dungeon)
            continue;

        if (dungeon->map == int32(mapId) && Difficulty(dungeon->difficulty) == difficulty)
            return dungeon;
    }

    return NULL;
}

uint32 GetDefaultMapLight(uint32 mapId)
{
    for (int32 i = sLightStore.GetNumRows(); i >= 0; --i)
    {
        LightEntry const* light = sLightStore.LookupEntry(uint32(i));
        if (!light)
            continue;

        if (light->MapId == mapId && light->X == 0.0f && light->Y == 0.0f && light->Z == 0.0f)
            return light->Id;
    }

    return 0;
}
