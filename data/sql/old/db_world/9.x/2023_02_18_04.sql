-- DB update 2023_02_18_03 -> 2023_02_18_04
-- Dragonmaw Bonewarder - spawn Skeleton on reset
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1057;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 1057);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1057, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8853, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Bonewarder - On Reset - Cast \'Summon Skeleton\''),
(1057, 0, 1, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 11, 13787, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Bonewarder - On Aggro - Cast \'Demon Armor\' (No Repeat)'),
(1057, 0, 2, 0, 0, 0, 100, 0, 3000, 4000, 120000, 120000, 0, 11, 6205, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Bonewarder - In Combat - Cast \'Curse of Weakness\''),
(1057, 0, 3, 0, 0, 0, 100, 0, 5000, 6000, 15000, 15000, 0, 11, 707, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Bonewarder - In Combat - Cast \'Immolate\'');

-- Skeleton (Dragonmaw Bonewarder's pet) - force despawn on death
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6412;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 6412);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6412, 0, 0, 0, 6, 0, 100, 513, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeleton - On Just Died - Despawn In 1000 ms (No Repeat)');
