INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1611439433693694829');

DELETE FROM `game_event_creature` WHERE guid IN (724, 725, 726, 727);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(-1, 724),
(-7, 724),
(-1, 725),
(-7, 726),
(-1, 726),
(-7, 726),
(-1, 727),
(-7, 727);
