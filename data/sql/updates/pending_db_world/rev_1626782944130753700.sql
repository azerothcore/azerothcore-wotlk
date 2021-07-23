INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626782944130753700');

-- Changed the spawn point of Spellmaw closer to the ground and added patrolling around
UPDATE `creature` SET `position_x` = 6247.134, `position_y` = -4412.64, `position_z` = 687.228, `orientation` = 4.67879, `wander_distance` = 20,`MovementType` = 1  WHERE (`id` = 10662) AND (`guid` = 42265);

