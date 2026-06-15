-- DB update 2026_04_12_00 -> 2026_06_01_00
-- Add `chat_filter` table for chat content filtering.
DROP TABLE IF EXISTS `chat_filter`;
CREATE TABLE `chat_filter` (
    `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Word` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`ID`) USING BTREE
)
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
ROW_FORMAT = DEFAULT
;
