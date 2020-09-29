-- DB update 2020_09_28_00 -> 2020_09_29_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_09_28_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_09_28_00 2020_09_29_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1598878568943578500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598878568943578500');
/*
 * Dungeon: Upper Blackrock
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 348, `maxdmg` = 471, `DamageModifier` = 1.03 WHERE `entry` = 9096;
UPDATE `creature_template` SET `mindmg` = 355, `maxdmg` = 479, `DamageModifier` = 1.03 WHERE `entry` = 9819;
UPDATE `creature_template` SET `mindmg` = 332, `maxdmg` = 449, `DamageModifier` = 1.03 WHERE `entry` = 9817;
UPDATE `creature_template` SET `mindmg` = 318, `maxdmg` = 441, `DamageModifier` = 1.03 WHERE `entry` = 9818;
UPDATE `creature_template` SET `mindmg` = 355, `maxdmg` = 479, `DamageModifier` = 1.03 WHERE `entry` = 10316;
UPDATE `creature_template` SET `mindmg` = 96, `maxdmg` = 132, `DamageModifier` = 1.03 WHERE `entry` = 10161;
UPDATE `creature_template` SET `mindmg` = 335, `maxdmg` = 438, `DamageModifier` = 1.03 WHERE `entry` = 10083;
UPDATE `creature_template` SET `mindmg` = 416, `maxdmg` = 512, `DamageModifier` = 1.03 WHERE `entry` = 10317;
UPDATE `creature_template` SET `mindmg` = 267, `maxdmg` = 361, `DamageModifier` = 1.03 WHERE `entry` = 10447;
UPDATE `creature_template` SET `mindmg` = 355, `maxdmg` = 479, `DamageModifier` = 1.03 WHERE `entry` = 10742;
UPDATE `creature_template` SET `mindmg` = 239, `maxdmg` = 323, `DamageModifier` = 1.03 WHERE `entry` = 10442;
UPDATE `creature_template` SET `mindmg` = 489, `maxdmg` = 497, `DamageModifier` = 1.03 WHERE `entry` = 10319;
UPDATE `creature_template` SET `mindmg` = 375, `maxdmg` = 497, `DamageModifier` = 1.03 WHERE `entry` = 10366;
UPDATE `creature_template` SET `mindmg` = 386, `maxdmg` = 492, `DamageModifier` = 1.03 WHERE `entry` = 10371;
UPDATE `creature_template` SET `mindmg` = 362, `maxdmg` = 489, `DamageModifier` = 1.03 WHERE `entry` = 10318;
UPDATE `creature_template` SET `mindmg` = 347, `maxdmg` = 475, `DamageModifier` = 1.03 WHERE `entry` = 10372;
UPDATE `creature_template` SET `mindmg` = 311, `maxdmg` = 405, `DamageModifier` = 1.03 WHERE `entry` = 9045;
UPDATE `creature_template` SET `mindmg` = 362, `maxdmg` = 479, `DamageModifier` = 1.03 WHERE `entry` = 10762;
UPDATE `creature_template` SET `mindmg` = 412, `maxdmg` = 523, `DamageModifier` = 1.03 WHERE `entry` = 10814;

/* RARE */
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 496, `maxdmg` = 642, `DamageModifier` = 1.02 WHERE `entry` = 10899;
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 484, `maxdmg` = 611, `DamageModifier` = 1.02 WHERE `entry` = 10509;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 579, `maxdmg` = 685, `DamageModifier` = 1.01 WHERE `entry` = 9816;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 524, `maxdmg` = 652, `DamageModifier` = 1.01 WHERE `entry` = 10264;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 563, `maxdmg` = 679, `DamageModifier` = 1.01 WHERE `entry` = 10429;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 597, `maxdmg` = 682, `DamageModifier` = 1.01 WHERE `entry` = 10430;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 485, `maxdmg` = 597, `DamageModifier` = 1.01 WHERE `entry` = 10339;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 515, `maxdmg` = 697, `DamageModifier` = 1.01 WHERE `entry` = 103363;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
