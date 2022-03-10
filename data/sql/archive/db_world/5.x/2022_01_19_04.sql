-- DB update 2022_01_19_03 -> 2022_01_19_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_19_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_19_03 2022_01_19_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642175085880779000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642175085880779000');

-- Based on the wrong creatures' position.
-- Left group
UPDATE `creature` SET `position_x` = -7462.55, `position_y` = -1015.27, `position_z` = 408.75, `orientation` = 2.26 WHERE `guid` = 84605;
UPDATE `creature` SET `position_x` = -7484.4, `position_y` = -992.57, `position_z` = 408.74, `orientation` = 2.28 WHERE `guid` = 84606;
UPDATE `creature` SET `position_x` = -7469.89, `position_y` = -1004.51, `position_z` = 408.74, `orientation` = 2.17 WHERE `guid` = 84616;
-- Right group
UPDATE `creature` SET `position_x` = -7505.69, `position_y` = -1007.07, `position_z` = 408.73, `orientation` = 2.19 WHERE `guid` = 84603;
UPDATE `creature` SET `position_x` = -7491.17, `position_y` = -1035.6, `position_z` = 408.74, `orientation` = 2.26 WHERE `guid` = 84614;
UPDATE `creature` SET `position_x` = -7494.95, `position_y` = -1022.22, `position_z` = 408.73, `orientation` = 2.19 WHERE `guid` = 84615;

DELETE FROM `creature` WHERE `guid` IN (84513, 84514, 84515, 84516, 84517, 84518);

DELETE FROM `linked_respawn` WHERE `guid` IN (84513, 84514, 84515, 84516, 84517, 84518, 84603, 84605, 84606, 84614, 84615, 84616);

INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(84603, 84512, 0),
(84605, 84512, 0),
(84606, 84512, 0),
(84614, 84512, 0),
(84615, 84512, 0),
(84616, 84512, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_19_04' WHERE sql_rev = '1642175085880779000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
