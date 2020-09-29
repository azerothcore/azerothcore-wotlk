INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1600739072121853409');

/* brewfest camp hostile mobs */
DELETE FROM `game_event_creature` WHERE `guid` IN (7370, 22181, 22188, 22473);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(-24,7370),
(-24,22181),
(-24,22188),
(-24,22473);

/* brewfest camp non-hostile mobs */
DELETE FROM `game_event_creature` WHERE `guid` IN (12369, 12372, 21020, 21022, 21026);
INSERT INTO `game_event_creature` (eventEntry,guid) VALUES
(-24,12369),
(-24,12372),
(-24,21020),
(-24,21022),
(-24,21026);
