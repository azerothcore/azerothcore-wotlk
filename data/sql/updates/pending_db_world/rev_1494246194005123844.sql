INSERT INTO version_db_world (`sql_rev`) VALUES ('1494246194005123844');

DELETE FROM `areatrigger_involvedrelation` WHERE `id` in (302,1667);
INSERT INTO `areatrigger_involvedrelation` VALUES (1667,1265);


DELETE FROM `areatrigger_scripts` WHERE `entry` = 302;
INSERT INTO `areatrigger_scripts` VALUES (302,'at_sentry_point');

UPDATE `creature_template` SET `ScriptName` = 'npc_archmage_tervosh' WHERE `entry` = 4967;

DELETE FROM `creature_text` WHERE `entry` = 4967 AND `groupid` = 0 and `id` = 0;
INSERT INTO `creature_text` VALUES (4967, 0, 0, 'Go with grace, and may the Lady\'s magic protect you.', 12, 0, 100, 0, 0, 0, 1751, 0, 'SAY1');
