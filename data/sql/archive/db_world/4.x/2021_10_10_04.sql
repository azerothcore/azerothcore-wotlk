-- DB update 2021_10_10_03 -> 2021_10_10_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_10_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_10_03 2021_10_10_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633030444663834900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633030444663834900');

DELETE FROM `smart_scripts` WHERE `entryorguid`=6746 AND `id`>1;
INSERT INTO `smart_scripts` VALUES
(6746,0,2,3,62,0,100,0,21215,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Innkeeper Pala - On gossip option 0 select - Close gossip'),
(6746,0,3,0,61,0,100,0,0,0,0,0,0,85,24751,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Innkeeper Pala - On gossip option 0 select - Player cast Trick or Treat on self');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_10_04' WHERE sql_rev = '1633030444663834900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
