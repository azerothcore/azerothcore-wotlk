-- DB update 2025_02_09_04 -> 2025_02_10_00
--
DELETE FROM `spell_custom_attr` WHERE `spell_id`=46305;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (46305, 4194304);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25948) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25948, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 46305, 2, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomfire Shard - On Just Died - Cast \'Avenging Rage\'');
