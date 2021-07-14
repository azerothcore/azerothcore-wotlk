INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626029066766191700');

-- ----------------------------
-- Table structure for string_class
-- ----------------------------
DROP TABLE IF EXISTS `string_class`;
CREATE TABLE `string_class` (
  `ID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `locale` varchar(4) CHARACTER SET utf8 NOT NULL,
  `NameMale` text CHARACTER SET utf8 DEFAULT NULL,
  `NameFemale` text CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ID`,`locale`) USING BTREE
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of string_class
-- ----------------------------
INSERT INTO `string_class` (`ID`, `locale`, `NameMale`, `NameFemale`) VALUES
(1, 'ruRU', 'Воин', NULL),
(2, 'ruRU', 'Паладин', NULL),
(3, 'ruRU', 'Охотник', 'Охотница'),
(4, 'ruRU', 'Разбойник', 'Разбойница'),
(5, 'ruRU', 'Жрец', 'Жрица'),
(6, 'ruRU', 'Рыцарь смерти', NULL),
(7, 'ruRU', 'Шаман', 'Шаманка'),
(8, 'ruRU', 'Маг', NULL),
(9, 'ruRU', 'Чернокнижник', 'Чернокнижница'),
(11, 'ruRU', 'Друид', NULL),
(1, 'enUS', 'Warrior', NULL),
(2, 'enUS', 'Paladin', NULL),
(3, 'enUS', 'Hunter', NULL),
(4, 'enUS', 'Rogue', NULL),
(5, 'enUS', 'Priest', NULL),
(6, 'enUS', 'DeathKnight', NULL),
(7, 'enUS', 'Shaman', NULL),
(8, 'enUS', 'Mage', NULL),
(9, 'enUS', 'Warlock', NULL),
(11, 'enUS', 'Druid', NULL);

-- ----------------------------
-- Table structure for string_module
-- ----------------------------
DROP TABLE IF EXISTS `string_module`;
CREATE TABLE `string_module` (
  `ModuleName` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT 'system',
  `ID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `Locale` varchar(4) CHARACTER SET utf8 NOT NULL,
  `Text` text CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ModuleName`,`ID`,`Locale`) USING BTREE
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for string_race
-- ----------------------------
DROP TABLE IF EXISTS `string_race`;
CREATE TABLE `string_race` (
  `ID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `locale` varchar(4) CHARACTER SET utf8 NOT NULL,
  `NameMale` text CHARACTER SET utf8 DEFAULT NULL,
  `NameFemale` text CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ID`,`locale`) USING BTREE
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of string_race
-- ----------------------------
INSERT INTO `string_race` (`ID`, `locale`, `NameMale`, `NameFemale`) VALUES
(2, 'ruRU', 'Орк', NULL),
(1, 'ruRU', 'Человек', NULL),
(3, 'ruRU', 'Дворф', NULL),
(4, 'ruRU', 'Ночной эльф', 'Ночная эльфийка'),
(5, 'ruRU', 'Нежить', NULL),
(6, 'ruRU', 'Таурен', NULL),
(7, 'ruRU', 'Гном', NULL),
(8, 'ruRU', 'Тролль', NULL),
(9, 'ruRU', 'Гоблин', NULL),
(10, 'ruRU', 'Эльф крови', 'Эльфийка крови'),
(11, 'ruRU', 'Дреней', NULL),
(1, 'enUS', 'Human', NULL),
(2, 'enUS', 'Orc', NULL),
(3, 'enUS', 'Dwarf', NULL),
(4, 'enUS', 'NightElf', NULL),
(5, 'enUS', 'Scourge', NULL),
(6, 'enUS', 'Tauren', NULL),
(7, 'enUS', 'Gnome', NULL),
(8, 'enUS', 'Troll', NULL),
(9, 'enUS', 'Goblin', NULL),
(10, 'enUS', 'BloodElf', NULL),
(11, 'enUS', 'Draenei', NULL);

ALTER TABLE `broadcast_text`
CHANGE COLUMN `Language` `LanguageID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `ID`,
CHANGE COLUMN `MaleText` `Text` LONGTEXT NULL AFTER `LanguageID`,
CHANGE COLUMN `FemaleText` `Text1` LONGTEXT NULL AFTER `Text`,
CHANGE COLUMN `EmoteID0` `EmoteID1` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `Text1`,
CHANGE COLUMN `EmoteID1` `EmoteID2` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteID1`,
CHANGE COLUMN `EmoteID2` `EmoteID3` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteID2`,
CHANGE COLUMN `EmoteDelay0` `EmoteDelay1` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteID3`,
CHANGE COLUMN `EmoteDelay1` `EmoteDelay2` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay1`,
CHANGE COLUMN `EmoteDelay2` `EmoteDelay3` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay2`,
CHANGE COLUMN `SoundId` `SoundEntriesID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay3`,
CHANGE COLUMN `Unk1` `EmotesID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `SoundEntriesID`,
CHANGE COLUMN `Unk2` `Flags` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmotesID`;

