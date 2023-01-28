-- DB update 2023_01_28_01 -> 2023_01_28_02
-- Add Chinese translation of Wand of Allistarj
DELETE FROM `item_template_locale` WHERE `ID`=13065 AND `locale` = 'zhCN';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(13065, 'zhCN', '奥利斯塔的魔杖', '', 0);
