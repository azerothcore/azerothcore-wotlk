-- DB update 2025_02_15_01 -> 2025_02_15_02
UPDATE `creature_template` SET `ScriptName`='', `AIName` = 'SmartAI' WHERE (`entry` = 28591);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28591) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28591, 0, 0, 1, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghoul Feeding KC Bunny - On Respawn - Store Targetlist'),
(28591, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 28565, 30, 0, 0, 0, 0, 0, 0, 'Ghoul Feeding KC Bunny - On Respawn - Send Target 1'),
(28591, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 28591, 0, 0, 0, 0, 0, 19, 28565, 30, 0, 0, 0, 0, 0, 0, 'Ghoul Feeding KC Bunny - On Respawn - Set Data 28591 0'),
(28591, 0, 3, 4, 38, 0, 100, 1, 28565, 0, 0, 0, 0, 0, 11, 52030, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghoul Feeding KC Bunny - On Data Set 28565 0 - Cast \'Kill Credit\' (No Repeat)'),
(28591, 0, 4, 5, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghoul Feeding KC Bunny - On Data Set 28565 0 - Despawn Instant (No Repeat)'),
(28591, 0, 5, 0, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 20, 190656, 5, 0, 0, 0, 0, 0, 0, 'Ghoul Feeding KC Bunny - On Data Set 28565 0 - Despawn In 3000 ms (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28565) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28565, 0, 0, 0, 38, 0, 100, 0, 28591, 0, 40000, 40000, 0, 0, 69, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Decaying Ghoul - On Data Set 28591 0 - Move To Stored'),
(28565, 0, 1, 2, 34, 0, 100, 512, 8, 1, 0, 0, 0, 0, 45, 28565, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Decaying Ghoul - On Reached Point 1 - Set Data 28565 0'),
(28565, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 5, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Decaying Ghoul - On Reached Point 1 - Play Emote 7');
