-- DB update 2022_02_04_00 -> 2022_02_04_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_04_00 2022_02_04_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643232180075711500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643232180075711500');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17853) AND (`source_type` = 0) AND (`id` IN (9));

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17664) AND (`source_type` = 0) AND (`id` IN (12, 23));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17664, 0, 12, 23, 61, 1, 100, 1, 22, 51, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 17853, 30, 0, 0, 0, 0, 0, 0, 'Matis the Cruel - Between 22-51% Health - Set Data 1 1 (Phase 1) (No Repeat)'),
(17664, 0, 23, 13, 61, 1, 100, 1, 22, 51, 0, 0, 0, 11, 31336, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Matis the Cruel - Between 22-51% Health - Cast \'Matis Captured DND\' (Phase 1) (No Repeat)');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_04_01' WHERE sql_rev = '1643232180075711500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
