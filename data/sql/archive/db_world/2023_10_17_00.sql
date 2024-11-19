-- DB update 2023_10_16_04 -> 2023_10_17_00
-- Move Mindless Skeletons (11197) created by Baron Rivendare (10440)
-- to more accurate locations based on sniffed data.
DELETE FROM `spell_target_position` WHERE `ID`=17475 AND `EffectIndex`=0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES (17475, 0, 329, 4012.92, -3365.70, 116.251, 0.745, 50664);
DELETE FROM `spell_target_position` WHERE `ID`=17476 AND `EffectIndex`=0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES (17476, 0, 329, 4009.10, -3352.31, 116.712, 0.299, 50664);
DELETE FROM `spell_target_position` WHERE `ID`=17477 AND `EffectIndex`=0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES (17477, 0, 329, 4013.96, -3338.65, 116.242, 6.094, 50664);
DELETE FROM `spell_target_position` WHERE `ID`=17478 AND `EffectIndex`=0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES (17478, 0, 329, 4051.75, -3339.05, 116.241, 3.340, 50664);
DELETE FROM `spell_target_position` WHERE `ID`=17479 AND `EffectIndex`=0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES (17479, 0, 329, 4055.96, -3351.46, 116.586, 2.870, 50664);
DELETE FROM `spell_target_position` WHERE `ID`=17480 AND `EffectIndex`=0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES (17480, 0, 329, 4053.11, -3364.98, 116.402, 2.287, 50664);

-- Additionally, cause the Baron to despawn his summoned Mindless Skeletons
-- when he is reset.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10440;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 10440);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10440, 0, 0, 0, 0, 0, 100, 0, 4000, 9000, 7000, 11000, 0, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast \'Cleave\''),
(10440, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 6000, 9000, 0, 0, 11, 17393, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast \'Shadow Bolt\''),
(10440, 0, 2, 0, 0, 0, 100, 0, 7000, 11000, 9000, 15000, 0, 0, 11, 15708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast \'Mortal Strike\''),
(10440, 0, 3, 0, 0, 0, 100, 513, 0, 0, 0, 0, 0, 0, 11, 17467, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast \'Unholy Aura\' (No Repeat)'),
(10440, 0, 4, 5, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 0, 0, 11, 17473, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast \'Raise Dead\''),
(10440, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Say Line 7'),
(10440, 0, 6, 0, 0, 0, 100, 0, 22000, 22000, 20000, 20000, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Say Line 8'),
(10440, 0, 7, 8, 0, 0, 100, 512, 11000, 11000, 20000, 20000, 0, 0, 11, 17475, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast \'Raise Dead\''),
(10440, 0, 8, 9, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 17476, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast \'Raise Dead\''),
(10440, 0, 9, 10, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 17477, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast \'Raise Dead\''),
(10440, 0, 10, 11, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 17478, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast \'Raise Dead\''),
(10440, 0, 11, 12, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 17479, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast \'Raise Dead\''),
(10440, 0, 12, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 17480, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast \'Raise Dead\''),
(10440, 0, 13, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 16031, 100, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - On Just Died - Free Prisoner'),
(10440, 0, 14, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 14, 35848, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - On Aggro - Set GO State To 1'),
(10440, 0, 15, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 14, 35848, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - On Just Died - Set GO State To 0'),
(10440, 0, 16, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 14, 35848, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - On Reset - Set GO State To 0'),
(10440, 0, 17, 18, 0, 0, 100, 512, 1000, 1000, 100, 100, 0, 0, 118, 0, 0, 0, 0, 0, 0, 14, 35848, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Set GO State To 0'),
(10440, 0, 18, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Evade'),
(10440, 0, 19, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 204, 11197, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - On Reset - Kill Summoned Creatures');

