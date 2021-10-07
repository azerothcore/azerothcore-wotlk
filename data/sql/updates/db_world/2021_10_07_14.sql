-- DB update 2021_10_07_13 -> 2021_10_07_14
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_07_13';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_07_13 2021_10_07_14 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633408496818705100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633408496818705100');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 4962 AND `source_type` = 0 AND `id` = 13;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4962, 0, 13, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 4971, 0, 0, 0, 0, 0, 0, 0, 'Tapoke "Slim" Jahn - On Evade - Set Data 2 2');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 4971 AND `source_type` = 0 AND `id` = 4;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4971, 0, 4, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Slim\'s Friend - On Data Set 2 2 - Despawn Instant');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_07_14' WHERE sql_rev = '1633408496818705100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
