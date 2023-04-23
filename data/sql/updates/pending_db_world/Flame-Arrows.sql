DELETE FROM `creature` WHERE `id1` = 17461;
DELETE FROM `creature` WHERE `id1` = 20923;
INSERT INTO `creature` VALUES (151283, 20923, 0, 0, 540, 0, 0, 2, 1, 1, 512.687, 315.652, 2.0405, 2.98451, 86400, 0, 0, 103320, 0, 0, 0, 0, 0, '', 0);
INSERT INTO `creature` VALUES (151118, 17461, 0, 0, 540, 0, 0, 1, 1, 1, 512.687, 315.652, 2.0405, 2.98451, 86400, 0, 0, 1, 0, 0, 0, 0, 0, '', 46924);

DELETE FROM `smart_scripts` WHERE `source_type` = 2 AND `entryorguid` = 4575;
INSERT INTO `smart_scripts` VALUES (4575, 2, 0, 0, 46, 0, 100, 1, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 151283, 20923, 0, 0, 0, 0, 0, 0, 'Area Trigger - On Trigger - Set Data');
INSERT INTO `smart_scripts` VALUES (4575, 2, 1, 0, 46, 0, 100, 1, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 151118, 17461, 0, 0, 0, 0, 0, 0, 'Area Trigger - On Trigger - Set Data');

DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = 1746100;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = 2092300;
INSERT INTO `smart_scripts` VALUES (1746100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Blood Guard - Script9 - Set Event Phase');
INSERT INTO `smart_scripts` VALUES (1746100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Blood Guard - Script9 - Talk');
INSERT INTO `smart_scripts` VALUES (1746100, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Blood Guard - Script9 - Talk');
INSERT INTO `smart_scripts` VALUES (1746100, 9, 3, 0, 0, 1, 100, 0, 0, 0, 10000, 10000, 0, 86, 30952, 0, 11, 17427, 30, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Blood Guard - Out Of Combat - Cross Cast');
INSERT INTO `smart_scripts` VALUES (1746100, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Blood Guard - Script9 - Talk');
INSERT INTO `smart_scripts` VALUES (1746100, 9, 5, 0, 0, 1, 100, 0, 0, 0, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Blood Guard - Out Of Combat - Summon Creature Group');
INSERT INTO `smart_scripts` VALUES (1746100, 9, 6, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Blood Guard - Script9 - Talk');
INSERT INTO `smart_scripts` VALUES (2092300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Guard Porung - Script9 - Talk');
INSERT INTO `smart_scripts` VALUES (2092300, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Guard Porung - Script9 - Talk');
INSERT INTO `smart_scripts` VALUES (2092300, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Guard Porung - Script9 - Talk');
INSERT INTO `smart_scripts` VALUES (2092300, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Guard Porung - Script9 - Talk');
INSERT INTO `smart_scripts` VALUES (2092300, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Guard Porung - Script9 - Set Event Phase');
