INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625927133942554056');

-- Stop Wrathscale Siren spawning underground
UPDATE `creature` SET `position_z` = -21.14 WHERE `id` = 17195 AND `guid` = 60996;
