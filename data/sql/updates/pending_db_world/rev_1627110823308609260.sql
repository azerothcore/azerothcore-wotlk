INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627110823308609260');

-- Set Dreadscorn respawn to 5 hours
UPDATE `creature` SET `spawntimesecs` = 18000 WHERE `id` = 8304 AND `guid` = 3902;

-- Set Gnarl Leafbrother respawn to 40 hours
UPDATE `creature` SET `spawntimesecs` = 144000 WHERE `id` = 5354 AND `guid` = 51842;

-- Set Cranky Benj respawn to 40 hours
UPDATE `creature` SET `spawntimesecs` = 144000 WHERE `id` = 14223 AND `guid` = 90511;

-- Set Azzere the Skyblade respawn to 5 hours
UPDATE `creature` SET `spawntimesecs` = 18000 WHERE `id` = 5834 AND `guid` = 51813;

-- Set Accursed Slitherblade respawn to 26.5 hours
UPDATE `creature` SET `spawntimesecs` = 95400 WHERE `id` = 14229 AND `guid` = 51846;

-- Set Giggler respawn to 13 hours
UPDATE `creature` SET `spawntimesecs` = 46800 WHERE `id` = 14228 AND `guid` = 51847;

-- Set Verifonix respawn to 26.5 hours
UPDATE `creature` SET `spawntimesecs` = 95400 WHERE `id` = 14492 AND `guid` IN (49152, 134231, 134232, 134233, 134234, 134235);

-- Set Diamond Head respawn to 13 hours
UPDATE `creature` SET `spawntimesecs` = 46800 WHERE `id` = 5345 AND `guid` = 51843;

