INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641645833659060700');

DELETE FROM `game_event_creature` WHERE `guid` IN (3565,3566);
INSERT INTO `game_event_creature` VALUES
(52,3565),
(52,3566);
