-- DB update 2020_11_03_00 -> 2020_11_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_03_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_03_00 2020_11_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1603072521176787100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603072521176787100');

/*
 * Update by Silker | <www.azerothcore.org> | Copyright (C)
*/

UPDATE `creature_template` SET `AIName`='PassiveAI' WHERE `entry`=32866;
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432 WHERE  `entry` IN
(32866, 33690);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
