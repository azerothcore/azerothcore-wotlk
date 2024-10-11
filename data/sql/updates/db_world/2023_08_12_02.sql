-- DB update 2023_08_12_01 -> 2023_08_12_02
--
ALTER TABLE `smart_scripts`
	ADD COLUMN `event_param6` INT UNSIGNED NOT NULL DEFAULT '0' AFTER `event_param5`;

UPDATE `smart_scripts` SET `event_param6` = `event_param5` WHERE `event_type` = 106 AND `source_type` = 0;
UPDATE `smart_scripts` SET `event_param5` = 0 WHERE `event_type` = 106 AND `source_type` = 0;

UPDATE `smart_scripts` SET `event_param6` = `event_param5` WHERE `event_type` = 105 AND `source_type` = 0;
UPDATE `smart_scripts` SET `event_param5` = 0 WHERE `event_type` = 105 AND `source_type` = 0;
