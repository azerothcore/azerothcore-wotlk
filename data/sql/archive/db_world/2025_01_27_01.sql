-- DB update 2025_01_27_00 -> 2025_01_27_01
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |134217728 WHERE `entry` IN (24698, 24684, 24697, 24696, 24683, 24686);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = -96841) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-96841, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 0, 0, 0, 0, 0, 0, 205, 3, 1, 0, 0, 0, 0, 0, 0, 'Coilskar Witch - On Just Died - Felblood Kaeltas Do Action ID 0');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = -96781) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-96781, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 0, 0, 0, 0, 0, 0, 205, 3, 1, 0, 0, 0, 0, 0, 0, 'Sunblade Blood Knight - On Just Died - Felblood Kaeltas Do Action ID 0');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = -96809) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-96809, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 0, 0, 0, 0, 0, 0, 205, 3, 1, 0, 0, 0, 0, 0, 0, 'Sunblade Warlock - On Just Died - Felblood Kaeltas Do Action ID 0');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = -96770) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-96770, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 0, 0, 0, 0, 0, 0, 205, 3, 1, 0, 0, 0, 0, 0, 0, 'Sunblade Mage Guard - On Just Died - Felblood Kaeltas Do Action ID 0');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = -96850) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-96850, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 0, 0, 0, 0, 0, 0, 205, 3, 1, 0, 0, 0, 0, 0, 0, 'Ethereum Smuggler - On Just Died - Felblood Kaeltas Do Action ID 0');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = -96847) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-96847, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 0, 0, 0, 0, 0, 0, 205, 3, 1, 0, 0, 0, 0, 0, 0, 'Sister of Torment - On Just Died - Felblood Kaeltas Do Action ID 0');
