-- DB update 2020_06_09_00 -> 2020_06_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_09_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_09_00 2020_06_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588338688279133200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588338688279133200');

/*
 * Dungeon: Blood Furnace
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 733, `maxdmg` = 1015, `DamageModifier` = 1.03 WHERE `entry` = 17370;
UPDATE `creature_template` SET `mindmg` = 1488, `maxdmg` = 2103, `DamageModifier` = 1.03 WHERE `entry` = 18608;
UPDATE `creature_template` SET `mindmg` = 697, `maxdmg` = 965, `DamageModifier` = 1.03 WHERE `entry` = 17397;
UPDATE `creature_template` SET `mindmg` = 1322, `maxdmg` = 1953, `DamageModifier` = 1.03 WHERE `entry` = 18615;
UPDATE `creature_template` SET `mindmg` = 697, `maxdmg` = 965, `DamageModifier` = 1.03 WHERE `entry` = 17477;
UPDATE `creature_template` SET `mindmg` = 1322, `maxdmg` = 1953, `DamageModifier` = 1.03 WHERE `entry` = 18606;
UPDATE `creature_template` SET `mindmg` = 587, `maxdmg` = 812, `DamageModifier` = 1.03 WHERE `entry` = 17491;
UPDATE `creature_template` SET `mindmg` = 910, `maxdmg` = 1371, `DamageModifier` = 1.03 WHERE `entry` = 18610;
UPDATE `creature_template` SET `mindmg` = 568, `maxdmg` = 814, `DamageModifier` = 1.03 WHERE `entry` = 17371;
UPDATE `creature_template` SET `mindmg` = 757, `maxdmg` = 1098, `DamageModifier` = 1.03 WHERE `entry` = 18619;
UPDATE `creature_template` SET `mindmg` = 733, `maxdmg` = 1015, `DamageModifier` = 1.03 WHERE `entry` = 17626;
UPDATE `creature_template` SET `mindmg` = 970, `maxdmg` = 1371, `DamageModifier` = 1.03 WHERE `entry` = 18609;
UPDATE `creature_template` SET `mindmg` = 568, `maxdmg` = 814, `DamageModifier` = 1.03 WHERE `entry` = 17395;
UPDATE `creature_template` SET `mindmg` = 718, `maxdmg` = 1087, `DamageModifier` = 1.03 WHERE `entry` = 18617;
UPDATE `creature_template` SET `mindmg` = 780, `maxdmg` = 1084, `DamageModifier` = 1.03 WHERE `entry` = 17624;
UPDATE `creature_template` SET `mindmg` = 1020, `maxdmg` = 1444, `DamageModifier` = 1.03 WHERE `entry` = 18611;
UPDATE `creature_template` SET `mindmg` = 568, `maxdmg` = 867, `DamageModifier` = 1.03 WHERE `entry` = 17414;
UPDATE `creature_template` SET `mindmg` = 757, `maxdmg` = 1098, `DamageModifier` = 1.03 WHERE `entry` = 18618;
UPDATE `creature_template` SET `mindmg` = 587, `maxdmg` = 867, `DamageModifier` = 1.03 WHERE `entry` = 17398;
UPDATE `creature_template` SET `mindmg` = 1019, `maxdmg` = 1443, `DamageModifier` = 1.03 WHERE `entry` = 18612;
UPDATE `creature_template` SET `mindmg` = 733, `maxdmg` = 1015, `DamageModifier` = 1.03 WHERE `entry` = 18894;
UPDATE `creature_template` SET `mindmg` = 930, `maxdmg` = 1371, `DamageModifier` = 1.03 WHERE `entry` = 21645;
UPDATE `creature_template` SET `mindmg` = 350, `maxdmg` = 487, `DamageModifier` = 1.03 WHERE `entry` = 17653;
UPDATE `creature_template` SET `mindmg` = 520, `maxdmg` = 722, `DamageModifier` = 1.03 WHERE `entry` = 18620;
UPDATE `creature_template` SET `mindmg` = 697, `maxdmg` = 965, `DamageModifier` = 1.03 WHERE `entry` = 17399;
UPDATE `creature_template` SET `mindmg` = 936, `maxdmg` = 1325, `DamageModifier` = 1.03 WHERE `entry` = 18614;
UPDATE `creature_template` SET `mindmg` = 142, `maxdmg` = 210, `DamageModifier` = 1.03 WHERE `entry` = 17401;
UPDATE `creature_template` SET `mindmg` = 153, `maxdmg` = 216, `DamageModifier` = 1.03 WHERE `entry` = 18605;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 975, `maxdmg` = 1355, `DamageModifier` = 1.01 WHERE `entry` = 17381;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1060, `maxdmg` = 1503, `DamageModifier` = 1.01 WHERE `entry` = 18621;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 636, `maxdmg` = 914, `DamageModifier` = 1.01 WHERE `entry` = 17380;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1246, `maxdmg` = 1810, `DamageModifier` = 1.01 WHERE `entry` = 18601;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 636, `maxdmg` = 914, `DamageModifier` = 1.01 WHERE `entry` = 17377;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 830, `maxdmg` = 1206, `DamageModifier` = 1.01 WHERE `entry` = 18607;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
