-- DB update 2020_05_09_00 -> 2020_05_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_09_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_09_00 2020_05_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1585996374442685300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1585996374442685300');

-- fix creatures come together and don't move randomly
UPDATE `creature` SET `position_x`=5608.7485, `position_y`=5587.217, `position_z`=-88.64437, `wander_distance`=8, `MovementType`=1 WHERE `guid`=104560;
UPDATE `creature` SET `position_x`=5659.1381, `position_y`=5556.411, `position_z`=-85.08512, `wander_distance`=8, `MovementType`=1 WHERE `guid`=104561;
UPDATE `creature` SET `position_x`=5618.4741, `position_y`=5537.622, `position_z`=-88.30284, `wander_distance`=8, `MovementType`=1 WHERE `guid`=105391;
UPDATE `creature` SET `position_x`=5638.1625, `position_y`=5495.338, `position_z`=-84.40144, `wander_distance`=8, `MovementType`=1 WHERE `guid`=105390;
UPDATE `creature` SET `position_x`=5814.5957, `position_y`=5253.0585, `position_z`=-94.8729 WHERE `guid`=132681;
UPDATE `creature` SET `position_x`=5815.2612, `position_y`=5248.3652, `position_z`=-81.3897 WHERE `guid`=132860;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
