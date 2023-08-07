--
ALTER TABLE `smart_scripts`
	ADD COLUMN `event_param6` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `event_param5`;
