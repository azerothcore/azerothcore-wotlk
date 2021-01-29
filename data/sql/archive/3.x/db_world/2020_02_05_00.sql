-- DB update 2020_01_31_00 -> 2020_02_05_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_01_31_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_01_31_00 2020_02_05_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1579215466676030435'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1579215466676030435');

UPDATE `creature` SET `spawndist` = 5, `MovementType` = 1 WHERE `id` = 27131;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 27131 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2713100 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(27131,0,0,0,1,0,100,0,10000,15000,10000,15000,0,80,2713100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grizzly Bear - Out of Combat - Run Script'),
(27131,0,1,0,4,0,100,0,0,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grizzly Bear - On Aggro - Set Root Off'),

(2713100,9,0,0,0,0,100,0,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grizzly Bear - On Script - Set Root On'),
(2713100,9,1,0,0,0,100,0,0,0,0,0,0,5,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grizzly Bear - On Script - Play Emote ''ONESHOT_EAT'''),
(2713100,9,2,0,0,0,100,0,2000,2000,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grizzly Bear - On Script - Set Root Off');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
