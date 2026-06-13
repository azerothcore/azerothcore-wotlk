-- DB update 2026_02_15_02 -> 2026_02_15_03

-- Move the text in its own group.
UPDATE `creature_text` SET `GroupID` = 10, `ID` = 0 WHERE (`CreatureID` = 28860) AND (`GroupID` = 7) AND (`ID` = 3);
