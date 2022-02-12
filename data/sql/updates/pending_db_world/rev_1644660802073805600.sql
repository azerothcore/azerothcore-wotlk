INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644660802073805600');

DELETE FROM `creature_formations` WHERE `leaderGuid`=84389;
INSERT INTO `creature_formations` VALUES
(84389,84389,0,0,7,0,0),
(84389,84388,0,0,7,0,0);
