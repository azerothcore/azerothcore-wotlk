-- DB update 2023_12_03_03 -> 2023_12_03_04
-- Banish More Demons should not be available without honoured reputation
UPDATE `quest_template_addon` SET `RequiredMinRepFaction` = 1038, `RequiredMinRepValue` = 9000 WHERE `ID` = 11026;
