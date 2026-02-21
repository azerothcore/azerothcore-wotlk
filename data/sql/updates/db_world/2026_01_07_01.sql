-- DB update 2026_01_07_00 -> 2026_01_07_01
--
UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags`|1 WHERE (`ID` = 13845);
