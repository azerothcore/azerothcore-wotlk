INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630128453579281559');

-- Set respawn for two Dark Iron deposits to 15 mins
UPDATE `gameobject` SET `spawntimesecs` = 900 WHERE `id` = 165658 AND `guid` IN (64838, 64842);

