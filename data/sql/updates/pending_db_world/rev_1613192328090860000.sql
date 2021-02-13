INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613192328090860000');

/* Script Master Wood Emotes and Responses
   Source: https://wow.gamepedia.com/Master_Wood, https://www.wowhead.com/npc=8383/master-wood
*/

DELETE FROM `creature_text` WHERE `CreatureID`=8383 AND `GroupID`=211 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (8383, 211, 0, 'Master Wood is not impressed.', 16, 0, 100, 0, 0, 0, 0, 0, 'Master Wood - Emote on Receive Emote');
DELETE FROM `creature_text` WHERE `CreatureID`=8383 AND `GroupID`=210 AND `ID`=2;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (8383, 210, 2, 'Don\'t make me go medieval on you.', 12, 0, 100, 0, 0, 0, 0, 0, 'Master Wood - Say on Receive Emote');
DELETE FROM `creature_text` WHERE `CreatureID`=8383 AND `GroupID`=210 AND `ID`=1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (8383, 210, 1, 'Keep it up, $N, and I\'ll beat some manners into you.', 12, 0, 100, 0, 0, 0, 0, 0, 'Master Wood - Say on Receive Emote 2');
DELETE FROM `creature_text` WHERE `CreatureID`=8383 AND `GroupID`=210 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (8383, 210, 0, 'You\'re pushing it $N.', 12, 0, 100, 0, 0, 0, 0, 0, 'Master Wood - Say on Receive Emote 3');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8383;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8383) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8383, 0, 0, 0, 22, 0, 100, 0, 77, 0, 0, 0, 0, 1, 210, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Master Wood - Received Emote 77 - Say Randomized Line 210'),
(8383, 0, 1, 0, 22, 0, 100, 0, 41, 0, 0, 0, 0, 1, 211, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Master Wood - Received Emote 41 - Emote Line 211'),
(8383, 0, 2, 0, 22, 0, 100, 0, 17, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Master Wood - Received Emote 17 - Play Emote 2'),
(8383, 0, 3, 0, 22, 0, 100, 0, 101, 0, 0, 0, 0, 5, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Master Wood - Received Emote 101 - Play Emote 3'),
(8383, 0, 4, 0, 22, 0, 100, 0, 78, 0, 0, 0, 0, 5, 66, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Master Wood - Received Emote 78 - Play Emote 66');
