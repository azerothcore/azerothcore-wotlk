-- Makes the quest "Remember Everfrost" repetable
UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags` | 1 WHERE `ID` = 13421;
