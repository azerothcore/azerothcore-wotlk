-- DB update 2020_06_27_00 -> 2020_06_27_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_27_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_27_00 2020_06_27_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1589122636951229900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1589122636951229900');
/*
 * Shadow Labyrinth
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 1112, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 18635;
UPDATE `creature_template` SET `mindmg` = 1116, `maxdmg` = 1643, `DamageModifier` = 1.03 WHERE `entry` = 20641;
UPDATE `creature_template` SET `mindmg` = 1031, `maxdmg` = 1453, `DamageModifier` = 1.03 WHERE `entry` = 18633;
UPDATE `creature_template` SET `mindmg` = 1037, `maxdmg` = 1465, `DamageModifier` = 1.03 WHERE `entry` = 20638;
UPDATE `creature_template` SET `mindmg` = 1031, `maxdmg` = 1453, `DamageModifier` = 1.03 WHERE `entry` = 18640;
UPDATE `creature_template` SET `mindmg` = 1037, `maxdmg` = 1465, `DamageModifier` = 1.03 WHERE `entry` = 20649;
UPDATE `creature_template` SET `mindmg` = 1031, `maxdmg` = 1453, `DamageModifier` = 1.03 WHERE `entry` = 18642;
UPDATE `creature_template` SET `mindmg` = 1037, `maxdmg` = 1465, `DamageModifier` = 1.03 WHERE `entry` = 20651;
UPDATE `creature_template` SET `mindmg` = 687, `maxdmg` = 995, `DamageModifier` = 1.03 WHERE `entry` = 18641;
UPDATE `creature_template` SET `mindmg` = 862, `maxdmg` = 1250, `DamageModifier` = 1.03 WHERE `entry` = 20643;
UPDATE `creature_template` SET `mindmg` = 1031, `maxdmg` = 1453, `DamageModifier` = 1.03 WHERE `entry` = 18794;
UPDATE `creature_template` SET `mindmg` = 1037, `maxdmg` = 1524, `DamageModifier` = 1.03 WHERE `entry` = 20645;
UPDATE `creature_template` SET `mindmg` = 1116, `maxdmg` = 1577, `DamageModifier` = 1.03 WHERE `entry` = 18796;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 20652;
UPDATE `creature_template` SET `mindmg` = 1031, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 18637;
UPDATE `creature_template` SET `mindmg` = 1037, `maxdmg` = 1524, `DamageModifier` = 1.03 WHERE `entry` = 20646;
UPDATE `creature_template` SET `mindmg` = 1112, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 18631;
UPDATE `creature_template` SET `mindmg` = 1116, `maxdmg` = 1643, `DamageModifier` = 1.03 WHERE `entry` = 20640;
UPDATE `creature_template` SET `mindmg` = 1037, `maxdmg` = 1524, `DamageModifier` = 1.03 WHERE `entry` = 18848;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1643, `DamageModifier` = 1.03 WHERE `entry` = 20656;
UPDATE `creature_template` SET `mindmg` = 554, `maxdmg` = 833, `DamageModifier` = 1.03 WHERE `entry` = 18797;
UPDATE `creature_template` SET `mindmg` = 894, `maxdmg` = 1286, `DamageModifier` = 1.03 WHERE `entry` = 20662;
UPDATE `creature_template` SET `mindmg` = 1037, `maxdmg` = 1465, `DamageModifier` = 1.03 WHERE `entry` = 18638;
UPDATE `creature_template` SET `mindmg` = 1186, `maxdmg` = 1675, `DamageModifier` = 1.03 WHERE `entry` = 20650;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 18830;
UPDATE `creature_template` SET `mindmg` = 1116, `maxdmg` = 1643, `DamageModifier` = 1.03 WHERE `entry` = 20644;
UPDATE `creature_template` SET `mindmg` = 773, `maxdmg` = 1090, `DamageModifier` = 1.03 WHERE `entry` = 19208;
UPDATE `creature_template` SET `mindmg` = 1037, `maxdmg` = 1316, `DamageModifier` = 1.03 WHERE `entry` = 20660;
UPDATE `creature_template` SET `mindmg` = 1161, `maxdmg` = 1643, `DamageModifier` = 1.03 WHERE `entry` = 18632;
UPDATE `creature_template` SET `mindmg` = 1448, `maxdmg` = 2050, `DamageModifier` = 1.03 WHERE `entry` = 20642;
UPDATE `creature_template` SET `mindmg` = 1037, `maxdmg` = 1524, `DamageModifier` = 1.03 WHERE `entry` = 18639;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1584, `DamageModifier` = 1.03 WHERE `entry` = 20647;
UPDATE `creature_template` SET `mindmg` = 1037, `maxdmg` = 1465, `DamageModifier` = 1.03 WHERE `entry` = 18634;
UPDATE `creature_template` SET `mindmg` = 1076, `maxdmg` = 1532, `DamageModifier` = 1.03 WHERE `entry` = 20648;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1207, `maxdmg` = 1711, `DamageModifier` = 1.01 WHERE `entry` = 18731;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1882, `maxdmg` = 2668, `DamageModifier` = 1.01 WHERE `entry` = 20636;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1207, `maxdmg` = 1711, `DamageModifier` = 1.01 WHERE `entry` = 18667;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1693, `maxdmg` = 2401, `DamageModifier` = 1.01 WHERE `entry` = 20637;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1119, `maxdmg` = 1585, `DamageModifier` = 1.01 WHERE `entry` = 18732;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1214, `maxdmg` = 1647, `DamageModifier` = 1.01 WHERE `entry` = 20653;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1207, `maxdmg` = 1711, `DamageModifier` = 1.01 WHERE `entry` = 18708;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1756, `maxdmg` = 2490, `DamageModifier` = 1.01 WHERE `entry` = 20657;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
