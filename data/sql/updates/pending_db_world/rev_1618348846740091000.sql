INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618348846740091000');

-- Shadowfang Keep
UPDATE `dungeon_access_template` SET `max_level` = 26  WHERE `map_id` = 33;
-- Stormwind Stockade
UPDATE `dungeon_access_template` SET `max_level` = 30  WHERE `map_id` = 34;
-- Deadmines
UPDATE `dungeon_access_template` SET `max_level` = 25  WHERE `map_id` = 36;
-- Wailing Caverns
UPDATE `dungeon_access_template` SET `max_level` = 25  WHERE `map_id` = 43;
