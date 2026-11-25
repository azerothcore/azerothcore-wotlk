--
-- Poison Water chain from Mull Thunderhorn (2948) is Tauren-only
UPDATE `quest_template` SET `AllowableRaces` = 32 WHERE `ID` IN (748, 756, 759);
