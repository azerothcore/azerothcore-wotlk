-- DB update 2021_12_31_02 -> 2021_12_31_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_31_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_31_02 2021_12_31_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640823255701543300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640823255701543300');

-- "Patches", correcting SAI.
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30993) AND (`source_type` = 0) AND (`id` IN (1, 3, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30993, 0, 1, 13, 1, 2, 100, 0, 0, 0, 3000, 3000, 0, 11, 58108, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Patches" - OOC (Phase 2) - Cast Patches Chain'),
(30993, 0, 3, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 28, 58108, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Patches" - On Data Set 1 1 - Remove Aura Patches Chain'),
(30993, 0, 6, 15, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Patches" - On Data Set 1 1 - Say Line 1'),
(30993, 0, 8, 9, 38, 0, 100, 0, 3, 3, 0, 0, 0, 11, 59115, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Patches" - On Data Set 3 3 - Cast Patches Credit'),
(30993, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 15000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Patches" - On Data Set 3 3 - Despawn'),
(30993, 0, 10, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Patches" - On On Data Set 5 5 - Turn Random Move Off'),
(30993, 0, 11, 0, 38, 0, 100, 0, 4, 4, 0, 0, 0, 80, 3099300, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Patches" - On Data Set 4 4 - Run Script'),
(30993, 0, 12, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 14, 62005, 193025, 0, 0, 0, 0, 0, 0, '"Patches" - On Respawn - Set Data 1 1 on Metal Stake'),
(30993, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Patches" - On Respawn - Set Random Movement'),
(30993, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Patches" - On Respawn - Set Unit Flags'),
(30993, 0, 15, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6606.15, 3189.54, 648.54, 3.32, '"Patches" - On Data Set 1 1 - Face Doctor Sabnok End WP'),
(30993, 0, 16, 0, 17, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '"Patches" - Summoned Unit - Store Target');

-- Doctor Sabnok, correcting damage and damage speed (Estimated Guess from videos)
UPDATE `creature_template` SET `DamageModifier` = 3.5, `BaseAttackTime` = 5000, `RangeAttackTime` = 5000 WHERE (`entry` = 30992);

-- Doctor Sabnok, correcting SAI
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30992) AND (`source_type` = 0) AND (`id` IN (5, 7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30992, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 80, 3099200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doctor Sabnok - Reached WP14 - Run Script');

-- Update Doctor Sabnok final waypoint orientation to not look in wall
UPDATE `waypoints` SET `orientation`='6.16' WHERE `entry`=30992 AND `pointid`=14;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_31_03' WHERE sql_rev = '1640823255701543300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
