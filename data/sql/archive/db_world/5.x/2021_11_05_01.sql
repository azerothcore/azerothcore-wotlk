-- DB update 2021_11_05_00 -> 2021_11_05_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_05_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_05_00 2021_11_05_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632248054324754400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632248054324754400');


DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2338) AND (`source_type` = 0) AND (`id` IN (2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2338, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Disciple - On Aggro - Talk 0'),
(2338, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Disciple - On Death - Talk 1');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2339) AND (`source_type` = 0) AND (`id` IN (3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2339, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Thug - On Aggro - Talk 0'),
(2339, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Thug - On Death - Talk 1');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_05_01' WHERE sql_rev = '1632248054324754400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
