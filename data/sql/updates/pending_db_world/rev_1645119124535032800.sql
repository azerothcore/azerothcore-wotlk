INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645119124535032800');

UPDATE `npc_text` SET  `text0_0` = (SELECT `MaleText` FROM `broadcast_text` WHERE `ID` = 22630), `BroadcastTextID0` = 22630 WHERE `ID` = 11596;
