INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553124717573135800');

-- Script for Living Ember (Halion fight)
UPDATE `creature_template` SET `ScriptName`='npc_living_ember' WHERE  `entry` = 40683;
