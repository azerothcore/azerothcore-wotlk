-- DB update 2022_01_30_00 -> 2022_01_30_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_30_00 2022_01_30_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642867700594743900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642867700594743900');

UPDATE `creature` SET `position_x`=-8947.64, `position_y`=-132.319, `position_z`=83.7199, `orientation`=3.33358 WHERE `id1`=823;
UPDATE `creature` SET `position_x`=10314, `position_y`=829.83, `position_z`=1326.48, `orientation`=2.54818 WHERE `id1`=2079;
UPDATE `creature` SET `position_x`=10352, `position_y`=-6359.93, `position_z`=34.1146, `orientation`=2.07694 WHERE `id1`=15278;
UPDATE `creature` SET `position_x`=-610.073, `position_y`=-4253.52, `position_z`=39.0393, `orientation`=3.28122 WHERE `id1`=10176;
UPDATE `creature` SET `position_x`=-6236.74, `position_y`=331.113, `position_z`=382.911, `orientation`=3.00197 WHERE `id1`=658;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_30_01' WHERE sql_rev = '1642867700594743900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
