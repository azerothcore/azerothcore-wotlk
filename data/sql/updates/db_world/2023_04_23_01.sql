-- DB update 2023_04_23_00 -> 2023_04_23_01
DELETE FROM `creature_text` WHERE `CreatureID` = 17083;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
-- Shadow Sear
(17083, 0, 0, 'It hurt!', 14, 0, 100, 18, 0, 0, 14136, 0, 'Fel Orc Convert - Hit by Shadow Sear'),
(17083, 0, 1, 'Augh! No more hurt!', 14, 0, 100, 18, 0, 0, 14137, 0, 'Fel Orc Convert - Hit by Shadow Sear'),
(17083, 0, 2, 'This not good tickle!', 14, 0, 100, 18, 0, 0, 14138, 0, 'Fel Orc Convert - Hit by Shadow Sear'),
(17083, 0, 3, 'Skin on fire!', 14, 0, 100, 18, 0, 0, 14139, 0, 'Fel Orc Convert - Hit by Shadow Sear'),
-- Death Coil
(17083, 1, 0, 'It hurt!', 14, 1, 100, 18, 0, 0, 14140, 0, 'Fel Orc Convert - Hit by Death Coil'),
(17083, 1, 1, 'Aahhh!', 14, 1, 100, 18, 0, 0, 14141, 0, 'Fel Orc Convert - Hit by Death Coil'),
(17083, 1, 2, 'No more scary!', 14, 1, 100, 18, 0, 0, 14142, 0, 'Fel Orc Convert - Hit by Death Coil'),
(17083, 1, 3, 'Mommy!', 14, 1, 100, 18, 0, 0, 14143, 0, 'Fel Orc Convert - Hit by Death Coil'),
(17083, 1, 4, 'No more!', 14, 1, 100, 18, 0, 0, 14144, 0, 'Fel Orc Convert - Hit by Death Coil'),
-- Consumption / Shadow Fissure
(17083, 2, 0, 'Pain!', 14, 1, 100, 18, 0, 1343, 14149, 0, 'Fel Orc Convert - Hit by Shadow Fissure'),
(17083, 2, 1, 'It hurts!', 14, 1, 100, 18, 0, 1343, 14150, 0, 'Fel Orc Convert - Hit by Shadow Fissure'),
(17083, 2, 2, 'Graaagggh!!', 14, 1, 100, 18, 0, 1343, 14151, 0, 'Fel Orc Convert - Hit by Shadow Fissure'),
(17083, 2, 3, 'No more!!', 14, 1, 100, 18, 0, 1343, 14152, 0, 'Fel Orc Convert - Hit by Shadow Fissure');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17083 AND `id` IN (6, 7, 8));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17083, 0, 6, 0, 8, 0, 25, 0, 30735, 0, 21000, 21000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Orc Convert - On Hit by \'Shadow Sear\' - Say Line 0'),
(17083, 0, 7, 0, 8, 0, 25, 0, 30741, 0, 20000, 20000, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Orc Convert - On Hit by \'Death Coil\' - Say Line 1'),
(17083, 0, 8, 0, 8, 0, 25, 0, 32251, 0, 20000, 20000, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Orc Convert - On Hit by \'Consumption\' - Say Line 2');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 3) AND (`SourceEntry` = 30741);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 30741, 0, 0, 31, 0, 3, 17083, 0, 0, 0, 0, '', 'Death Coil (30741) can only target Fel Orc Convert (17083)');
