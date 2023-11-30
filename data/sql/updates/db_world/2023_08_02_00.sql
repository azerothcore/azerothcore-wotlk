-- DB update 2023_08_01_00 -> 2023_08_02_00
--
-- mechanical immunities changes
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|2|16|64|256|512|1024|2048|4096|8192|131072|524288|4194304|8388608|33554432, `flags_extra` = `flags_extra`|256 WHERE `entry` = 16414;

-- smart scripts changes
DELETE FROM `smart_scripts` WHERE `entryorguid` = 16414 AND `source_type` = 0;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16414, 0, 0, 0, 4, 0, 30, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Steward - On Aggro - Say Line 0'),
(16414, 0, 1, 0, 6, 0, 50, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Steward - On Death - Say Line 1'),
(16414, 0, 2, 3, 0, 0, 100, 0, 2000, 11000, 12000, 21000, 0, 11, 29690, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Steward - In Combat - Cast Drunken Skull Crack'),
(16414, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Steward - In Combat - Say Line 2'),
(16414, 0, 4, 5, 2, 0, 100, 1, 0, 50, 0, 0, 0, 11, 29691, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Steward - At Health 50% - Cast Frenzy'),
(16414, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Steward - At Health 50% - Say Line 3'),
(16414, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 14, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Steward - At Health 50% - Wipe Raid Threat');
