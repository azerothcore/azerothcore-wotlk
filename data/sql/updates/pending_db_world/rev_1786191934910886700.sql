--
DELETE FROM `creature_text` WHERE `CreatureID` = 33271 AND `GroupID` IN (9, 10);
DELETE FROM `creature_text` WHERE `CreatureID` = 33488;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(33271, 9, 0, 'The saronite barrier protecting General Vezax shimmers and fades away!', 41, 0, 100, 0, 0, 0, 33647, 0, 'General Vezax - EMOTE_BARRIER_FADE'),
(33271, 10, 0, 'A cloud of saronite vapors coalesces nearby!', 41, 0, 100, 0, 0, 0, 33587, 0, 'General Vezax - EMOTE_VAPORS');
