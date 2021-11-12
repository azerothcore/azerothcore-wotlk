INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636493523189661400');

DELETE FROM `creature` WHERE `guid` IN (240643, 240521);
DELETE FROM `game_event_creature` WHERE `guid` IN (240643, 240521);
