-- DB update 2020_05_30_00 -> 2020_05_31_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_30_00 2020_05_31_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588336118180516700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588336118180516700');

/*
 * Dungeon: Wailing Caverns
 * Update by Knindza | <www.azerothcore.org>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 46, `maxdmg` = 65, `DamageModifier` = 1.03 WHERE `entry` IN (3637, 3636);
UPDATE `creature_template` SET `mindmg` = 43, `maxdmg` = 61, `DamageModifier` = 1.03 WHERE `entry` = 3640;
UPDATE `creature_template` SET `mindmg` = 44, `maxdmg` = 59, `DamageModifier` = 1.03 WHERE `entry` IN (3840, 5761);
UPDATE `creature_template` SET `mindmg` = 27, `maxdmg` = 38, `DamageModifier` = 1.03 WHERE `entry` = 5053;
UPDATE `creature_template` SET `mindmg` = 29, `maxdmg` = 38, `DamageModifier` = 1.03 WHERE `entry` = 5055;
UPDATE `creature_template` SET `mindmg` = 49, `maxdmg` = 65, `DamageModifier` = 1.03 WHERE `entry` IN (5756, 5056, 5048, 5755);
UPDATE `creature_template` SET `mindmg` = 27, `maxdmg` = 38, `DamageModifier` = 1.03 WHERE `entry` = 8886;
UPDATE `creature_template` SET `mindmg` = 30, `maxdmg` = 40, `DamageModifier` = 1.03 WHERE `entry` = 5763;
UPDATE `creature_template` SET `mindmg` = 65, `maxdmg` = 89, `DamageModifier` = 1.03 WHERE `entry` = 5762;

/* RARE */														
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 99, `maxdmg` = 127, `DamageModifier` = 1.02 WHERE `entry` = 5912;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 101, `maxdmg` = 130, `DamageModifier` = 1.01 WHERE `entry` IN (3671, 3670, 2673);
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 85, `maxdmg` = 110, `DamageModifier` = 1.01 WHERE `entry` IN (3674, 3653);
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 201, `maxdmg` = 230, `DamageModifier` = 1.01 WHERE `entry` = 5775;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 95, `maxdmg` = 122, `DamageModifier` = 1.01 WHERE `entry` = 3669;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 117, `maxdmg` = 151, `DamageModifier` = 1.01 WHERE `entry` = 3654;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
