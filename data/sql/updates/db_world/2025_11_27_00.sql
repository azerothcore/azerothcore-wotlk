-- DB update 2025_11_26_06 -> 2025_11_27_00
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30474);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30474, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The North Wind - On Reset - Set Event Phase 1'),
(30474, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The North Wind - On Reset - Remove Flags Immune To Players'),
(30474, 0, 2, 0, 0, 1, 100, 0, 1000, 3000, 8000, 11000, 0, 0, 11, 61662, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'The North Wind - In Combat - Cast \'Cyclone\' (Phase 1)'),
(30474, 0, 3, 0, 0, 1, 100, 0, 1000, 8000, 12000, 16000, 0, 0, 11, 61663, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'The North Wind - In Combat - Cast \'Gust of Wind\' (Phase 1)'),
(30474, 0, 4, 0, 2, 0, 100, 1, 0, 20, 0, 0, 0, 0, 80, 3047400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The North Wind - Between 0-20% Health - Run Script (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3047400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3047400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The North Wind - Actionlist - Set Event Phase 2'),
(3047400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The North Wind - Actionlist - Stop Attack'),
(3047400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 117, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The North Wind - Actionlist - Disable Evade'),
(3047400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The North Wind - Actionlist - Set Faction 35'),
(3047400, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The North Wind - Actionlist - Set Flags Immune To Players'),
(3047400, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 46957, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The North Wind - Actionlist - Cast \'Cosmetic - Stun (Permanent)\''),
(3047400, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The North Wind - Actionlist - Say Line 0'),
(3047400, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 30388, 100, 0, 0, 0, 0, 0, 0, 'The North Wind - Actionlist - Say Line 0'),
(3047400, 9, 8, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The North Wind - Actionlist - Say Line 1'),
(3047400, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 30388, 100, 0, 0, 0, 0, 0, 0, 'The North Wind - Actionlist - Say Line 1'),
(3047400, 9, 10, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 56892, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The North Wind - Actionlist - Cast \'Drop Horn of Elemental Fury\''),
(3047400, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 46598, 0, 0, 0, 0, 0, 19, 30388, 100, 0, 0, 0, 0, 0, 0, 'The North Wind - Actionlist - Remove Aura \'Ride Vehicle Hardcoded\''),
(3047400, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 60000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The North Wind - Actionlist - Despawn In 60000 ms');

DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 30388) AND (`Index` IN (0, 2));
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(30388, 0, 56896, 12340),
(30388, 2, 56897, 12340);

-- eject forward and to the right
DELETE FROM `vehicle_seat_addon` WHERE `SeatEntry` = 2245;
INSERT INTO `vehicle_seat_addon` (`SeatEntry`, `SeatOrientation`, `ExitParamX`, `ExitParamY`, `ExitParamZ`, `ExitParamO`, `ExitParamValue`) VALUES
(2245, 0.0, 3.0, -4.0, 3.0, 0.0, 1);

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 194123);
UPDATE `gameobject_template` SET `AIName` = '' WHERE (`entry` = 194123);

-- Remove duplicate spawn of 'The North Wind'
DELETE FROM `creature` WHERE `guid` = 1955014 AND `id1` = 30474;
