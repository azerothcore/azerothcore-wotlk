INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629427468671180105');

-- Add movement to Tenders
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 15271 AND `guid` IN (54872, 54879, 54874, 54878, 54883, 54898);

-- Add movement to Feral Tenders
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 15294 AND `guid` IN (55021, 55038, 55049, 55044);

