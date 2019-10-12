INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1570916858306186295');

DELETE FROM `trinity_string` WHERE `entry` = 30080;
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`)
VALUES
(30080,'The file ''opcode.txt'' is missing in the server working directory.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
