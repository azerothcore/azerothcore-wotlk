-- DB update 2025_11_25_00 -> 2025_11_25_01
-- Makes the quest "Remember Everfrost" repetable
UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags` | 1 WHERE `ID` = 13421;
