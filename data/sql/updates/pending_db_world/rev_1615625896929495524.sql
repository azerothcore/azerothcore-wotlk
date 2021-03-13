INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615625896929495524');

-- Decrease respawn rate and make him move
UPDATE `creature` SET `spawntimesecs`=300,`MovementType`=1, `wander_distance`=60 WHERE `guid`=2169;
