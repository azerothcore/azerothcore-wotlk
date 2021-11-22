INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637565596089806926');

UPDATE `npc_trainer`  SET `ReqLevel` = 35 WHERE `SpellID` in (49360, 49361)
