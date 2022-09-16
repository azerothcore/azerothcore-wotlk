-- DB update 2020_06_28_00 -> 2020_06_29_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_28_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_28_00 2020_06_29_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1589122762458729700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1589122762458729700');
/*
 * Dungeon: Slave Pens
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 780, `maxdmg` = 1084, `DamageModifier` = 1.03 WHERE `entry` = 17816;
UPDATE `creature_template` SET `mindmg` = 980, `maxdmg` = 1386, `DamageModifier` = 1.03 WHERE `entry` = 19884;
UPDATE `creature_template` SET `mindmg` = 780, `maxdmg` = 1084, `DamageModifier` = 1.03 WHERE `entry` = 17817;
UPDATE `creature_template` SET `mindmg` = 980, `maxdmg` = 1386, `DamageModifier` = 1.03 WHERE `entry` = 19892;
UPDATE `creature_template` SET `mindmg` = 468, `maxdmg` = 692, `DamageModifier` = 1.03 WHERE `entry` = 17964;
UPDATE `creature_template` SET `mindmg` = 1031, `maxdmg` = 1459, `DamageModifier` = 1.03 WHERE `entry` = 19904;
UPDATE `creature_template` SET `mindmg` = 780, `maxdmg` = 1154, `DamageModifier` = 1.03 WHERE `entry` = 17959;
UPDATE `creature_template` SET `mindmg` = 1031, `maxdmg` = 1459, `DamageModifier` = 1.03 WHERE `entry` = 19889;
UPDATE `creature_template` SET `mindmg` = 828, `maxdmg` = 1154, `DamageModifier` = 1.03 WHERE `entry` = 17957;
UPDATE `creature_template` SET `mindmg` = 1031, `maxdmg` = 1460, `DamageModifier` = 1.03 WHERE `entry` = 19885;
UPDATE `creature_template` SET `mindmg` = 736, `maxdmg` = 1024, `DamageModifier` = 1.03 WHERE `entry` = 17938;
UPDATE `creature_template` SET `mindmg` = 911, `maxdmg` = 1287, `DamageModifier` = 1.03 WHERE `entry` = 19888;
UPDATE `creature_template` SET `mindmg` = 736, `maxdmg` = 1024, `DamageModifier` = 1.03 WHERE `entry` = 21126;
UPDATE `creature_template` SET `mindmg` = 921, `maxdmg` = 1301, `DamageModifier` = 1.03 WHERE `entry` = 21842;
UPDATE `creature_template` SET `mindmg` = 875, `maxdmg` = 1222, `DamageModifier` = 1.03 WHERE `entry` = 21128;
UPDATE `creature_template` SET `mindmg` = 1002, `maxdmg` = 1416, `DamageModifier` = 1.03 WHERE `entry` = 21841;
UPDATE `creature_template` SET `mindmg` = 736, `maxdmg` = 1024, `DamageModifier` = 1.03 WHERE `entry` = 17961;
UPDATE `creature_template` SET `mindmg` = 911, `maxdmg` = 1287, `DamageModifier` = 1.03 WHERE `entry` = 19887;
UPDATE `creature_template` SET `mindmg` = 603, `maxdmg` = 867, `DamageModifier` = 1.03 WHERE `entry` = 17960;
UPDATE `creature_template` SET `mindmg` = 759, `maxdmg` = 1099, `DamageModifier` = 1.03 WHERE `entry` = 19890;
UPDATE `creature_template` SET `mindmg` = 828, `maxdmg` = 1154, `DamageModifier` = 1.03 WHERE `entry` = 17958;
UPDATE `creature_template` SET `mindmg` = 1031, `maxdmg` = 1460, `DamageModifier` = 1.03 WHERE `entry` = 19886;
UPDATE `creature_template` SET `mindmg` = 774, `maxdmg` = 1078, `DamageModifier` = 1.03 WHERE `entry` = 17940;
UPDATE `creature_template` SET `mindmg` = 957, `maxdmg` = 1354, `DamageModifier` = 1.03 WHERE `entry` = 19891;
UPDATE `creature_template` SET `mindmg` = 440, `maxdmg` = 650, `DamageModifier` = 1.03 WHERE `entry` = 17962;
UPDATE `creature_template` SET `mindmg` = 980, `maxdmg` = 1386, `DamageModifier` = 1.03 WHERE `entry` = 19903;
UPDATE `creature_template` SET `mindmg` = 828, `maxdmg` = 1154, `DamageModifier` = 1.03 WHERE `entry` = 21127;
UPDATE `creature_template` SET `mindmg` = 991, `maxdmg` = 1402, `DamageModifier` = 1.03 WHERE `entry` = 21843;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 464, `maxdmg` = 647, `DamageModifier` = 1.01 WHERE `entry` = 17941;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1005, `maxdmg` = 1423, `DamageModifier` = 1.01 WHERE `entry` = 19893;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 875, `maxdmg` = 1222, `DamageModifier` = 1.01 WHERE `entry` = 17991;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1084, `maxdmg` = 1536, `DamageModifier` = 1.01 WHERE `entry` = 19895;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1084, `maxdmg` = 1536, `DamageModifier` = 1.01 WHERE `entry` = 17942;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1312, `maxdmg` = 1834, `DamageModifier` = 1.01 WHERE `entry` = 19894;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
