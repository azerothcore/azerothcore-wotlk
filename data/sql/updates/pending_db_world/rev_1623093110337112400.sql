INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623093110337112400');

SET @NPC = 30504;

UPDATE `creature` 
SET `position_x` = -4960.708496, `position_y` = -3828.589600, `position_z` = 43.382378, `wander_distance` = 5, `MovementType` = 1 
WHERE `guid` = @NPC;
