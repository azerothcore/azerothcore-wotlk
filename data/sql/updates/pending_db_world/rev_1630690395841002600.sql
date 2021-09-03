INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630690395841002600');

-- Fix merge of #7707
-- Adds movements for Stonewind Trackers
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 16316 AND `guid` IN (82666, 82668);

