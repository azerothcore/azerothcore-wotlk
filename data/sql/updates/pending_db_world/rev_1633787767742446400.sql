INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633787767742446400');

ALTER TABLE `spell_custom_attr`
	ADD COLUMN `attributes1` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'SpellCustomAttributes1' AFTER `attributes`;

-- Raise Ally control aura
DELETE FROM `spell_custom_attr` WHERE `spell_id`=46619;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`, `attributes1`) VALUES
(46619, 0, 2);
