-- DB update 2026_01_27_02 -> 2026_01_27_03
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28352);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28352, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 50, 190555, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethurbian Crater KC Bunny - On Respawn - Summon Gameobject \'Nerubian Crater\''),
(28352, 0, 1, 2, 8, 0, 100, 1, 51381, 0, 0, 0, 0, 0, 80, 2835200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethurbian Crater KC Bunny - On Spellhit \'Toss Grenade\' - Run Script (No Repeat)'),
(28352, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 28352, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethurbian Crater KC Bunny - On Spellhit \'Toss Grenade\' - Quest Credit (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2835200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2835200, 9, 0, 0, 0, 0, 100, 0, 4200, 4200, 0, 0, 0, 0, 11, 44762, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethurbian Crater KC Bunny - Actionlist - Cast \'Camera Shake - Med\''),
(2835200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 48456, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethurbian Crater KC Bunny - Actionlist - Cast \'Shredder Smoke\''),
(2835200, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51435, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethurbian Crater KC Bunny - Actionlist - Cast \'Summon Skimmer\''),
(2835200, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51435, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethurbian Crater KC Bunny - Actionlist - Cast \'Summon Skimmer\''),
(2835200, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51435, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethurbian Crater KC Bunny - Actionlist - Cast \'Summon Skimmer\''),
(2835200, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51435, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethurbian Crater KC Bunny - Actionlist - Cast \'Summon Skimmer\''),
(2835200, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51435, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethurbian Crater KC Bunny - Actionlist - Cast \'Summon Skimmer\''),
(2835200, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51435, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethurbian Crater KC Bunny - Actionlist - Cast \'Summon Skimmer\''),
(2835200, 9, 8, 0, 0, 0, 100, 0, 11300, 11300, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 20, 190555, 5, 0, 0, 0, 0, 0, 0, 'Nethurbian Crater KC Bunny - Actionlist - Despawn Instant'),
(2835200, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethurbian Crater KC Bunny - Actionlist - Despawn Instant');

DELETE FROM `gameobject` WHERE `id` = 190555 AND `guid` BETWEEN 58160 AND 58168;
DELETE FROM `creature` WHERE `id1` = 28369 AND `guid` BETWEEN 115685 AND 115691;
UPDATE `creature` SET `spawntimesecs` = 120 WHERE `id1` = 28352 AND `guid` BETWEEN 114082 AND 114091;

UPDATE `creature_template` SET `AIName` = 'SmartAI', `speed_run` = 2 WHERE `entry` = 28369;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28369);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28369, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40148, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Burning Skimmer - On Respawn - Cast \'Immolation\''),
(28369, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Burning Skimmer - On Respawn - Set Run On'),
(28369, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Burning Skimmer - On Respawn - Start Random Movement'),
(28369, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 37, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Burning Skimmer - On Respawn - Kill Self');
