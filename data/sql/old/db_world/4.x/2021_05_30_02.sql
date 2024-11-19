-- DB update 2021_05_30_01 -> 2021_05_30_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_30_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_30_01 2021_05_30_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1621659447273280925'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621659447273280925');

DELETE FROM `reference_loot_template` WHERE `Entry` = 24062 AND `Item` = 880;

DELETE FROM `creature_loot_template` WHERE `Entry` = 202 AND `Item` = 880;

INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(202, 880, 0, 1.6, 0, 1, 0, 1, 1, "Skeletal Horror - Staff of Horrors");


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_05_30_02' WHERE sql_rev = '1621659447273280925';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
