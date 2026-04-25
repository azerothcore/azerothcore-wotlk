-- Update Apothecary Ravien SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23782;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23782);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23782, 0, 0, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 1, 23782, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Ravien - On Just Summoned - Start Waypoint Path 23782'),
(23782, 0, 1, 2, 40, 0, 100, 512, 6, 23782, 0, 0, 0, 0, 54, 60000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Ravien - On Point 6 of Path 23782 Reached - Pause Waypoint'),
(23782, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 101906, 24126, 0, 0, 0, 0, 0, 0, 'Apothecary Ravien - On Point 6 of Path 23782 Reached - Set Orientation Closest Creature \'Apothecary Lysander\''),
(23782, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 223, 10, 0, 0, 0, 0, 0, 10, 101906, 24126, 0, 0, 0, 0, 0, 0, 'Apothecary Ravien - On Point 6 of Path 23782 Reached - Do Action ID 10'),
(23782, 0, 4, 0, 40, 0, 100, 512, 7, 23782, 0, 0, 0, 0, 223, 11, 0, 0, 0, 0, 0, 10, 101906, 24126, 0, 0, 0, 0, 0, 0, 'Apothecary Ravien - On Point 7 of Path 23782 Reached - Do Action ID 11'),
(23782, 0, 5, 0, 40, 0, 100, 512, 18, 23782, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Ravien - On Point 18 of Path 23782 Reached - Despawn Instant');

-- Update Apothecary Lysander SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24126;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24126);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24126, 0, 0, 0, 20, 1, 100, 0, 11170, 0, 0, 0, 0, 0, 80, 2412600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - On Quest \'Test at Sea\' Finished - Run Script (Phase 1)'),
(24126, 0, 1, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 80, 2412601, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - On Action 10 Done - Run Script'),
(24126, 0, 2, 0, 72, 0, 100, 0, 11, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - On Action 11 Done - Set Event Phase 1'),
(24126, 0, 3, 0, 1, 1, 100, 0, 0, 30000, 30000, 90000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - Out of Combat - Say Line 6 (Phase 1)'),
(24126, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - On Reset - Set Event Phase 1');

-- Set Action Lists
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2412600, 2412601));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2412600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 23782, 1, 90000, 0, 0, 0, 8, 0, 0, 0, 0, 1965.13, -6126.74, 25.6126, 3.27167, 'Apothecary Lysander - Actionlist - Summon Creature \'Apothecary Ravien\''),
(2412600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - Actionlist - Set Event Phase 0'),
(2412601, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 23782, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - Actionlist - Say Line 0 (Apothecary Ravien)'),
(2412601, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - Actionlist - Say Line 0'),
(2412601, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 204, 23782, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - Actionlist - Say Line 1 (Apothecary Ravien)'),
(2412601, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - Actionlist - Say Line 1'),
(2412601, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 204, 23782, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - Actionlist - Say Line 2 (Apothecary Ravien)'),
(2412601, 9, 5, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - Actionlist - Say Line 2'),
(2412601, 9, 6, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - Actionlist - Say Line 3'),
(2412601, 9, 7, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - Actionlist - Say Line 4'),
(2412601, 9, 8, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - Actionlist - Say Line 5'),
(2412601, 9, 9, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 204, 23782, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Lysander - Actionlist - Say Line 3 (Apothecary Ravien)');
