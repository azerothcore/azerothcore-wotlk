-- DB update 2023_05_28_02 -> 2023_05_28_03
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-151090,-151091,-151092,-151093)) AND (`source_type` = 0) AND (`id` IN (1000));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-151090, 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 18, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hack: Fel Orc Convert - On Respawn - Set Flags Not Attackable'),
(-151091, 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 18, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hack: Fel Orc Convert - On Respawn - Set Flags Not Attackable'),
(-151092, 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 18, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hack: Fel Orc Convert - On Respawn - Set Flags Not Attackable'),
(-151093, 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 18, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hack: Fel Orc Convert - On Respawn - Set Flags Not Attackable');

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|134217728 WHERE (`entry` IN (17083, 20567));
