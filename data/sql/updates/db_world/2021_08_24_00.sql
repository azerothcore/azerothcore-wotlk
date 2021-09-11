-- DB update 2021_08_23_01 -> 2021_08_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_23_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_23_01 2021_08_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629290838385347720'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629290838385347720');

-- Delete Chimaera Leather
DELETE FROM `skinning_loot_template` WHERE `item` = 15423 AND `entry` IN (7447, 7448, 7449, 8763, 8764, 10807, 11497);

-- Update Fledgling Chillwind
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 7447) AND (`Item` IN (4304, 8169, 8170, 8171));
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7447, 4304, 0, 37.199, 0, 1, 1, 1, 1, 'Fledgling Chillwind - Thick Leather'),
(7447, 8169, 0, 3.869, 0, 1, 1, 1, 1, 'Fledgling Chillwind - Thick Hide'),
(7447, 8170, 0, 52.755, 0, 1, 1, 1, 1, 'Fledgling Chillwind - Rugged Leather'),
(7447, 8171, 0, 6.177, 0, 1, 1, 1, 1, 'Fledgling Chillwind - Rugged Hide');

-- Update Chillwind Chimaera
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 7448) AND (`Item` IN (4304, 8170, 8171));
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7448, 4304, 0, 10.456, 0, 1, 1, 1, 1, 'Chillwind Chimaera - Thick Leather'),
(7448, 8170, 0, 81.050, 0, 1, 1, 1, 1, 'Chillwind Chimaera - Rugged Leather'),
(7448, 8171, 0, 8.494, 0, 1, 1, 1, 1, 'Chillwind Chimaera - Rugged Hide');

-- Update Chillwind Ravager
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 7449) AND (`Item` IN (4304, 8170, 8171));
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7449, 4304, 0, 7.990, 0, 1, 1, 1, 1, 'Chillwind Ravager - Thick Leather'),
(7449, 8170, 0, 83.502, 0, 1, 1, 1, 1, 'Chillwind Ravager - Rugged Leather'),
(7449, 8171, 0, 8.508, 0, 1, 1, 1, 1, 'Chillwind Ravager - Rugged Hide');

-- Update Mistwing Rogue
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 8763) AND (`Item` IN (4304, 8169, 8170, 8171));
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8763, 4304, 0, 41.811, 0, 1, 1, 1, 1, 'Mistwing Rogue - Thick Leather'),
(8763, 8169, 0, 4.529, 0, 1, 1, 1, 1, 'Mistwing Rogue - Thick Hide'),
(8763, 8170, 0, 48.782, 0, 1, 1, 1, 1, 'Mistwing Rogue - Rugged Leather'),
(8763, 8171, 0, 4.878, 0, 1, 1, 1, 1, 'Mistwing Rogue - Rugged Hide');

-- Update Mistwing Ravager
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 8764) AND (`Item` IN (4304, 8169, 8170, 8171));
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8764, 4304, 0, 37.879, 0, 1, 1, 1, 1, 'Mistwing Ravager - Thick Leather'),
(8764, 8169, 0, 4.243, 0, 1, 1, 1, 1, 'Mistwing Ravager - Thick Hide'),
(8764, 8170, 0, 53.636, 0, 1, 1, 1, 1, 'Mistwing Ravager - Rugged Leather'),
(8764, 8171, 0, 4.242, 0, 1, 1, 1, 1, 'Mistwing Ravager - Rugged Hide');

-- Update Brumeran
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 10807) AND (`Item` IN (4304, 8170, 8171));
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10807, 4304, 0, 7.628, 0, 1, 1, 1, 1, 'Brumeran - Thick Leather'),
(10807, 8170, 0, 83.050, 0, 1, 1, 1, 1, 'Brumeran - Rugged Leather'),
(10807, 8171, 0, 9.322, 0, 1, 1, 1, 1, 'Brumeran - Rugged Hide');

-- Update The Razza
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 11497) AND (`Item` IN (4304, 8170, 8171));
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11497, 4304, 0, 5.413, 0, 1, 0, 1, 1, 'The Razza - Thick Leather'),
(11497, 8170, 0, 82.823, 0, 1, 0, 1, 1, 'The Razza - Rugged Leather'),
(11497, 8171, 0, 11.764, 0, 1, 0, 1, 1, 'The Razza - Rugged Hide');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_24_00' WHERE sql_rev = '1629290838385347720';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
