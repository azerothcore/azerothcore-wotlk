INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641650285026899700');

ALTER TABLE `creature_template`
    ADD COLUMN `speed_swim` FLOAT NOT NULL DEFAULT '1' AFTER `speed_run`,
    ADD COLUMN `speed_flight` FLOAT NOT NULL DEFAULT '1' AFTER `speed_swim`;
