-- DB update 2025_07_29_03 -> 2025_08_01_00
--
ALTER TABLE `item_template` DROP COLUMN `StatsCount`;

UPDATE `item_template` SET `fire_res` = `stat_value1`, `frost_res` = `stat_value2`, `shadow_res` = `stat_value3`, `arcane_res` = `stat_value4`, `nature_res` = `stat_value5`, `stat_type1` = 0, `stat_value1` = 0, `stat_type2` = 0, `stat_value2` = 0, `stat_type3` = 0, `stat_value3` = 0, `stat_type4` = 0, `stat_value4` = 0, `stat_type5` = 0, `stat_value5` = 0, `VerifiedBuild` = 0 WHERE `entry` = 5828;
UPDATE `item_template` SET `fire_res` = `stat_value3`, `nature_res` = `stat_value4`, `stat_type3` = 0, `stat_value3` = 0, `stat_type4` = 0, `stat_value4` = 0, `VerifiedBuild` = 0 WHERE `entry` = 17802;
UPDATE `item_template` SET `fire_res` = `stat_value3`, `stat_type3` = 0, `stat_value3` = 0, `VerifiedBuild` = 0 WHERE `entry` = 18881;
UPDATE `item_template` SET `ArmorDamageModifier` = `stat_value3`, `stat_type3` = 0, `stat_value3` = 0, `VerifiedBuild` = 0 WHERE `entry` = 19065;
UPDATE `item_template` SET `fire_res` = `stat_value3`, `stat_type3` = 0, `stat_value3` = 0, `VerifiedBuild` = 0 WHERE `entry` = 19158;
UPDATE `item_template` SET `ArmorDamageModifier` = `stat_value3`, `fire_res` = `stat_value4`, `frost_res` = `stat_value5`, `shadow_res` = `stat_value6`, `arcane_res` = `stat_value7`, `nature_res` = `stat_value8`, `stat_type3` = 0, `stat_value3` = 0, `stat_type4` = 0, `stat_value4` = 0, `stat_type5` = 0, `stat_value5` = 0, `stat_type6` = 0, `stat_value6` = 0, `stat_type7` = 0, `stat_value7` = 0, `stat_type8` = 0, `stat_value8` = 0, `VerifiedBuild` = 0 WHERE `entry` = 20142;
UPDATE `item_template` SET `ArmorDamageModifier` = `stat_value3`, `stat_type3` = 0, `stat_value3` = 0, `VerifiedBuild` = 0 WHERE `entry` = 20522;
UPDATE `item_template` SET `ArmorDamageModifier` = `stat_value3`, `stat_type3` = 0, `stat_value3` = 0, `shadow_res` = `stat_value4`, `stat_type4` = 0, `stat_value4` = 0, `VerifiedBuild` = 0 WHERE `entry` = 20524;
UPDATE `item_template` SET `nature_res` = `stat_value3`, `stat_type3` = 0, `stat_value3` = 0, `VerifiedBuild` = 0 WHERE `entry` = 21614;
UPDATE `item_template` SET `ArmorDamageModifier` = `stat_value2`, `stat_type2` = 0, `stat_value2` = 0, `VerifiedBuild` = 0 WHERE `entry` = 22230;
UPDATE `item_template` SET `ArmorDamageModifier` = `stat_value5`, `fire_res` = `stat_value6`, `shadow_res` = `stat_value7`,`stat_type5` = 0, `stat_value5` = 0, `stat_type6` = 0, `stat_value6` = 0, `stat_type7` = 0, `stat_value7` = 0, `VerifiedBuild` = 0 WHERE `entry` = 23362;
UPDATE `item_template` SET `nature_res` = `stat_value5`, `arcane_res` = `stat_value6`, `stat_type5` = 0, `stat_value5` = 0, `stat_type6` = 0, `stat_value6` = 0, `VerifiedBuild` = 0 WHERE `entry` = 23363;
UPDATE `item_template` SET `ArmorDamageModifier` = `stat_value5`, `stat_type5` = 0, `stat_value5` = 0, `VerifiedBuild` = 0 WHERE `entry` IN (32113, 32114, 32115, 32116, 32117, 32118, 32119, 32121, 32122, 32123, 32128, 32129, 32130, 32131, 32132);
UPDATE `item_template` SET `ArmorDamageModifier` = `stat_value1`, `stat_type1` = 0, `stat_value1` = 0, `VerifiedBuild` = 0 WHERE `entry` = 34187;
UPDATE `item_template` SET `fire_res` = `stat_value5`, `stat_type5` = 0, `stat_value5` = 0, `VerifiedBuild` = 0 WHERE `entry` = 40762;
UPDATE `item_template` SET `ArmorDamageModifier` = `stat_value1`, `stat_type1` = 0, `stat_value1` = 0, `VerifiedBuild` = 0 WHERE `entry` = 45860;
UPDATE `item_template` SET `ArmorDamageModifier` = `stat_value2`, `stat_type2` = 0, `stat_value2` = 0, `VerifiedBuild` = 0 WHERE `entry` = 48945;
UPDATE `item_template` SET `fire_res` = `stat_value3`, `stat_type3` = 0, `stat_value3` = 0, `VerifiedBuild` = 0 WHERE `entry` = 49312;
UPDATE `item_template` SET `fire_res` = `stat_value5`, `stat_type5` = 0, `stat_value5` = 0, `VerifiedBuild` = 0 WHERE `entry` = 49314;
