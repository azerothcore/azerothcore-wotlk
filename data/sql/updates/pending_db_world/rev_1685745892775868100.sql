SET @Agility 	 := 3;
SET @Strength	 := 4;
SET @Intellect	 := 5;
SET @Spirit 	 := 6;
SET @Stamina	 := 7;
SET @Crit 		 := 32;
SET @Resilience  := 35;
SET @AttackPower := 38;
SET @MP5 		 := 43;
Set @SpellPower  := 45;


-- Marshal's Wyrmhide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 29005;
-- Veteran's Ornamented Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 32988;
-- Guardian's Scaled Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 32, `stat_type2` = @Stamina, `stat_value2` = 32, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @Crit, `stat_value4` = 18, `stat_type5` = @Resilience, `stat_value5` = 19 WHERE `entry` = 35178;
-- Vindicator's Dreadweave Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 32, `stat_type3` = @SpellPower, `stat_value3` = 41, `stat_type4` = @Resilience, `stat_value4` = 31 WHERE `entry` = 33882;
-- General's Silk Footguards
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 28410;
-- Marshal's Chain Bracers
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 18, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Intellect, `stat_value3` = 9, `stat_type4` = @AttackPower, `stat_value4` = 16, `stat_type5` = @Crit, `stat_value5` = 7, `stat_type6` = @Resilience, `stat_value6` = 11 WHERE `entry` = 28973;
-- Veteran's Ornamented Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 32990;
-- Marshal's Leather Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @AttackPower, `stat_value3` = 16, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 13 WHERE `entry` = 28988;
-- Guardian's Wyrmhide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 35, `stat_type3` = @SpellPower, `stat_value3` = 44, `stat_type4` = @MP5, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 35165;
-- General's Scaled Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 26, `stat_type2` = @Stamina, `stat_value2` = 22, `stat_type3` = @Intellect, `stat_value3` = 11, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 8 WHERE `entry` = 28646;
-- Vindicator's Mail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 43, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 35, `stat_type4` = @Crit, `stat_value4` = 29, `stat_type5` = @Resilience, `stat_value5` = 27 WHERE `entry` = 33899;
-- Guardian's Ornamented Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 35, `stat_type3` = @SpellPower, `stat_value3` = 40, `stat_type4` = @Crit, `stat_value4` = 34, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 35145;
-- Vindicator's Dragonhide Belt
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 30, `stat_type2` = @Agility, `stat_value2` = 29, `stat_type3` = @Stamina, `stat_value3` = 42, `stat_type4` = @Intellect, `stat_value4` = 20, `stat_type5` = @Crit, `stat_value5` = 21, `stat_type6` = @Resilience, `stat_value6` = 26 WHERE `entry` = 33879;
-- Veteran's Kodohide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @SpellPower, `stat_value3` = 16, `stat_type4` = @MP5, `stat_value4` = 8, `stat_type5` = @Resilience, `stat_value5` = 18 WHERE `entry` = 32812;
-- Vindicator's Kodohide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 43, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 40, `stat_type4` = @MP5, `stat_value4` = 11, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 33885;
-- Veteran's Mail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27 WHERE `entry` = 32804;
-- General's Dragonhide Belt
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23 WHERE `entry` = 28443;
-- Guardian's Dragonhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 25, `stat_type2` = @Agility, `stat_value2` = 25, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 17 WHERE `entry` = 35167;
-- General's Linked Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19 WHERE `entry` = 28630;
-- Guardian's Chain Bracers
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 26, `stat_type2` = @Stamina, `stat_value2` = 36, `stat_type3` = @Intellect, `stat_value3` = 15, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 13 WHERE `entry` = 35166;
-- Guardian's Silk Cuffs
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 25, `stat_type3` = @SpellPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 18, `stat_type5` = @Resilience, `stat_value5` = 13 WHERE `entry` = 35179;
-- Guardian's Dragonhide Belt
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 34, `stat_type2` = @Agility, `stat_value2` = 33, `stat_type3` = @Stamina, `stat_value3` = 46, `stat_type4` = @Intellect, `stat_value4` = 24, `stat_type5` = @Crit, `stat_value5` = 25, `stat_type6` = @Resilience, `stat_value6` = 26 WHERE `entry` = 35152;
-- Marshal's Mail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23 WHERE `entry` = 28994;
-- Veteran's Scaled Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 41, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 27, `stat_type4` = @Crit, `stat_value4` = 18, `stat_type5` = @Resilience, `stat_value5` = 18 WHERE `entry` = 32794;
-- General's Kodohide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 31595;
-- General's Mooncloth Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27 WHERE `entry` = 32974;
-- Vindicator's Ringmail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 29, `stat_type2` = @Intellect, `stat_value2` = 17, `stat_type3` = @SpellPower, `stat_value3` = 27, `stat_type4` = @Crit, `stat_value4` = 21, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 33906;
-- Veteran's Plate Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 31, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Crit, `stat_value3` = 31, `stat_type4` = @Resilience, `stat_value4` = 30 WHERE `entry` = 32805;
-- Guardian's Ringmail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 20, `stat_type3` = @SpellPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 35177;
-- Guardian's Mail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 34, `stat_type3` = @SpellPower, `stat_value3` = 40, `stat_type4` = @Crit, `stat_value4` = 34, `stat_type5` = @Resilience, `stat_value5` = 27 WHERE `entry` = 35143;
-- Veteran's Ornamented Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 32989;
-- Guardian's Wyrmhide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 35, `stat_type3` = @SpellPower, `stat_value3` = 44, `stat_type4` = @MP5, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 35150;
-- Veteran's Chain Sabatons
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Intellect, `stat_value3` = 20, `stat_type4` = @AttackPower, `stat_value4` = 32, `stat_type5` = @Crit, `stat_value5` = 16, `stat_type6` = @Resilience, `stat_value6` = 21 WHERE `entry` = 32785;
-- General's Mooncloth Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14 WHERE `entry` = 32973;
-- Veteran's Dreadweave Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 31, `stat_type2` = @Intellect, `stat_value2` = 16, `stat_type3` = @SpellPower, `stat_value3` = 25, `stat_type4` = @Resilience, `stat_value4` = 17 WHERE `entry` = 32811;
-- Vindicator's Silk Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 43, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 35, `stat_type4` = @Crit, `stat_value4` = 28, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 33912;
-- Guardian's Mooncloth Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 38, `stat_type2` = @Intellect, `stat_value2` = 24, `stat_type3` = @SpellPower, `stat_value3` = 34, `stat_type4` = @Resilience, `stat_value4` = 17 WHERE `entry` = 35174;
-- General's Ornamented Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 32984;
-- Vindicator's Wyrmhide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 43, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 40, `stat_type4` = @MP5, `stat_value4` = 11, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 33915;
-- Vindicator's Ornamented Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 43, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 35, `stat_type4` = @Crit, `stat_value4` = 30, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 33905;
-- Vindicator's Wyrmhide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 43, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 40, `stat_type4` = @MP5, `stat_value4` = 11, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 33916;
-- Guardian's Scaled Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 44, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Intellect, `stat_value3` = 31, `stat_type4` = @Crit, `stat_value4` = 31, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 35163;
-- Veteran's Dragonhide Belt
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Agility, `stat_value2` = 26, `stat_type3` = @Stamina, `stat_value3` = 39, `stat_type4` = @Intellect, `stat_value4` = 17, `stat_type5` = @SpellPower, `stat_value5` = 22, `stat_type6` = @Resilience, `stat_value6` = 26 WHERE `entry` = 32798;
-- Veteran's Mail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 17, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 32817;
-- Vindicator's Ringmail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 43, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 35, `stat_type4` = @Crit, `stat_value4` = 29, `stat_type5` = @Resilience, `stat_value5` = 27 WHERE `entry` = 33907;
-- General's Plate Greaves
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27 WHERE `entry` = 28383;
-- Vindicator's Chain Sabatons
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 33, `stat_type2` = @Stamina, `stat_value2` = 48, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @AttackPower, `stat_value4` = 38, `stat_type5` = @Crit, `stat_value5` = 18, `stat_type6` = @Resilience, `stat_value6` = 21 WHERE `entry` = 33878;
-- General's Dreadweave Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27 WHERE `entry` = 28404;
-- Veteran's Dragonhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 19, `stat_type2` = @Agility, `stat_value2` = 18, `stat_type3` = @Stamina, `stat_value3` = 25, `stat_type4` = @SpellPower, `stat_value4` = 11, `stat_type5` = @Resilience, `stat_value5` = 17 WHERE `entry` = 32810;
-- Guardian's Mooncloth Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 56, `stat_type2` = @Intellect, `stat_value2` = 36, `stat_type3` = @SpellPower, `stat_value3` = 47, `stat_type4` = @Resilience, `stat_value4` = 31 WHERE `entry` = 35159;
-- Vindicator's Linked Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @AttackPower, `stat_value3` = 50, `stat_type4` = @Crit, `stat_value4` = 21, `stat_type5` = @Resilience, `stat_value5` = 12 WHERE `entry` = 33894;
-- General's Lamellar Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13 WHERE `entry` = 28643;
-- Marshal's Kodohide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 13, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 14 WHERE `entry` = 31599;
-- General's Plate Greaves Tier 2
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27 WHERE `entry` = 30491;
-- Marshal's Ringmail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23 WHERE `entry` = 32996;
-- Guardian's Ornamented Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 20, `stat_type3` = @SpellPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 35175;
-- General's Ringmail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23 WHERE `entry` = 32993;
-- Marshal's Plate Greaves
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27 WHERE `entry` = 28997;
-- Marshal's Linked Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19 WHERE `entry` = 28990;
-- Marshal's Dreadweave Stalkers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27 WHERE `entry` = 28982;
-- Marshal's Lamellar Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 28983;
-- Vindicator's Dragonhide Boots
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 30, `stat_type2` = @Agility, `stat_value2` = 29, `stat_type3` = @Stamina, `stat_value3` = 42, `stat_type4` = @Intellect, `stat_value4` = 20, `stat_type5` = @Crit, `stat_value5` = 21, `stat_type6` = @Resilience, `stat_value6` = 26 WHERE `entry` = 33880;
-- Marshal's Mooncloth Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27 WHERE `entry` = 32976;
-- General's Mail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13 WHERE `entry` = 28638;
-- General's Dragonhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 16, `stat_type2` = @Agility, `stat_value2` = 13, `stat_type3` = @Stamina, `stat_value3` = 22, `stat_type4` = @SpellPower, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 11 WHERE `entry` = 28445;
-- Veteran's Lamellar Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 32789;
-- Veteran's Linked Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 20, `stat_type3` = @AttackPower, `stat_value3` = 60, `stat_type4` = @Crit, `stat_value4` = 31, `stat_type5` = @Resilience, `stat_value5` = 21 WHERE `entry` = 32791;
-- Guardian's Dragonhide Boots
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 34, `stat_type2` = @Agility, `stat_value2` = 33, `stat_type3` = @Stamina, `stat_value3` = 46, `stat_type4` = @Intellect, `stat_value4` = 24, `stat_type5` = @Crit, `stat_value5` = 25, `stat_type6` = @Resilience, `stat_value6` = 26 WHERE `entry` = 35137;
-- General's Mail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23 WHERE `entry` = 28640;
-- Marshal's Wyrmhide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 29004;
-- Guardian's Dreadweave Stalkers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 56, `stat_type2` = @Intellect, `stat_value2` = 37, `stat_type3` = @SpellPower, `stat_value3` = 47, `stat_type4` = @Resilience, `stat_value4` = 31 WHERE `entry` = 35138;
-- Marshal's Linked Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 9, `stat_type3` = @AttackPower, `stat_value3` = 38, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 10 WHERE `entry` = 28989;
-- General's Plate Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27 WHERE `entry` = 28385;
-- Guardian's Mooncloth Slippers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 56, `stat_type2` = @Intellect, `stat_value2` = 36, `stat_type3` = @SpellPower, `stat_value3` = 47, `stat_type4` = @Resilience, `stat_value4` = 31 WHERE `entry` = 35144;
-- Veteran's Leather Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @AttackPower, `stat_value3` = 34, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 30 WHERE `entry` = 32802;
-- Marshal's Scaled Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16 WHERE `entry` = 28998;
-- Veteran's Ringmail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27 WHERE `entry` = 32999;
-- Vindicator's Leather Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 33, `stat_type2` = @Stamina, `stat_value2` = 49, `stat_type3` = @AttackPower, `stat_value3` = 40, `stat_type4` = @Crit, `stat_value4` = 19, `stat_type5` = @Resilience, `stat_value5` = 30 WHERE `entry` = 33891;
-- Guardian's Kodohide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 35, `stat_type3` = @SpellPower, `stat_value3` = 44, `stat_type4` = @MP5, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 35139;
-- General's Mail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23 WHERE `entry` = 28639;
-- Veteran's Scaled Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 41, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 27, `stat_type4` = @Crit, `stat_value4` = 18, `stat_type5` = @Resilience, `stat_value5` = 18 WHERE `entry` = 32806;
-- Vindicator's Ornamented Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 29, `stat_type2` = @Intellect, `stat_value2` = 17, `stat_type3` = @SpellPower, `stat_value3` = 27, `stat_type4` = @Crit, `stat_value4` = 20, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 33904;
-- Vindicator's Linked Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @AttackPower, `stat_value3` = 68, `stat_type4` = @Crit, `stat_value4` = 33, `stat_type5` = @Resilience, `stat_value5` = 21 WHERE `entry` = 33895;
-- Vindicator's Plate Bracers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 25, `stat_type2` = @Stamina, `stat_value2` = 36, `stat_type3` = @Crit, `stat_value3` = 21, `stat_type4` = @Resilience, `stat_value4` = 17 WHERE `entry` = 33813;
-- Veteran's Lamellar Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 32813;
-- General's Linked Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19 WHERE `entry` = 28629;
-- Veteran's Mooncloth Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31 WHERE `entry` = 32979;
-- Vindicator's Mooncloth Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 20, `stat_type3` = @SpellPower, `stat_value3` = 29, `stat_type4` = @Resilience, `stat_value4` = 17 WHERE `entry` = 33901;
-- Marshal's Dreadweave Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27 WHERE `entry` = 28980;
-- Veteran's Dreadweave Stalkers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31 WHERE `entry` = 32787;
-- Guardian's Leather Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 37, `stat_type2` = @Stamina, `stat_value2` = 55, `stat_type3` = @AttackPower, `stat_value3` = 48, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 30 WHERE `entry` = 35156;
-- General's Kodohide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 31594;
-- Guardian's Plate Bracers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 28, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 24, `stat_type4` = @Resilience, `stat_value4` = 17 WHERE `entry` = 35176;
-- Guardian's Wyrmhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 35, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 27, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 35180;
-- Vindicator's Mail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 43, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 35, `stat_type4` = @Crit, `stat_value4` = 29, `stat_type5` = @Resilience, `stat_value5` = 27 WHERE `entry` = 33898;
-- Marshal's Wyrmhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 13 WHERE `entry` = 29006;
-- Guardian's Kodohide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 31, `stat_type2` = @Intellect, `stat_value2` = 25, `stat_type3` = @SpellPower, `stat_value3` = 25, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 18 WHERE `entry` = 35169;
-- Veteran's Leather Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @AttackPower, `stat_value3` = 34, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 30 WHERE `entry` = 32790;
-- Guardian's Leather Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 28, `stat_type2` = @Stamina, `stat_value2` = 37, `stat_type3` = @AttackPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 35171;
-- Marshal's Linked Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19 WHERE `entry` = 28991;
-- Marshal's Silk Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 29001;
-- General's Scaled Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16 WHERE `entry` = 28644;
-- Veteran's Ringmail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 17, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 32997;
-- General's Dreadweave Stalkers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27 WHERE `entry` = 28402;
-- Guardian's Dreadweave Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 38, `stat_type2` = @Intellect, `stat_value2` = 24, `stat_type3` = @SpellPower, `stat_value3` = 34, `stat_type4` = @Resilience, `stat_value4` = 17 WHERE `entry` = 35168;
-- Veteran's Kodohide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 26, `stat_type3` = @SpellPower, `stat_value3` = 37, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 32788;
-- Vindicator's Kodohide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 43, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 40, `stat_type4` = @MP5, `stat_value4` = 11, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 33886;
-- Veteran's Dragonhide Boots
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Agility, `stat_value2` = 26, `stat_type3` = @Stamina, `stat_value3` = 39, `stat_type4` = @Intellect, `stat_value4` = 17, `stat_type5` = @SpellPower, `stat_value5` = 22, `stat_type6` = @Resilience, `stat_value6` = 26 WHERE `entry` = 32786;
-- Guardian's Ringmail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 34, `stat_type3` = @SpellPower, `stat_value3` = 40, `stat_type4` = @Crit, `stat_value4` = 34, `stat_type5` = @Resilience, `stat_value5` = 27 WHERE `entry` = 35162;
-- Veteran's Wyrmhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 27, `stat_type2` = @Intellect, `stat_value2` = 16, `stat_type3` = @SpellPower, `stat_value3` = 19, `stat_type4` = @MP5, `stat_value4` = 8, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 32821;
-- General's Wyrmhide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 28446;
-- Veteran's Plate Bracers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 21, `stat_type2` = @Stamina, `stat_value2` = 30, `stat_type3` = @Crit, `stat_value3` = 17, `stat_type4` = @Resilience, `stat_value4` = 17 WHERE `entry` = 32818;
-- Veteran's Scaled Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 29, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Intellect, `stat_value3` = 13, `stat_type4` = @Crit, `stat_value4` = 8, `stat_type5` = @Resilience, `stat_value5` = 9 WHERE `entry` = 32819;
-- Veteran's Leather Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 21, `stat_type2` = @Stamina, `stat_value2` = 29, `stat_type3` = @AttackPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 32814;
-- Marshal's Scaled Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16 WHERE `entry` = 29000;
-- Guardian's Kodohide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 35, `stat_type3` = @SpellPower, `stat_value3` = 44, `stat_type4` = @MP5, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 35154;
-- Guardian's Silk Footguards
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 35, `stat_type3` = @SpellPower, `stat_value3` = 40, `stat_type4` = @Crit, `stat_value4` = 32, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 35149;
-- Vindicator's Leather Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 33, `stat_type2` = @Stamina, `stat_value2` = 49, `stat_type3` = @AttackPower, `stat_value3` = 40, `stat_type4` = @Crit, `stat_value4` = 19, `stat_type5` = @Resilience, `stat_value5` = 30 WHERE `entry` = 33892;
-- General's Ornamented Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 32982;
-- Guardian's Dreadweave Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 56, `stat_type2` = @Intellect, `stat_value2` = 37, `stat_type3` = @SpellPower, `stat_value3` = 47, `stat_type4` = @Resilience, `stat_value4` = 31 WHERE `entry` = 35153;
-- Guardian's Ornamented Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 35, `stat_type3` = @SpellPower, `stat_value3` = 40, `stat_type4` = @Crit, `stat_value4` = 34, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 35160;
-- Marshal's Leather Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 28987;
-- Vindicator's Dreadweave Stalkers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 32, `stat_type3` = @SpellPower, `stat_value3` = 41, `stat_type4` = @Resilience, `stat_value4` = 31 WHERE `entry` = 33884;
-- General's Silk Cuffs
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 17, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 12, `stat_type5` = @Resilience, `stat_value5` = 11 WHERE `entry` = 28411;
-- Marshal's Silk Footguards
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 29003;
-- Guardian's Silk Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 35, `stat_type3` = @SpellPower, `stat_value3` = 40, `stat_type4` = @Crit, `stat_value4` = 32, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 35164;
-- Marshal's Mail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13 WHERE `entry` = 28992;
-- Vindicator's Silk Footguards
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 43, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 35, `stat_type4` = @Crit, `stat_value4` = 28, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 33914;
-- Vindicator's Mooncloth Slippers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 31, `stat_type3` = @SpellPower, `stat_value3` = 41, `stat_type4` = @Resilience, `stat_value4` = 31 WHERE `entry` = 33902;
-- Marshal's Mail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23 WHERE `entry` = 28993;
-- General's Ringmail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13 WHERE `entry` = 32991;
-- General's Ringmail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23 WHERE `entry` = 32992;
-- Vindicator's Wyrmhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 31, `stat_type2` = @Intellect, `stat_value2` = 20, `stat_type3` = @SpellPower, `stat_value3` = 23, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 33917;
-- Marshal's Ornamented Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13 WHERE `entry` = 32986;
-- General's Linked Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 9, `stat_type3` = @AttackPower, `stat_value3` = 38, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 10 WHERE `entry` = 28605;
-- Marshal's Plate Bracers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Crit, `stat_value3` = 14, `stat_type4` = @Resilience, `stat_value4` = 14 WHERE `entry` = 28996;
-- General's Plate Bracers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Crit, `stat_value3` = 14, `stat_type4` = @Resilience, `stat_value4` = 14 WHERE `entry` = 28381;
-- Marshal's Mooncloth Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14 WHERE `entry` = 32977;
-- General's Dragonhide Boots
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23 WHERE `entry` = 28444;
-- General's Lamellar Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 28642;
-- Veteran's Wyrmhide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 32796;
-- Veteran's Silk Cuffs
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13 WHERE `entry` = 32820;
-- Vindicator's Ringmail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 43, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 35, `stat_type4` = @Crit, `stat_value4` = 29, `stat_type5` = @Resilience, `stat_value5` = 27 WHERE `entry` = 33908;
-- Vindicator's Linked Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @AttackPower, `stat_value3` = 66, `stat_type4` = @Crit, `stat_value4` = 34, `stat_type5` = @Resilience, `stat_value5` = 21 WHERE `entry` = 33896;
-- General's Leather Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @AttackPower, `stat_value3` = 16, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 13 WHERE `entry` = 28424;
-- Veteran's Lamellar Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 32801;
-- Vindicator's Mooncloth Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 31, `stat_type3` = @SpellPower, `stat_value3` = 41, `stat_type4` = @Resilience, `stat_value4` = 31 WHERE `entry` = 33900;
-- Marshal's Ornamented Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 32985;
-- Marshal's Dreadweave Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14 WHERE `entry` = 28981;
-- Guardian's Lamellar Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 20, `stat_type3` = @SpellPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 35170;
-- Vindicator's Plate Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 35, `stat_type2` = @Stamina, `stat_value2` = 49, `stat_type3` = @Crit, `stat_value3` = 35, `stat_type4` = @Resilience, `stat_value4` = 30 WHERE `entry` = 33811;
-- Veteran's Chain Girdle
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Intellect, `stat_value3` = 20, `stat_type4` = @AttackPower, `stat_value4` = 32, `stat_type5` = @Crit, `stat_value5` = 16, `stat_type6` = @Resilience, `stat_value6` = 21 WHERE `entry` = 32797;
-- Veteran's Ringmail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27 WHERE `entry` = 32998;
-- Marshal's Leather Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 28986;
-- Vindicator's Lamellar Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 29, `stat_type2` = @Intellect, `stat_value2` = 17, `stat_type3` = @SpellPower, `stat_value3` = 27, `stat_type4` = @Crit, `stat_value4` = 20, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 33889;
-- Veteran's Mooncloth Slippers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31 WHERE `entry` = 32981;
-- General's Mooncloth Slippers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27 WHERE `entry` = 32975;
-- Marshal's Plate Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27 WHERE `entry` = 28995;
-- Vindicator's Dragonhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 22, `stat_type2` = @Agility, `stat_value2` = 22, `stat_type3` = @Stamina, `stat_value3` = 29, `stat_type4` = @Crit, `stat_value4` = 21, `stat_type5` = @Resilience, `stat_value5` = 17 WHERE `entry` = 33881;
-- Veteran's Wyrmhide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 32808;
-- General's Leather Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 28422;
-- Marshal's Dragonhide Boots
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23 WHERE `entry` = 28977;
-- Marshal's Chain Sabatons
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18 WHERE `entry` = 28975;
-- Guardian's Plate Greaves
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 40, `stat_type2` = @Stamina, `stat_value2` = 56, `stat_type3` = @Crit, `stat_value3` = 40, `stat_type4` = @Resilience, `stat_value4` = 30 WHERE `entry` = 35146;
-- Marshal's Scaled Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 26, `stat_type2` = @Stamina, `stat_value2` = 22, `stat_type3` = @Intellect, `stat_value3` = 11, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 8 WHERE `entry` = 28999;
-- Veteran's Chain Bracers
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 20, `stat_type2` = @Stamina, `stat_value2` = 29, `stat_type3` = @Intellect, `stat_value3` = 10, `stat_type4` = @AttackPower, `stat_value4` = 18, `stat_type5` = @Crit, `stat_value5` = 8, `stat_type6` = @Resilience, `stat_value6` = 13 WHERE `entry` = 32809;
-- Marshal's Kodohide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 31596;
-- Guardian's Lamellar Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 35, `stat_type3` = @SpellPower, `stat_value3` = 40, `stat_type4` = @Crit, `stat_value4` = 34, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 35155;
-- Marshal's Ringmail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23 WHERE `entry` = 32995;
-- General's Lamellar Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 28641;
-- Guardian's Mail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 20, `stat_type3` = @SpellPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 35173;
-- Vindicator's Lamellar Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 43, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 35, `stat_type4` = @Crit, `stat_value4` = 30, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 33890;
-- Vindicator's Chain Girdle
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 33, `stat_type2` = @Stamina, `stat_value2` = 48, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @AttackPower, `stat_value4` = 38, `stat_type5` = @Crit, `stat_value5` = 18, `stat_type6` = @Resilience, `stat_value6` = 21 WHERE `entry` = 33877;
-- Marshal's Mooncloth Slippers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27 WHERE `entry` = 32978;
-- General's Wyrmhide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 28447;
-- General's Dreadweave Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14 WHERE `entry` = 28405;
-- Guardian's Leather Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 37, `stat_type2` = @Stamina, `stat_value2` = 55, `stat_type3` = @AttackPower, `stat_value3` = 48, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 30 WHERE `entry` = 35141;
-- Guardian's Lamellar Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 35, `stat_type3` = @SpellPower, `stat_value3` = 40, `stat_type4` = @Crit, `stat_value4` = 34, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 35140;
-- Vindicator's Scaled Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 29, `stat_type2` = @Stamina, `stat_value2` = 28, `stat_type3` = @Intellect, `stat_value3` = 15, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 19 WHERE `entry` = 33910;
-- Marshal's Lamellar Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13 WHERE `entry` = 28984;
-- Vindicator's Plate Greaves
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 35, `stat_type2` = @Stamina, `stat_value2` = 49, `stat_type3` = @Crit, `stat_value3` = 35, `stat_type4` = @Resilience, `stat_value4` = 30 WHERE `entry` = 33812;
-- Veteran's Mail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27 WHERE `entry` = 32792;
-- General's Kodohide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 13, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 14 WHERE `entry` = 31598;
-- Vindicator's Scaled Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 40, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 26, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 33911;
-- Veteran's Dreadweave Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31 WHERE `entry` = 32799;
-- Vindicator's Scaled Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 40, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 26, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 33909;
-- Vindicator's Lamellar Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 43, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 35, `stat_type4` = @Crit, `stat_value4` = 30, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 33888;
-- Veteran's Kodohide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 32800;
-- Marshal's Silk Cuffs
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 17, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 12, `stat_type5` = @Resilience, `stat_value5` = 11 WHERE `entry` = 29002;
-- Veteran's Linked Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 29, `stat_type2` = @Intellect, `stat_value2` = 11, `stat_type3` = @AttackPower, `stat_value3` = 42, `stat_type4` = @Crit, `stat_value4` = 17, `stat_type5` = @Resilience, `stat_value5` = 12 WHERE `entry` = 32816;
-- General's Silk Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 28409;
-- Vindicator's Dreadweave Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 20, `stat_type3` = @SpellPower, `stat_value3` = 29, `stat_type4` = @Resilience, `stat_value4` = 17 WHERE `entry` = 33883;
-- Veteran's Linked Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 20, `stat_type3` = @AttackPower, `stat_value3` = 62, `stat_type4` = @Crit, `stat_value4` = 30, `stat_type5` = @Resilience, `stat_value5` = 21 WHERE `entry` = 32803;
-- Marshal's Ornamented Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 32987;
-- Marshal's Kodohide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 31597;
-- Marshal's Dragonhide Belt
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23 WHERE `entry` = 28976;
-- Marshal's Ringmail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13 WHERE `entry` = 32994;
-- Marshal's Chain Girdle
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18 WHERE `entry` = 28974;
-- Marshal's Lamellar Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24 WHERE `entry` = 28985;
-- Guardian's Plate Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 40, `stat_type2` = @Stamina, `stat_value2` = 56, `stat_type3` = @Crit, `stat_value3` = 40, `stat_type4` = @Resilience, `stat_value4` = 30 WHERE `entry` = 35161;
-- General's Scaled Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16 WHERE `entry` = 28645;
-- Guardian's Linked Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 37, `stat_type2` = @Intellect, `stat_value2` = 17, `stat_type3` = @AttackPower, `stat_value3` = 56, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 12 WHERE `entry` = 35172;
-- Vindicator's Chain Bracers
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 23, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 13, `stat_type4` = @AttackPower, `stat_value4` = 24, `stat_type5` = @Crit, `stat_value5` = 11, `stat_type6` = @Resilience, `stat_value6` = 13 WHERE `entry` = 33876;
-- General's Wyrmhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 13 WHERE `entry` = 28448;
-- Vindicator's Ornamented Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 43, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 35, `stat_type4` = @Crit, `stat_value4` = 30, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 33903;
-- General's Leather Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 28423;
-- General's Chain Girdle
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18 WHERE `entry` = 28450;
-- Vindicator's Leather Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 25, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @AttackPower, `stat_value3` = 26, `stat_type4` = @Crit, `stat_value4` = 12, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 33893;
-- General's Chain Sabatons
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18 WHERE `entry` = 28449;
-- Guardian's Linked Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 55, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @AttackPower, `stat_value3` = 76, `stat_type4` = @Crit, `stat_value4` = 38, `stat_type5` = @Resilience, `stat_value5` = 21 WHERE `entry` = 35142;
-- General's Ornamented Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13 WHERE `entry` = 32983;
-- General's Chain Bracers
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 18, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Intellect, `stat_value3` = 9, `stat_type4` = @AttackPower, `stat_value4` = 16, `stat_type5` = @Crit, `stat_value5` = 7, `stat_type6` = @Resilience, `stat_value6` = 11 WHERE `entry` = 28451;
-- Guardian's Linked Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 55, `stat_type2` = @Intellect, `stat_value2` = 28, `stat_type3` = @AttackPower, `stat_value3` = 76, `stat_type4` = @Crit, `stat_value4` = 37, `stat_type5` = @Resilience, `stat_value5` = 21 WHERE `entry` = 35157;
-- Guardian's Chain Girdle
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 37, `stat_type2` = @Stamina, `stat_value2` = 52, `stat_type3` = @Intellect, `stat_value3` = 27, `stat_type4` = @AttackPower, `stat_value4` = 46, `stat_type5` = @Crit, `stat_value5` = 22, `stat_type6` = @Resilience, `stat_value6` = 21 WHERE `entry` = 35151;
-- Guardian's Chain Sabatons
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 37, `stat_type2` = @Stamina, `stat_value2` = 52, `stat_type3` = @Intellect, `stat_value3` = 27, `stat_type4` = @AttackPower, `stat_value4` = 46, `stat_type5` = @Crit, `stat_value5` = 22, `stat_type6` = @Resilience, `stat_value6` = 21 WHERE `entry` = 35136;
-- Marshal's Dragonhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 16, `stat_type2` = @Agility, `stat_value2` = 13, `stat_type3` = @Stamina, `stat_value3` = 22, `stat_type4` = @SpellPower, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 11 WHERE `entry` = 28978;
-- Guardian's Ringmail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 34, `stat_type3` = @SpellPower, `stat_value3` = 40, `stat_type4` = @Crit, `stat_value4` = 34, `stat_type5` = @Resilience, `stat_value5` = 27 WHERE `entry` = 35147;
-- Veteran's Plate Greaves
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 31, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Crit, `stat_value3` = 31, `stat_type4` = @Resilience, `stat_value4` = 30 WHERE `entry` = 32793;
-- Veteran's Silk Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 32807;
-- Veteran's Silk Footguards
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 32795;
-- Guardian's Mail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 49, `stat_type2` = @Intellect, `stat_value2` = 34, `stat_type3` = @SpellPower, `stat_value3` = 40, `stat_type4` = @Crit, `stat_value4` = 34, `stat_type5` = @Resilience, `stat_value5` = 27 WHERE `entry` = 35158;
-- Vindicator's Kodohide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 29, `stat_type2` = @Intellect, `stat_value2` = 22, `stat_type3` = @SpellPower, `stat_value3` = 21, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 18 WHERE `entry` = 33887;
-- Guardian's Scaled Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 44, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Intellect, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 31, `stat_type5` = @Resilience, `stat_value5` = 26 WHERE `entry` = 35148;
-- Veteran's Mooncloth Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 31, `stat_type2` = @Intellect, `stat_value2` = 16, `stat_type3` = @SpellPower, `stat_value3` = 25, `stat_type4` = @Resilience, `stat_value4` = 17 WHERE `entry` = 32980;
-- Vindicator's Silk Cuffs
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 29, `stat_type2` = @Intellect, `stat_value2` = 22, `stat_type3` = @SpellPower, `stat_value3` = 27, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 13 WHERE `entry` = 33913;
-- Vindicator's Mail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 29, `stat_type2` = @Intellect, `stat_value2` = 17, `stat_type3` = @SpellPower, `stat_value3` = 27, `stat_type4` = @Crit, `stat_value4` = 21, `stat_type5` = @Resilience, `stat_value5` = 15 WHERE `entry` = 33897;