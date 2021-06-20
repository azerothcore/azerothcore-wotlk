-- DB update 2020_07_24_00 -> 2020_07_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_07_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_07_24_00 2020_07_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1590935541802471000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590935541802471000');
/*
 * Dungeon: The Mechanar
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1534, `DamageModifier` = 1.03 WHERE `entry` = 19510;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 21522;
UPDATE `creature_template` SET `mindmg` = 968, `maxdmg` = 1367, `DamageModifier` = 1.03 WHERE `entry` = 20990;
UPDATE `creature_template` SET `mindmg` = 1031, `maxdmg` = 1453, `DamageModifier` = 1.03 WHERE `entry` = 21523;
UPDATE `creature_template` SET `mindmg` = 804, `maxdmg` = 1167, `DamageModifier` = 1.03 WHERE `entry` = 20059;
UPDATE `creature_template` SET `mindmg` = 896, `maxdmg` = 1300, `DamageModifier` = 1.03 WHERE `entry` = 21541;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1472, `DamageModifier` = 1.03 WHERE `entry` = 19167;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 21524;
UPDATE `creature_template` SET `mindmg` = 1083, `maxdmg` = 1534, `DamageModifier` = 1.03 WHERE `entry` = 19166;
UPDATE `creature_template` SET `mindmg` = 1206, `maxdmg` = 1708, `DamageModifier` = 1.03 WHERE `entry` = 21543;
UPDATE `creature_template` SET `mindmg` = 968, `maxdmg` = 1367, `DamageModifier` = 1.03 WHERE `entry` = 20988;
UPDATE `creature_template` SET `mindmg` = 1031, `maxdmg` = 1453, `DamageModifier` = 1.03 WHERE `entry` = 21540;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1472, `DamageModifier` = 1.03 WHERE `entry` = 19716;
UPDATE `creature_template` SET `mindmg` = 1112, `maxdmg` = 1332, `DamageModifier` = 1.03 WHERE `entry` = 21531;
UPDATE `creature_template` SET `mindmg` = 1083, `maxdmg` = 1534, `DamageModifier` = 1.03 WHERE `entry` = 19231;
UPDATE `creature_template` SET `mindmg` = 1276, `maxdmg` = 1804, `DamageModifier` = 1.03 WHERE `entry` = 21527;
UPDATE `creature_template` SET `mindmg` = 1083, `maxdmg` = 1534, `DamageModifier` = 1.03 WHERE `entry` = 19712;
UPDATE `creature_template` SET `mindmg` = 1276, `maxdmg` = 1804, `DamageModifier` = 1.03 WHERE `entry` = 21528;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1472, `DamageModifier` = 1.03 WHERE `entry` = 19713;
UPDATE `creature_template` SET `mindmg` = 1276, `maxdmg` = 1804, `DamageModifier` = 1.03 WHERE `entry` = 21532;
UPDATE `creature_template` SET `mindmg` = 1083, `maxdmg` = 1534, `DamageModifier` = 1.03 WHERE `entry` = 19735;
UPDATE `creature_template` SET `mindmg` = 1206, `maxdmg` = 1708, `DamageModifier` = 1.03 WHERE `entry` = 21542;
UPDATE `creature_template` SET `mindmg` = 968, `maxdmg` = 1367, `DamageModifier` = 1.03 WHERE `entry` = 19168;
UPDATE `creature_template` SET `mindmg` = 1031, `maxdmg` = 1453, `DamageModifier` = 1.03 WHERE `entry` = 21539;
UPDATE `creature_template` SET `mindmg` = 2045, `maxdmg` = 2900, `DamageModifier` = 1.03 WHERE `entry` = 20481;
UPDATE `creature_template` SET `mindmg` = 2481, `maxdmg` = 3518, `DamageModifier` = 1.03 WHERE `entry` = 21538;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1254, `maxdmg` = 1778, `DamageModifier` = 1.01 WHERE `entry` = 19710;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1609, `maxdmg` = 2281, `DamageModifier` = 1.01 WHERE `entry` = 21526;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1126, `maxdmg` = 1597, `DamageModifier` = 1.01 WHERE `entry` = 19219;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1254, `maxdmg` = 1778, `DamageModifier` = 1.01 WHERE `entry` = 21533;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1232, `maxdmg` = 1678, `DamageModifier` = 1.01 WHERE `entry` = 19218;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1589, `maxdmg` = 2154, `DamageModifier` = 1.01 WHERE `entry` = 21525;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1044, `maxdmg` = 1479, `DamageModifier` = 1.01 WHERE `entry` = 19221;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1163, `maxdmg` = 1647, `DamageModifier` = 1.01 WHERE `entry` = 21536;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1043, `maxdmg` = 1257, `DamageModifier` = 1.01 WHERE `entry` = 19220;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1194, `maxdmg` = 1679, `DamageModifier` = 1.01 WHERE `entry` = 21537;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
