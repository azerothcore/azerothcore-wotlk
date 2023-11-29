-- DB update 2023_11_29_00 -> 2023_11_29_01
-- Bombing Run (11010) should not be available to druids
UPDATE `quest_template_addon` SET `AllowableClasses`=`AllowableClasses`|1|2|4|8|16|32|64|128|256 WHERE `ID` = 11010;

-- Banish More Demons should not be available without honoured reputation
UPDATE `quest_template_addon` SET `RequiredMinRepFaction` = 1030, `RequiredMinRepValue` = 9000 WHERE `ID` = 11026;
