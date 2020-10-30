INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601451772137449700');

/*
 * Update by Silker | <www.azerothcore.org> | Copyright (C)
*/

-- https://www.wowhead.com/npc=34607/nerubian-burrower
UPDATE `creature_template` SET `minlevel`=82, `maxlevel`=82 WHERE `entry` IN 
(34607, 34648, 35655, 35656);

-- https://www.wowhead.com/npc=34605/swarm-scarab  (maxlevel is already 80)
UPDATE `creature_template` SET `minlevel`=80 WHERE `entry` IN 
(34605, 34650, 35658, 35659);

