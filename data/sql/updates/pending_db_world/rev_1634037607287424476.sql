INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634037607287424476');

-- Sets flying Arthas' Tears to the ground
UPDATE `gameobject` SET `position_z` = 59.5 WHERE `id` = 142141 AND `guid` = 15968;
