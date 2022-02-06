INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643393372625004300');

DELETE FROM `creature` WHERE `guid` = 247519;
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 20 WHERE `id1` = 14361;
