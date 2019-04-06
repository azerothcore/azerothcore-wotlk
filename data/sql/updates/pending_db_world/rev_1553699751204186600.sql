INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553699751204186600');

DELETE FROM trinity_string WHERE entry IN (712, 713);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
(712, '|cffff0000[BG Queue Announcer]:|r %s -- [%u-%u] [%u/%u]|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