ALTER TABLE `broadcast_text_locale`
CHANGE COLUMN `MaleText` `Text` TEXT NULL AFTER `locale`,
CHANGE COLUMN `FemaleText` `Text1` TEXT NULL AFTER `Text`;

ALTER TABLE `npc_text`
CHANGE COLUMN `em0_0` `EmoteDelay0_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Probability0`,
CHANGE COLUMN `em0_1` `Emote0_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay0_0`,
CHANGE COLUMN `em0_2` `EmoteDelay0_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote0_0`,
CHANGE COLUMN `em0_3` `Emote0_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay0_1`,
CHANGE COLUMN `em0_4` `EmoteDelay0_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote0_1`,
CHANGE COLUMN `em0_5` `Emote0_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay0_2`,
CHANGE COLUMN `em1_0` `EmoteDelay1_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Probability1`,
CHANGE COLUMN `em1_1` `Emote1_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay1_0`,
CHANGE COLUMN `em1_2` `EmoteDelay1_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote1_0`,
CHANGE COLUMN `em1_3` `Emote1_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay1_1`,
CHANGE COLUMN `em1_4` `EmoteDelay1_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote1_1`,
CHANGE COLUMN `em1_5` `Emote1_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay1_2`,
CHANGE COLUMN `em2_0` `EmoteDelay2_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Probability2`,
CHANGE COLUMN `em2_1` `Emote2_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay2_0`,
CHANGE COLUMN `em2_2` `EmoteDelay2_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote2_0`,
CHANGE COLUMN `em2_3` `Emote2_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay2_1`,
CHANGE COLUMN `em2_4` `EmoteDelay2_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote2_1`,
CHANGE COLUMN `em2_5` `Emote2_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay2_2`,
CHANGE COLUMN `em3_0` `EmoteDelay3_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Probability3`,
CHANGE COLUMN `em3_1` `Emote3_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay3_0`,
CHANGE COLUMN `em3_2` `EmoteDelay3_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote3_0`,
CHANGE COLUMN `em3_3` `Emote3_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay3_1`,
CHANGE COLUMN `em3_4` `EmoteDelay3_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote3_1`,
CHANGE COLUMN `em3_5` `Emote3_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay3_2`,
CHANGE COLUMN `em4_0` `EmoteDelay4_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Probability4`,
CHANGE COLUMN `em4_1` `Emote4_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay4_0`,
CHANGE COLUMN `em4_2` `EmoteDelay4_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote4_0`,
CHANGE COLUMN `em4_3` `Emote4_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay4_1`,
CHANGE COLUMN `em4_4` `EmoteDelay4_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote4_1`,
CHANGE COLUMN `em4_5` `Emote4_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay4_2`,
CHANGE COLUMN `em5_0` `EmoteDelay5_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Probability5`,
CHANGE COLUMN `em5_1` `Emote5_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay5_0`,
CHANGE COLUMN `em5_2` `EmoteDelay5_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote5_0`,
CHANGE COLUMN `em5_3` `Emote5_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay5_1`,
CHANGE COLUMN `em5_4` `EmoteDelay5_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote5_1`,
CHANGE COLUMN `em5_5` `Emote5_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay5_2`,
CHANGE COLUMN `em6_0` `EmoteDelay6_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Probability6`,
CHANGE COLUMN `em6_1` `Emote6_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay6_0`,
CHANGE COLUMN `em6_2` `EmoteDelay6_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote6_0`,
CHANGE COLUMN `em6_3` `Emote6_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay6_1`,
CHANGE COLUMN `em6_4` `EmoteDelay6_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote6_1`,
CHANGE COLUMN `em6_5` `Emote6_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay6_2`,
CHANGE COLUMN `em7_0` `EmoteDelay7_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Probability7`,
CHANGE COLUMN `em7_1` `Emote7_0` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay7_0`,
CHANGE COLUMN `em7_2` `EmoteDelay7_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote7_0`,
CHANGE COLUMN `em7_3` `Emote7_1` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay7_1`,
CHANGE COLUMN `em7_4` `EmoteDelay7_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `Emote7_1`,
CHANGE COLUMN `em7_5` `Emote7_2` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' AFTER `EmoteDelay7_2`;

--
UPDATE `npc_text` AS a INNER JOIN `broadcast_text` AS b ON a.`BroadcastTextID0` = b.`ID` SET a.`lang0`= b.`LanguageID`, a.`text0_0` = b.`Text`, a.`text0_1` = b.`Text1`, a.`EmoteDelay0_0` = b.`EmoteDelay1`, a.`Emote0_0` = b.`EmoteID1`, a.`EmoteDelay0_1` = b.`EmoteDelay2`, a.`Emote0_1` = b.`EmoteID2`, a.`EmoteDelay0_2` = b.`EmoteDelay3`, a.`Emote0_2` = b.`EmoteID3`;
UPDATE `npc_text` AS a INNER JOIN `broadcast_text` AS b ON a.`BroadcastTextID1` = b.`ID` SET a.`lang1`= b.`LanguageID`, a.`text1_0` = b.`Text`, a.`text1_1` = b.`Text1`, a.`EmoteDelay1_0` = b.`EmoteDelay1`, a.`Emote1_0` = b.`EmoteID1`, a.`EmoteDelay1_1` = b.`EmoteDelay2`, a.`Emote1_1` = b.`EmoteID2`, a.`EmoteDelay1_2` = b.`EmoteDelay3`, a.`Emote1_2` = b.`EmoteID3`;
UPDATE `npc_text` AS a INNER JOIN `broadcast_text` AS b ON a.`BroadcastTextID2` = b.`ID` SET a.`lang2`= b.`LanguageID`, a.`text2_0` = b.`Text`, a.`text2_1` = b.`Text1`, a.`EmoteDelay2_0` = b.`EmoteDelay1`, a.`Emote2_0` = b.`EmoteID1`, a.`EmoteDelay2_1` = b.`EmoteDelay2`, a.`Emote2_1` = b.`EmoteID2`, a.`EmoteDelay2_2` = b.`EmoteDelay3`, a.`Emote2_2` = b.`EmoteID3`;
UPDATE `npc_text` AS a INNER JOIN `broadcast_text` AS b ON a.`BroadcastTextID3` = b.`ID` SET a.`lang3`= b.`LanguageID`, a.`text3_0` = b.`Text`, a.`text3_1` = b.`Text1`, a.`EmoteDelay3_0` = b.`EmoteDelay1`, a.`Emote3_0` = b.`EmoteID1`, a.`EmoteDelay3_1` = b.`EmoteDelay2`, a.`Emote3_1` = b.`EmoteID2`, a.`EmoteDelay3_2` = b.`EmoteDelay3`, a.`Emote3_2` = b.`EmoteID3`;
UPDATE `npc_text` AS a INNER JOIN `broadcast_text` AS b ON a.`BroadcastTextID4` = b.`ID` SET a.`lang4`= b.`LanguageID`, a.`text4_0` = b.`Text`, a.`text4_1` = b.`Text1`, a.`EmoteDelay4_0` = b.`EmoteDelay1`, a.`Emote4_0` = b.`EmoteID1`, a.`EmoteDelay4_1` = b.`EmoteDelay2`, a.`Emote4_1` = b.`EmoteID2`, a.`EmoteDelay4_2` = b.`EmoteDelay3`, a.`Emote4_2` = b.`EmoteID3`;
UPDATE `npc_text` AS a INNER JOIN `broadcast_text` AS b ON a.`BroadcastTextID5` = b.`ID` SET a.`lang5`= b.`LanguageID`, a.`text5_0` = b.`Text`, a.`text5_1` = b.`Text1`, a.`EmoteDelay5_0` = b.`EmoteDelay1`, a.`Emote5_0` = b.`EmoteID1`, a.`EmoteDelay5_1` = b.`EmoteDelay2`, a.`Emote5_1` = b.`EmoteID2`, a.`EmoteDelay5_2` = b.`EmoteDelay3`, a.`Emote5_2` = b.`EmoteID3`;
UPDATE `npc_text` AS a INNER JOIN `broadcast_text` AS b ON a.`BroadcastTextID6` = b.`ID` SET a.`lang6`= b.`LanguageID`, a.`text6_0` = b.`Text`, a.`text6_1` = b.`Text1`, a.`EmoteDelay6_0` = b.`EmoteDelay1`, a.`Emote6_0` = b.`EmoteID1`, a.`EmoteDelay6_1` = b.`EmoteDelay2`, a.`Emote6_1` = b.`EmoteID2`, a.`EmoteDelay6_2` = b.`EmoteDelay3`, a.`Emote6_2` = b.`EmoteID3`;
UPDATE `npc_text` AS a INNER JOIN `broadcast_text` AS b ON a.`BroadcastTextID7` = b.`ID` SET a.`lang7`= b.`LanguageID`, a.`text7_0` = b.`Text`, a.`text7_1` = b.`Text1`, a.`EmoteDelay7_0` = b.`EmoteDelay1`, a.`Emote7_0` = b.`EmoteID1`, a.`EmoteDelay7_1` = b.`EmoteDelay2`, a.`Emote7_1` = b.`EmoteID2`, a.`EmoteDelay7_2` = b.`EmoteDelay3`, a.`Emote7_2` = b.`EmoteID3`;
