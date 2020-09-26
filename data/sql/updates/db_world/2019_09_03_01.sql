-- DB update 2019_09_03_00 -> 2019_09_03_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_09_03_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_09_03_00 2019_09_03_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1567205199450545499'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1567205199450545499');

DELETE FROM `trinity_string` WHERE `entry` IN (30077,30078,30079);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`)
VALUES
(30077,'Toggle Instant Flight',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30078,'Instant Flight ON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30079,'Instant Flight OFF',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
