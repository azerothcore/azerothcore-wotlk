-- DB update 2019_05_17_01 -> 2019_05_17_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_17_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_17_01 2019_05_17_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1557740416904830700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1557740416904830700');

DELETE FROM `skill_fishing_base_level` WHERE `entry`= 3479;
INSERT INTO `skill_fishing_base_level` (`entry`, `skill`) VALUES ('3479', '225');
DELETE FROM `fishing_loot_template` WHERE `Entry`=3479;
INSERT INTO `fishing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3479, 6352, 0, 0.4, 0, 1, 0, 1, 1, NULL),
(3479, 6359, 0, 15, 0, 1, 0, 1, 1, NULL),
(3479, 6360, 0, 0.5, 0, 1, 0, 1, 1, NULL),
(3479, 6354, 0, 0.4, 0, 1, 0, 1, 1, NULL),
(3479, 6358, 0, 25, 0, 1, 0, 1, 1, NULL),
(3479, 6361, 0, 58.8, 0, 1, 0, 1, 1, NULL),
(3479, 6307, 0, 0.4, 0, 1, 0, 1, 1, NULL);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
