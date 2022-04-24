INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650793587179586100');

UPDATE `creature_formations` SET `groupAI`=`groupAI`|0x8 WHERE `leaderGuid` IN (84634,84648);
