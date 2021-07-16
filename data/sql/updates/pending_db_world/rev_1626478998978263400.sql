INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626478998978263400');

-- Move Termite Mound to the ground
UPDATE `gameobject` SET `position_z` = 145.3 WHERE `id` = 177464 AND `guid` = 45874;
