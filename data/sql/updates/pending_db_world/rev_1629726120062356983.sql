INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629726120062356983');

-- adds movement to a few Mummified Headhunters
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 16342 AND `guid` IN (82050, 82052, 82053, 82054, 82055, 82056, 82048, 82084);
