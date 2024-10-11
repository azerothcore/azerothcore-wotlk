-- DB update 2020_07_01_00 -> 2020_07_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_07_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_07_01_00 2020_07_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1589123057762319000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1589123057762319000');
/*
 * Dungeon: Underbog
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 780, `maxdmg` = 1084, `DamageModifier` = 1.03 WHERE `entry` = 17724;
UPDATE `creature_template` SET `mindmg` = 1488, `maxdmg` = 2103, `DamageModifier` = 1.03 WHERE `entry` = 20185;
UPDATE `creature_template` SET `mindmg` = 991, `maxdmg` = 1401, `DamageModifier` = 1.03 WHERE `entry` = 17725;
UPDATE `creature_template` SET `mindmg` = 975, `maxdmg` = 1442, `DamageModifier` = 1.03 WHERE `entry` = 20188;
UPDATE `creature_template` SET `mindmg` = 1042, `maxdmg` = 1476, `DamageModifier` = 1.03 WHERE `entry` = 17734;
UPDATE `creature_template` SET `mindmg` = 1093, `maxdmg` = 1528, `DamageModifier` = 1.03 WHERE `entry` = 20187;
UPDATE `creature_template` SET `mindmg` = 920, `maxdmg` = 1301, `DamageModifier` = 1.03 WHERE `entry` = 17871;
UPDATE `creature_template` SET `mindmg` = 921, `maxdmg` = 1348, `DamageModifier` = 1.03 WHERE `entry` = 20190;
UPDATE `creature_template` SET `mindmg` = 875, `maxdmg` = 1222, `DamageModifier` = 1.03 WHERE `entry` = 17727;
UPDATE `creature_template` SET `mindmg` = 1042, `maxdmg` = 1476, `DamageModifier` = 1.03 WHERE `entry` = 20192;
UPDATE `creature_template` SET `mindmg` = 875, `maxdmg` = 1222, `DamageModifier` = 1.03 WHERE `entry` = 17726;
UPDATE `creature_template` SET `mindmg` = 1042, `maxdmg` = 1476, `DamageModifier` = 1.03 WHERE `entry` = 20191;
UPDATE `creature_template` SET `mindmg` = 828, `maxdmg` = 1222, `DamageModifier` = 1.03 WHERE `entry` = 17728;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1475, `DamageModifier` = 1.03 WHERE `entry` = 20181;
UPDATE `creature_template` SET `mindmg` = 828, `maxdmg` = 1222, `DamageModifier` = 1.03 WHERE `entry` = 17735;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1476, `DamageModifier` = 1.03 WHERE `entry` = 20193;
UPDATE `creature_template` SET `mindmg` = 774, `maxdmg` = 1138, `minrangedmg` = 495, `maxrangedmg` = 781, `DamageModifier` = 1.03 WHERE `entry` = 17729;
UPDATE `creature_template` SET `mindmg` = 967, `maxdmg` = 1368, `minrangedmg` = 1223, `maxrangedmg` = 1819, `DamageModifier` = 1.03 WHERE `entry` = 20180;
UPDATE `creature_template` SET `mindmg` = 774, `maxdmg` = 1138, `DamageModifier` = 1.03 WHERE `entry` = 17771;
UPDATE `creature_template` SET `mindmg` = 930, `maxdmg` = 1315, `DamageModifier` = 1.03 WHERE `entry` = 20179;
UPDATE `creature_template` SET `mindmg` = 875, `maxdmg` = 1222, `DamageModifier` = 1.03 WHERE `entry` = 17731;
UPDATE `creature_template` SET `mindmg` = 1042, `maxdmg` = 1476, `DamageModifier` = 1.03 WHERE `entry` = 20173;
UPDATE `creature_template` SET `mindmg` = 828, `maxdmg` = 1154, `DamageModifier` = 1.03 WHERE `entry` = 17723;
UPDATE `creature_template` SET `mindmg` = 991, `maxdmg` = 1402, `DamageModifier` = 1.03 WHERE `entry` = 20164;
UPDATE `creature_template` SET `mindmg` = 1096, `maxdmg` = 1553, `DamageModifier` = 1.03 WHERE `entry` = 17827;
UPDATE `creature_template` SET `mindmg` = 1845, `maxdmg` = 2585, `DamageModifier` = 1.03 WHERE `entry` = 20165;
UPDATE `creature_template` SET `mindmg` = 296, `maxdmg` = 392, `DamageModifier` = 1.03 WHERE `entry` = 20465;
UPDATE `creature_template` SET `mindmg` = 442, `maxdmg` = 597, `DamageModifier` = 1.03 WHERE `entry` = 21943;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 923, `maxdmg` = 1292, `DamageModifier` = 1.01 WHERE `entry` = 17770;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1096, `maxdmg` = 1553, `DamageModifier` = 1.01 WHERE `entry` = 20169;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 738, `maxdmg` = 1034, `DamageModifier` = 1.01 WHERE `entry` = 18105;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1096, `maxdmg` = 1553, `DamageModifier` = 1.01 WHERE `entry` = 20168;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 770, `maxdmg` = 1078, `minrangedmg` = 703, `maxrangedmg` = 1045, `DamageModifier` = 1.01 WHERE `entry` = 17826;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1016, `maxdmg` = 1439, `minrangedmg` = 1276, `maxrangedmg` = 1897, `DamageModifier` = 1.01 WHERE `entry` = 20183;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 856, `maxdmg` = 1198, `DamageModifier` = 1.01 WHERE `entry` = 17882;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1016, `maxdmg` = 1439, `DamageModifier` = 1.01 WHERE `entry` = 20184;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
