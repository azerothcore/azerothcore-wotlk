-- DB update 2021_08_20_02 -> 2021_08_20_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_20_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_20_02 2021_08_20_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629205101934861200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629205101934861200');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 9736) AND (`Item` IN (12835, 13252, 13253, 16716));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9736, 12835, 0, 13, 0, 1, 0, 1, 1, 'Quartermaster Zigris - Plans: Annihilator'),
(9736, 13252, 0, 20, 0, 1, 1, 1, 1, 'Quartermaster Zigris - Cloudrunner Girdle'),
(9736, 13253, 0, 19, 0, 1, 1, 1, 1, 'Quartermaster Zigris - Hands of Power'),
(9736, 16716, 0, 1.3, 0, 1, 1, 1, 1, 'Quartermaster Zigris - Wildheart Belt');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_20_03' WHERE sql_rev = '1629205101934861200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
