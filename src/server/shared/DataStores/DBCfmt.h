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

#ifndef ACORE_DBCSFRM_H
#define ACORE_DBCSFRM_H

char constexpr Achievementfmt[] = "niixssssssssssssssssxxxxxxxxxxxxxxxxxxiixixxxxxxxxxxxxxxxxxxii";
char constexpr AchievementCategoryfmt[] = "nixxxxxxxxxxxxxxxxxx";
char constexpr AchievementCriteriafmt[] = "niiiiiiiixxxxxxxxxxxxxxxxxiiiix";
char constexpr AreaTableEntryfmt[] = "niiiixxxxxissssssssssssssssxiiiiixxx";
char constexpr AreaGroupEntryfmt[] = "niiiiiii";
char constexpr AreaPOIEntryfmt[] = "niiiiiiiiiiifffixisxxxxxxxxxxxxxxxxsxxxxxxxxxxxxxxxxix";
char constexpr AuctionHouseEntryfmt[] = "niiixxxxxxxxxxxxxxxxx";
char constexpr BankBagSlotPricesEntryfmt[] = "ni";
char constexpr BarberShopStyleEntryfmt[] = "nixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxiii";
char constexpr BattlemasterListEntryfmt[] = "niiiiiiiiixssssssssssssssssxiixx";
char constexpr CharStartOutfitEntryfmt[] = "dbbbXiiiiiiiiiiiiiiiiiiiiiiiixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
char constexpr CharTitlesEntryfmt[] = "nxssssssssssssssssxssssssssssssssssxi";
char constexpr ChatChannelsEntryfmt[] = "nixssssssssssssssssxxxxxxxxxxxxxxxxxx"; // ChatChannelsEntryfmt, index not used (more compact store)
char constexpr ChrClassesEntryfmt[] = "nxixssssssssssssssssxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxixii";
char constexpr ChrRacesEntryfmt[] = "niixiixixxxxixssssssssssssssssxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxi";
char constexpr CinematicCameraEntryfmt[] = "nsiffff";
char constexpr CinematicSequencesEntryfmt[] = "nxixxxxxxx";
char constexpr CreatureDisplayInfofmt[] = "nixifxxxxxxxxxxx";
char constexpr CreatureDisplayInfoExtrafmt[] = "dixxxxxxxxxxxxxxxxxxx";
char constexpr CreatureFamilyfmt[] = "nfifiiiiixssssssssssssssssxx";
char constexpr CreatureModelDatafmt[] = "nixxfxxxxxxxxxfffxxxxxxxxxxx";
char constexpr CreatureSpellDatafmt[] = "niiiixxxx";
char constexpr CreatureTypefmt[] = "nxxxxxxxxxxxxxxxxxx";
char constexpr CurrencyTypesfmt[] = "xnxi";
char constexpr DestructibleModelDatafmt[] = "nxxixxxixxxixxxixxx";
char constexpr DungeonEncounterfmt[] = "niixissssssssssssssssxx";
char constexpr DurabilityCostsfmt[] = "niiiiiiiiiiiiiiiiiiiiiiiiiiiii";
char constexpr DurabilityQualityfmt[] = "nf";
char constexpr EmotesEntryfmt[] = "nxxiiix";
char constexpr EmotesTextEntryfmt[] = "nxixxxxxxxxxxxxxxxx";
char constexpr FactionEntryfmt[] = "niiiiiiiiiiiiiiiiiiffixssssssssssssssssxxxxxxxxxxxxxxxxxx";
char constexpr FactionTemplateEntryfmt[] = "niiiiiiiiiiiii";
char constexpr GameObjectArtKitfmt[] = "nxxxxxxx";
char constexpr GameObjectDisplayInfofmt[] = "nsxxxxxxxxxxffffffx";
char constexpr GemPropertiesEntryfmt[] = "nixxi";
char constexpr GlyphPropertiesfmt[] = "niix";
char constexpr GlyphSlotfmt[] = "nii";
char constexpr GtBarberShopCostBasefmt[] = "df";
char constexpr GtCombatRatingsfmt[] = "df";
char constexpr GtChanceToMeleeCritBasefmt[] = "df";
char constexpr GtChanceToMeleeCritfmt[] = "df";
char constexpr GtChanceToSpellCritBasefmt[] = "df";
char constexpr GtChanceToSpellCritfmt[] = "df";
char constexpr GtNPCManaCostScalerfmt[] = "df";
char constexpr GtOCTClassCombatRatingScalarfmt[] = "df";
char constexpr GtOCTRegenHPfmt[] = "df";
//char constexpr GtOCTRegenMPfmt[] = "f";
char constexpr GtRegenHPPerSptfmt[] = "df";
char constexpr GtRegenMPPerSptfmt[] = "df";
char constexpr Holidaysfmt[] = "niiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiixxsiix";
char constexpr Itemfmt[] = "niiiiiii";
char constexpr ItemBagFamilyfmt[] = "nxxxxxxxxxxxxxxxxx";
char constexpr ItemDisplayTemplateEntryfmt[] = "nxxxxsxxxxxxxxxxxxxxxxxxx";
//char constexpr ItemCondExtCostsEntryfmt[] = "xiii";
char constexpr ItemExtendedCostEntryfmt[] = "niiiiiiiiiiiiiix";
char constexpr ItemLimitCategoryEntryfmt[] = "nxxxxxxxxxxxxxxxxxii";
char constexpr ItemRandomPropertiesfmt[] = "nxiiiiissssssssssssssssx";
char constexpr ItemRandomSuffixfmt[] = "nssssssssssssssssxxiiiiiiiiii";
char constexpr ItemSetEntryfmt[] = "dssssssssssssssssxiiiiiiiiiixxxxxxxiiiiiiiiiiiiiiiiii";
char constexpr LFGDungeonEntryfmt[] = "nssssssssssssssssxiiiiiiiiixxixixxxxxxxxxxxxxxxxx";
char constexpr LightEntryfmt[] = "nifffxxxxxxxxxx";
char constexpr LiquidTypefmt[] = "nxxixixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
char constexpr LockEntryfmt[] = "niiiiiiiiiiiiiiiiiiiiiiiixxxxxxxx";
char constexpr MailTemplateEntryfmt[] = "nxxxxxxxxxxxxxxxxxssssssssssssssssx";
char constexpr MapEntryfmt[] = "nxiixssssssssssssssssxixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxixiffxixi";
char constexpr MapDifficultyEntryfmt[] = "diisxxxxxxxxxxxxxxxxiix";
char constexpr MovieEntryfmt[] = "nxx";
char constexpr NamesReservedfmt[] = "xsx";
char constexpr NamesProfanityfmt[] = "xsx";
char constexpr OverrideSpellDatafmt[] = "niiiiiiiiiix";
char constexpr PowerDisplayfmt[] = "nixxxx";
char constexpr QuestSortEntryfmt[] = "nxxxxxxxxxxxxxxxxx";
char constexpr QuestXPfmt[] = "niiiiiiiiii";
char constexpr QuestFactionRewardfmt[] = "niiiiiiiiii";
char constexpr PvPDifficultyfmt[] = "diiiii";
char constexpr RandomPropertiesPointsfmt[] = "niiiiiiiiiiiiiii";
char constexpr ScalingStatDistributionfmt[] = "niiiiiiiiiiiiiiiiiiiii";
char constexpr ScalingStatValuesfmt[] = "iniiiiiiiiiiiiiiiiiiiiii";
char constexpr SkillLinefmt[] = "nixssssssssssssssssxxxxxxxxxxxxxxxxxxixxxxxxxxxxxxxxxxxi";
char constexpr SkillLineAbilityfmt[] = "niiiixxiiiiixx";
char constexpr SkillRaceClassInfofmt[] = "diiiixix";
char constexpr SkillTiersfmt[] = "nxxxxxxxxxxxxxxxxiiiiiiiiiiiiiiii";
char constexpr SoundEntriesfmt[] = "nxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
char constexpr SpellCastTimefmt[] = "nixx";
char constexpr SpellCategoryfmt[] = "ni";
char constexpr SpellDifficultyfmt[] = "niiii";
char constexpr SpellDurationfmt[] = "niii";
char constexpr SpellEntryfmt[] = "niiiiiiiiiiiixixiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiifxiiiiiiiiiiiiiiiiiiiiiiiiiiiifffiiiiiiiiiiiiiiiiiiiiifffiiiiiiiiiiiiiiifffiiiiiiiiiiiiiissssssssssssssssxssssssssssssssssxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxiiiiiiiiiiixfffxxxiiiiixxfffxx";
char constexpr SpellFocusObjectfmt[] = "nxxxxxxxxxxxxxxxxx";
char constexpr SpellItemEnchantmentfmt[] = "niiiiiiixxxiiissssssssssssssssxiiiiiii";
char constexpr SpellItemEnchantmentConditionfmt[] = "nbbbbbxxxxxbbbbbbbbbbiiiiiXXXXX";
char constexpr SpellRadiusfmt[] = "nfff";
char constexpr SpellRangefmt[] = "nffffixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
char constexpr SpellRuneCostfmt[] = "niiii";
char constexpr SpellShapeshiftFormEntryfmt[] = "nxxxxxxxxxxxxxxxxxxiixiiixxiiiiiiii";
char constexpr SpellVisualfmt[] = "dxxxxxxiixxxxxxxxxxxxxxxxxxxxxxx";
char constexpr StableSlotPricesfmt[] = "ni";
char constexpr SummonPropertiesfmt[] = "niiiii";
char constexpr TalentEntryfmt[] = "niiiiiiiixxxxixxixxixxx";
char constexpr TalentTabEntryfmt[] = "nxxxxxxxxxxxxxxxxxxxiiix";
char constexpr TaxiNodesEntryfmt[] = "nifffssssssssssssssssxii";
char constexpr TaxiPathEntryfmt[] = "niii";
char constexpr TaxiPathNodeEntryfmt[] = "diiifffiiii";
char constexpr TeamContributionPointsfmt[] = "df";
char constexpr TotemCategoryEntryfmt[] = "nxxxxxxxxxxxxxxxxxii";
char constexpr TransportAnimationfmt[] = "diifffx";
char constexpr TransportRotationfmt[] = "diiffff";
char constexpr VehicleEntryfmt[] = "niffffiiiiiiiifffffffffffffffssssfifiixx";
char constexpr VehicleSeatEntryfmt[] = "niiffffffffffiiiiiifffffffiiifffiiiiiiiffiiiiixxxxxxxxxxxx";
char constexpr WMOAreaTableEntryfmt[] = "niiixxxxxiixxxxxxxxxxxxxxxxx";
char constexpr WorldMapAreaEntryfmt[] = "xinxffffixx";
char constexpr WorldMapOverlayEntryfmt[] = "nxiiiixxxxxxxxxxx";

#endif
