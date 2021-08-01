INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627818799536182900');

-- Added movement to Mok'rash (1493)
UPDATE `creature` SET  `MovementType` = 1, `wander_distance`= 5 WHERE (`id` = 1493) AND (`guid` IN (1672));

