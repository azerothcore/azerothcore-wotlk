-- DB update 2020_05_31_00 -> 2020_06_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_31_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_31_00 2020_06_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588336378116569500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588336378116569500');

/*
 * Dungeon: Shadowfang Keep
 * Update by Knindza | <www.azerothcore.org>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 42, `maxdmg` = 59, `DamageModifier` = 1.03 WHERE `entry` = 3851;
UPDATE `creature_template` SET `mindmg` = 46, `maxdmg` = 73, `DamageModifier` = 1.03 WHERE `entry` = 3861;
UPDATE `creature_template` SET `mindmg` = 28, `maxdmg` = 44, `DamageModifier` = 1.03 WHERE `entry` = 3862;
UPDATE `creature_template` SET `mindmg` = 44, `maxdmg` = 59, `DamageModifier` = 1.03 WHERE `entry` = 3853;
UPDATE `creature_template` SET `mindmg` = 54, `maxdmg` = 73, `DamageModifier` = 1.03 WHERE `entry` = 4444;
UPDATE `creature_template` SET `mindmg` = 46, `maxdmg` = 65, `DamageModifier` = 1.03 WHERE `entry` = 3875;
UPDATE `creature_template` SET `mindmg` = 27, `maxdmg` = 36, `DamageModifier` = 1.03 WHERE `entry` = 4958;
UPDATE `creature_template` SET `mindmg` = 51, `maxdmg` = 69, `DamageModifier` = 1.03 WHERE `entry` = 3854;
UPDATE `creature_template` SET `mindmg` = 39, `maxdmg` = 52, `DamageModifier` = 1.03 WHERE `entry` = 5058;
UPDATE `creature_template` SET `mindmg` = 49, `maxdmg` = 65, `DamageModifier` = 1.03 WHERE `entry` = 3857;
UPDATE `creature_template` SET `mindmg` = 44, `maxdmg` = 59, `DamageModifier` = 1.03 WHERE `entry` = 3855;
UPDATE `creature_template` SET `mindmg` = 49, `maxdmg` = 65, `DamageModifier` = 1.03 WHERE `entry` = 3877;
UPDATE `creature_template` SET `mindmg` = 51, `maxdmg` = 69, `DamageModifier` = 1.03 WHERE `entry` IN (3866, 3868, 3873, 3859, 2529);
UPDATE `creature_template` SET `mindmg` = 51, `maxdmg` = 73, `DamageModifier` = 1.03 WHERE `entry` = 3863;
UPDATE `creature_template` SET `mindmg` = 30, `maxdmg` = 40, `DamageModifier` = 1.03 WHERE `entry` = 4627;
UPDATE `creature_template` SET `mindmg` = 22, `maxdmg` = 31, `DamageModifier` = 1.03 WHERE `entry` = 5097;

/* RARE */
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 101, `maxdmg` = 130, `DamageModifier` = 1.02 WHERE `entry` = 3872;

/* BOSS */
UPDATE `creature_template` SET `type_flags` = `type_flags`|4, `mindmg` = 85, `maxdmg` = 110, `DamageModifier` = 1.01 WHERE `entry` = 3914;
UPDATE `creature_template` SET `type_flags` = `type_flags`|4, `mindmg` = 95, `maxdmg` = 122, `DamageModifier` = 1.01 WHERE `entry` = 3865;
UPDATE `creature_template` SET `type_flags` = `type_flags`|4, `mindmg` = 101, `maxdmg` = 130, `DamageModifier` = 1.01 WHERE `entry` = 3886;
UPDATE `creature_template` SET `type_flags` = `type_flags`|4, `mindmg` = 112, `maxdmg` = 144, `DamageModifier` = 1.01 WHERE `entry` = 3887;
UPDATE `creature_template` SET `type_flags` = `type_flags`|4, `mindmg` = 117, `maxdmg` = 151, `DamageModifier` = 1.01 WHERE `entry` = 4278;
UPDATE `creature_template` SET `type_flags` = `type_flags`|4, `mindmg` = 106, `maxdmg` = 136, `DamageModifier` = 1.01 WHERE `entry` IN (4279, 4274);
UPDATE `creature_template` SET `type_flags` = `type_flags`|4, `mindmg` = 117, `maxdmg` = 151, `DamageModifier` = 1.01 WHERE `entry` = 3927;
UPDATE `creature_template` SET `type_flags` = `type_flags`|4, `mindmg` = 129, `maxdmg` = 166, `DamageModifier` = 1.01 WHERE `entry` = 4275;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
