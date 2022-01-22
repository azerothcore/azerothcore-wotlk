-- DB update 2019_01_12_03 -> 2019_01_12_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_12_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_12_03 2019_01_12_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1546089286503990304'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1546089286503990304');

-- ----------------------------
-- Drop old locales tables
-- ----------------------------

DROP TABLE IF EXISTS `locales_achievement_reward`;
DROP TABLE IF EXISTS `locales_broadcast_text`;
DROP TABLE IF EXISTS `locales_creature_text`;
DROP TABLE IF EXISTS `locales_gossip_menu_option`;
DROP TABLE IF EXISTS `locales_item`;
DROP TABLE IF EXISTS `locales_item_set_names`;
DROP TABLE IF EXISTS `locales_npc_text`;
DROP TABLE IF EXISTS `locales_page_text`;
DROP TABLE IF EXISTS `locales_points_of_interest`;
DROP TABLE IF EXISTS `locales_quest`;

-- ----------------------------
-- Update table structure
-- ----------------------------

-- creature_text
ALTER TABLE `creature_text` CHANGE `entry` `CreatureID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `groupid` `GroupID` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `id` `ID` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `text` `Text` LONGTEXT;
ALTER TABLE `creature_text` CHANGE `type` `Type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `language` `Language` TINYINT(3) NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `probability` `Probability` FLOAT UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `emote` `Emote` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `duration` `Duration` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `sound` `Sound` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE COLUMN `BroadcastTextID` `BroadcastTextId` mediumint(6) NOT NULL DEFAULT 0 AFTER `Sound`;

-- npc_text
ALTER TABLE `npc_text` ADD `BroadcastTextID0` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text0_1`;
ALTER TABLE `npc_text` ADD `BroadcastTextID1` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text1_1`;
ALTER TABLE `npc_text` ADD `BroadcastTextID2` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text2_1`;
ALTER TABLE `npc_text` ADD `BroadcastTextID3` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text3_1`;
ALTER TABLE `npc_text` ADD `BroadcastTextID4` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text4_1`;
ALTER TABLE `npc_text` ADD `BroadcastTextID5` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text5_1`;
ALTER TABLE `npc_text` ADD `BroadcastTextID6` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text6_1`;
ALTER TABLE `npc_text` ADD `BroadcastTextID7` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text7_1`;

-- gossip_menu
ALTER TABLE `gossip_menu` CHANGE `entry` `MenuID` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu` CHANGE `text_id` `TextID` mediumint(8) unsigned NOT NULL DEFAULT '0';

-- gossip_menu_option
ALTER TABLE `gossip_menu_option` CHANGE `menu_id` `MenuID` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `id` `OptionID` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `option_icon` `OptionIcon` mediumint(8) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `option_text` `OptionText` text;
ALTER TABLE `gossip_menu_option` CHANGE `option_id` `OptionType` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `npc_option_npcflag` `OptionNpcFlag` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `action_menu_id` `ActionMenuID` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `action_poi_id` `ActionPoiID` mediumint(8) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `box_coded` `BoxCoded` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `box_money` `BoxMoney` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `box_text` `BoxText` text;
ALTER TABLE `gossip_menu_option` ADD `OptionBroadcastTextID` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `OptionText`;
ALTER TABLE `gossip_menu_option` ADD `BoxBroadcastTextID` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `BoxText`;
ALTER TABLE `gossip_menu_option` ADD COLUMN `VerifiedBuild` smallint(5) NOT NULL DEFAULT 0 AFTER `BoxBroadcastTextID`;

-- ----------------------------
-- Delete db_script_string
-- ----------------------------

DROP TABLE `db_script_string`; -- RIP

-- ----------------------------
-- Table structure for quest_mail_sender
-- ----------------------------
DROP TABLE IF EXISTS `quest_mail_sender`;
CREATE TABLE `quest_mail_sender`  (
  `QuestId` int(5) UNSIGNED NOT NULL DEFAULT 0,
  `RewardMailSenderEntry` int(5) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`QuestId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of quest_mail_sender
-- ----------------------------
INSERT INTO `quest_mail_sender` VALUES (8729, 11811);
INSERT INTO `quest_mail_sender` VALUES (10588, 18166);
INSERT INTO `quest_mail_sender` VALUES (10966, 22818);
INSERT INTO `quest_mail_sender` VALUES (10967, 22817);
INSERT INTO `quest_mail_sender` VALUES (12067, 2708);
INSERT INTO `quest_mail_sender` VALUES (12085, 5885);
INSERT INTO `quest_mail_sender` VALUES (12422, 27102);
INSERT INTO `quest_mail_sender` VALUES (12711, 28930);
INSERT INTO `quest_mail_sender` VALUES (13959, 33533);
INSERT INTO `quest_mail_sender` VALUES (13960, 33532);

-- ----------------------------
-- Table structure for quest_offer_reward_locale
-- ----------------------------

DROP TABLE IF EXISTS `quest_offer_reward_locale`;
CREATE TABLE `quest_offer_reward_locale` (
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) NOT NULL,
  `RewardText` text,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`locale`)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for quest_request_items_locale
-- ----------------------------

DROP TABLE IF EXISTS `quest_request_items_locale`;
CREATE TABLE `quest_request_items_locale` (
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) NOT NULL,
  `CompletionText` text,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`locale`)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of quest_request_items_locale and quest_offer_reward_locale
-- ----------------------------

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) SELECT `ID`, `locale`, `RequestItemsText`, `VerifiedBuild` from `quest_template_locale` WHERE `RequestItemsText` != ""; -- Migrate data to new table
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) SELECT `ID`, `locale`, `OfferRewardText`, `VerifiedBuild` from `quest_template_locale` WHERE `OfferRewardText` != ""; -- Migrate data to new table

-- ----------------------------
-- Delete columns in quest_template_locale
-- ----------------------------

ALTER TABLE `quest_template_locale`
  DROP COLUMN `RequestItemsText`,
  DROP COLUMN `OfferRewardText`;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
