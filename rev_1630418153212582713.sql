INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630418153212582713');

-- Adds movements for Stonewind Trackers
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 16350 AND `guid` IN (82666, 82668);
