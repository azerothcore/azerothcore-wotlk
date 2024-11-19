-- DB update 2023_10_12_02 -> 2023_10_12_03
-- Seeking the Kor Gem, Bailor's Ore Shipment
UPDATE `quest_template_addon` SET `PrevQuestID` = 1653 WHERE `ID` IN (1442,1655);
