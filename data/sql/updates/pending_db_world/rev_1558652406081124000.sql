INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558652406081124000');

-- Define helper functions

DROP FUNCTION IF EXISTS InsertStrangeOreNode;

DELIMITER $$

CREATE FUNCTION InsertStrangeOreNode(position_x double, position_y double, position_z double)
RETURNS decimal
DETERMINISTIC
BEGIN
	SET @RND_ORIENTATION := (RAND() / 3.3) * 10;
	
	INSERT INTO `gameobject`(`id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
	(188699, 571, 0, 0, 1, 1, position_x, position_y, position_z, @RND_ORIENTATION, 0, 0, 0, 0, 300, 100, 1, '', 0);

	SET @NEW_GUID := LAST_INSERT_ID();

	RETURN @NEW_GUID;
END $$

DELIMITER ;

-- Remove old Strange Ore nodes

DELETE FROM `gameobject` where `id` = 188699 and `map` = 571;

-- Insert Strange Ore nodes

SET @rc := InsertStrangeOreNode(3898.41, -874.94, 109.69);
SET @rc := InsertStrangeOreNode(3910.97, -868.05, 107.67);
SET @rc := InsertStrangeOreNode(3939.70, -869.39, 104.37);
SET @rc := InsertStrangeOreNode(3956.76, -864.70, 104.16);
SET @rc := InsertStrangeOreNode(3971.40, -862.84, 104.68);
SET @rc := InsertStrangeOreNode(3967.61, -902.46, 104.68);
SET @rc := InsertStrangeOreNode(3969.14, -922.30, 106.98);
SET @rc := InsertStrangeOreNode(3987.90, -902.99, 107.33);
SET @rc := InsertStrangeOreNode(4007.40, -911.82, 107.20);
SET @rc := InsertStrangeOreNode(4016.82, -885.51, 110.17);
SET @rc := InsertStrangeOreNode(4059.49, -902.67, 116.14);
SET @rc := InsertStrangeOreNode(4078.81, -907.17, 115.57);
SET @rc := InsertStrangeOreNode(4070.35, -868.52, 114.24);
SET @rc := InsertStrangeOreNode(4078.17, -855.47, 112.71);
SET @rc := InsertStrangeOreNode(4103.27, -867.37, 113.54);
SET @rc := InsertStrangeOreNode(4110.56, -847.12, 116.59);
SET @rc := InsertStrangeOreNode(4038.53, -813.69, 123.35);
SET @rc := InsertStrangeOreNode(3979.26, -877.96, 119.18);
SET @rc := InsertStrangeOreNode(3957.79, -891.33, 119.49);
SET @rc := InsertStrangeOreNode(4004.26, -781.90, 118.49);
SET @rc := InsertStrangeOreNode(4017.86, -766.48, 119.13);
SET @rc := InsertStrangeOreNode(3993.02, -789.91, 122.71);
SET @rc := InsertStrangeOreNode(3979.85, -815.04, 124.89);
SET @rc := InsertStrangeOreNode(3956.10, -839.98, 122.27);
SET @rc := InsertStrangeOreNode(3945.32, -858.50, 122.96);
SET @rc := InsertStrangeOreNode(3926.84, -850.59, 123.78);
SET @rc := InsertStrangeOreNode(3926.00, -862.90, 122.24);
SET @rc := InsertStrangeOreNode(3906.27, -870.06, 122.12);
SET @rc := InsertStrangeOreNode(4001.21, -967.61, 104.52);
SET @rc := InsertStrangeOreNode(4000.94, -938.04, 105.72);

-- Clean up helper functions

DROP FUNCTION IF EXISTS InsertStrangeOreNode;

