INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588709577858892600');

DELETE FROM `acore_string` WHERE `entry` IN (30085,30086);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(30085, 'Battleground Debugging is already enabled in the config, thus you are unable to enable/disable it with command.'),
(30086, 'Arena Debugging is already enabled in the config, thus you are unable to enable/disable it with command.');
