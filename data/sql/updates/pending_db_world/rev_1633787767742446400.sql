INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633787767742446400');

ALTER TABLE `spell_custom_attr`
	ADD COLUMN `attributes1` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'SpellCustomAttributes1' AFTER `attributes`;
