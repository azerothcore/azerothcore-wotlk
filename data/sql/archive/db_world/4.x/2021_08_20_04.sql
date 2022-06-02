-- DB update 2021_08_20_03 -> 2021_08_20_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_20_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_20_03 2021_08_20_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629208512724054400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629208512724054400');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 9736);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 9736);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9736, 0, 0, 0, 0, 0, 100, 0, 16000, 16000, 16000, 16000, 0, 11, 16497, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Quartermaster Zigris - In Combat - Cast \'Stun Bomb\''),
(9736, 0, 1, 0, 9, 0, 100, 0, 4, 6, 14000, 16000, 0, 11, 15609, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Quartermaster Zigris - Within 4-6 Range - Cast \'Hooked Net\''),
(9736, 0, 2, 3, 9, 0, 100, 0, 10, 30, 2000, 2000, 0, 11, 16496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Quartermaster Zigris - Within 10-30 Range - Cast \'Shoot\''),
(9736, 0, 3, 0, 61, 0, 100, 0, 10, 30, 2000, 2000, 0, 21, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Quartermaster Zigris - Within 10-30 Range - Disable Combat Movement'),
(9736, 0, 4, 0, 9, 0, 100, 0, 0, 10, 300, 300, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quartermaster Zigris - Within 0-10 Range - Enable Combat Movement');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_20_04' WHERE sql_rev = '1629208512724054400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
