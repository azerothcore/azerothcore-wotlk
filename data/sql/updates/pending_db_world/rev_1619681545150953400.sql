INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619681545150953400');

UPDATE `npc_text` SET `BroadcastTextID0` = 0 WHERE `ID` = 10106 AND `BroadcastTextID0` = 18360; -- Unlink incorrect broadcast text from Stormwind guard (Class Trainer > Shaman)
