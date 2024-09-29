-- DB update 2024_07_05_00 -> 2024_09_03_00
DROP TABLE IF EXISTS `character_achievement_offline_updates`;
CREATE TABLE `character_achievement_offline_updates` (
    `guid` INT UNSIGNED NOT NULL COMMENT 'Character\'s GUID',
    `update_type` TINYINT UNSIGNED NOT NULL COMMENT 'Supported types: 1 - COMPLETE_ACHIEVEMENT; 2 - UPDATE_CRITERIA',
    `arg1` INT UNSIGNED NOT NULL COMMENT 'For type 1: achievement ID; for type 2: ACHIEVEMENT_CRITERIA_TYPE',
    `arg2` INT UNSIGNED DEFAULT NULL COMMENT 'For type 2: miscValue1 for updating achievement criteria',
    `arg3` INT UNSIGNED DEFAULT NULL COMMENT 'For type 2: miscValue2 for updating achievement criteria',
    INDEX `idx_guid` (`guid`)
)
COMMENT = 'Stores updates to character achievements when the character was offline'
CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci
ENGINE = InnoDB
;
