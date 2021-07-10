INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625825866239168500');

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 4484;
-- First wave
-- https://youtu.be/NZaDRm3E9T4?t=245 starting out of combat here, 2 minutes after they despawn
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`) VALUES
(4484, 0, 0, 3879, 3490.648193, 204.498672, 11.509378, 3.3, 4, 120000),
(4484, 0, 0, 3879, 3499.849854, 191.872589, 9.913058, 1.305067, 4, 120000),
(4484, 0, 0, 3879, 3512.693848, 230.043503, 12.579866, 3.03, 4.390900, 120000),
(4484, 0, 0, 3879, 3489.394775, 233.419022, 13.957080, 5.502226, 4, 120000),
-- Second wave
(4484, 0, 1, 3893, 3768.341064, 167.625793, 8.215360, 4.300611, 4, 60000),
(4484, 0, 1, 3893, 3761.626465, 176.662735, 8.166564, 4.390155, 4, 60000),
(4484, 0, 1, 3893, 3738.870605, 185.198700, 8.003495, 4.987058, 4, 60000),
-- Third wave
-- https://youtu.be/NZaDRm3E9T4?t=756 starting out of combat, 1 minute after they despawn
(4484, 0, 2, 3898, 4217.048828, 95.637215, 34.785011, 3.82938, 4, 60000),
(4484, 0, 2, 3899, 4223.432129, 94.937691, 35.046329, 3.907077, 4, 60000),
(4484, 0, 2, 3900, 4217.989258, 101.213264, 35.168644, 3.856026, 4, 60000);


UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3893;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3893);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3893, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 63, 2, 1, 0, 0, 0, 0, 10, 32783, 4484, 0, 0, 0, 0, 0, 0, 'Forsaken Scout - On Just Died - On Set Counter');


UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3879;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3879);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3879, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 32783, 4484, 0, 0, 0, 0, 0, 0, 'Dark Strand Assassin - On Just Died - On Set Counter');



-- Aligar the Tormentor
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3898;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3898);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3898, 0, 0, 1, 54, 0, 100, 1, 0, 0, 0, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aligar the Tormentor - On Just Summoned - Cast \'Battle Stance\' (No Repeat)'),
(3898, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aligar the Tormentor - On Just Summoned - Say Line 0'),
(3898, 0, 2, 0, 0, 0, 100, 0, 3000, 4000, 5000, 6000, 0, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aligar the Tormentor - In Combat - Cast \'Hamstring\''),
(3898, 0, 3, 0, 0, 0, 100, 1, 6000, 7000, 6000, 7000, 0, 11, 25712, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aligar the Tormentor - In Combat - Cast \'Heroic Strike\' (No Repeat)');


-- https://youtu.be/NZaDRm3E9T4?t=707 Says "You cannot hide from us, little paladin!"
DELETE FROM `creature_text` WHERE `CreatureID` = 3898 AND `GroupID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (3898, 0, 0, 'You cannot hide from us, little paladin!', 12, 0, 100, 0, 0, 0, 1312, 0, 'Aligar the Tormentor');


-- Balizar the Umbrage
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3899;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3899);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3899, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 10000, 15000, 0, 11, 14868, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Balizar the Umbrage - In Combat - Cast \'Curse of Agony\''),
(3899, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 11000, 16000, 0, 11, 11980, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Balizar the Umbrage - In Combat - Cast \'Curse of Weakness\''),
(3899, 0, 2, 0, 0, 0, 100, 0, 7000, 8000, 7000, 8000, 0, 11, 20791, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Balizar the Umbrage - In Combat - Cast \'Shadow Bolt\'');

-- Caedakar the Vicious
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3900;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3900, 0, 0, 0, 54, 0, 100, 1, 0, 0, 0, 0, 0, 11, 905, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caedakar the Vicious - On Just Summoned - Cast \'Lightning Shield\' (No Repeat)'),
(3900, 0, 1, 0, 0, 0, 100, 0, 0, 0, 6000, 6000, 0, 11, 915, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Caedakar the Vicious - In Combat - Cast \'Lightning Bolt\'');


