INSERT INTO version_db_world (`sql_rev`) VALUES ('1494246194005123844');

DELETE FROM `areatrigger_involvedrelation` WHERE `id` in (302,1667);
INSERT INTO `areatrigger_involvedrelation` VALUES (1667,1265);


DELETE FROM `areatrigger_scripts` WHERE `id` = 302;
INSERT INTO `areatrigger_scripts` VALUES (302,'at_sentry_point');

UPDATE `creature_template` SET `ScriptName` = 'npc_archmage_tervosh' WHERE = 4967;
