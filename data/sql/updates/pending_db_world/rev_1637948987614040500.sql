INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637948987614040500');

UPDATE `creature_template` SET `flags_extra` = `flags_extra` |128, `ScriptName` = '' WHERE `entry` = 12758;
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` = 11262;
