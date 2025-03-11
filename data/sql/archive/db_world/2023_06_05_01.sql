-- DB update 2023_06_05_00 -> 2023_06_05_01
-- Archaedas (Uldaman) SAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 2748);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2748, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Reset - Cast Stoned'),
(2748, 0, 1, 2, 38, 0, 100, 0, 1, 1, 0, 0, 0, 11, 10347, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Data Set - Cast Archaedas Awaken Visual (DND)'),
(2748, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 67, 1, 4000, 4000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Data Set - Create Timed Event'),
(2748, 0, 3, 4, 59, 0, 100, 512, 1, 0, 0, 0, 0, 28, 10255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Timed Event - Remove Aura Stoned'),
(2748, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 80, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Timed Event - Attack Start'),
(2748, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Aggro - Say Line 0'),
(2748, 0, 6, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Kill - Say Line 3'),
(2748, 0, 7, 8, 2, 0, 100, 1, 0, 70, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - Health Between 0-70% - Say Line 1'),
(2748, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 10252, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - Health Between 0-70% - Cast Awaken Earthen Guardian'),
(2748, 0, 9, 10, 2, 0, 100, 1, 0, 40, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - Health Between 0-40% - Say Line 2'),
(2748, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 10258, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - Health Between 0-40% - Cast Awaken Vault Warder'),
(2748, 0, 11, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 0, 11, 10259, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - In Combat - Awaken Earthen Dwarf'),
(2748, 0, 12, 0, 0, 0, 100, 0, 0, 10000, 14000, 20000, 0, 11, 6524, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - In Combat - Cast Ground Tremor'),
(2748, 0, 13, 14, 60, 0, 100, 769, 1000, 1000, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 11, 7076, 100, 0, 0, 0, 0, 0, 0, 'Archaedas - On Update - Store Target List (Earthen Guardian)'),
(2748, 0, 14, 15, 61, 0, 100, 512, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 11, 10120, 100, 0, 0, 0, 0, 0, 0, 'Archaedas - On Update - Store Target List (Vault Warder)'),
(2748, 0, 15, 16, 61, 0, 100, 512, 0, 0, 0, 0, 0, 64, 3, 0, 0, 0, 0, 0, 11, 7077, 100, 0, 0, 0, 0, 0, 0, 'Archaedas - On Update - Store Target List (Earthen Hellshaper)'),
(2748, 0, 16, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 64, 4, 0, 0, 0, 0, 0, 11, 7309, 100, 0, 0, 0, 0, 0, 0, 'Archaedas - On Update - Store Target List (Earthen Custodian)'),
(2748, 0, 17, 18, 25, 0, 100, 512, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Reset - Respawn Target'),
(2748, 0, 18, 19, 61, 0, 100, 512, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Reset - Respawn Target'),
(2748, 0, 19, 20, 61, 0, 100, 512, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Reset - Respawn Target'),
(2748, 0, 20, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Reset - Respawn Target'),
(2748, 0, 21, 0, 21, 0, 100, 512, 0, 0, 0, 0, 0, 34, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - Just Reached Home - Set Instance Data'),
(2748, 0, 22, 23, 6, 0, 100, 512, 0, 0, 0, 0, 0, 34, 2, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Death - Set Instance Data'),
(2748, 0, 23, 25, 61, 0, 100, 512, 0, 0, 0, 0, 0, 11, 10604, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - On Death - Cast Destroy Earthen Guards'),
(2748, 0, 24, 0, 31, 0, 100, 512, 10604, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaedas - Spell Hit Target - Despawn'),
(2748, 0, 25, 26, 61, 0, 100, 512, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 9, 10120, 0, 100, 0, 0, 0, 0, 0, 'Archaedas - On Just Died - Despawn Vault Warders'),
(2748, 0, 26, 27, 61, 0, 100, 512, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 9, 7076, 0, 100, 0, 0, 0, 0, 0, 'Archaedas - On Just Died - Despawn Earthen Guardians'),
(2748, 0, 27, 28, 61, 0, 100, 512, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 9, 7077, 0, 100, 0, 0, 0, 0, 0, 'Archaedas - On Just Died - Despawn Earthen Hallshapers'),
(2748, 0, 28, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 9, 7309, 0, 100, 0, 0, 0, 0, 0, 'Archaedas - On Just Died - Despawn Earthen Custodians');

