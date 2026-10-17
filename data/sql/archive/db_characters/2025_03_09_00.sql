-- DB update 2025_02_16_00 -> 2025_03_09_00
--
DROP TABLE IF EXISTS `mail_server_template_items`;
CREATE TABLE `mail_server_template_items` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `templateID` INT UNSIGNED NOT NULL,
    `faction` ENUM('Alliance', 'Horde') NOT NULL,
    `item` INT UNSIGNED NOT NULL,
    `itemCount` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_mail_template`
        FOREIGN KEY (`templateID`) REFERENCES `mail_server_template`(`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB COLLATE='utf8mb4_unicode_ci';

DELETE FROM `mail_server_template_items` WHERE `faction` = 'Alliance';
INSERT INTO `mail_server_template_items` (`templateID`, `faction`, `item`, `itemCount`)
SELECT `id`, 'Alliance', `itemA`, `itemCountA` FROM `mail_server_template` WHERE `itemA` > 0;

DELETE FROM `mail_server_template_items` WHERE `faction` = 'Horde';
INSERT INTO `mail_server_template_items` (`templateID`, `faction`, `item`, `itemCount`)
SELECT `id`, 'Horde', `itemH`, `itemCountH` FROM `mail_server_template` WHERE `itemH` > 0;

ALTER TABLE `mail_server_template`
    DROP COLUMN `itemA`,
    DROP COLUMN `itemCountA`,
    DROP COLUMN `itemH`,
    DROP COLUMN `itemCountH`;

-- mail_server_template_conditions
DROP TABLE IF EXISTS `mail_server_template_conditions`;
CREATE TABLE `mail_server_template_conditions` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `templateID` INT UNSIGNED NOT NULL,
    `conditionType` ENUM('Level', 'PlayTime', 'Quest', 'Achievement', 'Reputation', 'Faction', 'Race', 'Class') NOT NULL,
    `conditionValue` INT UNSIGNED NOT NULL,
    `conditionState` INT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_mail_template_conditions`
        FOREIGN KEY (`templateID`) REFERENCES `mail_server_template`(`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB COLLATE='utf8mb4_unicode_ci';

DELETE FROM `mail_server_template_conditions` WHERE `conditionType` = 'Level';
INSERT INTO `mail_server_template_conditions` (`templateID`, `conditionType`, `conditionValue`)
SELECT `id`, 'Level', `reqLevel` FROM `mail_server_template` WHERE `reqLevel` > 0;

DELETE FROM `mail_server_template_conditions` WHERE `conditionType` = 'PlayTime';
INSERT INTO `mail_server_template_conditions` (`templateID`, `conditionType`, `conditionValue`)
SELECT `id`, 'PlayTime', `reqPlayTime` FROM `mail_server_template` WHERE `reqPlayTime` > 0;

ALTER TABLE `mail_server_template`
    DROP COLUMN `reqLevel`,
    DROP COLUMN `reqPlayTime`;

-- mail_server_character
-- Make sure we dont have invalid instances in mail_server_character.mailId before we add the foregin key to avoid SQL errors
DELETE FROM `mail_server_character` WHERE `mailId` NOT IN (SELECT `id` FROM `mail_server_template`);

-- Add foreign key for mail_server_character.mailId
ALTER TABLE `mail_server_character`
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`guid`, `mailId`),
    ADD CONSTRAINT `fk_mail_server_character`
        FOREIGN KEY (`mailId`) REFERENCES `mail_server_template`(`id`)
        ON DELETE CASCADE;
