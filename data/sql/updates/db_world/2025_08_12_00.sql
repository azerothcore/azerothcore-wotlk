-- DB update 2025_08_10_01 -> 2025_08_12_00

-- Set SmartAI (Wreckage A, B, C)
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE (`entry`IN (188087, 188088, 188089));

DELETE FROM `smart_scripts` WHERE (`source_type` = 1) AND (`entryorguid` IN (188087, 188088, 188089));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(188087, 1, 0, 0, 38, 0, 100, 0, 0, 1, 0, 0, 0, 0, 41, 0, 60, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wreckage A - On Data Set 0 1 - Despawn Instant'),
(188088, 1, 0, 0, 38, 0, 100, 0, 0, 1, 0, 0, 0, 0, 41, 0, 60, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wreckage B - On Data Set 0 1 - Despawn Instant'),
(188089, 1, 0, 0, 38, 0, 100, 0, 0, 1, 0, 0, 0, 0, 41, 0, 60, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wreckage C - On Data Set 0 1 - Despawn Instant');

-- Set SmartAI (Fezzix Geartwist)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25849;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25849);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25849, 0, 0, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - On Reset - Set Event Phase 1'),
(25849, 0, 1, 2, 20, 1, 100, 0, 11894, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - On Quest \'Patching Up\' Finished - Say Line 0 (Phase 1)'),
(25849, 0, 2, 0, 61, 1, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2584900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - On Quest \'Patching Up\' Finished - Run Script (Phase 1)'),
(25849, 0, 3, 0, 40, 2, 100, 512, 11, 25849, 0, 0, 0, 0, 80, 2584901, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - On Point 11 of Path 25849 Reached - Run Script (Phase 2)'),
(25849, 0, 4, 5, 40, 2, 100, 512, 12, 25849, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - On Point 12 of Path 25849 Reached - Set Event Phase 1 (Phase 2)'),
(25849, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.06662, 'Fezzix Geartwist - On Point 12 of Path 25849 Reached - Set Orientation 4.06662 (Phase 2)');

-- Set Timed Actionlist (Fezzix Geartwist)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2584900, 2584901));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2584900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - Actionlist - Set Event Phase 2'),
(2584900, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 12, 26040, 1, 13000, 0, 0, 0, 8, 0, 0, 0, 0, 3481.33, 4099.85, 17.839, 3.35103, 'Fezzix Geartwist - Actionlist - Summon Creature \'Fezzix\'s Flying Machine\''),
(2584900, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 14, 60069, 188087, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - Actionlist - Set Data 0 1'),
(2584900, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 14, 60080, 188088, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - Actionlist - Set Data 0 1'),
(2584900, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 14, 60095, 188089, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - Actionlist - Set Data 0 1'),
(2584900, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - Actionlist - Say Line 1'),
(2584900, 9, 6, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 0, 0, 43, 0, 22719, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - Actionlist - Mount To Model 22719'),
(2584900, 9, 7, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - Actionlist - Say Line 2'),
(2584900, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - Actionlist - Set Fly On'),
(2584900, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 25849, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - Actionlist - Start Waypoint Path 25849'),
(2584901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 46419, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - Actionlist - Cast \'Cosmetic - Explosion\''),
(2584901, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - Actionlist - Dismount'),
(2584901, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - Actionlist - Set Fly Off'),
(2584901, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 42963, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - Actionlist - Cast \'Cosmetic - Combat Knockdown Self\''),
(2584901, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - Actionlist - Say Line 3'),
(2584901, 9, 5, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fezzix Geartwist - Actionlist - Say Line 4');
