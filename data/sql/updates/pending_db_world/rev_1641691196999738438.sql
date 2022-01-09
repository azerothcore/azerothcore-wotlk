INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641691196999738438');

-- relocks npc Great-father Winter's Helper back to winter veil.
DELETE FROM `game_event_creature` WHERE `guid`=3566 AND `eventEntry`=2;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES (2, 3566);
