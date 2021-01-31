-- DB update 2019_05_31_00 -> 2019_06_01_00

-- Define helper functions
DROP FUNCTION IF EXISTS InsertStrangeOreNode;

DELIMITER $$

CREATE FUNCTION InsertStrangeOreNode(position_x double, position_y double, position_z double, orientation double)
RETURNS decimal
DETERMINISTIC
BEGIN
	INSERT INTO `gameobject`(`id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
	(188699, 571, 0, 0, 1, 1, position_x, position_y, position_z, orientation, 0, 0, 0, 0, 300, 100, 1, '', 0);

	SET @NEW_GUID := LAST_INSERT_ID();

	RETURN @NEW_GUID;
END $$

DELIMITER ;

-- Begin update
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_31_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_31_00 2019_06_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1558652406081124000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558652406081124000');

-- Remove old Strange Ore nodes

DELETE FROM `gameobject` where `id` = 188699 and `map` = 571;

-- Insert Strange Ore nodes

SET @rc := InsertStrangeOreNode(3898.41, -874.94, 109.69, 5.13);
SET @rc := InsertStrangeOreNode(3910.97, -868.05, 107.67, 2.02);
SET @rc := InsertStrangeOreNode(3939.70, -869.39, 104.37, 5.46);
SET @rc := InsertStrangeOreNode(3956.76, -864.70, 104.16, 3.24);
SET @rc := InsertStrangeOreNode(3971.40, -862.84, 104.68, 0.13);
SET @rc := InsertStrangeOreNode(3967.61, -902.46, 104.68, 5.61);
SET @rc := InsertStrangeOreNode(3969.14, -922.30, 106.98, 3.50);
SET @rc := InsertStrangeOreNode(3987.90, -902.99, 107.33, 4.00);
SET @rc := InsertStrangeOreNode(4007.40, -911.82, 107.20, 2.24);
SET @rc := InsertStrangeOreNode(4016.82, -885.51, 110.17, 0.66);
SET @rc := InsertStrangeOreNode(4059.49, -902.67, 116.14, 3.16);
SET @rc := InsertStrangeOreNode(4078.81, -907.17, 115.57, 0.52);
SET @rc := InsertStrangeOreNode(4070.35, -868.52, 114.24, 1.51);
SET @rc := InsertStrangeOreNode(4078.17, -855.47, 112.71, 4.03);
SET @rc := InsertStrangeOreNode(4103.27, -867.37, 113.54, 1.35);
SET @rc := InsertStrangeOreNode(4110.56, -847.12, 116.59, 4.13);
SET @rc := InsertStrangeOreNode(4038.53, -813.69, 123.35, 1.42);
SET @rc := InsertStrangeOreNode(3979.26, -877.96, 119.18, 2.16);
SET @rc := InsertStrangeOreNode(3957.79, -891.33, 119.49, 3.42);
SET @rc := InsertStrangeOreNode(4004.26, -781.90, 118.49, 5.55);
SET @rc := InsertStrangeOreNode(4017.86, -766.48, 119.13, 2.14);
SET @rc := InsertStrangeOreNode(3993.02, -789.91, 122.71, 3.03);
SET @rc := InsertStrangeOreNode(3979.85, -815.04, 124.89, 4.21);
SET @rc := InsertStrangeOreNode(3956.10, -839.98, 122.27, 3.13);
SET @rc := InsertStrangeOreNode(3945.32, -858.50, 122.96, 1.55);
SET @rc := InsertStrangeOreNode(3926.84, -850.59, 123.78, 3.51);
SET @rc := InsertStrangeOreNode(3926.00, -862.90, 122.24, 4.11);
SET @rc := InsertStrangeOreNode(3906.27, -870.06, 122.12, 1.14);
SET @rc := InsertStrangeOreNode(4001.21, -967.61, 104.52, 4.52);
SET @rc := InsertStrangeOreNode(4000.94, -938.04, 105.72, 6.05);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

-- Clean up helper functions
DROP FUNCTION IF EXISTS InsertStrangeOreNode;
