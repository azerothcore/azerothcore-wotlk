INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627303283998958800');

-- Changed the speed movement from 2.22 to 1 of Grunter (8303)
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 8303);

