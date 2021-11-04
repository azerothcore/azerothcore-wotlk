INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636045459174422908');

# Sets spawntime of Sergeant Brashclaw to 2.5 hours
UPDATE `creature` SET `spawntimesecs` = 9000 WHERE `id` = 506;

# Sets spawntime of Slark to 2 hours
UPDATE `creature` SET `spawntimesecs` = 7200 WHERE `id` = 519;

# Sets spawntime of Brack to 2.5 hours
UPDATE `creature` SET `spawntimesecs` = 9000 WHERE `id` = 520;

# Sets spawntime of Foe Reaper 4000 to 5 hours
UPDATE `creature` SET `spawntimesecs` = 18000 WHERE `id` = 573;

# Sets spawntime of Master Digger to 2 hours
UPDATE `creature` SET `spawntimesecs` = 7200 WHERE `id` = 1424;
