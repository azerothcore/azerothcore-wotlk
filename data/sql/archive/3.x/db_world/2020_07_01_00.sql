-- DB update 2020_06_30_00 -> 2020_07_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_30_00 2020_07_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1589122896707983200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1589122896707983200');
/*
 * Dungeon: The Steamvault
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 1067, `maxdmg` = 1637, `DamageModifier` = 1.03 WHERE `entry` = 17802;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 20626;
UPDATE `creature_template` SET `mindmg` = 992, `maxdmg` = 1401, `DamageModifier` = 1.03 WHERE `entry` = 17801;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1142, `DamageModifier` = 1.03 WHERE `entry` = 20623;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1472, `DamageModifier` = 1.03 WHERE `entry` = 21694;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 21914;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1472, `DamageModifier` = 1.03 WHERE `entry` = 17721;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1472, `DamageModifier` = 1.03 WHERE `entry` = 20620;
UPDATE `creature_template` SET `mindmg` = 1044, `maxdmg` = 1479, `DamageModifier` = 1.03 WHERE `entry` = 21695;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 21917;
UPDATE `creature_template` SET `mindmg` = 968, `maxdmg` = 1367, `DamageModifier` = 1.03 WHERE `entry` = 21626;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 21916;
UPDATE `creature_template` SET `mindmg` = 968, `maxdmg` = 1367, `DamageModifier` = 1.03 WHERE `entry` = 17803;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 20622;
UPDATE `creature_template` SET `mindmg` = 1044, `maxdmg` = 1479, `DamageModifier` = 1.03 WHERE `entry` = 17917;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 20627;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1472, `DamageModifier` = 1.03 WHERE `entry` = 17800;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 20621;
UPDATE `creature_template` SET `mindmg` = 968, `maxdmg` = 1423, `DamageModifier` = 1.03 WHERE `entry` = 17722;
UPDATE `creature_template` SET `mindmg` = 1075, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 20625;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1472, `DamageModifier` = 1.03 WHERE `entry` = 17805;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 20624;
UPDATE `creature_template` SET `mindmg` = 696, `maxdmg` = 984, `DamageModifier` = 1.03 WHERE `entry` = 17799;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1534, `DamageModifier` = 1.03 WHERE `entry` = 20628;
UPDATE `creature_template` SET `mindmg` = 968, `maxdmg` = 1367, `DamageModifier` = 1.03 WHERE `entry` = 21338;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 21915;
UPDATE `creature_template` SET `mindmg` = 968, `maxdmg` = 1367, `DamageModifier` = 1.03 WHERE `entry` = 17951;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 20632;
UPDATE `creature_template` SET `mindmg` = 1891, `maxdmg` = 2673, `DamageModifier` = 1.03 WHERE `entry` = 22891;

/* BOSS */
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 1044, `maxdmg` = 1479, `DamageModifier` = 1.01 WHERE `entry` = 17797;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 1163, `maxdmg` = 1647, `DamageModifier` = 1.01 WHERE `entry` = 20629;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 1126, `maxdmg` = 1597, `DamageModifier` = 1.01 WHERE `entry` = 17796;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 1254, `maxdmg` = 1778, `DamageModifier` = 1.01 WHERE `entry` = 20630;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 1126, `maxdmg` = 1597, `DamageModifier` = 1.01 WHERE `entry` = 17798;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 1254, `maxdmg` = 1778, `DamageModifier` = 1.01 WHERE `entry` = 20633;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
