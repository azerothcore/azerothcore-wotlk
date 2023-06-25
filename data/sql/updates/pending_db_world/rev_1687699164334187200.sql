-- Fix Quest Replacement Phial Only available to Alliance --
UPDATE `quest_template` SET `AllowableRaces` = 1101 WHERE (`ID` = 3375);
