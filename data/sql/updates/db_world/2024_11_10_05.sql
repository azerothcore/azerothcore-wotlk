-- DB update 2024_11_10_04 -> 2024_11_10_05
--
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 24844;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24844) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24844, 0, 0, 1, 34, 0, 100, 0, 0, 6, 0, 0, 0, 0, 5, 293, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Reached Point 6 - Play Emote 293'),
(24844, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 207, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Reached Point 6 - Set hover 0'),
(24844, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 0, 2000, 2000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Reached Point 6 - Create Timed Event'),
(24844, 0, 3, 4, 59, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44762, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Timed Event 0 Triggered - Cast \'Camera Shake - Med\''),
(24844, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 227, 0.6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Timed Event 0 Triggered - Set Scale to 0.6%'),
(24844, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 1000, 1000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Timed Event 0 Triggered - Create Timed Event'),
(24844, 0, 6, 7, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 11, 46307, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Timed Event 1 Triggered - Cast \'Scrying Orb Kill Credit\''),
(24844, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 24085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Timed Event 1 Triggered - Cast \'Transform Visual\''),
(24844, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44670, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Timed Event 1 Triggered - Cast \'KalecgosTransform into Kalec\''),
(24844, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 36, 24848, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Timed Event 1 Triggered - Update Template To \'Kalecgos\''),
(24844, 0, 10, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kalecgos - On Reset - Say Line 0');
