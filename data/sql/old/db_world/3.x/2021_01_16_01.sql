-- DB update 2021_01_16_00 -> 2021_01_16_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_16_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_16_00 2021_01_16_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1609175919318500200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609175919318500200');

DELETE FROM `creature_text` WHERE `CreatureID` = 25270 AND `GroupID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(25270, 0, 0, 'HOORAY! ME FREE!', 12, 1, 20, 0, 0, 0, 24627, 0, 'Warsong Peon'),
(25270, 0, 1, 'Tanks, buddy!', 12, 1, 20, 0, 0, 0, 24628, 0, 'Warsong Peon'),
(25270, 0, 2, 'Mister Mortuus gonna be so mad! Me go home now.', 12, 1, 20, 0, 0, 0, 24629, 0, 'Warsong Peon'),
(25270, 0, 3, 'Why it keep telling me to put da lotion in da basket? Me no like da lotion!', 12, 1, 20, 0, 0, 0, 24630, 0, 'Warsong Peon'),
(25270, 0, 4, 'Huh? Where me at? Dis don''t look good! Me run now!', 12, 1, 20, 0, 0, 0, 24626, 0, 'Warsong Peon');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `unit_flags`=`unit_flags`|512 WHERE `entry` = 25270;

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 25270;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25270, 0, 0, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Peon - Out of Combat - Say Line 0'),
(25270, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Peon - Out of Combat - Despawn In 5000 ms'),
(25270, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 122, 2500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Peon - Out of Combat - Flee For 2500 ms');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
