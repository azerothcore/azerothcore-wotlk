INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629435906739087287');

-- Add movement to Withered Green Keepers
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 15637 AND `guid` IN (55527, 55528, 55529, 55532, 55533, 55534, 55535, 55569, 55570);

-- Shift one spawn slightly to avoid overlapping
UPDATE `creature` SET `position_x` = 8258, `position_y` = -6136.1, `position_z` = 34.2 WHERE `id` = 15637 AND `guid` = 55534;

