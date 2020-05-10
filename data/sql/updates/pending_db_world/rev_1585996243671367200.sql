INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1585996243671367200');

-- fix Julianne's first death sound
UPDATE `creature_text` SET `Sound` = 9198 WHERE `CreatureID` = 17534 AND `GroupID` = 2 AND `ID` = 0;
