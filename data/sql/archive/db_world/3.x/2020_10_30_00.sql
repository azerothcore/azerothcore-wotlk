-- DB update 2020_10_28_01 -> 2020_10_30_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_10_28_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_10_28_01 2020_10_30_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601451772137449700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601451772137449700');

/*
 * Update by Silker | <www.azerothcore.org> | Copyright (C)
*/

-- https://www.wowhead.com/npc=34607/nerubian-burrower
UPDATE `creature_template` SET `minlevel`=82, `maxlevel`=82 WHERE `entry` IN 
(34607, 34648, 35655, 35656);

-- https://www.wowhead.com/npc=34605/swarm-scarab  (maxlevel is already 80)
UPDATE `creature_template` SET `minlevel`=80 WHERE `entry` IN 
(34605, 34650, 35658, 35659);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
