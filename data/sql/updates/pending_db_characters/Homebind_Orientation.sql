--
DELETE FROM `updates` WHERE  `name`='Homebind_Orientation.sql';

ALTER TABLE `character_homebind`
	ADD COLUMN `posO` FLOAT NOT NULL DEFAULT '0' AFTER `posZ`;
