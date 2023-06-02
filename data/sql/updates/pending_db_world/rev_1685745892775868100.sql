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


-- Marshal's Mail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 28994;
-- General's Leather Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @AttackPower, `stat_value3` = 16, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 1032 WHERE `entry` = 28424;
-- Veteran's Kodohide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @SpellPower, `stat_value3` = 16, `stat_type4` = @MP5, `stat_value4` = 8, `stat_type5` = @Resilience, `stat_value5` = 18, `AllowableClass` = 1032 WHERE `entry` = 32812;
-- General's Chain Bracers
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 18, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Intellect, `stat_value3` = 9, `stat_type4` = @AttackPower, `stat_value4` = 16, `stat_type5` = @Crit, `stat_value5` = 7, `stat_type6` = @Resilience, `stat_value6` = 11, `AllowableClass` = 68 WHERE `entry` = 28451;
-- General's Dreadweave Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14, `AllowableClass` = 400 WHERE `entry` = 28405;
-- Marshal's Mooncloth Slippers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 32978;
-- Marshal's Dreadweave Stalkers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 28982;
-- General's Ornamented Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 32982;
-- Veteran's Dreadweave Stalkers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31, `AllowableClass` = 400 WHERE `entry` = 32787;
-- Marshal's Linked Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19, `AllowableClass` = 68 WHERE `entry` = 28991;
-- General's Leather Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 28422;
-- Veteran's Ringmail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27, `AllowableClass` = 68 WHERE `entry` = 32998;
-- Veteran's Linked Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 20, `stat_type3` = @AttackPower, `stat_value3` = 60, `stat_type4` = @Crit, `stat_value4` = 31, `stat_type5` = @Resilience, `stat_value5` = 21, `AllowableClass` = 68 WHERE `entry` = 32791;
-- General's Ringmail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 32993;
-- General's Ornamented Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 3 WHERE `entry` = 32983;
-- Veteran's Dreadweave Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31, `AllowableClass` = 400 WHERE `entry` = 32799;
-- Marshal's Silk Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 400 WHERE `entry` = 29001;
-- General's Linked Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19, `AllowableClass` = 68 WHERE `entry` = 28629;
-- Marshal's Leather Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @AttackPower, `stat_value3` = 16, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 1032 WHERE `entry` = 28988;
-- Marshal's Lamellar Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 3 WHERE `entry` = 28984;
-- Marshal's Lamellar Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 28983;
-- General's Lamellar Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 28641;
-- Marshal's Dreadweave Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 28980;
-- General's Lamellar Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 3 WHERE `entry` = 28643;
-- General's Mail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 28639;
-- General's Wyrmhide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 28446;
-- Marshal's Leather Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 28986;
-- General's Dragonhide Belt
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23, `AllowableClass` = 1032 WHERE `entry` = 28443;
-- Veteran's Scaled Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 41, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 27, `stat_type4` = @Crit, `stat_value4` = 18, `stat_type5` = @Resilience, `stat_value5` = 18, `AllowableClass` = 3 WHERE `entry` = 32806;
-- Veteran's Silk Footguards
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 400 WHERE `entry` = 32795;
-- Veteran's Dreadweave Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 31, `stat_type2` = @Intellect, `stat_value2` = 16, `stat_type3` = @SpellPower, `stat_value3` = 25, `stat_type4` = @Resilience, `stat_value4` = 17, `AllowableClass` = 400 WHERE `entry` = 32811;
-- General's Plate Bracers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Crit, `stat_value3` = 14, `stat_type4` = @Resilience, `stat_value4` = 14, `AllowableClass` = 35 WHERE `entry` = 28381;
-- Marshal's Mooncloth Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14, `AllowableClass` = 400 WHERE `entry` = 32977;
-- Marshal's Silk Footguards
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 400 WHERE `entry` = 29003;
-- Marshal's Ringmail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 32996;
-- General's Scaled Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16, `AllowableClass` = 3 WHERE `entry` = 28645;
-- Veteran's Mail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 17, `stat_type5` = @Resilience, `stat_value5` = 15, `AllowableClass` = 68 WHERE `entry` = 32817;
-- Veteran's Ornamented Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 3 WHERE `entry` = 32988;
-- General's Wyrmhide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 28447;
-- Veteran's Linked Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 20, `stat_type3` = @AttackPower, `stat_value3` = 62, `stat_type4` = @Crit, `stat_value4` = 30, `stat_type5` = @Resilience, `stat_value5` = 21, `AllowableClass` = 68 WHERE `entry` = 32803;
-- General's Mail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 28640;
-- Marshal's Chain Girdle
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18, `AllowableClass` = 68 WHERE `entry` = 28974;
-- Veteran's Ornamented Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 3 WHERE `entry` = 32990;
-- Veteran's Ringmail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27, `AllowableClass` = 68 WHERE `entry` = 32999;
-- Veteran's Plate Greaves
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 31, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Crit, `stat_value3` = 31, `stat_type4` = @Resilience, `stat_value4` = 30, `AllowableClass` = 35 WHERE `entry` = 32793;
-- General's Plate Greaves Tier 2
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 3 WHERE `entry` = 30491;
-- General's Kodohide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 13, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 14, `AllowableClass` = 1032 WHERE `entry` = 31598;
-- Marshal's Linked Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19, `AllowableClass` = 68 WHERE `entry` = 28990;
-- Veteran's Lamellar Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 3 WHERE `entry` = 32789;
-- Marshal's Ornamented Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 32987;
-- Marshal's Lamellar Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 28985;
-- Marshal's Plate Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 35 WHERE `entry` = 28995;
-- Marshal's Mail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 28993;
-- Marshal's Wyrmhide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 29004;
-- General's Mooncloth Slippers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 32975;
-- Veteran's Wyrmhide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 32796;
-- Marshal's Ringmail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 32995;
-- Marshal's Scaled Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 26, `stat_type2` = @Stamina, `stat_value2` = 22, `stat_type3` = @Intellect, `stat_value3` = 11, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 8, `AllowableClass` = 3 WHERE `entry` = 28999;
-- Marshal's Kodohide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 31597;
-- Veteran's Lamellar Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 15, `AllowableClass` = 3 WHERE `entry` = 32813;
-- Veteran's Lamellar Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 3 WHERE `entry` = 32801;
-- Veteran's Wyrmhide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 32808;
-- Marshal's Wyrmhide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 29005;
-- Marshal's Wyrmhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 1032 WHERE `entry` = 29006;
-- General's Mooncloth Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 32974;
-- General's Silk Cuffs
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 17, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 12, `stat_type5` = @Resilience, `stat_value5` = 11, `AllowableClass` = 400 WHERE `entry` = 28411;
-- Veteran's Chain Girdle
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Intellect, `stat_value3` = 20, `stat_type4` = @AttackPower, `stat_value4` = 32, `stat_type5` = @Crit, `stat_value5` = 16, `stat_type6` = @Resilience, `stat_value6` = 21, `AllowableClass` = 68 WHERE `entry` = 32797;
-- Veteran's Scaled Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 29, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Intellect, `stat_value3` = 13, `stat_type4` = @Crit, `stat_value4` = 8, `stat_type5` = @Resilience, `stat_value5` = 9, `AllowableClass` = 3 WHERE `entry` = 32819;
-- Veteran's Wyrmhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 27, `stat_type2` = @Intellect, `stat_value2` = 16, `stat_type3` = @SpellPower, `stat_value3` = 19, `stat_type4` = @MP5, `stat_value4` = 8, `stat_type5` = @Resilience, `stat_value5` = 15, `AllowableClass` = 1032 WHERE `entry` = 32821;
-- General's Kodohide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 31594;
-- General's Scaled Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 26, `stat_type2` = @Stamina, `stat_value2` = 22, `stat_type3` = @Intellect, `stat_value3` = 11, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 8, `AllowableClass` = 3 WHERE `entry` = 28646;
-- General's Dragonhide Boots
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23, `AllowableClass` = 1032 WHERE `entry` = 28444;
-- Veteran's Dragonhide Belt
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Agility, `stat_value2` = 26, `stat_type3` = @Stamina, `stat_value3` = 39, `stat_type4` = @Intellect, `stat_value4` = 17, `stat_type5` = @SpellPower, `stat_value5` = 22, `stat_type6` = @Resilience, `stat_value6` = 26, `AllowableClass` = 1032 WHERE `entry` = 32798;
-- General's Ringmail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 68 WHERE `entry` = 32991;
-- Marshal's Mail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 68 WHERE `entry` = 28992;
-- General's Dreadweave Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 28404;
-- General's Ringmail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 32992;
-- Marshal's Scaled Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16, `AllowableClass` = 3 WHERE `entry` = 28998;
-- General's Linked Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19, `AllowableClass` = 68 WHERE `entry` = 28630;
-- General's Kodohide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 31595;
-- General's Mail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 68 WHERE `entry` = 28638;
-- General's Linked Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 9, `stat_type3` = @AttackPower, `stat_value3` = 38, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 10, `AllowableClass` = 68 WHERE `entry` = 28605;
-- Veteran's Ornamented Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 15, `AllowableClass` = 3 WHERE `entry` = 32989;
-- Marshal's Ornamented Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 32985;
-- Veteran's Chain Sabatons
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Intellect, `stat_value3` = 20, `stat_type4` = @AttackPower, `stat_value4` = 32, `stat_type5` = @Crit, `stat_value5` = 16, `stat_type6` = @Resilience, `stat_value6` = 21, `AllowableClass` = 68 WHERE `entry` = 32785;
-- Veteran's Chain Bracers
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 20, `stat_type2` = @Stamina, `stat_value2` = 29, `stat_type3` = @Intellect, `stat_value3` = 10, `stat_type4` = @AttackPower, `stat_value4` = 18, `stat_type5` = @Crit, `stat_value5` = 8, `stat_type6` = @Resilience, `stat_value6` = 13, `AllowableClass` = 68 WHERE `entry` = 32809;
-- Veteran's Dragonhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 19, `stat_type2` = @Agility, `stat_value2` = 18, `stat_type3` = @Stamina, `stat_value3` = 25, `stat_type4` = @SpellPower, `stat_value4` = 11, `stat_type5` = @Resilience, `stat_value5` = 17, `AllowableClass` = 1032 WHERE `entry` = 32810;
-- Marshal's Kodohide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 13, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 14, `AllowableClass` = 1032 WHERE `entry` = 31599;
-- Marshal's Ringmail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 68 WHERE `entry` = 32994;
-- Marshal's Dragonhide Belt
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23, `AllowableClass` = 1032 WHERE `entry` = 28976;
-- Veteran's Linked Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 29, `stat_type2` = @Intellect, `stat_value2` = 11, `stat_type3` = @AttackPower, `stat_value3` = 42, `stat_type4` = @Crit, `stat_value4` = 17, `stat_type5` = @Resilience, `stat_value5` = 12, `AllowableClass` = 68 WHERE `entry` = 32816;
-- General's Wyrmhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 1032 WHERE `entry` = 28448;
-- Veteran's Leather Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @AttackPower, `stat_value3` = 34, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 30, `AllowableClass` = 1032 WHERE `entry` = 32790;
-- Marshal's Dragonhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 16, `stat_type2` = @Agility, `stat_value2` = 13, `stat_type3` = @Stamina, `stat_value3` = 22, `stat_type4` = @SpellPower, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 11, `AllowableClass` = 1032 WHERE `entry` = 28978;
-- General's Dragonhide Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 16, `stat_type2` = @Agility, `stat_value2` = 13, `stat_type3` = @Stamina, `stat_value3` = 22, `stat_type4` = @SpellPower, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 11, `AllowableClass` = 1032 WHERE `entry` = 28445;
-- Veteran's Scaled Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 41, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 27, `stat_type4` = @Crit, `stat_value4` = 18, `stat_type5` = @Resilience, `stat_value5` = 18, `AllowableClass` = 3 WHERE `entry` = 32794;
-- Veteran's Plate Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 31, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Crit, `stat_value3` = 31, `stat_type4` = @Resilience, `stat_value4` = 30, `AllowableClass` = 35 WHERE `entry` = 32805;
-- Veteran's Silk Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 400 WHERE `entry` = 32807;
-- Marshal's Ornamented Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 3 WHERE `entry` = 32986;
-- General's Chain Girdle
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18, `AllowableClass` = 68 WHERE `entry` = 28450;
-- General's Scaled Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16, `AllowableClass` = 3 WHERE `entry` = 28644;
-- Marshal's Chain Bracers
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 18, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Intellect, `stat_value3` = 9, `stat_type4` = @AttackPower, `stat_value4` = 16, `stat_type5` = @Crit, `stat_value5` = 7, `stat_type6` = @Resilience, `stat_value6` = 11, `AllowableClass` = 68 WHERE `entry` = 28973;
-- Veteran's Kodohide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 32800;
-- Marshal's Kodohide Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 31596;
-- Marshal's Leather Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 28987;
-- Veteran's Mail Girdle
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27, `AllowableClass` = 68 WHERE `entry` = 32804;
-- Marshal's Linked Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 9, `stat_type3` = @AttackPower, `stat_value3` = 38, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 10, `AllowableClass` = 68 WHERE `entry` = 28989;
-- Marshal's Plate Bracers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Crit, `stat_value3` = 14, `stat_type4` = @Resilience, `stat_value4` = 14, `AllowableClass` = 35 WHERE `entry` = 28996;
-- General's Dreadweave Stalkers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 28402;
-- Veteran's Plate Bracers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 21, `stat_type2` = @Stamina, `stat_value2` = 30, `stat_type3` = @Crit, `stat_value3` = 17, `stat_type4` = @Resilience, `stat_value4` = 17, `AllowableClass` = 35 WHERE `entry` = 32818;
-- Veteran's Silk Cuffs
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 400 WHERE `entry` = 32820;
-- Veteran's Kodohide Boots
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 26, `stat_type3` = @SpellPower, `stat_value3` = 37, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 32788;
-- Veteran's Mooncloth Slippers
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31, `AllowableClass` = 400 WHERE `entry` = 32981;
-- General's Plate Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 35 WHERE `entry` = 28385;
-- General's Ornamented Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 32984;
-- General's Plate Greaves
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 35 WHERE `entry` = 28383;
-- General's Chain Sabatons
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18, `AllowableClass` = 68 WHERE `entry` = 28449;
-- Veteran's Mooncloth Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 31, `stat_type2` = @Intellect, `stat_value2` = 16, `stat_type3` = @SpellPower, `stat_value3` = 25, `stat_type4` = @Resilience, `stat_value4` = 17, `AllowableClass` = 400 WHERE `entry` = 32980;
-- Marshal's Mooncloth Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 32976;
-- Marshal's Plate Greaves
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 35 WHERE `entry` = 28997;
-- Marshal's Dreadweave Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14, `AllowableClass` = 400 WHERE `entry` = 28981;
-- General's Leather Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 28423;
-- Veteran's Mail Sabatons
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27, `AllowableClass` = 68 WHERE `entry` = 32792;
-- Veteran's Leather Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 21, `stat_type2` = @Stamina, `stat_value2` = 29, `stat_type3` = @AttackPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 15, `AllowableClass` = 1032 WHERE `entry` = 32814;
-- General's Silk Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 400 WHERE `entry` = 28409;
-- Veteran's Dragonhide Boots
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Agility, `stat_value2` = 26, `stat_type3` = @Stamina, `stat_value3` = 39, `stat_type4` = @Intellect, `stat_value4` = 17, `stat_type5` = @SpellPower, `stat_value5` = 22, `stat_type6` = @Resilience, `stat_value6` = 26, `AllowableClass` = 1032 WHERE `entry` = 32786;
-- Veteran's Leather Belt
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @AttackPower, `stat_value3` = 34, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 30, `AllowableClass` = 1032 WHERE `entry` = 32802;
-- Veteran's Mooncloth Belt
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31, `AllowableClass` = 400 WHERE `entry` = 32979;
-- Marshal's Silk Cuffs
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 17, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 12, `stat_type5` = @Resilience, `stat_value5` = 11, `AllowableClass` = 400 WHERE `entry` = 29002;
-- Veteran's Ringmail Bracers
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 17, `stat_type5` = @Resilience, `stat_value5` = 15, `AllowableClass` = 68 WHERE `entry` = 32997;
-- Marshal's Dragonhide Boots
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23, `AllowableClass` = 1032 WHERE `entry` = 28977;
-- General's Mooncloth Cuffs
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14, `AllowableClass` = 400 WHERE `entry` = 32973;
-- Marshal's Chain Sabatons
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18, `AllowableClass` = 68 WHERE `entry` = 28975;
-- Marshal's Scaled Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16, `AllowableClass` = 3 WHERE `entry` = 29000;
-- General's Lamellar Greaves
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 28642;
-- General's Silk Footguards
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 400 WHERE `entry` = 28410;