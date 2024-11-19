-- DB update 2021_09_13_09 -> 2021_09_13_10
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_13_09';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_13_09 2021_09_13_10 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631368907971857000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631368907971857000');

SET @ID = 2045;

# Sets position of stranglekelp to positions gathered from Wowhead
UPDATE `gameobject` SET `position_x` = -860.287476, `position_y` = -3811.75, `position_z` = 2.997894 WHERE `id` = @ID AND `guid` = 8231;
UPDATE `gameobject` SET `position_x` = -988.582275, `position_y` = -3831.728271, `position_z` = -22.586107 WHERE `id` = @ID AND `guid` = 8382;
UPDATE `gameobject` SET `position_x` = -981.448547, `position_y` = -3812.717285, `position_z` = -20.767349 WHERE `id` = @ID AND `guid` = 8383;
UPDATE `gameobject` SET `position_x` = -995.412476, `position_y` = -3720.549805, `position_z` = 3.327584 WHERE `id` = @ID AND `guid` = 8384;
UPDATE `gameobject` SET `position_x` = -1191.343872, `position_y` = -3811.750000, `position_z` = 4.271667 WHERE `id` = @ID AND `guid` = 8425;
UPDATE `gameobject` SET `position_x` = -1326.468872, `position_y` = -4034.682617, `position_z` = 7.943251 WHERE `id` = @ID AND `guid` = 8426;
UPDATE `gameobject` SET `position_x` = -1921.018921, `position_y` = -3750.950195, `position_z` = -0.358390 WHERE `id` = @ID AND `guid` = 8452;
UPDATE `gameobject` SET `position_x` = -1981.825073, `position_y` = -3750.950195, `position_z` = 1.099884 WHERE `id` = @ID AND `guid` = 8466;
UPDATE `gameobject` SET `position_x` = -2393.956543, `position_y` = -3781.350098, `position_z` = 0.065314 WHERE `id` = @ID AND `guid` = 8570;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_13_10' WHERE sql_rev = '1631368907971857000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
