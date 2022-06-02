-- DB update 2020_06_08_00 -> 2020_06_09_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_08_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_08_00 2020_06_09_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588338509800182100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588338509800182100');

/*
 * Dungeon: Hellfire Ramparts
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 411, `maxdmg` = 609, `DamageModifier` = 1.03 WHERE `entry` = 17264;
UPDATE `creature_template` SET `mindmg` = 928, `maxdmg` = 1315, `DamageModifier` = 1.03 WHERE `entry` = 18054;
UPDATE `creature_template` SET `mindmg` = 411, `maxdmg` = 609, `DamageModifier` = 1.03 WHERE `entry` = 17259;
UPDATE `creature_template` SET `mindmg` = 928, `maxdmg` = 1315, `DamageModifier` = 1.03 WHERE `entry` = 18053;
UPDATE `creature_template` SET `mindmg` = 479, `maxdmg` = 657, `DamageModifier` = 1.03 WHERE `entry` = 17280;
UPDATE `creature_template` SET `mindmg` = 1069, `maxdmg` = 1510, `DamageModifier` = 1.03 WHERE `entry` = 18059;
UPDATE `creature_template` SET `mindmg` = 685, `maxdmg` = 1015, `DamageModifier` = 1.03 WHERE `entry` = 17271;
UPDATE `creature_template` SET `mindmg` = 893, `maxdmg` = 1315, `DamageModifier` = 1.03 WHERE `entry` = 18052;
UPDATE `creature_template` SET `mindmg` = 534, `maxdmg` = 814, `DamageModifier` = 1.03 WHERE `entry` = 17269;
UPDATE `creature_template` SET `mindmg` = 719, `maxdmg` = 1043, `DamageModifier` = 1.03 WHERE `entry` = 18049;
UPDATE `creature_template` SET `mindmg` = 392, `maxdmg` = 579, `minrangedmg` = 513, `maxrangedmg` = 821, `DamageModifier` = 1.03 WHERE `entry` = 17270;
UPDATE `creature_template` SET `mindmg` = 830, `maxdmg` = 1219, `minrangedmg` = 1169, `maxrangedmg` = 1819, `DamageModifier` = 1.03 WHERE `entry` = 18048;
UPDATE `creature_template` SET `mindmg` = 320, `maxdmg` = 488, `DamageModifier` = 1.03 WHERE `entry` = 17478;
UPDATE `creature_template` SET `mindmg` = 780, `maxdmg` = 1133, `DamageModifier` = 1.03 WHERE `entry` = 18050;
UPDATE `creature_template` SET `mindmg` = 440, `maxdmg` = 609, `DamageModifier` = 1.03 WHERE `entry` = 17281;
UPDATE `creature_template` SET `mindmg` = 1009, `maxdmg` = 1429, `DamageModifier` = 1.03 WHERE `entry` = 18055;
UPDATE `creature_template` SET `mindmg` = 411, `maxdmg` = 567, `DamageModifier` = 1.03 WHERE `entry` = 17455;
UPDATE `creature_template` SET `mindmg` = 959, `maxdmg` = 1355, `DamageModifier` = 1.03 WHERE `entry` = 18051;
UPDATE `creature_template` SET `mindmg` = 300, `maxdmg` = 429, `DamageModifier` = 1.03 WHERE `entry` = 17309;
UPDATE `creature_template` SET `mindmg` = 661, `maxdmg` = 957, `DamageModifier` = 1.03 WHERE `entry` = 18058;
UPDATE `creature_template` SET `mindmg` = 320, `maxdmg` = 488, `DamageModifier` = 1.03 WHERE `entry` = 17540;
UPDATE `creature_template` SET `mindmg` = 661, `maxdmg` = 957, `DamageModifier` = 1.03 WHERE `entry` = 18056;
UPDATE `creature_template` SET `mindmg` = 270, `maxdmg` = 364, `DamageModifier` = 1.03 WHERE `entry` = 17517;
UPDATE `creature_template` SET `mindmg` = 434, `maxdmg` = 574, `DamageModifier` = 1.03 WHERE `entry` = 18057;

/* BOSS */
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 468, `maxdmg` = 650, `DamageModifier` = 1.01 WHERE `entry` = 17306;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 965, `maxdmg` = 1369, `DamageModifier` = 1.01 WHERE `entry` = 18436;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 736, `maxdmg` = 1024, `DamageModifier` = 1.01 WHERE `entry` = 17308;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 1492, `maxdmg` = 2113, `DamageModifier` = 1.01 WHERE `entry` = 18433;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 838, `maxdmg` = 1165, `DamageModifier` = 1.01 WHERE `entry` = 17536;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 2336, `maxdmg` = 3312, `DamageModifier` = 1.01 WHERE `entry` = 18432;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 1526, `maxdmg` = 2121, `DamageModifier` = 1.01 WHERE `entry` = 17537;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 2336, `maxdmg` = 3312, `DamageModifier` = 1.01 WHERE `entry` = 18434;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
