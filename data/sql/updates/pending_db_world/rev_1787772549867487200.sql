-- Alystros the Verdant Keeper
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27249) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27249, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 6000, 9000, 0, 0, 11, 51937, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - In Combat - Cast \'Talon Strike\' (Phase 1) (No Repeat)'),
(27249, 0, 1, 0, 106, 0, 100, 0, 16000, 21000, 16000, 21000, 0, 5, 11, 51938, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - Within 0-5 Range - Cast \'Wing Beat\' (Phase 1) (No Repeat)'),
(27249, 0, 2, 0, 0, 0, 100, 0, 2500, 4000, 17000, 21000, 0, 0, 12, 15214, 3, 16000, 0, 0, 0, 5, 0, 1, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - In Combat - Summon Invisible Stalker At Random Player'),
(27249, 0, 3, 4, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - On Data Set - Set Emote State None'),
(27249, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - On Data Set - Set Unit Flags'),
(27249, 0, 5, 6, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 4, 3605, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - On Data Set - Play Sound 3605'),
(27249, 0, 6, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - On Data Set - Attack'),
(27249, 0, 7, 0, 17, 0, 100, 0, 15214, 0, 0, 0, 0, 0, 80, 2724900, 2, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - On Invisible Stalker Summoned - Run Lapsing Dream Actionlist');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15214) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15214, 0, 0, 0, 59, 0, 100, 0, 27249, 0, 0, 0, 0, 0, 75, 51928, 0, 0, 0, 0, 0, 18, 8, 0, 0, 0, 0, 0, 0, 0, 'Invisible Stalker - On Lapsing Dream Timed Event - Apply Lapsing Dream To Players Within 8 Yards');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2724900) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2724900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51922, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - Actionlist - Cast Lapsing Dream Smoke'),
(2724900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 27249, 0, 0, 500, 500, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - Actionlist - Create Lapsing Dream Timed Event');
