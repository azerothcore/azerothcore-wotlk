INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623263911660022500');

UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 14428); -- Uruson walk speed to 1, was 1.75
