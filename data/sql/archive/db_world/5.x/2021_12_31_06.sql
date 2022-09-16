-- DB update 2021_12_31_05 -> 2021_12_31_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_31_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_31_05 2021_12_31_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640972252071688181'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640972252071688181');

-- removes unverified corrections of loot drop of the abyssal crest with drop rate based on udb from consolidated sniffs.
DELETE FROM `creature_loot_template` WHERE `Entry`=15209 AND `Item`=20513 AND `Reference`=0 AND `GroupId`=0;
DELETE FROM `creature_loot_template` WHERE `Entry`=15211 AND `Item`=20513 AND `Reference`=0 AND `GroupId`=0;
DELETE FROM `creature_loot_template` WHERE `Entry`=15212 AND `Item`=20513 AND `Reference`=0 AND `GroupId`=0;
DELETE FROM `creature_loot_template` WHERE `Entry`=15307 AND `Item`=20513 AND `Reference`=0 AND `GroupId`=0;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(15209, 20513, 0, 83.7314, 0, 1, 0, 1, 1, 'Crimson Templar - Abyssal Crest'),
(15211, 20513, 0, 83.5982, 0, 1, 0, 1, 1, 'Azure Templar - Abyssal Crest'),
(15212, 20513, 0, 83.8428, 0, 1, 0, 1, 1, 'Hoary Templar - Abyssal Crest'),
(15307, 20513, 0, 83.9362, 0, 1, 0, 1, 1, 'Earthen Templar - Abyssal Crest');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_31_06' WHERE sql_rev = '1640972252071688181';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
