--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24170;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24170);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24170, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2417000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draconis Gastritis Bunny - On Just Summoned - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2417000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2417000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Draconis Gastritis Bunny - Actionlist - Store Player & Party'),
(2417000, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draconis Gastritis Bunny - Actionlist - Store Self'),
(2417000, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 3, 0, 0, 0, 0, 0, 19, 23689, 100, 0, 0, 0, 0, 0, 0, 'Draconis Gastritis Bunny - Actionlist - Get Nearest Proto-Drake'),
(2417000, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 50, 186598, 60, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draconis Gastritis Bunny - Actionlist - Summon Gameobject \'Tillinghast\'s Plagued Meat\''),
(2417000, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draconis Gastritis Bunny - Actionlist - Despawn In 30000 ms'),
(2417000, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Draconis Gastritis Bunny - Actionlist - Send Player Party to Proto-Drake'),
(2417000, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 2, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Draconis Gastritis Bunny - Actionlist - Send Self to Proto-Drake'),
(2417000, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Draconis Gastritis Bunny - Actionlist - Ping Nearest Proto-Drake');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23689;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23689);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23689, 0, 0, 0, 9, 0, 100, 0, 0, 0, 2000, 3500, 0, 5, 11, 51219, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Within 0-5 Range - Cast \'Flame Breath\''),
(23689, 0, 1, 0, 0, 0, 100, 0, 3000, 9000, 30000, 45000, 0, 0, 11, 42362, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - In Combat - Cast \'Flames of Birth\''),
(23689, 0, 2, 0, 9, 0, 100, 0, 0, 0, 10000, 15000, 0, 20, 11, 41572, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Within 0-20 Range - Cast \'Wing Buffet\''),
(23689, 0, 3, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, 2368900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - On Ping Received from Bunny - Run Script'),
(23689, 0, 4, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2368901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - On Reached Bunny - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2368900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2368900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 235, 60000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Actionlist - Pause Movement'),
(2368900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Actionlist - Set Flags Immune To Players'),
(2368900, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 1, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Actionlist - Move To Bunny');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2368901);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2368901, 9, 0, 0, 0, 0, 100, 0, 2800, 2800, 0, 0, 0, 0, 5, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Actionlist - Play Emote 35 (OneShotAttackUnarmed)'),
(2368901, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 43176, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Actionlist - Cast \'Upset Stomach\''),
(2368901, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 24170, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Actionlist - Quest Credit \'Draconis Gastritis\''),
(2368901, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Actionlist - Kill Bunny'),
(2368901, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Actionlist - Remove Flags Immune To Players'),
(2368901, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 236, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Actionlist - Resume Movement');
