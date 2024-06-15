-- DB update 2022_01_03_24 -> 2022_01_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_03_24';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_03_24 2022_01_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641307926630364064'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641307926630364064');

-- removes Frigid Ring from creature loot template
DELETE FROM `creature_loot_template` WHERE  `Entry`=14457 AND `Item`=18679 AND `Reference`=0 AND `GroupId`=0;

-- Add Frigid Ring to Reference Loot Template where it is suppose to be
DELETE FROM `reference_loot_template` WHERE `Entry`=24016 AND `Item`=18679;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(24016, 18679, 0, 0, 0, 1, 1, 1, 1, 'Frigid Ring');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_04_00' WHERE sql_rev = '1641307926630364064';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
