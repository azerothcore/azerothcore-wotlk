INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635972083556511200');

DELETE FROM `creature_text` WHERE `CreatureID`=12018 AND `GroupID`=11 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(12018, 11, 0, 'My flame... Please, don\'t take away my flame...', 14, 0, 100, 0, 0, 8042, 0, 0, 'majordomo SAY_DEATH');
