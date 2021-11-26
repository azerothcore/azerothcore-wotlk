INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637861417456909900');

SET @flag := 268435456;

UPDATE `spell_custom_attr` SET `attributes` = 16777216 WHERE `spell_id` = (SELECT `spell_id` WHERE `attributes` & @flag = @flag);
