-- add revision
INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635951187866923861');
-- add orientation` and delay into existing wp table
ALTER TABLE `waypoints` ADD COLUMN `orientation` FLOAT DEFAULT 0 NOT NULL AFTER `position_z`, ADD COLUMN `delay` INT(10) UNSIGNED DEFAULT 0 NOT NULL AFTER `orientation`;
