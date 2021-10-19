-- DB update 2020_06_05_00 -> 2020_06_06_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_05_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_05_00 2020_06_06_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588337666335849000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588337666335849000');

/*
 * Dungeon: Razorfen Downs
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 90, `maxdmg` = 125, `DamageModifier` = 1.03 WHERE `entry` IN (7327, 7332);
UPDATE `creature_template` SET `mindmg` = 59, `maxdmg` = 81, `DamageModifier` = 1.03 WHERE `entry` = 7335;
UPDATE `creature_template` SET `mindmg` = 60, `maxdmg` = 126, `DamageModifier` = 1.03 WHERE `entry` = 7353;
UPDATE `creature_template` SET `mindmg` = 110, `maxdmg` = 146, `DamageModifier` = 1.03 WHERE `entry` = 7347;
UPDATE `creature_template` SET `mindmg` = 60, `maxdmg` = 84, `DamageModifier` = 1.03 WHERE `entry` = 7342;
UPDATE `creature_template` SET `mindmg` = 27, `maxdmg` = 38, `DamageModifier` = 1.03 WHERE `entry` = 7340;
UPDATE `creature_template` SET `mindmg` = 90, `maxdmg` = 121, `DamageModifier` = 1.03 WHERE `entry` = 7333;
UPDATE `creature_template` SET `mindmg` = 93, `maxdmg` = 129, `DamageModifier` = 1.03 WHERE `entry` IN (7334, 7329, 7344);
UPDATE `creature_template` SET `mindmg` = 130, `maxdmg` = 180, `DamageModifier` = 1.03 WHERE `entry` = 7328;
UPDATE `creature_template` SET `mindmg` = 55, `maxdmg` = 74, `DamageModifier` = 1.03 WHERE `entry` = 7349;
UPDATE `creature_template` SET `mindmg` = 170, `maxdmg` = 230, `DamageModifier` = 1.03 WHERE `entry` = 7351;
UPDATE `creature_template` SET `mindmg` = 93, `maxdmg` = 125, `DamageModifier` = 1.03 WHERE `entry` = 7343;
UPDATE `creature_template` SET `mindmg` = 77, `maxdmg` = 104, `DamageModifier` = 1.03 WHERE `entry` = 7352;
UPDATE `creature_template` SET `mindmg` = 99, `maxdmg` = 129, `DamageModifier` = 1.03 WHERE `entry` = 7348;
UPDATE `creature_template` SET `mindmg` = 59, `maxdmg` = 84, `DamageModifier` = 1.03 WHERE `entry` = 7341;
UPDATE `creature_template` SET `mindmg` = 96, `maxdmg` = 129, `DamageModifier` = 1.03 WHERE `entry` = 7346;
UPDATE `creature_template` SET `mindmg` = 134, `maxdmg` = 180, `DamageModifier` = 1.03 WHERE `entry` = 7345;
UPDATE `creature_template` SET `mindmg` = 46, `maxdmg` = 62, `DamageModifier` = 1.03 WHERE `entry` = 8585;

/* RARE */
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 140, `maxdmg` = 158, `DamageModifier` = 1.02 WHERE `entry` = 7354;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 208, `maxdmg` = 268, `DamageModifier` = 1.01 WHERE `entry` IN (7355, 7357);
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 229, `maxdmg` = 295, `DamageModifier` = 1.01 WHERE `entry` = 8567;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 215, `maxdmg` = 276, `DamageModifier` = 1.01 WHERE `entry` = 7356;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 269, `maxdmg` = 346, `DamageModifier` = 1.01 WHERE `entry` = 7358;

/* QUEST */
UPDATE `creature_template` SET `speed_run` = 1 WHERE `entry` = 8516;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
