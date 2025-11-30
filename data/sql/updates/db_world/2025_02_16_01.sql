-- DB update 2025_02_16_00 -> 2025_02_16_01
--
ALTER TABLE `updates`
    CHANGE COLUMN `state` `state` ENUM('RELEASED','CUSTOM','MODULE','ARCHIVED','PENDING') NOT NULL DEFAULT 'RELEASED' COMMENT 'defines if an update is released or archived.' COLLATE 'utf8mb4_unicode_ci' AFTER `hash`;

ALTER TABLE `updates_include`
    CHANGE COLUMN `state` `state` ENUM('RELEASED','ARCHIVED','CUSTOM','PENDING') NOT NULL DEFAULT 'RELEASED' COMMENT 'defines if the directory contains released or archived updates.' COLLATE 'utf8mb4_unicode_ci' AFTER `path`;

DELETE FROM `updates_include` WHERE `path` = '$/data/sql/updates/pending_db_world';
INSERT INTO `updates_include` (`path`, `state`) VALUES
('$/data/sql/updates/pending_db_world', 'PENDING');
