-- DB update 2020_12_07_00 -> 2020_12_07_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_07_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_07_00 2020_12_07_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601827407065319600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827407065319600');
/*
 * Raid: Onyxia Lair
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */
UPDATE `creature_template` SET `mindmg` = 4293, `maxdmg` = 6560, `DamageModifier` = 1.03 WHERE `entry` = 12129;
UPDATE `creature_template` SET `mindmg` = 8586, `maxdmg` = 13120, `DamageModifier` = 1.03 WHERE `entry` = 36572;
UPDATE `creature_template` SET `mindmg` = 776, `maxdmg` = 912, `DamageModifier` = 1.03 WHERE `entry` = 11262;
UPDATE `creature_template` SET `mindmg` = 1552, `maxdmg` = 1824, `DamageModifier` = 1.03 WHERE `entry` = 36566;
UPDATE `creature_template` SET `mindmg` = 3165, `maxdmg` = 4395, `DamageModifier` = 1.03 WHERE `entry` = 36561;
UPDATE `creature_template` SET `mindmg` = 6330, `maxdmg` = 8790, `DamageModifier` = 1.03 WHERE `entry` = 36571;

/* BOSS */ 
UPDATE `creature_template` SET `mindmg` = 27860, `maxdmg` = 38650, `DamageModifier` = 1.01 WHERE `entry` = 10184;
UPDATE `creature_template` SET `mindmg` = 55720, `maxdmg` = 77300, `DamageModifier` = 1.01 WHERE `entry` = 36538;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
