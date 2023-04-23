-- DB update 2023_03_31_05 -> 2023_04_01_00
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (20867, -138927) AND `id` IN (3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20867, 0, 3, 4, 6, 0, 100, 0, 0, 0, 0, 0, 0, 28, 36657, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Just Died - Remove Aura \'Death Count\''),
(20867, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 28, 38818, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Just Died - Remove Aura \'Death Count\''),
(20867, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 28, 36657, 0, 0, 0, 0, 0, 9, 0, 0, 100, 0, 0, 0, 0, 0, 'Death Watcher - On Just Died - Remove Aura \'Death Count\''),
(20867, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 28, 38818, 0, 0, 0, 0, 0, 9, 0, 0, 100, 0, 0, 0, 0, 0, 'Death Watcher - On Just Died - Remove Aura \'Death Count\''),

(-138927, 0, 3, 4, 6, 0, 100, 0, 0, 0, 0, 0, 0, 28, 36657, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Just Died - Remove Aura \'Death Count\''),
(-138927, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 28, 38818, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Just Died - Remove Aura \'Death Count\''),
(-138927, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 28, 36657, 0, 0, 0, 0, 0, 9, 0, 0, 100, 0, 0, 0, 0, 0, 'Death Watcher - On Just Died - Remove Aura \'Death Count\''),
(-138927, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 28, 38818, 0, 0, 0, 0, 0, 9, 0, 0, 100, 0, 0, 0, 0, 0, 'Death Watcher - On Just Died - Remove Aura \'Death Count\'');
