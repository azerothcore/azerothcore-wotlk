-- DB update 2024_06_22_00 -> 2024_06_22_01
-- make Quest 'Apothecary Zamah' failable in any state
UPDATE `quest_template_addon` SET `SpecialFlags` = (`SpecialFlags` | 128) WHERE (`ID` = 853);
