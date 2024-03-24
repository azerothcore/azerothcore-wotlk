-- DB update 2021_05_02_01 -> 2021_05_02_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_02_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_02_01 2021_05_02_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619976848278136900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619976848278136900');

-- Durotar | GUID 4815 | issue #5571
UPDATE `gameobject` SET `position_x`=-246.69, `position_y`=-5237.25, `position_z`=2.6372 WHERE `guid`=4815;

-- Thousand Needles | GUID 5365 | issue #5584
UPDATE `gameobject` SET `position_x`=-4859.25, `position_y`=-1798.27, `position_z`=-41.880 WHERE `guid`=5365;


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
