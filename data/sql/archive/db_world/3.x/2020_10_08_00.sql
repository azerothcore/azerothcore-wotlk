-- DB update 2020_10_07_01 -> 2020_10_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_10_07_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_10_07_01 2020_10_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1598710166600374331'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598710166600374331');
UPDATE `creature` SET `position_x`=-7249.024, `position_y`=-937.411, `position_z`=168.396, `orientation`=4.995 WHERE `guid`=5231;
UPDATE `creature` SET `position_x`=-7249.391, `position_y`=-939.451, `position_z`=168.207, `orientation`=0.638 WHERE `guid`=5848;
UPDATE `creature` SET `position_x`=-7276.807, `position_y`=-877.667, `position_z`=169.758, `orientation`=3.428 WHERE `guid`=5747;
UPDATE `creature` SET `position_x`=-7279.149, `position_y`=-877.149, `position_z`=169.645, `orientation`=6.164 WHERE `guid`=3756;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
