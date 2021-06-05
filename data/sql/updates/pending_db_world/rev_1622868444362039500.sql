INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622868444362039500');

SET @NPC = 17610;

UPDATE `creature` 
SET `position_x` = -505.063416, `position_y` = 1155.307861, `position_z` = 63.713577, `wander_distance` = 10, `MovementType` = 1 
WHERE `guid` = @NPC;