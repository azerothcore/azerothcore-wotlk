-- DB update 2021_12_04_02 -> 2021_12_04_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_04_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_04_02 2021_12_04_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638624697731724160'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638624697731724160');

-- groups Rage Talon Captains 137860 and 137861 with their formations
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (137860, 137861);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(137860, 137860, 0, 0, 3, 0, 0),
(137860, 137866, 0, 0, 3, 0, 0),
(137860, 137961, 0, 0, 3, 0, 0),
(137860, 137963, 0, 0, 3, 0, 0),
(137860, 137994, 0, 0, 3, 0, 0),
(137861, 137861, 0, 0, 3, 0, 0),
(137861, 137867, 0, 0, 3, 0, 0),
(137861, 137982, 0, 0, 3, 0, 0),
(137861, 137981, 0, 0, 3, 0, 0),
(137861, 137863, 0, 0, 3, 0, 0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_04_03' WHERE sql_rev = '1638624697731724160';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
