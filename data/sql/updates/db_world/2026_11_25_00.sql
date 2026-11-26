-- DB update 2026_11_24_02 -> 2026_11_25_00
--
-- Poison Water chain from Mull Thunderhorn (2948) is Tauren-only
UPDATE `quest_template` SET `AllowableRaces` = 32 WHERE `ID` IN (748, 756, 759);
