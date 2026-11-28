-- DB update 2026_08_16_00 -> 2026_09_27_00
--
-- EndTime stays NULL while a session runs and is only written after a clean shutdown,
-- so a NULL on an older row means that session crashed.
--
-- This file was changed after it shipped (#27862). A database that already applied it
-- applies it again, and one that stopped halfway already has the columns, so each step
-- below only runs where it hasn't happened yet.
SET @column_exists = (SELECT 1 FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'uptime' AND `COLUMN_NAME` = 'EndTime' LIMIT 1);
SET @sql = IF(@column_exists IS NULL, 'ALTER TABLE `uptime` ADD COLUMN `EndTime` INT UNSIGNED NULL DEFAULT NULL AFTER `uptime`, ADD COLUMN `ShutdownType` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT ''0 = unknown, 1 = shutdown, 2 = restart, 3 = error'' AFTER `revision`, ADD COLUMN `ExitCode` TINYINT UNSIGNED NULL DEFAULT NULL AFTER `ShutdownType`, ADD COLUMN `ShutdownReason` VARCHAR(255) NOT NULL DEFAULT '''' AFTER `ExitCode`', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Sessions recorded before this update are of unknown outcome, not crashes. Only on the
-- first successful run: once this file is recorded, a NULL EndTime marks a crash. Rows whose
-- uptime wrapped around (the clock was stepped back during the session) have no end that
-- fits the column and keep NULL.
UPDATE `uptime` SET `EndTime` = `starttime` + `uptime`
    WHERE `EndTime` IS NULL AND `starttime` + `uptime` <= 4294967295
      AND NOT EXISTS (SELECT 1 FROM `updates` WHERE `name` = '2026_09_27_00.sql');
