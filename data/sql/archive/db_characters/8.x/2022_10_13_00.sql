-- DB update 2022_08_21_00 -> 2022_10_13_00
--
DELETE FROM `updates` WHERE  `name`='Homebind_Orientation.sql';

ALTER TABLE `character_homebind`
	ADD COLUMN `posO` FLOAT NOT NULL DEFAULT '0' AFTER `posZ`;
