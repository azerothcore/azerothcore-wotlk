-- DB update 2021_12_04_03 -> 2021_12_05_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_04_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_04_03 2021_12_05_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638657340'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638657340');

/* Dr Weavil - Mental Domination and Mind Shatter SAI */
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 15552);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15552, 0, 0, 1, 11, 0, 100, 1, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 5086.29, -5108.8, 929.24, 0, 'Dr Weavil - On Respawn - Move Point'),
(15552, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dr Weavil - On Respawn - Set Faction'),
(15552, 0, 2, 0, 34, 0, 100, 1, 8, 1, 0, 0, 0, 80, 1555200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'MovementInform - Start Script'),
(15552, 0, 3, 4, 34, 0, 100, 1, 8, 2, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 15553, 30, 0, 0, 0, 0, 0, 0, 'Dr Weavil - MovementInform - Set Data'),
(15552, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dr Weavil - MovementInform - Despawn'),
(15552, 0, 5, 0, 0, 0, 100, 0, 5000, 8000, 55000, 60000, 0, 11, 25772, 32, 1, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Dr Weavil - In Combat - Cast Mental Domination'),
(15552, 0, 6, 0, 0, 0, 100, 0, 4000, 7000, 14000, 16500, 0, 11, 25774, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dr Weavil - In Combat - Cast Mind Shatter');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_05_00' WHERE sql_rev = '1638657340';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
