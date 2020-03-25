use acore_world;

START TRANSACTION;

SET @NpcEntry = 55002;

DELETE FROM creature_template WHERE `entry` = @NpcEntry;
DELETE FROM npc_text WHERE `ID` = @NpcEntry;
DELETE FROM command WHERE `name` LIKE 'templatenpc %';

COMMIT;

USE acore_characters;
START TRANSACTION;

DROP TABLE IF EXISTS `template_npc_glyphs`;
DROP TABLE IF EXISTS `template_npc_talents`;
DROP TABLE IF EXISTS `template_npc_alliance`;
DROP TABLE IF EXISTS `template_npc_horde`;
DROP TABLE IF EXISTS `template_npc_human`;
DROP TABLE IF EXISTS `template_npc_talents`;

COMMIT;

