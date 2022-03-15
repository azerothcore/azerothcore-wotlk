INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647387221217292000');

-- Update missing npc flag
UPDATE `creature_template` SET `npcflag`=`npcflag`|1 WHERE `entry` = 7918;
