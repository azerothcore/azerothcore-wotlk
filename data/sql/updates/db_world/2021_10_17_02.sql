-- DB update 2021_10_17_01 -> 2021_10_17_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_17_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_17_01 2021_10_17_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634045250480483175'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634045250480483175');

-- Deletes Black Metal War Axe from the RLT 24068
DELETE FROM `reference_loot_template` WHERE `Entry` = 24068 AND `Item` = 2015;

-- Adds Black Metal War Axe to Brain Eaters directly
DELETE FROM `creature_loot_template` WHERE `Entry` = 570 AND `Item` = 2015;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(570, 2015, 0, 0.9, 0, 1, 0, 1, 1, '');

-- Reduces the drop chance of Nightcrawler to not exceed 100 % overall loot chance for Brain Eaters
UPDATE `creature_loot_template` SET `Chance` = 32.28 WHERE `Entry` = 570 AND `Item` = 6530;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_17_02' WHERE sql_rev = '1634045250480483175';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
