-- DB update 2023_09_20_06 -> 2023_09_20_07
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

-- General's Ornamented Bracers 32983   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 624, `AllowableClass` = 3 WHERE `entry` = 32983;
-- Marshal's Ornamented Bracers 32986   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 624, `AllowableClass` = 3 WHERE `entry` = 32986;
-- General's Ringmail Bracers 32991   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 349, `AllowableClass` = 68 WHERE `entry` = 32991;
-- Marshal's Ringmail Bracers 32994   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 349, `AllowableClass` = 68 WHERE `entry` = 32994;
-- General's Mooncloth Cuffs 32973   113
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14, `armor` = 84, `AllowableClass` = 400 WHERE `entry` = 32973;
-- Marshal's Mooncloth Cuffs 32977   113
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14, `armor` = 84, `AllowableClass` = 400 WHERE `entry` = 32977;
-- General's Plate Greaves Tier 2 30491   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 1063, `AllowableClass` = 3 WHERE `entry` = 30491;
-- General's Ornamented Belt 32982   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 870, `AllowableClass` = 3 WHERE `entry` = 32982;
-- General's Ornamented Greaves 32984   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 1063, `AllowableClass` = 3 WHERE `entry` = 32984;
-- Marshal's Ornamented Belt 32985   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 870, `AllowableClass` = 3 WHERE `entry` = 32985;
-- Marshal's Ornamented Greaves 32987   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 1063, `AllowableClass` = 3 WHERE `entry` = 32987;
-- General's Ringmail Girdle 32992   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `armor` = 487, `AllowableClass` = 68 WHERE `entry` = 32992;
-- General's Ringmail Sabatons 32993   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `armor` = 595, `AllowableClass` = 68 WHERE `entry` = 32993;
-- Marshal's Ringmail Girdle 32995   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `armor` = 487, `AllowableClass` = 68 WHERE `entry` = 32995;
-- Marshal's Ringmail Sabatons 32996   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `armor` = 595, `AllowableClass` = 68 WHERE `entry` = 32996;
-- General's Mooncloth Belt 32974   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 117, `AllowableClass` = 400 WHERE `entry` = 32974;
-- General's Mooncloth Slippers 32975   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 142, `AllowableClass` = 400 WHERE `entry` = 32975;
-- Marshal's Mooncloth Belt 32976   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 117, `AllowableClass` = 400 WHERE `entry` = 32976;
-- Marshal's Mooncloth Slippers 32978   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 142, `AllowableClass` = 400 WHERE `entry` = 32978;

UPDATE `item_template` SET `Flags` = `Flags`|32768, `FlagsExtra` = `FlagsExtra`&~8192, `BuyPrice` = 0, `SellPrice` = 0, `AllowableRace` = 32767, `VerifiedBuild` = 0 WHERE `entry` IN (
32983, -- General's Ornamented Bracers
32986, -- Marshal's Ornamented Bracers
32991, -- General's Ringmail Bracers
32994, -- Marshal's Ringmail Bracers
32973, -- General's Mooncloth Cuffs
32977, -- Marshal's Mooncloth Cuffs
30491, -- General's Plate Greaves Tier 2
32982, -- General's Ornamented Belt
32984, -- General's Ornamented Greaves
32985, -- Marshal's Ornamented Belt
32987, -- Marshal's Ornamented Greaves
32992, -- General's Ringmail Girdle
32993, -- General's Ringmail Sabatons
32995, -- Marshal's Ringmail Girdle
32996, -- Marshal's Ringmail Sabatons
32974, -- General's Mooncloth Belt
32975, -- General's Mooncloth Slippers
32976, -- Marshal's Mooncloth Belt
32978  -- Marshal's Mooncloth Slippers
);
