-- DB update 2020_06_10_00 -> 2020_06_11_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_10_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_10_00 2020_06_11_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588338801814673000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588338801814673000');

/*
 * Dungeon: Shattered Halls
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 1056, `maxdmg` = 1493, `DamageModifier` = 1.03 WHERE `entry` = 16699;
UPDATE `creature_template` SET `mindmg` = 1112, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 20590;
UPDATE `creature_template` SET `mindmg` = 1001, `maxdmg` = 1413, `DamageModifier` = 1.03 WHERE `entry` = 17420;
UPDATE `creature_template` SET `mindmg` = 1056, `maxdmg` = 1493, `DamageModifier` = 1.03 WHERE `entry` = 20587;
UPDATE `creature_template` SET `mindmg` = 1056, `maxdmg` = 1493, `DamageModifier` = 1.03 WHERE `entry` = 16700;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 20589;
UPDATE `creature_template` SET `mindmg` = 1056, `maxdmg` = 1493, `DamageModifier` = 1.03 WHERE `entry` = 16507;
UPDATE `creature_template` SET `mindmg` = 1112, `maxdmg` = 1570, `DamageModifier` = 1.03 WHERE `entry` = 20593;
UPDATE `creature_template` SET `mindmg` = 1056, `maxdmg` = 1493, `DamageModifier` = 1.03 WHERE `entry` = 16593;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 20582;
UPDATE `creature_template` SET `mindmg` = 1056, `maxdmg` = 1493, `DamageModifier` = 1.03 WHERE `entry` = 17083;
UPDATE `creature_template` SET `mindmg` = 1112, `maxdmg` = 1570, `DamageModifier` = 1.03 WHERE `entry` = 20567;
UPDATE `creature_template` SET `mindmg` = 816, `maxdmg` = 1184, `DamageModifier` = 1.03 WHERE `entry` = 17694;
UPDATE `creature_template` SET `mindmg` = 826, `maxdmg` = 1300, `DamageModifier` = 1.03 WHERE `entry` = 20577;
UPDATE `creature_template` SET `mindmg` = 816, `maxdmg` = 1184, `DamageModifier` = 1.03 WHERE `entry` = 16594;
UPDATE `creature_template` SET `mindmg` = 826, `maxdmg` = 1300, `DamageModifier` = 1.03 WHERE `entry` = 20576;
UPDATE `creature_template` SET `mindmg` = 1056, `maxdmg` = 1493, `minrangedmg` = 787, `maxrangedmg` = 1224, `DamageModifier` = 1.03 WHERE `entry` = 16704;
UPDATE `creature_template` SET `mindmg` = 1112, `maxdmg` = 1640, `minrangedmg` = 1057, `maxrangedmg` = 1570, `DamageModifier` = 1.03 WHERE `entry` = 20594;
UPDATE `creature_template` SET `mindmg` = 1056, `maxdmg` = 1493, `DamageModifier` = 1.03 WHERE `entry` = 17670;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 20588;
UPDATE `creature_template` SET `mindmg` = 778, `maxdmg` = 1099, `minrangedmg` = 944, `maxrangedmg` = 1402, `DamageModifier` = 1.03 WHERE `entry` = 17622;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1472, `minrangedmg` = 1268, `maxrangedmg` = 1884, `DamageModifier` = 1.03 WHERE `entry` = 20578;
UPDATE `creature_template` SET `mindmg` = 763, `maxdmg` = 1073, `DamageModifier` = 1.03 WHERE `entry` = 17669;
UPDATE `creature_template` SET `mindmg` = 1035, `maxdmg` = 1463, `DamageModifier` = 1.03 WHERE `entry` = 20574;
UPDATE `creature_template` SET `mindmg` = 1813, `maxdmg` = 2559, `DamageModifier` = 1.03 WHERE `entry` = 17356;
UPDATE `creature_template` SET `mindmg` = 2327, `maxdmg` = 3290, `DamageModifier` = 1.03 WHERE `entry` = 20565;
UPDATE `creature_template` SET `mindmg` = 179, `maxdmg` = 253, `DamageModifier` = 1.03 WHERE `entry` = 17357;
UPDATE `creature_template` SET `mindmg` = 242, `maxdmg` = 341, `DamageModifier` = 1.03 WHERE `entry` = 20566;
UPDATE `creature_template` SET `mindmg` = 823, `maxdmg` = 1164, `DamageModifier` = 1.03 WHERE `entry` = 17695;
UPDATE `creature_template` SET `mindmg` = 1099, `maxdmg` = 1556, `DamageModifier` = 1.03 WHERE `entry` = 20580;
UPDATE `creature_template` SET `mindmg` = 789, `maxdmg` = 1115, `minrangedmg` = 787, `maxrangedmg` = 1169, `DamageModifier` = 1.03 WHERE `entry` = 17427;
UPDATE `creature_template` SET `mindmg` = 1056, `maxdmg` = 1493, `minrangedmg` = 1057, `maxrangedmg` = 1570, `DamageModifier` = 1.03 WHERE `entry` = 20579;
UPDATE `creature_template` SET `mindmg` = 857, `maxdmg` = 1213, `DamageModifier` = 1.03 WHERE `entry` = 17461;
UPDATE `creature_template` SET `mindmg` = 1099, `maxdmg` = 1556, `DamageModifier` = 1.03 WHERE `entry` = 20581;
UPDATE `creature_template` SET `mindmg` = 857, `maxdmg` = 1213, `DamageModifier` = 1.03 WHERE `entry` = 17465;
UPDATE `creature_template` SET `mindmg` = 1099, `maxdmg` = 1556, `DamageModifier` = 1.03 WHERE `entry` = 20583;
UPDATE `creature_template` SET `mindmg` = 823, `maxdmg` = 1164, `DamageModifier` = 1.03 WHERE `entry` = 17464;
UPDATE `creature_template` SET `mindmg` = 1056, `maxdmg` = 1493, `DamageModifier` = 1.03 WHERE `entry` = 20586;
UPDATE `creature_template` SET `mindmg` = 857, `maxdmg` = 1213, `DamageModifier` = 1.03 WHERE `entry` = 17671;
UPDATE `creature_template` SET `mindmg` = 1099, `maxdmg` = 1556, `DamageModifier` = 1.03 WHERE `entry` = 20584;
UPDATE `creature_template` SET `mindmg` = 169, `maxdmg` = 239, `DamageModifier` = 1.03 WHERE `entry` = 17623;
UPDATE `creature_template` SET `mindmg` = 176, `maxdmg` = 250, `DamageModifier` = 1.03 WHERE `entry` = 20575;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1081, `maxdmg` = 1531, `DamageModifier` = 1.01 WHERE `entry` = 16807;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1120, `maxdmg` = 1584, `DamageModifier` = 1.01 WHERE `entry` = 20568;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 918, `maxdmg` = 1302, `DamageModifier` = 1.01 WHERE `entry` = 16809;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1178, `maxdmg` = 1670, `DamageModifier` = 1.01 WHERE `entry` = 20596;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1129, `maxdmg` = 1601, `DamageModifier` = 1.01 WHERE `entry` = 16808;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1178, `maxdmg` = 1670, `DamageModifier` = 1.01 WHERE `entry` = 20597;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1254, `maxdmg` = 1778, `DamageModifier` = 1.01 WHERE `entry` = 20923;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1609, `maxdmg` = 2281, `DamageModifier` = 1.01 WHERE `entry` = 20993;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
