-- DB update 2021_09_20_06 -> 2021_09_20_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_20_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_20_06 2021_09_20_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631691102244326583'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631691102244326583');

UPDATE `dungeon_access_requirements` SET `leader_only` = 0 WHERE `dungeon_access_id` = 17 AND `requirement_type` = 1 AND `requirement_id` = 10285;
UPDATE `dungeon_access_requirements` SET `faction` = 2 , `leader_only` = 0 WHERE `dungeon_access_id` = 18 AND `requirement_type` = 2 AND `requirement_id` = 30635; 
UPDATE `dungeon_access_requirements` SET `faction` = 2 WHERE `dungeon_access_id` = 41 AND `requirement_type` = 2 AND `requirement_id` = 30623; 
UPDATE `dungeon_access_requirements` SET `faction` = 2 WHERE `dungeon_access_id` = 43 AND `requirement_type` = 2 AND `requirement_id` = 30623; 
UPDATE `dungeon_access_requirements` SET `faction` = 2 WHERE `dungeon_access_id` = 45 AND `requirement_type` = 2 AND `requirement_id` = 30623; 
UPDATE `dungeon_access_requirements` SET `faction` = 2 WHERE `dungeon_access_id` = 49 AND `requirement_type` = 2 AND `requirement_id` = 30634; 
UPDATE `dungeon_access_requirements` SET `faction` = 2 WHERE `dungeon_access_id` = 51 AND `requirement_type` = 2 AND `requirement_id` = 30634; 
UPDATE `dungeon_access_requirements` SET `faction` = 2 WHERE `dungeon_access_id` = 53 AND `requirement_type` = 2 AND `requirement_id` = 30634; 
UPDATE `dungeon_access_requirements` SET `faction` = 2 WHERE `dungeon_access_id` = 55 AND `requirement_type` = 2 AND `requirement_id` = 30633; 
UPDATE `dungeon_access_requirements` SET `faction` = 2 WHERE `dungeon_access_id` = 57 AND `requirement_type` = 2 AND `requirement_id` = 30633; 
UPDATE `dungeon_access_requirements` SET `faction` = 2 WHERE `dungeon_access_id` = 59 AND `requirement_type` = 2 AND `requirement_id` = 30633; 
UPDATE `dungeon_access_requirements` SET `faction` = 2 WHERE `dungeon_access_id` = 61 AND `requirement_type` = 2 AND `requirement_id` = 30633; 
UPDATE `dungeon_access_requirements` SET `faction` = 2 WHERE `dungeon_access_id` = 63 AND `requirement_type` = 2 AND `requirement_id` = 30635; 
UPDATE `dungeon_access_requirements` SET `leader_only` = 0 WHERE `dungeon_access_id` = 77 AND `requirement_type` = 1 AND `requirement_id` = 11492;
UPDATE `dungeon_access_requirements` SET `leader_only` = 0 WHERE `dungeon_access_id` = 114 AND `requirement_type` = 1 AND `requirement_id` = 24499; 
UPDATE `dungeon_access_requirements` SET `leader_only` = 0 WHERE `dungeon_access_id` = 114 AND `requirement_type` = 1 AND `requirement_id` = 24511; 
UPDATE `dungeon_access_requirements` SET `leader_only` = 0 WHERE `dungeon_access_id` = 115 AND `requirement_type` = 1 AND `requirement_id` = 24499; 
UPDATE `dungeon_access_requirements` SET `leader_only` = 0 WHERE `dungeon_access_id` = 115 AND `requirement_type` = 1 AND `requirement_id` = 24511; 
UPDATE `dungeon_access_requirements` SET `leader_only` = 0 WHERE `dungeon_access_id` = 116 AND `requirement_type` = 1 AND `requirement_id` = 24710; 
UPDATE `dungeon_access_requirements` SET `leader_only` = 0 WHERE `dungeon_access_id` = 116 AND `requirement_type` = 1 AND `requirement_id` = 24712; 
UPDATE `dungeon_access_requirements` SET `leader_only` = 0 WHERE `dungeon_access_id` = 117 AND `requirement_type` = 1 AND `requirement_id` = 24710; 
UPDATE `dungeon_access_requirements` SET `leader_only` = 0 WHERE `dungeon_access_id` = 117 AND `requirement_type` = 1 AND `requirement_id` = 24712;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_20_07' WHERE sql_rev = '1631691102244326583';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
