-- DB update 2025_02_06_00 -> 2025_02_06_01
--
UPDATE `creature_text` SET `Language` = 0 WHERE `CreatureID` = 24882 AND `GroupId`= 3 AND `ID` = 0;
