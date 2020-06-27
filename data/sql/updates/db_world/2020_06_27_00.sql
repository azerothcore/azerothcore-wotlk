-- DB update 2020_06_25_00 -> 2020_06_27_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_25_00 2020_06_27_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1589122395528568300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1589122395528568300');
/*
 * Dungeon: Sethekk Halls
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 1017, `maxdmg` = 1431, `DamageModifier` = 1.03 WHERE `entry` = 18323;
UPDATE `creature_template` SET `mindmg` = 1488, `maxdmg` = 2191, `DamageModifier` = 1.03 WHERE `entry` = 20692;
UPDATE `creature_template` SET `mindmg` = 1017, `maxdmg` = 1431, `DamageModifier` = 1.03 WHERE `entry` = 18318;
UPDATE `creature_template` SET `mindmg` = 1488, `maxdmg` = 2103, `DamageModifier` = 1.03 WHERE `entry` = 20693;
UPDATE `creature_template` SET `mindmg` = 705, `maxdmg` = 1019, `DamageModifier` = 1.03 WHERE `entry` = 18327;
UPDATE `creature_template` SET `mindmg` = 1034, `maxdmg` = 1497, `DamageModifier` = 1.03 WHERE `entry` = 20691;
UPDATE `creature_template` SET `mindmg` = 715, `maxdmg` = 1019, `DamageModifier` = 1.03 WHERE `entry` = 19429;
UPDATE `creature_template` SET `mindmg` = 927, `maxdmg` = 1386, `DamageModifier` = 1.03 WHERE `entry` = 20686;
UPDATE `creature_template` SET `mindmg` = 705, `maxdmg` = 1019, `DamageModifier` = 1.03 WHERE `entry` = 18328;
UPDATE `creature_template` SET `mindmg` = 1034, `maxdmg` = 1565, `DamageModifier` = 1.03 WHERE `entry` = 20694;
UPDATE `creature_template` SET `mindmg` = 851, `maxdmg` = 1219, `DamageModifier` = 1.03 WHERE `entry` = 18322;
UPDATE `creature_template` SET `mindmg` = 1083, `maxdmg` = 1534, `DamageModifier` = 1.03 WHERE `entry` = 20696;
UPDATE `creature_template` SET `mindmg` = 649, `maxdmg` = 1017, `DamageModifier` = 1.03 WHERE `entry` = 21891;
UPDATE `creature_template` SET `mindmg` = 815, `maxdmg` = 1126, `DamageModifier` = 1.03 WHERE `entry` = 21989;
UPDATE `creature_template` SET `mindmg` = 984, `maxdmg` = 1386, `DamageModifier` = 1.03 WHERE `entry` = 19428;
UPDATE `creature_template` SET `mindmg` = 1436, `maxdmg` = 2032, `DamageModifier` = 1.03 WHERE `entry` = 20688;
UPDATE `creature_template` SET `mindmg` = 626, `maxdmg` = 906, `DamageModifier` = 1.03 WHERE `entry` = 18319;
UPDATE `creature_template` SET `mindmg` = 958, `maxdmg` = 1391, `DamageModifier` = 1.03 WHERE `entry` = 20697;
UPDATE `creature_template` SET `mindmg` = 886, `maxdmg` = 1308, `DamageModifier` = 1.03 WHERE `entry` = 18321;
UPDATE `creature_template` SET `mindmg` = 1005, `maxdmg` = 1479, `DamageModifier` = 1.03 WHERE `entry` = 20701;
UPDATE `creature_template` SET `mindmg` = 739, `maxdmg` = 1069, `DamageModifier` = 1.03 WHERE `entry` = 18325;
UPDATE `creature_template` SET `mindmg` = 1034, `maxdmg` = 1629, `DamageModifier` = 1.03 WHERE `entry` = 20695;
UPDATE `creature_template` SET `mindmg` = 1064, `maxdmg` = 1428, `DamageModifier` = 1.03 WHERE `entry` = 21904;
UPDATE `creature_template` SET `mindmg` = 1186, `maxdmg` = 1534, `DamageModifier` = 1.03 WHERE `entry` = 21990;
UPDATE `creature_template` SET `mindmg` = 825, `maxdmg` = 1163, `DamageModifier` = 1.03 WHERE `entry` = 18326;
UPDATE `creature_template` SET `mindmg` = 1005, `maxdmg` = 1479, `DamageModifier` = 1.03 WHERE `entry` = 20699;
UPDATE `creature_template` SET `mindmg` = 773, `maxdmg` = 1119, `DamageModifier` = 1.03 WHERE `entry` = 18320;
UPDATE `creature_template` SET `mindmg` = 872, `maxdmg` = 1267, `DamageModifier` = 1.03 WHERE `entry` = 20698;
UPDATE `creature_template` SET `mindmg` = 356, `maxdmg` = 486, `DamageModifier` = 1.03 WHERE `entry` = 20132;

/* BOSS */
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 821, `maxdmg` = 1118, `DamageModifier` = 1.01 WHERE `entry` = 18472;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 1246, `maxdmg` = 1810, `DamageModifier` = 1.01 WHERE `entry` = 20690;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 821, `maxdmg` = 1118, `DamageModifier` = 1.01 WHERE `entry` = 18473;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 1267, `maxdmg` = 1750, `DamageModifier` = 1.01 WHERE `entry` = 20706;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 1327, `maxdmg` = 1880, `DamageModifier` = 1.01 WHERE `entry` = 23035;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
