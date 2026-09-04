-- DB update 2026_08_07_03 -> 2026_08_07_04
--
DELETE FROM `waypoints` WHERE `entry` = 28182;

DELETE FROM `waypoint_data` WHERE `id` = 281820;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `smoothTransition`, `move_type`) VALUES
(281820, 1, 3138.284, 3836.4502, 23.855997, NULL, 0, 1, 1),
(281820, 2, 3161.0283, 3845.8699, 26.104483, NULL, 0, 1, 1),
(281820, 3, 3197.6423, 3844.5496, 28.894367, NULL, 0, 1, 1),
(281820, 4, 3240.9358, 3837.4001, 26.947998, NULL, 0, 1, 1),
(281820, 5, 3286.0344, 3832.1116, 26.765312, NULL, 0, 1, 1),
(281820, 6, 3314.7297, 3828.5247, 28.489101, NULL, 0, 1, 1),
(281820, 7, 3343.4626, 3825.5073, 24.872, NULL, 0, 1, 1),
(281820, 8, 3374.1536, 3817.4878, 26.240791, NULL, 0, 1, 1),
(281820, 9, 3399.5452, 3818.3586, 27.51474, NULL, 0, 1, 1),
(281820, 10, 3440.7595, 3828.7961, 28.035929, NULL, 0, 1, 1),
(281820, 11, 3464.9824, 3838.2666, 29.86587, NULL, 0, 1, 1),
(281820, 12, 3493.0493, 3843.1963, 32.623665, NULL, 0, 1, 1),
(281820, 13, 3532.0413, 3843.2734, 33.35426, NULL, 0, 1, 1),
(281820, 14, 3554.011, 3826.3604, 39.335087, NULL, 0, 1, 1),
(281820, 15, 3571.1467, 3806.4927, 39.678947, NULL, 0, 1, 1),
(281820, 16, 3574.3892, 3781.1829, 36.334305, NULL, 0, 1, 1),
(281820, 17, 3583.3992, 3758.6902, 36.302624, NULL, 0, 1, 1),
(281820, 18, 3597.051, 3736.6194, 36.51474, NULL, 0, 1, 1),
(281820, 19, 3605.6096, 3702.6047, 36.526268, NULL, 0, 1, 1),
(281820, 20, 3611.8079, 3676.5244, 36.383934, NULL, 5000, 0, 1),
(281820, 21, 3622.393, 3666.966, 35.5299, NULL, 0, 1, 0);

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_dusk' WHERE `entry` = 28182;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28182);

-- 'Dan's Eject All Passengers' Sniffed spell cast
DELETE FROM `spell_script_names` WHERE `spell_id` = 51254 AND `ScriptName` = 'spell_gen_eject_all_passengers';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(51254, 'spell_gen_eject_all_passengers');

DELETE FROM `creature_text` WHERE (`CreatureID` = 28182);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(28182, 0, 0, '%s motions toward the icy water below.', 16, 0, 100, 0, 0, 0, 29446, 0, 'Dusk - Finding the Phylactery');

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 188141;
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 188141);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(188141, 1, 0, 0, 71, 0, 100, 0, 17430, 0, 0, 0, 0, 0, 107, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frozen Phylactery - On Event 17430 Inform - Summon Creature Group');

DELETE FROM `event_scripts` WHERE `id` = 17430;

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 188141 AND `summonerType` = 1 AND `groupId` = 0;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(188141, 1, 0, 26224, 3621.1597, 3648.702, 24.475744, 3.04438328742980957, 4, 60000, 'Frozen Phylactery - Drowned Guardian'),
(188141, 1, 0, 26224, 3615.5735, 3644.4353, 24.697205, 1.514552116394042968, 4, 60000, 'Frozen Phylactery - Drowned Guardian'),
(188141, 1, 0, 26224, 3614.929, 3650.7393, 24.34017, 5.270894527435302734, 4, 60000, 'Frozen Phylactery - Drowned Guardian'),
(188141, 1, 0, 26225, 3616.2922, 3647.6338, 24.34017, 3.193952560424804687, 4, 60000, 'Frozen Phylactery - Phylactery Guardian');

UPDATE `creature_template` SET `unit_flags` = `unit_flags`|256 WHERE (`entry` = 26225);
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26225;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26225);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26225, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2622500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phylactery Guardian - On Just Summoned - Run Script'),
(26225, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Phylactery Guardian - On Aggro - Say Line');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2622500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2622500, 9, 0, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phylactery Guardian - Actionlist - Remove Flags Immune To Players'),
(2622500, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 0, 'Phylactery Guardian - Actionlist - Start Attacking');

DELETE FROM `creature_text` WHERE (`CreatureID` = 26225);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(26225, 0, 0, 'The phylactery is not yours to take, $n!  You will pay for your transgression.', 12, 0, 100, 0, 0, 0, 25377, 0, 'Phylactery Guardian');
