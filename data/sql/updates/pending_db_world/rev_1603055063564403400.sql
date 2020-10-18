INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603055063564403400');

/*
 * Update by Silker | <www.azerothcore.org> | Copyright (C)
*/

-- fix models
UPDATE `creature_template` SET `modelid1`=23258, `modelid2`=0 WHERE `entry` IN
(33395, 33402)

