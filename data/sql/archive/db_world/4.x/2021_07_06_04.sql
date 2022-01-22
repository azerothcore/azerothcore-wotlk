-- DB update 2021_07_06_03 -> 2021_07_06_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_06_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_06_03 2021_07_06_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625248824338191500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625248824338191500');

-- Update Kroshius' SAI and make it not selectable
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|33554432, `AIName` = 'SmartAI' WHERE (`entry` = 14467);

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (14467,1446700)) AND (`source_type` IN (0,9)) AND (`id` IN (0, 1, 2, 3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14467, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 80, 1446700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kroshius - On Just Summoned - Run Script'),
(14467, 0, 1, 0, 0, 0, 100, 0, 5000, 8000, 9000, 12000, 0, 11, 10101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Kroshius - In Combat - Cast \'Knock Away\''),
(1446700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 9, 0, 0, 10, 0, 0, 0, 0, 0, 'Kroshius - On Script - Force Despawn'),
(1446700, 9, 1, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kroshius - On Script - Set Rooted On'),
(1446700, 9, 2, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kroshius - On Script - Say Line 0'),
(1446700, 9, 3, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 2, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kroshius - On Script - Set Faction 16'),
(1446700, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 19, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kroshius - On Script - Remove Flags Immune To Players & Immune To NPC\'s'),
(1446700, 9, 5, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kroshius - On Script - Set Rooted Off'),
(1446700, 9, 6, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kroshius - On Script - Start Attacking');

-- Adjust spawn position on quest item use
UPDATE `event_scripts` SET `datalong2` = 180000, `x` = 5780.34, `y` = -964.844, `z` = 412.695 WHERE `id` = 8328;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_06_04' WHERE sql_rev = '1625248824338191500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
