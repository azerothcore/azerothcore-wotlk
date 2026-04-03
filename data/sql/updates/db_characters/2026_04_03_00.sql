-- DB update 2026_03_30_00 -> 2026_04_03_00
--
CREATE TABLE `spam_reports` (
    `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `SpamType` TINYINT UNSIGNED NOT NULL COMMENT '0 = mail, 1 = chat, 2 = calendar',
    `SpammerGuid` INT UNSIGNED NOT NULL DEFAULT '0',
    `Unk1` INT UNSIGNED NULL DEFAULT '0',
    `MailIdOrMessageType` INT UNSIGNED NULL DEFAULT '0',
    `ChannelId` INT UNSIGNED NULL COMMENT 'Only used if SpamType = 1',
    `SecondsSinceMessage` INT UNSIGNED NULL COMMENT 'Only used if SpamType = 1',
    `Description` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `Time` INT NULL DEFAULT NULL COMMENT 'Time of report',
    PRIMARY KEY (`ID`) USING BTREE
)
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
ROW_FORMAT = DEFAULT
;
