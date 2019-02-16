INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1550356980568891570');

-- Script for Living Inferno (Halion fight)
UPDATE `creature_template` SET `ScriptName`='npc_living_inferno' WHERE `entry` = 40681;
