-- DB update 2021_11_03_01 -> 2021_11_03_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_03_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_03_01 2021_11_03_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635586926158019590'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635586926158019590');

-- Deletes Defias Rapier from RLT 24077
DELETE FROM `reference_loot_template` WHERE `Entry` = 24077 AND `Item` = 1925;

-- Adds Defias Rapier drop to Defias Watchman
DELETE FROM `creature_loot_template` WHERE `Entry` = 1725 AND `Item` = 1925;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1725, 1925, 0, 6.6, 0, 1, 1, 1, 1, 'Defias Watchman - Defias Rapier');


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_03_02' WHERE sql_rev = '1635586926158019590';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
