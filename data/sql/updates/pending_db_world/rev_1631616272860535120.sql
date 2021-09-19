INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631616272860535120');

UPDATE `creature` SET `movementtype`= 1, `wander_distance` = 5 WHERE `GUID` IN (56058, 56059, 56086, 56127, 56160, 56162, 56125, 56123, 56166, 56150) AND `id` IN (15654, 15656, 15658);
