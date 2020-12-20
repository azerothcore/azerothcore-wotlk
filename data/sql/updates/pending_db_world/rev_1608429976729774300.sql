INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1608429976729774300');

UPDATE `spell_proc_event` SET `procFlags` = 16384, `CustomChance` = 0 WHERE `entry` = -51940;
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_earthliving_weapon';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-51940, 'spell_sha_earthliving_weapon');
