-- DB update 2017_01_24_03 -> 2017_01_24_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_01_24_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_01_24_03 2017_01_24_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1482952611662394924'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1482952611662394924');

ALTER TABLE `quest_template`
  CHANGE COLUMN `LimitTime`             `TimeAllowed`         INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `PointOption`,
  CHANGE COLUMN `RequiredRaces`         `RequiredRaces`       SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `TimeAllowed`,
  CHANGE COLUMN `NextQuestIdChain`      `RewardNextQuest`     MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `RequiredFactionValue2`,
  CHANGE COLUMN `RewardXPId`            `RewardXPDifficulty`  TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `RewardNextQuest`,
  CHANGE COLUMN `RewardOrRequiredMoney` `RewardMoney`         INT(11) NOT NULL DEFAULT '0' AFTER `RewardXPDifficulty`,
  CHANGE COLUMN `RewardMoneyMaxLevel`   `RewardBonusMoney`    INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `RewardMoney`,
  CHANGE COLUMN `RewardSpell`           `RewardDisplaySpell`  MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `RewardBonusMoney`,
  CHANGE COLUMN `RewardSpellCast`       `RewardSpell`         INT(11) NOT NULL DEFAULT '0' AFTER `RewardDisplaySpell`,
  CHANGE COLUMN `RewardHonorMultiplier` `RewardKillHonor`     FLOAT NOT NULL DEFAULT '0' AFTER `RewardHonor`,
  CHANGE COLUMN `SourceItemId`          `StartItem`           MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `RewardKillHonor`,
  CHANGE COLUMN `RewardTitle`           `RewardTitle`         TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `RewardChoiceItemQuantity6`,
  CHANGE COLUMN `RewardTalents`         `RewardTalents`       TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `RewardTitle`,
  CHANGE COLUMN `RewardArenaPoints`     `RewardArenaPoints`   SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `RewardTalents`;
-- split needed to avoid import errors
ALTER TABLE `quest_template`
  CHANGE COLUMN `PointMapId`            `POIContinent`        SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `RewardChoiceItemQuantity6`,
  CHANGE COLUMN `PointX`                `POIx`                FLOAT NOT NULL DEFAULT '0' AFTER `POIContinent`,
  CHANGE COLUMN `PointY`                `POIy`                FLOAT NOT NULL DEFAULT '0' AFTER `POIx`,
  CHANGE COLUMN `PointOption`           `POIPriority`         MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `POIy`,
  CHANGE COLUMN `EndText`               `AreaDescription`     TEXT NULL AFTER `QuestDescription`;

ALTER TABLE `quest_template`
  CHANGE COLUMN `RequiredRaces`            `AllowableRaces`    SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `TimeAllowed`,
  CHANGE COLUMN `RequiredSourceItemId1`    `ItemDrop1`         MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `RewardAmount4`,
  CHANGE COLUMN `RequiredSourceItemCount1` `ItemDropQuantity1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `ItemDrop1`,
  CHANGE COLUMN `RequiredSourceItemId2`    `ItemDrop2`         MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `ItemDropQuantity1`,
  CHANGE COLUMN `RequiredSourceItemCount2` `ItemDropQuantity2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `ItemDrop2`,
  CHANGE COLUMN `RequiredSourceItemId3`    `ItemDrop3`         MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `ItemDropQuantity2`,
  CHANGE COLUMN `RequiredSourceItemCount3` `ItemDropQuantity3` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `ItemDrop3`,
  CHANGE COLUMN `RequiredSourceItemId4`    `ItemDrop4`         MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `ItemDropQuantity3`,
  CHANGE COLUMN `RequiredSourceItemCount4` `ItemDropQuantity4` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `ItemDrop4`;
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
