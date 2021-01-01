INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609543457839849700');

UPDATE `creature_template` SET `npcflag`=`npcflag`&~32768, `flags_extra`=`flags_extra`|1024 WHERE `entry` IN (8888, 9299);
