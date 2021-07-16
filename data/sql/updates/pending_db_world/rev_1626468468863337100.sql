INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626468468863337100');

-- Move herb above ground
UPDATE `gameobject` SET `position_z` = 32.195 WHERE `id` = 2046 AND `guid` = 8802;
