INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623407387579164400');

DELETE FROM `smart_scripts` WHERE `entryorguid`=24914 AND `id` BETWEEN 2 AND 5;
INSERT INTO `smart_scripts` VALUES
(24914,0,2,3,8,0,100,0,45008,0,0,0,0,102,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sorlof - On spell hit Big Gun Assault - disable health regen'),
(24914,0,3,0,61,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sorlof - On spell hit Big Gun Assault - set phase to 1'),
(24914,0,4,5,1,1,100,0,15000,15000,0,0,0,102,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sorlof - OOC (phase 1) - enable health regen'),
(24914,0,5,0,61,1,100,0,0,0,0,0,0,22,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sorlof - OOC (phase 1) - set phase to 0');
