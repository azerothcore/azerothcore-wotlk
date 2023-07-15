-- DB update 2023_07_10_01 -> 2023_07_10_02
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17256);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17256, 0, 0, 0, 0, 0, 100, 0, 20900, 28200, 12100, 19400, 0, 11, 30510, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - In Combat - Cast \'Shadow Bolt Volley\''),
(17256, 0, 1, 0, 74, 0, 100, 0, 0, 50, 14500, 15000, 30, 11, 30528, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - On Friendly Between 0-50% Health - Cast \'Dark Mending\''),
(17256, 0, 2, 0, 0, 0, 100, 0, 6000, 12000, 17000, 28000, 0, 11, 30530, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - In Combat - Cast \'Fear\''),
(17256, 0, 3, 0, 0, 0, 100, 0, 19650, 63350, 60000, 60000, 0, 11, 30511, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - In Combat - Cast \'Burning Abyssal\''),
(17256, 0, 4, 0, 1, 0, 100, 0, 3600, 3600, 3600, 3600, 0, 11, 30207, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - Out of Combat - Cast \'Shadow Grasp\''),
(17256, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 30531, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - On Just Died - Cast \'Soul Transfer\''),
(17256, 0, 6, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 34, 10, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - On Aggro - Set Instance Data 10 to 1'),
(17256, 0, 7, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - On Reset - Set Reactstate Defensive');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18829);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18829, 0, 0, 0, 0, 0, 100, 0, 10050, 26400, 13350, 23100, 0, 11, 39175, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - In Combat - Cast \'Shadow Bolt Volley\''),
(18829, 0, 1, 0, 0, 0, 100, 0, 10600, 16100, 12100, 26700, 0, 11, 34437, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - In Combat - Cast \'Death Coil\''),
(18829, 0, 2, 0, 0, 0, 100, 0, 8200, 8800, 12150, 19450, 0, 11, 34435, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - In Combat - Cast \'Rain of Fire\''),
(18829, 0, 3, 0, 0, 0, 100, 0, 8200, 8800, 18200, 30350, 0, 11, 34436, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - In Combat - Cast \'Shadow Burst\''),
(18829, 0, 4, 0, 0, 0, 100, 0, 19750, 25200, 8500, 18200, 0, 11, 34439, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - In Combat - Cast \'Unstable Affliction\''),
(18829, 0, 5, 0, 0, 0, 100, 0, 10600, 16100, 26700, 29100, 0, 11, 34441, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - In Combat - Cast \'Shadow Word: Pain\''),
(18829, 0, 6, 0, 31, 0, 100, 512, 34439, 0, 0, 0, 0, 13, 0, 100, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - On Target Spellhit \'Unstable Affliction\' - Reset Threat');
