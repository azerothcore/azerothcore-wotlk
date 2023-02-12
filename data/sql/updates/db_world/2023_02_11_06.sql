-- DB update 2023_02_11_05 -> 2023_02_11_06
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16425);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16425, 0, 0, 0, 0, 0, 100, 0, 20000, 60000, 40000, 60000, 0, 11, 29537, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phantom Guardsman - In Combat - Cast \'Summon Phantom Hound\''),
(16425, 0, 1, 0, 0, 0, 100, 0, 15000, 16000, 15000, 16000, 0, 11, 29684, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Phantom Guardsman - In Combat - Cast \'Shield Slam\''),
(16425, 0, 2, 0, 4, 0, 30, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phantom Guardsman - On Aggro - Say Line 0'),
(16425, 0, 3, 0, 6, 0, 30, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phantom Guardsman - On Just Died - Say Line 1');

DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 17067;
