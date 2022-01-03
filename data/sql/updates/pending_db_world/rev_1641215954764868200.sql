INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641215954764868200');

-- Fix error in worldserver (creature random movement without wanderer distance)
UPDATE `creature` SET `wander_distance`='4' WHERE `guid`= 121049;
