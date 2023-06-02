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


-- Veteran's Lamellar Greaves 32789
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 3 WHERE `entry` = 32789;
-- Marshal's Plate Greaves 28997
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 35 WHERE `entry` = 28997;
-- General's Plate Belt 28385
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 35 WHERE `entry` = 28385;
-- Veteran's Leather Belt 32802
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @AttackPower, `stat_value3` = 34, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 30, `AllowableClass` = 1032 WHERE `entry` = 32802;
-- General's Ornamented Bracers 32983
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 3 WHERE `entry` = 32983;
-- General's Wyrmhide Bracers 28448
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 1032 WHERE `entry` = 28448;
-- General's Mail Sabatons 28640
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 28640;
-- Veteran's Dreadweave Stalkers 32787
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31, `AllowableClass` = 400 WHERE `entry` = 32787;
-- General's Chain Girdle 28450
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18, `AllowableClass` = 68 WHERE `entry` = 28450;
-- Veteran's Silk Belt 32807
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 400 WHERE `entry` = 32807;
-- General's Silk Cuffs 28411
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 17, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 12, `stat_type5` = @Resilience, `stat_value5` = 11, `AllowableClass` = 400 WHERE `entry` = 28411;
-- General's Leather Belt 28423
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 28423;
-- Marshal's Dreadweave Belt 28980
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 28980;
-- Veteran's Ringmail Bracers 32997
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 17, `stat_type5` = @Resilience, `stat_value5` = 15, `AllowableClass` = 68 WHERE `entry` = 32997;
-- Veteran's Chain Girdle 32797
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Intellect, `stat_value3` = 20, `stat_type4` = @AttackPower, `stat_value4` = 32, `stat_type5` = @Crit, `stat_value5` = 16, `stat_type6` = @Resilience, `stat_value6` = 21, `AllowableClass` = 68 WHERE `entry` = 32797;
-- General's Scaled Belt 28644
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16, `AllowableClass` = 3 WHERE `entry` = 28644;
-- General's Dragonhide Boots 28444
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23, `AllowableClass` = 1032 WHERE `entry` = 28444;
-- Veteran's Plate Bracers 32818
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 21, `stat_type2` = @Stamina, `stat_value2` = 30, `stat_type3` = @Crit, `stat_value3` = 17, `stat_type4` = @Resilience, `stat_value4` = 17, `AllowableClass` = 35 WHERE `entry` = 32818;
-- Veteran's Dreadweave Cuffs 32811
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 31, `stat_type2` = @Intellect, `stat_value2` = 16, `stat_type3` = @SpellPower, `stat_value3` = 25, `stat_type4` = @Resilience, `stat_value4` = 17, `AllowableClass` = 400 WHERE `entry` = 32811;
-- Marshal's Mail Bracers 28992
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 68 WHERE `entry` = 28992;
-- Veteran's Wyrmhide Bracers 32821
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 27, `stat_type2` = @Intellect, `stat_value2` = 16, `stat_type3` = @SpellPower, `stat_value3` = 19, `stat_type4` = @MP5, `stat_value4` = 8, `stat_type5` = @Resilience, `stat_value5` = 15, `AllowableClass` = 1032 WHERE `entry` = 32821;
-- Marshal's Dreadweave Stalkers 28982
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 28982;
-- Veteran's Ringmail Girdle 32998
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27, `AllowableClass` = 68 WHERE `entry` = 32998;
-- General's Chain Bracers 28451
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 18, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Intellect, `stat_value3` = 9, `stat_type4` = @AttackPower, `stat_value4` = 16, `stat_type5` = @Crit, `stat_value5` = 7, `stat_type6` = @Resilience, `stat_value6` = 11, `AllowableClass` = 68 WHERE `entry` = 28451;
-- General's Lamellar Greaves 28642
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 28642;
-- Marshal's Wyrmhide Bracers 29006
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 1032 WHERE `entry` = 29006;
-- Veteran's Chain Bracers 32809
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 20, `stat_type2` = @Stamina, `stat_value2` = 29, `stat_type3` = @Intellect, `stat_value3` = 10, `stat_type4` = @AttackPower, `stat_value4` = 18, `stat_type5` = @Crit, `stat_value5` = 8, `stat_type6` = @Resilience, `stat_value6` = 13, `AllowableClass` = 68 WHERE `entry` = 32809;
-- General's Leather Bracers 28424
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @AttackPower, `stat_value3` = 16, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 1032 WHERE `entry` = 28424;
-- General's Mooncloth Belt 32974
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 32974;
-- Veteran's Linked Bracers 32816
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 29, `stat_type2` = @Intellect, `stat_value2` = 11, `stat_type3` = @AttackPower, `stat_value3` = 42, `stat_type4` = @Crit, `stat_value4` = 17, `stat_type5` = @Resilience, `stat_value5` = 12, `AllowableClass` = 68 WHERE `entry` = 32816;
-- Marshal's Mooncloth Slippers 32978
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 32978;
-- Marshal's Linked Bracers 28989
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 9, `stat_type3` = @AttackPower, `stat_value3` = 38, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 10, `AllowableClass` = 68 WHERE `entry` = 28989;
-- General's Chain Sabatons 28449
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18, `AllowableClass` = 68 WHERE `entry` = 28449;
-- Veteran's Scaled Bracers 32819
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 29, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Intellect, `stat_value3` = 13, `stat_type4` = @Crit, `stat_value4` = 8, `stat_type5` = @Resilience, `stat_value5` = 9, `AllowableClass` = 3 WHERE `entry` = 32819;
-- Marshal's Dragonhide Bracers 28978
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 16, `stat_type2` = @Agility, `stat_value2` = 13, `stat_type3` = @Stamina, `stat_value3` = 22, `stat_type4` = @SpellPower, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 11, `AllowableClass` = 1032 WHERE `entry` = 28978;
-- General's Kodohide Belt 31594
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 31594;
-- General's Dreadweave Stalkers 28402
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 28402;
-- Marshal's Dreadweave Cuffs 28981
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14, `AllowableClass` = 400 WHERE `entry` = 28981;
-- Veteran's Silk Cuffs 32820
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 400 WHERE `entry` = 32820;
-- General's Ornamented Greaves 32984
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 32984;
-- Marshal's Dragonhide Boots 28977
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23, `AllowableClass` = 1032 WHERE `entry` = 28977;
-- Marshal's Wyrmhide Boots 29005
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 29005;
-- General's Silk Footguards 28410
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 400 WHERE `entry` = 28410;
-- General's Dragonhide Belt 28443
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23, `AllowableClass` = 1032 WHERE `entry` = 28443;
-- Marshal's Kodohide Boots 31597
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 31597;
-- General's Ringmail Sabatons 32993
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 32993;
-- Marshal's Linked Sabatons 28991
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19, `AllowableClass` = 68 WHERE `entry` = 28991;
-- Veteran's Ornamented Belt 32988
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 3 WHERE `entry` = 32988;
-- Marshal's Silk Belt 29001
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 400 WHERE `entry` = 29001;
-- General's Leather Boots 28422
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 28422;
-- Veteran's Kodohide Boots 32788
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 26, `stat_type3` = @SpellPower, `stat_value3` = 37, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 32788;
-- Marshal's Scaled Greaves 29000
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16, `AllowableClass` = 3 WHERE `entry` = 29000;
-- General's Wyrmhide Belt 28446
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 28446;
-- Veteran's Plate Greaves 32793
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 31, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Crit, `stat_value3` = 31, `stat_type4` = @Resilience, `stat_value4` = 30, `AllowableClass` = 35 WHERE `entry` = 32793;
-- Veteran's Leather Bracers 32814
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 21, `stat_type2` = @Stamina, `stat_value2` = 29, `stat_type3` = @AttackPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 15, `AllowableClass` = 1032 WHERE `entry` = 32814;
-- General's Lamellar Belt 28641
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 28641;
-- Veteran's Ornamented Bracers 32989
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 15, `AllowableClass` = 3 WHERE `entry` = 32989;
-- Veteran's Dragonhide Bracers 32810
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 19, `stat_type2` = @Agility, `stat_value2` = 18, `stat_type3` = @Stamina, `stat_value3` = 25, `stat_type4` = @SpellPower, `stat_value4` = 11, `stat_type5` = @Resilience, `stat_value5` = 17, `AllowableClass` = 1032 WHERE `entry` = 32810;
-- General's Linked Sabatons 28630
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19, `AllowableClass` = 68 WHERE `entry` = 28630;
-- Marshal's Leather Bracers 28988
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @AttackPower, `stat_value3` = 16, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 1032 WHERE `entry` = 28988;
-- General's Plate Bracers 28381
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Crit, `stat_value3` = 14, `stat_type4` = @Resilience, `stat_value4` = 14, `AllowableClass` = 35 WHERE `entry` = 28381;
-- Marshal's Silk Cuffs 29002
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 17, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 12, `stat_type5` = @Resilience, `stat_value5` = 11, `AllowableClass` = 400 WHERE `entry` = 29002;
-- Marshal's Dragonhide Belt 28976
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23, `AllowableClass` = 1032 WHERE `entry` = 28976;
-- Veteran's Mooncloth Slippers 32981
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31, `AllowableClass` = 400 WHERE `entry` = 32981;
-- Marshal's Chain Bracers 28973
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 18, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Intellect, `stat_value3` = 9, `stat_type4` = @AttackPower, `stat_value4` = 16, `stat_type5` = @Crit, `stat_value5` = 7, `stat_type6` = @Resilience, `stat_value6` = 11, `AllowableClass` = 68 WHERE `entry` = 28973;
-- Marshal's Mooncloth Belt 32976
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 32976;
-- Marshal's Lamellar Belt 28983
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 28983;
-- Veteran's Silk Footguards 32795
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 400 WHERE `entry` = 32795;
-- General's Wyrmhide Boots 28447
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 28447;
-- Marshal's Plate Bracers 28996
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Crit, `stat_value3` = 14, `stat_type4` = @Resilience, `stat_value4` = 14, `AllowableClass` = 35 WHERE `entry` = 28996;
-- Marshal's Mail Girdle 28993
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 28993;
-- Veteran's Dreadweave Belt 32799
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31, `AllowableClass` = 400 WHERE `entry` = 32799;
-- Marshal's Leather Belt 28986
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 28986;
-- General's Linked Girdle 28629
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19, `AllowableClass` = 68 WHERE `entry` = 28629;
-- Marshal's Wyrmhide Belt 29004
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 29004;
-- General's Kodohide Bracers 31598
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 13, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 14, `AllowableClass` = 1032 WHERE `entry` = 31598;
-- Veteran's Mail Girdle 32804
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27, `AllowableClass` = 68 WHERE `entry` = 32804;
-- Marshal's Ornamented Bracers 32986
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 3 WHERE `entry` = 32986;
-- General's Plate Greaves Tier 2 30491
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 3 WHERE `entry` = 30491;
-- General's Scaled Bracers 28646
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 26, `stat_type2` = @Stamina, `stat_value2` = 22, `stat_type3` = @Intellect, `stat_value3` = 11, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 8, `AllowableClass` = 3 WHERE `entry` = 28646;
-- Marshal's Lamellar Bracers 28984
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 3 WHERE `entry` = 28984;
-- Marshal's Ornamented Belt 32985
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 32985;
-- General's Linked Bracers 28605
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 9, `stat_type3` = @AttackPower, `stat_value3` = 38, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 10, `AllowableClass` = 68 WHERE `entry` = 28605;
-- General's Scaled Greaves 28645
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16, `AllowableClass` = 3 WHERE `entry` = 28645;
-- Veteran's Linked Girdle 32803
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 20, `stat_type3` = @AttackPower, `stat_value3` = 62, `stat_type4` = @Crit, `stat_value4` = 30, `stat_type5` = @Resilience, `stat_value5` = 21, `AllowableClass` = 68 WHERE `entry` = 32803;
-- Marshal's Kodohide Bracers 31599
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 13, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 14, `AllowableClass` = 1032 WHERE `entry` = 31599;
-- Veteran's Ornamented Greaves 32990
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 3 WHERE `entry` = 32990;
-- Marshal's Ringmail Sabatons 32996
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 32996;
-- Marshal's Mooncloth Cuffs 32977
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14, `AllowableClass` = 400 WHERE `entry` = 32977;
-- General's Ringmail Bracers 32991
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 68 WHERE `entry` = 32991;
-- Veteran's Kodohide Belt 32800
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 32800;
-- General's Plate Greaves 28383
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 35 WHERE `entry` = 28383;
-- Marshal's Plate Belt 28995
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 35 WHERE `entry` = 28995;
-- Veteran's Scaled Greaves 32794
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 41, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 27, `stat_type4` = @Crit, `stat_value4` = 18, `stat_type5` = @Resilience, `stat_value5` = 18, `AllowableClass` = 3 WHERE `entry` = 32794;
-- General's Ringmail Girdle 32992
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 32992;
-- Veteran's Lamellar Belt 32801
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 3 WHERE `entry` = 32801;
-- Veteran's Kodohide Bracers 32812
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @SpellPower, `stat_value3` = 16, `stat_type4` = @MP5, `stat_value4` = 8, `stat_type5` = @Resilience, `stat_value5` = 18, `AllowableClass` = 1032 WHERE `entry` = 32812;
-- General's Lamellar Bracers 28643
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 3 WHERE `entry` = 28643;
-- Veteran's Mail Bracers 32817
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 17, `stat_type5` = @Resilience, `stat_value5` = 15, `AllowableClass` = 68 WHERE `entry` = 32817;
-- Marshal's Scaled Belt 28998
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16, `AllowableClass` = 3 WHERE `entry` = 28998;
-- General's Mail Girdle 28639
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 28639;
-- General's Ornamented Belt 32982
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 32982;
-- Veteran's Dragonhide Boots 32786
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Agility, `stat_value2` = 26, `stat_type3` = @Stamina, `stat_value3` = 39, `stat_type4` = @Intellect, `stat_value4` = 17, `stat_type5` = @SpellPower, `stat_value5` = 22, `stat_type6` = @Resilience, `stat_value6` = 26, `AllowableClass` = 1032 WHERE `entry` = 32786;
-- Veteran's Ringmail Sabatons 32999
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27, `AllowableClass` = 68 WHERE `entry` = 32999;
-- Marshal's Mail Sabatons 28994
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 28994;
-- Veteran's Wyrmhide Belt 32808
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 32808;
-- Marshal's Chain Sabatons 28975
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18, `AllowableClass` = 68 WHERE `entry` = 28975;
-- General's Mooncloth Slippers 32975
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 32975;
-- Veteran's Wyrmhide Boots 32796
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 32796;
-- Veteran's Mail Sabatons 32792
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27, `AllowableClass` = 68 WHERE `entry` = 32792;
-- Veteran's Dragonhide Belt 32798
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Agility, `stat_value2` = 26, `stat_type3` = @Stamina, `stat_value3` = 39, `stat_type4` = @Intellect, `stat_value4` = 17, `stat_type5` = @SpellPower, `stat_value5` = 22, `stat_type6` = @Resilience, `stat_value6` = 26, `AllowableClass` = 1032 WHERE `entry` = 32798;
-- Marshal's Ringmail Girdle 32995
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `AllowableClass` = 68 WHERE `entry` = 32995;
-- General's Dragonhide Bracers 28445
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 16, `stat_type2` = @Agility, `stat_value2` = 13, `stat_type3` = @Stamina, `stat_value3` = 22, `stat_type4` = @SpellPower, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 11, `AllowableClass` = 1032 WHERE `entry` = 28445;
-- Marshal's Ringmail Bracers 32994
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 68 WHERE `entry` = 32994;
-- General's Mail Bracers 28638
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `AllowableClass` = 68 WHERE `entry` = 28638;
-- General's Kodohide Boots 31595
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 31595;
-- Marshal's Leather Boots 28987
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26, `AllowableClass` = 1032 WHERE `entry` = 28987;
-- Marshal's Linked Girdle 28990
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19, `AllowableClass` = 68 WHERE `entry` = 28990;
-- General's Mooncloth Cuffs 32973
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14, `AllowableClass` = 400 WHERE `entry` = 32973;
-- Veteran's Linked Sabatons 32791
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 20, `stat_type3` = @AttackPower, `stat_value3` = 60, `stat_type4` = @Crit, `stat_value4` = 31, `stat_type5` = @Resilience, `stat_value5` = 21, `AllowableClass` = 68 WHERE `entry` = 32791;
-- Marshal's Kodohide Belt 31596
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 1032 WHERE `entry` = 31596;
-- Veteran's Plate Belt 32805
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 31, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Crit, `stat_value3` = 31, `stat_type4` = @Resilience, `stat_value4` = 30, `AllowableClass` = 35 WHERE `entry` = 32805;
-- General's Silk Belt 28409
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 400 WHERE `entry` = 28409;
-- Veteran's Leather Boots 32790
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @AttackPower, `stat_value3` = 34, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 30, `AllowableClass` = 1032 WHERE `entry` = 32790;
-- Veteran's Lamellar Bracers 32813
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 15, `AllowableClass` = 3 WHERE `entry` = 32813;
-- Marshal's Scaled Bracers 28999
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 26, `stat_type2` = @Stamina, `stat_value2` = 22, `stat_type3` = @Intellect, `stat_value3` = 11, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 8, `AllowableClass` = 3 WHERE `entry` = 28999;
-- Veteran's Chain Sabatons 32785
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Intellect, `stat_value3` = 20, `stat_type4` = @AttackPower, `stat_value4` = 32, `stat_type5` = @Crit, `stat_value5` = 16, `stat_type6` = @Resilience, `stat_value6` = 21, `AllowableClass` = 68 WHERE `entry` = 32785;
-- Veteran's Mooncloth Belt 32979
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31, `AllowableClass` = 400 WHERE `entry` = 32979;
-- Marshal's Lamellar Greaves 28985
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 28985;
-- Marshal's Ornamented Greaves 32987
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 3 WHERE `entry` = 32987;
-- General's Dreadweave Cuffs 28405
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14, `AllowableClass` = 400 WHERE `entry` = 28405;
-- Veteran's Scaled Belt 32806
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 41, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 27, `stat_type4` = @Crit, `stat_value4` = 18, `stat_type5` = @Resilience, `stat_value5` = 18, `AllowableClass` = 3 WHERE `entry` = 32806;
-- General's Dreadweave Belt 28404
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `AllowableClass` = 400 WHERE `entry` = 28404;
-- Marshal's Silk Footguards 29003
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24, `AllowableClass` = 400 WHERE `entry` = 29003;
-- Marshal's Chain Girdle 28974
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18, `AllowableClass` = 68 WHERE `entry` = 28974;
-- Veteran's Mooncloth Cuffs 32980
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 31, `stat_type2` = @Intellect, `stat_value2` = 16, `stat_type3` = @SpellPower, `stat_value3` = 25, `stat_type4` = @Resilience, `stat_value4` = 17, `AllowableClass` = 400 WHERE `entry` = 32980;
