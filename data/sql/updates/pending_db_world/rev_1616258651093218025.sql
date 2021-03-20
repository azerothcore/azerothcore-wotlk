INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616258651093218025');

DELETE FROM `gameobject_addon` WHERE `guid` IN (5141, 5205, 5382, 5398, 5405, 5425);

INSERT INTO `gameobject_addon` VALUES (5141, 0, 0);
INSERT INTO `gameobject_addon` VALUES (5205, 0, 0);
INSERT INTO `gameobject_addon` VALUES (5382, 0, 0);
INSERT INTO `gameobject_addon` VALUES (5398, 0, 0);
INSERT INTO `gameobject_addon` VALUES (5405, 0, 0);
INSERT INTO `gameobject_addon` VALUES (5425, 0, 0);

