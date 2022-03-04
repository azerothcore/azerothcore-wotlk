INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646373024271158100');

DROP TABLE IF EXISTS `commands_help_locale`;
CREATE TABLE `commands_help_locale` (
  `Command` VARCHAR(100) NOT NULL DEFAULT '0',
  `Locale` enum('enUS','koKR','frFR','deDE','zhCN','zhTW','esES','esMX','ruRU') NOT NULL,
  `Content` TEXT DEFAULT NULL,
  PRIMARY KEY (`Locale`,`Command`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

DROP TABLE IF EXISTS `string_module`;
CREATE TABLE IF NOT EXISTS `string_module` (
  `Entry` varchar(100) NOT NULL,
  `Locale` enum('enUS','koKR','frFR','deDE','zhCN','zhTW','esES','esMX','ruRU') NOT NULL,
  `Text` text CHARACTER SET utf8mb3 DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Locale`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

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
CHANGE COLUMN `MaleText` `Text` LONGTEXT NULL AFTER `LanguageID`,
CHANGE COLUMN `FemaleText` `Text1` LONGTEXT NULL AFTER `Text`;

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

-- Replace to fmt
-- content_default
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%s', '{}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%.*s', '{}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%c', '{}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%u', '{}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%d', '{}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%f', '{}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%i', '{}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%2.2f', '{:2.2f}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%-10s', '{:<10}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%3d', '{:>3}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%4d', '{:>4}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%5d', '{:>5}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%10s', '{:>10}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%20s', '{:>20}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%12s', '{:>12}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%15s', '{:>15}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%16s', '{:>16}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%19s', '{:>19}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%8u', '{:>8}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%6u', '{:>6}');
UPDATE `acore_string` SET content_default = REPLACE(content_default, '%10u', '{:>10}');

-- locale_koKR
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%s', '{}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%.*s', '{}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%c', '{}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%u', '{}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%d', '{}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%f', '{}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%i', '{}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%2.2f', '{:2.2f}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%-10s', '{:<10}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%3d', '{:>3}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%4d', '{:>4}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%5d', '{:>5}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%10s', '{:>10}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%20s', '{:>20}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%12s', '{:>12}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%15s', '{:>15}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%16s', '{:>16}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%19s', '{:>19}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%8u', '{:>8}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%6u', '{:>6}');
UPDATE `acore_string` SET locale_koKR = REPLACE(locale_koKR, '%10u', '{:>10}');

-- locale_frFR
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%s', '{}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%.*s', '{}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%c', '{}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%u', '{}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%d', '{}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%f', '{}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%i', '{}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%2.2f', '{:2.2f}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%-10s', '{:<10}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%3d', '{:>3}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%4d', '{:>4}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%5d', '{:>5}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%10s', '{:>10}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%20s', '{:>20}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%12s', '{:>12}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%15s', '{:>15}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%16s', '{:>16}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%19s', '{:>19}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%8u', '{:>8}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%6u', '{:>6}');
UPDATE `acore_string` SET locale_frFR = REPLACE(locale_frFR, '%10u', '{:>10}');

-- locale_deDE
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%s', '{}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%.*s', '{}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%c', '{}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%u', '{}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%d', '{}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%f', '{}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%i', '{}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%2.2f', '{:2.2f}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%-10s', '{:<10}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%3d', '{:>3}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%4d', '{:>4}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%5d', '{:>5}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%10s', '{:>10}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%20s', '{:>20}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%12s', '{:>12}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%15s', '{:>15}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%16s', '{:>16}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%19s', '{:>19}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%8u', '{:>8}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%6u', '{:>6}');
UPDATE `acore_string` SET locale_deDE = REPLACE(locale_deDE, '%10u', '{:>10}');

-- locale_zhCN
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%s', '{}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%.*s', '{}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%c', '{}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%u', '{}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%d', '{}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%f', '{}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%i', '{}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%2.2f', '{:2.2f}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%-10s', '{:<10}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%3d', '{:>3}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%4d', '{:>4}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%5d', '{:>5}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%10s', '{:>10}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%20s', '{:>20}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%12s', '{:>12}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%15s', '{:>15}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%16s', '{:>16}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%19s', '{:>19}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%8u', '{:>8}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%6u', '{:>6}');
UPDATE `acore_string` SET locale_zhCN = REPLACE(locale_zhCN, '%10u', '{:>10}');

-- locale_zhTW
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%s', '{}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%.*s', '{}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%c', '{}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%u', '{}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%d', '{}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%f', '{}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%i', '{}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%2.2f', '{:2.2f}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%-10s', '{:<10}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%3d', '{:>3}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%4d', '{:>4}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%5d', '{:>5}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%10s', '{:>10}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%20s', '{:>20}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%12s', '{:>12}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%15s', '{:>15}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%16s', '{:>16}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%19s', '{:>19}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%8u', '{:>8}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%6u', '{:>6}');
UPDATE `acore_string` SET locale_zhTW = REPLACE(locale_zhTW, '%10u', '{:>10}');

-- locale_esES
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%s', '{}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%.*s', '{}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%c', '{}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%u', '{}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%d', '{}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%f', '{}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%i', '{}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%2.2f', '{:2.2f}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%-10s', '{:<10}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%3d', '{:>3}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%4d', '{:>4}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%5d', '{:>5}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%10s', '{:>10}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%20s', '{:>20}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%12s', '{:>12}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%15s', '{:>15}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%16s', '{:>16}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%19s', '{:>19}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%8u', '{:>8}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%6u', '{:>6}');
UPDATE `acore_string` SET locale_esES = REPLACE(locale_esES, '%10u', '{:>10}');

-- locale_esMX
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%s', '{}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%.*s', '{}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%c', '{}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%u', '{}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%d', '{}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%f', '{}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%i', '{}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%2.2f', '{:2.2f}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%-10s', '{:<10}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%3d', '{:>3}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%4d', '{:>4}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%5d', '{:>5}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%10s', '{:>10}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%20s', '{:>20}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%12s', '{:>12}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%15s', '{:>15}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%16s', '{:>16}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%19s', '{:>19}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%8u', '{:>8}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%6u', '{:>6}');
UPDATE `acore_string` SET locale_esMX = REPLACE(locale_esMX, '%10u', '{:>10}');

-- locale_ruRU
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%s', '{}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%.*s', '{}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%c', '{}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%u', '{}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%d', '{}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%f', '{}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%i', '{}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%2.2f', '{:2.2f}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%-10s', '{:<10}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%3d', '{:>3}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%4d', '{:>4}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%5d', '{:>5}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%10s', '{:>10}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%20s', '{:>20}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%12s', '{:>12}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%15s', '{:>15}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%16s', '{:>16}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%19s', '{:>19}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%8u', '{:>8}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%6u', '{:>6}');
UPDATE `acore_string` SET locale_ruRU = REPLACE(locale_ruRU, '%10u', '{:>10}');
