-- DB update 2025_09_11_03 -> 2025_09_12_00
--
-- The Aberrations Must Die.
UPDATE `quest_template_addon` SET `PrevQuestID` = 12925 WHERE (`ID` = 13425);
-- The Aberrations Must Die. is always available
DELETE FROM `pool_quest` WHERE `entry`=13425 and `pool_entry` = 354;
