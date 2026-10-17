-- DB update 2025_02_13_00 -> 2025_02_13_01
--
DELETE FROM `creature_text` WHERE `CreatureID` = 24844 AND `GroupID` = 1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(24844, 1, 0, 'Madrigosa deserved a far better fate. You did what had to be done, but this battle is far from over!', 14, 0, 100, 25261, 3, 'Kalecgos (SWP) - SAY_KALECGOS_MADRIGOSA');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24844);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24844, 0, 0, 1, 34, 0, 100, 0, 0, 6, 0, 0, 0, 0, 5, 293, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Reached Point 6 - Play Emote 293'),
(24844, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 207, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Reached Point 6 - Set hover 0'),
(24844, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 0, 2000, 2000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Reached Point 6 - Create Timed Event'),
(24844, 0, 3, 4, 59, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44762, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Timed Event 0 Triggered - Cast \'Camera Shake - Med\''),
(24844, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 227, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Timed Event 0 Triggered - Set Scale to 1%'),
(24844, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 1000, 1000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Timed Event 0 Triggered - Create Timed Event'),
(24844, 0, 6, 7, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 11, 46307, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Timed Event 1 Triggered - Cast \'Scrying Orb Kill Credit\''),
(24844, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Timed Event 1 Triggered - Cast \'Transform Visual\''),
(24844, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44670, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Timed Event 1 Triggered - Cast \'KalecgosTransform into Kalec\''),
(24844, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 36, 24848, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Timed Event 1 Triggered - Update Template To \'Kalecgos\''),
(24844, 0, 10, 11, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Reached Point 1 - Say Line 1'),
(24844, 0, 11, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 67, 2, 4000, 4000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Reached Point 1 - Create Timed Event'),
(24844, 0, 12, 0, 59, 0, 100, 0, 2, 0, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1511.65, 550.702, 25.5101, 0, 'Kalecgos - On Timed Event 2 Triggered - Move To Self'),
(24844, 0, 13, 14, 34, 0, 100, 0, 8, 2, 0, 0, 0, 0, 11, 46650, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Reached Point 2 - Cast \'Open Brutallus Back Door\''),
(24844, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 3, 4000, 4000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Reached Point 2 - Create Timed Event'),
(24844, 0, 15, 0, 59, 0, 100, 0, 3, 0, 0, 0, 0, 0, 69, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1648.26, 519.377, 165.848, 0, 'Kalecgos - On Timed Event 3 Triggered - Move To Self'),
(24844, 0, 16, 0, 34, 0, 100, 0, 8, 3, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Reached Point 3 - Despawn Instant');
