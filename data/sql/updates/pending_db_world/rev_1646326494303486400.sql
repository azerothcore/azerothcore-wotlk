INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646326494303486400');

DELETE FROM `creature_text` WHERE `CreatureID` = 10184 AND `GroupID` = 5;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(10184, 5, 0, 'You seek to lure me from my clutch? You shall pay for your insolence!', 14, 0, 100, 0, 0, 0, 8570, 0, 'Onyxia - Boundary Evade');
