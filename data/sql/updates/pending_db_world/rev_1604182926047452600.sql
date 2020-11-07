INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1604182926047452600');

/*
 * Update by Silker | <www.azerothcore.org> | Copyright (C)
*/

UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432 WHERE  `entry` IN
(30641, 31521);
UPDATE `creature_template` SET `ScriptName` = 'trigger_periodic' WHERE `entry`= 30641;

