-- DB update 2026_06_21_00 -> 2026_06_22_00

-- Add Spell Script Name.
DELETE FROM `spell_script_names` WHERE `spell_id` = 51036;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(51036, 'spell_venture_pilot_summon');

-- Add new Sniffed Waypoints
DELETE FROM `waypoints` WHERE `entry` IN (28192, 2819200, 2822900);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(2819200, 1, 5142.8774, 4676.631, 73.46826, NULL, 'Archmage Pentarus Flying Machine'),
(2819200, 2, 5199.205, 4727.144, 72.46811, NULL, 'Archmage Pentarus Flying Machine'),
(2819200, 3, 5264.4897, 4794.4497, 69.96814, NULL, 'Archmage Pentarus Flying Machine'),
(2819200, 4, 5309.7544, 4842.0576, 59.273388, NULL, 'Archmage Pentarus Flying Machine'),
(2819200, 5, 5339.674, 4877.8887, 46.18986, NULL, 'Archmage Pentarus Flying Machine'),
(2819200, 6, 5403.4263, 4944.932, 15.161798, NULL, 'Archmage Pentarus Flying Machine'),
(2819200, 7, 5455.6265, 5002.442, -3.115965, NULL, 'Archmage Pentarus Flying Machine'),
(2819200, 8, 5529.6377, 5085.854, -31.67146, NULL, 'Archmage Pentarus Flying Machine'),
(2819200, 9, 5599.5723, 5174.9565, -62.560642, NULL, 'Archmage Pentarus Flying Machine'),
(2819200, 10, 5622.023, 5202.6616, -68.72743, NULL, 'Archmage Pentarus Flying Machine'),
(2819200, 11, 5635.8755, 5225.5605, -75.11644, NULL, 'Archmage Pentarus Flying Machine'),
(2822900, 1, 5508.8813, 4993.8525, -26.99996, NULL, 'Venture Co. Pilot'),
(2822900, 2, 5527.892, 5024.44, -33.166454, NULL, 'Venture Co. Pilot'),
(2822900, 3, 5555.9478, 5055.0166, -40.555496, NULL, 'Venture Co. Pilot'),
(2822900, 4, 5573.23, 5081.3677, -46.416637, NULL, 'Venture Co. Pilot'),
(2822900, 5, 5596.7915, 5120.5415, -60.861324, NULL, 'Venture Co. Pilot'),
(2822900, 6, 5616.4214, 5169.3354, -73.94473, NULL, 'Venture Co. Pilot'),
(2822900, 7, 5639.541, 5246.319, -82.02806, NULL, 'Venture Co. Pilot'),
(2822900, 8, 5649.434, 5336.935, -80.611534, NULL, 'Venture Co. Pilot'),
(2822900, 9, 5649.434, 5336.935, -80.611534, NULL, 'Venture Co. Pilot');

