-- Makes the quest "Remember Everfrost" repetable
UPDATE `quest_template_addon` SET `SpecialFlags` = 1 WHERE `ID` = 13421;
