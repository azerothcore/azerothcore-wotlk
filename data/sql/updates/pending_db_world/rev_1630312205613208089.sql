INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630312205613208089');

-- add multiple movements for spindlewebs
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 16350 AND `guid` IN (82212, 82255, 82461, 82463, 82467, 82468, 82471, 82472, 82475, 82476, 82719);
