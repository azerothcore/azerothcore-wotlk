-- DB update 2026_09_03_05 -> 2026_09_03_06
--
-- Gluttonous Lurkers (12527) was offered to anyone at level 74+, but it should only open up
-- once Precious Elemental Fluids (12510) is completed and turned in.
UPDATE `quest_template_addon` SET `PrevQuestID` = 12510 WHERE `ID` = 12527;
