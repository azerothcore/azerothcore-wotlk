-- DB update 2020_09_29_00 -> 2020_09_30_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_09_29_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_09_29_00 2020_09_30_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1598878239120359200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598878239120359200');
/*
 * Dungeon: Dire Maul (West)
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 489, `maxdmg` = 673, `DamageModifier` = 1.03 WHERE `entry` = 11459;
UPDATE `creature_template` SET `mindmg` = 415, `maxdmg` = 625, `DamageModifier` = 1.03 WHERE `entry` = 14303;
UPDATE `creature_template` SET `mindmg` = 421, `maxdmg` = 637, `DamageModifier` = 1.03 WHERE `entry` = 11458;
UPDATE `creature_template` SET `mindmg` = 456, `maxdmg` = 629, `DamageModifier` = 1.03 WHERE `entry` = 11483;
UPDATE `creature_template` SET `mindmg` = 475, `maxdmg` = 641, `DamageModifier` = 1.03 WHERE `entry` = 11480;
UPDATE `creature_template` SET `mindmg` = 464, `maxdmg` = 629, `DamageModifier` = 1.03 WHERE `entry` = 11473;
UPDATE `creature_template` SET `mindmg` = 452, `maxdmg` = 619, `DamageModifier` = 1.03 WHERE `entry` = 11470;
UPDATE `creature_template` SET `mindmg` = 498, `maxdmg` = 559, `DamageModifier` = 1.03 WHERE `entry` = 11469;
UPDATE `creature_template` SET `mindmg` = 472, `maxdmg` = 612, `DamageModifier` = 1.03 WHERE `entry` = 11477;
UPDATE `creature_template` SET `mindmg` = 464, `maxdmg` = 629, `DamageModifier` = 1.03 WHERE `entry` = 14398;
UPDATE `creature_template` SET `mindmg` = 432, `maxdmg` = 605, `DamageModifier` = 1.03 WHERE `entry` = 11476;
UPDATE `creature_template` SET `mindmg` = 472, `maxdmg` = 647, `DamageModifier` = 1.03 WHERE `entry` = 11472;
UPDATE `creature_template` SET `mindmg` = 456, `maxdmg` = 615, `DamageModifier` = 1.03 WHERE `entry` = 11471;
UPDATE `creature_template` SET `mindmg` = 498, `maxdmg` = 663, `DamageModifier` = 1.03 WHERE `entry` = 11475;
UPDATE `creature_template` SET `mindmg` = 775, `maxdmg` = 1027, `DamageModifier` = 1.03 WHERE `entry` = 14308;
UPDATE `creature_template` SET `mindmg` = 410, `maxdmg` = 553, `DamageModifier` = 1.03 WHERE `entry` = 11484;
UPDATE `creature_template` SET `mindmg` = 337, `maxdmg` = 455, `DamageModifier` = 1.03 WHERE `entry` = 14397;
UPDATE `creature_template` SET `mindmg` = 412, `maxdmg` = 616, `DamageModifier` = 1.03 WHERE `entry` = 14399;
UPDATE `creature_template` SET `mindmg` = 305, `maxdmg` = 428, `DamageModifier` = 1.03 WHERE `entry` = 14400;
UPDATE `creature_template` SET `mindmg` = 266, `maxdmg` = 363, `DamageModifier` = 1.03 WHERE `entry` = 11466;

/* RARE */
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 496, `maxdmg` = 692, `DamageModifier` = 1.02 WHERE `entry` = 11467;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 689, `maxdmg` = 771, `DamageModifier` = 1.01 WHERE `entry` = 11489;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 684, `maxdmg` = 741, `DamageModifier` = 1.01 WHERE `entry` = 11487;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 692, `maxdmg` = 757, `DamageModifier` = 1.01 WHERE `entry` = 11488;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 675, `maxdmg` = 714, `DamageModifier` = 1.01 WHERE `entry` = 11496;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 695, `maxdmg` = 723, `DamageModifier` = 1.01 WHERE `entry` = 11486;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 684, `maxdmg` = 776, `DamageModifier` = 1.01 WHERE `entry` = 14506;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
