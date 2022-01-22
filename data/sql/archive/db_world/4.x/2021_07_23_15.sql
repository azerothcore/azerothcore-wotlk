-- DB update 2021_07_23_14 -> 2021_07_23_15
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_23_14';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_23_14 2021_07_23_15 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626884022511079500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626884022511079500');

-- Slowed the movement speed of Dragonmaw Battlemaster from 1.54 to 1 as the rest of the orcs there
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 1037);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_23_15' WHERE sql_rev = '1626884022511079500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
