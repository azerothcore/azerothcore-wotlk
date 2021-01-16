INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1610739863539733975');

-- "Chest of The Seven" from Blackrock Depths should spawn in a different position
UPDATE `gameobject` SET `position_x`=1265.55, `position_y`=-284.421, `position_z`=-78.2193, `orientation`=0.786698, `rotation2`=-0.383284, `rotation3`=-0.923631 WHERE `guid`=67872;
