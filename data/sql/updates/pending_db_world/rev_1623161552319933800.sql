INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623161552319933800');

SET @NPC = 6707;

UPDATE `creature` 
SET `position_x` = -9296.069336, `position_y` = -1887.173462, `position_z` = 78.376251
WHERE `guid` = @NPC;
