-- DB update 2020_09_23_00 -> 2020_09_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_09_23_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_09_23_00 2020_09_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1598878347481363100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598878347481363100');
/*
 * Dungeon: Dire Maul (North)
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 487, `maxdmg` = 588, `DamageModifier` = 1.03 WHERE `entry` = 11441;
UPDATE `creature_template` SET `mindmg` = 453, `maxdmg` = 569, `DamageModifier` = 1.03 WHERE `entry` = 11444;
UPDATE `creature_template` SET `mindmg` = 354, `maxdmg` = 479, `DamageModifier` = 1.03 WHERE `entry` = 13160;
UPDATE `creature_template` SET `mindmg` = 357, `maxdmg` = 491, `DamageModifier` = 1.03 WHERE `entry` = 13036;
UPDATE `creature_template` SET `mindmg` = 492, `maxdmg` = 595, `DamageModifier` = 1.03 WHERE `entry` = 11450;
UPDATE `creature_template` SET `mindmg` = 412, `maxdmg` = 511, `DamageModifier` = 1.03 WHERE `entry` = 11448;
UPDATE `creature_template` SET `mindmg` = 223, `maxdmg` = 389, `DamageModifier` = 1.03 WHERE `entry` = 11859;
UPDATE `creature_template` SET `mindmg` = 145, `maxdmg` = 212, `DamageModifier` = 1.03 WHERE `entry` = 14386;
UPDATE `creature_template` SET `mindmg` = 475, `maxdmg` = 571, `DamageModifier` = 1.03 WHERE `entry` = 11445;


/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 658, `maxdmg` = 795, `DamageModifier` = 1.01 WHERE `entry` = 14322;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 627, `maxdmg` = 762, `DamageModifier` = 1.01 WHERE `entry` = 14326;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 643, `maxdmg` = 747, `DamageModifier` = 1.01 WHERE `entry` = 14321;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 652, `maxdmg` = 789, `DamageModifier` = 1.01 WHERE `entry` = 14323;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 661, `maxdmg` = 798, `DamageModifier` = 1.01 WHERE `entry` = 14325;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 463, `maxdmg` = 571, `DamageModifier` = 1.01 WHERE `entry` = 14324;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 635, `maxdmg` = 810, `DamageModifier` = 1.01 WHERE `entry` = 11501;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
