--
DELETE FROM `creature` WHERE (`id1` = 14693);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4543) AND (`source_type` = 0) AND (`id` IN (7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4543, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 14693, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1797.84, 1233.68, 18.3153, 1.58286, 'Bloodmage Thalnos - On Just Died - Summon Creature \'Scorn\'');
