-- DB update 2021_06_14_01 -> 2021_06_17_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_14_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_14_01 2021_06_17_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622504741914151600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622504741914151600');

DELETE FROM `acore_string` WHERE `entry` IN (713, 726);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(713, 'Queue status for %s (skirmish %s) (Lvl: %u to %u)\nQueued: %u (Need at least %u more)'),
(726, '|cffff0000[Arena Queue]:|r %s (skirmish %s) -- [%u-%u] [%u/%u]|r');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_17_00' WHERE sql_rev = '1622504741914151600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
