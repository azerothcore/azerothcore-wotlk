-- DB update 2025_07_11_00 -> 2025_07_29_00
--
ALTER TABLE `mail_server_template_conditions`
    CHANGE COLUMN `conditionType` `conditionType` ENUM('Level','PlayTime','Quest','Achievement','Reputation','Faction','Race','Class','AccountFlags') NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `templateID`;