-- Set Sniffed walk and run speed (Archmage Pentarus' Flying Machine).
UPDATE `creature_template` SET `speed_run` = 3.14, `speed_walk` = 6 WHERE `entry` = 28192;

-- Set Default Aura (Archmage Pentarus' Flying Machine).
UPDATE `creature_template_addon` SET `auras` = '48602' WHERE (`entry` = 28192);

-- Edit SAI & Action List (Archmage Pentarus)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28160;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28160);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28160, 0, 0, 0, 62, 0, 100, 512, 10024, 0, 0, 0, 0, 0, 80, 2816000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus - On Gossip Option 0 Selected - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2816000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2816000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus - Actionlist - Close Gossip'),
(2816000, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 50860, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus - Actionlist - Invoker Cast \'Flight to Sholazar\''),
(2816000, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus - Actionlist - Say Line 0'),
(2816000, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 50, 190488, 19, 0, 0, 0, 0, 8, 0, 0, 0, 0, 5828.64, 427.118, 670.096, 0.820303, 'Archmage Pentarus - Actionlist - Summon Gameobject \'Pentarus\' Portal to Sholazar Basin\'');

-- Set SAI & Action Lists (Archmage Pentarus Flying Machine).
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28192;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28192);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28192, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2819200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus\' Flying Machine - On Just Summoned - Run Script'),
(28192, 0, 1, 0, 34, 0, 100, 0, 8, 22, 0, 0, 0, 0, 80, 2819201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus\' Flying Machine - On Reached Point 22 - Run Script'),
(28192, 0, 2, 0, 58, 0, 100, 0, 0, 2819200, 0, 0, 0, 0, 80, 2819202, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus\' Flying Machine - On Path 2819200 Finished - Run Script'),
(28192, 0, 3, 4, 34, 0, 100, 0, 8, 23, 0, 0, 0, 0, 223, 24, 0, 0, 0, 0, 0, 10, 103289, 27987, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus\' Flying Machine - On Reached Point 23 - Do Action ID 24'),
(28192, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 53119, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus\' Flying Machine - On Reached Point 23 - Cast \'Cosmetic Flame Dart\''),
(28192, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus\' Flying Machine - On Reached Point 23 - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2819200, 2819201, 2819202));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2819200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51076, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus\' Flying Machine - Actionlist - Cast \'Flight to Sholazar (Trigger Warning)\''),
(2819200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 46598, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus\' Flying Machine - Actionlist - Invoker Cast \'Ride Vehicle Hardcoded\''),
(2819200, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus\' Flying Machine - Actionlist - Set Fly On'),
(2819200, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 75, 51038, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus\' Flying Machine - Actionlist - Add Aura \'Flight to Sholazar Periodic\''),
(2819200, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 69, 22, 0, 1, 0, 0, 0, 8, 0, 0, 0, 0, 5828.73, 428.093, 669.899, 0, 'Archmage Pentarus\' Flying Machine - Actionlist - Move To Position'),
(2819201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 50987, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus\' Flying Machine - Actionlist - Cast \'Teleport to Sholazar\''),
(2819201, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 53, 0, 2819200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus\' Flying Machine - Actionlist - Start Waypoint Path 2819200'),
(2819202, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 53119, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus\' Flying Machine - Actionlist - Cast \'Cosmetic Flame Dart\''),
(2819202, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 75, 61360, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus\' Flying Machine - Actionlist - Add Aura \'Parachute\''),
(2819202, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 50630, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus\' Flying Machine - Actionlist - Cast \'Eject All Passengers\''),
(2819202, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 23, 0, 1, 0, 0, 0, 8, 0, 0, 0, 0, 5637.41, 5301.54, -109.587, 0, 'Archmage Pentarus\' Flying Machine - Actionlist - Move To Position');

-- Set SAI & Action List Venture Co. Pilot
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28229;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28229);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28229, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2822900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Pilot - On Just Summoned - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2822900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2822900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Pilot - Actionlist - Set Reactstate Passive'),
(2822900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Pilot - Actionlist - Set Fly On'),
(2822900, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 48602, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Pilot - Actionlist - Cast \'Flight\''),
(2822900, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51044, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Pilot - Actionlist - Cast \'Venture Co. Air Patrol Rockets\''),
(2822900, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51043, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Pilot - Actionlist - Cast \'Venture Co. Air Patrol Periodic (Kill Shot)\''),
(2822900, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 2822900, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Pilot - Actionlist - Start Waypoint Path 2822900'),
(2822900, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Pilot - Actionlist - Say Line 0'),
(2822900, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 'Venture Co. Pilot - Actionlist - Say Line 0');

-- Edit SAI (Monte Muzzleshot).
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27987;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27987);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27987, 0, 0, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 60, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Monte Muzzleshot - On Reset - Set Fly On'),
(27987, 0, 1, 0, 72, 0, 100, 0, 24, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Monte Muzzleshot - On Action 24 Done - Say Line 0');

-- Delete unecessary Action List (Monte Muzzleshot).
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2798700) AND (`source_type` = 9);
