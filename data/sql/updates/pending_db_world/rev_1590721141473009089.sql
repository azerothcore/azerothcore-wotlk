INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590721141473009089');

/*delete any entries in creature_formations to make sure no errors*/
DELETE FROM `creature_formations` WHERE `leaderGUID` = '79333';

/*add captain greenskin as leader of the formation and give him followers.*/
INSERT INTO  `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`) VALUES 
(79333,79333,0,0,0),
(79333,79334,2,135,0),
(79333,79335,2,225,0);

