-- DB update 2021_07_06_04 -> 2021_07_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_06_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_06_04 2021_07_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625248286388193100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625248286388193100');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 24060) AND (`Item` IN (2021));

DELETE FROM `creature_loot_template` WHERE (`Entry` = 569) AND (`Item` IN (2021));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(569, 2021, 0, 1.2, 0, 1, 0, 1, 1, '');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_07_00' WHERE sql_rev = '1625248286388193100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
