-- DB update 2026_01_07_02 -> 2026_01_08_00
--
UPDATE `creature_summon_groups` SET `summonType` = 6, `summonTime` = 60000 WHERE `summonerId` = 32239 AND `summonerType` = 0 AND `groupId` = 1;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 32312);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32312, 0, 0, 0, 0, 0, 100, 0, 3000, 4000, 10000, 10000, 0, 0, 11, 58843, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - In Combat - Cast \'Plague Strike\''),
(32312, 0, 1, 0, 0, 0, 100, 0, 7000, 8000, 10000, 10000, 0, 0, 11, 59011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - In Combat - Cast \'Icy Touch\''),
(32312, 0, 2, 0, 1, 0, 100, 512, 3600, 3600, 3600, 3600, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 32239, 20, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - Out of Combat - Set Data 1 1');
