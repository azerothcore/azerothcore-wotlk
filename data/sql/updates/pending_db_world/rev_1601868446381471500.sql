INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601868446381471500');

DELETE FROM `event_scripts` WHERE `id`=14592;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES (14592, 1, 10, 22890, 300000, 0, -108.252, -510.302, 21.4761, 2.44346);