INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637093880615871400');

DELETE FROM `smart_scripts` WHERE `entryorguid`=9217 AND `source_type`=0 AND `id` IN (5,6);
INSERT INTO `smart_scripts` VALUES
(9217,0,5,0,74,0,100,0,0,50,10000,10000,0,11,8365,0,0,0,0,0,9,0,0,0,0,0,0,0,0,'Spirestone Lord Magus - on friendly below 50%hp - cast Enlarge'),
(9217,0,6,0,74,0,100,0,0,30,30000,30000,0,11,6742,0,0,0,0,0,9,0,0,0,0,0,0,0,0,'Spirestone Lord Magus - on friendly below 30%hp - cast Bloodlust');
