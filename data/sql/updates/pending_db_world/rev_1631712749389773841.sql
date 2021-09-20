INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631712749389773841');

-- Adds movement to Spindleweb Lurker's
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 16351 AND `guid` IN (82364, 82374, 82377, 82592, 82597, 82604, 82616, 82617, 82382, 82386, 82480, 82691);

-- Repositioning of one Spindleweb Lurker that spawned in a tree
UPDATE `creature` SET `position_x` = 7110.5, `position_y` = -6149.9, `position_z` = 22.72 WHERE `id` = 16351 AND `guid` = 82604;
