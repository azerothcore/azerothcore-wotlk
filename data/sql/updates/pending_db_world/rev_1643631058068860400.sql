INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643631058068860400');

-- Added by mistake during another PR
DELETE FROM `game_event_creature` WHERE `eventEntry` = 13 AND `guid` = 14461;

-- Adding Boss to Game event 13: Elemental Invasions
DELETE FROM `game_event_creature` WHERE `eventEntry` = 13 AND `guid` = 247200;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES (13, 247200);
