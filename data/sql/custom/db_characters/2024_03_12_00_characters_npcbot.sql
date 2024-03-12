--
ALTER TABLE `characters_npcbot` ADD `hire_time` timestamp NULL DEFAULT '0000-00-00 00:00:00' AFTER `faction`;
UPDATE `characters_npcbot` SET `hire_time` = CURRENT_TIMESTAMP() WHERE `owner` != 0;
