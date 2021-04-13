-- DB update 2020_06_02_00 -> 2020_06_03_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_02_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_02_00 2020_06_03_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588336883299094900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588336883299094900');

/*
 * Dungeon: Stormwind Stockade
 * Update by Knindza | <www.azerothcore.org>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 60, `maxdmg` = 80, `DamageModifier` = 1.03 WHERE `entry` IN (1707, 1706);
UPDATE `creature_template` SET `mindmg` = 60, `maxdmg` = 84, `DamageModifier` = 1.03 WHERE `entry` IN (1708, 1711);
UPDATE `creature_template` SET `mindmg` = 82, `maxdmg` = 109, `DamageModifier` = 1.03 WHERE `entry` = 1715;

/* RARE */
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 116, `maxdmg` = 149, `DamageModifier` = 1.02 WHERE `entry` = 1720;

/* BOSS */
UPDATE `creature_template` SET `type_flags` = `type_flags`|4, `mindmg` = 106, `maxdmg` = 166, `DamageModifier` = 1.01 WHERE `entry` = 1696;
UPDATE `creature_template` SET `type_flags` = `type_flags`|4, `mindmg` = 129, `maxdmg` = 166, `DamageModifier` = 1.01 WHERE `entry` IN (1666, 1663, 1716);
UPDATE `creature_template` SET `type_flags` = `type_flags`|4, `mindmg` = 134, `maxdmg` = 173, `DamageModifier` = 1.01 WHERE `entry` = 1717;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
