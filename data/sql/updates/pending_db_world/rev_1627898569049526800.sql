INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627898569049526800');

-- Spawn time changed to 38h, added movement to the spawn of Mongress (14344). Reduced her movement speed from 2.45 to 1
UPDATE `creature_template` SET `MovementType` = 1, `speed_walk` = 1 WHERE (`entry` = 14344);
UPDATE `creature` SET `spawntimesecs` = 136800, `wander_distance` = 10, `MovementType` = 1 WHERE (`id` = 14344) AND (`guid` IN (51895));
