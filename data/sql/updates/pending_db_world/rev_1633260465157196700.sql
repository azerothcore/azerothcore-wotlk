INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633260465157196700');

DELETE FROM `creature_text` WHERE `CreatureID` = 9938 AND `ID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(9938, 0, 0, 'Emperor Thaurissan does not wish to be disturbed! Turn back now or face your doom, weak mortals!', 14, 0, 100, 0, 0, 0, 5430, 3, 'Magmus - SAY_MAGMUS_BRAZIERS_LIT');
