INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633787767742446400');

-- Raise Ally control aura should not be saved
DELETE FROM `spell_custom_attr` WHERE `spell_id`=46619;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(46619, 268435456);
