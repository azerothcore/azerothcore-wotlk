INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628955615714597262');

-- Shift Silvermane Stalker spawn slightly to avoid tree
UPDATE `creature` SET `position_x` = -108.08, `position_y` = -3529.83, `position_z` = 118.49  WHERE `id` = 2926 AND `guid` = 93058;

