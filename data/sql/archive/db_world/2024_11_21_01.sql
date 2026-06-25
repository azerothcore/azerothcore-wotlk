-- DB update 2024_11_21_00 -> 2024_11_21_01
--
-- James Hyal (1/2) requirement removed from James Hyal (2/2)
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 1302);

-- Little Pamela requirement removed from Pamela's Doll
UPDATE `quest_template_addon` SET `NextQuestID` = 0 WHERE (`ID` = 5142);

-- Sister Pamela requirement removed from Pamela's Doll
UPDATE `quest_template_addon` SET `NextQuestID` = 0 WHERE (`ID` = 5601);

-- Uncle Carlin requirement removed from Defenders of Darrowshire
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 5211);

-- A Troubled Spirit requirement removed from Warrior Kinship
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 8423);

-- A Call to Arms: The Plaguelands! requirement removed from Clear the Way
-- Stormwind
UPDATE `quest_template_addon` SET `NextQuestID` = 0 WHERE (`ID` = 5066);
-- Ironforge
UPDATE `quest_template_addon` SET `NextQuestID` = 0 WHERE (`ID` = 5090);
-- Darnassus
UPDATE `quest_template_addon` SET `NextQuestID` = 0 WHERE (`ID` = 5091);
-- Exodar
UPDATE `quest_template_addon` SET `NextQuestID` = 0 WHERE (`ID` = 10373);

-- Malin's Request (1/2) requirement removed from Worth Its Weight in Gold
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 691);

-- Tran'rek requirement removed from Scarab Shells
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 2865);

-- Stoley's Debt requirement removed from Stoley's Shipment
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 2873);

