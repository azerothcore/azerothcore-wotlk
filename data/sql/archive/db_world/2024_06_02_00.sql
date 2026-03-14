-- DB update 2024_06_01_00 -> 2024_06_02_00
--
DELETE FROM `achievement_reward` WHERE `ID` = 431;
INSERT INTO `achievement_reward` (`ID`, `TitleA`, `TitleH`, `ItemID`, `Sender`, `Subject`, `Body`, `MailTemplateID`) VALUES
(431, 64, 64, 0, 0, null, null, 0);
