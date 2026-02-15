
-- Move the text in its own group.
UPDATE `creature_text` SET `GroupID` = 10, `ID` = 0 WHERE (`CreatureID` = 28860) AND (`GroupID` = 7) AND (`ID` = 3);
