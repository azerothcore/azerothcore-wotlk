-- DB update 2022_01_19_04 -> 2022_01_19_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_19_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_19_04 2022_01_19_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639532770750121300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639532770750121300');

-- Senetil Selarin spawn after completition of quest=995 or quest=994
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`= 3694;

-- Terenthis Smart Scripts
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3693;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 3693 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (369301, 369302, 369303) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(3693, 0, 0, 0, 20, 0, 100, 0, 995, 0, 0, 0, 0, 12, 3694, 6, 180000, 0, 0, 0, 8, 0, 0, 0, 0, 6339.14, 341.764, 24.3387, 0.498114, 'Terenthis - On Quest \'Escape Through Stealth\' Finished - Summon Creature \'Sentinel Selarin\''),
(3693, 0, 1, 0, 20, 0, 100, 0, 994, 0, 0, 0, 0, 12, 3694, 6, 180000, 0, 0, 0, 8, 0, 0, 0, 0, 6339.14, 341.764, 24.3387, 0.498114, 'Terenthis - On Quest \'Escape Through Force\' Finished - Summon Creature \'Sentinel Selarin\''),
(3693, 0, 3, 4, 20, 0, 100, 0, 985, 0, 0, 0, 0, 83, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Quest How Big a Threat? (Part 2) Rewarded - Remove Questgiver+Gossip npcflag'),
(3693, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 12, 3695, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6402.48, 368.301, 16.3091, 1.0602, 'Terenthis - On Quest How Big a Threat? (Part 2) Rewarded - Summon Grimclaw'),
(3693, 0, 5, 0, 20, 0, 100, 0, 986, 0, 0, 0, 0, 80, 369302, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Quest A Lost Master (Part 1) Finished - Run Script'),
(3693, 0, 6, 0, 19, 0, 100, 0, 993, 0, 0, 0, 0, 80, 369303, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Quest A Lost Master (Part 2) Taken - Run Script'),
(369301, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 3695, 1, 50000, 0, 0, 0, 8, 0, 0, 0, 0, 6435.25, 368.004, 13.9412, 1.09956, 'Terenthis - On Script - Summon Creature \'Grimclaw\''),
(369301, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Script - Say Line 3'),
(369301, 9, 2, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Script - Say Line 4'),
(369301, 9, 3, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Script - Say Line 5'),
(369301, 9, 4, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Script - Say Line 6'),
(369301, 9, 5, 0, 0, 0, 100, 0, 14000, 14000, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Script - Say Line 7'),
(369302, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Script - Remove Npc Flag Questgiver+Gossip'),
(369302, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Script - Say Line 8'),
(369302, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Script - Say Line 9'),
(369302, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Script - Set Emote State 69'),
(369302, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Script - Set Emote State 0'),
(369302, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 82, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Script - Add Npc Flag Questgiver+Gossip'),
(369303, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 6236, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Script - Cast \'Form of the Moonstalker\''),
(369303, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Script - Say Line 10'),
(369303, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 1, 11, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Terenthis - On Script - Say Line 11');

-- Sentinel Selarin Smart Scripts
DELETE FROM `smart_scripts` WHERE `entryorguid` = 3694 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 369400 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(3694, 0, 0, 2, 54, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 3694, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - On Just Summoned - Start Waypoint'),
(3694, 0, 1, 0, 40, 0, 100, 0, 23, 3694, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - On Waypoint 23 Reached - Despawn Instant'),
(3694, 0, 2, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - On Just Summoned - Set Active On'),
(3694, 0, 3, 0, 40, 0, 100, 0, 1, 3694, 0, 0, 0, 54, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - On Waypoint 1 Reached - Pause Waypoint'),
(3694, 0, 4, 6, 40, 0, 100, 0, 12, 3694, 0, 0, 0, 54, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - On Waypoint 12 Reached - Pause Waypoint'),
(3694, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - On Just Summoned - Remove Npc Flags Questgiver'),
(3694, 0, 6, 8, 61, 0, 100, 0, 12, 3694, 0, 0, 0, 80, 369400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - On Waypoint 12 Reached - Run Script'),
(3694, 0, 7, 8, 40, 0, 100, 0, 14, 0, 0, 0, 0, 54, 120000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - On Waypoint 14 Reached - Pause Waypoint'),
(3694, 0, 8, 0, 61, 0, 100, 0, 12, 3694, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - On Waypoint 12 Reached - Set Run Off'),
(369400, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - Actionlist - Say Line 0'),
(369400, 9, 1, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - Actionlist - Say Line 7'),
(369400, 9, 2, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - Actionlist - Say Line 1'),
(369400, 9, 3, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - Actionlist - Say Line 2'),
(369400, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - Actionlist - Add Npc Flags Questgiver'),
(369400, 9, 5, 0, 0, 0, 100, 0, 90000, 90000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - Actionlist - Say Line 3'),
(369400, 9, 6, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentinel Selarin - Actionlist - Remove Npc Flags Questgiver');

-- Grimclaw SAI
DELETE FROM `smart_scripts` WHERE `entryorguid` = 3695 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 369500 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(3695, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 3695, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Respawn - Start Waypoint'),
(3695, 0, 1, 0, 40, 0, 100, 0, 1, 3695, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On WP 1 Reached (Path 3695) - Talk 0 (Terenthis)'),
(3695, 0, 2, 0, 40, 0, 100, 0, 5, 3695, 0, 0, 0, 80, 369500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On WP 5 Reached (Path 3695) - Run Actionlist'),
(3695, 0, 3, 0, 40, 0, 100, 0, 9, 3695, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On WP 9 Reached (Path 3695) - Despawn'),
(3695, 0, 4, 0, 22, 0, 100, 0, 101, 50000, 50000, 0, 0, 80, 369501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - Received Emote 101 - Run Actionlist'),
(3695, 0, 5, 0, 40, 0, 100, 0, 3, 369500, 0, 0, 0, 80, 369502, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On WP 3 Reached (Path 369500) - Run Actionlist'),
(369500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 40000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Pause Waypoint for 40 seconds'),
(369500, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 0'),
(369500, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 1 (Terenthis)'),
(369500, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 1'),
(369500, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 2 (Terenthis)'),
(369500, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 3 (Terenthis)'),
(369500, 9, 6, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 86, 6238, 0, 19, 3693, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Cross Cast \'Speak with Animals\''),
(369500, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 4 (Terenthis)'),
(369500, 9, 8, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 2'),
(369500, 9, 9, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 5 (Terenthis)'),
(369500, 9, 10, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 3'),
(369500, 9, 11, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Talk 6 (Terenthis)'),
(369500, 9, 12, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 82, 3, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Script - Add Questgiver+Gossip npcflag (Terenthis)');

-- Updating Grimclaw, Terenthis and Sentinel Selarin texts
DELETE FROM `creature_text` WHERE `CreatureID` IN (3694, 3695, 3693);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(3694, 0, 0, 'Terenthis, Raene sent me to find you. The Sentinels are in need of help in Ashenvale.', 12, 7, 100, 1, 0, 0, 1302, 0, 'Sentinel Selarin'),
(3694, 1, 0, 'Thank you, Terenthis. I shall remain here for as long as I can.', 12, 7, 100, 2, 0, 0, 1303, 0, 'Sentinel Selarin'),
(3694, 2, 0, 'Hopefully I can send a worthy few to help Ashenvale and the Sentinels.', 12, 7, 100, 1, 0, 0, 1304, 0, 'Sentinel Selarin'),
(3694, 3, 0, 'Thank you again, Terenthis. I shall return again if more help is needed. Until then, please send more adventurers to Ashenvale', 12, 7, 100, 2, 0, 0, 1306, 0, 'Sentinel Selarin'),
(3693, 0, 0, 'What was that noise? It sounded like a roar.', 12, 7, 100, 6, 0, 0, 1245, 0, 'Terenthis'),
(3693, 1, 0, 'Grimclaw?! Easy there, my friend... where is your master Volcor?', 12, 7, 100, 5, 0, 0, 1227, 0, 'Terenthis'),
(3693, 2, 0, 'Whoa, whoa there, my friend. One moment...', 12, 7, 100, 1, 0, 0, 1229, 0, 'Terenthis'),
(3693, 3, 0, '%s begins to cast a spell on Grimclaw.', 16, 7, 100, 0, 0, 0, 1246, 0, 'Terenthis'),
(3693, 4, 0, 'There... that should help. Now, tell me what\'s happened, Grimclaw.', 12, 7, 100, 1, 0, 0, 1230, 0, 'Terenthis'),
(3693, 5, 0, 'I understand, my friend. I shall find someone to help your master. Go back to him now, or at least stay close.', 12, 7, 100, 1, 0, 0, 1232, 0, 'Terenthis'),
(3693, 6, 0, 'If you have the time, Grimclaw and his master Volcor could use your help. If you\'re interested, speak with me further...', 12, 7, 100, 1, 0, 0, 1384, 0, 'Terenthis'),
(3693, 7, 0, 'Hello, Selarin. I\'m afraid I cannot help you at the moment, but perhaps some of the adventurers here in Auberdine can...', 12, 7, 100, 1, 0, 0, 1305, 0, 'Terenthis'),
(3693, 8, 0, 'I shall get started right away, $n.', 12, 7, 100, 1, 0, 0, 1247, 0, 'Terenthis'),
(3693, 9, 0, 'Now... where was my thread and needle. Ah! There it is...', 12, 7, 100, 1, 0, 0, 1248, 0, 'Terenthis'),
(3693, 10, 0, '%s begins to cast a spell as you take the cloak from him.', 16, 7, 100, 0, 0, 0, 1249, 0, 'Terenthis'),
(3693, 11, 0, 'Go now, $n. Find Volcor... and remember, the magics protecting you will fail if you interact with anyone, save for talking.', 12, 7, 100, 1, 0, 0, 1289, 0, 'Terenthis'),
(3695, 0, 0, '%s roars at Terenthis to get his attention.', 16, 0, 100, 0, 0, 478, 1226, 0, 'Grimclaw'),
(3695, 1, 0, '%s begins to moan and roar at Terenthis while stomping his paws on the ground.', 16, 0, 100, 53, 0, 474, 1228, 0, 'Grimclaw'),
(3695, 2, 0, '%s roars at Terenthis more, but this time the druid seems to understand the bear.', 16, 0, 100, 0, 0, 473, 1231, 0, 'Grimclaw'),
(3695, 3, 0, '%s roars in acknowledgement at Terenthis.', 16, 0, 100, 0, 0, 473, 1233, 0, 'Grimclaw'),
(3695, 4, 0, '%s growls in your direction before taking time to sniff you.', 16, 7, 100, 0, 0, 0, 1234, 0, 'Grimclaw'),
(3695, 5, 0, '%s faces southeast and whimpers before looking back at you.', 16, 7, 100, 0, 0, 0, 1225, 0, 'Grimclaw'),
(3695, 6, 0, '%s roars in excitement as he rushes Volcor. When he reaches his master, Grimclaw licks his face.', 16, 7, 100, 0, 0, 0, 1241, 0, 'Grimclaw');

-- Waypoints for Grimclaw and Sentinel Selarin
DELETE FROM `waypoints` WHERE `entry` IN (3694, 3695, 369500);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES 
(3694, 1, 6339.14, 341.764, 24.3387, 0, 'Sentinel Selarin'),
(3694, 2, 6353.39, 354.557, 22.3779, 0, 'Sentinel Selarin'),
(3694, 3, 6368.99, 357.894, 21.5712, 0, 'Sentinel Selarin'),
(3694, 4, 6387.81, 359.455, 18.9899, 0, 'Sentinel Selarin'),
(3694, 5, 6398.12, 363.588, 17.366, 0, 'Sentinel Selarin'),
(3694, 6, 6403.68, 370.92, 15.6815, 0, 'Sentinel Selarin'),
(3694, 7, 6416.57, 392.998, 12.0215, 0, 'Sentinel Selarin'),
(3694, 8, 6424.95, 399.193, 10.9586, 0, 'Sentinel Selarin'),
(3694, 9, 6428.93, 396.971, 11.1736, 0, 'Sentinel Selarin'),
(3694, 10, 6432, 388.708, 13.7662, 0, 'Sentinel Selarin'),
(3694, 11, 6436.71, 375.264, 13.9403, 0, 'Sentinel Selarin'),
(3694, 12, 6434.92, 367.203, 13.9403, 4.410007, 'Sentinel Selarin'),
(3694, 13, 6436.568359, 361.979736, 13.941305, 0, 'Sentinel Selarin'),
(3694, 14, 6436.570312, 362.127228, 13.941305, 1.522100, 'Sentinel Selarin'),
(3694, 15, 6436.9, 374.833, 13.9403, 0, 'Sentinel Selarin'),
(3694, 16, 6431.63, 389.723, 13.5875, 0, 'Sentinel Selarin'),
(3694, 17, 6428.84, 397.45, 11.0941, 0, 'Sentinel Selarin'),
(3694, 18, 6424, 400.084, 10.9784, 0, 'Sentinel Selarin'),
(3694, 19, 6413.76, 392.804, 12.2825, 0, 'Sentinel Selarin'),
(3694, 20, 6401.4, 368.195, 16.4249, 0, 'Sentinel Selarin'),
(3694, 21, 6393.69, 360.887, 18.1549, 0, 'Sentinel Selarin'),
(3694, 22, 6377.21, 357.731, 20.6589, 0, 'Sentinel Selarin'),
(3694, 23, 6358.35, 357.353, 22.2106, 0, 'Sentinel Selarin'),
(3694, 24, 6348.45, 352.662, 22.6056, 0, 'Sentinel Selarin'),
(3694, 25, 6322.42, 326.649, 25.3338, 0, 'Sentinel Selarin'),
(3695, 1, 6409.01, 381.597, 13.7997, 0, 'Grimclaw'),
(3695, 2, 6422.38, 398.542, 11.1623, 0, 'Grimclaw'),
(3695, 3, 6429.16, 395.692, 11.6041, 0, 'Grimclaw'),
(3695, 4, 6437.87, 372.912, 13.9415, 0, 'Grimclaw'),
(3695, 5, 6436.29, 366.529, 13.9415, 4.410007, 'Grimclaw'),
(3695, 6, 6437.87, 372.912, 13.9415, 0, 'Grimclaw'),
(3695, 7, 6429.16, 395.692, 11.6041, 0, 'Grimclaw'),
(3695, 8, 6422.38, 398.542, 11.1623, 0, 'Grimclaw'),
(3695, 9, 6409.01, 381.597, 13.7997, 0, 'Grimclaw'),
(369500, 1, 4685.86, 140.07, 55.7441, 0, 'Grimclaw'),
(369500, 2, 4605.85, 1.4452, 69.5886, 0, 'Grimclaw'),
(369500, 3, 4607.42, -3.3206, 69.8902, 0, 'Grimclaw');

-- Gossip menu for Volcor
DELETE FROM `gossip_menu` WHERE `MenuID` = 3692 AND `TextID` IN (3213, 3214);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES 
(3692, 3213),
(3692, 3214);

UPDATE `npc_text` SET `Probability0`= 100 WHERE `ID` IN (3213, 3214);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 3692) AND (`SourceEntry` = 3214) AND (`SourceId` = 0) AND (`ElseGroup` IN (0, 1));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 3692, 3214, 0, 0, 47, 0, 993, 66, 0, 0, 0, 0, '', 'When player has quest \'A Lost Master (2)\' Complete or Rewarded'),
(14, 3692, 3214, 0, 1, 47, 0, 994, 64, 0, 1, 0, 0, '', 'When player has not finished quest \'Escape Through Force\''),
(14, 3692, 3214, 0, 1, 47, 0, 995, 64, 0, 1, 0, 0, '', 'When player has not finished quest \'Escape Through Stealth\'');

UPDATE `creature_template` SET `npcflag`= 2 WHERE `entry`= 3694;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_19_05' WHERE sql_rev = '1639532770750121300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
