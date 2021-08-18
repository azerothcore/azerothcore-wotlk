INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628999064175305912');

-- Change Primitive Owlbeast spawn to above ground, add random movement
UPDATE `creature` SET `position_x` = 182.04, `position_y` = -3549.64, `position_z` = 130, `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 2928 AND `guid` = 92955;

