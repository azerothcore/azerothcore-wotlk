--
CREATE PROCEDURE DropColumnIfExists()
BEGIN
    DECLARE `column_exists` INT DEFAULT 0;
    SELECT COUNT(*) FROM `information_schema`.`columns` WHERE `table_schema` = 'acore_world' AND `table_name` = 'item_template' AND `column_name` = 'StatsCount' INTO `column_exists`;

    IF `column_exists` > 0 THEN
        ALTER TABLE `item_template` DROP COLUMN `StatsCount`;
    END IF;
END;

CALL DropColumnIfExists();

DROP PROCEDURE IF EXISTS DropColumnIfExists;
