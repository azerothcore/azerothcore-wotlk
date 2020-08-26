/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2020 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "DBCStores.h"
#include "DBCFileLoader.h"
#include "DBCfmt.h"
#include "Errors.h"
#include "Log.h"
#include "SharedDefines.h"
#include "SpellMgr.h"
#include "TransportMgr.h"
#include "BattlegroundMgr.h"
#include "World.h"
#include <map>

typedef std::map<uint16, uint32> AreaFlagByAreaID;
typedef std::map<uint32, uint32> AreaFlagByMapID;

typedef std::tuple<int16, int8, int32> WMOAreaTableKey;
typedef std::map<WMOAreaTableKey, WMOAreaTableEntry const*> WMOAreaInfoByTripple;

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

// store absolute bit position for first rank for talent inspect
static uint32 sTalentTabPages[MAX_CLASSES][3];

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
inline void LoadDBC(uint32& availableDbcLocales, StoreProblemList& errors, DBCStorage<T>& storage, std::string const& dbcPath, std::string const& filename, char const* dbTable = nullptr)
{
    // compatibility format and C++ structure sizes
    ASSERT(DBCFileLoader::GetFormatRecordSize(storage.GetFormat()) == sizeof(T) || LoadDBC_assert_print(DBCFileLoader::GetFormatRecordSize(storage.GetFormat()), sizeof(T), filename));

    ++DBCFileCount;
    std::string dbcFilename = dbcPath + filename;
    bool existDBData = false;

    if (storage.Load(dbcFilename.c_str()))
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
                availableDbcLocales &= ~(1 << i);             // mark as not available for speedup next checks
        }
    }

    if (dbTable)
        storage.LoadFromDB(dbTable, storage.GetFormat());

    if (storage.GetNumRows())
        existDBData = true;

    if (!existDBData)
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
}

