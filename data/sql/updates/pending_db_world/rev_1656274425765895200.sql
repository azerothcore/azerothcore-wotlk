--
ALTER TABLE `creature_loot_template` ADD COLUMN `ReqLevel` INT DEFAULT 0 AFTER `MaxCount`;
ALTER TABLE `disenchant_loot_template` ADD COLUMN `ReqLevel` INT DEFAULT 0 AFTER `MaxCount`;
ALTER TABLE `fishing_loot_template` ADD COLUMN `ReqLevel` INT DEFAULT 0 AFTER `MaxCount`;
ALTER TABLE `gameobject_loot_template` ADD COLUMN `ReqLevel` INT DEFAULT 0 AFTER `MaxCount`;
ALTER TABLE `item_loot_template` ADD COLUMN `ReqLevel` INT DEFAULT 0 AFTER `MaxCount`;
ALTER TABLE `mail_loot_template` ADD COLUMN `ReqLevel` INT DEFAULT 0 AFTER `MaxCount`;
ALTER TABLE `milling_loot_template` ADD COLUMN `ReqLevel` INT DEFAULT 0 AFTER `MaxCount`;
ALTER TABLE `pickpocketing_loot_template` ADD COLUMN `ReqLevel` INT DEFAULT 0 AFTER `MaxCount`;
ALTER TABLE `prospecting_loot_template` ADD COLUMN `ReqLevel` INT DEFAULT 0 AFTER `MaxCount`;
ALTER TABLE `reference_loot_template` ADD COLUMN `ReqLevel` INT DEFAULT 0 AFTER `MaxCount`;
ALTER TABLE `skinning_loot_template` ADD COLUMN `ReqLevel` INT DEFAULT 0 AFTER `MaxCount`;
ALTER TABLE `spell_loot_template` ADD COLUMN `ReqLevel` INT DEFAULT 0 AFTER `MaxCount`;
ALTER TABLE `player_loot_template` ADD COLUMN `ReqLevel` INT DEFAULT 0 AFTER `MaxCount`;
