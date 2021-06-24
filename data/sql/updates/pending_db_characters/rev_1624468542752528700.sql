INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1624468542752528700');

SET @dbname = DATABASE();
SET @tablename = "characters";
SET @columnname = "order";
SET @preparedStatement = (SELECT IF(
    (
        SELECT COUNT(*) FROM information_schema.COLUMNS
        WHERE
            (TABLE_NAME = @tablename)
            AND (TABLE_SCHEMA = @dbname)
            AND (COLUMN_NAME = @columnname)
    ) > 0,
    "SELECT 1 WHERE false",
    CONCAT("ALTER TABLE `", @tablename, "` ADD `", @columnname, "` TINYINT NULL DEFAULT NULL AFTER `grantableLevels`;")
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;
