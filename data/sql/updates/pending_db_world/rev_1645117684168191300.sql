INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645117684168191300');

UPDATE `npc_text` SET `text0_0` = "", `text0_1` = (SELECT `FemaleText` FROM `broadcast_text` WHERE `ID` = 11406), `BroadcastTextID0` = 11406 WHERE `ID` = 8121;
UPDATE `npc_text` SET `text0_0` = "", `text0_1` = (SELECT `FemaleText` FROM `broadcast_text` WHERE `ID` = 11410), `BroadcastTextID0` = 11410 WHERE `ID` = 8122;
