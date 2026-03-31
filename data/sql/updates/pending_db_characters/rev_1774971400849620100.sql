--
CREATE TABLE `spam_reports` (
    `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `SpamType` TINYINT UNSIGNED NOT NULL DEFAULT '0' COMMENT '0 = mail, 1 = chat',
    `SpammerGuid` INT UNSIGNED NOT NULL DEFAULT '0',
    `Unk1` INT UNSIGNED NULL DEFAULT '0',
    `MailIdOrMessageType` INT UNSIGNED NULL DEFAULT '0',
    `ChannelId` INT UNSIGNED NULL DEFAULT '0' COMMENT 'Only used if SpamType = 1',
    `secondsSinceMessage` INT UNSIGNED NULL DEFAULT '0' COMMENT 'Only used if SpamType = 1',
    `Description` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    PRIMARY KEY (`ID`) USING BTREE
)
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
ROW_FORMAT = DEFAULT
;
