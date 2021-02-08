-- DB update 2020_10_19_00 -> 2020_10_22_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_10_19_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_10_19_00 2020_10_22_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601269291015416700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601269291015416700');

/*
 * Update by Silker | <www.azerothcore.org> | Copyright (C)
*/

-- = Thaddius 25 = 29448 -------------------------------------------------------------------------------

-- Create referenced tokens into the reference table
DELETE FROM `reference_loot_template` WHERE `Entry`=34380;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES 
(34380, 40634, 0, 0, 0, 1, 1, 1, 1),
(34380, 40635, 0, 0, 0, 1, 1, 1, 1),
(34380, 40636, 0, 0, 0, 1, 1, 1, 1);

-- Insert reference loot into the creature loot temlate
DELETE FROM `creature_loot_template` WHERE `Entry`=29448 AND `Reference`=34380;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES 
(29448, 2, 34380, 100, 0, 1, 0, 1, 2);

-- Delete old tokens which are separetely placed
DELETE FROM `creature_loot_template` WHERE  `Entry`=29448 AND `Item` IN (40634, 40635, 40636);


-- = Loatheb 25 = 29718 -------------------------------------------------------------------------------

-- Create referenced tokens into the reference table
DELETE FROM `reference_loot_template` WHERE `Entry`=34381;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES 
(34381, 40637, 0, 0, 0, 1, 1, 1, 1),
(34381, 40638, 0, 0, 0, 1, 1, 1, 1),
(34381, 40639, 0, 0, 0, 1, 1, 1, 1);

-- Insert reference loot into the creature loot temlate
DELETE FROM `creature_loot_template` WHERE `Entry`=29718 AND `Reference`=34381;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES 
(29718, 2, 34381, 100, 0, 1, 0, 1, 2);

-- Delete old tokens which are separetely placed
DELETE FROM `creature_loot_template` WHERE  `Entry`=29718 AND `Item` IN (40637, 40638, 40639);


-- = Four horsemen 25 = 25193 (data1)

-- Create referenced tokens into the reference table
DELETE FROM `reference_loot_template` WHERE `Entry`=34382;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES 
(34382, 40625, 0, 0, 0, 1, 1, 1, 1),
(34382, 40626, 0, 0, 0, 1, 1, 1, 1),
(34382, 40627, 0, 0, 0, 1, 1, 1, 1);

-- Insert reference loot into the creature loot temlate
DELETE FROM `gameobject_loot_template` WHERE `Entry`=25193 AND `Reference`=34382;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES 
(25193, 2, 34382, 100, 0, 1, 0, 1, 2);

-- Delete tokens which are separetely placed
DELETE FROM `gameobject_loot_template` WHERE  `Entry`=25193 AND `Item` IN (40625, 40626, 40627);


-- = Gluth 25 = 29417

-- Create referenced tokens into the reference table
DELETE FROM `reference_loot_template` WHERE `Entry`=34383;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES 
(34383, 40625, 0, 0, 0, 1, 1, 1, 1),
(34383, 40626, 0, 0, 0, 1, 1, 1, 1),
(34383, 40627, 0, 0, 0, 1, 1, 1, 1),
(34383, 40634, 0, 0, 0, 1, 1, 1, 1),
(34383, 40635, 0, 0, 0, 1, 1, 1, 1),
(34383, 40636, 0, 0, 0, 1, 1, 1, 1),
(34383, 40637, 0, 0, 0, 1, 1, 1, 1),
(34383, 40638, 0, 0, 0, 1, 1, 1, 1),
(34383, 40639, 0, 0, 0, 1, 1, 1, 1);

-- Insert reference loot into the creature loot temlate
DELETE FROM `creature_loot_template` WHERE `Entry`=29417 AND `Reference`=34383;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES 
(29417, 2, 34383, 100, 0, 1, 0, 1, 2);

-- Delete tokens which are separetely placed
DELETE FROM `creature_loot_template` WHERE  `Entry`=29417 AND `Item` IN (40625, 40626, 40627, 40634, 40635, 40636, 40637, 40638, 40639);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
