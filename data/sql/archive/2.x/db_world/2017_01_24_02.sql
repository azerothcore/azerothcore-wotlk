-- DB update 2017_01_24_01 -> 2017_01_24_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_01_24_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_01_24_01 2017_01_24_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1482409122200235830'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1482409122200235830');
-- creating `quest_template_addon` table
DROP TABLE IF EXISTS        `quest_template_addon`;
CREATE TABLE IF NOT EXISTS  `quest_template_addon` (                  -- old names:
  `ID`                    mediumint(8) unsigned NOT NULL DEFAULT '0', -- ID
  `MaxLevel`              tinyint(3) unsigned NOT NULL DEFAULT '0',   -- MaxLevel
  `AllowableClasses`      int(10) unsigned NOT NULL DEFAULT '0',      -- RequiredClasses
  `SourceSpellID`         mediumint(8) unsigned NOT NULL DEFAULT '0', -- SourceSpellId
  `PrevQuestID`           mediumint(8) NOT NULL DEFAULT '0',          -- PrevQuestId
  `NextQuestID`           mediumint(8) NOT NULL DEFAULT '0',          -- NextQuestId
  `ExclusiveGroup`        mediumint(8) NOT NULL DEFAULT '0',          -- ExclusiveGroup
  `RewardMailTemplateID`  mediumint(8) unsigned NOT NULL DEFAULT '0', -- RewardMailTemplateId
  `RewardMailDelay`       int(10) unsigned NOT NULL DEFAULT '0',      -- RewardMailDelay
  `RequiredSkillID`       smallint(5) unsigned NOT NULL DEFAULT '0',  -- RequiredSkillId
  `RequiredSkillPoints`   smallint(5) unsigned NOT NULL DEFAULT '0',  -- RequiredSkillPoints
  `RequiredMinRepFaction` smallint(5) unsigned NOT NULL DEFAULT '0',  -- RequiredMinRepFaction
  `RequiredMaxRepFaction` smallint(5) unsigned NOT NULL DEFAULT '0',  -- RequiredMaxRepFaction
  `RequiredMinRepValue`   mediumint(8) NOT NULL DEFAULT '0',          -- RequiredMinRepValue
  `RequiredMaxRepValue`   mediumint(8) NOT NULL DEFAULT '0',          -- RequiredMaxRepValue
  `ProvidedItemCount`     tinyint(3) unsigned NOT NULL DEFAULT '0',   -- SourceItemCount
  `SpecialFlags`          tinyint(3) unsigned NOT NULL DEFAULT '0',   -- SpecialFlags
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- moving data from `quest_template` to `quest_template_addon`
INSERT INTO `quest_template_addon`
(`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`)
(SELECT `ID`, `MaxLevel`, `RequiredClasses`, `SourceSpellId`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `RewardMailTemplateId`, `RewardMailDelay`, `RequiredSkillId`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `SourceItemCount`, `SpecialFlags` FROM `quest_template`);


-- drop `quest_template` fields
ALTER TABLE `quest_template`
DROP `MaxLevel`,
DROP `RequiredClasses`,
DROP `SourceSpellId`,
DROP `PrevQuestId`,
DROP `NextQuestId`,
DROP `ExclusiveGroup`,
DROP `RewardMailTemplateId`,
DROP `RewardMailDelay`,
DROP `RequiredSkillId`,
DROP `RequiredSkillPoints`,
DROP `RequiredMinRepFaction`,
DROP `RequiredMaxRepFaction`,
DROP `RequiredMinRepValue`,
DROP `RequiredMaxRepValue`,
DROP `SourceItemCount`,
DROP `SpecialFlags`;


-- alter `quest_template` fields
ALTER TABLE `quest_template`
  CHANGE COLUMN `Method`    `QuestType`   TINYINT(3)  UNSIGNED NOT NULL DEFAULT '2' AFTER `ID`,
  CHANGE COLUMN `QuestType` `QuestInfoID` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `QuestSortID`;
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
