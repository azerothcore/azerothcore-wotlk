-- DB update 2021_08_17_01 -> 2021_08_17_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_17_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_17_01 2021_08_17_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1628938293777910785'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628938293777910785');

-- Add movement to Draconic Mageweaver
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `guid` = 36427 AND `id` = 6131;
-- Add movement to Makrinni Razorclaw
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `guid` = 36013 AND `id` = 6350;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_17_02' WHERE sql_rev = '1628938293777910785';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
