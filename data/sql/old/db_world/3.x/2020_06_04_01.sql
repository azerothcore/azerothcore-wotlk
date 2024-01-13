-- DB update 2020_06_04_00 -> 2020_06_04_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_04_00 2020_06_04_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588337177136468800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588337177136468800');

/*
 * Dungeon: Gnomeregan
 * Update by Knindza | <www.azerothcore.org>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 56, `maxdmg` = 77, `DamageModifier` = 1.03 WHERE `entry` = 6329;
UPDATE `creature_template` SET `mindmg` = 63, `maxdmg` = 92, `DamageModifier` = 1.03 WHERE `entry` IN (6207, 6206);
UPDATE `creature_template` SET `mindmg` = 146, `maxdmg` = 189, `DamageModifier` = 1.03 WHERE `entry` = 6215;
UPDATE `creature_template` SET `mindmg` = 68, `maxdmg` = 92, `DamageModifier` = 1.03 WHERE `entry` IN (6211, 6218);
UPDATE `creature_template` SET `mindmg` = 68, `maxdmg` = 95, `DamageModifier` = 1.03 WHERE `entry` IN (6219, 7603, 6222, 6224);
UPDATE `creature_template` SET `mindmg` = 58, `maxdmg` = 81, `DamageModifier` = 1.03 WHERE `entry` = 6220;
UPDATE `creature_template` SET `mindmg` = 65, `maxdmg` = 88, `DamageModifier` = 1.03 WHERE `entry` = 7849;
UPDATE `creature_template` SET `mindmg` = 65, `maxdmg` = 95, `DamageModifier` = 1.03 WHERE `entry` = 6233;
UPDATE `creature_template` SET `mindmg` = 68, `maxdmg` = 95, `minrangedmg` = 38, `maxrangedmg` = 58, `DamageModifier` = 1.03 WHERE `entry` = 6223;
UPDATE `creature_template` SET `mindmg` = 71, `maxdmg` = 95, `DamageModifier` = 1.03 WHERE `entry` IN (6230, 6234, 6212, 6232);
UPDATE `creature_template` SET `mindmg` = 46, `maxdmg` = 63, `minrangedmg` = 37, `maxrangedmg` = 58, `DamageModifier` = 1.03 WHERE `entry` = 6225;
UPDATE `creature_template` SET `mindmg` = 40, `maxdmg` = 54, `DamageModifier` = 1.03 WHERE `entry` = 6227;
UPDATE `creature_template` SET `mindmg` = 47, `maxdmg` = 63, `DamageModifier` = 1.03 WHERE `entry` = 6226;

/* RARE */
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 161, `maxdmg` = 207, `DamageModifier` = 1.02 WHERE `entry` = 6228;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 193, `maxdmg` = 249, `DamageModifier` = 1.01 WHERE `entry` IN (7361, 6235, 6229);
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 90, `maxdmg` = 115, `DamageModifier` = 1.01 WHERE `entry` = 7079;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 193, `maxdmg` = 249, `DamageModifier` = 1.01 WHERE `entry` = 7800;

/* SMARTSCRIPTS */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6233;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6233);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6233, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 8000, 9000, 11, 1604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mechanized Sentry - In Combat - Cast \'Dazed\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
