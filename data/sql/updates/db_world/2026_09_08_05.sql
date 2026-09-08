-- DB update 2026_09_08_04 -> 2026_09_08_05
--
-- The Drakkari Do Not Need Water Elementals! (12562) was offered to anyone at level 74+, but it should
-- only open up once Strange Mojo (12507) is completed and turned in.
UPDATE `quest_template_addon` SET `PrevQuestID` = 12507 WHERE `ID` = 12562;
