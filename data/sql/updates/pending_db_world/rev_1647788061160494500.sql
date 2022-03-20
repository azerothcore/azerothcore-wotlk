INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647788061160494500');

DELETE FROM `smart_scripts` WHERE `entryorguid`=12459 AND `source_type`=0 AND `id`=3;
INSERT INTO `smart_scripts` VALUES
(12459,0,3,0,6,0,100,0,0,0,0,0,0,41,0,0,0,0,0,0,11,14081,10,0,0,0,0,0,0,'Blackwing Warlock - On Death - Despanw nearest Demon Portals');
