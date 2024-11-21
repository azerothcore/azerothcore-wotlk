--
ALTER TABLE `characters_npcbot` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE `characters_npcbot` ADD `miscvalues` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `spells_disabled`;
