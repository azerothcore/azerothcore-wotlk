-- DB update 2021_08_04_00 -> 2021_08_04_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_04_00 2021_08_04_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627383748783756100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627383748783756100');

-- Changed the spawn point of Scarlet High Clerist to the tower south of hearthglen
UPDATE `creature` SET  `position_x` = 2703.07, `position_y` = -1951.61, `position_z` = 107.23 WHERE (`id` = 1839) AND (`guid` = 49764);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_04_01' WHERE sql_rev = '1627383748783756100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
