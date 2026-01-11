-- DB update 2024_07_09_12 -> 2024_07_09_13
--
UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags`|1 WHERE (`ID` IN (11103, 11104, 11105, 11106));
