INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627115613806415400');

-- Relocate Peacebloom gameobject (guid=26813) to avoid collision with Darkmoon Faire and remove it from game_event_gameobject (de-)spawns
UPDATE `gameobject` SET `position_x` = -9570.9, `position_y` = 120.2, `position_z` = 59.594 WHERE `guid` = 26813;
DELETE FROM `game_event_gameobject` WHERE `guid` = 26813 AND `eventEntry` = -4;
