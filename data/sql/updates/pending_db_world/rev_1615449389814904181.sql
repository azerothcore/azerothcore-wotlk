INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615449389814904181');

-- Add spirit healer to Eastern graveyard in Arathi Highlands
DELETE FROM `creature` WHERE `guid` = 18 AND `id` = 6491;

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`) VALUES
(18,6491,0,1,1,0,0,-1314.78,-3185.29,37.373,5.49505,300,0,0);
