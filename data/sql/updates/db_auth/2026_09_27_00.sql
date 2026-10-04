-- DB update 2026_08_16_00 -> 2026_09_27_00
--
-- EndTime stays NULL while a session runs and is only written after a clean shutdown,
-- so a NULL on an older row means that session crashed.
ALTER TABLE `uptime`
    ADD COLUMN `EndTime` INT UNSIGNED NULL DEFAULT NULL AFTER `uptime`,
    ADD COLUMN `ShutdownType` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 = unknown, 1 = shutdown, 2 = restart, 3 = error' AFTER `revision`,
    ADD COLUMN `ExitCode` TINYINT UNSIGNED NULL DEFAULT NULL AFTER `ShutdownType`,
    ADD COLUMN `ShutdownReason` VARCHAR(255) NOT NULL DEFAULT '' AFTER `ExitCode`;

-- Sessions recorded before this update are of unknown outcome, not crashes.
UPDATE `uptime` SET `EndTime` = `starttime` + `uptime` WHERE `EndTime` IS NULL;
