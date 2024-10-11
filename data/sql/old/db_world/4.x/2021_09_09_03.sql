-- DB update 2021_09_09_02 -> 2021_09_09_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_09_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_09_02 2021_09_09_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631038913388302500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631038913388302500');

DELETE FROM `creature_loot_template` WHERE `Entry`=193 AND `Item`=34535;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(193, 34535, 0, 0.1, 0, 1, 0, 1, 1, 'Blue Dragonspawn - Azure Whelpling');


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_09_03' WHERE sql_rev = '1631038913388302500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
