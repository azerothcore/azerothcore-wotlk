--
DELETE FROM `creature_text` WHERE `CreatureID` = 31028;
DELETE FROM `creature_text` WHERE `CreatureID` = 31126 AND `GroupID` = 2;
DELETE FROM `creature_text` WHERE `CreatureID` = 31127 AND `GroupID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
-- Patricia O'Reilly (31028) - Ambient lines (GroupID 0)
(31028, 0, 0, 'The magistrate is very busy.', 12, 0, 100, 1, 0, 0, 32068, 0, 'Patricia O\'Reilly - Ambient'),
(31028, 0, 1, 'Please, return to your homes.', 12, 0, 100, 1, 0, 0, 32069, 0, 'Patricia O\'Reilly - Ambient'),
(31028, 0, 2, 'Everyone, please remain calm...', 12, 0, 100, 1, 0, 0, 32070, 0, 'Patricia O\'Reilly - Ambient'),
(31028, 0, 3, 'Magistrate Barthilas is unavailable at the moment...', 12, 0, 100, 1, 0, 0, 32071, 0, 'Patricia O\'Reilly - Ambient'),
-- Patricia O'Reilly (31028) - Player enters building (GroupID 1)
(31028, 1, 0, 'Please don\'t go back there!', 12, 0, 100, 274, 0, 0, 32073, 0, 'Patricia O\'Reilly - Player Enters'),
(31028, 1, 1, 'Don\'t disturb the magistrate, please!', 12, 0, 100, 274, 0, 0, 32074, 0, 'Patricia O\'Reilly - Player Enters'),
-- Agitated Stratholme Citizen (31126) - Ambient crowd (GroupID 2)
(31126, 2, 0, 'Where\'s Barthilas?!', 12, 0, 100, 6, 0, 0, 32057, 0, 'Agitated Stratholme Citizen - Ambient'),
(31126, 2, 1, 'What are we supposed to do?!', 12, 0, 100, 6, 0, 0, 32059, 0, 'Agitated Stratholme Citizen - Ambient'),
(31126, 2, 2, 'We need leadership!', 12, 0, 100, 5, 0, 0, 32060, 0, 'Agitated Stratholme Citizen - Ambient'),
(31126, 2, 3, 'Stop hiding, Barthilas!', 12, 0, 100, 5, 0, 0, 32061, 0, 'Agitated Stratholme Citizen - Ambient'),
(31126, 2, 4, 'Let us through!', 12, 0, 100, 25, 0, 0, 32062, 0, 'Agitated Stratholme Citizen - Ambient'),
(31126, 2, 5, 'We\'ll drag you out here if we have to!', 12, 0, 100, 5, 0, 0, 32063, 0, 'Agitated Stratholme Citizen - Ambient'),
-- Agitated Stratholme Resident (31127) - Ambient crowd (GroupID 0)
(31127, 0, 0, 'Where\'s Barthilas?!', 12, 0, 100, 6, 0, 0, 32057, 0, 'Agitated Stratholme Resident - Ambient'),
(31127, 0, 1, 'We want to speak to the magistrate!', 12, 0, 100, 5, 0, 0, 32058, 0, 'Agitated Stratholme Resident - Ambient'),
(31127, 0, 2, 'What are we supposed to do?!', 12, 0, 100, 6, 0, 0, 32059, 0, 'Agitated Stratholme Resident - Ambient'),
(31127, 0, 3, 'We need leadership!', 12, 0, 100, 5, 0, 0, 32060, 0, 'Agitated Stratholme Resident - Ambient'),
(31127, 0, 4, 'Let us through!', 12, 0, 100, 25, 0, 0, 32062, 0, 'Agitated Stratholme Resident - Ambient');
