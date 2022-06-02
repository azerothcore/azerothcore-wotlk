-- DB update 2021_07_04_03 -> 2021_07_05_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_04_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_04_03 2021_07_05_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624687532594694252'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624687532594694252');

-- Removes quest requirement from Belamoore's Research Journal junk drop
DELETE FROM `creature_loot_template` WHERE `Entry` = 2415 AND `Item` = 3711;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2415, 3711, 0, 100, 0, 1, 0, 1, 1, 'Warden Belamoore - Belamoore\'s Research Journal');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_05_00' WHERE sql_rev = '1624687532594694252';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
