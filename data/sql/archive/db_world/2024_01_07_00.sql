-- DB update 2024_01_06_01 -> 2024_01_07_00
-- update BroadcastTextId
UPDATE `creature_text` SET `BroadcastTextId`=9463 WHERE `CreatureID`=14383 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=9464 WHERE `CreatureID`=14383 AND `GroupID`=1 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=9465 WHERE `CreatureID`=14383 AND `GroupID`=2 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=9475 WHERE `CreatureID`=14383 AND `GroupID`=3 AND `ID`=0;

-- Remove GroupID 1 add  GroupID 0 BroadcastTextId
DELETE FROM `creature_text` WHERE `CreatureID`=11489;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(11489, 0, 0, 'You do not belong here! Ancients, rise up against these intruders!', 14, 0, 100, 0, 0, 0, 11727, 0, 'Tendris Warpwood');

-- Increase creature_text 
DELETE FROM `creature_text` WHERE `CreatureID`=14566;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(14566, 0, 0, '%s breaks free of its spectral bonds with a tremendous crash of thunder!', 16, 0, 100, 0, 0, 0, 9763, 0, 'Ancient Equine Spirit');

-- Increase Talk
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14566;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14566) AND (`source_type` = 0) AND (`id` IN (2, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14566, 0, 2, 4, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 10387, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Equine Spirit - On Update - Cast Lightning Surge'),
(14566, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Equine Spirit - Talk - Say 0');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11489;
-- Delete the wrong event This event should have been said by Creature 14566
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11489) AND (`source_type` = 0) AND (`id` IN (4));
