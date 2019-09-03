INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1567205199450545499');

DELETE FROM `trinity_string` WHERE `entry` IN (30077,30078,30079);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`)
VALUES
(30077,'Toggle Instant Flight',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30078,'Instant Flight ON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30079,'Instant Flight OFF',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