void LoadDBCStores(const std::string& dataPath)
{
    uint32 oldMSTime = getMSTime();

    std::string dbcPath = dataPath + "dbc/";

    StoreProblemList bad_dbc_files;
    uint32 availableDbcLocales = 0xFFFFFFFF;

#define LOAD_DBC(store, file, dbtable) LoadDBC(availableDbcLocales, bad_dbc_files, store, dbcPath, file, dbtable)

    LOAD_DBC(sAreaTableStore,                       "AreaTable.dbc",                        "areatable_dbc");
    LOAD_DBC(sAchievementStore,                     "Achievement.dbc",                      "achievement_dbc");
    LOAD_DBC(sAchievementCategoryStore,             "Achievement_Category.dbc",             "achievement_category_dbc");
    LOAD_DBC(sAchievementCriteriaStore,             "Achievement_Criteria.dbc",             "achievement_criteria_dbc");
    LOAD_DBC(sAreaGroupStore,                       "AreaGroup.dbc",                        "areagroup_dbc");
    LOAD_DBC(sAreaPOIStore,                         "AreaPOI.dbc",                          "areapoi_dbc");
    LOAD_DBC(sAuctionHouseStore,                    "AuctionHouse.dbc",                     "auctionhouse_dbc");
    LOAD_DBC(sBankBagSlotPricesStore,               "BankBagSlotPrices.dbc",                "bankbagslotprices_dbc");
    LOAD_DBC(sBattlemasterListStore,                "BattlemasterList.dbc",                 "battlemasterlist_dbc");
    LOAD_DBC(sBarberShopStyleStore,                 "BarberShopStyle.dbc",                  "barbershopstyle_dbc");
    LOAD_DBC(sCharStartOutfitStore,                 "CharStartOutfit.dbc",                  "charstartoutfit_dbc");
    LOAD_DBC(sCharTitlesStore,                      "CharTitles.dbc",                       "chartitles_dbc");
    LOAD_DBC(sChatChannelsStore,                    "ChatChannels.dbc",                     "chatchannels_dbc");
    LOAD_DBC(sChrClassesStore,                      "ChrClasses.dbc",                       "chrclasses_dbc");
    LOAD_DBC(sChrRacesStore,                        "ChrRaces.dbc",                         "chrraces_dbc");
    LOAD_DBC(sCinematicSequencesStore,              "CinematicSequences.dbc",               "cinematicsequences_dbc");
    LOAD_DBC(sCreatureDisplayInfoStore,             "CreatureDisplayInfo.dbc",              "creaturedisplayinfo_dbc");
    LOAD_DBC(sCreatureFamilyStore,                  "CreatureFamily.dbc",                   "creaturefamily_dbc");
    LOAD_DBC(sCreatureModelDataStore,               "CreatureModelData.dbc",                "creaturemodeldata_dbc");
    LOAD_DBC(sCreatureSpellDataStore,               "CreatureSpellData.dbc",                "creaturespelldata_dbc");
    LOAD_DBC(sCreatureTypeStore,                    "CreatureType.dbc",                     "creaturetype_dbc");
    LOAD_DBC(sCurrencyTypesStore,                   "CurrencyTypes.dbc",                    "currencytypes_dbc");
    LOAD_DBC(sDestructibleModelDataStore,           "DestructibleModelData.dbc",            "destructiblemodeldata_dbc");
    LOAD_DBC(sDungeonEncounterStore,                "DungeonEncounter.dbc",                 "dungeonencounter_dbc");
    LOAD_DBC(sDurabilityCostsStore,                 "DurabilityCosts.dbc",                  "durabilitycosts_dbc");
    LOAD_DBC(sDurabilityQualityStore,               "DurabilityQuality.dbc",                "durabilityquality_dbc");
    LOAD_DBC(sEmotesStore,                          "Emotes.dbc",                           "emotes_dbc");
    LOAD_DBC(sEmotesTextStore,                      "EmotesText.dbc",                       "emotestext_dbc");
    LOAD_DBC(sFactionStore,                         "Faction.dbc",                          "faction_dbc");
    LOAD_DBC(sFactionTemplateStore,                 "FactionTemplate.dbc",                  "factiontemplate_dbc");
    LOAD_DBC(sGameObjectDisplayInfoStore,           "GameObjectDisplayInfo.dbc",            "gameobjectdisplayinfo_dbc");
    LOAD_DBC(sGemPropertiesStore,                   "GemProperties.dbc",                    "gemproperties_dbc");
    LOAD_DBC(sGlyphPropertiesStore,                 "GlyphProperties.dbc",                  "glyphproperties_dbc");
    LOAD_DBC(sGlyphSlotStore,                       "GlyphSlot.dbc",                        "glyphslot_dbc");
    LOAD_DBC(sGtBarberShopCostBaseStore,            "gtBarberShopCostBase.dbc",             "gtbarbershopcostbase_dbc");
    LOAD_DBC(sGtCombatRatingsStore,                 "gtCombatRatings.dbc",                  "gtcombatratings_dbc");
    LOAD_DBC(sGtChanceToMeleeCritBaseStore,         "gtChanceToMeleeCritBase.dbc",          "gtchancetomeleecritbase_dbc");
    LOAD_DBC(sGtChanceToMeleeCritStore,             "gtChanceToMeleeCrit.dbc",              "gtchancetomeleecrit_dbc");
    LOAD_DBC(sGtChanceToSpellCritBaseStore,         "gtChanceToSpellCritBase.dbc",          "gtchancetospellcritbase_dbc");
    LOAD_DBC(sGtChanceToSpellCritStore,             "gtChanceToSpellCrit.dbc",              "gtchancetospellcrit_dbc");
    LOAD_DBC(sGtNPCManaCostScalerStore,             "gtNPCManaCostScaler.dbc",              "gtnpcmanacostscaler_dbc");
    LOAD_DBC(sGtOCTClassCombatRatingScalarStore,    "gtOCTClassCombatRatingScalar.dbc",     "gtoctclasscombatratingscalar_dbc");
    LOAD_DBC(sGtOCTRegenHPStore,                    "gtOCTRegenHP.dbc",                     "gtoctregenhp_dbc");
    //LOAD_DBC(sGtOCTRegenMPStore,                  "gtOCTRegenMP.dbc",                     "gtoctregenmp_dbc");       -- not used currently
    LOAD_DBC(sGtRegenHPPerSptStore,                 "gtRegenHPPerSpt.dbc",                  "gtregenhpperspt_dbc");
    LOAD_DBC(sGtRegenMPPerSptStore,                 "gtRegenMPPerSpt.dbc",                  "gtregenmpperspt_dbc");
    LOAD_DBC(sHolidaysStore,                        "Holidays.dbc",                         "holidays_dbc");
    LOAD_DBC(sItemBagFamilyStore,                   "ItemBagFamily.dbc",                    "itembagfamily_dbc");
    LOAD_DBC(sItemDisplayInfoStore,                 "ItemDisplayInfo.dbc",                  "itemdisplayinfo_dbc");
    //LOAD_DBC(sItemCondExtCostsStore,              "ItemCondExtCosts.dbc",                 "itemcondextcosts_dbc");
    LOAD_DBC(sItemExtendedCostStore,                "ItemExtendedCost.dbc",                 "itemextendedcost_dbc");
    LOAD_DBC(sItemLimitCategoryStore,               "ItemLimitCategory.dbc",                "itemlimitcategory_dbc");
    LOAD_DBC(sItemRandomPropertiesStore,            "ItemRandomProperties.dbc",             "itemrandomproperties_dbc");
    LOAD_DBC(sItemRandomSuffixStore,                "ItemRandomSuffix.dbc",                 "itemrandomsuffix_dbc");
    LOAD_DBC(sItemSetStore,                         "ItemSet.dbc",                          "itemset_dbc");
    LOAD_DBC(sLFGDungeonStore,                      "LFGDungeons.dbc",                      "lfgdungeons_dbc");
    LOAD_DBC(sLightStore,                           "Light.dbc",                            "light_dbc");
    LOAD_DBC(sLiquidTypeStore,                      "LiquidType.dbc",                       "liquidtype_dbc");
    LOAD_DBC(sLockStore,                            "Lock.dbc",                             "lock_dbc");
    LOAD_DBC(sMailTemplateStore,                    "MailTemplate.dbc",                     "mailtemplate_dbc");
    LOAD_DBC(sMapStore,                             "Map.dbc",                              "map_dbc");
    LOAD_DBC(sMapDifficultyStore,                   "MapDifficulty.dbc",                    "mapdifficulty_dbc");
    LOAD_DBC(sMovieStore,                           "Movie.dbc",                            "movie_dbc");
    LOAD_DBC(sOverrideSpellDataStore,               "OverrideSpellData.dbc",                "overridespelldata_dbc");
    LOAD_DBC(sPowerDisplayStore,                    "PowerDisplay.dbc",                     "powerdisplay_dbc");
    LOAD_DBC(sPvPDifficultyStore,                   "PvpDifficulty.dbc",                    "pvpdifficulty_dbc");
    LOAD_DBC(sQuestXPStore,                         "QuestXP.dbc",                          "questxp_dbc");
    LOAD_DBC(sQuestFactionRewardStore,              "QuestFactionReward.dbc",               "questfactionreward_dbc");
    LOAD_DBC(sQuestSortStore,                       "QuestSort.dbc",                        "questsort_dbc");
    LOAD_DBC(sRandomPropertiesPointsStore,          "RandPropPoints.dbc",                   "randproppoints_dbc");
    LOAD_DBC(sScalingStatDistributionStore,         "ScalingStatDistribution.dbc",          "scalingstatdistribution_dbc");
    LOAD_DBC(sScalingStatValuesStore,               "ScalingStatValues.dbc",                "scalingstatvalues_dbc");
    LOAD_DBC(sSkillLineStore,                       "SkillLine.dbc",                        "skillline_dbc");
    LOAD_DBC(sSkillLineAbilityStore,                "SkillLineAbility.dbc",                 "skilllineability_dbc");
    LOAD_DBC(sSoundEntriesStore,                    "SoundEntries.dbc",                     "soundentries_dbc");
    LOAD_DBC(sSpellStore,                           "Spell.dbc",                            "spell_dbc");
    LOAD_DBC(sSpellCastTimesStore,                  "SpellCastTimes.dbc",                   "spellcasttimes_dbc");
    LOAD_DBC(sSpellCategoryStore,                   "SpellCategory.dbc",                    "spellcategory_dbc");
    LOAD_DBC(sSpellDifficultyStore,                 "SpellDifficulty.dbc",                  "spelldifficulty_dbc");
    LOAD_DBC(sSpellDurationStore,                   "SpellDuration.dbc",                    "spellduration_dbc");
    LOAD_DBC(sSpellFocusObjectStore,                "SpellFocusObject.dbc",                 "spellfocusobject_dbc");
    LOAD_DBC(sSpellItemEnchantmentStore,            "SpellItemEnchantment.dbc",             "spellitemenchantment_dbc");
    LOAD_DBC(sSpellItemEnchantmentConditionStore,   "SpellItemEnchantmentCondition.dbc",    "spellitemenchantmentcondition_dbc");
    LOAD_DBC(sSpellRadiusStore,                     "SpellRadius.dbc",                      "spellradius_dbc");
    LOAD_DBC(sSpellRangeStore,                      "SpellRange.dbc",                       "spellrange_dbc");
    LOAD_DBC(sSpellRuneCostStore,                   "SpellRuneCost.dbc",                    "spellrunecost_dbc");
    LOAD_DBC(sSpellShapeshiftStore,                 "SpellShapeshiftForm.dbc",              "spellshapeshiftform_dbc");
    LOAD_DBC(sStableSlotPricesStore,                "StableSlotPrices.dbc",                 "stableslotprices_dbc");
    LOAD_DBC(sSummonPropertiesStore,                "SummonProperties.dbc",                 "summonproperties_dbc");
    LOAD_DBC(sTalentStore,                          "Talent.dbc",                           "talent_dbc");
    LOAD_DBC(sTalentTabStore,                       "TalentTab.dbc",                        "talenttab_dbc");
    LOAD_DBC(sTaxiNodesStore,                       "TaxiNodes.dbc",                        "taxinodes_dbc");
    LOAD_DBC(sTaxiPathStore,                        "TaxiPath.dbc",                         "taxipath_dbc");
    LOAD_DBC(sTaxiPathNodeStore,                    "TaxiPathNode.dbc",                     "taxipathnode_dbc");
    LOAD_DBC(sTeamContributionPointsStore,          "TeamContributionPoints.dbc",           "teamcontributionpoints_dbc");
    LOAD_DBC(sTotemCategoryStore,                   "TotemCategory.dbc",                    "totemcategory_dbc");
    LOAD_DBC(sTransportAnimationStore,              "TransportAnimation.dbc",               "transportanimation_dbc");
    LOAD_DBC(sTransportRotationStore,               "TransportRotation.dbc",                "transportrotation_dbc");
    LOAD_DBC(sVehicleStore,                         "Vehicle.dbc",                          "vehicle_dbc");
    LOAD_DBC(sVehicleSeatStore,                     "VehicleSeat.dbc",                      "vehicleseat_dbc");
    LOAD_DBC(sWMOAreaTableStore,                    "WMOAreaTable.dbc",                     "wmoareatable_dbc");
    LOAD_DBC(sWorldMapAreaStore,                    "WorldMapArea.dbc",                     "worldmaparea_dbc");
    LOAD_DBC(sWorldMapOverlayStore,                 "WorldMapOverlay.dbc",                  "worldmapoverlay_dbc"); 

#undef LOAD_DBC

    for (CharStartOutfitEntry const* outfit : sCharStartOutfitStore)
        sCharStartOutfitMap[outfit->Race | (outfit->Class << 8) | (outfit->Gender << 16)] = outfit;
    
    for (FactionEntry const* faction : sFactionStore)
    {
        if (faction->team)
        {
            SimpleFactionsList& flist = sFactionTeamMap[faction->team];
            flist.push_back(faction->ID);
        }
    }
    
    for (GameObjectDisplayInfoEntry const* info : sGameObjectDisplayInfoStore)
    {
        if (info->maxX < info->minX)
            std::swap(*(float*)(&info->maxX), *(float*)(&info->minX));

        if (info->maxY < info->minY)
            std::swap(*(float*)(&info->maxY), *(float*)(&info->minY));

        if (info->maxZ < info->minZ)
            std::swap(*(float*)(&info->maxZ), *(float*)(&info->minZ));
    }
    
    // fill data
    for (MapDifficultyEntry const* entry : sMapDifficultyStore)
        sMapDifficultyMap[MAKE_PAIR32(entry->MapId, entry->Difficulty)] = MapDifficulty(entry->resetTime, entry->maxPlayers, entry->areaTriggerText[0] != '\0');

    for (PvPDifficultyEntry const* entry : sPvPDifficultyStore)
        if (entry->bracketId > MAX_BATTLEGROUND_BRACKETS)
            ASSERT(false && "Need update MAX_BATTLEGROUND_BRACKETS by DBC data");
    
    for (auto i : sSpellStore)
        if (i->Category)
            sSpellsByCategoryStore[i->Category].insert(i->Id);

    for (SkillLineAbilityEntry const* skillLine : sSkillLineAbilityStore)
    {
        SpellEntry const* spellInfo = sSpellStore.LookupEntry(skillLine->spellId);
        if (spellInfo && spellInfo->Attributes & SPELL_ATTR0_PASSIVE)
        {
            for (CreatureFamilyEntry const* cFamily : sCreatureFamilyStore)
            {
                if (skillLine->skillId != cFamily->skillLine[0] && skillLine->skillId != cFamily->skillLine[1])
                    continue;

                if (spellInfo->spellLevel)
                    continue;

                if (skillLine->learnOnGetSkill != ABILITY_LEARNED_ON_GET_RACE_OR_CLASS_SKILL)
                    continue;

                sPetFamilySpellsStore[cFamily->ID].insert(spellInfo->Id);
            }
        }
    }

    // Create Spelldifficulty searcher
    for (SpellDifficultyEntry const* spellDiff : sSpellDifficultyStore)
    {
        SpellDifficultyEntry newEntry;

        memset(newEntry.SpellID, 0, 4 * sizeof(uint32));

        for (uint8 x = 0; x < MAX_DIFFICULTY; ++x)
        {
            if (spellDiff->SpellID[x] <= 0 || !sSpellStore.LookupEntry(spellDiff->SpellID[x]))
            {
                if (spellDiff->SpellID[x] > 0) //don't show error if spell is <= 0, not all modes have spells and there are unknown negative values
                    sLog->outErrorDb("spelldifficulty_dbc: spell %i at field id: %u at spellid %i does not exist in SpellStore (spell.dbc), loaded as 0", spellDiff->SpellID[x], spellDiff->ID, x);

                newEntry.SpellID[x] = 0; // spell was <= 0 or invalid, set to 0
            }
            else
                newEntry.SpellID[x] = spellDiff->SpellID[x];
        }

        if (newEntry.SpellID[0] <= 0 || newEntry.SpellID[1] <= 0) // id0-1 must be always set!
            continue;

        for (uint8 x = 0; x < MAX_DIFFICULTY; ++x)
            if (newEntry.SpellID[x])
                sSpellMgr->SetSpellDifficultyId(uint32(newEntry.SpellID[x]), spellDiff->ID);
    }

    // create talent spells set
    for (TalentEntry const* talentInfo : sTalentStore)
        for (uint8 j = 0; j < MAX_TALENT_RANK; ++j)
            if (talentInfo->RankID[j])
                sTalentSpellPosMap[talentInfo->RankID[j]] = TalentSpellPos(talentInfo->TalentID, j);

    // prepare fast data access to bit pos of talent ranks for use at inspecting
    {
        // now have all max ranks (and then bit amount used for store talent ranks in inspect)
        for (uint32 talentTabId = 1; talentTabId < sTalentTabStore.GetNumRows(); ++talentTabId)
        {
            TalentTabEntry const* talentTabInfo = sTalentTabStore.LookupEntry(talentTabId);
            if (!talentTabInfo)
                continue;

            // prevent memory corruption; otherwise cls will become 12 below
            if ((talentTabInfo->ClassMask & CLASSMASK_ALL_PLAYABLE) == 0)
                continue;

            // store class talent tab pages
            for (uint32 cls = 1; cls < MAX_CLASSES; ++cls)
                if (talentTabInfo->ClassMask & (1 << (cls - 1)))
                    sTalentTabPages[cls][talentTabInfo->tabpage] = talentTabId;
        }
    }
    
    for (uint32 i = 1; i < sTaxiPathStore.GetNumRows(); ++i)
        if (TaxiPathEntry const* entry = sTaxiPathStore.LookupEntry(i))
            sTaxiPathSetBySource[entry->from][entry->to] = TaxiPathBySourceAndDestination(entry->ID, entry->price);

    

    // Calculate path nodes count
    uint32 pathCount = sTaxiPathStore.GetNumRows();
    std::vector<uint32> pathLength;
    pathLength.resize(pathCount);                           // 0 and some other indexes not used

    for (uint32 i = 1; i < sTaxiPathNodeStore.GetNumRows(); ++i)
        if (TaxiPathNodeEntry const* entry = sTaxiPathNodeStore.LookupEntry(i))
            if (pathLength[entry->path] < entry->index + 1)
                pathLength[entry->path] = entry->index + 1;

    // Set path length
    sTaxiPathNodesByPath.resize(pathCount);                 // 0 and some other indexes not used
    for (uint32 i = 1; i < sTaxiPathNodesByPath.size(); ++i)
        sTaxiPathNodesByPath[i].resize(pathLength[i]);

    // fill data
    for (TaxiPathNodeEntry const* entry : sTaxiPathNodeStore)
        sTaxiPathNodesByPath[entry->path][entry->index] = entry;

    // Initialize global taxinodes mask
    // include existed nodes that have at least single not spell base (scripted) path
    {
        std::set<uint32> spellPaths;
        for (SpellEntry const* sInfo : sSpellStore)
            for (uint8 j = 0; j < MAX_SPELL_EFFECTS; ++j)
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

    for (TransportAnimationEntry const* anim : sTransportAnimationStore)
        sTransportMgr->AddPathNodeToTransport(anim->TransportEntry, anim->TimeSeg, anim);
    
    for (TransportRotationEntry const* rot : sTransportRotationStore)
        sTransportMgr->AddPathRotationToTransport(rot->TransportEntry, rot->TimeSeg, rot);

    for (WMOAreaTableEntry const* entry : sWMOAreaTableStore)
        sWMOAreaInfoByTripple[WMOAreaTableKey(entry->rootId, entry->adtId, entry->groupId)] = entry;

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
        sLog->outError("You have _outdated_ DBC data. Please extract correct versions from current using client.");
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

    return nullptr;
}

char* GetPetName(uint32 petfamily, uint32 dbclang)
{
    if (!petfamily)
        return nullptr;

    CreatureFamilyEntry const* pet_family = sCreatureFamilyStore.LookupEntry(petfamily);
    if (!pet_family)
        return nullptr;

    return pet_family->Name[dbclang] ? pet_family->Name[dbclang] : nullptr;
}

TalentSpellPos const* GetTalentSpellPos(uint32 spellId)
{
    TalentSpellPosMap::const_iterator itr = sTalentSpellPosMap.find(spellId);
    if (itr == sTalentSpellPosMap.end())
        return nullptr;

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
    auto i = sWMOAreaInfoByTripple.find(WMOAreaTableKey(int16(rootid), int8(adtid), groupid));
    if (i != sWMOAreaInfoByTripple.end())
        return i->second;

    return nullptr;
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
    return itr != sMapDifficultyMap.end() ? &itr->second : nullptr;
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
    PvPDifficultyEntry const* maxEntry = nullptr;              // used for level > max listed level case

    for (PvPDifficultyEntry const* entry : sPvPDifficultyStore)
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

    return maxEntry;
}

PvPDifficultyEntry const* GetBattlegroundBracketById(uint32 mapid, BattlegroundBracketId id)
{
    for (PvPDifficultyEntry const* entry : sPvPDifficultyStore)
        if (entry->mapId == mapid && entry->GetBracketId() == id)
            return entry;

    return nullptr;
}

uint32 const* GetTalentTabPages(uint8 cls)
{
    return sTalentTabPages[cls];
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
        return nullptr;

    return itr->second;
}

/// Returns LFGDungeonEntry for a specific map and difficulty. Will return first found entry if multiple dungeons use the same map (such as Scarlet Monastery)
LFGDungeonEntry const* GetLFGDungeon(uint32 mapId, Difficulty difficulty)
{
    for (LFGDungeonEntry const* dungeon : sLFGDungeonStore)
        if (dungeon->map == int32(mapId) && Difficulty(dungeon->difficulty) == difficulty)
            return dungeon;

    return nullptr;
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
