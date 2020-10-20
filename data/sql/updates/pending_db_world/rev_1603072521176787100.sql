INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603072521176787100');

/*
 * Update by Silker | <www.azerothcore.org> | Copyright (C)
*/

UPDATE `creature_template` SET `AIName`='PassiveAI' WHERE `entry`=32866;
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432 WHERE  `entry` IN
(32866, 33690)

