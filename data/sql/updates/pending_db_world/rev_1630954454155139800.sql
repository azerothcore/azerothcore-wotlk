INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630954454155139800');

UPDATE `npc_trainer` SET `ReqLevel` = 50 WHERE `SpellID` IN (11419, 11420);
