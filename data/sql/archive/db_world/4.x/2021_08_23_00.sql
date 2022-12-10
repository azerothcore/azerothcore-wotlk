-- DB update 2021_08_22_01 -> 2021_08_23_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_22_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_22_01 2021_08_23_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629136628346689200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629136628346689200');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4966;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4966);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4966, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - On Spawn - Normal Emote'),
(4966, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - Linked - Add NPC Flag Questgiver'),
(4966, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - Linked - Reset Invincibility HP'),
(4966, 0, 3, 0, 19, 0, 100, 0, 1324, 0, 0, 0, 0, 80, 496600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - On Quest \'The Missing Diplomat (Part 16)\' Taken - Run Script'),
(4966, 0, 4, 0, 2, 1, 100, 1, 0, 20, 300, 500, 0, 80, 496601, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - Between 0-20% Health - Run Script (Phase 1) (No Repeat)'),
(4966, 0, 5, 0, 40, 2, 100, 0, 1, 496600, 0, 0, 0, 80, 496602, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - On Waypoint 1 Reached - Run Script (Phase 2)');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_23_00' WHERE sql_rev = '1629136628346689200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
