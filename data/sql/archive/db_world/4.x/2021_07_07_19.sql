-- DB update 2021_07_07_18 -> 2021_07_07_19
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_07_18';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_07_18 2021_07_07_19 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625577114142882549'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625577114142882549');

-- Delete various incorrect items from Torwa's Pouch
DELETE FROM `item_loot_template` WHERE `Entry` = 11568 AND `Item` IN (2450, 3820, 8838, 11018, 16204);
-- Make Preserved Pheromone Mixture drop with 100% chance
UPDATE `item_loot_template` SET `Chance` = 100 WHERE `Entry` = 11568 AND `Item` = 11570;

-- Delete Threshadon Meat/Preserved Pheromone from Hoard of the Black Dragonflight
DELETE FROM `item_loot_template` WHERE `Entry` = 10569 AND `Item` IN (11569, 11570);

-- Delete Threshadon Meat/Preserved Pheromone from A Small Pack
DELETE FROM `item_loot_template` WHERE `Entry` = 11107 AND `Item` IN (11569, 11570);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_07_19' WHERE sql_rev = '1625577114142882549';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
