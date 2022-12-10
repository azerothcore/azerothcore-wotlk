-- DB update 2021_07_07_21 -> 2021_07_07_22
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_07_21';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_07_21 2021_07_07_22 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625603525661258200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625603525661258200');

-- Witch Doctor Unbagwa
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1449;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 1449);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1449, 0, 0, 0, 20, 0, 100, 0, 349, 0, 0, 0, 0, 80, 144900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Unbagwa - On Quest \'Stranglethorn Fever\' Finished - Run Script'),
(1449, 0, 1, 2, 38, 0, 100, 0, 1, 1, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Unbagwa - On Data Set 1 1 - Add Npc Flags Questgiver'),
(1449, 0, 2, 3, 61, 0, 100, 0, 1, 1, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Unbagwa - On Data Set 1 1 - Set Event Phase 1'),
(1449, 0, 3, 4, 61, 0, 100, 0, 1, 1, 0, 0, 0, 92, 0, 12380, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Unbagwa - On Data Set 1 1 - Interrupt Spell \'Shadow Channeling\''),
(1449, 0, 4, 5, 61, 1, 100, 0, 1, 1, 0, 0, 0, 5, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Unbagwa - On Data Set 1 1 - Play Emote 4'),
(1449, 0, 5, 6, 61, 1, 100, 0, 1, 1, 0, 0, 0, 4, 2859, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Unbagwa - On Data Set 1 1 - Play Sound 2859'),
(1449, 0, 6, 0, 61, 1, 100, 0, 1, 1, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Unbagwa - On Data Set 1 1 - Set Event Phase 0');

-- Witch Doctor Unbagwa actionlist
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 144900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(144900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Unbagwa - Actionlist - Say Line 0'),
(144900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Unbagwa - Actionlist - Remove Npc Flags Questgiver'),
(144900, 9, 3, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 11, 12380, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Unbagwa - Actionlist - Cast \'Shadow Channeling\''),
(144900, 9, 4, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 12, 1511, 3, 300000, 1, 0, 0, 8, 0, 0, 0, 0, -13813.5, 8.70047, 27.3387, 6.0634, 'Witch Doctor Unbagwa - Actionlist - Summon Creature \'Enraged Silverback Gorilla\''),
(144900, 9, 5, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 0, 12, 1516, 3, 300000, 1, 0, 0, 8, 0, 0, 0, 0, -13813.5, 8.70047, 27.3387, 6.0634, 'Witch Doctor Unbagwa - Actionlist - Summon Creature \'Konda\''),
(144900, 9, 6, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 0, 12, 1514, 3, 300000, 1, 0, 0, 8, 0, 0, 0, 0, -13813.5, 8.70047, 27.3387, 6.0634, 'Witch Doctor Unbagwa - Actionlist - Summon Creature \'Mokk the Savage\'');

-- Mokk
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1514;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 1514);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1514, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1514, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mokk the Savage - On Respawn - Start Waypoint'),
(1514, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mokk the Savage - On Respawn - Set Reactstate Aggressive'),
(1514, 0, 2, 3, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8269, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mokk the Savage - Between 0-30% Health - Cast \'Frenzy\' (No Repeat)'),
(1514, 0, 3, 0, 61, 0, 100, 0, 0, 30, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mokk the Savage - Between 0-30% Health - Say Line 0 (No Repeat)'),
(1514, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 1219, 1449, 0, 0, 0, 0, 0, 0, 'Mokk the Savage - On Just Died - Set Data 1 1');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_07_22' WHERE sql_rev = '1625603525661258200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
