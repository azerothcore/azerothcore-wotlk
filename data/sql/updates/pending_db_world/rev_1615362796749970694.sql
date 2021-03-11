INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615362796749970694');

-- Booty Bay fishing, add description
UPDATE `pool_gameobject` SET `description`="Fishing pool - Booty Bay" WHERE `pool_entry`=268;

-- Change respawn of items in pool
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `guid` IN (50320,64627);
