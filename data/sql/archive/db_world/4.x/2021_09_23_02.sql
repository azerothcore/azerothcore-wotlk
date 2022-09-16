-- DB update 2021_09_23_01 -> 2021_09_23_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_23_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_23_01 2021_09_23_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620466647964636420'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620466647964636420');

UPDATE `creature` SET `position_x`=-7133.56, `position_y`=-3161.51, `position_z`=244.252, `orientation` = 1.04837 WHERE `guid`=6947;
UPDATE `creature` SET `position_x`=-6650.07, `position_y`=-3484.77, `position_z`=258.771, `orientation` = 1.16804 WHERE `guid`=7614;
UPDATE `creature` SET `position_x`=-6649.06, `position_y`=-3482.49, `position_z`=263.517, `orientation` = 4.37896 WHERE `guid`=6915;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_23_02' WHERE sql_rev = '1620466647964636420';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
