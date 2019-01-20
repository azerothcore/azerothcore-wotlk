INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1547923789457439140');

ALTER TABLE `smart_scripts`
  ADD COLUMN `event_param5` INT(10) UNSIGNED DEFAULT 0 NOT NULL AFTER `event_param4`,
  ADD COLUMN `target_param4` INT(10) UNSIGNED DEFAULT 0 NOT NULL AFTER `target_param3`;
