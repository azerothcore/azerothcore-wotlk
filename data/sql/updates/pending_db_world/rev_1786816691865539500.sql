UPDATE `creature` SET `position_x` = 848.659, `position_y` = -229.467, `position_z` = -43.6962, `orientation` = 0.838014 WHERE `guid` = 46615;

DELETE FROM `creature_text` WHERE `CreatureID` = 9502 AND `GroupID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(9502, 0, 0, 'Violence!  Property damage!  None shall pass!!', 14, 0, 100, 0, 0, 0, 5300, 0, 'Phalanx');