INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629983088640886216');

-- Added roaming movement to Risen Creeper
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 16300) AND (`guid` IN (82122, 82123, 82124, 82130, 82713));
-- Added roaming movement to Dreadbone Skeleton
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 16303) AND (`guid` IN (82125, 82127, 82131, 82450, 82822, 82823, 82826, 82827, 82841, 82864, 82899, 82932));
-- Added roaming movement to Deathcage Scryer
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 16307) AND (`guid` IN (82126, 82129));

