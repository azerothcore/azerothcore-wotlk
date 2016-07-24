-- bang a gong starter npc
DELETE FROM `creature_queststarter` WHERE `id` = 15192 AND `quest` = 8743;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES ('15192', '8743'); 

DELETE FROM `creature_questender` WHERE `id` = 15192 AND `quest` = 8743;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES ('15192', '8743');
