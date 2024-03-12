--
ALTER TABLE `characters_npcbot` ADD `hire_time` timestamp NULL DEFAULT '1970-01-01 07:00:01' AFTER `faction`;
UPDATE `characters_npcbot` SET `hire_time` = CURRENT_TIMESTAMP() WHERE `owner` != 0;
