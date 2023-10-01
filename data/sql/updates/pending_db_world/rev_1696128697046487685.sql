-- Move Mindless Skeletons (11197) created by Baron Rivendare (10440)
-- to safe spots where they will not fall through the floor.
DELETE FROM `spell_target_position` WHERE `ID`=17475 AND `EffectIndex`=0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES (17475, 0, 329, 4050.39, -3363.61, 115.05, 2.48, 0);
DELETE FROM `spell_target_position` WHERE `ID`=17476 AND `EffectIndex`=0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES (17476, 0, 329, 4052.56, -3350.93, 115.05, 3.11, 0);
DELETE FROM `spell_target_position` WHERE `ID`=17477 AND `EffectIndex`=0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES (17477, 0, 329, 4048.98, -3339.65, 115.06, 3.74, 0);
DELETE FROM `spell_target_position` WHERE `ID`=17478 AND `EffectIndex`=0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES (17478, 0, 329, 4016.50, -3340.00, 115.06, 5.71, 0);
DELETE FROM `spell_target_position` WHERE `ID`=17479 AND `EffectIndex`=0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES (17479, 0, 329, 4012.95, -3352.47, 115.05, 0.10, 0);
DELETE FROM `spell_target_position` WHERE `ID`=17480 AND `EffectIndex`=0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES (17480, 0, 329, 4015.36, -3363.66, 115.06, 0.66, 0);

-- Since skeletons are slightly closer to the center, adjust Baron
-- Riverdare's (10440) SAI to wait 250ms longer between casts to
-- maintain approximately the same difficulty.
--
-- Additionally, cause the Baron to kill his summoned Mindless Skeletons
-- when reset.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10440;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 10440);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10440, 0, 0, 0, 0, 0, 100, 0, 4000, 9000, 7000, 11000, 0, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Every 7 - 11 seconds (4 - 9s initially) - Self: Cast spell 15284 on Victim'),
(10440, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 6000, 9000, 0, 0, 11, 17393, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Every 6 - 9 seconds (1 - 6s initially) - Self: Cast spell 17393 on Victim'),
(10440, 0, 2, 0, 0, 0, 100, 0, 7000, 11000, 9000, 15000, 0, 0, 11, 15708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Every 9 - 15 seconds (7 - 11s initially) - Self: Cast spell 15708 on Victim'),
(10440, 0, 3, 0, 0, 0, 100, 513, 0, 0, 0, 0, 0, 0, 11, 17467, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Once - Self: Cast spell 17467 on Self (flags: triggered)'),
(10440, 0, 4, 5, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 0, 0, 11, 17473, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (10s initially) - Self: Cast spell 17473 on Self'),
(10440, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (10s initially) - Self: Talk 7 to invoker'),
(10440, 0, 6, 0, 0, 0, 100, 0, 22000, 22000, 20000, 20000, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (22s initially) - Self: Talk 8 to invoker'),
(10440, 0, 7, 8, 0, 0, 100, 512, 11000, 11000, 20250, 20250, 0, 0, 11, 17475, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (11s initially) - Self: Cast spell 17475 on Self (flags: triggered)'),
(10440, 0, 8, 9, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 17476, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (11s initially) - Self: Cast spell 17476 on Self (flags: triggered)'),
(10440, 0, 9, 10, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 17477, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (11s initially) - Self: Cast spell 17477 on Self (flags: triggered)'),
(10440, 0, 10, 11, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 17478, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (11s initially) - Self: Cast spell 17478 on Self (flags: triggered)'),
(10440, 0, 11, 12, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 17479, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (11s initially) - Self: Cast spell 17479 on Self (flags: triggered)'),
(10440, 0, 12, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 17480, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (11s initially) - Self: Cast spell 17480 on Self (flags: triggered)'),
(10440, 0, 13, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 16031, 100, 0, 0, 0, 0, 0, 0, 'On death - Closest alive creature Ysida Harmon (16031) in 100 yards: Set creature data #2 to 2'),
(10440, 0, 14, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 14, 35848, 0, 0, 0, 0, 0, 0, 0, 'On aggro - Gameobject with guid 35848: Set gameobject state to ready'),
(10440, 0, 15, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 14, 35848, 0, 0, 0, 0, 0, 0, 0, 'On death - Gameobject with guid 35848: Set gameobject state to active'),
(10440, 0, 16, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 14, 35848, 0, 0, 0, 0, 0, 0, 0, 'On reset - Gameobject with guid 35848: Set gameobject state to active'),
(10440, 0, 17, 18, 0, 0, 100, 512, 1000, 1000, 100, 100, 0, 0, 118, 0, 0, 0, 0, 0, 0, 14, 35848, 0, 0, 0, 0, 0, 0, 0, 'Every 0.1 seconds (1s initially) - Gameobject with guid 35848: Set gameobject state to active'),
(10440, 0, 18, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Every 0.1 seconds (1s initially) - Self: Evade'),
(10440, 0, 19, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 204, 11197, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - On Reset - Kill Summoned Creatures');
