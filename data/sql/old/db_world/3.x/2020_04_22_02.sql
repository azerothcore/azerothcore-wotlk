-- DB update 2020_04_22_01 -> 2020_04_22_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_04_22_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_04_22_01 2020_04_22_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1584114505260057800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1584114505260057800');

-- Based on https://wowwiki.fandom.com/wiki/Clam?oldid=2076011
DELETE FROM `spell_loot_template` WHERE `entry` IN (58172, 58168, 61898, 58165, 58160);
INSERT INTO `spell_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(58172, 5503, 0, 100, 0, 1, 0, 1, 1, ''),
(58172, 5498, 0, 5, 0, 1, 1, 1, 1, ''),
(58168, 5504, 0, 100, 0, 1, 0, 1, 1, ''),
(58168, 5498, 0, 5, 0, 1, 1, 1, 1, ''),
(58168, 5500, 0, 2.5, 0, 1, 1, 1, 1, ''),
(61898, 15924, 0, 100, 0, 1, 0, 1, 1, ''),
(58165, 7974, 0, 100, 0, 1, 0, 1, 1, ''),
(58165, 5498, 0, 3, 0, 1, 1, 1, 1, ''),
(58165, 5500, 0, 1, 0, 1, 1, 1, 1, ''),
(58165, 7971, 0, 4, 0, 1, 1, 1, 1, ''),
(58165, 13926, 0, 0.5, 0, 1, 1, 1, 1, ''),
(58160, 24477, 0, 100, 0, 1, 0, 1, 1, ''),
(58160, 24478, 0, 15, 0, 1, 1, 1, 1, ''),
(58160, 13926, 0, 5, 0, 1, 1, 1, 1, ''),
(58160, 24479, 0, 1, 0, 1, 1, 1, 1, '');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
