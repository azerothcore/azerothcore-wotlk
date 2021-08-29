-- DB update 2020_05_23_00 -> 2020_05_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_23_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_23_00 2020_05_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588335399793049400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588335399793049400');

/*
 * Dungeon: Ragefire Chasm
 * Update by Knindza | <www.azerothcore.org>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 31, `maxdmg` = 46, `DamageModifier` = 1.03 WHERE `entry` IN (11320, 11319, 11322);
UPDATE `creature_template` SET `mindmg` = 31, `maxdmg` = 42, `DamageModifier` = 1.03 WHERE `entry` = 11321;
UPDATE `creature_template` SET `mindmg` = 31, `maxdmg` = 50, `DamageModifier` = 1.03 WHERE `entry` IN (11318, 11323);
UPDATE `creature_template` SET `mindmg` = 22, `maxdmg` = 38, `DamageModifier` = 1.03 WHERE `entry` = 11324;
UPDATE `creature_template` SET `mindmg` = 38, `maxdmg` = 47, `DamageModifier` = 1.03 WHERE `entry` = 8996;
UPDATE `creature_template` SET `mindmg` = 89, `maxdmg` = 113, `DamageModifier` = 1.03 WHERE `entry` = 17830;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 74, `maxdmg` = 96, `DamageModifier` = 1.01 WHERE `entry` IN (11520, 11518, 11519);
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 101, `maxdmg` = 130, `DamageModifier` = 1.01 WHERE `entry` = 11517;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
