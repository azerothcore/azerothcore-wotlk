-- DB update 2021_07_07_07 -> 2021_07_07_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_07_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_07_07 2021_07_07_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625304053277095200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625304053277095200');

-- Quest: The Divination (2992)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8022;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8022) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8022, 0, 0, 0, 19, 0, 100, 0, 2992, 0, 0, 0, 0, 80, 802200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thadius Grimshade - On Quest \'The Divination\' Taken - Run Script');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 802200) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(802200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thadius Grimshade - Actionlist - Remove Npc Flags Questgiver'),
(802200, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thadius Grimshade - Actionlist - Say Line 0'),
(802200, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thadius Grimshade - Actionlist - Say Line 1'),
(802200, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 144069, 10, 0, 0, 0, 0, 8, 0, 0, 0, 0, -10999, -3484.47, 103.122, 2.52228, 'Thadius Grimshade - Actionlist - Summon Gameobject \'Grimshade\'s Vision\''),
(802200, 9, 4, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thadius Grimshade - Actionlist - Say Line 2'),
(802200, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thadius Grimshade - Actionlist - Add Npc Flags Questgiver');

DELETE FROM `creature_text` WHERE `CreatureID`=8022;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(8022,0,0,"Make no sound during the ritual.  One misstep could spell our doom...",12,0,100,0,0,0,4126,0,"Thadius Grimshade"),
(8022,1,0,"Now, watch...",12,0,100,0,0,0,4127,0,"Thadius Grimshade"),
(8022,2,0,"There.  It is done.",12,0,100,0,0,0,4128,0,"Thadius Grimshade");


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_07_08' WHERE sql_rev = '1625304053277095200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
