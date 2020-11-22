-- DB update 2020_11_22_00 -> 2020_11_22_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_22_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_22_00 2020_11_22_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1605911267657207700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1605911267657207700');

/*
 * Update by Silker | <www.azerothcore.org> | Copyright (C)
*/

-- fix models
UPDATE `creature_template` SET `modelid1`=23258, `modelid2`=0 WHERE `entry` IN
(33395, 33402);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
