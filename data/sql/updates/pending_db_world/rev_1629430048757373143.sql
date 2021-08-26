INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629430048757373143');

-- Add movement to Elder Springpaws
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 15652 AND `guid` IN (55987, 55988, 55989, 55990, 56007, 56008);
-- Adjusts Elder Springpaw position to stop it falling through the world
UPDATE `creature` SET `position_x` = 8183.1, `position_y` = -7747.6, `position_z` = 162.8 WHERE `id` = 15652 AND `guid` = 56008;
