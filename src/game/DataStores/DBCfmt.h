/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef TRINITY_DBCSFRM_H
#define TRINITY_DBCSFRM_H

char const Achievementfmt[] = "niixssssssssssssssssxxxxxxxxxxxxxxxxxxiixixxxxxxxxxxxxxxxxxxii";
const std::string CustomAchievementfmt="pppaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaapapaaaaaaaaaaaaaaaaaapp";
const std::string CustomAchievementIndex = "ID";
char const AchievementCategoryfmt[] = "nixxxxxxxxxxxxxxxxxx";
char const AchievementCriteriafmt[] = "niiiiiiiixxxxxxxxxxxxxxxxxiiiix";
char const AreaTableEntryfmt[] = "niiiixxxxxissssssssssssssssxiiiiixxx";
char const AreaGroupEntryfmt[] = "niiiiiii";
char const AreaPOIEntryfmt[] = "niiiiiiiiiiifffixixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxix";
char const AreaTriggerEntryfmt[] = "niffffffff";
char const AuctionHouseEntryfmt[] = "niiixxxxxxxxxxxxxxxxx";
char const BankBagSlotPricesEntryfmt[] = "ni";
char const BarberShopStyleEntryfmt[] = "nixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxiii";
char const BattlemasterListEntryfmt[] = "niiiiiiiiixssssssssssssssssxiixx";
char const CharStartOutfitEntryfmt[] = "dbbbXiiiiiiiiiiiiiiiiiiiiiiiixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
char const CharTitlesEntryfmt[] = "nxssssssssssssssssxssssssssssssssssxi";
char const ChatChannelsEntryfmt[] = "nixssssssssssssssssxxxxxxxxxxxxxxxxxx";
                                                            // ChatChannelsEntryfmt, index not used (more compact store)
