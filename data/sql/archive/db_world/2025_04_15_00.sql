-- DB update 2025_04_14_00 -> 2025_04_15_00
-- Set Mission: Gateways Murketh and Shaadraz as prerequisted to Return to Thrallmar
UPDATE `quest_template_addon` SET `PrevQuestID` = 10129 WHERE (`ID` = 10388);
