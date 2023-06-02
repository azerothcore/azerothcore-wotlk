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


-- Veteran's Ornamented Belt 32988   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `armor` = 959, `AllowableClass` = 3 WHERE `entry` = 32988;
-- General's Mooncloth Cuffs 32973   113
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14, `armor` = 84, `AllowableClass` = 400 WHERE `entry` = 32973;
-- General's Wyrmhide Boots 28447   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 307, `ArmorDamageModifier` = 40, `AllowableClass` = 1032 WHERE `entry` = 28447;
-- Marshal's Linked Bracers 28989   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 9, `stat_type3` = @AttackPower, `stat_value3` = 38, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 10, `armor` = 349, `AllowableClass` = 68 WHERE `entry` = 28989;
-- Veteran's Chain Sabatons 32785   136
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Intellect, `stat_value3` = 20, `stat_type4` = @AttackPower, `stat_value4` = 32, `stat_type5` = @Crit, `stat_value5` = 16, `stat_type6` = @Resilience, `stat_value6` = 21, `armor` = 656, `AllowableClass` = 68 WHERE `entry` = 32785;
-- Veteran's Scaled Bracers 32819   126
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 29, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Intellect, `stat_value3` = 13, `stat_type4` = @Crit, `stat_value4` = 8, `stat_type5` = @Resilience, `stat_value5` = 9, `armor` = 693, `AllowableClass` = 3 WHERE `entry` = 32819;
-- Marshal's Ringmail Bracers 32994   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 349, `AllowableClass` = 68 WHERE `entry` = 32994;
-- General's Plate Bracers 28381   113
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Crit, `stat_value3` = 14, `stat_type4` = @Resilience, `stat_value4` = 14, `armor` = 624, `AllowableClass` = 35 WHERE `entry` = 28381;
-- Veteran's Mooncloth Cuffs 32980   126
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 31, `stat_type2` = @Intellect, `stat_value2` = 16, `stat_type3` = @SpellPower, `stat_value3` = 25, `stat_type4` = @Resilience, `stat_value4` = 17, `armor` = 93, `AllowableClass` = 400 WHERE `entry` = 32980;
-- Marshal's Scaled Bracers 28999   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 26, `stat_type2` = @Stamina, `stat_value2` = 22, `stat_type3` = @Intellect, `stat_value3` = 11, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 8, `armor` = 624, `AllowableClass` = 3 WHERE `entry` = 28999;
-- Veteran's Mooncloth Slippers 32981   136
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31, `armor` = 157, `AllowableClass` = 400 WHERE `entry` = 32981;
-- General's Plate Greaves 28383   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 1063, `AllowableClass` = 35 WHERE `entry` = 28383;
-- General's Linked Sabatons 28630   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19, `armor` = 595, `AllowableClass` = 68 WHERE `entry` = 28630;
-- Veteran's Mail Sabatons 32792   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27, `armor` = 656, `AllowableClass` = 68 WHERE `entry` = 32792;
-- Veteran's Mail Bracers 32817   126
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 17, `stat_type5` = @Resilience, `stat_value5` = 15, `armor` = 388, `AllowableClass` = 68 WHERE `entry` = 32817;
-- Veteran's Plate Bracers 32818   126
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 21, `stat_type2` = @Stamina, `stat_value2` = 30, `stat_type3` = @Crit, `stat_value3` = 17, `stat_type4` = @Resilience, `stat_value4` = 17, `armor` = 693, `AllowableClass` = 35 WHERE `entry` = 32818;
-- Marshal's Linked Sabatons 28991   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19, `armor` = 595, `AllowableClass` = 68 WHERE `entry` = 28991;
-- General's Wyrmhide Bracers 28448   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 187, `ArmorDamageModifier` = 30, `AllowableClass` = 1032 WHERE `entry` = 28448;
-- Veteran's Chain Girdle 32797   136
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Intellect, `stat_value3` = 20, `stat_type4` = @AttackPower, `stat_value4` = 32, `stat_type5` = @Crit, `stat_value5` = 16, `stat_type6` = @Resilience, `stat_value6` = 21, `armor` = 537, `AllowableClass` = 68 WHERE `entry` = 32797;
-- General's Dreadweave Stalkers 28402   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 142, `AllowableClass` = 400 WHERE `entry` = 28402;
-- Veteran's Wyrmhide Boots 32796   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26, `armor` = 336, `ArmorDamageModifier` = 42, `AllowableClass` = 1032 WHERE `entry` = 32796;
-- General's Scaled Bracers 28646   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 26, `stat_type2` = @Stamina, `stat_value2` = 22, `stat_type3` = @Intellect, `stat_value3` = 11, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 8, `armor` = 624, `AllowableClass` = 3 WHERE `entry` = 28646;
-- General's Mail Sabatons 28640   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `armor` = 595, `AllowableClass` = 68 WHERE `entry` = 28640;
-- Marshal's Dreadweave Belt 28980   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 117, `AllowableClass` = 400 WHERE `entry` = 28980;
-- Veteran's Silk Belt 32807   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `armor` = 128, `AllowableClass` = 400 WHERE `entry` = 32807;
-- Marshal's Chain Girdle 28974   123
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18, `armor` = 487, `AllowableClass` = 68 WHERE `entry` = 28974;
-- General's Linked Girdle 28629   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19, `armor` = 487, `AllowableClass` = 68 WHERE `entry` = 28629;
-- General's Mail Girdle 28639   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `armor` = 487, `AllowableClass` = 68 WHERE `entry` = 28639;
-- General's Chain Girdle 28450   123
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18, `armor` = 487, `AllowableClass` = 68 WHERE `entry` = 28450;
-- General's Lamellar Greaves 28642   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 1063, `AllowableClass` = 3 WHERE `entry` = 28642;
-- Marshal's Plate Greaves 28997   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 1063, `AllowableClass` = 35 WHERE `entry` = 28997;
-- Marshal's Dreadweave Cuffs 28981   113
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14, `armor` = 84, `AllowableClass` = 400 WHERE `entry` = 28981;
-- Veteran's Mooncloth Belt 32979   136
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31, `armor` = 128, `AllowableClass` = 400 WHERE `entry` = 32979;
-- Veteran's Dreadweave Stalkers 32787   136
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31, `armor` = 157, `AllowableClass` = 400 WHERE `entry` = 32787;
-- Veteran's Chain Bracers 32809   126
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 20, `stat_type2` = @Stamina, `stat_value2` = 29, `stat_type3` = @Intellect, `stat_value3` = 10, `stat_type4` = @AttackPower, `stat_value4` = 18, `stat_type5` = @Crit, `stat_value5` = 8, `stat_type6` = @Resilience, `stat_value6` = 13, `armor` = 388, `AllowableClass` = 68 WHERE `entry` = 32809;
-- Veteran's Kodohide Bracers 32812   126
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @SpellPower, `stat_value3` = 16, `stat_type4` = @MP5, `stat_value4` = 8, `stat_type5` = @Resilience, `stat_value5` = 18, `armor` = 216, `ArmorDamageModifier` = 42, `AllowableClass` = 1032 WHERE `entry` = 32812;
-- Veteran's Silk Footguards 32795   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `armor` = 157, `AllowableClass` = 400 WHERE `entry` = 32795;
-- Veteran's Wyrmhide Belt 32808   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26, `armor` = 283, `ArmorDamageModifier` = 42, `AllowableClass` = 1032 WHERE `entry` = 32808;
-- Marshal's Chain Bracers 28973   113
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 18, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Intellect, `stat_value3` = 9, `stat_type4` = @AttackPower, `stat_value4` = 16, `stat_type5` = @Crit, `stat_value5` = 7, `stat_type6` = @Resilience, `stat_value6` = 11, `armor` = 349, `AllowableClass` = 68 WHERE `entry` = 28973;
-- Marshal's Mooncloth Belt 32976   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 117, `AllowableClass` = 400 WHERE `entry` = 32976;
-- Veteran's Linked Sabatons 32791   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 20, `stat_type3` = @AttackPower, `stat_value3` = 60, `stat_type4` = @Crit, `stat_value4` = 31, `stat_type5` = @Resilience, `stat_value5` = 21, `armor` = 656, `AllowableClass` = 68 WHERE `entry` = 32791;
-- Marshal's Ringmail Girdle 32995   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `armor` = 487, `AllowableClass` = 68 WHERE `entry` = 32995;
-- Marshal's Lamellar Bracers 28984   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 624, `AllowableClass` = 3 WHERE `entry` = 28984;
-- General's Kodohide Boots 31595   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 307, `ArmorDamageModifier` = 40, `AllowableClass` = 1032 WHERE `entry` = 31595;
-- General's Lamellar Belt 28641   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 870, `AllowableClass` = 3 WHERE `entry` = 28641;
-- Marshal's Kodohide Bracers 31599   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 13, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 14, `armor` = 187, `ArmorDamageModifier` = 30, `AllowableClass` = 1032 WHERE `entry` = 31599;
-- Marshal's Wyrmhide Boots 29005   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 307, `ArmorDamageModifier` = 40, `AllowableClass` = 1032 WHERE `entry` = 29005;
-- General's Chain Bracers 28451   113
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 18, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Intellect, `stat_value3` = 9, `stat_type4` = @AttackPower, `stat_value4` = 16, `stat_type5` = @Crit, `stat_value5` = 7, `stat_type6` = @Resilience, `stat_value6` = 11, `armor` = 349, `AllowableClass` = 68 WHERE `entry` = 28451;
-- General's Dreadweave Belt 28404   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 117, `AllowableClass` = 400 WHERE `entry` = 28404;
-- General's Wyrmhide Belt 28446   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 259, `ArmorDamageModifier` = 40, `AllowableClass` = 1032 WHERE `entry` = 28446;
-- Veteran's Mail Girdle 32804   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27, `armor` = 537, `AllowableClass` = 68 WHERE `entry` = 32804;
-- Marshal's Dragonhide Boots 28977   123
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23, `armor` = 307, `ArmorDamageModifier` = 40, `AllowableClass` = 1032 WHERE `entry` = 28977;
-- General's Ornamented Belt 32982   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 870, `AllowableClass` = 3 WHERE `entry` = 32982;
-- General's Dreadweave Cuffs 28405   113
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14, `armor` = 84, `AllowableClass` = 400 WHERE `entry` = 28405;
-- General's Silk Belt 28409   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 117, `AllowableClass` = 400 WHERE `entry` = 28409;
-- Veteran's Ornamented Bracers 32989   126
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 15, `armor` = 693, `AllowableClass` = 3 WHERE `entry` = 32989;
-- General's Leather Bracers 28424   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @AttackPower, `stat_value3` = 16, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 157, `AllowableClass` = 1032 WHERE `entry` = 28424;
-- Veteran's Kodohide Belt 32800   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26, `armor` = 283, `ArmorDamageModifier` = 42, `AllowableClass` = 1032 WHERE `entry` = 32800;
-- Marshal's Kodohide Boots 31597   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 307, `ArmorDamageModifier` = 40, `AllowableClass` = 1032 WHERE `entry` = 31597;
-- Veteran's Plate Greaves 32793   136
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 31, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Crit, `stat_value3` = 31, `stat_type4` = @Resilience, `stat_value4` = 30, `armor` = 1172, `AllowableClass` = 35 WHERE `entry` = 32793;
-- Marshal's Ornamented Greaves 32987   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 1063, `AllowableClass` = 3 WHERE `entry` = 32987;
-- Veteran's Silk Cuffs 32820   126
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 93, `AllowableClass` = 400 WHERE `entry` = 32820;
-- General's Ornamented Greaves 32984   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 1063, `AllowableClass` = 3 WHERE `entry` = 32984;
-- Veteran's Ringmail Sabatons 32999   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27, `armor` = 656, `AllowableClass` = 68 WHERE `entry` = 32999;
-- Marshal's Mooncloth Cuffs 32977   113
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Resilience, `stat_value4` = 14, `armor` = 84, `AllowableClass` = 400 WHERE `entry` = 32977;
-- Marshal's Wyrmhide Belt 29004   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 259, `ArmorDamageModifier` = 40, `AllowableClass` = 1032 WHERE `entry` = 29004;
-- Marshal's Silk Footguards 29003   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 142, `AllowableClass` = 400 WHERE `entry` = 29003;
-- Veteran's Leather Boots 32790   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @AttackPower, `stat_value3` = 34, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 30, `armor` = 294, `AllowableClass` = 1032 WHERE `entry` = 32790;
-- General's Linked Bracers 28605   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 9, `stat_type3` = @AttackPower, `stat_value3` = 38, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 10, `armor` = 349, `AllowableClass` = 68 WHERE `entry` = 28605;
-- Marshal's Mail Bracers 28992   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 349, `AllowableClass` = 68 WHERE `entry` = 28992;
-- Veteran's Scaled Belt 32806   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 41, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 27, `stat_type4` = @Crit, `stat_value4` = 18, `stat_type5` = @Resilience, `stat_value5` = 18, `armor` = 959, `AllowableClass` = 3 WHERE `entry` = 32806;
-- General's Ringmail Girdle 32992   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `armor` = 487, `AllowableClass` = 68 WHERE `entry` = 32992;
-- General's Mail Bracers 28638   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 349, `AllowableClass` = 68 WHERE `entry` = 28638;
-- Veteran's Leather Belt 32802   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 30, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @AttackPower, `stat_value3` = 34, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 30, `armor` = 241, `AllowableClass` = 1032 WHERE `entry` = 32802;
-- General's Leather Belt 28423   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26, `armor` = 219, `AllowableClass` = 1032 WHERE `entry` = 28423;
-- Veteran's Plate Belt 32805   136
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 31, `stat_type2` = @Stamina, `stat_value2` = 45, `stat_type3` = @Crit, `stat_value3` = 31, `stat_type4` = @Resilience, `stat_value4` = 30, `armor` = 959, `AllowableClass` = 35 WHERE `entry` = 32805;
-- Marshal's Linked Girdle 28990   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 18, `stat_type3` = @AttackPower, `stat_value3` = 54, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 19, `armor` = 487, `AllowableClass` = 68 WHERE `entry` = 28990;
-- Veteran's Linked Girdle 32803   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 20, `stat_type3` = @AttackPower, `stat_value3` = 62, `stat_type4` = @Crit, `stat_value4` = 30, `stat_type5` = @Resilience, `stat_value5` = 21, `armor` = 537, `AllowableClass` = 68 WHERE `entry` = 32803;
-- Marshal's Scaled Belt 28998   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16, `armor` = 870, `AllowableClass` = 3 WHERE `entry` = 28998;
-- General's Scaled Greaves 28645   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16, `armor` = 1063, `AllowableClass` = 3 WHERE `entry` = 28645;
-- General's Dragonhide Bracers 28445   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 16, `stat_type2` = @Agility, `stat_value2` = 13, `stat_type3` = @Stamina, `stat_value3` = 22, `stat_type4` = @SpellPower, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 11, `armor` = 213, `ArmorDamageModifier` = 56, `AllowableClass` = 1032 WHERE `entry` = 28445;
-- Veteran's Dragonhide Bracers 32810   126
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 19, `stat_type2` = @Agility, `stat_value2` = 18, `stat_type3` = @Stamina, `stat_value3` = 25, `stat_type4` = @SpellPower, `stat_value4` = 11, `stat_type5` = @Resilience, `stat_value5` = 17, `armor` = 216, `ArmorDamageModifier` = 42, `AllowableClass` = 1032 WHERE `entry` = 32810;
-- Marshal's Ornamented Belt 32985   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 870, `AllowableClass` = 3 WHERE `entry` = 32985;
-- Marshal's Chain Sabatons 28975   123
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18, `armor` = 595, `AllowableClass` = 68 WHERE `entry` = 28975;
-- Marshal's Silk Cuffs 29002   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 17, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 12, `stat_type5` = @Resilience, `stat_value5` = 11, `armor` = 84, `AllowableClass` = 400 WHERE `entry` = 29002;
-- Veteran's Dreadweave Cuffs 32811   126
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 31, `stat_type2` = @Intellect, `stat_value2` = 16, `stat_type3` = @SpellPower, `stat_value3` = 25, `stat_type4` = @Resilience, `stat_value4` = 17, `armor` = 93, `AllowableClass` = 400 WHERE `entry` = 32811;
-- Marshal's Ringmail Sabatons 32996   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `armor` = 595, `AllowableClass` = 68 WHERE `entry` = 32996;
-- Veteran's Dragonhide Belt 32798   136
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Agility, `stat_value2` = 26, `stat_type3` = @Stamina, `stat_value3` = 39, `stat_type4` = @Intellect, `stat_value4` = 17, `stat_type5` = @SpellPower, `stat_value5` = 22, `stat_type6` = @Resilience, `stat_value6` = 26, `armor` = 283, `ArmorDamageModifier` = 42, `AllowableClass` = 1032 WHERE `entry` = 32798;
-- Marshal's Leather Boots 28987   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26, `armor` = 267, `AllowableClass` = 1032 WHERE `entry` = 28987;
-- General's Ringmail Bracers 32991   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 349, `AllowableClass` = 68 WHERE `entry` = 32991;
-- Veteran's Scaled Greaves 32794   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 41, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 27, `stat_type4` = @Crit, `stat_value4` = 18, `stat_type5` = @Resilience, `stat_value5` = 18, `armor` = 1172, `AllowableClass` = 3 WHERE `entry` = 32794;
-- General's Plate Greaves Tier 2 30491   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 1063, `AllowableClass` = 3 WHERE `entry` = 30491;
-- Marshal's Dragonhide Belt 28976   123
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23, `armor` = 259, `ArmorDamageModifier` = 40, `AllowableClass` = 1032 WHERE `entry` = 28976;
-- Marshal's Dragonhide Bracers 28978   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 16, `stat_type2` = @Agility, `stat_value2` = 13, `stat_type3` = @Stamina, `stat_value3` = 22, `stat_type4` = @SpellPower, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 11, `armor` = 213, `ArmorDamageModifier` = 56, `AllowableClass` = 1032 WHERE `entry` = 28978;
-- General's Chain Sabatons 28449   123
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @Intellect, `stat_value3` = 18, `stat_type4` = @AttackPower, `stat_value4` = 30, `stat_type5` = @Crit, `stat_value5` = 14, `stat_type6` = @Resilience, `stat_value6` = 18, `armor` = 595, `AllowableClass` = 68 WHERE `entry` = 28449;
-- Marshal's Leather Bracers 28988   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @AttackPower, `stat_value3` = 16, `stat_type4` = @Crit, `stat_value4` = 7, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 157, `AllowableClass` = 1032 WHERE `entry` = 28988;
-- General's Plate Belt 28385   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 870, `AllowableClass` = 35 WHERE `entry` = 28385;
-- Marshal's Wyrmhide Bracers 29006   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 187, `ArmorDamageModifier` = 30, `AllowableClass` = 1032 WHERE `entry` = 29006;
-- General's Mooncloth Belt 32974   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 117, `AllowableClass` = 400 WHERE `entry` = 32974;
-- Marshal's Mooncloth Slippers 32978   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 142, `AllowableClass` = 400 WHERE `entry` = 32978;
-- Marshal's Ornamented Bracers 32986   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 624, `AllowableClass` = 3 WHERE `entry` = 32986;
-- Marshal's Scaled Greaves 29000   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16, `armor` = 1063, `AllowableClass` = 3 WHERE `entry` = 29000;
-- Marshal's Plate Bracers 28996   113
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 19, `stat_type2` = @Stamina, `stat_value2` = 25, `stat_type3` = @Crit, `stat_value3` = 14, `stat_type4` = @Resilience, `stat_value4` = 14, `armor` = 624, `AllowableClass` = 35 WHERE `entry` = 28996;
-- Veteran's Lamellar Greaves 32789   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `armor` = 1172, `AllowableClass` = 3 WHERE `entry` = 32789;
-- General's Scaled Belt 28644   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Strength, `stat_value1` = 36, `stat_type2` = @Stamina, `stat_value2` = 33, `stat_type3` = @Intellect, `stat_value3` = 23, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 16, `armor` = 870, `AllowableClass` = 3 WHERE `entry` = 28644;
-- Marshal's Silk Belt 29001   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 117, `AllowableClass` = 400 WHERE `entry` = 29001;
-- Veteran's Lamellar Belt 32801   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `armor` = 959, `AllowableClass` = 3 WHERE `entry` = 32801;
-- Veteran's Ornamented Greaves 32990   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 27, `stat_type5` = @Resilience, `stat_value5` = 26, `armor` = 1172, `AllowableClass` = 3 WHERE `entry` = 32990;
-- General's Leather Boots 28422   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26, `armor` = 267, `AllowableClass` = 1032 WHERE `entry` = 28422;
-- Marshal's Lamellar Belt 28983   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 870, `AllowableClass` = 3 WHERE `entry` = 28983;
-- Veteran's Ringmail Bracers 32997   126
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 17, `stat_type5` = @Resilience, `stat_value5` = 15, `armor` = 388, `AllowableClass` = 68 WHERE `entry` = 32997;
-- General's Kodohide Bracers 31598   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 13, `stat_type3` = @SpellPower, `stat_value3` = 12, `stat_type4` = @MP5, `stat_value4` = 5, `stat_type5` = @Resilience, `stat_value5` = 14, `armor` = 187, `ArmorDamageModifier` = 30, `AllowableClass` = 1032 WHERE `entry` = 31598;
-- Veteran's Leather Bracers 32814   126
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 21, `stat_type2` = @Stamina, `stat_value2` = 29, `stat_type3` = @AttackPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 15, `armor` = 174, `AllowableClass` = 1032 WHERE `entry` = 32814;
-- Veteran's Lamellar Bracers 32813   126
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 25, `stat_type2` = @Intellect, `stat_value2` = 14, `stat_type3` = @SpellPower, `stat_value3` = 22, `stat_type4` = @Crit, `stat_value4` = 16, `stat_type5` = @Resilience, `stat_value5` = 15, `armor` = 693, `AllowableClass` = 3 WHERE `entry` = 32813;
-- General's Dragonhide Boots 28444   123
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23, `armor` = 307, `ArmorDamageModifier` = 40, `AllowableClass` = 1032 WHERE `entry` = 28444;
-- Marshal's Dreadweave Stalkers 28982   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 142, `AllowableClass` = 400 WHERE `entry` = 28982;
-- Veteran's Dreadweave Belt 32799   136
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 45, `stat_type2` = @Intellect, `stat_value2` = 30, `stat_type3` = @SpellPower, `stat_value3` = 36, `stat_type4` = @Resilience, `stat_value4` = 31, `armor` = 128, `AllowableClass` = 400 WHERE `entry` = 32799;
-- Marshal's Mail Sabatons 28994   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `armor` = 595, `AllowableClass` = 68 WHERE `entry` = 28994;
-- Marshal's Lamellar Greaves 28985   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 23, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 1063, `AllowableClass` = 3 WHERE `entry` = 28985;
-- Veteran's Linked Bracers 32816   126
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 29, `stat_type2` = @Intellect, `stat_value2` = 11, `stat_type3` = @AttackPower, `stat_value3` = 42, `stat_type4` = @Crit, `stat_value4` = 17, `stat_type5` = @Resilience, `stat_value5` = 12, `armor` = 388, `AllowableClass` = 68 WHERE `entry` = 32816;
-- General's Mooncloth Slippers 32975   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Stamina, `stat_value1` = 40, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 142, `AllowableClass` = 400 WHERE `entry` = 32975;
-- Veteran's Dragonhide Boots 32786   136
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Agility, `stat_value2` = 26, `stat_type3` = @Stamina, `stat_value3` = 39, `stat_type4` = @Intellect, `stat_value4` = 17, `stat_type5` = @SpellPower, `stat_value5` = 22, `stat_type6` = @Resilience, `stat_value6` = 26, `armor` = 336, `ArmorDamageModifier` = 42, `AllowableClass` = 1032 WHERE `entry` = 32786;
-- General's Silk Cuffs 28411   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 17, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 12, `stat_type5` = @Resilience, `stat_value5` = 11, `armor` = 84, `AllowableClass` = 400 WHERE `entry` = 28411;
-- Marshal's Plate Belt 28995   123
UPDATE `item_template` SET `StatsCount` = 4, `stat_type1` = @Strength, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 40, `stat_type3` = @Crit, `stat_value3` = 27, `stat_type4` = @Resilience, `stat_value4` = 27, `armor` = 870, `AllowableClass` = 35 WHERE `entry` = 28995;
-- Marshal's Mail Girdle 28993   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `armor` = 487, `AllowableClass` = 68 WHERE `entry` = 28993;
-- Veteran's Kodohide Boots 32788   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 26, `stat_type3` = @SpellPower, `stat_value3` = 37, `stat_type4` = @MP5, `stat_value4` = 10, `stat_type5` = @Resilience, `stat_value5` = 26, `armor` = 336, `ArmorDamageModifier` = 42, `AllowableClass` = 1032 WHERE `entry` = 32788;
-- Marshal's Leather Belt 28986   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Agility, `stat_value1` = 27, `stat_type2` = @Stamina, `stat_value2` = 39, `stat_type3` = @AttackPower, `stat_value3` = 30, `stat_type4` = @Crit, `stat_value4` = 15, `stat_type5` = @Resilience, `stat_value5` = 26, `armor` = 219, `AllowableClass` = 1032 WHERE `entry` = 28986;
-- General's Kodohide Belt 31594   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 259, `ArmorDamageModifier` = 40, `AllowableClass` = 1032 WHERE `entry` = 31594;
-- Veteran's Ringmail Girdle 32998   136
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 39, `stat_type2` = @Intellect, `stat_value2` = 27, `stat_type3` = @SpellPower, `stat_value3` = 32, `stat_type4` = @Crit, `stat_value4` = 26, `stat_type5` = @Resilience, `stat_value5` = 27, `armor` = 537, `AllowableClass` = 68 WHERE `entry` = 32998;
-- Veteran's Wyrmhide Bracers 32821   126
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 27, `stat_type2` = @Intellect, `stat_value2` = 16, `stat_type3` = @SpellPower, `stat_value3` = 19, `stat_type4` = @MP5, `stat_value4` = 8, `stat_type5` = @Resilience, `stat_value5` = 15, `armor` = 216, `ArmorDamageModifier` = 42, `AllowableClass` = 1032 WHERE `entry` = 32821;
-- General's Ringmail Sabatons 32993   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 23, `armor` = 595, `AllowableClass` = 68 WHERE `entry` = 32993;
-- Marshal's Kodohide Belt 31596   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 34, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 33, `stat_type4` = @MP5, `stat_value4` = 9, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 259, `ArmorDamageModifier` = 40, `AllowableClass` = 1032 WHERE `entry` = 31596;
-- General's Lamellar Bracers 28643   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 624, `AllowableClass` = 3 WHERE `entry` = 28643;
-- General's Dragonhide Belt 28443   123
UPDATE `item_template` SET `StatsCount` = 6, `stat_type1` = @Strength, `stat_value1` = 24, `stat_type2` = @Agility, `stat_value2` = 24, `stat_type3` = @Stamina, `stat_value3` = 33, `stat_type4` = @Intellect, `stat_value4` = 15, `stat_type5` = @SpellPower, `stat_value5` = 20, `stat_type6` = @Resilience, `stat_value6` = 23, `armor` = 259, `ArmorDamageModifier` = 40, `AllowableClass` = 1032 WHERE `entry` = 28443;
-- General's Silk Footguards 28410   123
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 33, `stat_type2` = @Intellect, `stat_value2` = 23, `stat_type3` = @SpellPower, `stat_value3` = 28, `stat_type4` = @Crit, `stat_value4` = 24, `stat_type5` = @Resilience, `stat_value5` = 24, `armor` = 142, `AllowableClass` = 400 WHERE `entry` = 28410;
-- General's Ornamented Bracers 32983   113
UPDATE `item_template` SET `StatsCount` = 5, `stat_type1` = @Stamina, `stat_value1` = 22, `stat_type2` = @Intellect, `stat_value2` = 12, `stat_type3` = @SpellPower, `stat_value3` = 20, `stat_type4` = @Crit, `stat_value4` = 14, `stat_type5` = @Resilience, `stat_value5` = 13, `armor` = 624, `AllowableClass` = 3 WHERE `entry` = 32983;
