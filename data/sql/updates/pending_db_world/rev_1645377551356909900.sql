INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645377551356909900');

DELETE FROM `spell_proc_event` WHERE `entry`=-16689;
INSERT INTO `spell_proc_event` VALUES
(-16689,0,0,0,0,0,0,0,2,0,0,1000);
