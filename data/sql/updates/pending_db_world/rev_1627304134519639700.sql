INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627304134519639700');

-- Changed the coords just a bit to assure that no dwarf spawns in the same place as other
UPDATE `creature` SET `position_x` = -7183.29, `position_y` = -881.80, `position_z` = 163.93 WHERE (`id` = 24818) AND (`guid` = 4566);
UPDATE `creature` SET `position_x` = -7339.15, `position_y` = -1020.25, `position_z` = 178.65  WHERE (`id` = 24818) AND (`guid` = 5727);

