-- DB update 2021_07_07_04 -> 2021_07_07_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_07_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_07_04 2021_07_07_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625379465170274070'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625379465170274070');

-- Removes Stonemason's Cloak from RLT 24078'
DELETE FROM `reference_loot_template` WHERE `Entry` = 24078 AND `Item` = 1930;

-- Adds Stonemason's Cloak to Defias Miner with 3% drop rate
DELETE FROM `creature_loot_template` WHERE `Entry` = 598 AND `Item` = 1930;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(598, 1930, 0, 3, 0, 1, 1, 1, 1, 'Defias Miner - Stonemason\'s Cloak');


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_07_05' WHERE sql_rev = '1625379465170274070';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
