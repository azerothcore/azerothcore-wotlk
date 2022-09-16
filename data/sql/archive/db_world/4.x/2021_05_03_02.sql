-- DB update 2021_05_03_01 -> 2021_05_03_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_03_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_03_01 2021_05_03_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619363905724595186'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619363905724595186');

-- select max(entry) from reference_loot_template; 526760, using 526760 + 30

-- Create new unified reference loot template containing loot from 24037, 24039, 24041, 24056
INSERT INTO `reference_loot_template`
SELECT 526790,
       rlt.Item,
       rlt.Reference,
       rlt.Chance,
       rlt.QuestRequired,
       rlt.LootMode,
       rlt.GroupId,
       rlt.MinCount,
       rlt.MaxCount,
       rlt.Comment
FROM (SELECT DISTINCT Item,
                      Reference,
                      Chance,
                      QuestRequired,
                      LootMode,
                      GroupId,
                      MinCount,
                      MaxCount,
                      Comment
      FROM `reference_loot_template`
      WHERE `Entry` IN (24037, 24039, 24041, 24056)) AS rlt;

-- 763 Lost One Chieftain
-- 2605 Zalas Witherbark
-- 2604 Molok the Crusher
-- 14234 Hayoc
-- 14226 Kaskk
-- 2744 Shadowforge Commander

-- Remove old references for the above-mentioned rares
DELETE
FROM `creature_loot_template`
WHERE `Reference` IN (24037, 24039, 24041, 24056)
  AND `Chance` = 1
  AND `Entry` IN
      (763,
       2605,
       2604,
       14234,
       14226,
       2744);

-- Insert new reference template with 100% chance to guarantee green drop from a rare
INSERT INTO `creature_loot_template` VALUES
(763, 526780, 526790, 100, 0, 1, 1, 1, 1, 'Lost One Chieftain - (ReferenceTable)'),
(2605, 526780, 526790, 100, 0, 1, 1, 1, 1, 'Zalas Witherbark - (ReferenceTable)'),
(2604, 526780, 526790, 100, 0, 1, 1, 1, 1, 'Molok the Crusher - (ReferenceTable)'),
(14234, 526780, 526790, 100, 0, 1, 1, 1, 1, 'Hayoc - (ReferenceTable)'),
(14226, 526780, 526790, 100, 0, 1, 1, 1, 1, 'Kaskk - (ReferenceTable)'),
(2744, 526780, 526790, 100, 0, 1, 1, 1, 1, 'Shadowforge Commander - (ReferenceTable)');

-- Extra - cleanup Shadowforge Commander references as those are loot tables of too low level
DELETE
FROM `creature_loot_template`
WHERE `Reference` IN (24068, 24077, 24060)
  AND `Entry` = 2744;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
