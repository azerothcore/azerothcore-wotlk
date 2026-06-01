-- Add `filtered_words` table for chat content filtering.
DROP TABLE IF EXISTS `filtered_words`;
CREATE TABLE `filtered_words` (
    `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Word` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`ID`) USING BTREE
)
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
ROW_FORMAT = DEFAULT
;
