-- DB update 2021_10_10_04 -> 2021_10_10_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_10_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_10_04 2021_10_10_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633073530324719639'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633073530324719639');

-- Slightly changes the position of a Copper Ore that was unreachable
UPDATE `gameobject` SET `position_x` = -5632, `position_y` = -1752, `position_z` = 357.2 WHERE `id` = 1731 AND `guid` = 73532;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_10_05' WHERE sql_rev = '1633073530324719639';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
