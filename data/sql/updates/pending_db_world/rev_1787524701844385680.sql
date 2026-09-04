--
-- Phalanx
UPDATE `creature` SET `position_x` = 847.848, `position_y` = -230.067, `position_z` = -43.697308, `orientation` = 2.06059 WHERE (`guid` = 46615) AND (`id` = 9502);
DELETE FROM `creature_text` WHERE (`CreatureID` = 9502);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(9502, 0, 0, 'Violence!  Property damage!  None shall pass!!', 14, 0, 100, 0, 0, 0, 5300, 0, 'Phalanx - Say Line 0');
