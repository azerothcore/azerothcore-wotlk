-- DB update 2017_02_03_47 -> 2017_03_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_02_03_47';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_02_03_47 2017_03_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1486213838562161500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1486213838562161500');
-- BRITTLE REVENANT LOOT TABLE AND DROP RATE fixed.
DELETE FROM `creature_loot_template` WHERE (entry = 30160) AND (item IN (42246));
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(30160, 42246, 68, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (entry = 30160) AND (item IN (42780));
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(30160, 42780, 34, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (entry = 30160) AND (item IN (37701));
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(30160, 37701, 26, 1, 0, 1, 2);--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
