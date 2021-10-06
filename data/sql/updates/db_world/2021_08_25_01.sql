-- DB update 2021_08_25_00 -> 2021_08_25_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_25_00 2021_08_25_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629285313174833600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629285313174833600');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = ''  WHERE `entry` = 9236;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 9236);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9236, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 45000, 45000, 0, 11, 16098, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow Hunter Vosh\'gajin - In Combat - Cast \'Curse of Blood\''),
(9236, 0, 1, 0, 0, 0, 100, 0, 8000, 8000, 15000, 15000, 0, 11, 16097, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow Hunter Vosh\'gajin - In Combat - Cast \'Hex\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_25_01' WHERE sql_rev = '1629285313174833600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
