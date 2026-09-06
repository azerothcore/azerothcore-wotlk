-- DB update 2025_12_10_01 -> 2025_12_11_00

UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags`  | 1 WHERE `ID` IN (12618, 12656);
