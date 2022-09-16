-- DB update 2021_06_09_02 -> 2021_06_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_09_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_09_02 2021_06_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622621882267236728'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622621882267236728');

-- These murlocs aren't guarding anything so they should wander around
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE `guid` IN (37854, 37951, 37955, 37967, 37974) AND `id` BETWEEN 2201 AND 2208;

-- Murloc 37990 should face the bonfire he's standing next to
UPDATE `creature` SET `orientation` = 5.9828 WHERE `guid` = 37990 AND `id` BETWEEN 2201 AND 2208;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_10_00' WHERE sql_rev = '1622621882267236728';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
