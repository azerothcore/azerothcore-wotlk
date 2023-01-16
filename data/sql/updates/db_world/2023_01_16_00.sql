-- DB update 2023_01_15_00 -> 2023_01_16_00
DELETE FROM `quest_request_items_locale` WHERE `ID` IN (6387, 6391) AND `locale` = 'deDE';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(6387, 'deDE', 'Habt Ihr schon so bald die Nase voll von Thelsamar? Seid Ihr bereit, in eine andere Stadt abzureisen?', 0),
(6391, 'deDE', 'Womit kann ich Euch dienen, $Gwerter Herr:werte Dame;?', 0);
