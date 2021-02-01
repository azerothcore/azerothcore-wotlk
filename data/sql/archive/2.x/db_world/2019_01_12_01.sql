-- DB update 2019_01_12_00 -> 2019_01_12_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_12_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_12_00 2019_01_12_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1546089286503990300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1546089286503990300');

-- ----------------------------
-- Create new table for locales
-- ----------------------------

DROP TABLE IF EXISTS `achievement_reward_locale`;
CREATE TABLE IF NOT EXISTS `achievement_reward_locale` (
  `ID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `Locale` VARCHAR(4) NOT NULL,
  `Subject` TEXT,
  `Text` TEXT,
  PRIMARY KEY (`ID`, `Locale`)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

DROP TABLE IF EXISTS `broadcast_text_locale`;
CREATE TABLE IF NOT EXISTS `broadcast_text_locale` (
  `ID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `locale` VARCHAR(4) NOT NULL,
  `MaleText` TEXT,
  `FemaleText` TEXT,
  `VerifiedBuild` SMALLINT(5) DEFAULT '0',
  PRIMARY KEY (`ID`, `locale`)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

DROP TABLE IF EXISTS `creature_text_locale`;
CREATE TABLE IF NOT EXISTS `creature_text_locale` (
  `CreatureID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `GroupID` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `ID` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `Locale` VARCHAR(4) NOT NULL,
  `Text` TEXT,
  PRIMARY KEY (`CreatureID`, `GroupID`, `ID`, `Locale`)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

DROP TABLE IF EXISTS `gossip_menu_option_locale`;
CREATE TABLE IF NOT EXISTS `gossip_menu_option_locale` (
  `MenuID` smallint(6) unsigned NOT NULL DEFAULT '0',
  `OptionID` smallint(6) unsigned NOT NULL DEFAULT '0',
  `Locale` varchar(4) NOT NULL,
  `OptionText` text,
  `BoxText` text,
  PRIMARY KEY (`MenuID`, `OptionID`, `Locale`)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

DROP TABLE IF EXISTS `item_template_locale`;
CREATE TABLE IF NOT EXISTS `item_template_locale` (
  `ID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `locale` VARCHAR(4) NOT NULL,
  `Name` TEXT,
  `Description` TEXT,
  `VerifiedBuild` SMALLINT(5) DEFAULT '0',
  PRIMARY KEY (`ID`, `locale`)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

DROP TABLE IF EXISTS `item_set_names_locale`;
CREATE TABLE `item_set_names_locale`  (
  `ID` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `locale` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Name` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `VerifiedBuild` smallint(5) NULL DEFAULT 0,
  PRIMARY KEY (`ID`, `locale`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

DROP TABLE IF EXISTS `npc_text_locale`;
CREATE TABLE `npc_text_locale` (
  `ID` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Locale` varchar(4) NOT NULL,
  `Text0_0` longtext,
  `Text0_1` longtext,
  `Text1_0` longtext,
  `Text1_1` longtext,
  `Text2_0` longtext,
  `Text2_1` longtext,
  `Text3_0` longtext,
  `Text3_1` longtext,
  `Text4_0` longtext,
  `Text4_1` longtext,
  `Text5_0` longtext,
  `Text5_1` longtext,
  `Text6_0` longtext,
  `Text6_1` longtext,
  `Text7_0` longtext,
  `Text7_1` longtext,
  PRIMARY KEY (`ID`, `Locale`)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

DROP TABLE IF EXISTS `page_text_locale`;
CREATE TABLE IF NOT EXISTS `page_text_locale` (
  `ID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `locale` VARCHAR(4) NOT NULL,
  `Text` TEXT,
  `VerifiedBuild` SMALLINT(5) DEFAULT '0',
  PRIMARY KEY (`ID`, `locale`)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

DROP TABLE IF EXISTS `points_of_interest_locale`;
CREATE TABLE IF NOT EXISTS `points_of_interest_locale` (
  `ID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `locale` VARCHAR(4) NOT NULL,
  `Name` TEXT,
  `VerifiedBuild` SMALLINT(5) DEFAULT '0',
  PRIMARY KEY (`ID`, `locale`)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

DROP TABLE IF EXISTS `quest_template_locale`;
CREATE TABLE IF NOT EXISTS `quest_template_locale` (
  `ID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `locale` VARCHAR(4) NOT NULL,
  `Title` TEXT,
  `Details` TEXT,
  `Objectives` TEXT,
  `OfferRewardText` TEXT,
  `RequestItemsText` TEXT,
  `EndText` TEXT,
  `CompletedText` TEXT,
  `ObjectiveText1` TEXT,
  `ObjectiveText2` TEXT,
  `ObjectiveText3` TEXT,
  `ObjectiveText4` TEXT,
  `VerifiedBuild` SMALLINT(5) DEFAULT '0',
  PRIMARY KEY (`ID`, `locale`)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
