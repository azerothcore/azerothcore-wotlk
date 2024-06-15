-- DB update 2022_12_02_00 -> 2022_12_02_01
--
UPDATE `creature` SET `curmana` = 0 WHERE `id1` = 20196;
UPDATE `creature_template` SET `unit_flags2` = `unit_flags2`&~2048 WHERE (`entry` = 20196);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 20196) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20196, 0, 0, 0, 0, 0, 100, 0, 6000, 18000, 8000, 14000, 0, 11, 17008, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodthirsty Marshfang - In Combat - Cast \'Drain Mana\''),
(20196, 0, 1, 0, 0, 0, 100, 0, 10000, 12000, 10000, 12000, 0, 11, 35335, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodthirsty Marshfang - In Combat - Cast \'Nether Leech\''),
(20196, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 108, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodthirsty Marshfang - On Reset - Set Mana To 0');

UPDATE `creature` SET `curmana` = 0 WHERE `id1` = 18285;
UPDATE `creature_template` SET `unit_flags2` = `unit_flags2`&~2048 WHERE (`entry` = 18285);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18285) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18285, 0, 1, 0, 0, 0, 100, 0, 6000, 18000, 8000, 14000, 0, 11, 17008, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, '\'Count\' Ungula - In Combat - Cast \'Drain Mana\''),
(18285, 0, 2, 0, 0, 0, 100, 0, 10000, 12000, 10000, 12000, 0, 11, 35335, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, '\'Count\' Ungula - In Combat - Cast \'Nether Leech\''),
(18285, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 108, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '\'Count\' Ungula - On Reset - Set Mana To 0');
