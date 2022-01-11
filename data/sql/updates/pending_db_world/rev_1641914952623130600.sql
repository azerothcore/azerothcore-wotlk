INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641914952623130600');

UPDATE `creature_template_addon` SET auras = REPLACE(auras, ',', ' ');
