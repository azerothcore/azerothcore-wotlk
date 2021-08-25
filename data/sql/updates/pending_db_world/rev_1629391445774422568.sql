INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629391445774422568');

-- Change the respawntime of the Ammo Crate to 15 s
UPDATE `gameobject` SET `spawntimesecs` = 15 WHERE (`id` = 176785) AND (`guid` IN (10663));
