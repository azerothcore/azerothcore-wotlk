-- DB update 2023_08_10_02 -> 2023_08_11_00
--
DELETE FROM `acore_string` WHERE `entry` IN (600,601);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(600,'Event %u (%s) is started'),
(601,'Event %u (%s) is stopped');

UPDATE `acore_string` SET `content_default` = 'Event %u (%s) is already active!', `locale_deDE` = 'Event %u (%s) bereits aktiv!', `locale_zhCN` = '事件 %u (%s) 已经激活了。' WHERE `entry` = 587;
UPDATE `acore_string` SET `content_default` = 'Event %u (%s) is not active!',  `locale_deDE` = 'Event %u (%s) nicht aktiv!', `locale_zhCN` = '事件 %u (%s) 没有被激活。' WHERE `entry` = 588;