char const ChrClassesEntryfmt[] = "nxixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxixii";
char const ChrRacesEntryfmt[] = "nxixiixixxxxixssssssssssssssssxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxi";
char const CinematicSequencesEntryfmt[] = "nxxxxxxxxx";
char const CreatureDisplayInfofmt[] = "nixxfxxxxxxxxxxx";
char const CreatureFamilyfmt[] = "nfifiiiiixssssssssssssssssxx";
char const CreatureModelDatafmt[] = "nxxxfxxxxxxxxxxffxxxxxxxxxxx";
char const CreatureSpellDatafmt[] = "niiiixxxx";
char const CreatureTypefmt[] = "nxxxxxxxxxxxxxxxxxx";
char const CurrencyTypesfmt[] = "xnxi";
char const DestructibleModelDatafmt[] = "nxxixxxixxxixxxixxx";
char const DungeonEncounterfmt[] = "niixissssssssssssssssxx";
char const DurabilityCostsfmt[] = "niiiiiiiiiiiiiiiiiiiiiiiiiiiii";
char const DurabilityQualityfmt[] = "nf";
char const EmotesEntryfmt[] = "nxxiiix";
char const EmotesTextEntryfmt[] = "nxixxxxxxxxxxxxxxxx";
char const FactionEntryfmt[] = "niiiiiiiiiiiiiiiiiiffixssssssssssssssssxxxxxxxxxxxxxxxxxx";
char const FactionTemplateEntryfmt[] = "niiiiiiiiiiiii";
char const GameObjectDisplayInfofmt[] = "nsxxxxxxxxxxffffffx";
char const GemPropertiesEntryfmt[] = "nixxi";
char const GlyphPropertiesfmt[] = "niii";
char const GlyphSlotfmt[] = "nii";
char const GtBarberShopCostBasefmt[] = "f";
char const GtCombatRatingsfmt[] = "f";
char const GtChanceToMeleeCritBasefmt[] = "f";
char const GtChanceToMeleeCritfmt[] = "f";
char const GtChanceToSpellCritBasefmt[] = "f";
char const GtChanceToSpellCritfmt[] = "f";
char const GtNPCManaCostScalerfmt[] = "f";
char const GtOCTClassCombatRatingScalarfmt[] = "df";
char const GtOCTRegenHPfmt[] = "f";
//char const GtOCTRegenMPfmt[] = "f";
char const GtRegenHPPerSptfmt[] = "f";
char const GtRegenMPPerSptfmt[] = "f";
char const Holidaysfmt[] = "niiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiixxsiix";
char const ItemBagFamilyfmt[] = "nxxxxxxxxxxxxxxxxx";
char const ItemDisplayTemplateEntryfmt[] = "nxxxxsxxxxxxxxxxxxxxxxxxx";
//char const ItemCondExtCostsEntryfmt[] = "xiii";
char const ItemExtendedCostEntryfmt[] = "niiiiiiiiiiiiiix";
char const ItemLimitCategoryEntryfmt[] = "nxxxxxxxxxxxxxxxxxii";
char const ItemRandomPropertiesfmt[] = "nxiiixxssssssssssssssssx";
char const ItemRandomSuffixfmt[] = "nssssssssssssssssxxiiixxiiixx";
char const ItemSetEntryfmt[] = "dssssssssssssssssxiiiiiiiiiixxxxxxxiiiiiiiiiiiiiiiiii";
char const LFGDungeonEntryfmt[] = "nssssssssssssssssxiiiiiiiiixxixixxxxxxxxxxxxxxxxx";
char const LightEntryfmt[] = "nifffxxxxxxxxxx";
char const LiquidTypefmt[] = "nxxixixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
char const LockEntryfmt[] = "niiiiiiiiiiiiiiiiiiiiiiiixxxxxxxx";
char const MailTemplateEntryfmt[] = "nxxxxxxxxxxxxxxxxxssssssssssssssssx";
char const MapEntryfmt[] = "nxiixssssssssssssssssxixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxixiffxiii";
char const MapDifficultyEntryfmt[] = "diisxxxxxxxxxxxxxxxxiix";
char const MovieEntryfmt[] = "nxx";
char const OverrideSpellDatafmt[] = "niiiiiiiiiix";
char const PowerDisplayfmt[] = "nixxxx";
char const QuestSortEntryfmt[] = "nxxxxxxxxxxxxxxxxx";
char const QuestXPfmt[] = "niiiiiiiiii";
char const QuestFactionRewardfmt[] = "niiiiiiiiii";
char const PvPDifficultyfmt[] = "diiiii";
char const RandomPropertiesPointsfmt[] = "niiiiiiiiiiiiiii";
char const ScalingStatDistributionfmt[] = "niiiiiiiiiiiiiiiiiiiii";
char const ScalingStatValuesfmt[] = "iniiiiiiiiiiiiiiiiiiiiii";
char const SkillLinefmt[] = "nixssssssssssssssssxxxxxxxxxxxxxxxxxxixxxxxxxxxxxxxxxxxi";
char const SkillLineAbilityfmt[] = "niiiixxiiiiixx";
char const SoundEntriesfmt[] = "nxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
char const SpellCastTimefmt[] = "nixx";
char const SpellCategoryfmt[] = "ni";
char const SpellDifficultyfmt[] = "niiii";
const std::string CustomSpellDifficultyfmt="ppppp";
const std::string CustomSpellDifficultyIndex="id";
char const SpellDurationfmt[] = "niii";
char const SpellEntryfmt[] = "niiiiiiiiiiiixixiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiifxiiiiiiiiiiiiiiiiiiiiiiiiiiiifffiiiiiiiiiiiiiiiiiiiiifffiiiiiiiiiiiiiiifffiiiiiiiiiiiiixssssssssssssssssxssssssssssssssssxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxiiiiiiiiiiixfffxxxiiiiixxfffxx";
const std::string CustomSpellEntryfmt = "papppppppppppapapaaaaaaaaaaapaaapapppppppaaaaapaapaaaaaaaaaaaaaaaaaappppppppppppppppppppppppppppppppppppaaappppppppppppaaapppppppppaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaappppppppapppaaaaappaaaaaaa";
const std::string CustomSpellEntryIndex = "Id";
char const SpellFocusObjectfmt[] = "nxxxxxxxxxxxxxxxxx";
char const SpellItemEnchantmentfmt[] = "niiiiiiixxxiiissssssssssssssssxiiiiiii";
char const SpellItemEnchantmentConditionfmt[] = "nbbbbbxxxxxbbbbbbbbbbiiiiiXXXXX";
char const SpellRadiusfmt[] = "nfff";
char const SpellRangefmt[] = "nffffixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
char const SpellRuneCostfmt[] = "niiii";
char const SpellShapeshiftfmt[] = "nxxxxxxxxxxxxxxxxxxiixiiixxiiiiiiii";
char const StableSlotPricesfmt[] = "ni";
char const SummonPropertiesfmt[] = "niiiii";
char const TalentEntryfmt[] = "niiiiiiiixxxxixxixxixxx";
char const TalentTabEntryfmt[] = "nxxxxxxxxxxxxxxxxxxxiiix";
char const TaxiNodesEntryfmt[] = "nifffssssssssssssssssxii";
char const TaxiPathEntryfmt[] = "niii";
char const TaxiPathNodeEntryfmt[] = "diiifffiiii";
char const TeamContributionPointsfmt[] = "df";
char const TotemCategoryEntryfmt[] = "nxxxxxxxxxxxxxxxxxii";
char const TransportAnimationfmt[] = "diifffx";
char const TransportRotationfmt[] = "diiffff";
char const VehicleEntryfmt[] = "niffffiiiiiiiifffffffffffffffssssfifiixx";
char const VehicleSeatEntryfmt[] = "niiffffffffffiiiiiifffffffiiifffiiiiiiiffiiiiixxxxxxxxxxxx";
char const WMOAreaTableEntryfmt[] = "niiixxxxxiixxxxxxxxxxxxxxxxx";
char const WorldMapAreaEntryfmt[] = "xinxffffixx";
char const WorldMapOverlayEntryfmt[] = "nxiiiixxxxxxxxxxx";
char const WorldSafeLocsEntryfmt[] = "nifffxxxxxxxxxxxxxxxxx";

#endif
