INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1610385898427311800');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (48777,7215,48776);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(48777,'spell_item_with_mount_speed'),
(7215,'spell_item_with_mount_speed'),
(48776,'spell_item_with_mount_speed');
