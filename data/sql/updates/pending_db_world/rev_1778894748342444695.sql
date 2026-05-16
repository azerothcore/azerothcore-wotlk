--
DELETE FROM `creature_text` WHERE (`CreatureID` = 24322) AND (`GroupID` IN (0));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
    (24322, 0, 0, 'Silence!', 14, 0, 100, 1, 0, 0, 32240, 0, 'Ancient Citizen of Nifflevar yell');
