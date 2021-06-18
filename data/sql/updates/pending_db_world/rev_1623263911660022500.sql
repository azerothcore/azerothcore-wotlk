INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623263911660022500');

UPDATE `creature_template` SET `speed_walk` = 0.66, `speed_run` = 1  WHERE (`entry` = 14428); -- Set Uruson walk speed to 0.66 and speed run to 1 from sniffs.
