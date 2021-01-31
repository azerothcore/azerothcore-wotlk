-- DB update 2020_12_05_02 -> 2020_12_06_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_05_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_05_02 2020_12_06_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601827252211534700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827252211534700');
/*
 * Raid: The Eye of Eternity 
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 4137, `maxdmg` = 6356, `DamageModifier` = 1.03 WHERE `entry` = 30245;
UPDATE `creature_template` SET `mindmg` = 8274, `maxdmg` = 12712, `DamageModifier` = 1.03 WHERE `entry` = 31750;
UPDATE `creature_template` SET `mindmg` = 3514, `maxdmg` = 5614, `DamageModifier` = 1.03 WHERE `entry` = 30249;
UPDATE `creature_template` SET `mindmg` = 7028, `maxdmg` = 11228, `DamageModifier` = 1.03 WHERE `entry` = 31751;

/* BOSS */ 
UPDATE `creature_template` SET `mindmg` = 18815, `maxdmg` = 24905, `DamageModifier` = 1.01 WHERE `entry` = 28859;
UPDATE `creature_template` SET `mindmg` = 37630, `maxdmg` = 49810, `DamageModifier` = 1.01 WHERE `entry` = 31734;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
