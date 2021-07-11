-- DB update 2021_07_07_12 -> 2021_07_07_13
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_07_12';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_07_12 2021_07_07_13 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625434614739025100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--


INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625434614739025100');

-- Squire Maltrake
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8509;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8509) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8509, 0, 0, 0, 20, 0, 100, 0, 3463, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 8479, 0, 0, 0, 0, 0, 0, 0, 'Squire Maltrake - On Quest \'Set Them Ablaze!\' Finished - Set Data 1 1');


-- Kalaran Windblade
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8479;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 8479);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8479, 0, 0, 1, 62, 0, 100, 0, 1321, 0, 0, 0, 0, 26, 3441, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran Windblade - On Gossip Option 0 Selected - Quest Credit \'Divine Retribution\''),
(8479, 0, 1, 0, 61, 0, 100, 0, 1321, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran Windblade - On Gossip Option 0 Selected - Close Gossip'),
(8479, 0, 2, 3, 62, 0, 100, 0, 1323, 2, 0, 0, 0, 11, 19797, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran Windblade - On Gossip Option 2 Selected - Cast \'Conjure Torch of Retribution\''),
(8479, 0, 3, 0, 61, 0, 100, 0, 1323, 2, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran Windblade - On Gossip Option 2 Selected - Close Gossip'),
(8479, 0, 4, 0, 62, 0, 100, 0, 1323, 3, 0, 0, 0, 80, 847900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran Windblade - On Gossip Option 3 Selected - Run Script'),
(8479, 0, 5, 6, 19, 0, 100, 0, 3454, 0, 0, 0, 0, 50, 149047, 60, 1, 0, 0, 0, 8, 0, 0, 0, 0, -6683.73, -1194.19, 242.02, 0.212059, 'Kalaran Windblade - On Quest \'The Torch of Retribution\' Taken - Summon Gameobject \'Torch of Retribution\''),
(8479, 0, 6, 0, 61, 0, 100, 0, 3454, 0, 0, 0, 0, 50, 149410, 60, 1, 0, 0, 0, 8, 0, 0, 0, 0, -6683.73, -1194.19, 240.02, 0.447678, 'Kalaran Windblade - On Quest \'The Torch of Retribution\' Taken - Summon Gameobject \'Light of Retribution\''),
(8479, 0, 7, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran Windblade - On Data Set 1 1 - Despawn Instant'),
(8479, 0, 8, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 12, 8480, 3, 68000, 0, 0, 0, 8, 0, 0, 0, 0, -6680.12, -1194.4, 243.255, 3.00197, 'Kalaran Windblade - On Data Set 1 1 - Summon Creature \'Kalaran the Deceiver\'');

-- Respawn time for Kalaran Windblade lowered to 120 it was 900
UPDATE `creature` SET `spawntimesecs` = 120 WHERE (`ID` = 8479);


-- Kalaran the Deceiver
UPDATE `creature_template` SET `AIName` = 'SmartAI', `InhabitType` = 4, `unit_flags` = 33555264 WHERE `entry` = 8480;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8480) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8480, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 80, 848000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran the Deceiver - On Just Summoned - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 848000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(848000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 0, 'Kalaran the Deceiver - Actionlist - Set Orientation Closest Player'),
(848000, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran the Deceiver - Actionlist - Say Line 0'),
(848000, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran the Deceiver - Actionlist - Say Line 1'),
(848000, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran the Deceiver - Actionlist - Say Line 2'),
(848000, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 8509, 0, 0, 0, 0, 0, 0, 0, 'Kalaran the Deceiver - Actionlist - Say Line 0'),
(848000, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.65994, 'Kalaran the Deceiver - Actionlist - Set Orientation 4.65994'),
(848000, 9, 6, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran the Deceiver - Actionlist - Say Line 3'),
(848000, 9, 7, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran the Deceiver - Actionlist - Say Line 4'),
(848000, 9, 8, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran the Deceiver - Actionlist - Say Line 5'),
(848000, 9, 9, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 8509, 0, 0, 0, 0, 0, 0, 0, 'Kalaran the Deceiver - Actionlist - Say Line 1'),
(848000, 9, 10, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran the Deceiver - Actionlist - Say Line 6'),
(848000, 9, 11, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran the Deceiver - Actionlist - Say Line 7'),
(848000, 9, 12, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalaran the Deceiver - Actionlist - Say Line 8'),
(848000, 9, 13, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -6879.3, -1187.34, 293.384, 0, 'Kalaran the Deceiver - Actionlist - Move To Position');

-- Correct order texts for Kalaran the Deceiver
DELETE FROM `creature_text` WHERE `CreatureID`= 8480;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(8480, 0, 0, 'Glorious, indeed, Maltrake. It looks as if my plan worked perfectly. Wouldn\'t you say so, mortal?', 12, 0, 100, 0, 0, 0, 4456, 0, 'Kalaran the Deceiver'),
(8480, 1, 0, '%s lets loose a reptilian laugh... at least you think it\'s a laugh.', 16, 0, 100, 0, 0, 0, 4458, 0, 'Kalaran the Deceiver'),
(8480, 2, 0, 'You would not have helped the legion of Blackrock had we just asked for your assistance, now would you?', 12, 0, 100, 0, 0, 0, 4457, 0, 'Kalaran the Deceiver'),
(8480, 3, 0, 'SILENCE FOOL!', 12, 0, 100, 0, 0, 0, 4460, 0, 'Kalaran the Deceiver'),
(8480, 4, 0, 'They will live, if only to see the fruits of their labor: the destruction and chaos that will surely ensue as the legion of Blackrock invade the gorge.', 12, 0, 100, 0, 0, 0, 4461, 0, 'Kalaran the Deceiver'),
(8480, 5, 0, 'I leave you now, mortals. Alive and with these trinkets. Maltrake! Present them with the trinkets!', 12, 0, 100, 0, 0, 0, 4462, 0, 'Kalaran the Deceiver'),
(8480, 6, 0, '%s begins to flap his massive wings faster. He is preparing for flight.', 16, 0, 100, 0, 0, 0, 4464, 0, 'Kalaran the Deceiver'),
(8480, 7, 0, 'Oh yes, the molt - do not lose it. There are those of my kin in the Burning Steppes that would craft items that only the molt of the black Dragonflight could fortify.', 12, 0, 100, 0, 0, 0, 4463, 0, 'Kalaran the Deceiver'),
(8480, 8, 0, 'The legion of Blackrock comes, dwarflings! We shall scorch the earth and set fire to the heavens. None shall survive...', 14, 0, 100, 0, 0, 0, 4465, 0, 'Kalaran the Deceiver');



--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_07_13' WHERE sql_rev = '1625434614739025100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
