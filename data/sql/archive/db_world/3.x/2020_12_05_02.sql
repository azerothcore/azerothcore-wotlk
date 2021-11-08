-- DB update 2020_12_05_01 -> 2020_12_05_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_05_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_05_01 2020_12_05_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601827337526865700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827337526865700');
/*
 * Raid: The Obsidian Sanctum
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */
UPDATE `creature_template` SET `mindmg` = 3293, `maxdmg` = 4560, `DamageModifier` = 1.03 WHERE `entry` = 30682;
UPDATE `creature_template` SET `mindmg` = 6586, `maxdmg` = 9120, `DamageModifier` = 1.03 WHERE `entry` = 31000;
UPDATE `creature_template` SET `mindmg` = 3254, `maxdmg` = 4522, `DamageModifier` = 1.03 WHERE `entry` = 30681;
UPDATE `creature_template` SET `mindmg` = 6508, `maxdmg` = 9044, `DamageModifier` = 1.03 WHERE `entry` = 30998;
UPDATE `creature_template` SET `mindmg` = 3293, `maxdmg` = 4790, `DamageModifier` = 1.03 WHERE `entry` = 30680;
UPDATE `creature_template` SET `mindmg` = 6586, `maxdmg` = 9580, `DamageModifier` = 1.03 WHERE `entry` = 30999;
UPDATE `creature_template` SET `mindmg` = 3287, `maxdmg` = 4670, `DamageModifier` = 1.03 WHERE `entry` = 30453;
UPDATE `creature_template` SET `mindmg` = 6574, `maxdmg` = 9340, `DamageModifier` = 1.03 WHERE `entry` = 31001;

/* BOSS */ 
UPDATE `creature_template` SET `mindmg` = 17815, `maxdmg` = 23905, `DamageModifier` = 1.01 WHERE `entry` = 28860;
UPDATE `creature_template` SET `mindmg` = 35630, `maxdmg` = 47810, `DamageModifier` = 1.01 WHERE `entry` = 31311;
/* MINI BOSS */ 
UPDATE `creature_template` SET `mindmg` = 13743, `maxdmg` = 18441, `DamageModifier` = 1.01 WHERE `entry` = 30449;
UPDATE `creature_template` SET `mindmg` = 27486, `maxdmg` = 36882, `DamageModifier` = 1.01 WHERE `entry` = 31535;
UPDATE `creature_template` SET `mindmg` = 13743, `maxdmg` = 18441, `DamageModifier` = 1.01 WHERE `entry` = 30451;
UPDATE `creature_template` SET `mindmg` = 27486, `maxdmg` = 36882, `DamageModifier` = 1.01 WHERE `entry` = 31520;
UPDATE `creature_template` SET `mindmg` = 13743, `maxdmg` = 18441, `DamageModifier` = 1.01 WHERE `entry` = 30452;
UPDATE `creature_template` SET `mindmg` = 27486, `maxdmg` = 36882, `DamageModifier` = 1.01 WHERE `entry` = 31534;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
