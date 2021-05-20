INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621501368347745883');

UPDATE `creature`
SET `modelid` = 1744, `spawntimesecs` = 275, `wander_distance` = 5, `curhealth` = 178, `movementtype` = 1
WHERE `guid` BETWEEN 40489 AND 40496 AND `id` = 3254;
