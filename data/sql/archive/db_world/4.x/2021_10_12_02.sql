-- DB update 2021_10_12_01 -> 2021_10_12_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_12_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_12_01 2021_10_12_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633365891402740400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633365891402740400');

-- Alliance only(5401)
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`|1|4|8|64|1024 WHERE (`ID` = 5401);

-- Horde only(5405)
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`|2|16|32|128|512 WHERE (`ID` = 5405);

-- Changed from Argent Officer Pureheart to Argent Officer Garush.
DELETE FROM `creature_queststarter` WHERE (`quest` = 5405) AND (`id` IN (10857, 10839));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(10839, 5405);

DELETE FROM `creature_questender` WHERE (`quest` = 5405) AND (`id` IN (10857, 10839));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(10839, 5405);

-- Changed from Argent Officer Garush to Duke Nicholas Zverenhoff  For the neutral quest(5503)
DELETE FROM `creature_queststarter` WHERE (`quest` = 5503) AND (`id` IN (10839, 11039));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(11039, 5503);

DELETE FROM `creature_questender` WHERE (`quest` = 5503) AND (`id` IN (10839, 11039));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(11039, 5503);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_12_02' WHERE sql_rev = '1633365891402740400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
