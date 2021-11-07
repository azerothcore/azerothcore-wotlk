INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636311037132029200');

DELETE FROM `creature_text` WHERE `CreatureID` = 9568;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`) VALUES
(9568, 0, 0, '%s calls for help!' , 16);
