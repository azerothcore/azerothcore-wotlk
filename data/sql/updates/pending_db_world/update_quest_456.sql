-- Correcting quest 456 (first night elves quest)
-- https://www.wowhead.com/quest=456/the-balance-of-nature
UPDATE `quest_template` SET `LogDescription`='Kill 3 Young Nightsabers and 3 Young Thistle Boars and return to Conservator Ilthalaine.' WHERE `ID`=456;
UPDATE `quest_template` SET `RequiredNpcOrGoCount1`=3 WHERE `ID`=456;
UPDATE `quest_template` SET `RequiredNpcOrGoCount2`=3 WHERE `ID`=456;
