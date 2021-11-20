-- DB update 2020_09_06_00 -> 2020_09_06_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_09_06_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_09_06_00 2020_09_06_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1598880966895655100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598880966895655100');
/*
 * General: Build Update
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* Content 3.3.0 */ 
SET @Build := 11159;

UPDATE `gameobject_template` SET `VerifiedBuild` = @Build WHERE `entry` IN (202443, 202616, 202218);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
