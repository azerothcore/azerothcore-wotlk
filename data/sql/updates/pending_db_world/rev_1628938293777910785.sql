INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628938293777910785');

-- Add movment to Draconic Mageweaver
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `guid` = 36427 AND `id` = 6131;
-- Add movement to Makrinni Razorclaw
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `guid` = 36013 AND `id` = 6350;

