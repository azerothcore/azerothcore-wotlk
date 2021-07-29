INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627568726175425000');

-- Changed the spawn time from  2h45 to 24h
UPDATE `creature` SET `spawntimesecs` = 86400 WHERE (`id` = 14343) AND (`guid` IN (51897, 301303, 301304));

-- Added his 3 spawn points to the pool creature and added those 3 to a common pool template (365), with a max of 1 spawn at the same time
DELETE FROM `pool_template` WHERE `entry` = 365;

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)  VALUES (365, 1, "Olm the Wise Spawns");

DELETE FROM `pool_creature` WHERE `guid` IN (911, 912, 913);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (51897, 365, 0, "Olm the Wise Spawn 1");
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (301303, 365, 0, "Olm the Wise Spawn 2");
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (301304, 365, 0, "Olm the Wise Spawn 3");

