-- DB update 2023_04_15_00 -> 2023_04_17_00
--
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (18708, 20657);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Rooted`, `Flight`) VALUES
(18708, 1, 1, 1),
(20657, 1, 1, 1);

DELETE FROM `spell_script_names` WHERE `spell_id` = 33711;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(33711, 'spell_murmur_touch');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = -146210) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-146210, 0, 1, 0, 58, 0, 100, 0, 8, 1863400, 0, 0, 0, 225, 0, 1, 0, 0, 0, 0, 10, 146104, 18708, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - On Waypoint Finished - Send GUID to Murmur');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -146209 AND `id` = 4);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-146209, 0, 4, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 225, 0, 1, 0, 0, 0, 0, 10, 146104, 18708, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - On Reached Point 1 - Send GUID to Murmur'); -- This is a hack as it will trigger spell 33331 instead of 33329

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceEntry` = 33329);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 33329, 0, 0, 31, 0, 3, 18639, 146225, 0, 0, 0, '', 'Murmur\'s Wrath (33329) only targets a set of guids'),
(13, 1, 33329, 0, 1, 31, 0, 3, 18634, 146226, 0, 0, 0, '', 'Murmur\'s Wrath (33329) only targets a set of guids'),
(13, 1, 33329, 0, 2, 31, 0, 3, 18639, 146227, 0, 0, 0, '', 'Murmur\'s Wrath (33329) only targets a set of guids'),
(13, 1, 33329, 0, 3, 31, 0, 3, 18634, 146228, 0, 0, 0, '', 'Murmur\'s Wrath (33329) only targets a set of guids'),
(13, 1, 33329, 0, 4, 31, 0, 3, 18639, 146229, 0, 0, 0, '', 'Murmur\'s Wrath (33329) only targets a set of guids');
