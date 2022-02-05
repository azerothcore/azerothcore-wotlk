-- DB update 2022_01_03_12 -> 2022_01_03_13
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_03_12';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_03_12 2022_01_03_13 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641213986609051100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641213986609051100');

-- Grethok immunity flags.
UPDATE `creature_template` SET `mechanic_immune_mask` = 33636209 WHERE (`entry` = 12557);

-- Grethok - Update arcane missiles to correct spell id (was using triggered spell)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 12557) AND (`source_type` = 0) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12557, 0, 3, 0, 0, 0, 80, 2, 16000, 16000, 12000, 12000, 0, 11, 22272, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Grethok the Controller - In Combat - Cast \'Arcane Missiles\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_03_13' WHERE sql_rev = '1641213986609051100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
