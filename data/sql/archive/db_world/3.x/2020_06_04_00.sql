-- DB update 2020_06_03_00 -> 2020_06_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_03_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_03_00 2020_06_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588337024794996000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588337024794996000');

/*
 * Dungeon: Razorfen Kraul
 * Update by Knindza | <www.azerothcore.org>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 65, `maxdmg` = 88, `DamageModifier` = 1.03 WHERE `entry` IN (4530, 4436, 4437, 4514);
UPDATE `creature_template` SET `mindmg` = 57, `maxdmg` = 80, `DamageModifier` = 1.03 WHERE `entry` = 4535;
UPDATE `creature_template` SET `mindmg` = 63, `maxdmg` = 88, `DamageModifier` = 1.03 WHERE `entry` IN (4435, 4511);
UPDATE `creature_template` SET `mindmg` = 65, `maxdmg` = 92, `DamageModifier` = 1.03 WHERE `entry` IN (4442, 4438, 6035);
UPDATE `creature_template` SET `mindmg` = 43, `maxdmg` = 62, `DamageModifier` = 1.03 WHERE `entry` = 4516;
UPDATE `creature_template` SET `mindmg` = 56, `maxdmg` = 77, `DamageModifier` = 1.03 WHERE `entry` IN (4523, 4522, 4440, 4518, 4519);
UPDATE `creature_template` SET `mindmg` = 56, `maxdmg` = 75, `DamageModifier` = 1.03 WHERE `entry` IN (4520, 4517);
UPDATE `creature_template` SET `mindmg` = 54, `maxdmg` = 80, `DamageModifier` = 1.03 WHERE `entry` = 4528;
UPDATE `creature_template` SET `mindmg` = 68, `maxdmg` = 92, `DamageModifier` = 1.03 WHERE `entry` IN (4512, 4623, 4539, 4538, 4541);
UPDATE `creature_template` SET `mindmg` = 68, `maxdmg` = 92, `minrangedmg` = 48, `maxrangedmg` = 71, `DamageModifier` = 1.03 WHERE `entry` = 4532;
UPDATE `creature_template` SET `mindmg` = 36, `maxdmg` = 48, `DamageModifier` = 1.03 WHERE `entry` = 4534;
UPDATE `creature_template` SET `mindmg` = 117, `maxdmg` = 151, `DamageModifier` = 1.03 WHERE `entry` = 6021;
UPDATE `creature_template` SET `mindmg` = 43, `maxdmg` = 60, `DamageModifier` = 1.03 WHERE `entry` = 4526;
UPDATE `creature_template` SET `mindmg` = 58, `maxdmg` = 77, `DamageModifier` = 1.03 WHERE `entry` IN (4525, 4427);
UPDATE `creature_template` SET `mindmg` = 38, `maxdmg` = 50, `DamageModifier` = 1.03 WHERE `entry` = 4625;

/* RARE */
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 193, `maxdmg` = 249, `DamageModifier` = 1.02 WHERE `entry` = 4842;
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 208, `maxdmg` = 266, `DamageModifier` = 1.02 WHERE `entry` = 4425;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 146, `maxdmg` = 189, `DamageModifier` = 1.01 WHERE `entry` IN (4424, 4428);
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 193, `maxdmg` = 249, `DamageModifier` = 1.01 WHERE `entry` = 4420;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 160, `maxdmg` = 205, `DamageModifier` = 1.01 WHERE `entry` = 4422;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 185, `maxdmg` = 239, `DamageModifier` = 1.01 WHERE `entry` = 4421;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 134, `maxdmg` = 173, `DamageModifier` = 1.01 WHERE `entry` = 6168;

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4535;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4535);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4535, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6268, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tamed Battleboar - On Aggro - Cast \'6268\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
