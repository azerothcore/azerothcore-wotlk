-- DB update 2021_07_30_00 -> 2021_07_30_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_30_00 2021_07_30_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627234127883337100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627234127883337100');

-- Slowed down the movement speed
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 8302);

-- Delete previous skinning loots of deatheye
DELETE FROM `skinning_loot_template` WHERE `Entry` = 100003;

-- Added new ones from the template of a Redstone Crystalhide (id: 5991)
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(100003, 4304, 0, 40, 0, 1, 1, 1, 1, ''), -- Thick leather
(100003, 8169, 0, 5, 0, 1, 1, 1, 1, ''), -- Thick hide
(100003, 8170, 0, 50, 0, 1, 1, 1, 1, ''), -- Rugged Leather
(100003, 8171, 0, 5, 0, 1, 1, 1, 1, ''); -- Rugged Hide


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_30_01' WHERE sql_rev = '1627234127883337100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
