INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629430048757373143');

-- Add movement to Elder Springpaws
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 15652 AND `guid` IN (55987, 55988, 55989, 55990, 56007, 56008);

