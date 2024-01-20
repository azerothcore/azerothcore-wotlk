-- DB update 2023_06_17_05 -> 2023_06_17_06
--
UPDATE `quest_template` SET `AllowableRaces` = 1101 WHERE `ID` IN (9494, 9492);
UPDATE `quest_template` SET `AllowableRaces` = 690 WHERE `ID` = 9495;
