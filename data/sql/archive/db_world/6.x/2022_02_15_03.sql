-- DB update 2022_02_15_02 -> 2022_02_15_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_15_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_15_02 2022_02_15_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642639045919873206'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642639045919873206');

#closes #10227
UPDATE `creature` SET `position_x`=-5026.72, `position_y`=-949.15, `position_z`=61.9471, `orientation`=4.07623 WHERE `guid`=21706;
UPDATE `creature` SET `position_x`=-5195.02, `position_y`=-1213.47, `position_z`=116.165, `orientation`=1.10743, `MovementType`=0 WHERE `guid`=21708;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_15_03' WHERE sql_rev = '1642639045919873206';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
