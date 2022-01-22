-- DB update 2021_05_13_04 -> 2021_05_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_13_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_13_04 2021_05_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620425644910599900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620425644910599900');

-- Delete WP path info for minions
DELETE FROM `creature_addon` WHERE `guid` IN (6973, 6975, 6974 ,6989 ,7210);

-- Create group
SET @leader:=7209;
DELETE FROM `creature_formations` WHERE `leaderGUID`=@leader;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(@leader, @leader, 5, 0, 2, 0, 0), -- core
(@leader, 6973, 8, 90, 2, 0, 0),
(@leader, 6975, 14, 140, 2, 0, 0),
(@leader, 6974, 16, 210, 2, 0, 0),
(@leader, 6989, 12, 260, 2, 0, 0),
(@leader, 7210, 10, 320, 2, 0, 0);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
