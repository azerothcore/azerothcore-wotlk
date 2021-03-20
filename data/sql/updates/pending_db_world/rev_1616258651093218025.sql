INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616258651093218025');

DELETE FROM `gameobject_addon` WHERE `guid` IN (5141, 5205, 5382, 5398, 5405, 5425);
INSERT INTO `gameobject_addon` (`guid`, `invisibilityType`, `invisibilityValue`) VALUES 
(5141, 0, 0),
(5193, 0, 0),
(5205, 0, 0),
(5382, 0, 0),
(5398, 0, 0),
(5405, 0, 0),
(5425, 0, 0);
