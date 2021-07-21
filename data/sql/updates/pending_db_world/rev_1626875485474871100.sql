INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626875485474871100');

-- Added movement to some Burning Blade Fanatic spawns
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 3197) AND (`guid` IN (6417, 6418, 6422, 6426, 6427, 6429, 7334, 7337, 7898, 7900, 7901));
  
--  Added movement to some Burning Blade Apprentice
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 3198) AND (`guid` IN (6420, 6423, 6430, 7339, 6431, 7880, 7883, 7885, 8429));

