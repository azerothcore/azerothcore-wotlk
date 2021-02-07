INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612676592853947300');

-- Stoneclaw Totem effect
UPDATE `spell_custom_attr` SET `attributes`=`attributes`|32 WHERE `spell_id` = 5729;
