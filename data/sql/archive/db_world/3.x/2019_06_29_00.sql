-- DB update 2019_06_28_00 -> 2019_06_29_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_06_28_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_06_28_00 2019_06_29_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1561242305351726648'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561242305351726648');

DELETE FROM `creature_template_addon` WHERE `entry` = 11327;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`)
VALUES
(11327,0,0,0,0,0,'19226'); -- Zergling aura (attack emote every 20 seconds)

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11327;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1132700,1132701) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
-- Zergling wins
(1132700,9,0,0,0,0,100,0,0,0,0,0,0,64,1,0,0,0,0,0,19,34694,15,0,0,0,0,0,0,'Zergling - On Script - Store Target ''Grunty'''),
(1132700,9,1,0,0,0,100,0,0,0,0,0,0,97,15,5,1,0,0,0,12,1,0,0,0,0,0,0,0,'Zergling - On Script - Self-Jump To Pos ''Grunty'''),
(1132700,9,2,0,0,0,100,0,0,0,0,0,0,11,67400,2,0,0,0,0,12,1,0,0,0,0,0,0,0,'Zergling - On Script - Cast ''Zergling Attack'''),
(1132700,9,3,0,0,0,100,0,1000,1000,0,0,0,11,67400,2,0,0,0,0,12,1,0,0,0,0,0,0,0,'Zergling - On Script - Cast ''Zergling Attack'''),
(1132700,9,4,0,0,0,100,0,500,500,0,0,0,51,0,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Zergling - On Script - Kill ''Grunty'''),
-- Grunty wins
(1132701,9,0,0,0,0,100,0,0,0,0,0,0,64,1,0,0,0,0,0,19,34694,15,0,0,0,0,0,0,'Zergling - On Script - Store Target ''Grunty'''),
(1132701,9,1,0,0,0,100,0,500,500,0,0,0,86,67366,0,12,1,0,0,1,0,0,0,0,0,0,0,0,'Zergling - On Script - Cross Cast ''C-14 Gauss Rifle'''),
(1132701,9,2,0,0,0,100,0,2300,2300,0,0,0,17,36,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Zergling - On Script - Set Emote State ''ONESHOT_ATTACK1H'''),
(1132701,9,3,0,0,0,100,0,2300,2300,0,0,0,17,0,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Zergling - On Script - Set Emote State ''ONESHOT_NONE'''),
(1132701,9,4,0,0,0,100,0,0,0,0,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Zergling - On Script - Die');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 34694;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 34694 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(34694,0,0,0,1,0,100,0,5500,5500,5500,5500,0,87,1132700,1132701,0,0,0,0,19,11327,15,0,0,0,0,0,0,'Grunty - OOC - Call Random Timed Action List For ''Zergling''');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
