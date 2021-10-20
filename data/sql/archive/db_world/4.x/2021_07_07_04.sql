-- DB update 2021_07_07_03 -> 2021_07_07_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_07_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_07_03 2021_07_07_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625375927776772391'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625375927776772391');

-- Delete Blackwater Cutlass from RLT 24078
DELETE FROM `reference_loot_template` WHERE `Entry` = 24078 AND `Item` = 1951;

-- Blackwater Cutlass added to Defias Pirate loot table with 6% drop rate
DELETE FROM `creature_loot_template` WHERE `Entry` = 657 AND `Item` = 1951;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(657, 1951, 0, 6, 0, 1, 1, 1, 1, 'Blackwater Cutlass');

-- Blackwater Cutlass added to Defias Squallshaper loot table with 6% drop rate
DELETE FROM `creature_loot_template` WHERE `Entry` = 1732 AND `Item` = 1951;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1732, 1951, 0, 6, 0, 1, 1, 1, 1, 'Blackwater Cutlass');



--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_07_04' WHERE sql_rev = '1625375927776772391';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
