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

INSERT INTO `mail_server_template_items` (`templateID`, `faction`, `item`, `itemCount`)
SELECT `id`, 'Alliance', `itemA`, `itemCountA` FROM `mail_server_template` WHERE `itemA` > 0;

INSERT INTO `mail_server_template_items` (`templateID`, `faction`, `item`, `itemCount`)
SELECT `id`, 'Horde', `itemH`, `itemCountH` FROM `mail_server_template` WHERE `itemH` > 0;

ALTER TABLE `mail_server_template` 
DROP COLUMN `itemA`,
DROP COLUMN `itemCountA`,
DROP COLUMN `itemH`,
DROP COLUMN `itemCountH`;

-- Make sure we dont have invalid instances in mail_server_character.mailId before we add the foregin key to avoid SQL errors
DELETE FROM `mail_server_character` WHERE `mailId` NOT IN (SELECT `id` FROM `mail_server_template`);

-- Add foreign key for mail_server_character.mailId
ALTER TABLE `mail_server_character`
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`guid`, `mailId`),
    ADD CONSTRAINT `fk_mail_template_character`
        FOREIGN KEY (`mailId`) REFERENCES `mail_server_template`(`id`)
        ON DELETE CASCADE;
