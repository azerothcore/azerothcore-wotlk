-- DB update 2019_09_15_00 -> 2019_09_16_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_09_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_09_15_00 2019_09_16_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1567713200326299359'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1567713200326299359');

UPDATE `creature_template` SET `flags_extra`= 0 WHERE `entry` IN (26638,31351);
 
UPDATE `creature_template` SET `faction`= 16  WHERE `entry` IN (26620,31339);

DELETE FROM `creature_addon` WHERE `guid` = 127438;
INSERT INTO `creature_addon` (`guid`, `bytes2`, `emote`) VALUES 
(127438, 1, 36);

DELETE FROM `smart_scripts` WHERE `entryorguid`= 26623  AND `id` IN (10,11);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-127591,-127590,-127589,-127582,-127580,-127579,-127578);

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (127590,127580,127449,127579);

INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(127590, 127590, 0, 0, 3, 0, 0),
(127590, 127438, 0, 0, 3, 0, 0),
(127590, 127617, 0, 0, 3, 0, 0),
(127590, 127589, 0, 0, 3, 0, 0),
(127580, 127580, 0, 0, 3, 0, 0),
(127580, 127427, 0, 0, 3, 0, 0),
(127580, 127428, 0, 0, 3, 0, 0),
(127449, 127449, 0, 0, 3, 0, 0),
(127449, 127451, 0, 0, 3, 0, 0),
(127449, 127591, 0, 0, 3, 0, 0),
(127449, 127582, 0, 0, 3, 0, 0),
(127579, 127579, 0, 0, 3, 0, 0),
(127579, 127578, 0, 0, 3, 0, 0),
(127579, 127432, 0, 0, 3, 0, 0),
(127579, 127433, 0, 0, 3, 0, 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
