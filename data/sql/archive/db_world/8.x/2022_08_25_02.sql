-- DB update 2022_08_25_01 -> 2022_08_25_02
--
UPDATE `creature_template` SET `DamageModifier`=2.35, `ArmorModifier`=1.1, `AIName`='SmartAI' WHERE `entry`=14668;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14668) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14668, 0, 0, 0, 0, 0, 100, 0, 3000, 3000, 3000, 3000, 0, 11, 20153, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Infernal - In Combat - Cast \'Immolation\''),
(14668, 0, 1, 0, 0, 0, 100, 0, 2000, 5000, 10000, 12000, 0, 11, 22703, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Infernal - In Combat - Cast \'Inferno Effect\'');
