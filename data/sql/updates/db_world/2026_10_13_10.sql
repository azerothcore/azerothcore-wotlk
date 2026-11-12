-- DB update 2026_10_13_09 -> 2026_10_13_10
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|134217728 WHERE (`entry` = 16870);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-58200, -58201, -58202, -58203));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-58200, 0, 0, 0, 1, 0, 100, 0, 2400, 3600, 2400, 3600, 0, 0, 5, 37, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Out of Combat - Play Emote 37'),
(-58201, 0, 0, 0, 1, 0, 100, 0, 2400, 3600, 2400, 3600, 0, 0, 5, 37, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Out of Combat - Play Emote 37'),
(-58202, 0, 0, 0, 1, 0, 100, 0, 2400, 3600, 2400, 3600, 0, 0, 5, 37, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Out of Combat - Play Emote 37'),
(-58203, 0, 0, 0, 1, 0, 100, 0, 2400, 3600, 2400, 3600, 0, 0, 5, 37, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Captain - Out of Combat - Play Emote 37');