-- Feero Ironhand Smart AI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4484;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4484);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4484, 0, 0, 1, 19, 0, 100, 1, 976, 0, 0, 0, 0, 2, 774, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Quest \'Supplies to Auberdine\' Taken - Set Faction 774 (No Repeat)'),
(4484, 0, 1, 2, 61, 0, 100, 1, 976, 0, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Quest \'Supplies to Auberdine\' Taken - Remove Flags Immune To NPC\'s (No Repeat)'),
(4484, 0, 2, 0, 61, 0, 100, 1, 976, 0, 0, 0, 0, 1, 7, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Quest \'Supplies to Auberdine\' Taken - Say Line 7 (No Repeat)'),
(4484, 0, 3, 0, 7, 0, 100, 1, 0, 0, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Evade - Remove Flags Immune To NPC\'s (No Repeat)'),
(4484, 0, 4, 5, 40, 0, 100, 1, 20, 4484, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Waypoint 20 Reached - Pause Waypoint (No Repeat)'),
(4484, 0, 5, 0, 61, 0, 100, 1, 20, 4484, 0, 0, 0, 80, 448400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Waypoint 20 Reached - Run Script (No Repeat)'),
(4484, 0, 6, 0, 77, 0, 100, 0, 1, 4, 0, 0, 0, 80, 448403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Counter Set - Run Script'),
(4484, 0, 7, 8, 40, 0, 100, 1, 27, 4484, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Waypoint 27 Reached - Pause Waypoint (No Repeat)'),
(4484, 0, 8, 0, 61, 0, 100, 0, 27, 4484, 0, 0, 0, 80, 448401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Waypoint 27 Reached - Run Script (No Repeat)'),
(4484, 0, 9, 0, 77, 0, 100, 1, 2, 3, 0, 0, 0, 80, 448404, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Counter Set - Run Script (No Repeat)'),
(4484, 0, 10, 11, 40, 0, 100, 1, 43, 4484, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Waypoint 43 Reached - Pause Waypoint (No Repeat)'),
(4484, 0, 11, 0, 61, 0, 100, 0, 43, 4484, 0, 0, 0, 80, 448402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Waypoint 43 Reached - Run Script (No Repeat)'),
(4484, 0, 12, 13, 40, 0, 100, 1, 44, 4484, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Waypoint 44 Reached - Say Line 6 (No Repeat)'),
(4484, 0, 13, 14, 61, 0, 100, 1, 44, 4484, 0, 0, 0, 15, 976, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Waypoint 44 Reached - Quest Credit \'Supplies to Auberdine\' (No Repeat)'),
(4484, 0, 14, 0, 61, 0, 100, 1, 44, 4484, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Waypoint 44 Reached - Pause Waypoint (No Repeat)'),
(4484, 0, 15, 0, 40, 0, 100, 1, 46, 4484, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Waypoint 46 Reached - Despawn Instant (No Repeat)'),
(4484, 0, 16, 0, 6, 0, 100, 1, 0, 0, 0, 0, 0, 6, 976, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Just Died - Fail Quest \'Supplies to Auberdine\' (No Repeat)'),
(4484, 0, 17, 0, 52, 0, 100, 1, 4, 4484, 0, 0, 0, 1, 0, 5000, 0, 0, 0, 0, 19, 3899, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Text 4 Over - Say Line 0 (No Repeat)'),
(4484, 0, 18, 0, 52, 0, 100, 1, 0, 3899, 0, 0, 0, 5, 1, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Text 0 Over - Play Emote 1 (No Repeat)'),
(4484, 0, 19, 0, 52, 0, 100, 1, 7, 4484, 0, 0, 0, 53, 1, 4484, 0, 976, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - On Text 7 Over - Start Waypoint (No Repeat)');

-- Actionlist 0
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 448400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(448400, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 0, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - Actionlist - Say Line 0'),
(448400, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 107, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - Actionlist - Summon Creature Group 0'),
(448400, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 10, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - Actionlist - Start Attacking');

-- Actionlist 1
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 448401);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(448401, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 1, 2, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - Actionlist - Say Line 2'),
(448401, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 107, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - Actionlist - Summon Creature Group 1'),
(448401, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 10, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - Actionlist - Start Attacking');

-- Actionlist 2
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 448402);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(448402, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 1, 4, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - Actionlist - Say Line 4'),
(448402, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 107, 2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - Actionlist - Summon Creature Group 2'),
(448402, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 10, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - Actionlist - Start Attacking');

-- Actionlist 3
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 448403);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(448403, 9, 0, 0, 0, 0, 100, 1, 500, 500, 0, 0, 0, 54, 11000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - Actionlist - Pause Waypoint (No Repeat)'),
(448403, 9, 1, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - Actionlist - Say Line 1 (No Repeat)');

-- Actionlist 5
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 448404);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(448404, 9, 0, 0, 0, 0, 100, 1, 500, 500, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - Actionlist - Pause Waypoint (No Repeat)'),
(448404, 9, 1, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feero Ironhand - Actionlist - Say Line 3 (No Repeat)');

-- Waypoints
DELETE FROM `waypoints` WHERE `entry` = 4484;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(4484, 1, 3175.93, 193.541, 3.48354, 'Feero Ironhand'),
(4484, 2, 3187.92, 197.118, 4.6993, 'Feero Ironhand'),
(4484, 3, 3203.48, 192.349, 5.90847, 'Feero Ironhand'),
(4484, 4, 3219.12, 182.236, 6.58841, 'Feero Ironhand'),
(4484, 5, 3229.85, 191.23, 7.49455, 'Feero Ironhand'),
(4484, 6, 3225.04, 199.439, 7.09672, 'Feero Ironhand'),
(4484, 7, 3227.65, 210.76, 8.62933, 'Feero Ironhand'),
(4484, 8, 3232.94, 223.725, 10.0522, 'Feero Ironhand'),
(4484, 9, 3263.07, 225.985, 10.6459, 'Feero Ironhand'),
(4484, 10, 3284.76, 220.414, 10.9505, 'Feero Ironhand'),
(4484, 11, 3315.65, 210.198, 11.9677, 'Feero Ironhand'),
(4484, 12, 3341.02, 214.29, 13.3204, 'Feero Ironhand'),
(4484, 13, 3367.13, 224.588, 11.8671, 'Feero Ironhand'),
(4484, 14, 3409.07, 226.385, 9.21523, 'Feero Ironhand'),
(4484, 15, 3432.29, 225.396, 10.0283, 'Feero Ironhand'),
(4484, 16, 3454.87, 219.339, 12.5932, 'Feero Ironhand'),
(4484, 17, 3470.46, 214.818, 13.2644, 'Feero Ironhand'),
(4484, 18, 3481.42, 212.557, 12.3546, 'Feero Ironhand'),
(4484, 19, 3500.32, 210.936, 10.2261, 'Feero Ironhand'),
(4484, 20, 3515.19, 212.546, 9.62118, 'Feero Ironhand'),
(4484, 21, 3522.900146, 213.576904, 9.203624, 'Feero Ironhand'),
(4484, 22, 3601.65, 217.771, 1.29901, 'Feero Ironhand'),
(4484, 23, 3638.61, 212.526, 1.43314, 'Feero Ironhand'),
(4484, 24, 3680.76, 200.308, 3.38501, 'Feero Ironhand'),
(4484, 25, 3725.67, 180.396, 6.31401, 'Feero Ironhand'),
(4484, 26, 3762.35, 159.686, 7.38862, 'Feero Ironhand'),
(4484, 27, 3774.54, 151.17, 7.79964, 'Feero Ironhand'),
(4484, 28, 3789.7, 140.397, 9.06224, 'Feero Ironhand'),
(4484, 29, 3821.42, 111.61, 10.2586, 'Feero Ironhand'),
(4484, 30, 3850.38, 84.7109, 13.942, 'Feero Ironhand'),
(4484, 31, 3875.35, 60.3884, 14.9889, 'Feero Ironhand'),
(4484, 32, 3908.24, 35.2092, 15.332, 'Feero Ironhand'),
(4484, 33, 3942.2, 14.8882, 16.9694, 'Feero Ironhand'),
(4484, 34, 3976.43, -0.073566, 16.9687, 'Feero Ironhand'),
(4484, 35, 4008.34, -6.62891, 16.4641, 'Feero Ironhand'),
(4484, 36, 4029.48, -6.64076, 16.5497, 'Feero Ironhand'),
(4484, 37, 4050.06, 1.48816, 15.7462, 'Feero Ironhand'),
(4484, 38, 4083.41, 14.0858, 15.8512, 'Feero Ironhand'),
(4484, 39, 4098.46, 20.0329, 17.2525, 'Feero Ironhand'),
(4484, 40, 4125.749023, 32.694153, 20.618135, 'Feero Ironhand'),
(4484, 41, 4149.13, 46.8332, 24.661, 'Feero Ironhand'),
(4484, 42, 4164.44, 55.9354, 26.7934, 'Feero Ironhand'),
(4484, 43, 4200.283203, 82.396561, 32.021034, 'Feero Ironhand'),
(4484, 44, 4202.202148, 83.824730, 32.288143, 'Feero Ironhand'),
(4484, 45, 4256.208984, 126.819801, 40.609882, 'Feero Ironhand'),
(4484, 46, 4338.702148, 176.241531, 46.838947, 'Feero Ironhand');
