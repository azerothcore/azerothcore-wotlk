-- DB update 2022_11_27_00 -> 2022_12_02_00
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18130) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18130, 0, 0, 0, 0, 0, 75, 0, 3000, 3000, 9000, 9000, 0, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshfang Ripper - In Combat - Cast \'Tendon Rip\''),
(18130, 0, 1, 0, 0, 0, 75, 0, 1000, 1000, 10000, 15000, 0, 11, 17008, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshfang Ripper - In Combat - Cast \'Drain Mana\''),
(18130, 0, 2, 0, 0, 0, 100, 0, 3000, 3000, 3000, 6000, 0, 11, 33860, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshfang Ripper - In Combat - Cast \'Arcane Explosion\''),
(18130, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 108, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshfang Ripper - On Reset - Set Mana To 0');

UPDATE `creature_template` SET `unit_flags2` = `unit_flags` &~ 2048 WHERE `entry` = 18130;

UPDATE `creature` SET `curmana` = 0 WHERE `id1` = 18130;
