-- DB update 2021_09_20_02 -> 2021_09_20_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_20_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_20_02 2021_09_20_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631645430068698532'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631645430068698532');

-- Change the quest parameter and the comment. Now he should cast Break stuff when completing the correct quest The Temple of Atal'Hakkar. Deleted wrong smartAI.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 1443);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1443, 0, 0, 0, 20, 0, 100, 0, 1445, 0, 0, 0, 0, 11, 7437, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel\'zerul - On Quest \'The Temple of Atal\'Hakkar\' Finished - Cast \'Break Stuff\'');


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_20_03' WHERE sql_rev = '1631645430068698532';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
