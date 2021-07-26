-- DB update 2021_07_22_05 -> 2021_07_22_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_22_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_22_05 2021_07_22_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626444381466806000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626444381466806000');

DELETE FROM `creature_loot_template` WHERE `Entry` IN (193, 6130, 6129, 6131) AND `Item` = 21949;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(193, 21949, 0, 0.5, 0, 1, 1, 1, 1, 'Blue Dragonspawn - Design: Ruby Serpent'),
(6130, 21949, 0, 0.5, 0, 1, 1, 1, 1, 'Blue Scalebane - Design: Ruby Serpent'),
(6129, 21949, 0, 0.5, 0, 1, 1, 1, 1, 'Draconic Magelord - Design: Ruby Serpent'),
(6131, 21949, 0, 0.5, 0, 1, 1, 1, 1, 'Draconic Mageweaver - Design: Ruby Serpent');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_22_06' WHERE sql_rev = '1626444381466806000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
