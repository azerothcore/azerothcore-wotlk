-- DB update 2020_11_06_03 -> 2020_11_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_06_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_06_03 2020_11_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1604182926047452600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1604182926047452600');

/*
 * Update by Silker | <www.azerothcore.org> | Copyright (C)
*/

UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432 WHERE  `entry` IN
(30641, 31521);
UPDATE `creature_template` SET `ScriptName` = 'trigger_periodic' WHERE `entry`= 30641;


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
