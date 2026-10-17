-- DB update 2025_09_28_01 -> 2025_09_29_00

-- Update SmartAI (Bleeding Hollow Necrolyte and Tunneler)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (16968, 19422));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (16968, 19422));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19422, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2400, 3800, 0, 0, 11, 9053, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Necrolyte - In Combat - Cast \'Fireball\''),
(19422, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 30000, 45000, 0, 0, 11, 34073, 33, 0, 0, 0, 0, 5, 0, 0, 0, 34073, 0, 0, 0, 0, 'Bleeding Hollow Necrolyte - In Combat - Cast \'Curse of the Bleeding Hollow\''),
(19422, 0, 2, 0, 2, 0, 100, 512, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Necrolyte - Between 0-15% Health - Flee For Assist'),
(19422, 0, 3, 0, 5, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 34019, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Necrolyte - On Killed Unit - Cast \'Raise Dead\' (No Repeat)'),
(16968, 0, 0, 1, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - On Reset - Set Flags Not Selectable'),
(16968, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 29147, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - On Reset - Cast \'Tunnel Bore Passive\''),
(16968, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - On Reset - Set Flag Standstate Submerged'),
(16968, 0, 3, 4, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - On Aggro - Remove Flags Not Selectable'),
(16968, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 29147, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - On Aggro - Remove Aura \'Tunnel Bore Passive\''),
(16968, 0, 5, 0, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 91, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - On Aggro - Remove FlagStandstate Submerged'),
(16968, 0, 6, 0, 0, 0, 100, 0, 1000, 6000, 8000, 11000, 0, 0, 11, 32738, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - In Combat - Cast \'Bore\''),
(16968, 0, 7, 0, 9, 0, 100, 0, 0, 0, 2000, 3500, 4, 50, 11, 31747, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - Within 4-50 Range - Cast \'Poison\'');
