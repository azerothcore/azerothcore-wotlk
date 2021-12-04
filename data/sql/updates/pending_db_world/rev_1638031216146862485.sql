INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638031216146862485');

-- Add missing random movement to Sarkoth
UPDATE `creature` SET `wander_distance`=25, `MovementType`=1 WHERE `guid`=12263;
