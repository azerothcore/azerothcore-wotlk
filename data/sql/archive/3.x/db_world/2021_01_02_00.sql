-- DB update 2021_01_01_00 -> 2021_01_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_01_00 2021_01_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1609174873784850500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609174873784850500');

UPDATE `creature_template_addon` SET `auras` = '29266' WHERE `entry` = 17508;

DELETE FROM `creature` WHERE `id` = 17426 AND `guid` = 86514;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17508;
UPDATE `creature_template` SET `unit_flags` = 512, `AIName` = 'SmartAI' WHERE (`entry` = 17426);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17508);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17508, 0, 0, 1, 19, 0, 100, 0, 9579, 0, 0, 0, 0, 12, 17426, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, -2089.99, -11297.3, 63.522, 3.29479, 'Galaen\'s Corpse - On Quest \'Galaen\'s Fate\' Taken - Summon Creature \'Galaen\''),
(17508, 0, 1, 2, 61, 0, 100, 0, 9579, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Galaen\'s Corpse - On Quest \'Galaen\'s Fate\' Taken - Store Targetlist'),
(17508, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 9, 17426, 0, 0, 0, 0, 0, 0, 0, 'Galaen\'s Corpse - On Quest \'Galaen\'s Fate\' Taken - Send Target 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17426);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17426, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 80, 1742600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Galaen - On Respawn - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1742600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1742600, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Galaen - Actionlist - Set Orientation to Stored Target'),
(1742600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Galaen - Actionlist - Say Line 0'),
(1742600, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Galaen - Actionlist - Say Line 1'),
(1742600, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Galaen - Actionlist - Say Line 2'),
(1742600, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Galaen - Actionlist - Despawn In 5000 ms');

-- Set correct quest prev for Galaen's Journal - The Fate of Vindicator Saruan based on WOW Head
UPDATE `quest_template_addon` SET `PrevQuestID` = 9779 WHERE `ID` = 9706;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
