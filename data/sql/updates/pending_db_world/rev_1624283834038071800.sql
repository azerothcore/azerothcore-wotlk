INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624283834038071800');

UPDATE `creature_template` SET `unit_flags` = `unit_flags`|4|131072, `flags_extra` = `flags_extra`|2|256|8388608 WHERE (`entry` = 17680);
