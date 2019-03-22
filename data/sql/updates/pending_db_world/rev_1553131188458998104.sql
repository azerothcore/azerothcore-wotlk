INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553131188458998104');

-- achievement_reward
ALTER TABLE `achievement_reward` CHANGE `entry` `ID` mediumint(8) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `achievement_reward` CHANGE `title_A` `TitleA` mediumint(8) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `achievement_reward` CHANGE `title_H` `TitleH` mediumint(8) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `achievement_reward` CHANGE `item` `ItemID` mediumint(8) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `achievement_reward` CHANGE `sender` `Sender` mediumint(8) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `achievement_reward` CHANGE `subject` `Subject` varchar(255) DEFAULT NULL;
ALTER TABLE `achievement_reward` CHANGE `text` `Body` text;
ALTER TABLE `achievement_reward` CHANGE `mailTemplate` `MailTemplateID` mediumint(8) unsigned DEFAULT '0';
